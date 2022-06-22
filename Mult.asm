// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

//for (i in R0; i>0 i--;){
//	R2 = R2 + R1}

// Initialization set Result to 0
@R2
M=0
// Get first number, check if 0, =0 END, >0 continue
(LOOP)
@R0
D=M
@END
D;JEQ
//Grab R1, add to R2(total)
@R1
D=M
@R2
M=D+M
//decrement R0
@R0
M=M-1
@LOOP
0;JMP
//end of prog
(END)
@END
0;JMP
