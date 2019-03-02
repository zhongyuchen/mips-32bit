`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/28 16:51:43
// Design Name: 
// Module Name: maindec
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


module maindec(
    input clk,reset,
    input [5:0] op,
    output pcwrite,memwrite,irwrite,regwrite,
    output [1:0] alusrca,
    output branch,iord,memtoreg,
    output [1:0] regdst,//-> [1:0]
    output [1:0] alusrcb,pcsrc,
    output [2:0] aluop,//[1:0] -> [2:0]
    output [19:0] lightsmd,
    output extend,//newly added
    output extsrc,
    input [5:0] funct,
    input [9:0] swt,
    output reg [31:0] t,
    output reg [7:0] disop
    );
    
    //state 0~11
    parameter FETCH     = 5'b00000;
    parameter DECODE    = 5'b00001;
    parameter MEMADR    = 5'b00010;
    parameter MEMRD     = 5'b00011;
    parameter MEMWB     = 5'b00100;
    parameter MEMWR     = 5'b00101;
    parameter RTYPEEX   = 5'b00110;
    parameter RTYPEWB   = 5'b00111;
    parameter BEQEX     = 5'b01000;
    parameter ADDIEX    = 5'b01001;
    parameter ADDIWB    = 5'b01010;
    parameter JEX       = 5'b01011;
    
    parameter BNEEX     = BEQEX;
    parameter ANDIEX    = 5'b01100;
    parameter ANDIWB    = ADDIWB;
    parameter ORIEX     = 5'b01101;
    parameter ORIWB     = ADDIWB;
    parameter XORIEX    = 5'b01110;
    parameter XORIWB    = ADDIWB;
    parameter SLTIEX    = 5'b01111;
    parameter SLTIWB    = ADDIWB;
    parameter SLLEX     = 5'b10000;
    parameter SLLWB     = RTYPEWB;//sll, srl, sra
    parameter SRLEX     = SLLEX;
    parameter SRAEX     = SLLEX;
    parameter JALEX     = 5'b10001;
    parameter JALWB     = 5'b10010;
    parameter LUIEX     = 5'b10011;
    parameter LUIWB     = ADDIWB;
    
    //opcode for instructions
    parameter LW=     6'b100011;
    parameter SW=     6'b101011;
    parameter RTYPE=  6'b000000;
    parameter BEQ=    6'b000100;
    parameter ADDI=   6'b001000;
    parameter J=      6'b000010;
    
    parameter BNE=    6'b000101;
    parameter NOP=    6'b000000;
    parameter ANDI=   6'b001100;
    parameter ORI=    6'b001101;
    parameter XORI=   6'b001110;
    parameter SLTI=   6'b001010;
    parameter JAL=    6'b000011;
    parameter LUI=    6'b001111;
    
    //states and controls register
    reg [4:0] state,nextstate;
    //[3:0] -> [4:0] because of too many states
    reg [19:0] controls;
    
    //state register
    always@(posedge clk)
    if(reset)
        state<=FETCH;
    else
        state<=nextstate;
        
    //next state logic
    always@(*)
    case(state)
    FETCH: nextstate = DECODE;
    DECODE: case(op)
            LW: nextstate = MEMADR;
            SW: nextstate = MEMADR;
            RTYPE: 
                case(funct)
                6'b000000:nextstate = SLLEX;
                6'b000010:nextstate = SRLEX;
                6'b000011:nextstate = SRAEX;
                default:nextstate = RTYPEEX;
                endcase
            BEQ: nextstate = BEQEX;
            BNE: nextstate = BNEEX;
            ADDI: nextstate = ADDIEX;
            J: nextstate = JEX;
            //NOP: nextstate = FETCH;
            ANDI: nextstate = ANDIEX;
            ORI: nextstate = ORIEX;
            XORI: nextstate = XORIEX;
            SLTI: nextstate = SLTIEX;
            JAL: nextstate = JALEX;
            LUI: nextstate = LUIEX;
            //default should never happen
            default: nextstate = 5'bxxxxx;
            endcase
    MEMADR: case(op)
            LW: nextstate = MEMRD;
            SW: nextstate = MEMWR;
            default: nextstate = 5'bxxxxx;
            endcase
    MEMRD: nextstate = MEMWB;
    MEMWB: nextstate = FETCH;
    MEMWR: nextstate = FETCH;
    RTYPEEX: nextstate = RTYPEWB;
    RTYPEWB: nextstate = FETCH;
    BEQEX: nextstate = FETCH;//also for BNEEX
    ADDIEX: nextstate = ADDIWB;
    ADDIWB: nextstate = FETCH;
    JEX: nextstate = FETCH;
    ANDIEX: nextstate = ANDIWB;
    ORIEX: nextstate = ORIWB;
    XORIEX: nextstate = XORIWB;
    SLTIEX: nextstate = SLTIWB;
    SLLEX: nextstate = RTYPEWB;
    JALEX: nextstate = JALWB;
    JALWB: nextstate = FETCH;
    LUIEX: nextstate = LUIWB;
    //default should never happen
    default: nextstate = 5'bxxxxx;
    endcase
    
    //output logic
    assign {pcwrite, memwrite, irwrite, regwrite, 
            alusrca, branch, iord, memtoreg, regdst, 
            alusrcb, pcsrc, aluop, 
            extend, extsrc} = controls;
            //[14:0] -> [15:0] because aluop is 1 bit wider
            //-> [16:0] because extend
            //-> [17:0] because extsrc
            //-> [18:0] because widen regdst 
            //-> [19:0] because widen alusrca
            
//19    18    17    16    15    14    13    12    11    10    9     8     7    6    5    4    3    2    1    0
//pcw   mem   irw   regw  alua        bran  iord  memto regd        alusrcb   pcsrc     aluop           ext  extsrc
            
    always@(state)
    case(state)
    FETCH: controls =   20'b10100000000010000010;
    DECODE: controls =  20'b00000000000110000010;
    MEMADR: controls =  20'b00000100000100000010;
    MEMRD: controls =   20'b00000001000000000010;
    MEMWB: controls =   20'b00010000100000000010;
    MEMWR: controls =   20'b01000001000000000010;
    RTYPEEX: controls = 20'b00000100000000011110;
    RTYPEWB: controls = 20'b00010000001000000010;
    BEQEX: controls =   20'b00000110000000100110;
    ADDIEX: controls =  20'b00000100000100000010;
    ANDIEX: controls =  20'b00000100000100001000;//ANDI execute
    ORIEX: controls =   20'b00000100000100001100;//ORI execute
    XORIEX: controls =  20'b00000100000100010100;//XORI execute
    ADDIWB: controls =  20'b00010000000000000010;//also for ANDIWB, ORIWB, XORIWB;
    
    JEX: controls =     20'b10000000000001000010;
    JALEX: controls =   20'b10000000000011000010;
    JALWB: controls =   20'b00010000010000000010;
    
    SLTIEX: controls =  20'b00000100000100010010;//slti
    
    SLLEX: controls =   20'b00001100000000011111;//sll
    LUIEX: controls =   20'b00001000000100011010;//lui
    
    default: controls = 20'bxxxxxxxxxxxxxxxxxxxx;//default should never happen
    endcase
    
    //more than 16 leds are needed, redo discu!!!
    //assign discu=controls;
    assign lightsmd=controls;
    
    parameter ZERO=8'b0;
    parameter TWO=8'b11;
    always@(*)
    begin
        case(swt[9:6])
        4'b0000:
            case(swt[5:0])
            6'b000000:begin t<=state;disop<=TWO; end
            6'b000001:begin t<=nextstate;disop<=TWO; end
            default:begin t<=0;disop<=ZERO;end
            endcase
        default:begin t<=0;disop<=ZERO;end
        endcase
    end
    
endmodule
