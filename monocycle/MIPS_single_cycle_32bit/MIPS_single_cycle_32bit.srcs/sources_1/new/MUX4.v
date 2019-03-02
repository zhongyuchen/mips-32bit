`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/21 19:12:56
// Design Name: 
// Module Name: MUX4
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


module MUX4 #(parameter WIDTH=8)
    (
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input [WIDTH-1:0] in2,
    input [WIDTH-1:0] in3,
    input [1:0] s,
    output reg [WIDTH-1:0] out
    );
    
    always@(*)
    begin
        case(s)
        2'b00:out<=in0;
        2'b01:out<=in1;
        2'b10:out<=in2;
        2'b11:out<=in3;
        endcase
    end
    
endmodule