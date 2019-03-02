`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 12:04:53
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
    output [31:0] pcF,
    input [31:0] instrF,
    output memwriteM,
    output [31:0] aluoutM,writedataM,
    input [31:0] readdataM,
    input [2:0] lsrc,
    output reg [15:0] led,
    input beep,
    input [9:0] SW,
    output [31:0] t,
    output [7:0] disop    
    );
    
    wire [5:0] opD,functD;
    wire [1:0] regdstE;
    wire pcsrcD,memtoregE,memtoregM,
         memtoregW,regwriteE,regwriteM,regwriteW;
    wire [1:0] alusrcbE,alusrcaE;
         
    wire [3:0] alucontrolE;
    wire flushE,cmpD;
    
    wire [1:0] jumpD;
    wire branchD;
    
    wire [15:0] ledc,leddp;
    
    wire [15:0] BEEP;
    
    wire extend;
    wire [2:0] cmpcontrolD;
     
    controller c(clk,reset,opD,functD,flushE,cmpD,
                 memtoregE,memtoregM,memtoregW,memwriteM,
                 pcsrcD,branchD,alusrcaE,alusrcbE,regdstE,regwriteE,
                 regwriteM,regwriteW,jumpD,alucontrolE,
                 lsrc,ledc,beep,
                 extend,cmpcontrolD);
                    
    datapath dp(clk,reset,memtoregE,memtoregM,memtoregW,
                pcsrcD,branchD,alusrcaE,alusrcbE,regdstE,regwriteE,
                regwriteM,regwriteW,jumpD,alucontrolE,
                cmpD,pcF,instrF,aluoutM,writedataM,
                readdataM,opD,functD,flushE,
                leddp,beep,
                extend,cmpcontrolD,
                SW,t,disop);
                 
    //led BEEP         
    assign BEEP={beep,beep,beep,beep,
                 beep,beep,beep,beep,
                 beep,beep,beep,beep,
                 beep,beep,beep,beep}; 
    //final LED     
    always@(*)
    case(lsrc)
    //controller signals
    3'b0:led<=ledc;
    3'b1:led<=ledc;
    3'b10:led<=ledc;
    3'b11:led<=ledc;
    3'b100:led<=ledc;
    //hazard signals
    3'b101:led<=leddp;
    //???
    default:led<=BEEP;
    endcase
    
endmodule
