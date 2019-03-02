`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 17:12:46
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input reset,
    input [4:0] a1,a2,a3,
    input [31:0] wd3,
    input we3,
    output [31:0] rd1,
    output [31:0] rd2,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    reg [31:0] rf[31:0];//32 32bit regfile
    
    initial
    rf[0]=32'b0;
    
    always@(posedge clk)
    if(reset)
        $readmemh("C:/Users/ECHOES/Desktop/multi_cycle_pj/MIPS_multi_cycle_32bit/MIPS_multi_cycle_32bit.srcs/test_files/emptyreg.dat", rf);
    
    //write in data
    always@(posedge clk)
    if(we3)
        rf[a3]<=wd3;
        
    assign rd1=(a1!=0)?rf[a1]:0;
    assign rd2=(a2!=0)?rf[a2]:0;
    
    parameter ZERO=8'b0;
    parameter EIGHT=8'b11111111;
    always@(*)
    begin 
        case(swt[9:6])
        4'b1000:
            if(swt[5])
                begin t<=0;disop<=ZERO; end
            else
                begin t<=rf[swt[4:0]];disop<=EIGHT; end
        default:begin t<=0;disop<=ZERO; end
        endcase
    end
    
endmodule
