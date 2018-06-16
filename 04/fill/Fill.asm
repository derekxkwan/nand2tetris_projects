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

//3  will be our indexer for screen, 4 is actual address, 5 is color
//256 * 512 pixels / 16 bits = 8192 16 bit words
//so pixels go from SCREEN to SCREEN + 8191
	
(INIT)
	@8191 //reset indexer
	D=A
	@3
	M=D

(READ)
	@SCREEN //calc address
	D=A
	@3
	D=D+M
	@4 //store address
	M=D
	@24576 //get keyboard
	D=M
	@WHITE
	D;JEQ //key not depressed, should be white
	@5
	M=-1 //if not, key depressed, should be black
	@PAINT
	0;JMP
(WHITE)
	@5
	M=0
(PAINT)
	@5
	D=M //get color
	@4 //get address
	A=M
	M=D //paint color
	@3
	MD=M-1 //decrement indexer and store in D as well
	@INIT
	D;JLT //should init if less than 0
	@READ
	0;JMP //or else jump to read
