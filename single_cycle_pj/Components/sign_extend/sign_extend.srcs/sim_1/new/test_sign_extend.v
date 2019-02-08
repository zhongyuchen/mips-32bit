`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/09 16:53:15
// Design Name: 
// Module Name: test_sign_extend
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


module test_sign_extend();
    reg [15:0] x;
    wire [31:0] y;

    sign_extend se(
        .x(x),
        .y(y)
        );
        
    parameter period=10;
    
    initial begin
        //initial
        x=16'h0000;
        #period;
        //1
        x=16'h0fff;
        #period;
        //2
        x=16'h8fff;
        #period;
        //3
        x=16'h7fff;
    end
    
endmodule
