#include "program_manager.h"
#include "../cstdlib.h"
#include "../syscall.h"
#include "../math.h"
#include "../interrupt.h"
#include "../panic.h"
#include "program_configure.h"

// 初始化
void ProgramManager::initialize()
{
    // 最后线程的跳转由内核完成
    currentRunning = nullptr;
    allPrograms.initialize();
    readyPrograms.initialize();
}

// 线程调度
void ProgramManager::schedule()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    // 只剩下一个线程/进程
    if (allPrograms.find(&(currentRunning->tagInAllList)) == -1)
        return;


    if (currentRunning->status == ThreadStatus::RUNNING)
    {
        currentRunning->status = ThreadStatus::READY;
        currentRunning->ticks = currentRunning->priority;
        readyPrograms.push_back(&(currentRunning->tagInGeneralList));
        //printf("schedule %x\n", currentRunning);
    }
    else
    {
    }

    ThreadListItem *item = readyPrograms.front();
    PCB *next = (PCB *)(((dword)item) & 0xfffff000);
    PCB *cur = currentRunning;
    next->status = ThreadStatus::RUNNING;
    currentRunning = next;

    readyPrograms.pop_front();

    //activatePageTab(next);

    _switch_thread_to(cur, next);
    _enable_interrupt();
}

// 阻塞当前线程
void ProgramManager::block()
{
    currentRunning->status = ThreadStatus::BLOCKED;
    schedule();
}

// 唤醒线程
void ProgramManager::wakeUp(PCB *program)
{
    program->status = ThreadStatus::READY;
    readyPrograms.push_front(&(program->tagInGeneralList));
}

// 正在执行的线程/进程的pcb
PCB *ProgramManager::running()
{
    return currentRunning;
}

dword ProgramManager::executeThread(ThreadFunction func, void *arg, const char *name, byte priority)
{
    PCB *thread = buildThreadPCB(func, arg, name, priority);
    
    if (!thread)
        return -1;

    // 加入线程队列
    bool interruptStatus = _interrupt_status();
    _disable_interrupt();
    allPrograms.push_back(&(thread->tagInAllList));
    readyPrograms.push_back(&(thread->tagInGeneralList));
    _set_interrupt(interruptStatus);

    return thread->pid;
}

// 找到一个可用的pid
dword ProgramManager::allocatePid()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    // 0号线程
    if(allPrograms.empty()) return 0;

    dword pid = -1;
    PCB *program;

    for (int i = 0; i < MAX_PROGRAM_AMOUNT; ++i)
    {
        program = findProgramByPid(i);
        if (!program)
        {
            pid = i;
            break;
        }
    }

    _set_interrupt(status);

    return pid;
}

PCB *ProgramManager::findProgramByPid(dword pid)
{
    bool status = _interrupt_status();
    _disable_interrupt();

    ThreadListItem *item = allPrograms.head.next;
    PCB *program, *ans;

    ans = nullptr;
    while (item)
    {
        
        program = (PCB *)(((dword)item) & 0xfffff000);
        //printf("find pid: %d\n", program->pid);
        if (program->pid == pid)
        {
            ans = program;
            break;
        }
        item = item->next;
    }

    _set_interrupt(status);

    return ans;
}

// 创建一个线程的PCB并返回
PCB *ProgramManager::buildThreadPCB(ThreadFunction func, void *arg, const char *name, byte priority)
{
    PCB *thread = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!thread)
        return nullptr;

    memset((byte *)thread, 0, PAGE_SIZE);

    for (int i = 0; i < MAX_PROGRAM_NAME && name[i]; ++i)
    {
        (thread->name)[i] = name[i];
    }

    thread->status = ThreadStatus::READY;
    thread->priority = priority;
    thread->ticks = priority;
    thread->ticksPassedBy = 0;
    thread->pageDir = nullptr;

    /*
    // 初始化文件描述符数组
    for (dword i = 0; i < MAX_FILE_OPEN_PER_PROCESS; ++i)
    {
        if (i < 3)
        {
            // 预留三个标准输入流，标准输出流，标准错误流
            thread->fileDescriptors[i] = i;
        }
        else
        {
            thread->fileDescriptors[i] = -1;
        }
    }
*/

    thread->pid = allocatePid();
    if (thread->pid == -1)
    {
        // 释放前面分配的资源
        releaseKernelPage((dword)thread, 1);
        return nullptr;
    }

    thread->stack = (dword *)((dword)thread + PAGE_SIZE - sizeof(ThreadInterruptStack) - sizeof(ThreadStack));

    ThreadStack *threadStack = (ThreadStack *)thread->stack;
    threadStack->eip = (dword)func;
    threadStack->ret = (dword)sysExit; // kernelThread返回地址
    threadStack->arg = arg;
    threadStack->ebp = 0;
    threadStack->ebx = 0;
    threadStack->esi = 0;
    threadStack->edi = 0;

    return thread;
}

// void ProgramManager::activatePageDir(PCB *pcb)
// {
//     dword paddr = 0x100000; // 内核页目录表物理地址

//     if (pcb->pageDir)
//     {
//         paddr = vaddr2paddr((dword)pcb->pageDir);
//     }

//     sys_update_cr3(paddr);
// }

// void ProgramManager::activatePageTab(PCB *pcb)
// {
//     activatePageDir(pcb);

//     if (pcb->pageDir)
//     {
//         tss.updateEsp0(pcb);
//     }
// }

// dword ProgramManager::fork()
// {
//     // 禁止内核线程调用
//     PCB *parent = (PCB *)_running_thread();
//     if (!parent->pageDir)
//         return false;

//     PCB *child = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
//     if (!child)
//         return false;

//     // sys_fork_entry的作用是冻结parent的栈内容和指针
//     sys_fork_entry(parent, child);

//     parent->pid = 0;
//     child->pid = 1;

//     return false;
// }

// void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp)
// {
//     // printf("%x %x %x %x\n", parent, child, entry, esp);
//     // while(1){}
//     /****************************************
//      * 内核地址空间操作
//      ****************************************/
//     memcpy(parent, child, PAGE_SIZE);

//     child->stack = (dword *)((dword)child + esp - (dword)parent);
//     child->stack = child->stack - 5;

//     // 和switch的过程对应
//     child->stack[0] = esi;
//     child->stack[1] = edi;
//     child->stack[2] = ebx;
//     child->stack[3] = ebp;
//     child->stack[4] = entry;
//     //printf("entry: 0x%x", entry);

//     child->stack = (dword *)(esp - 4 * 5);

//     child->status = ThreadStatus::READY;
//     child->ticksPassedBy = 0;

//     // 复制进程页目录表，遵循页目录表定义规则。
//     // 0~767用户页目录项，768~1022内核页目录项，1023页目录表物理地址
//     child->pageDir = createPageDir(); // 处理768~1023的页目录项
//     if (!child->pageDir)
//     {
//         // 释放前面分配的内容
//         return;
//     }

//     memcpy(parent->pageDir, child->pageDir, 768 * sizeof(dword));

//     // 复制虚拟地址池
//     createUserVaddrPool(child);
//     dword bitmapLength = parent->userVaddr.resources.length;
//     dword bitmapBytes = stdmath::roundup(bitmapLength, 8);
//     memcpy(parent->userVaddr.resources.bitmap, child->userVaddr.resources.bitmap, bitmapBytes);

//     /****************************************
//      * 用户地址空间操作(实际上是复制页表和物理页)
//      ****************************************/

//     // 复制用户空间页表
//     byte *buffer = (byte *)allocatePages(AddressPoolType::KERNEL, 1);
//     dword childPageDirPaddr = vaddr2paddr((dword)child->pageDir);
//     dword parentPageDirPaddr = vaddr2paddr((dword)parent->pageDir);

//     if (!buffer)
//     {
//         // 释放前面分配的内容
//         return;
//     }

//     for (dword i = 0; i < 768; ++i)
//     {
//         // 页表存在
//         if (parent->pageDir[i] & 0x1)
//         {
//             // 复制页目录项对应的页表到子进程

//             // 计算页表的虚拟地址
//             dword *pageTableVaddr = (dword *)(0xffc00000 + (i << 12));

//             memcpy(pageTableVaddr, buffer, PAGE_SIZE);
//             dword paddr = (dword)allocatePhysicalPage(AddressPoolType::USER);
//             if (!paddr)
//             {
//                 // 释放前面分配的资源
//                 return;
//             }

//             sys_update_cr3(childPageDirPaddr); // 下面根据的就是子进程的页目录表进行寻址
//             child->pageDir[i] = (child->pageDir[i] & 0x00000fff) | paddr;
//             memcpy(buffer, pageTableVaddr, PAGE_SIZE);
//             sys_update_cr3(parentPageDirPaddr);

//             void *pageVaddr;

//             // 复制物理页
//             for (int j = 0; j < 1024; ++j)
//             {
//                 if (pageTableVaddr[j] & 0x1)
//                 {
//                     paddr = (dword)allocatePhysicalPage(AddressPoolType::USER);
//                     if (!paddr)
//                     {
//                         // 释放前面分配的资源
//                         return;
//                     }
//                     pageVaddr = (void *)((i << 22) + (j << 12));
//                     memcpy(pageVaddr, buffer, PAGE_SIZE);

//                     sys_update_cr3(childPageDirPaddr);
//                     pageTableVaddr[j] = (pageTableVaddr[j] & 0x00000fff) | paddr;
//                     memcpy(buffer, pageVaddr, PAGE_SIZE);
//                     sys_update_cr3(parentPageDirPaddr);
//                 }
//             }
//         }
//     }

//     // 归还从内核分配的页表
//     releaseKernelPage((dword)buffer, 1);

//     //将父进程PCB虚拟地址对应的物理页修改为子进程的物理页
//     dword childPCBaddr = vaddr2paddr((dword)child);
//     // 存放PCB地址的页表
//     dword *pageOfPCB = (dword *)allocatePages(AddressPoolType::KERNEL, 1);
//     if (!pageOfPCB)
//     {
//         // 释放前面分配的资源
//         return;
//     }

//     dword pde, pte;
//     pde = ((dword)parent & 0xffc00000) >> 22;
//     pte = ((dword)parent & 0x003ff000) >> 12;

//     //printf("%d %d\n", pde, pte);

//     dword *parentPageOfPCB = (dword *)(0xffc00000 + (pde << 12));
//     memcpy(parentPageOfPCB, pageOfPCB, PAGE_SIZE);
//     pageOfPCB[pte] = childPCBaddr | 0x7;
//     dword pageOfPCBaddr = vaddr2paddr((dword)pageOfPCB);
//     child->pageDir[pde] = pageOfPCBaddr | 0x7;

//     // 加入进程列表

//     bool interruptStatus = _interrupt_status();
//     _disable_interrupt();
//     _all_threads.push_back(&(child->tagInAllList));
//     _ready_threads.push_back(&(child->tagInGeneralList));
//     _set_interrupt(interruptStatus);
// }

// void ProgramManager::exit(dword status)
// {
//     PCB *process = (PCB *)_running_thread();
//     if (process->pageDir)
//         return;

//     // 释放进程用户空间的页表

//     dword *page;

//     // 0~768的页目录表对应用户空间的页目录表
//     for (dword i = 0; i < 768; ++i)
//     {
//         // 页目录表无对应的页表
//         if (!(process->pageDir[i] & 0x1))
//             continue;

//         page = (dword *)(0xffc00000 + (i << 12));

//         for (dword j = 0; j < 1024; ++j)
//         {
//             // 页表无对应的物理页
//             if (!(page[j] & 0x1))
//                 continue;
//             // 释放物理页
//             releasePage(((i << 22) + (j << 12)), 1);
//         }

//         // 释放页表占用的物理页
//         releasePage((dword)page, 1);
//     }

//     // 释放页目录表
//     releaseKernelPage((dword)process->pageDir, 1);

//     // 释放虚拟地址池占用的内核页表
//     dword temp = stdmath::roundup(process->userVaddr.resources.length, 8 * PAGE_SIZE);
//     releaseKernelPage((dword)process->userVaddr.resources.bitmap, temp);

//     // 关闭打开的文件
//     /*******************************/
//     /*******************************/
//     /*******************************/

//     // 向PCB中写入返回值，供父进程使用
//     process->returnStatus = status;

//     // 父进程结束子进程
//     backToParent(process->parentPID);
// }

// void ProgramManager::wait(dword *wstatus)
// {
// }