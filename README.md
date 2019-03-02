# mips-32bit

![build status](https://img.shields.io/badge/build-passing-66c2a5.svg)
[![Vivado version](https://img.shields.io/badge/Vivado-2018.1-fc8d62.svg)](https://www.xilinx.com/products/design-tools/vivado.html)
[![Verilog version](https://img.shields.io/badge/Verilog-2005-8da0cb.svg)](http://www.verilog.com/)
[![FPGA version](https://img.shields.io/badge/FPGA-DigilentNexys4DDRBoard-blue.svg)](https://www.xilinx.com/support/university/boards-portfolio/xup-boards/DigilentNexys4DDR.html)
[![MIT license](https://img.shields.io/badge/license-Apache2.0-e78ac3.svg)](http://www.apache.org/licenses/)

Four versions of MIPS 32bit implemented with Verilog HDL in Vivado HLx. 
There are several files containing hex instructions for each version to run programs.
Simulation files are also implemented.
All versions can be used on Digilent Nexys4 DDR Board.

## MIPS 32bit

The following versions of MIPS 32bit are included:
* monocycle
* multicycle
* pipeline
* pipeline with cache
    - one instruction cache and one data cache

## Prerequisites

* Install [Vivado](https://www.xilinx.com/products/design-tools/vivado.html)
* A [Digilent Nexys4 DDR Board](https://www.xilinx.com/support/university/boards-portfolio/xup-boards/DigilentNexys4DDR.html)

## Usage

### Preparations

* In module `imem()`, there is this line of code for loading hex instructions. Replace `<FILE>` with the actual path of the hex program
```
$readmemh("<FILE>", RAM);
```

* In module `regfile()`, there may be this line of code for resetting the register. Replace `<FILE>` with the actual path of `emptyreg.dat`
```
$readmemh("<FILE>",rf);
```

* When writing file path, use `/` instead of default `\ `!

### Run

* Simulation:
    - just run Simulation
* Nexys4 DDR Board:
    - run Synthesis
    - run Implementation
    - run Generate Bitstream
    - open Hardware Manager
    - connect the board

## Links

* MIPS simulator [QtSpim](https://sourceforge.net/projects/spimsimulator/files/) can run MIPS assembly (32 bit)
* [MIPS Converter](https://www.eg.bucknell.edu/~csci320/mips_web/) converts MIPS assembly into hex code and vice versa
