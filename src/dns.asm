format ELF
public send 		as 'dns.send'
public get_field 	as 'dns.get_field'

include '../include/_macros.inc'
include '../include/_dns.inc'
extrn string.len


section '.strtab' 
random_filename db "/dev/random", 0


section '.bss' writeable
sock_fd		rd 1
request_len rw 1

DNS_request dnsreq 
DNS_server sockaddr 00,53, 8,8,8,8


section '.dns.text' executable
send:
	prelude

	; open
	mov eax, 5
	mov ebx, random_filename
	mov ecx, 0
	mov edx, 0
	int 80h

	push eax

	; read
	mov ebx, eax
	mov eax, 3
	mov ecx, ID
	mov edx, 2
	int 80h

	; close
	mov eax, 6
	pop ebx
	int 80h

	mov eax, [ebp+2*4]
	mov ecx, DNS_question

	.bigloop:
		xor ebx, ebx

		.small0loop:
			cmp [eax+ebx], byte '.'
			je .small0break
			cmp [eax+ebx], byte 0
			je .small0break

			inc ebx
			jmp .small0loop
	.small0break:
		mov [ecx], ebx
		inc ecx

		xor ebx, ebx

		.small1loop:
			cmp [eax], byte '.'
			je .small1break
			cmp [eax], byte 0
			je .bigbreak
		
			mov bl, [eax]
			mov [ecx], bl
			inc ecx
			inc eax

			jmp .small1loop
	.small1break:
		inc eax
		jmp .bigloop
	
	.bigbreak:
	
	mov [ecx],		byte 0
	mov [ecx+1], 	dword 01000100h

	add ecx, 5
	sub ecx, DNS_request
	mov [request_len], cx

	; socket
	mov eax, 167h
	mov ebx, AF_INET
	mov ecx, SOCK_DGRAM
	mov edx, IPPROTO_IP
	int 80h

	mov [sock_fd], eax
	
	; sendto
	mov eax, 369
	mov ebx, [sock_fd]
	mov ecx, DNS_request
	xor edx, edx
	mov  dx, [request_len]
	mov esi, flags
	mov edi, [ebp+3*4]
	push ebp
	mov ebp, 16
	int 80h
	pop ebp

	; read
	mov eax, 3
	mov ebx, [sock_fd]
	mov ecx, [ebp+4*4]
	mov edx, [ebp+5*4]
	int 80h

	; close
	mov eax, 6
	mov ebx, [sock_fd]
	int 80h

	mov eax, [ebp+4]
	mov [ebp+5*4], eax
	postlude
	add esp, 4*4
	ret

get_field:
	prelude

	mov eax, [ebp+3*4]
	mov bx , [ebp+2*4]
	mov ch , [eax+2*2]
	mov cl , [eax+2*2+1]
	cmp bx, cx
	jl @f
		mov [ebp+3*4], dword 0
		mov eax, [ebp+4]
		mov [ebp+2*4], eax
		postlude
		add esp, 4
		ret
@@:
	add eax, 3*4
	mov bh , [eax-8]
	mov bl , [eax-7]
	@@:
		dec bx
		push eax
		call string.len
		pop ecx
		add eax, ecx
		cmp ecx, 2
		je .a
			inc eax
		.a:
		add eax, 2*2

		cmp bx , 0
		je @f
		jmp @b
	@@:
		cmp word [ebp+2*4], 0
		je @f 

		push eax
		call string.len
		pop ecx
		add eax, ecx
		cmp ecx, 2
		je .b
			inc eax
		.b:
		add eax, 2*2+4
		xor ebx, ebx
		mov bx , [eax]
		add eax, ebx

		inc word [ebp+2*4]
		jmp @b
	@@:
	mov [ebp+3*4], eax
	mov eax, [ebp+4]
	mov [ebp+2*4], eax
	postlude
	add esp, 4
	ret
