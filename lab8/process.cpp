#include "process.h"
#include "memory.h"
#include "tss.h"
#include "cstdio.h"
#include "cstdlib.h"
#include "thread.h"

extern "C" void sys_start_process(dword esp);
extern "C" dword sys_update_cr3(dword address);

void startProcess(void *filename)
{
    PCB *pcb = (PCB *)_running_thread();
    ThreadInterruptStack *interruptStack = (ThreadInterruptStack *)((dword)pcb->stack + sizeof(ThreadStack));

    interruptStack->edi =
        interruptStack->esi =
            interruptStack->ebp =
                interruptStack->esp_dummy =
                    interruptStack->ebx =
                        interruptStack->ecx =
                            interruptStack->eax =
                                interruptStack->gs = 0;

    interruptStack->fs =
        interruptStack->es =
            interruptStack->ss =
                interruptStack->ds = 0x3b;

    interruptStack->eip = (dword)filename;
    interruptStack->cs = 0x33;                                // 用户模式平坦模式
    interruptStack->eflags = (3 << 12) | (1 << 9) | (1 << 1); // IOPL, IF, MBS
    interruptStack->esp = (dword)specifyPaddrForVaddr(AddressPoolType::USER, USER_STACK_VADDR) + PAGE_SIZE;

    sys_start_process((dword)interruptStack);
}

void activatePageDir(PCB *pcb)
{
    dword paddr = 0x100000; // 内核页目录表物理地址

    if (pcb->pageDir)
    {
        paddr = vaddr2paddr((dword)pcb->pageDir);
    }

    sys_update_cr3(paddr);
}

void activatePageTab(PCB *pcb)
{
    activatePageDir(pcb);

    if (pcb->pageDir)
    {
        tss.updateEsp0(pcb);
    }
}

dword *createPageDir()
{
    dword *vaddr = (dword *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!vaddr)
    {
        //printf("can not create page from kernel\n");
        return nullptr;
    }

    // 复制内核目录项到虚拟地址的高1GB
    dword *src = (dword *)(0xfffff000 + 0x300 * 4);
    dword *dst = (dword *)((dword)vaddr + 0x300 * 4);
    for (int i = 0; i < 256; ++i)
    {
        dst[i] = src[i];
    }

    // 最后一项设置为用户进程页目录表物理地址
    vaddr[1023] = vaddr2paddr((dword)vaddr) | 0x7;
    return vaddr;
}

void createUserVaddrPool(PCB *pcb)
{
    dword sourcesCount = (0xc0000000 - USER_VADDR_START) / PAGE_SIZE;
    dword length = (sourcesCount + 8 - 1) / 8;
    // 计算位图所占的页数
    dword pagesCount = (length + PAGE_SIZE - 1) / PAGE_SIZE;

    void *start = allocatePages(AddressPoolType::KERNEL, pagesCount);
    (pcb->userVaddr).setResources((byte *)start, sourcesCount);
    (pcb->userVaddr).setStartAddress(USER_VADDR_START);
}
dword executeProcess(void *filename, const char *name, dword priority)
{
    PCB *process = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!process)
        return -1;

    memset((byte *)process, 0, PAGE_SIZE);

    process->status = ThreadStatus::READY;
    process->priority = priority;
    process->ticks = priority;
    process->ticksPassedBy = 0;
    process->pageDir = createPageDir();
    createUserVaddrPool(process);
    process->magic = 0x19870916;

    process->stack = (dword *)((dword)process + PAGE_SIZE - sizeof(ThreadInterruptStack) - sizeof(ThreadStack));

    ThreadStack *threadStack = (ThreadStack *)process->stack;
    threadStack->eip = kernelThread;
    threadStack->function = startProcess;
    threadStack->funcArg = filename;
    threadStack->ebp =
        threadStack->ebx =
            threadStack->esi =
                threadStack->edi = 0;

    bool interruptStatus = _interrupt_status();
    _disable_interrupt();
    _all_threads.push_back(&(process->tagInAllList));
    _ready_threads.push_back(&(process->tagInGeneralList));
    _set_interrupt(interruptStatus);

    return process->pid;
}