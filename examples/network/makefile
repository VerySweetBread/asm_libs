all: main

main: ../../std.o ../../string.o ../../network.o ../../dns.o ../../dnstoys.o main.o
	ld -m elf_i386 main.o ../../std.o ../../string.o ../../network.o ../../dns.o  ../../dnstoys.o --output main
	
main.o:
	fasm main.asm

../../std.o:
	make -C ../.. std.o

../../string.o:
	make -C ../.. string.o

../../network.o:
	make -C ../.. network.o

../../dns.o:
	make -C ../.. dns.o

../../dnstoys.o:
	make -C ../.. dnstoys.o
	
clear:
	rm main.o main
