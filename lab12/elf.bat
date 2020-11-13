chcp 65001
set COMPLIE_TOOL_DIR=C:\data\code\vscode\os\gcc\bin
set RUN_DIR=..\run
cls

echo 编译内核(c++实现的内核代码)
%COMPLIE_TOOL_DIR%\g++.exe -O0 -march=i386 -m32 -c test.cpp -o test.o
pause
echo 链接内核
%COMPLIE_TOOL_DIR%\ld.exe -melf_i386 -N test.o  -Ttext 0x0  --oformat binary -o test.bin