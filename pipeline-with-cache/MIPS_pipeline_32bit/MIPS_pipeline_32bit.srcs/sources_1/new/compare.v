`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 22:03:17
// Design Name: 
// Module Name: compare
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


module compare(
    input [31:0] a,b,
    input [2:0] cmpcontrol,
    input [4:0] rt,
    output reg cmp
    );
    
    always@(*)
    case(cmpcontrol)
    3'b000:cmp<= a==b;//beq
    3'b001:cmp<= a!=b;//bne
    3'b010:cmp<= a[31]|(a==0);//blez
    3'b011:cmp<= ~a[31]&(a!=0);//bgtz
    3'b100://bltz,bgez
     case(rt)
     5'b00000:cmp<= a[31];//bltz
     5'b00001:cmp<= ~a[31];//bgez
     default: cmp<= 1'bx;
     endcase
    default:  cmp<= 1'bx;
    endcase

endmodule
