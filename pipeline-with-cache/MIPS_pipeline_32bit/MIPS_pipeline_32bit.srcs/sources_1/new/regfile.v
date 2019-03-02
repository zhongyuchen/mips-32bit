`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 11:47:08
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input we3,
    input [4:0] ra1,ra2,wa3,
    input [31:0] wd3,
    output [31:0] rd1,rd2,
    input [4:0] sw,
    output reg [31:0] t
    );
    
    reg [31:0] rf[31:0];//32bit x 32
    
    always@(negedge clk)//write at negedge clock!!!
    if(we3)
        rf[wa3]<=wd3;
        
    //delay 1 before assign
    assign rd1=(ra1!=0)?rf[ra1]:0;
    assign rd2=(ra2!=0)?rf[ra2]:0;
    
    //display
    always@(*)
        t<=rf[sw];
    
endmodule
