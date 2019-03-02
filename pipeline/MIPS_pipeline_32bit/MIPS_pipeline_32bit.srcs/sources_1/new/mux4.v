`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 12:33:47
// Design Name: 
// Module Name: mux4
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


module mux4 #(parameter WIDTH=8)
    (
    input [WIDTH-1:0] d00,d01,d10,d11,
    input [1:0] s,
    output reg [WIDTH-1:0] y
    );

    always@(*)
    case(s)
    2'b00:y<= #1 d00;
    2'b01:y<= #1 d01;
    2'b10:y<= #1 d10;
    2'b11:y<= #1 d11;
    endcase
    
endmodule
