`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/16 15:39:15
// Design Name: 
// Module Name: testbench
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


module testbench();

    reg next;
    reg clk;
    reg reset;
    reg cloak;
    wire [15:0] discu;
    reg [9:0] SW;
    wire [6:0] C;
    wire [7:0] AN;
    reg clear;
    
    
    parameter period=5;
    
    //instantiate device to be tested
    top dut(next,clk, reset,cloak, discu,SW,C,AN,clear);
    
    initial
    SW<=10'b0;
    
    initial
    next<=0;
    
    initial begin
    clear<=0;
    #10597;
    clear<=1;
    #10;
    clear<=0;
    end
    
    //initialize test
    initial begin
    reset<=1;
    #22;
    reset<=0;
    #10575;
    reset<=1;
    #10;
    reset<=0;
    end
    
    initial
    cloak<=1;
    
    //generate clock to sequence tests
    always begin
    clk<=1;
    #period;
    clk<=0;
    #period;
    end
    
    //check results
//    always@(negedge clk)
//    begin
//        if(memwrite)
//        begin
//            if(dataadr===84 & writedata===7)
//            begin
//                $display("Simulation succeeded");
//                $stop;
//            end
//            else if(dataadr!==80)
//            begin
//                $display("Simulation failed");
//                $stop;
//            end
//        end
//    end          

endmodule
