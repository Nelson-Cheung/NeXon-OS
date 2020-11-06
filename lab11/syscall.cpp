#include "syscall.h"
#include "memory.h"
#include "interrupt.h"
#include "cstdio.h"

void sysInitializeSysCall()
{
    memset((byte *)syscallTable, 0, SYSCALL_AMOUNT * sizeof(void *));
    syscallTable[SYSCALL_FIRST_SYS_CALL] = (void *)sysFirstSysCall;
    syscallTable[SYSCALL_WRITE] = (void *)sysWrite;
    syscallTable[SYSCALL_SCHEDULE_THREAD] = (void *)sysScheduleThread;
    syscallTable[SYSCALL_MALLOC] = (void *)sysMalloc;
    syscallTable[SYSCALL_FREE] = (void *)sysFree;
    syscallTable[SYSCALL_KERNEL_MALLOC] = (void *)sysKernelMalloc;
    syscallTable[SYSCALL_KERNEL_FREE] = (void *)sysKernelFree;
}

void *syscall(dword function, dword ebx, dword ecx,
              dword edx, dword esi, dword edi)
{
    dword eaxTemp, ebxTemp, ecxTemp, edxTemp, esiTemp, ediTemp;

    bool status = _interrupt_status();
    _disable_interrupt();

    eaxTemp = sysGetEax();
    ebxTemp = sysGetEbx();
    ecxTemp = sysGetEcx();
    edxTemp = sysGetEdx();
    esiTemp = sysGetEsi();
    ediTemp = sysGetEdi();

    _set_interrupt(status);

    sysSetEbx(ebx);
    sysSetEcx(ecx);
    sysSetEdx(edx);
    sysSetEsi(esi);
    sysSetEdi(edi);
    sysSetEax(function);

    void *ans = sysStartSysCall();

    status = _interrupt_status();
    _disable_interrupt();
    sysSetEax(eaxTemp);
    sysSetEbx(ebxTemp);
    sysSetEcx(ecxTemp);
    sysSetEdx(edxTemp);
    sysSetEsi(esiTemp);
    sysSetEdi(ediTemp);
    _set_interrupt(status);

    return ans;
}

void sysFirstSysCall()
{
    printf("First System Call!\n");
}

void firstSysCall()
{
    syscall(0);
}

void sysWrite()
{
    const char *ptr = (const char *)sysGetEbx();
    dword index = 0;
    while (ptr[index])
    {
        putchar(ptr[index]);
        ++index;
    }
}

void write(const char *ptr)
{
    syscall(SYSCALL_WRITE, (dword)ptr);
}

void sysScheduleThread()
{
    //printf("Sytem Schedule Thread\n");
    _schedule_thread();
}

void userScheduleThread()
{
    //printf("User Schedule Thread\n");
    PCB *pcb = (PCB *)_running_thread();
    if (pcb->pageDir)
    {
        syscall(SYSCALL_SCHEDULE_THREAD);
    }
    else
    {
        _schedule_thread();
    }
}

void *sysMalloc()
{
    //printf("---sysMalloc---\n");
    dword size = (dword)sysGetEbx();
    PCB *pcb = (PCB *)_running_thread();
    if (pcb->pageDir)
    {
        return pcb->memoryManager.allocate(size);
    }
    else
    {
        return sysMemoryManager.allocate(size);
    }
}
void sysFree()
{

    void *address = (void *)sysGetEbx();
    PCB *pcb = (PCB *)_running_thread();
    if (pcb->pageDir)
    {
        pcb->memoryManager.release(address);
    }
    else
    {
        sysMemoryManager.release(address);
    }
}

void *malloc(dword size)
{
    //mutexForMalloc.P();
    void *ans = syscall(SYSCALL_MALLOC, size);
    //mutexForMalloc.V();
    return ans;
}

void free(void *address)
{
    syscall(SYSCALL_FREE, (dword)address);
}

void *sysKernelMalloc()
{
    dword size = (dword)sysGetEbx();

    bool status = _interrupt_status();
    _disable_interrupt();

    PCB *pcb = (PCB *)_running_thread();
    dword *temp = pcb->pageDir;
    pcb->pageDir = nullptr;

    void *ans = sysMemoryManager.allocate(size);

    pcb->pageDir = temp;

    _set_interrupt(status);
    return ans;
}

void *kernelMalloc(dword size)
{
    void *ans = syscall(SYSCALL_KERNEL_MALLOC, size);
    return ans;
}

void sysKernelFree()
{
    void *address = (void *)sysGetEbx();

    bool status = _interrupt_status();
    _disable_interrupt();

    PCB *pcb = (PCB *)_running_thread();
    dword *temp = pcb->pageDir;
    pcb->pageDir = nullptr;

    sysMemoryManager.release(address);

    pcb->pageDir = temp;
    _set_interrupt(status);
}

void kernelFree(void *address)
{
    syscall(SYSCALL_KERNEL_FREE, (dword)address);
}