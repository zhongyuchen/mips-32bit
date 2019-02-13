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
    output reg pcsrc,
    output [1:0] alusrca,
    output [1:0] alusrcb,
    output [1:0] regdst,
    output regwrite,
    output jump,
    output [3:0] alucont,
    output extend,
    output [15:0] discu
    );
    
    wire [2:0] aluop;//[1:0] -> [2:0]
    wire branch;
    
    main_decoder md(op, mem2reg, memwrite, branch, alusrca, alusrcb,regdst, regwrite, jump,aluop, extend,funct);
    alu_decoder ad(funct, aluop, alucont);   
    
    always@(op, branch, zero)
    if(op==6'b000101)
        pcsrc<=branch&(~zero);
    else
        pcsrc<=branch&zero;
        
    //controls+alucont+pcsrc
    assign discu={regwrite, regdst, alusrca,alusrcb, branch, memwrite, mem2reg, jump,extend,alucont};
                  
endmodule
