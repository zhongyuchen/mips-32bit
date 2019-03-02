`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 16:21:35
// Design Name: 
// Module Name: controller
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


module controller(
    input clk,reset,
    input next,stop,lightsrc,
    input [5:0] op,funct,
    input zero,
    output iord,memwrite,irwrite,
    output [1:0] regdst,
    output memtoreg,regwrite,
    output [1:0] alusrca,
    output [1:0] alusrcb,
    output [3:0] alucontrol,
    output [1:0] pcsrc,
    output reg pcen,
    output reg [15:0] discu,
    output extend,
    output extsrc,
    input [9:0] swt,
    output [31:0] t,
    output [7:0] disop
    );
    
    wire pcwrite, branch;
    wire [2:0] aluop;
    wire [24:0] lights;
    
    maindec md(clk,reset,op,pcwrite,memwrite,irwrite,regwrite,
               alusrca,branch,iord,memtoreg,regdst,
               alusrcb,pcsrc,aluop,
               lights[19:0],extend,extsrc,funct,
               swt,t,disop);
        
    aludec ad(funct, aluop, alucontrol,lights[23:20]);
    
    //beq & bne
    always@(*)
    if(op==6'b000101)//bne
        pcen<=(branch&(~zero))|pcwrite;
    else//beq
        pcen<=(branch&zero)|pcwrite;
        
    assign lights[24]=pcen;
    
    always@(*)
    if(lightsrc)
        discu<={next,stop,lightsrc,reset,clk,2'b0,lights[24:16]};
    else
        discu<=lights[15:0];
        
endmodule
