PROG = LU.com LD.com RU.com RD.com test.com
IMG=../os17338233.img
CFLAGS=-march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel
LDFLAGS=-m elf_i386 -N  -entry main -Ttext 0x100 --oformat binary
CC=gcc

all: output
output: $(PROG)
	dd if=LU.com of=$(IMG) conv=notrunc bs=512 seek=18 count=2 >/dev/null
	dd if=LD.com of=$(IMG) conv=notrunc bs=512 seek=20 count=2 >/dev/null
	dd if=RU.com of=$(IMG) conv=notrunc bs=512 seek=22 count=2 >/dev/null
	dd if=RD.com of=$(IMG) conv=notrunc bs=512 seek=24 count=2 >/dev/null
	dd if=test.com of=$(IMG) conv=notrunc bs=512 seek=26 count=6 >/dev/null

%.com : %.asm
	nasm $< -o $@

test.com: test.o syscall.o mystring.o
	ld $(LDFLAGS) $^ -o $@

%.o : %.asm
	nasm -f elf32 $< -o $@


.PHONY:clean
clean:
	rm *com *o