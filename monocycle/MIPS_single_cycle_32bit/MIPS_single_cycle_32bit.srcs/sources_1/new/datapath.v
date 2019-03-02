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
    input clk,reset,
    input mem2reg,pcsrc,
    input [1:0] alusrca,
    input [1:0] alusrcb,
    input [1:0] regdst,
    input regwrite, jump,
    input [3:0] alucontrol,
    output zero,
    output [31:0] pc,
    input [31:0] instr,
    output [31:0] aluout,writedata,
    input [31:0] readdata,
    input extend,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    wire [4:0] writereg;
    wire [31:0] pcnext,pcnextbr,pcplus4,pcbranch;
    wire [31:0] signimm,signimmsh;
    wire [31:0] srca,srcb;
    wire [31:0] result;
    
    //extract reg values
    wire [31:0] tx;
    wire [7:0] disopx;
    
    //next PC logic
    //module 0000:pc, pcnext, pcplus4,signimm, signimmsh, 
    //  pcbranch, pcnextbr
    PC #(32) pcreg(clk, reset, pcnext, pc);
    adder pcadd1(pc, 32'b100, pcplus4);
    sl2 immsh(signimm,signimmsh);
    adder pcadd2(pcplus4,signimmsh,pcbranch);
    MUX2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    MUX2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
    
    //register file logic
    //module 0001: writereg, result, srca, writedata
    //module 0010: regs
    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg,instr[10:6], result, srca, writedata,alusrca,pc,swt,tx,disopx);
    MUX4 #(5) wrmux(instr[20:16], instr[15:11],5'b11111,5'b00000, regdst, writereg);
    MUX2 #(32) resmux(aluout, readdata, mem2reg, result);
    sign_extend se(instr[15:0], extend, signimm);
    
    //ALU logic
    //module 0011: srca, srcb, aluout, zero
    MUX4 #(32) srcbmux(writedata, signimm, 32'b100,32'b1000,alusrcb, srcb);
    ALU alu0(srca, srcb, alucontrol, aluout, zero);
    
    //extract data and display option
    parameter EIGHT=8'b11111111;
    parameter ZERO=8'b00000000;
    parameter TWO=8'b00000011;
    parameter ONE=8'b1;
    always@(*)
    begin
        case(swt[9:6])
        //pc, pcnext, pcplus4,signimm, signimmsh, pcbranch, pcnextbr
        4'b0000:
            case(swt[5:0])
            6'b000000:begin t<=pc;disop<=EIGHT; end
            6'b000001:begin t<=pcnext;disop<=EIGHT; end
            6'b000010:begin t<=pcplus4;disop<=EIGHT; end
            6'b000011:begin t<=signimm;disop<=EIGHT; end
            6'b000100:begin t<=signimmsh;disop<=EIGHT; end
            6'b000101:begin t<=pcbranch;disop<=EIGHT; end
            6'b000110:begin t<=pcnextbr;disop<=EIGHT; end
            6'b000111:begin t<=pcsrc;disop<=ONE; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        //writereg, result, srca, writedata
        4'b0001:
            case(swt[5:0])
            6'b000000:begin t<={{27{0}},writereg};disop<=TWO; end
            6'b000001:begin t<=result;disop<=EIGHT; end
            6'b000010:begin t<=srca;disop<=EIGHT; end
            6'b000011:begin t<=writedata;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        //regs
        4'b0010:
            begin t<=tx;disop<=disopx; end
        //srca, srcb, aluout, zero
        4'b0011:
            case(swt[5:0])
            6'b000000:begin t<=srca;disop<=EIGHT; end
            6'b000001:begin t<=srcb;disop<=EIGHT; end
            6'b000010:begin t<=aluout;disop<=EIGHT; end
            6'b000011:begin t<={{31{0}},zero};disop<=ONE; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        default:
            begin t<=0;disop<=ZERO; end
        endcase
    end
    
endmodule
