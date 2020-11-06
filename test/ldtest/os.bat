C:\data\code\vscode\os\gcc\bin\nasm -f elf32 syscall.asm -o syscall.o
C:\data\code\vscode\os\gcc\bin\gcc -march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel   -c -o test.o test.c
C:\data\code\vscode\os\gcc\bin\gcc -march=i386 -m16 -mpreferred-stack-boundary=2 -ffreestanding -fno-PIE -masm=intel   -c -o mystring.o mystring.c
rem C:\data\code\vscode\os\gcc\bin\ld -m elf_i386 -N syscall.o test.o mystring.o -entry main -Ttext -0x100 --oformat binary -o test.com
pause