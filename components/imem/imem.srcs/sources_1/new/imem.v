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
    input [7:0] addr,
    output [31:0] instr
    );
    
    reg [31:0] RAM[255:0];//32x256 RAM
    
    initial begin
    //initialize instr memory
    $readmemh("memfile.dat", RAM);
    end
    
    assign instr=RAM[addr];//word aligned
    
endmodule
