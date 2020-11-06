chcp 65001
set COMPLIE_TOOL_DIR=%cd%/toolkit


rem C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin mbr.asm -o mbr.bin
rem pause
rem C:\data\code\vscode\os\dd.exe if=mbr.bin of=../run/hd.img bs=512 seek=0 conv=notrunc
rem pause
rem C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin loader.asm -o loader.bin
rem pause
rem C:\data\code\vscode\os\dd.exe if=loader.bin of=../run/hd.img bs=512 count=5 seek=1 conv=notrunc
rem pause
rem C:\data\code\vscode\os\gcc\bin\nasm.exe -f elf32 kernel.asm -o kernel_asm.o
rem pause
C:\data\code\vscode\os\gcc\bin\g++.exe -O0 -march=i386 -m32 -c kernel.cpp -o kernel.o
pause
C:\data\code\vscode\os\gcc\bin\ld.exe -melf_i386 -N kernel_asm.o kernel.o -Ttext 0xc0020000  --oformat binary -o kernel.bin
C:\data\code\vscode\os\dd.exe if=kernel.bin of=..\run\hd.img bs=512 count=95 seek=6 conv=notrunc
pause