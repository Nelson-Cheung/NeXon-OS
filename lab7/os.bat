rem C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin mbr.asm -o mbr.bin
rem pause
rem C:\data\code\vscode\os\dd.exe if=mbr.bin of=hd.img bs=512 seek=0 conv=notrunc
rem pause
rem C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin loader.asm -o loader.bin
rem pause
rem C:\data\code\vscode\os\dd.exe if=loader.bin of=hd.img bs=512 count=5 seek=81 conv=notrunc
rem pause
 C:\data\code\vscode\os\gcc\bin\nasm.exe -f elf32 kernel.asm -o kernel_asm.o
 pause
C:\data\code\vscode\os\gcc\bin\g++.exe -O0 -march=i386 -m32 -c kernel.cpp
pause
C:\data\code\vscode\os\gcc\bin\g++.exe -O0 -march=i386 -m32 -S kernel.cpp
pause
C:\data\code\vscode\os\gcc\bin\ld.exe -melf_i386 -N kernel_asm.o kernel.o -Ttext 0x20000  --oformat binary -o kernel.bin
pause
C:\data\code\vscode\os\dd.exe if=kernel.bin of=hd.img bs=512 count=100 seek=86 conv=notrunc
pause