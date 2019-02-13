`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/09 16:42:48
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(
    input [15:0] x,
    input extend,
    output reg [31:0] y
    );
    
    //if extend == 1, sign extend
    //else extend == 0, zero extend
    always@(x,extend)
    if(extend)
        y<={{16{x[15]}}, x};
    else
        y<={{16{0}}, x};
    
endmodule
