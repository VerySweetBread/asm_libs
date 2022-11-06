format ELF
public _start

extrn network.IP_to_str
extrn network.get_ip
extrn dnstoys.myip
extrn print.str
extrn print.nl
extrn exit


section '.strtab'
hostname db "google.com", 0


section '.text' executable
_start:
	call dnstoys.myip
	call print.str
	call print.nl

	push hostname
	call network.get_ip
	call network.IP_to_str
	call print.str
	call print.nl

	call exit
