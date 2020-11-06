nasm -f elf32 afile.asm -o afile.o
gcc -march=i386 -m32 -mpreferred-stack-boundary=2 -ffreestanding -c cfile.c -o c.o 
ld.exe -m i386pe -N afile.o c.o -Ttext 0xA100 -o os.tmp
objcopy -O binary os.tmp os.bin