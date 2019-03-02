`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 16:21:11
// Design Name: 
// Module Name: mem
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


module mem(
    input clk,reset,memwrite,
    input [31:0] memadr,
    input [31:0] writedata,
    output [31:0] readdata,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    reg [31:0] RAM[63:0];//32x64 RAM
    
    //initialize instr memory
    initial
    $readmemh("C:/Users/ECHOES/Desktop/multi_cycle_pj/MIPS_multi_cycle_32bit/MIPS_multi_cycle_32bit.srcs/test_files/memfile6.dat", RAM);
    
    //read data
    assign readdata=RAM[memadr[31:2]];
    
    //reset instr memory
    always@(posedge clk)
    if(reset)
        $readmemh("C:/Users/ECHOES/Desktop/multi_cycle_pj/MIPS_multi_cycle_32bit/MIPS_multi_cycle_32bit.srcs/test_files/memfile6.dat", RAM);
    
    always@(posedge clk)
    if(memwrite)
        RAM[memadr[31:2]]<=writedata;
        
    parameter ZERO=8'b0;
    parameter ONE=8'b1;
    parameter TWO=8'b11;
    parameter FOUR=8'b1111;
    parameter EIGHT=8'b11111111;
    always@(*)
    begin 
        case(swt[9:6])
        4'b1100://memwrite,[31:0] memadr,[31:0] writedata,[31:0] readdata,
            case(swt[5:0])
            6'b0:begin t<=memwrite;disop<=ONE; end
            6'b1:begin t<=memadr;disop<=EIGHT; end
            6'b10:begin t<=writedata;disop<=EIGHT; end
            6'b11:begin t<=readdata;disop<=EIGHT; end
            default:begin t<=0;disop<=ZERO; end
            endcase
        4'b1101://MEMORY
            begin t<=RAM[swt[5:0]];disop<=EIGHT; end
        default:begin t<=0;disop<=ZERO; end
        endcase
    end
    
endmodule
