chcp 65001
set COMPLIE_TOOL_DIR=C:\data\code\vscode\os\gcc\bin
set RUN_DIR=..\run
cls

cd ..\run
start %RUN_DIR%\rollback.bat
cd ..\lab11

echo 编译内核(c++实现的内核代码)
%COMPLIE_TOOL_DIR%\g++.exe -O0 -march=i386 -m32 -c kernel.cpp -o kernel.o
pause
echo 链接内核
%COMPLIE_TOOL_DIR%\ld.exe -melf_i386 -N kernel_asm.o kernel.o -Ttext 0xc0020000  --oformat binary -o kernel.bin

echo 写入内核
%COMPLIE_TOOL_DIR%\dd.exe if=kernel.bin of=%RUN_DIR%\hd.img bs=512 count=95 seek=6 conv=notrunc
pause

cls
%RUN_DIR%\bochsdbg.exe -f C:\Users\NelsonCheung\Desktop\项目\NeXon\run\bochsrc.bxrc
exit