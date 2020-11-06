C:\data\code\vscode\os\gcc\bin\g++.exe -O0 -march=i386 -m32 -c shell.c
pause
C:\data\code\vscode\os\gcc\bin\g++.exe -O0 -march=i386 -m32 -S shell.c
pause
C:\data\code\vscode\os\gcc\bin\nasm.exe -f elf32 core.asm -o core.o
pause
C:\data\code\vscode\os\gcc\bin\ld.exe -melf_i386 -N core.o shell.o -Ttext 0x000  --oformat binary -o core.bin
wrap.exe core.bin
C:\data\code\vscode\os\dd.exe if=core.bin of=hd.img bs=512 seek=81 conv=notrunc
pause
