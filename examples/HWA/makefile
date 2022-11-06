all: main

main: ../../std.o main.o
	ld -m elf_i386 main.o ../../std.o --output main

main.o:
	fasm main.asm

../../std.o:
	make -C ../../ std.o

clear:
	rm main.o main
