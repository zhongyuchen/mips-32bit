`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 16:57:52
// Design Name: 
// Module Name: MUX2
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


module MUX2 #(parameter WIDTH=8)
    (
    input [WIDTH-1:0] d0,d1,
    input s,
    output [WIDTH-1:0] y
    );
    
    assign y=s?d1:d0;
    
endmodule
