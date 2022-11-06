format ELF
public get_ip       as 'network.get_ip'
public IP_to_str    as 'network.IP_to_str'

include '../include/_macros.inc'
include '../include/_dns.inc'
extrn dns.send
extrn dns.get_field
extrn string.len

section '.bss' writeable
IP_str		rb 19
DNS_server sockaddr 00,53, 8,8,8,8
response	rb 200

section '.network.text' executable
get_ip:
    prelude

	push dword 200
	push response
    push DNS_server
	push dword [ebp+2*4]
	call dns.send
	push response
	push dword 0
	call dns.get_field
	pop eax
	push eax
	call string.len
	pop ebx
	add eax, ebx  
	cmp ebx, 2
	je @f
		inc eax
	@@:
	add eax, 2*3+4
	
    mov [ebp+2*4], eax
	postlude
    ret

IP_to_str:
    prelude

    mov ecx, [ebp+2*4]

	xor ebx, ebx
	mov esi, IP_str

	.loop:
		mov al, [ecx+ebx]
		push 10

		.smloop:
			cmp ax, 10
			jnl @f
			push eax
			jmp .smbr
		
		@@:
			mov edx, 10
			div dl
			mov dl, ah
			push edx
			xor ah, ah

			jmp .smloop
		.smbr:
			pop eax
			cmp al, byte 10
			je .smbrbr

			add al, '0'
			mov [esi], al
			inc esi
			jmp .smbr
		.smbrbr:
			inc ebx
			cmp ebx, 4
			je .break
			mov [esi], byte '.'
			inc esi
			jmp .loop
	  .break:
		  mov [esi], byte 0

    mov [ebp+2*4], dword IP_str
	postlude
	ret