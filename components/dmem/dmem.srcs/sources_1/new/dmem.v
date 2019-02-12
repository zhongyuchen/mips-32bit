`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/10 00:07:50
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
    input clk,
    input memwrite,
    input [31:0] addr,writedata,
    output [31:0] readdata
    );
    
    reg [31:0] RAM[255:0];//32x256 RAM
    
    //read data from memory
    assign readdata=RAM[addr[31:2]];
    
    //write data into memory
    always@(posedge clk)
    if(memwrite)
        RAM[addr[31:2]]<=writedata;
    
endmodule
