`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 11:59:30
// Design Name: 
// Module Name: top
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


module top(
    input clk,reset,next,stop,
    input [9:0] SW,
    input [2:0] lsrc,
    output [15:0] LED,
    output reg [6:0] C,
    output reg [7:0] AN
    );
    
    wire [31:0] pc,instr,readdata;
    wire [31:0] writedata,dataadr;
    wire memwrite;
    
    reg [31:0] cycle;
    
    //clk
    wire realclk,myclk,beepclk,disclk;
    clkdiv c1(clk,myclk);
    beepdiv c2(clk,beepclk);
    disdiv c3(clk,disclk);
    assign realclk=next|((~stop)&myclk);
    
    //display variables
    reg [7:0] disop;//display option
    wire [7:0] disop0;//extracted data display option
    reg [31:0] T;
    wire [31:0] t0,t1,t2;//extract data
    
    wire [6:0] C0,C1,C2,C3,C4,C5,C6,C7;
    
    
    //cycle
    initial
        cycle<=32'b0;
    always@(posedge realclk)
        cycle<=cycle+1;
    
    //processor and memory
    mips mips(realclk,reset,pc,instr,memwrite,dataadr,writedata,readdata,
              lsrc,LED,beepclk,
              SW,t0,disop0);
    imem imem(pc[7:2],instr,
              SW[6:0],t1);
    dmem dmem(realclk,memwrite,dataadr,writedata,readdata,
              SW[6:0],t2);
    
    //get the final T & disop
    parameter EIGHT=8'b11111111;
    always@(*)
    case(SW[9:7])
    3'b000:
        case(SW[6:0])
        7'b0:begin T<=cycle;disop<=EIGHT;end
        default:begin T<=t0;disop<=disop0;end
        endcase
    3'b110:begin T<=t1;disop<=EIGHT;end
    3'b111:begin T<=t2;disop<=EIGHT;end
    default:begin T<=t0;disop<=disop0;end
    endcase
    
    //transfer into 7 segment display
    display dis0(T[3:0], C0,disop[0]);
    display dis1(T[7:4], C1,disop[1]);
    display dis2(T[11:8], C2,disop[2]);
    display dis3(T[15:12], C3,disop[3]);
    display dis4(T[19:16], C4,disop[4]);
    display dis5(T[23:20], C5,disop[5]);
    display dis6(T[27:24], C6,disop[6]);
    display dis7(T[31:28], C7,disop[7]);
    
    //scan display
    reg [3:0] cnt;//counter for display
    always@(posedge disclk)
    begin
        case(cnt)
        3'b000:
            begin
            AN<=8'b11111110;
            C<=C0;
            cnt<=cnt+1;
            end
        3'b001:
            begin
            AN<=8'b11111101;
            C<=C1;
            cnt<=cnt+1;
            end
        3'b010:
            begin
            AN<=8'b11111011;
            C<=C2;
            cnt<=cnt+1;
            end
        3'b011:
            begin
            AN<=8'b11110111;
            C<=C3;
            cnt<=cnt+1;
            end
        3'b100:
            begin
            AN<=8'b11101111;
            C<=C4;
            cnt<=cnt+1;
            end
        3'b101:
            begin
            AN<=8'b11011111;
            C<=C5;
            cnt<=cnt+1;
            end
        3'b110:
            begin
            AN<=8'b10111111;
            C<=C6;
            cnt<=cnt+1;
            end
        3'b111:
            begin
            AN<=8'b01111111;
            C<=C7;
            cnt<=3'b0;
            end
        endcase
    end        
    
endmodule
