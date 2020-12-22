#include "memory.h"
#include "../cstdio.h"
#include "../program/thread.h"

void initMemoryPool(const dword totalMemory)
{
    dword usedMemory = 256 * PAGE_SIZE + 0x100000;
    dword freeMemory = totalMemory - usedMemory;

    dword freePages = freeMemory / PAGE_SIZE;
    dword kernelPages = freePages / 2;
    dword userPages = freePages - kernelPages;

    dword kernelPoolStartAddress = usedMemory;
    dword userPoolStartAddress = usedMemory + kernelPages * PAGE_SIZE;

    byte *kernelBitMapStart = (byte *)BITMAP_START_ADDRESS;
    byte *userBitMapStart = kernelBitMapStart + kernelPages / 8;
    if (kernelPages % 8)
        ++userBitMapStart;

    kernelPool.setResources(kernelBitMapStart, kernelPages);
    kernelPool.setStartAddress(kernelPoolStartAddress);

    userPool.setResources(userBitMapStart, userPages);
    userPool.setStartAddress(userPoolStartAddress);

    byte *kernelVrirtualBitMapStart = userBitMapStart + userPages / 8;
    if (userPages % 8)
        ++kernelVrirtualBitMapStart;
    kernelVrirtualPool.setResources(kernelVrirtualBitMapStart, kernelPages);
    kernelVrirtualPool.setStartAddress(KERNEL_HEAP_START);

    // printf("kernel pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n",
    //        kernelPoolStartAddress, kernelPages, kernelBitMapStart);

    // printf("user pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n",
    //        userPoolStartAddress, userPages, userBitMapStart);

    // printf("kernel virtual pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n",
    //        KERNEL_HEAP_START, userPages, kernelVrirtualBitMapStart);
}

void *allocateVirtualPages(enum AddressPoolType type, const dword count)
{
    dword start = -1;

    if (type == AddressPoolType::KERNEL)
    {
        start = kernelVrirtualPool.allocate(count);
    }
    else if (type == AddressPoolType::USER)
    {
        PCB *ptr = sysProgramManager.running();
        start = ptr->userVaddr.allocate(count);
    }

    return (start == -1) ? nullptr : (void *)start;
}

void *allocatePhysicalPage(enum AddressPoolType type)
{
    dword start = -1;

    if (type == AddressPoolType::KERNEL)
    {
        start = kernelPool.allocate(1);
    }
    else if (type == AddressPoolType::USER)
    {
        start = userPool.allocate(1);
    }

    return (start == -1) ? nullptr : (void *)start;
}

bool connectPhysicalVritualPage(const dword virtualAddress, const dword physicalPageAddress)
{
    dword *pde = toPDE(virtualAddress);
    dword *pte = toPTE(virtualAddress);

    if (*pde & 0x00000001)
    {
        *pte = physicalPageAddress | 0x7;
    }
    else
    {
        void *ptr = allocatePhysicalPage(AddressPoolType::KERNEL);
        if (ptr == nullptr)
            return false;
        dword pageAddress = (dword)ptr;
        *pde = pageAddress | 0x7;
        byte *pagePtr = (byte *)(((dword)pte) & 0xfffff000);
        for (int i = 0; i < PAGE_SIZE; ++i)
        {
            pagePtr[i] = 0;
        }
        *pte = physicalPageAddress | 0x7;
    }

    return true;
}

dword *toPDE(const dword virtualAddress)
{
    return (dword *)(0xfffff000 + (((virtualAddress & 0xffc00000) >> 22) * 4));
}
dword *toPTE(const dword virtualAddress)
{
    return (dword *)(0xffc00000 + ((virtualAddress & 0xffc00000) >> 10) + (((virtualAddress & 0x003ff000) >> 12) * 4));
}

void *allocatePages(enum AddressPoolType type, const dword count)
{
    dword virtualAddress = (dword)allocateVirtualPages(type, count);
    if (!virtualAddress)
        return nullptr;

    dword physicalPageAddress;
    void *ans = (void *)virtualAddress;

    for (int i = 0; i < count; ++i, virtualAddress += PAGE_SIZE)
    {
        physicalPageAddress = (dword)allocatePhysicalPage(type);
        if (!physicalPageAddress)
        {
            // 之前分配的也要回收
            return nullptr;
        }
        if (!connectPhysicalVritualPage(virtualAddress, physicalPageAddress))
            return nullptr;
    }

    return ans;
}

dword vaddr2paddr(dword vaddr)
{
    return (((dword)(*(toPTE(vaddr))) & 0xfffff000) + (vaddr & 0xfff));
}

void *specifyPaddrForVaddr(enum AddressPoolType type, const dword vaddr)
{
    void *ptr = allocatePhysicalPage(type);
    if (!ptr)
        return 0;

    bool ans = connectPhysicalVritualPage(vaddr, (dword)ptr);
    return ans ? (void *)vaddr : nullptr;
}

void releasePage(const dword virtualAddress, const dword count)
{
    //  物理地址是不连续的，虚拟地址是连续的

    dword *pte = nullptr;
    dword temp = virtualAddress;
    PCB *pcb = sysProgramManager.running();

    for (int i = 0; i < count; ++i)
    {
        releasePhysicalPage(vaddr2paddr(temp));
        temp += PAGE_SIZE;
    }

    releaseVirtualPage(virtualAddress, count);
}

// 释放虚拟页
void releaseVirtualPage(const dword vaddr, const dword count)
{
    PCB *pcb = sysProgramManager.running();
    if (pcb->pageDir)
    {
        pcb->userVaddr.release(vaddr, count);
    }
    else
    {
        kernelVrirtualPool.release(vaddr, count);
    }
}
// 释放物理页
void releasePhysicalPage(const dword paddr)
{
    PCB *pcb = sysProgramManager.running();

    if (pcb->pageDir)
    {
        userPool.release(paddr, 1);
    }
    else
    {
        kernelPool.release(paddr, 1);
    }
}

void releaseKernelPage(const dword virtualAddress, const dword count)
{
    //  物理地址是不连续的，虚拟地址是连续的

    dword *pte = nullptr;
    dword temp = virtualAddress;
    PCB *pcb = sysProgramManager.running();

    for (int i = 0; i < count; ++i)
    {
        kernelPool.release(vaddr2paddr(temp), 1);
        temp += PAGE_SIZE;
    }

    kernelVrirtualPool.release(virtualAddress, count);
}