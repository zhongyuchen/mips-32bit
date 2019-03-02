`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 21:47:33
// Design Name: 
// Module Name: mips
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



module mips(
    input clk,reset,
    input next,stop,lightsrc,
    input [31:0] readdata,
    output memwrite,
    output [31:0] adr,writedata,
    output [15:0] discu,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    wire [5:0] op,funct;
    wire zero,irod,irwrite,memtoreg,regwrite;
    wire [1:0] alusrca;
    wire [1:0] alusrcb;
    wire [3:0] alucontrol;
    wire [1:0] pcsrc;
    wire pcen;
    wire extend;
    wire extsrc;
    wire [1:0] regdst;
    
    wire [31:0] tcu,tdp;
    wire [7:0] disopcu,disopdp;
    
    controller cu(clk,reset,next,stop,lightsrc,
                  op,funct,zero,
                  iord,memwrite,irwrite,regdst,memtoreg,regwrite,alusrca,
                  alusrcb,alucontrol,pcsrc,pcen,
                  discu,extend,extsrc,
                  swt,tcu,disopcu);
        
    datapath dp(clk,reset,pcen,iord,irwrite,regdst,memtoreg,regwrite,
                alusrca,alusrcb,alucontrol,pcsrc,readdata,
                op,funct,zero,adr,writedata,
                extend,extsrc,
                swt,tdp,disopdp);
                
    always@(*) 
    if(swt[9:6]==4'b0)
        begin t<=tcu;disop<=disopcu; end
    else
        begin t<=tdp;disop<=disopdp; end
    
endmodule
