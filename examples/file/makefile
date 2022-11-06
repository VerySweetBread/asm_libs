all: main

main: ../../file.o ../../std.o ../../path.o ../../string.o
	fasm main.asm
	ld -m elf_i386 main.o ../../file.o ../../std.o ../../path.o --output main

../../std.o:
	make -C ../.. std.o

../../file.o:
	make -C ../.. file.o

../../path.o:
	make -C ../.. path.o

../../string.o:
	make -C ../.. string.o

clear:
	rm main.o main
