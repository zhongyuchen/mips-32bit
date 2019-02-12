`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/09 14:56:10
// Design Name: 
// Module Name: PC
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


module PC #(parameter WIDTH=8)
    (
    input clk,
    input reset,
    input [WIDTH-1:0] newpc,
    output reg [WIDTH-1:0] pc
    );
    
    always@(posedge clk, posedge reset)
    if(reset) 
        pc<=0;
    else 
        pc<=newpc;
    
endmodule
