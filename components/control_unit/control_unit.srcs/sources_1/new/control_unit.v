`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/10 00:50:07
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [5:0] op, funct,
    input zero,
    output mem2reg,memwrite,
    output pcsrc,alusrc,
    output regdst,regwrite,
    output jump,
    output [2:0] alucont
    );
    
    wire [1:0] aluop;
    wire branch;
    
    main_decoder md(op, mem2reg, memwrite, branch, alusrc,regdst, regwrite,jump, aluop);
    alu_decoder ad(funct, aluop, alucont);
    
    assign pcsrc=branch&zero;
    
endmodule
