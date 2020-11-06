C:\data\code\vscode\os\gcc\bin\g++.exe -O0 -march=i386 -m32 -c shell.c
pause
C:\data\code\vscode\os\gcc\bin\g++.exe -march=i386 -m32 -S shell.c
pause
C:\data\code\vscode\os\gcc\bin\nasm.exe -f elf32 core.asm -o core.o
pause
C:\data\code\vscode\os\gcc\bin\ld.exe -melf_i386 -N core.o shell.o -Ttext 0x000  --oformat binary -o core.bin
wrap.exe core.bin
C:\data\code\vscode\os\dd.exe if=core.bin of=hd.img bs=512 seek=81 conv=notrunc
pause

C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin lu.asm -o lu.bin
wrap.exe lu.bin
C:\data\code\vscode\os\dd.exe if=lu.bin of=hd.img bs=512 seek=1081 conv=notrunc
pause

C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin ru.asm -o ru.bin
wrap.exe ru.bin
C:\data\code\vscode\os\dd.exe if=ru.bin of=hd.img bs=512 seek=1083 conv=notrunc
pause

C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin ld.asm -o ld.bin
wrap.exe ld.bin
C:\data\code\vscode\os\dd.exe if=ld.bin of=hd.img bs=512 seek=1085 conv=notrunc
pause

C:\data\code\vscode\os\gcc\bin\nasm.exe -f bin rd.asm -o rd.bin
wrap.exe rd.bin
C:\data\code\vscode\os\dd.exe if=rd.bin of=hd.img bs=512 seek=1087 conv=notrunc
pause

