format ELF
public _start

extrn print.int
extrn print.bin
extrn print.str
extrn print.nl
extrn exit

macro nl {
	call print.nl
}


section '.strtab'
str1 db "Hello world!", 0


section '.text' executable
_start:
	push dword 123
	call print.int
	nl

	push dword 123
	call print.bin
	nl

	push str1
	call print.str
	nl

	call exit
