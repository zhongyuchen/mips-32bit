`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 16:21:51
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
    input pcen,iord,irwrite,
    input [1:0] regdst,
    input memtoreg,regwrite,
    input [1:0] alusrca,
    input [1:0] alusrcb,
    input [3:0] alucontrol,
    input [1:0] pcsrc,
    input [31:0] readdata,
    output [5:0] op,funct,
    output zero,
    output [31:0] adr,
    output [31:0] writedata,
    input extend,
    input extsrc,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    wire [31:0] instr,data;
    
    wire [4:0] writereg;//reg addr to write into
    wire [31:0] writedata3;//reg data for writing into
    wire [31:0] regout1,regout2,regouta,regoutb;//readdata from regfile
    
    wire [31:0] signimm,signimmsh,addrsl,pcjump;
    
    wire [31:0] pc,pcnext;
    
    wire [31:0] srca,srcb,aluresult,aluout;
    
    wire [15:0] signsrc;
    
    wire [31:0] treg;
    wire [7:0] disopreg;
    
    flopenr #(32) pc_reg(clk, reset, pcen, pcnext, pc);
    adr_MUX2 adr_mux2(pc[7:2], aluout, iord, adr);
    
    flopenr #(32) instr_reg(clk, reset, irwrite, readdata, instr);
    flopr #(32) data_reg(clk, reset, readdata, data);
    
    //signals for controller
    assign op=instr[31:26];
    assign funct=instr[5:0];
    
    MUX4 #(5) writereg_mux3(instr[20:16], instr[15:11], 5'b11111, 5'bxxxxx, regdst, writereg);
    MUX2 #(32) writedata3_mux2(aluout, data, memtoreg, writedata3);
    regfile rf(clk, reset, instr[25:21], instr[20:16], writereg, writedata3, regwrite, regout1, regout2,
               swt, treg, disopreg);
    flopr #(32) rd1_reg(clk, reset, regout1, regouta);
    flopr #(32) rd2_reg(clk, reset, regout2, regoutb);    
    
    assign writedata=regoutb;
    
    MUX2 #(16) signsrc_mux2(instr[15:0],{11'b0,instr[10:6]},extsrc,signsrc);
    signext se(signsrc, extend, signimm);
    sl2 signimm_sl(signimm[29:0], signimmsh);
    
    MUX4 #(32) srca_mux4(pc, regouta, 32'b10000, signimm, alusrca, srca);
    MUX4 #(32) srcb_mux4(regoutb, 32'b100, signimm, signimmsh, alusrcb, srcb);
    alu ALU(srca, srcb, alucontrol, aluresult, zero);
    flopr #(32) aluout_reg(clk, reset, aluresult, aluout);
    
    sl2 addr_sl({4'b0,instr[25:0]}, addrsl);
    assign pcjump={pc[31:28], addrsl[27:0]};
    
    MUX4 #(32) pcnext_mux3(aluresult, aluout, pcjump,32'hxxxxxxxx, pcsrc, pcnext);
    

    parameter ZERO=8'b0;
    parameter ONE=8'b1;
    parameter TWO=8'b11;
    parameter FOUR=8'b1111;
    parameter EIGHT=8'b11111111;
    always@(*)
    begin
        case(swt[9:6])
        4'b0001://pc_reg: pcen, pcnext, pc
                //pcnext_mux3(aluresult, aluout, pcjump,32'hxxxxxxxx, pcsrc, pcnext);
            case(swt[5:0])
            6'b0:begin t<=pc;disop<=EIGHT; end
            6'b1:begin t<=pcnext;disop<=EIGHT; end
            6'b10:begin t<=pcen;disop<=ONE; end
            6'b11:begin t<=aluresult;disop<=EIGHT; end
            6'b100:begin t<=aluout;disop<=EIGHT; end
            6'b101:begin t<=pcjump;disop<=EIGHT; end
            6'b110:begin t<=pcsrc;disop<=ONE; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b0010://adr_mux2: pc[7:2], aluout, iord, adr
            case(swt[5:0])
            6'b0:begin t<=pc[7:2];disop<=TWO; end
            6'b1:begin t<=aluout;disop<=EIGHT; end
            6'b10:begin t<=iord;disop<=ONE; end
            6'b11:begin t<=adr;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b0011://instr_reg: irwrite, readdata, instr
            case(swt[5:0])
            6'b0:begin t<=irwrite;disop<=ONE; end
            6'b1:begin t<=readdata;disop<=EIGHT; end
            6'b10:begin t<=instr;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b0100://data_reg: readdata, data
                //op: instr[31:26]
                //funct: instr[5:0];
            case(swt[5:0])
            6'b0:begin t<=readdata;disop<=EIGHT; end
            6'b1:begin t<=data;disop<=EIGHT; end
            6'b10:begin t<=op;disop<=TWO; end
            6'b11:begin t<=funct;disop<=TWO; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b0101://writereg_mux3: instr[20:16], instr[15:11], 5'b11111, 5'bxxxxx, regdst, writereg
            case(swt[5:0])
            6'b0:begin t<=instr[20:16];disop<=TWO; end
            6'b1:begin t<=instr[15:11];disop<=TWO; end
            6'b10:begin t<=5'b11111;disop<=TWO; end
            6'b11:begin t<=regdst;disop<=ONE; end
            6'b100:begin t<=writereg;disop<=TWO; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b0110://writedata3_mux2: aluout, data, memtoreg, writedata3
            case(swt[5:0])
            6'b0:begin t<=aluout;disop<=EIGHT; end
            6'b1:begin t<=data;disop<=EIGHT; end
            6'b10:begin t<=memtoreg;disop<=ONE; end
            6'b11:begin t<=writedata3;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b0111://rf: instr[25:21], instr[20:16], writereg, writedata3, regwrite, regout1, regout2
                //rd1_reg: regouta
                //rd2_reg: regoutb 
                //writedata
            case(swt[5:0])
            6'b0:begin t<=instr[25:21];disop<=TWO; end
            6'b1:begin t<=instr[20:16];disop<=TWO; end
            6'b10:begin t<=writereg;disop<=TWO; end
            6'b11:begin t<=writedata3;disop<=EIGHT; end
            6'b100:begin t<=regwrite;disop<=ONE; end
            6'b101:begin t<=regout1;disop<=EIGHT; end
            6'b110:begin t<=regout2;disop<=EIGHT; end
            6'b111:begin t<=regouta;disop<=EIGHT; end
            6'b1000:begin t<=regoutb;disop<=EIGHT; end
            6'b1001:begin t<=writedata;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b1000://regfile
            begin t<=treg; disop<=disopreg; end
        4'b1001://signsrc_mux2: instr[15:0],{11'b0,instr[10:6]},extsrc,signsrc);
                //signext: signsrc, extend, signimm
                //signimm_sl: signimm[29:0], signimmsh
            case(swt[5:0])
            6'b0:begin t<=instr[15:0];disop<=FOUR; end
            6'b1:begin t<={11'b0,instr[10:6]};disop<=TWO; end
            6'b10:begin t<=extsrc;disop<=ONE; end
            6'b11:begin t<=signsrc;disop<=FOUR; end
            6'b100:begin t<=extend;disop<=ONE; end
            6'b101:begin t<=signimm;disop<=EIGHT; end
            6'b110:begin t<=signimmsh;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b1010://srca_mux4: pc, regouta, 32'b10000, signimm, alusrca, srca);
                //srcb_mux4: regoutb, 32'b100, signimmsh, alusrcb, srcb);
                //ALU: alucontrol, aluresult, zero);
                //faluout_reg: aluout);
            case(swt[5:0])
            6'b0:begin t<=pc;disop<=EIGHT; end
            6'b1:begin t<=regouta;disop<=EIGHT; end
            6'b10:begin t<=32'b10000;disop<=EIGHT; end
            6'b11:begin t<=signimm;disop<=EIGHT; end
            6'b100:begin t<=alusrca;disop<=ONE; end
            6'b101:begin t<=srca;disop<=EIGHT; end
            6'b110:begin t<=regoutb;disop<=EIGHT; end
            6'b111:begin t<=32'b100;disop<=EIGHT; end
            6'b1000:begin t<=signimmsh;disop<=EIGHT; end
            6'b1001:begin t<=alusrcb;disop<=ONE; end
            6'b1010:begin t<=srcb;disop<=EIGHT; end
            6'b1011:begin t<=alucontrol;disop<=ONE; end
            6'b1100:begin t<=aluresult;disop<=EIGHT; end
            6'b1101:begin t<=zero;disop<=ONE; end
            6'b1110:begin t<=aluout;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b1011://addr_sl({4'b0,instr[25:0]}, addrsl);
                //pcjump={pc[31:28], addrsl[27:0]};
            case(swt[5:0])
            6'b0:begin t<={6'b0,instr[25:0]};disop<=EIGHT; end
            6'b1:begin t<=addrsl;disop<=EIGHT; end
            6'b10:begin t<=pc[31:28];disop<=ONE; end
            6'b11:begin t<=pcjump;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        default:begin t<=0;disop<=ZERO; end
        endcase
    end
    
endmodule
