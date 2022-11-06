all: main

main: ../../std.o
	fasm main.asm
	ld -m elf_i386 main.o ../../std.o --output main

../../std.o:
	make -C ../../ std.o

clear:
	rm main.o main
