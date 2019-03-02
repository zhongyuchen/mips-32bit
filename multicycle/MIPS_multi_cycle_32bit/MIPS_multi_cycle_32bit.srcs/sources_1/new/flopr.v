`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/08 00:31:29
// Design Name: 
// Module Name: flopr
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


module flopr #(parameter WIDTH=8)
    (
    input clk,reset,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
    );
    
    //none-enabled & resettable flip-flop
    always@(posedge clk)
    if(reset)
        q<=0;//reset
    else
        q<=d;//load
    
endmodule
