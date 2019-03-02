`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/27 00:18:01
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
    input clk,reset,
    input [31:0] adr,
    output reg [127:0] instr,
    output reg ready,
    input [6:0] SW,
    output reg [31:0] t
    );
    
    //instr mem
    reg [31:0] RAM[511:0];//32bit x 512=2^9
    
    //read in instructions
    initial
    $readmemh("C:/Users/ECHOES/Desktop/MIPS_pipeline_32bit/MIPS_pipeline_32bit.srcs/test_files/cache.dat",RAM);
    
    //delay
    reg [2:0] count;
    reg [31:0] oldadr;
    always@(posedge clk)
    if(reset)
    begin count<=3'b0;oldadr=32'b0; end
    else
        if(oldadr==adr)
        begin
            if(count==3'b111) count<=count;
            else count<=count+1;
        end
        else
        begin count<=3'b0;oldadr<=adr; end
    
    always@(posedge clk)
    if(count==3'b111) ready<=1'b1;
    else ready<=1'b0;    
    
    //read data
    always@(*)
    instr<={RAM[{adr[31:4],2'b11}],
            RAM[{adr[31:4],2'b10}],
            RAM[{adr[31:4],2'b01}],
            RAM[{adr[31:4],2'b00}]};    
    
    //display
    always@(*)
        t<=RAM[{2'b00,SW}];
        //only display the first 2^7=128 datas
  
endmodule
