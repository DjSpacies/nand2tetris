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
//if no key, we jump
@WHITE
D;JEQ
//else we set state to black
(BLACK)
@state
M=-1
@CHECK
0;JMP
//set state to white
(WHITE)
@state
//should be 0
M=0
@CHECK
0;JMP


//if key keybd > 0 & state = white
//JMP fill black
//else if keybd = 0 & state = black; JMP FILLWHITE
//JMP CHECK

//(FILLBLACK)
//fill black
//set state register to black
//JMP CHECK
