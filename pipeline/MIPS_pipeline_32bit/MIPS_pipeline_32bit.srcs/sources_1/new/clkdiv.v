`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 00:18:39
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
    
    reg [35:0] q;
    
    initial q<=36'b0;
    
    always@(posedge inclk)
         q<=q+1;
    
//for development board
    //assign outclk=q[26];//around 1Hz
//for simulation
    assign outclk=q[0];    
    
endmodule
