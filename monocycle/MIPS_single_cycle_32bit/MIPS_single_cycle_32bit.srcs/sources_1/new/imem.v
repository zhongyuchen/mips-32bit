`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/09 16:02:21
// Design Name: 
// Module Name: imem
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


module imem(
    input [5:0] addr,
    output [31:0] instr,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    reg [31:0] RAM[63:0];
    
    //initialize instr memory
    initial
    $readmemh("sortfile0.dat", RAM);
    
    assign instr=RAM[addr];//word aligned
    
    parameter EIGHT=8'b11111111;
    parameter TWO=8'b11;
    always@(*)
    begin
        case(swt[9:6])
        //instr mem
        4'b0100:begin t<=RAM[swt[5:0]];disop<=EIGHT; end
        //other
        4'b0101:
            case(swt[5:0])
            6'b000000:begin t<={{26{0}},addr};disop<=TWO; end
            6'b000001:begin t<=instr;disop<=EIGHT; end
            default:begin t<=0;disop<=0; end
            endcase        
        default:begin t<=0;disop<=0; end
        endcase
    end
    
endmodule
