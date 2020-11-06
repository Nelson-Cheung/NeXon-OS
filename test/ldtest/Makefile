PROG = LU.com LD.com RU.com RD.com test.com
IMG=../os17338233.img
CFLAGS=-march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel
LDFLAGS=-m elf_i386 -N -entry main -Ttext -0x100 --oformat binary
CC=gcc

all: test.com clean

%.com : %.asm
	nasm $< -o $@

test.com:syscall.o test.o mystring.o 
	ld $(LDFLAGS) $^ -o $@

%.o : %.asm
	nasm -f elf32 $< -o $@


.PHONY:clean
clean:
	rm *com *o