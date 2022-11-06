format ELF
public _start

extrn file.open
extrn file.content
extrn file.close
extrn print.str
extrn print.nl
extrn exit

macro nl {
	call print.nl
}


section '.strtab'
filename db "makefile", 0
error db "An error occurred while opening the file", 0


section '.bss' writeable
file_ rd 1


section '.text' executable
_start:
	push filename
	call file.open
	pop eax

	cmp eax, 0
	jne @f
		push error
		call print.str
		nl
		call exit

	@@:
	mov [file_], eax
	
	push dword [file_]
	call print.str
	nl
	nl

	push dword [file_]
	call file.content
	call print.str
	nl

	push dword [file_]
	call file.close

	call exit
