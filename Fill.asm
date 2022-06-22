// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

//check keyboard press, 

(CHECK)
@KBD
D=M
//if no key, we jump to white
@WHITE
D;JEQ

//else we check if screen is already black
(BLACK)
@state
D=M
@CHECK
D;JNE
@state
M=-1
//@CHECK
@FILL
0;JMP

//Check if state changed, if yes go to top, otherwise set state to white and fill.
(WHITE)
@state
D=M
@CHECK
D;JEQ
@state
M=0
@FILL
0;JMP

////////////////////
(FILL)
@SCREEN
D=A
@addr
M=D  //addr = 16384 (screens base address)

@8192
D=A
@n
M=D // n RAM[0]

@i
M=0 // i=0

(LOOP)
@i
D=M
@n
D=D-M

@CHECK
D;JGE // if i>n goto END


//iterate through here to fill entire row
@state
D=M
@addr
A=M
//messing here was m=d
//M=-1 // RAM[addr]=111111111
M=D

@i
M=M+1 // i=i +1
@addr
M=M+1 // addr = addr +32
@LOOP
0;JMP // goto LOOP
