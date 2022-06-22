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

//Poll kbd register for input, 

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

//8192 size of the screen buffer
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
//grab value from state 0 = white -1 = black
@state
D=M
@addr
A=M
//copy state value (black or white) ino 16 bit screen buffer chunk
M=D
//repeat for entire screen
@i
M=M+1 // i=i +1
@addr
M=M+1 // addr = addr +32
//End of program
@LOOP
0;JMP // goto LOOP
