`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 11:44:51
// Design Name: 
// Module Name: nextU
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


module nextU(
    input [5:0] U,
    input [1:0] way,
    output reg [5:0] nextU
    );
    
    always@(*)
    case(way)
    2'b00:nextU<={3'b111,U[2:0]};
    2'b01:nextU<={1'b0,U[4:3],2'b11,U[0]};
    2'b10:nextU<={U[5],1'b0,U[3],1'b0,U[1],1'b1};
    2'b11:nextU<={U[5:4],1'b0,U[2],2'b00};
    default:nextU<=6'bxxxxxx;
    endcase
    
endmodule
