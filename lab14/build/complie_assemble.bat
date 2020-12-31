chcp 65001
set COMPLIE_TOOL_DIR=..\..\gcc\bin
set RUN_DIR=..\..\run
set SRC_DIR=..
cls

 echo 编译MBR
 %COMPLIE_TOOL_DIR%\nasm.exe -f bin %SRC_DIR%\boot\mbr.asm -o mbr.bin
 pause

 echo 写入MBR
 %COMPLIE_TOOL_DIR%\dd.exe if=mbr.bin of=%RUN_DIR%\hd.img.backup bs=512 seek=0 conv=notrunc
 pause

 cls
 echo 编译loader
 %COMPLIE_TOOL_DIR%\nasm.exe -f bin %SRC_DIR%\boot\loader.asm -o loader.bin
 pause

 echo 写入loader
 %COMPLIE_TOOL_DIR%\dd.exe if=loader.bin of=%RUN_DIR%\hd.img.backup bs=512 count=5 seek=1 conv=notrunc
 pause

 cls
 echo 编译内核(汇编实现的内核代码)
 %COMPLIE_TOOL_DIR%\nasm.exe -f elf32 %SRC_DIR%\boot\kernel.asm -o kernel_asm.o
 pause

