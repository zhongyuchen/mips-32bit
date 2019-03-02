`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2018 11:36:25 AM
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

    reg clk,reset;
    reg next,stop,lightsrc;
    reg [9:0] SW;
    
    wire [15:0] discu;
    wire [6:0] C;
    wire [7:0] AN;

    top dut(clk, reset,
            next, stop, lightsrc,
            SW, discu, C, AN);
    
    parameter period=5;
    
    initial begin
    reset<=1;
    #22;
    reset<=0;
    #20575;
    reset<=1;
    #10;
    reset<=0;
    end
    
    initial next<=0;
    initial stop<=0;
    initial lightsrc<=0;
    initial SW<=0;
    
    always begin
    clk<=1;
    #period;
    clk<=0;
    #period;
    end

endmodule
