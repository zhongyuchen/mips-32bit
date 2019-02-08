`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/09 14:33:45
// Design Name: 
// Module Name: test_ALU
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


module test_ALU();
    reg [31:0] a,b;
    reg [2:0] alucont;
    wire [31:0] result;
    wire zero;
    
    ALU alu0(
        .a(a),
        .b(b),
        .alucont(alucont),
        .result(result),
        .zero(zero)
        );
        
    parameter period=1;
    
    initial begin
        //initial
        a=32'h00000000;
        b=32'h00000000;
        alucont=3'd0;
        #period;
        //1
        a=32'h00000000;
        b=32'h00000000;
        alucont=3'd2;
        #period;
        //2
        a=32'h00000000;
        b=32'hffffffff;
        alucont=3'd2;
        #period;
        //3
        a=32'h00000001;
        b=32'hffffffff;
        alucont=3'd2;        
        #period;
        //4
        a=32'h000000ff;
        b=32'h00000001;
        alucont=3'd2;
        #period;
        //5
        a=32'h00000000;
        b=32'h00000000;
        alucont=3'd6;
        #period;
        //6
        a=32'h00000000;
        b=32'hffffffff;
        alucont=3'd6;
        #period;
        //7
        a=32'h00000001;
        b=32'h00000001;
        alucont=3'd6;
        #period;
        //8
        a=32'h00000100;
        b=32'h00000001;
        alucont=3'd6;
        #period;
        //9
        a=32'h00000000;
        b=32'h00000000;
        alucont=3'd7;
        #period;
        //10
        a=32'h00000000;
        b=32'h00000001;
        alucont=3'd7;
        #period;
        //11
        a=32'h00000000;
        b=32'hffffffff;
        alucont=3'd7;
        #period;
        //12
        a=32'h00000001;
        b=32'h00000000;
        alucont=3'd7;
        #period;
        //13
        a=32'hffffffff;
        b=32'h00000000;
        alucont=3'd7;
        #period;
        //14
        a=32'hffffffff;
        b=32'hffffffff;
        alucont=3'd0;
        #period;
        //15
        a=32'hffffffff;
        b=32'h12345678;
        alucont=3'd0;
        #period;
        //16
        a=32'h12345678;
        b=32'h87654321;
        alucont=3'd0;
        #period;
        //17
        a=32'h00000000;
        b=32'hffffffff;
        alucont=3'd0;
        #period;
        //18
        a=32'hffffffff;
        b=32'hffffffff;
        alucont=3'd1;
        #period;
        //19
        a=32'h12345678;
        b=32'h87654321;
        alucont=3'd1;
        #period;
        //20
        a=32'h00000000;
        b=32'hffffffff;
        alucont=3'd1;
        #period;
        //21
        a=32'h00000000;
        b=32'h00000000;
        alucont=3'd1;
        #period;
        //22
        a=32'h00000000;
        b=32'h80000000;
        alucont=3'd7;
        #period;
        //23
        a=32'h80000000;
        b=32'h00000000;
        alucont=3'd7;
        #period;
        //24
        a=32'h00000000;
        b=32'h7fffffff;
        alucont=3'd7;
        #period;
        //25
        a=32'h7fffffff;
        b=32'h00000000;
        alucont=3'd7;
        #period;
        //26
        a=32'h7fffffff;
        b=32'h80000000;
        alucont=3'd7;
        #period;
        //27
        a=32'h80000000;
        b=32'h7fffffff;
        alucont=3'd7;
        #period;
        //28
        a=32'h00000000;
        b=32'h00000000;
        alucont=3'd7;
        #period;
        //29
        a=32'h12345678;
        b=32'hffffffff;
        alucont=3'd7;
        #period;
    end

endmodule
