`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/09 14:32:19
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a,b,
    input [2:0] alucont,
    output reg [31:0] result,
    output reg zero
    );
    
    always@(*)
    begin
        case(alucont)
        3'b000:result=a&b;
        3'b001:result=a|b;
        3'b010:result=a+b;
        3'b011:result=result;
        3'b100:result=a&~b;
        3'b101:result=a|~b;
        3'b110:result=a-b;
        3'b111:result=a[31]==b[31]?a<b:a>b;
        endcase
        zero=!result;
    end
    
endmodule
