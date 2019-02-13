`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/22 14:16:58
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(
    input inclk,
    output outclk
    );
    
    reg [35:0] q=0;
    always@(posedge inclk)
         q<=q+1;
    
    //for development board
    //assign outclk=q[26];//around 1Hz
    assign outclk=q[0];//for simulation
endmodule
