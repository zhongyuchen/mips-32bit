`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 01:03:17
// Design Name: 
// Module Name: main_decoder
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


module main_decoder(
    input [5:0] op,
    output mem2reg, memwrite,
    output branch, alusrc,
    output regdst, regwrite,
    output jump,
    output [1:0] aluop
    );
    
    reg [8:0] controls;
    
    assign {regwrite, regdst, alusrc, branch, memwrite, mem2reg,jump, aluop}=controls;
    
    always@(*)
    case(op)
    6'b000000:controls<=9'b110000010;//Rtype
    6'b100011:controls<=9'b101001000;//LW
    6'b101011:controls<=9'b001010000;//SW
    6'b000100:controls<=9'b000100001;//BEQ
    6'b001000:controls<=9'b101000000;//ADDI
    6'b000010:controls<=9'b000000100;//J
    default:controls<=9'bxxxxxxxxx;//???
    endcase
    
endmodule
