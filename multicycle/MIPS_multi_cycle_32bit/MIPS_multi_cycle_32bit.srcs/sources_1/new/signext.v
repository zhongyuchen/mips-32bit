`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/28 16:48:26
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
    input [15:0] short,
    input extend,
    output reg [31:0] extended
    );
    
    //copy the MSb to the more significant 16 bits
    always@(*)
    if(extend)//sign extend
        extended={{16{short[15]}},short};
    else//zero extend
        extended={16'h0000,short};
    
endmodule
