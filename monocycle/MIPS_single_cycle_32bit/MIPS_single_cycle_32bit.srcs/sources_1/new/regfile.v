`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/09 16:35:02
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input we3,//write enable
    input [4:0] ra1,ra2,wa3,ra3,//reg
    input [31:0] wd3,//input data
    output reg [31:0] rd1,
    output [31:0] rd2,//2 vals
    input [1:0] alusrca,
    input [31:0] pc,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    reg [31:0] rf[31:0];//32 32bit-registers
    initial
    rf[0]=32'b0;//initial $0 = 0;
    
    always@(posedge clk)
    if(we3)
        rf[wa3]<=wd3;
    
    //R-type:
    //[10:6]==5'b00000:add, sub, and, or, slt, nor, xor
    //[25:21]==5'b00000:sll, srl, sra
    always@(*)
    begin
        case(alusrca)
        2'b00:rd1<=pc;
        2'b01:rd1<=rf[ra1];
        2'b10:rd1<={{27{0}}, ra3};
        default:rd1<=rd1;//not used
        endcase
    end

    assign rd2=ra2?rf[ra2]:0;
    
    always@(*)
    begin
    if(swt[5])
        begin t<=32'b0;disop<=8'b0; end
    else
        begin t<=rf[swt[4:0]];disop<=8'b11111111; end
    end
    
endmodule
