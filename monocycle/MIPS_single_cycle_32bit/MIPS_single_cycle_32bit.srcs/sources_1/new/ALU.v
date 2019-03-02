`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/09 14:32:19
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a,b,
    input [3:0] alucont,
    output reg [31:0] result,
    output reg zero
    );
    
    //sra to save SRA result
    reg [31:0] sra;
    always@(*)
    begin
        case(a)
        32'b1:sra<={{1{b[31]}},b[31:1]};
        32'b10:sra<={{2{b[31]}},b[31:2]};
        32'b11:sra<={{3{b[31]}},b[31:3]};
        32'b100:sra<={{4{b[31]}},b[31:4]};
        32'b101:sra<={{5{b[31]}},b[31:5]};
        32'b110:sra<={{6{b[31]}},b[31:6]};
        32'b111:sra<={{7{b[31]}},b[31:7]};
        32'b1000:sra<={{8{b[31]}},b[31:8]};
        32'b1001:sra<={{9{b[31]}},b[31:9]};
        32'b1010:sra<={{10{b[31]}},b[31:10]};
        32'b1011:sra<={{11{b[31]}},b[31:11]};
        32'b1100:sra<={{12{b[31]}},b[31:12]};
        32'b1101:sra<={{13{b[31]}},b[31:13]};
        32'b1110:sra<={{14{b[31]}},b[31:14]};
        32'b1111:sra<={{15{b[31]}},b[31:15]};
        32'b10000:sra<={{16{b[31]}},b[31:16]};
        32'b10001:sra<={{17{b[31]}},b[31:17]};
        32'b10010:sra<={{18{b[31]}},b[31:18]};
        32'b10011:sra<={{19{b[31]}},b[31:19]};
        32'b10100:sra<={{20{b[31]}},b[31:20]};
        32'b10101:sra<={{21{b[31]}},b[31:21]};
        32'b10110:sra<={{22{b[31]}},b[31:22]};
        32'b10111:sra<={{23{b[31]}},b[31:23]};
        32'b11000:sra<={{24{b[31]}},b[31:24]};
        32'b11001:sra<={{25{b[31]}},b[31:25]};
        32'b11010:sra<={{26{b[31]}},b[31:26]};
        32'b11011:sra<={{27{b[31]}},b[31:27]};
        32'b11100:sra<={{28{b[31]}},b[31:28]};
        32'b11101:sra<={{29{b[31]}},b[31:29]};
        32'b11110:sra<={{30{b[31]}},b[31:30]};
        32'b11111:sra<={32{b[31]}};
        default:sra<=b;
        endcase
    end
    
    always@(*)
    begin
        case(alucont)
        4'b0000:result<=a&b;
        4'b0001:result<=a|b;
        4'b0010:result<=a+b;
        4'b0011:result<=b<<a;//SLL
        4'b0100:result<=~(a|b);//NOR
        4'b0101:result<=a^b;//XOR
        4'b0110:result<=a-b;
        4'b0111:result<=(a[31]==b[31])?a<b:a>b;
        4'b1000:result<=b>>a;//SRL
        4'b1001:result<=sra;//SRA
        4'b1010:result<=b<<16;//LUI
        default:result<=32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;//???
        endcase
        zero<=!result;
    end
    
endmodule
