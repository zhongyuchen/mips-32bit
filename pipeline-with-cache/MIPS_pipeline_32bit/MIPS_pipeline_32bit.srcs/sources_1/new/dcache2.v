`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 11:02:43
// Design Name: 
// Module Name: dcache1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dcache2(
    input clk,reset,writeen,readen,
    input [31:0] addr,writedata,
    output reg [31:0] readdata,
    output ready,
    input [9:0] SW,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    //L2 data memory cache: 2^6=64=4x4x4
    //memory: 2^9=512=8x8x8
    
    reg [132:0] cache2[3:0][3:0];
    //[132:0] -> 1 block
    //132   131   130   129   128   127 ... 0
    //D     V     tag               32x4 data
    //---cache2[set][way][data bit]
    reg [5:0] U[3:0];
    initial
    begin 
    U[0]<=6'b0;U[1]<=6'b0;
    U[2]<=6'b0;U[3]<=6'b0; 
    end
    wire [5:0] tU;
    //LRU age sign
    
    //read or write data in dmem
    wire [127:0] rd,wd;
    wire dready;
    wire [31:0] loadadr;
        
    //find the data from cache2
    wire hit0,hit1,hit2,hit3,hit;
    wire [31:0] trd;

    //states
    parameter READY=3'b000;
    parameter LOAD1=3'b001;
    parameter SAVE=3'b010;
    parameter LOAD2=3'b011;
    parameter REPLACE=3'b100;
    reg [2:0] state,nextstate;

    //addr:
    //876   54    32      10
    //sign  set   boffset offset 
    wire [1:0] hway,rway,way;//hit way, replace way
    wire [2:0] tag;
    wire [1:0] set,blockoffset;
    
    wire [31:0] memt;
    
    reg [31:0] total,hitcount,replacecount,savecount;
    initial begin total=0;hitcount=0;replacecount=0;savecount=0; end
    
    wire read,load,we,clean,replace,write;
    reg [6:0] controls;
    assign {read,load,we,clean,replace,write,ready}=controls;
    
    assign {tag,set,blockoffset}=addr[8:2];
    
    //count
    always@(posedge readen|writeen) total<=total+1;
    always@(*) hitcount<=total-replacecount;
    always@(posedge clean) savecount<=savecount+1;
    always@(posedge replace) replacecount<=replacecount+1;
    
    //state logic
    always@(posedge clk)
    if(reset)
        state<=READY;
    else
        state<=nextstate;
        
    //nextstate logic
    always@(*)
    case(state)
    READY:
        if(~(writeen|readen)|hit) nextstate<=READY; else 
        if(cache2[set][rway][132]&cache2[set][rway][131]) nextstate<=LOAD1; else
        nextstate<=LOAD2;
    LOAD1:
        if(dready) nextstate<=SAVE;
        else nextstate<=LOAD1;
    SAVE:
        nextstate<=LOAD2;
    LOAD2:
        if(dready) nextstate<=REPLACE;
        else nextstate<=LOAD2;
    REPLACE:
        nextstate<=READY;
    default:
        nextstate<=3'bxxx;
    endcase
       
    //control signals in this state
    always@(*)
    case(state)
    READY:
        if(~(writeen|readen)|hit) controls<={readen,4'b0000,writeen,1'b1}; 
        else controls<=7'b0000000;        
    LOAD1:      controls<=7'b0010000;
    SAVE:       controls<=7'b0011000;
    LOAD2:      controls<=7'b0100000;
    REPLACE:    controls<=7'b0100100;
    default:    controls<=7'bxxxxxxx;
    endcase
    
    //find the data(addr) in cache
    hitcheck #(3) h0(tag,cache2[set][0][130:128],//tag
                     cache2[set][0][131],//V
                     hit0);
    hitcheck #(3) h1(tag,cache2[set][1][130:128],
                     cache2[set][1][131],
                     hit1);
    hitcheck #(3) h2(tag,cache2[set][2][130:128],
                     cache2[set][2][131],
                     hit2);
    hitcheck #(3) h3(tag,cache2[set][3][130:128],
                     cache2[set][3][131],
                     hit3);
    assign hit=hit0|hit1|hit2|hit3;
    //one hot -> normal encoding
    assign hway={hit3|hit2,hit3|hit1};
    mux4 #(32) trdmux4(cache2[set][hway][31:0],
                       cache2[set][hway][63:32],
                       cache2[set][hway][95:64],
                       cache2[set][hway][127:96],
                       blockoffset,trd);
    
    //find the way to be replaced
    assign rway=(U[set][5:3]==3'b000)?2'b00:(
                ({U[set][5],U[set][2:1]}==3'b100)?2'b01:(
                ({U[set][4],U[set][2],U[set][0]}==3'b110)?2'b10:(
                ({U[set][3],U[set][1:0]}==3'b111)?2'b11:
                2'bxx)));
    
    //next U
    nextU nextu(U[set],hway,tU);
    //flopenr #(6) Ureg(clk,reset,read,tU,U[set]);
   
    //read data
    //flopenr #(32) readdatamux2(clk,reset,read,trd,readdata);
    always@(*)
    if(read) readdata<=trd;

    always@(posedge clk)
    if(reset) U[set]<=6'b0; else
    if(read) U[set]<=tU;
    
    //write data
    mux2 #(2) waymux2(hway,rway,(replace|clean)&~write,way);
    mux4 #(128) wdmux4({cache2[set][way][127:32],writedata},
                       {cache2[set][way][127:64],writedata,cache2[set][way][31:0]},
                       {cache2[set][way][127:96],writedata,cache2[set][way][63:0]},
                       {writedata,cache2[set][way][95:0]},
                       blockoffset,
                       wd);    
    always@(posedge clk)
    case({clean,replace,write})
    3'b100:cache2[set][way][132:0]<={2'b01,cache2[set][way][130:0]};
    3'b010:cache2[set][way][132:0]<={2'b01,tag,rd};
    3'b001:cache2[set][way][132:0]<={2'b11,cache2[set][way][130:128],wd};
    default:cache2[set][way][132:0]<=cache2[set][way][132:0];
    endcase
    
    //interact with dmem
    mux2 #(32) loadadrmux2({23'b0,cache2[set][rway][130:128],set,4'b0},
                           {23'b0,tag,set,4'b0},
                           load,loadadr);
    dmem dmem(clk,we,reset,
              loadadr,
              cache2[set][rway][127:0],
              rd,dready,
              SW[6:0],memt);
    
    //display
    parameter ZERO=8'b0;
    parameter ONE=8'b1;
    parameter TWO=8'b11;
    parameter THREE=8'b111;
    parameter EIGHT=8'b11111111;
    always@(*)
    case(SW[9:7])
    3'b011:begin t<=memt;disop<=EIGHT; end//dmem
    3'b100://cache2
        if(SW[2])
        begin 
        t<={3'b0,cache2[SW[6:5]][SW[4:3]][132],
            3'b0,cache2[SW[6:5]][SW[4:3]][131],
            1'b0,cache2[SW[6:5]][SW[4:3]][130:128]};
        disop<=THREE;
        end
        else
        case(SW[1:0])
        2'b00:begin t<=cache2[SW[6:5]][SW[4:3]][31:0];disop<=EIGHT;end
        2'b01:begin t<=cache2[SW[6:5]][SW[4:3]][63:32];disop<=EIGHT;end
        2'b10:begin t<=cache2[SW[6:5]][SW[4:3]][95:64];disop<=EIGHT;end
        2'b11:begin t<=cache2[SW[6:5]][SW[4:3]][127:96];disop<=EIGHT;end
        endcase
    3'b101://other
        case(SW[6:0])
        7'b0:begin t<=total;disop<=EIGHT; end
        7'b1:begin t<=hitcount;disop<=EIGHT; end
        7'b10:begin t<=replacecount;disop<=EIGHT; end
        7'b11:begin t<=savecount;disop<=EIGHT; end
        7'b100:begin t<=state;disop<=ONE; end
        7'b101:begin t<=nextstate;disop<=ONE; end
        7'b110:begin t<=readdata;disop<=EIGHT; end
        7'b111:begin t<=controls;disop<=TWO; end
        7'b1000:begin t<=ready;disop<=ONE; end
        7'b1001:begin t<=hit;disop<=ONE; end
        7'b1010:begin t<=dready;disop<=ONE; end
        default:begin t<=32'b0;disop<=ZERO;end
        endcase
    default:begin t<=32'b0;disop<=ZERO;end
    endcase
    
endmodule
