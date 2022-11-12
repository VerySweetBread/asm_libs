all: main

main: ../../std.o ../../string.o main.o
	ld -m elf_i386 main.o ../../std.o ../../string.o --output main

main.o:
	fasm main.asm

../../std.o:
	make -C ../../ std.o

../../string.o:
	make -C ../../ string.o

clear:
	rm main.o main
