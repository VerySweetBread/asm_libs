all: std.o string.o file.o path.o network.o dns.o dnstoys.o

std.o:
	fasm src/std.asm std.o

string.o:
	fasm src/string.asm string.o

file.o:
	fasm src/file.asm file.o

path.o:
	fasm src/path.asm path.o

network.o:
	fasm src/network.asm network.o

dns.o:
	fasm src/dns.asm dns.o

dnstoys.o:
	fasm src/dnstoys.asm dnstoys.o

clear:
	rm *.o