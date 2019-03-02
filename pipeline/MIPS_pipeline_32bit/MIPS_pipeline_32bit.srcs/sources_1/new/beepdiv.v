`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 00:24:31
// Design Name: 
// Module Name: beepdiv
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


module beepdiv(
    input inclk,
output outclk
    );
    
    reg [35:0] q;
    
    initial q<=36'b0;
    
    always@(posedge inclk)
         q<=q+1;
    
    //beep
    assign outclk=q[26];//around 1Hz
    
endmodule
