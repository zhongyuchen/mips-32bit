`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 16:29:47
// Design Name: 
// Module Name: equal
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


module hitcheck #(parameter WIDTH=3)(
    input [WIDTH-1:0] a,b,
    input valid,
    output reg hit
    );
    
    always@(*)
    if(valid&(a==b)) hit<=1'b1;
    else hit<=1'b0;
    
endmodule
