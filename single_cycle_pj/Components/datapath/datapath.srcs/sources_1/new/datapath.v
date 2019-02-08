`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 09:21:36
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk,
    input reset,
    input alusrc,
    input regdst,
    inut regwrite, jump,
    input [2:0] alucontrol,
    output zero,
    output [31:0] pc,
    input [31:0] instr,
    output [31:0] aluout,
    output [31:0] writedata,
    input [31:0] readdata
    );
    
    wire [4:0] writereg;
    wire [31:0] pcnext, pcnext,pcplus4,pcbranch;
    wire [31:0] signimm,signimmsh;
    wire [31:0] srca,srcb;
    wire [31:0] result;
    
    //next PC logic
    PC #(32) pcreg(clk, reset, pcnext, pc);
    adder pcadd1(pc, 32'b100, pcplus4);
    sl2 immsh(signimm,signimmsh);
    adder pcadd2(pcplus4,pcbranch,pcsrc,pcnextbr);
    MUX2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    MUX2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
    
    //register file logic
    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);
    MUX2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
    MUX2 #(32) resmux(aluout, readdata, mem2reg, result);
    sign_extend se(instr[15:0], signimm);
    
    //ALU logic
    MUX2 #(32) srcbmux(writedata, signimm, alusrc, stcb);
    ALU alu(srca, srcb, alucontrol, aluout, zero);
    
endmodule
