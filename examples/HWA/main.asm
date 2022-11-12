format ELF
public _start

extrn print.int
extrn print.bin
extrn print.str
extrn print.nl
extrn string.parse_int
extrn exit

macro nl {
	call print.nl
}


section '.strtab'
str1 db "Hello world!", 10, 0
str2 db "Enter the number: ", 0
str3 db " + 10 = ", 0


section '.bss' writeable
buffer rb 11


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

	push str2
	call print.str
	mov eax, 3
	mov ebx, 0
	mov ecx, buffer
	mov edx, 11
	int 80h

	mov [buffer+eax-1], 0 

	push buffer
	call print.str
	push str3
	call print.str

	push buffer
	call string.parse_int
	pop eax
	add eax, 10
	push eax
	call print.int
	nl

	call exit
