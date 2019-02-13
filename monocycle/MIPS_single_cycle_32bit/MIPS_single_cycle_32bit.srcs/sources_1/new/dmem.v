`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zhongyu Chen
// 
// Create Date: 2018/04/10 00:07:50
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk,memwrite,
    input [31:0] addr,writedata,
    output [31:0] readdata,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop,
    input clear
    );
    
    reg [31:0] RAM[63:0];//32x64 RAM
    
    //read data from memory
    assign readdata=RAM[addr[31:2]];
    
    //write data into memory
    always@(posedge clk)
    if(memwrite)
        RAM[addr[31:2]]<=writedata;
        
    //clear dataRAM
    always@(posedge clk)
    if(clear)
        $readmemh("emptyRAM.dat",RAM);
        
    parameter EIGHT=8'b11111111;
    always@(*)
    begin
        case(swt[9:6])
        4'b1000:begin t<=RAM[swt[5:0]];disop<=EIGHT; end
        4'b1001://addr,writedata,readdata,
            case(swt[5:0])
            6'b000000:begin t<=addr;disop<=EIGHT; end
            6'b000001:begin t<=writedata;disop<=EIGHT; end
            6'b000010:begin t<=readdata;disop<=EIGHT; end
            default:begin t<=0;disop<=0; end
            endcase
        default:begin t<=0;disop<=0; end
        endcase
    end
    
endmodule
