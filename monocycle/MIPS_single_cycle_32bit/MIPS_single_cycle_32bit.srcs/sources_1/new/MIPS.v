`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/10 10:02:59
// Design Name: 
// Module Name: MIPS
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

module MIPS(
    input clk, reset,
    output [31:0] pc,
    input [31:0] instr,
    output memwrite,
    output [31:0] aluout, writedata,
    input [31:0] readdata,
    output [15:0] discu,
    input [9:0] swt,
    output [31:0] t,
    output [7:0] disop,
    input clear
    );
    
    wire mem2reg,regwrite,jump,pcsrc,zero;
    wire [1:0] regdst;
    
    //widen alusrc, and change into alusrcb
    wire [1:0] alusrca,alusrcb;
    
    wire [3:0] alucontrol;
    wire extend;
    
    control_unit cu(instr[31:26], instr[5:0], zero, mem2reg, memwrite, pcsrc, alusrca,alusrcb, regdst, regwrite, jump, alucontrol, extend, discu);
    datapath dp(clk,reset,mem2reg,pcsrc,alusrca,alusrcb,regdst,regwrite,jump,alucontrol,zero,pc,instr,aluout,writedata,readdata,extend,swt,t,disop,clear);

endmodule
