IMG = test.img
CFLAGS=-march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel
LDFLAGS=-m elf_i386 -N  -Ttext 0x7c00 --oformat binary  
CC=gcc

all :testimg  clean

testimg: boot.bin 
	dd if=boot.bin of=test.img bs=512 count=1 seek=0 conv=notrunc 

boot.bin : Timer.asm
	nasm  $< -o $@



.PHONY:clean
clean:
	rm -rf *bin *o