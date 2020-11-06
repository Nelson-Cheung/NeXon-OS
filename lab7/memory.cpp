#include "memory.h"
#include "cstdio.h"

AddressPool::AddressPool() {}
void AddressPool::setResources(byte *start, const dword length)
{
    resources.setBitMap(start, length);
}
void AddressPool::setStartAddress(const dword startAddress)
{
    this->startAddress = startAddress;
}
dword AddressPool::allocate(const dword count)
{
    dword start = resources.allocate(count);
    return (start == -1) ? -1 : (start * PAGE_SIZE + startAddress);
}

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

    printf("kernel pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n",
           kernelPoolStartAddress, kernelPages, kernelBitMapStart);

    printf("user pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n",
           userPoolStartAddress, userPages, userBitMapStart);

    printf("kernel virtual pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n",
           KERNEL_HEAP_START, userPages, kernelVrirtualBitMapStart);
}

void *allocateVirtualPages(enum AddressPoolType type, const dword count)
{
    if (type == AddressPoolType::KERNEL)
    {
        dword start = kernelVrirtualPool.allocate(count);
        return (start == -1) ? nullptr : (void *)start;
    }
    else
    {
        return nullptr;
    }
}

void *allocatePhysicalPage(enum AddressPoolType type)
{
    if (type == AddressPoolType::KERNEL)
    {
        dword start = kernelPool.allocate(1);
        return (start == -1) ? nullptr : (void *)start;
    }
    else
    {
        return nullptr;
    }
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
        if (!physicalPageAddress) {
            // 之前分配的也要回收
            return nullptr;
        }
        if (!connectPhysicalVritualPage(virtualAddress, physicalPageAddress))
            return nullptr;
    }

    return ans;
}