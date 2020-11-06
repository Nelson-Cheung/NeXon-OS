IMG = os17338233.img
INFO = myos1.bin 
KERNEL = kernel.bin
CFLAGS=-march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel
LDFLAGS=-m elf_i386 -N  -entry _start -Ttext 0x8100 --oformat binary
CC=gcc

all :img usrprog clean

testimg: 
	cd test && $(MAKE)	

img:$(INFO) $(KERNEL)
	dd if=myos1.bin of=$(IMG) conv=notrunc bs=512 count=1
	dd if=kernel.bin of=$(IMG) conv=notrunc bs=512 seek=1 count=16
	
usrprog:
	cd usrprogram && $(MAKE)	

myos1.bin: myos1.asm
	nasm  $< -o $@

kernel.bin: kernel.o main.o lib.o Timer.o process.o
	ld $(LDFLAGS) $^ -o $@

%.o : %.asm
	nasm -f elf32 $< -o $@

.PHONY:clean
clean:
	find . -regex '.*\.o\|.*\.bin'  | xargs rm -f


