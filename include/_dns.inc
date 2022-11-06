AF_INET		equ 2
SOCK_STREAM	equ 80001h
SOCK_DGRAM	equ 2
IPPROTO_TCP	equ 6
IPPROTO_UDP	equ 17
IPPROTO_IP	equ 0
SOL_TCP 	equ 6
SOL_UDP		equ 17
TCP_NODELAY	equ 1
FIODIO		equ 4
flags 		equ 0

TYPE_A		equ 1
TYPE_NS		equ 2
MD			equ 3 
MF          equ 4 
CNAME       equ 5
SOA         equ 6
MB          equ 7
MG          equ 8 
MR          equ 9 
NULL        equ 10 
WKS         equ 11 
PTR         equ 12
HINFO       equ 13
MINFO       equ 14
MX          equ 15 
TXT         equ 16 

opt_val		equ 1
opt_len		equ 4

struc sockaddr port0, port1, ip0, ip1, ip2, ip3{
	.sa_family	dw AF_INET
	.sa_data 	db port0, port1, ip0, ip1, ip2, ip3
}

struc dnsreq {
	DNS_header:
		ID		rb 2
		params	db 01h, 00h
		QDCOUNT	db 00h, 01h
		ANCOUNT	rb 2
		NSCOUNT rb 2
		ARCOUNT	rb 2
	DNS_question rb 256
}