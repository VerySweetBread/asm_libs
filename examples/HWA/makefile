all: main

main: /lib/sbalib.so main.o
	ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 main.o /lib/sbalib.so -o main

main.o:
	fasm main.asm > /dev/null

/lib/sbalib.so:
	make -C ../../

clear:
	rm main.o main
