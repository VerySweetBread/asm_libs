format ELF
public _start

extrn file.open
extrn file.content
extrn file.close
extrn print.str
extrn print.nl
extrn exit


section '.strtab'
filename db "makefile", 0


section '.bss' writeable
file_ rd 1


section '.text' executable
_start:
	push filename
	call file.open
	pop eax
	mov [file_], eax
	
	push dword [file_]
	call print.str
	call print.nl
	call print.nl

	push dword [file_]
	call file.content
	call print.str
	call print.nl

	push dword [file_]
	call file.close

	call exit
