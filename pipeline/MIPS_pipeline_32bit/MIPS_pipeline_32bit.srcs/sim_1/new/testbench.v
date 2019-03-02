`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/27 13:00:54
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

    reg clk,reset,next,stop;
    reg [9:0] SW;
    reg [2:0] lsrc;
    wire [15:0] LED;
    wire [6:0] C;
    wire [7:0] AN;
    parameter period=5;
    
    //instantiate device to be tested
    top dut(clk,reset,lsrc,LED);
    
    always begin
    clk<=1;
    #period;
    clk<=0;
    #period;
    end
    
    initial begin
    reset<=1;
    #22;
    reset<=0;
    #10575;
    reset<=1;
    #10;
    reset<=0;
    end
    
    initial next<=0;
    initial stop<=0;
    
    initial SW<=10'b0;
    
    initial lsrc<=3'b0;

endmodule
