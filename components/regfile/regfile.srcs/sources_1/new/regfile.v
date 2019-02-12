`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/09 16:35:02
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
    input write,//write enable
    input [4:0] rw,//target reg
    input [31:0] data,//input data

    input [4:0] ra,rb,//2 regs
    output [31:0] vala,valb//2 vals
    );
    
    reg [31:0] rf[31:0];//32 32bit-registers
    
    always@(posedge clk)
    if(write)
        rf[rw]<=data;
    
    assign vala=ra?rf[ra]:0;
    assign valb=rb?rf[rb]:0;
    
endmodule
