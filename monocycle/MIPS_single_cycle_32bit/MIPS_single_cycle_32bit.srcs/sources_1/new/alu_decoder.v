`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 01:03:38
// Design Name: 
// Module Name: alu_decoder
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


module alu_decoder(
    input [5:0] funct,
    input [2:0] aluop,
    output reg [3:0] alucontrol
    );
    //alucontrol: [2:0]->[3:0]
    
    always@(*)
    case(aluop)//aluop [1:0] -> [2:0]
    3'b000:alucontrol<=4'b0010;//add (for lw/sw/addi/j)
    3'b001:alucontrol<=4'b0110;//sub (for beq/bne)
    //add aluop
    3'b010:alucontrol<=4'b0000;//and (for andi)
    3'b011:alucontrol<=4'b0001;//or (for ori)
    3'b100:alucontrol<=4'b0111;//slt (for slti)
    3'b101:alucontrol<=4'b0101;//xor (for xori)
    3'b110:alucontrol<=4'b1010;//lui
    default://R-type
        case(funct)
        6'b100000:alucontrol<=4'b0010;//ADD
        6'b100010:alucontrol<=4'b0110;//SUB
        6'b100100:alucontrol<=4'b0000;//AND
        6'b100101:alucontrol<=4'b0001;//OR
        6'b101010:alucontrol<=4'b0111;//SLT
        6'b100111:alucontrol<=4'b0100;//NOR
        6'b100110:alucontrol<=4'b0101;//XOR
        6'b000000:alucontrol<=4'b0011;//SLL
        6'b000010:alucontrol<=4'b1000;//SRL
        6'b000011:alucontrol<=4'b1001;//SRA
        default:alucontrol<=4'bxxxx;//???
        endcase
    endcase
            
endmodule
