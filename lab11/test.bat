chcp 65001
set COMPLIE_TOOL_DIR=C:\data\code\vscode\os\gcc\bin
set RUN_DIR=..\run
cls

rem echo 编译MBR
rem %COMPLIE_TOOL_DIR%\nasm.exe -f bin mbr.asm -o mbr.bin
rem pause

rem echo 写入MBR
rem %COMPLIE_TOOL_DIR%\dd.exe if=mbr.bin of=%RUN_DIR%/hd.img bs=512 seek=0 conv=notrunc
rem pause

rem cls
rem echo 编译loader
rem %COMPLIE_TOOL_DIR%\nasm.exe -f bin loader.asm -o loader.bin
rem pause

rem echo 写入loader
rem %COMPLIE_TOOL_DIR%\dd.exe if=loader.bin of=%RUN_DIR%/hd.img bs=512 count=5 seek=1 conv=notrunc
rem pause

rem cls
rem echo 编译内核(汇编实现的内核代码)
rem %COMPLIE_TOOL_DIR%\nasm.exe -f elf32 kernel.asm -o kernel_asm.o
rem pause
echo 编译内核(c++实现的内核代码)
%COMPLIE_TOOL_DIR%\g++.exe -O0 -march=i386 -m32 -c kernel.cpp -o kernel.o
pause
echo 链接内核
%COMPLIE_TOOL_DIR%\ld.exe -melf_i386 -N kernel_asm.o kernel.o -Ttext 0xc0020000  --oformat binary -o kernel.bin
echo 写入内核
%COMPLIE_TOOL_DIR%\dd.exe if=kernel.bin of=%RUN_DIR%\hd.img bs=512 count=95 seek=6 conv=notrunc
pause

cls
%RUN_DIR%\bochsdbg.exe -f %RUN_DIR%\bochsrc.bxrc