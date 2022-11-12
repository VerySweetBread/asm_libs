format ELF
public myip as 'dnstoys.myip'

include '../include/_macros.inc'
include '../include/_dns.inc'
extrn network.get_ip
extrn dns.send
extrn dns.get_field
extrn string.len

section '.strtab'
dnstoys db "dns.toys", 0

endpoints:
	.ip db "ip", 0

section '.bss' writeable
response rb 200
DNS_server sockaddr 00,53, ?,?,?,?
DNS_request dnsreq

section '.dnstoys.text' executable
myip:
	push 0
	prelude

	push dnstoys
	call network.get_ip
	pop eax
	mov eax, [eax]
	mov [DNS_server+4], eax

	push dword 200
	push response
	push DNS_server
	push endpoints.ip
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
	add eax, 2*3+4+1
	
	mov ebx, [ebp+2*4]
	mov [ebp+4], ebx
	mov [ebp+2*4], eax
	postlude
	ret
