`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/27 00:18:01
// Design Name: 
// Module Name: imem
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


module imem(
    input [5:0] adr,
    output [31:0] instr,
    input [6:0] SW,
    output reg [31:0] t
    );
    
    reg [31:0] RAM[127:0];//32bit x 128
    
    initial
    $readmemh("C:/Users/ECHOES/Desktop/pipeline_pj/MIPS_pipeline_32bit/MIPS_pipeline_32bit.srcs/test_files/loop.dat",RAM);
    
    assign instr=RAM[adr];
    
    always@(*)
        t<=RAM[SW];
    
endmodule
