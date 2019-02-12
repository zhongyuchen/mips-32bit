`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/10 11:17:23
// Design Name: 
// Module Name: test_main_decoder
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


module test_main_decoder();
    reg [5:0] op;
    wire mem2reg, memwrite;
    wire branch, alusrc;
    wire regdst, regwrite,jump;
    wire [1:0] aluop;

    main_decoder md(op,mem2reg,memwrite,branch,alusrc,regdst,regwrite,jump,aluop);
//    main_decoder md(
//        .op(op),
//        .mem2reg(mem2reg),
//        .memwrite(memwrite),
//        .branch(branch),
//        .alusrc(alusrc),
//        .regdst(regdst),
//        .regwrite(regwrite),
//        .jump(jump),
//        .aluop(aluop)
//        );
        
    parameter period=10;
        
    initial begin
    //initial
    op=6'b000000;
    #period;
    //add signal
    op=6'b000000;
    #period;
    op=6'b100011;
    #period;
    op=6'b101011;
    #period;
    op=6'b000100;
    #period;
    op=6'b001000;
    #period;
    op=6'b000010;
    #period;
    op=6'b011110;
    end

endmodule
