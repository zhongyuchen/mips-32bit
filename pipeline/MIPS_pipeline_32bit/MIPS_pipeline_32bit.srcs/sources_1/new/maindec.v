`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/26 21:48:42
// Design Name: 
// Module Name: maindec
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


module maindec(
    input [5:0] op,
    output memtoreg,memwrite,
    output branch,
    output [1:0] alusrca,alusrcb,
    output [1:0] regdst,
    output regwrite,
    output [1:0] jump,
    output [2:0] aluop,
    output extend,
    input [5:0] funct,
    output [2:0] cmpcontrol
    );
    
    reg [18:0] controls;
    
    assign {regwrite,regdst,alusrca,alusrcb,
            branch,memwrite,memtoreg,
            jump,aluop,extend,cmpcontrol}=controls;
            
    always@(*)
    case(op)
    6'b000000://Rtype:
        case(funct)
        //sll,srl,sra
        6'b000000:controls<=19'b1010100000001111000;
        6'b000011:controls<=19'b1010100000001111000;
        6'b000010:controls<=19'b1010100000001111000;
        //jalr
        6'b001001:controls<=19'b1011010000100001000;
        //jr
        6'b001000:controls<=19'b0000000000100001000;
        //and,or,add,sub,slt,xor,nor
        default:  controls<=19'b1010000000001111000;
        endcase
    6'b100011:    controls<=19'b1000001001000001000;//LW
    6'b101011:    controls<=19'b0000001010000001000;//SW
    
    6'b000100:    controls<=19'b0000000100000011000;//BEQ
    6'b000101:    controls<=19'b0000000100000011001;//BNE
    6'b000110:    controls<=19'b0000000100000011010;//BLEZ
    6'b000111:    controls<=19'b0000000100000011011;//BGTZ
    6'b000001:    controls<=19'b0000000100000011100;//BGEZ,BLTZ
    
    6'b001000:    controls<=19'b1000001000000001000;//ADDI
    6'b000010:    controls<=19'b0000000000010001000;//J
    6'b000011:    controls<=19'b1101010000010001000;//JAL
    6'b001100:    controls<=19'b1000001000000100000;//ANDI
    6'b001101:    controls<=19'b1000001000000110000;//ORI
    6'b001010:    controls<=19'b1000001000001000000;//SLTI
    6'b001110:    controls<=19'b1000001000001010000;//XORI
    6'b001111:    controls<=19'b1001101000001100000;//LUI
    default:      controls<=19'bxxxxxxxxxxxxxxxxxxx;//???
    endcase
    
endmodule
