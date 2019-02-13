`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/10 10:31:55
// Design Name: 
// Module Name: test_adder
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


module test_adder();
    reg [31:0] a,b;
    wire [31:0] result;
    
    adder ad(
        .a(a),
        .b(b),
        .result(result)
        );
        
    parameter period=10;
        
    initial begin
    //initial
    a=32'h00000000;
    b=32'h00000000;
    #period;
    //1
    a=32'h07070707;
    b=32'h70707070;
    #period;
    //2
    a=32'h1;
    b=32'h80000000;
    #period;
    //3
    a=32'h6fffffff;
    b=32'h1;
    #period;
    end

endmodule
