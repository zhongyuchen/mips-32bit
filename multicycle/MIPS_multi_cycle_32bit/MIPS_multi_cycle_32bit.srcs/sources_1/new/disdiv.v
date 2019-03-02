`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/11 15:07:20
// Design Name: 
// Module Name: disdiv
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


module disdiv(
    input inclk,
    output outclk
    );
    
    reg [35:0]q;
    always@(posedge inclk)
         q<=q+1;
    assign outclk=q[17];//around 3kHz    
    
endmodule
