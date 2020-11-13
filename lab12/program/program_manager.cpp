#include "program_manager.h"
#include "../cstdlib.h"
#include "../syscall.h"
#include "../math.h"
#include "../interrupt.h"
#include "../panic.h"

extern "C" void sys_fork_entry(PCB *parent, PCB *child);

dword ProgramManager::fork()
{
    // 禁止内核线程调用
    PCB *parent = (PCB *)_running_thread();
    if (!parent->pageDir)
        return false;

    PCB *child = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!child)
        return false;

    // sys_fork_entry的作用是冻结parent的栈内容和指针
    sys_fork_entry(parent, child);

    parent->pid = 0;
    child->pid = 1;

    return false;
}

void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp)
{
    // printf("%x %x %x %x\n", parent, child, entry, esp);
    // while(1){}
    /****************************************
     * 内核地址空间操作
     ****************************************/
    memcpy(parent, child, PAGE_SIZE);

    child->stack = (dword *)((dword)child + esp - (dword)parent);
    child->stack = child->stack - 5;

    // 和switch的过程对应
    child->stack[0] = esi;
    child->stack[1] = edi;
    child->stack[2] = ebx;
    child->stack[3] = ebp;
    child->stack[4] = entry;
    //printf("entry: 0x%x", entry);

    child->stack = (dword *)(esp - 4 * 5);

    child->status = ThreadStatus::READY;
    child->ticksPassedBy = 0;

    // 复制进程页目录表，遵循页目录表定义规则。
    // 0~767用户页目录项，768~1022内核页目录项，1023页目录表物理地址
    child->pageDir = createPageDir(); // 处理768~1023的页目录项
    if (!child->pageDir)
    {
        // 释放前面分配的内容
        return;
    }

    memcpy(parent->pageDir, child->pageDir, 768 * sizeof(dword));

    // 复制虚拟地址池
    createUserVaddrPool(child);
    dword bitmapLength = parent->userVaddr.resources.length;
    dword bitmapBytes = stdmath::roundup(bitmapLength, 8);
    memcpy(parent->userVaddr.resources.bitmap, child->userVaddr.resources.bitmap, bitmapBytes);

    /****************************************
     * 用户地址空间操作(实际上是复制页表和物理页)
     ****************************************/

    // 复制用户空间页表
    byte *buffer = (byte *)allocatePages(AddressPoolType::KERNEL, 1);
    dword childPageDirPaddr = vaddr2paddr((dword)child->pageDir);
    dword parentPageDirPaddr = vaddr2paddr((dword)parent->pageDir);

    if (!buffer)
    {
        // 释放前面分配的内容
        return;
    }

    for (dword i = 0; i < 768; ++i)
    {
        // 页表存在
        if (parent->pageDir[i] & 0x1)
        {
            // 复制页目录项对应的页表到子进程

            // 计算页表的虚拟地址
            dword *pageTableVaddr = (dword *)(0xffc00000 + (i << 12));

            memcpy(pageTableVaddr, buffer, PAGE_SIZE);
            dword paddr = (dword)allocatePhysicalPage(AddressPoolType::USER);
            if (!paddr)
            {
                // 释放前面分配的资源
                return;
            }

            sys_update_cr3(childPageDirPaddr); // 下面根据的就是子进程的页目录表进行寻址
            child->pageDir[i] = (child->pageDir[i] & 0x00000fff) | paddr;
            memcpy(buffer, pageTableVaddr, PAGE_SIZE);
            sys_update_cr3(parentPageDirPaddr);

            void *pageVaddr;

            // 复制物理页
            for (int j = 0; j < 1024; ++j)
            {
                if (pageTableVaddr[j] & 0x1)
                {
                    paddr = (dword)allocatePhysicalPage(AddressPoolType::USER);
                    if (!paddr)
                    {
                        // 释放前面分配的资源
                        return;
                    }
                    pageVaddr = (void *)((i << 22) + (j << 12));
                    memcpy(pageVaddr, buffer, PAGE_SIZE);

                    sys_update_cr3(childPageDirPaddr);
                    pageTableVaddr[j] = (pageTableVaddr[j] & 0x00000fff) | paddr;
                    memcpy(buffer, pageVaddr, PAGE_SIZE);
                    sys_update_cr3(parentPageDirPaddr);
                }
            }
        }
    }

    // 归还从内核分配的页表
    releaseKernelPage((dword)buffer, 1);

    //将父进程PCB虚拟地址对应的物理页修改为子进程的物理页
    dword childPCBaddr = vaddr2paddr((dword)child);
    // 存放PCB地址的页表
    dword *pageOfPCB = (dword *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!pageOfPCB)
    {
        // 释放前面分配的资源
        return;
    }

    dword pde, pte;
    pde = ((dword)parent & 0xffc00000) >> 22;
    pte = ((dword)parent & 0x003ff000) >> 12;

    //printf("%d %d\n", pde, pte);

    dword *parentPageOfPCB = (dword *)(0xffc00000 + (pde << 12));
    memcpy(parentPageOfPCB, pageOfPCB, PAGE_SIZE);
    pageOfPCB[pte] = childPCBaddr | 0x7;
    dword pageOfPCBaddr = vaddr2paddr((dword)pageOfPCB);
    child->pageDir[pde] = pageOfPCBaddr | 0x7;

    // 加入进程列表

    bool interruptStatus = _interrupt_status();
    _disable_interrupt();
    _all_threads.push_back(&(child->tagInAllList));
    _ready_threads.push_back(&(child->tagInGeneralList));
    _set_interrupt(interruptStatus);

}
