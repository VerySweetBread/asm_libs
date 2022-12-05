all: $(patsubst src/%.asm,%.o, $(wildcard src/*))
	ld -m elf_i386 -shared *.o -o sbalib.so
	cp sbalib.so /lib/

%.o:
	fasm $(patsubst %.o,src/%.asm,$@) $@ 		> /dev/null

clear:
	rm *.o sbalib.so