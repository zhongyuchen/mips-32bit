`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2018 10:22:42 AM
// Design Name: 
// Module Name: adr_MUX2
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


module adr_MUX2(
    input [5:0] pcadr,
    input [31:0] aluout,
    input iord,
    output reg [31:0] adr 
    );
    
    always@(*)
    if(iord)
        adr<=aluout;
    else
        adr<={24'h000000,pcadr,2'b00};
    
endmodule
