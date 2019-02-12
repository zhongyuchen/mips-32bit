`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/09 14:59:28
// Design Name: 
// Module Name: test_PC
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


module test_PC();
    reg clk;
    reg reset;
    reg [7:0] newpc;
    wire [7:0] pc;
    
    PC pc0(
        .clk(clk),
        .reset(reset),
        .newpc(newpc),
        .pc(pc)
        );
        
    parameter period=10;
    
    always begin
        clk=0;
        #(period/2);
        clk=1;
        #(period/2);
    end
    
    initial begin
        //initial
        clk=0;
        reset=0;
        newpc=8'h00;
        #period;
        //1
        reset=0;
        newpc=8'haa;
        #period;
        //2
        reset=0;
        newpc=8'hbb;
        #period;
        //3
        reset=1;
        newpc=8'hcc;
        #period;
        //4
        reset=0;
        newpc=8'hdd;
        #period;
        //5
        reset=0;
        newpc=8'hee;
        #period;
        //6
        reset=1;
        newpc=8'hff;
        #period;
        //7
        reset=0;
        newpc=8'haa;
    end
    
endmodule
