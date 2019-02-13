`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
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
    output branch, 
    output [1:0] alusrca,
    output [1:0] alusrcb,
    output [1:0] regdst, 
    output regwrite,
    output jump,
    output [2:0] aluop,//[1:0] -> [2:0]
    output extend,
    input [5:0] funct
    );
    
    reg [14:0] controls;//[8:0] -> [9:0] -> [10:0] -> [11:0] -> [12:0] -> [13:0] -> [14:0]
    
    assign {regwrite, regdst, alusrca,alusrcb, branch, memwrite, mem2reg, jump,aluop,extend}=controls;
    
    always@(*)
    case(op)
    6'b000000://R-type, aluop: 10 -> 111(default in alu_decoder)
        case(funct)
        //sll, srl, sra
        6'b000000:controls<=15'b101100000001111;
        6'b000011:controls<=15'b101100000001111;
        6'b000010:controls<=15'b101100000001111;
        //add, sub, and, or, slt, nor, xor
        default:controls<=15'b101010000001111;  
        endcase
    6'b100011:controls<=15'b100010100100001;//LW
    6'b101011:controls<=15'b000010101000001;//SW
    6'b001000:controls<=15'b100010100000001;//ADDI
    //aluop: 00 -> 000
    
    //add op:
    6'b001100:controls<=15'b100010100000100;//ANDI
    //aluop: 010
    6'b001101:controls<=15'b100010100000110;//ORI
    //aluop: 011
    6'b001110:controls<=15'b100010100001010;//XORI
    //aluop: 101
    6'b001010:controls<=15'b100010100001001;//SLTI
    //aluop: 100
    
    6'b000100:controls<=15'b000010010000011;//BEQ
    //aluop: 01 -> 001
    //add op:
    6'b000101:controls<=15'b000010010000011;//BNE
    
    6'b000010:controls<=15'b000010000010001;//J
    //aluop: 00 -> 000
    6'b000011:controls<=15'b110001100010001;//JAL
    //alusrca == 0, alua <- pc
    
    6'b001111:controls<=15'b100010100001100;//LUI
    
    default:controls<=15'bxxxxxxxxxxxxxxx;//illegal operation
    endcase
    
endmodule
