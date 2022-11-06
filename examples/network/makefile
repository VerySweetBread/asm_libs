all: main

main: ../../std.o ../../string.o ../../network.o ../../dns.o ../../dnstoys.o
	fasm main.asm
	ld -m elf_i386 main.o ../../std.o ../../string.o ../../network.o ../../dns.o  ../../dnstoys.o --output main
	
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

