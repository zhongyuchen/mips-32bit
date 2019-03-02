`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/26 23:25:02
// Design Name: 
// Module Name: hazard
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


module hazard(
    input [4:0] rsD,rtD,rsE,rtE,
    input [4:0] writeregE,writeregM,writeregW,
    input regwriteE,regwriteM,regwriteW,
    input memtoregE,memtoregM,branchD,
    output forwardaD,forwardbD,
    output reg [1:0] forwardaE,forwardbE,
    output stallF,stallD,flushE,
    input [1:0] jumpD,
    output [15:0] led,
    input beep
    );
    
    wire lwstallD,branchstallD;
    wire jalrstallD;
    
    wire [15:0] BEEP;
    
    //forwarding sources to D stage (branch equality)
    assign forwardaD=(rsD!=0 & rsD==writeregM & regwriteM);
    assign forwardbD=(rtD!=0 & rtD==writeregM & regwriteM);
    
    //forwarding sources to E stage (ALU)
    always@(*)
    begin
        forwardaE=2'b00;
        if(rsE!=0)
        begin
            if(rsE==writeregM & regwriteM)
                forwardaE=2'b10;
            else
                if(rsE==writeregW & regwriteW)
                    forwardaE=2'b01;
        end
        
        forwardbE=2'b00;
        if(rtE!=0)
        begin 
            if(rtE==writeregM & regwriteM)
                forwardbE=2'b10;
            else
                if(rtE==writeregW & regwriteW)
                    forwardbE=2'b01;
        end
    end
    
    //stall
    assign #1 lwstallD=memtoregE & (rtE==rsD | rtE==rtD);
    assign #1 branchstallD=branchD & 
                           (regwriteE & (writeregE==rsD | writeregE==rtD) | 
                            memtoregM & (writeregM==rsD | writeregM==rtD));
    assign #1 jalrstallD=(jumpD==2'b10) & 
                         (regwriteE & writeregE==rsD |
                          memtoregM & writeregM==rsD);//jalr waits for the reg to be ready
    
    assign #1 stallD=lwstallD | branchstallD | jalrstallD;
    assign #1 stallF=stallD;//stalling D stalls all previous stages
    assign #1 flushE=stallD;//stalling D flushes next stage
    
    //led BEEP
    assign BEEP={beep,beep,beep,beep,
                 beep,beep,beep,beep,
                 beep,beep,beep,beep,
                 beep,beep,beep,beep};  
    //led display
    assign led={stallF,stallD,flushE,
                lwstallD,branchstallD,jalrstallD,
                forwardaD,forwardbD,
                forwardaE,forwardbE,
                BEEP[3:0]};
    
endmodule
