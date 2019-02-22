# mips-32bit

## todo list

* unpack all the programs
* readme!!!

## Usage

synthesis -> implementation -> generate bitstream -> hardware manager -> nexys board



when writing address use '/' instead of '\' (default)!

in module imem(), change the file path
```
$readmemh("memfile.dat", RAM);
```
into actual hex code file that you want to run
(in components/imem, monocycle this is for loading instructions)


in module dmem(), change the file path
```
$readmemh("emptyRAM.dat",RAM);
```
(in monocycle, this is for setting the dmem 0)

in module regfile(), change the file path
```
$readmemh("emptyreg.dat",rf);
```
(in monocycle, this is for setting the regfile 0)


v2015.4 and older
successful v2018.1

check if it succeeds?
Nexys board
simulation
testbench (check if the result is correct)


## Submission

* address: ftp://10.222.98.96:2121
* username/password: ics/ics

## multicycle

* why do we need multicycle? because of the cost!

## Links

* MIPS simulator [QtSpim](https://sourceforge.net/projects/spimsimulator/files/) can run MIPS assembly (32 bit)
* [MIPS Converter](https://www.eg.bucknell.edu/~csci320/mips_web/) converts MIPS assembly into hex code and vice versa
