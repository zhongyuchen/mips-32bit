`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/27 00:00:33
// Design Name: 
// Module Name: signext
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


module signext(
    input [15:0] a,
    input extend,
    output reg [31:0] y
    );
    
    always@(*)
    if(extend)
        y<= #1 { {16{a[15]}},a };
    else
        y<= #1 { 16'b0,a };
    
endmodule
