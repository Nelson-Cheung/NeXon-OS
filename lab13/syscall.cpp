#include "syscall.h"
#include "memory/memory.h"
#include "interrupt.h"
#include "cstdio.h"
#include "cstdlib.h"
#include "program/program_manager.h"

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
    syscallTable[SYSCALL_FORK] = (void *)sysFork;
    syscallTable[SYSCALL_EXIT] = (void *)sysExit;
    syscallTable[SYSCALL_WAIT] = (void *)sysWait;
    syscallTable[SYSCALL_MOVE_CURSOR] = (void *)sysMoveCursor;
    syscallTable[SYSCALL_PUT_CHAR] = (void *)sysPutc;
    syscallTable[SYSCALL_GET_CHAR] = (void *)sysGetc;
    syscallTable[SYSCALL_GET_CURSOR] = (void *)sysGetCursor;
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
    sysProgramManager.schedule();
}

void userScheduleThread()
{
    
    PCB *pcb = sysProgramManager.running();
    //printf("user schedule thread: %x, %d\n", pcb, pcb->pageDir);
    if (pcb->pageDir)
    {
        syscall(SYSCALL_SCHEDULE_THREAD);
    }
    else
    {
        sysProgramManager.schedule();
    }
}

void *sysMalloc()
{
    //printf("---sysMalloc---\n");
    dword size = (dword)sysGetEbx();
    PCB *pcb = sysProgramManager.running();
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
    PCB *pcb = sysProgramManager.running();
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

    PCB *pcb = sysProgramManager.running();
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

    PCB *pcb = sysProgramManager.running();
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

dword fork() {

    return (dword)syscall(SYSCALL_FORK);
}

dword sysFork() {
    return sysProgramManager.fork();
}

void exit(dword status) {
    syscall(SYSCALL_EXIT, status);
}

dword wait(dword *sstatus) {
    return (dword)syscall(SYSCALL_WAIT, (dword)sstatus);
}

dword sysWait(dword *sstatus) {
    return sysProgramManager.wait(sstatus);
}

void moveCursor(dword pos) {
    syscall(SYSCALL_MOVE_CURSOR, pos);
}

void sysMoveCursor(dword pos) {
    MoveCursor(pos);
}

void putc(byte c) {
    syscall(SYSCALL_PUT_CHAR, c);
}

void sysPutc(byte c) {
    putchar(c);
}

byte getc() {
    return (dword)syscall(SYSCALL_GET_CHAR);
}

dword getCursor() {
    return (dword)syscall(SYSCALL_GET_CURSOR);
}

dword sysGetCursor() {
    return GetCursor();
}