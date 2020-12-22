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

void sysExit(dword status)
{
    if (sysProgramManager.running()->pageDir)
    {
        // 交给父进程处理
        sysProgramManager.exit(0);
    }
    else
    {
        PCB *thread = sysProgramManager.running();
        sysProgramManager.allPrograms.erase(&(thread->tagInAllList));
        releaseKernelPage((dword)thread, 1);
        thread->status = ThreadStatus::DEAD;
        sysProgramManager.schedule();
    }
}

void ProgramManager::exit(dword status)
{
    PCB *process = currentRunning;

    // 释放进程用户空间的页表

    dword *page;

    // 0~768的页目录表对应用户空间的页目录表
    for (dword i = 0; i < 768; ++i)
    {
        // 页目录表无对应的页表
        if (!(process->pageDir[i] & 0x1))
            continue;

        page = (dword *)(0xffc00000 + (i << 12));

        for (dword j = 0; j < 1024; ++j)
        {
            // 页表无对应的物理页
            if (!(page[j] & 0x1))
                continue;
            // 释放物理页
            releasePhysicalPage(vaddr2paddr((i << 22) + (j << 12)));
        }

        // 释放页表占用的物理页

        // 用户页表并未从虚拟地址池中分配地址
        releasePhysicalPage(vaddr2paddr((dword)page));
    }

    // 释放页目录表
    releaseKernelPage((dword)process->pageDir, 1);

    // 释放虚拟地址池占用的内核页表
    dword temp = stdmath::roundup(process->userVaddr.resources.length, 8 * PAGE_SIZE);
    releaseKernelPage((dword)process->userVaddr.resources.bitmap, temp);

    // 关闭打开的文件
    /*******************************/
    /*******************************/
    /*******************************/

    // 向PCB中写入返回值，供父进程使用
    process->returnStatus = status;

    // 父进程结束子进程
    backToParent();
}

void ProgramManager::backToParent()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    PCB *parent = findProgramByPid(currentRunning->parentPid);
    if (!parent)
    {
        // 1号进程是init进程
        currentRunning->parentPid = 1;
    }

    currentRunning->status = ThreadStatus::DEAD;
    schedule();

    _set_interrupt(status);
}

dword ProgramManager::wait(dword *status)
{
    PCB *child;
    ThreadListItem *item;
    bool interrupt;
    dword temp;

    // 先找结束的进程
    interrupt = _interrupt_status();
    _disable_interrupt();

    item = allPrograms.head.next;
    while (item)
    {
        child = threadListItem2PCB(item);
        if (child->parentPid == currentRunning->pid && child->status == ThreadStatus::DEAD)
        {

            if (status)
            {
                *status = child->returnStatus;
            }

            dword pid = child->pid;
            releaseKernelPage((dword)child, 1);
            allPrograms.erase(&(child->tagInAllList));
            _set_interrupt(interrupt);
            printf("release child %d\n", child->pid);
            return pid;
        }
        item = item->next;
    }

    _set_interrupt(interrupt);

    while (1)
    {
        interrupt = _interrupt_status();
        _disable_interrupt();
        
        child = findChildProcess(currentRunning->pid);
        if (!child)
        {

            _set_interrupt(interrupt);
            return -1;
        }

        if (child->status == ThreadStatus::DEAD)
        {
            printf("wait before releasing child %d\n", child->pid);
            if (status)
            {
                *status = child->returnStatus;
            }

            dword pid = child->pid;
            releaseKernelPage((dword)child, 1);
            allPrograms.erase(&(child->tagInAllList));
            _set_interrupt(interrupt);
            return pid;
        } else {
            printf("wait for child %d\n", child->pid);
        }

        _set_interrupt(interrupt);

        // 等待一段时间
        
        temp = 0xfffff;
        while (temp) {
            //printf("%d\n", temp);
            --temp;
        }
        
    }
}