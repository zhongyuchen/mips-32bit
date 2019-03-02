`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 12:02:22
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk,we,
    input [31:0] adr,wd,
    output [31:0] rd,
    input [6:0] SW,
    output reg [31:0] t
    );
    
    reg [31:0] RAM[127:0];//32bit x 128
    
    assign rd=RAM[adr[31:2]];
    
    always@(posedge clk)
    if(we)
        RAM[adr[31:2]]<=wd;
        
    //display
    always@(*)
        t<=RAM[SW];
    
endmodule
