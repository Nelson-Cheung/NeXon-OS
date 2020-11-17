#include "program_manager.h"
#include "../cstdlib.h"
#include "../interrupt.h"
#include "tss.h"

// 用户进程初始化，构建用户进程上下文环境
void startProcess(void *filename)
{
    PCB *pcb = sysProgramManager.running();
    ThreadInterruptStack *interruptStack = (ThreadInterruptStack *)((dword)pcb->stack + sizeof(ThreadStack));

    interruptStack->edi = 0;
    interruptStack->esi = 0;
    interruptStack->ebp = 0;
    interruptStack->esp_dummy = 0;
    interruptStack->ebx = 0;
    interruptStack->ecx = 0;
    interruptStack->eax = 0;
    interruptStack->gs = 0;

    interruptStack->fs = 0x3b;
    interruptStack->es = 0x3b;
    interruptStack->ss = 0x3b;
    interruptStack->ds = 0x3b;

    interruptStack->eip = (dword)filename;
    interruptStack->cs = 0x33;                                // 用户模式平坦模式
    interruptStack->eflags = (3 << 12) | (1 << 9) | (1 << 1); // IOPL, IF, MBS
    interruptStack->esp = (dword)specifyPaddrForVaddr(AddressPoolType::USER, USER_STACK_VADDR) + PAGE_SIZE;

    sys_start_process((dword)interruptStack);
}

// 激活线程或进程页目录表
void ProgramManager::activatePageDir(PCB *program)
{
    dword paddr = 0x100000; // 内核页目录表物理地址

    if (program->pageDir)
    {
        paddr = vaddr2paddr((dword)program->pageDir);
    }

    sys_update_cr3(paddr);
}

// 激活线程或进程页表
void ProgramManager::activatePageTab(PCB *program)
{
    activatePageDir(program);

    if (program->pageDir)
    {
        tss.updateEsp0(program);
    }
}

// 创建用户进程的页目录表
dword *ProgramManager::createPageDir()
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

// 创建用户虚拟地址池
void ProgramManager::createUserVaddrPool(PCB *pcb)
{
    dword sourcesCount = (0xc0000000 - USER_VADDR_START) / PAGE_SIZE;
    dword length = (sourcesCount + 8 - 1) / 8;
    // 计算位图所占的页数
    dword pagesCount = (length + PAGE_SIZE - 1) / PAGE_SIZE;

    void *start = allocatePages(AddressPoolType::KERNEL, pagesCount);
    (pcb->userVaddr).setResources((byte *)start, sourcesCount);
    (pcb->userVaddr).setStartAddress(USER_VADDR_START);
}

// 创建用户进程
dword ProgramManager::executeProcess(void *filename, const char *name, dword priority)
{
    PCB *process = buildThreadPCB(nullptr, nullptr, name, priority);
    // 创建进程特定部分

    // 创建页目录表
    process->pageDir = createPageDir();
    //创建用户地址池
    createUserVaddrPool(process);

    ThreadStack *threadStack = (ThreadStack *)process->stack;
    threadStack->eip = (dword)startProcess;
    threadStack->arg = filename;

    process->memoryManager.initialize();

    bool interruptStatus = _interrupt_status();
    _disable_interrupt();
    allPrograms.push_back(&(process->tagInAllList));
    readyPrograms.push_back(&(process->tagInGeneralList));
    _set_interrupt(interruptStatus);

    return process->pid;
}

PCB *ProgramManager::findChildProcess(dword parentPid) {
    ThreadListItem *item = allPrograms.head.next;
    PCB *child, *ans;

    ans = nullptr;

    bool status = _interrupt_status();
    _disable_interrupt();
    while(item) {
        child = threadListItem2PCB(item);
        if(child->parentPid == parentPid) {
            ans = child;
            break;
        }
    }
    _set_interrupt(status);

    return ans;
}