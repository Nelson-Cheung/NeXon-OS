#ifndef PROGRAM_MANAGER
#define PROGRAM_MANAGER

#include "../thread.h"
#include "../process.h"

extern "C" void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp);

class ProgramManager
{
public:
    // 内核态的fork
    dword fork();
private:
    // 复制当前进程到一个新进程中，返回进程的PCB
    PCB* copyProcess();

};

ProgramManager sysProgramManager;

#endif