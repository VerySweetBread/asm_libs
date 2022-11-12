format ELF
public copy 		as 'string.copy'
public len  		as 'string.len'
public parse_int	as 'string.parse_int'

include "../include/_macros.inc"

section '.string.text' executable
copy:
	prelude

	mov eax, [ebp+3*4]
	mov ebx, [ebp+2*4]
	xor ecx, ecx	  

	.loop:
		cmp [eax+ecx], byte 0
		je .break

		mov dl, [eax+ecx]
		mov [ebx+ecx], dl
		inc ecx
		
		jmp .loop
	.break:
		mov eax, [ebp+4]
		mov [ebp+3*4], eax
		postlude
		add esp, 4*2
		ret

len:
	prelude

	mov eax, [ebp+2*4]
	xor ebx, ebx

	.loop:
		cmp [eax+ebx], byte 0
		je .break

		inc ebx
		jmp .loop
	.break:
		mov [ebp+2*4], ebx
		postlude
		ret

parse_int:
	prelude

	mov eax, [ebp+4*2]
	xor ebx, ebx
	mov ecx, 1
	push word 10

	@@:
		cmp [eax], byte '0'
		jl @f
		cmp [eax], byte '9'
		ja @f

		mov bl, [eax]
		sub bl, '0'
		push bx
		inc eax
		jmp @b
	@@:
		xor eax, eax
		mov ecx, 1
	@@:
		pop bx

		cmp bx, 10
		je @f

		imul ebx, ecx
		imul ecx, 10
		add eax, ebx
		jmp @b
	@@:
		mov [ebp+4*2], eax
		postlude
		ret
