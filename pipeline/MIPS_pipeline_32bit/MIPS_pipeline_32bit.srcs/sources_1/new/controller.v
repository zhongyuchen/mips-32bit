`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 12:16:34
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
    input [5:0] opD,functD,
    input flushE,cmpD,
    output memtoregE,memtoregM,memtoregW,
    output memwriteM,
    output pcsrcD,branchD,
    output [1:0] alusrcaE,alusrcbE,
    output [1:0] regdstE,
    output regwriteE,regwriteM,regwriteW,
    output [1:0] jumpD,
    output [3:0] alucontrolE,
    input [2:0] lsrc,
    output reg [15:0] led,
    input beep,
    output extend,
    output [2:0] cmpcontrolD
    );
    
    wire [2:0] aluopD;
    
    wire memtoregD,memwriteD;
    wire [1:0] alusrcbD,alusrcaD;
    wire [1:0] regdstD;
    wire regwriteD;
    wire [3:0] alucontrolD;
    wire memwriteE;
    
    wire [15:0] BEEP;
    
    maindec md(opD,memtoregD,memwriteD,branchD,
               alusrcaD,alusrcbD,regdstD,regwriteD,jumpD,
               aluopD,extend,functD,cmpcontrolD);
               
    aludec ad(functD,aluopD,alucontrolD);
    
    assign pcsrcD=branchD&cmpD;
    
    //pipeline registers
    floprc #(13) regE(clk,reset,flushE,
                     {memtoregD,memwriteD,alusrcaD,alusrcbD,regdstD,regwriteD,alucontrolD},
                     {memtoregE,memwriteE,alusrcaE,alusrcbE,regdstE,regwriteE,alucontrolE});
                     
    flopr #(3) regM(clk,reset,
                    {memtoregE,memwriteE,regwriteE},
                    {memtoregM,memwriteM,regwriteM});
                    
    flopr #(2) regW(clk,reset,
                    {memtoregM,regwriteM},
                    {memtoregW,regwriteW});
    
    
    //led BEEP         
    assign BEEP={beep,beep,beep,beep,
                 beep,beep,beep,beep,
                 beep,beep,beep,beep,
                 beep,beep,beep,beep};     
    //led display
    always@(*)
    case(lsrc)
    //D stage signals                  
    3'b0:led<={regwriteD,memtoregD,memwriteD,//to E
               alucontrolD,alusrcaD,alusrcbD,regdstD,//to E
               branchD,pcsrcD,extend};
    3'b1:led<={aluopD,jumpD,cmpcontrolD,
               BEEP[7:0]};
    //E stage signals
    3'b10:led<={regwriteE,memtoregE,memwriteE,
               alucontrolE,alusrcaE,alusrcbE,regdstE,
               BEEP[2:0]};
    //M stage signals
    3'b11:led<={regwriteM,memtoregM,memwriteM,
                BEEP[12:0]};
    //W stage signals
    3'b100:led<={regwriteW,memtoregW,
                BEEP[13:0]};
    default:led<=BEEP;
    endcase
    
endmodule
