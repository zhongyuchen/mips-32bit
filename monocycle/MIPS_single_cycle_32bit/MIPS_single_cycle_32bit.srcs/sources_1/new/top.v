`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 09:59:25
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
    input next,
    input clk,reset,cloak,
    output [15:0] discu,
    input [9:0] SW,
    output reg [6:0] C,
    output reg [7:0] AN
    );
    
    //MIPS processor
    wire [31:0] pc, instr, readdata;
    wire myclk,disclk;
    wire memwrite;
    wire [31:0] writedata, dataadr;
    
    //variables
    reg [7:0] disop;//display option
    wire [7:0] disop0,disop1,disop2;//extracted data display option
    
    wire [6:0] C0,C1,C2,C3,C4,C5,C6,C7;
    wire [31:0] t0,t1,t2;//extract data
    reg [31:0] T;
    
    clkdiv c1(clk, myclk);
    disdiv c2(clk, disclk);

    MIPS mips0(next|(myclk&cloak), reset, pc, instr, memwrite, dataadr, writedata, readdata,discu,SW,t0,disop0);
    imem instrmem(pc[7:2], instr,SW,t1,disop1);
    dmem datamem(next|(myclk&cloak), memwrite, dataadr, writedata, readdata,SW,t2,disop2);
    
    //use SW[9:6] to choose tx -> T, disopx -> disop ???
    always@(*)
    begin
        case(SW[9:6])
        //0
        4'b0000:begin T<=t0;disop<=disop0; end
        4'b0001:begin T<=t0;disop<=disop0; end
        4'b0010:begin T<=t0;disop<=disop0; end
        4'b0011:begin T<=t0;disop<=disop0; end
        //1
        4'b0100:begin T<=t1;disop<=disop1; end
        4'b0101:begin T<=t1;disop<=disop1; end
        //2
        4'b1000:begin T<=t2;disop<=disop2; end
        4'b1001:begin T<=t2;disop<=disop2; end
        default:begin T<=0;disop<=0; end
        endcase
    end
    
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
