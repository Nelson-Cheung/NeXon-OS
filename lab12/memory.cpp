#include "memory.h"
#include "cstdio.h"
#include "thread.h"

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
        if (pcb->pageDir)
        {
            userPool.release(vaddr2paddr(temp), 1);
        }
        else
        {
            kernelPool.release(vaddr2paddr(temp), 1);
        }

        pte = (dword *)temp;
        *pte = 0;
        temp += PAGE_SIZE;
    }

    if (pcb->pageDir)
    {
        pcb->userVaddr.release(virtualAddress, count);
    }
    else
    {
        kernelVrirtualPool.release(virtualAddress, count);
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

        pte = (dword *)temp;
        *pte = 0;
        temp += PAGE_SIZE;
    }

    kernelVrirtualPool.release(virtualAddress, count);
}

// MemoryManager::MemoryManager()
// {
//     initialize();
// }

// void MemoryManager::initialize()
// {
//     dword size = minSize;
//     for (int i = 0; i < MEM_BLOCK_TYPES; ++i)
//     {
//         arenas[i] = nullptr;
//         arenaSize[i] = size;
//         size = size << 1;
//     }
//     mutex.initialize(1); // 内存分配和释放时实现互斥
// }

// void *MemoryManager::allocate(dword size)
// {
//     dword index = 0;
//     while (index < MEM_BLOCK_TYPES && arenaSize[index] < size)
//         ++index;

//     PCB *pcb = sysProgramManager.running();
//     AddressPoolType poolType = (pcb->pageDir) ? AddressPoolType::USER : AddressPoolType::KERNEL;
//     void *ans = nullptr;

//     if (index == MEM_BLOCK_TYPES)
//     {
//         // 上取整
//         dword pageAmount = (size + sizeof(Arena) + PAGE_SIZE - 1) / PAGE_SIZE;

//         mutex.P();
//         ans = allocatePages(poolType, pageAmount);
//         mutex.V();

//         if (ans)
//         {
//             Arena *arena = (Arena *)ans;
//             arena->type = ArenaType::ARENA_MORE;
//             arena->counter = pageAmount;
//         }
//     }
//     else
//     {
//         //printf("---MemoryManager::allocate----\n");
//         if (arenas[index] == nullptr)
//         {
//             if (!getNewArena(poolType, index))
//                 return nullptr;
//         }

//         // 每次取出内存块链表中的第一个内存块
//         ans = arenas[index];
//         arenas[index] = ((MemoryBlockListItem *)ans)->next;

//         if (arenas[index])
//         {
//             (arenas[index])->previous = nullptr;
//         }

//         Arena *arena = (Arena *)((dword)ans & 0xfffff000);
//         --(arena->counter);
//         //printf("---MemoryManager::allocate----\n");
//     }

//     return ans;
// }

// bool MemoryManager::getNewArena(AddressPoolType type, dword index)
// {
//     mutex.P();
//     void *ptr = allocatePages(type, 1);
//     mutex.V();

//     if (ptr == nullptr)
//         return false;

//     // 内存块的数量
//     dword times = (PAGE_SIZE - sizeof(Arena)) / arenaSize[index];
//     // 内存块的起始地址
//     dword address = (dword)ptr + sizeof(Arena);

//     // 记录下内存块的数据
//     Arena *arena = (Arena *)ptr;
//     arena->type = (ArenaType)index;
//     arena->counter = times;
//     // printf("---MemoryManager::getNewArena: type: %d, arena->counter: %d\n", index, arena->counter);

//     MemoryBlockListItem *prevPtr = (MemoryBlockListItem *)address;
//     MemoryBlockListItem *curPtr = nullptr;
//     arenas[index] = prevPtr;
//     prevPtr->previous = nullptr;
//     prevPtr->next = nullptr;
//     --times;

//     while (times)
//     {
//         address += arenaSize[index];
//         curPtr = (MemoryBlockListItem *)address;
//         prevPtr->next = curPtr;
//         curPtr->previous = prevPtr;
//         curPtr->next = nullptr;
//         prevPtr = curPtr;
//         --times;
//     }

//     return true;
// }

// void MemoryManager::release(void *address)
// {
//     // 由于Arena是按页分配的，所以其首地址的低12位必定0，
//     // 其中划分的内存块的高20位也必定与其所在的Arena首地址相同
//     Arena *arena = (Arena *)((dword)address & 0xfffff000);

//     if (arena->type == ARENA_MORE)
//     {
//         dword address = (dword)arena;

//         mutex.P();
//         releasePage(address, arena->counter);
//         mutex.V();
//     }
//     else
//     {
//         MemoryBlockListItem *itemPtr = (MemoryBlockListItem *)address;
//         itemPtr->next = arenas[arena->type];
//         itemPtr->previous = nullptr;

//         if (itemPtr->next)
//         {
//             itemPtr->next->previous = itemPtr;
//         }

//         arenas[arena->type] = itemPtr;
//         ++(arena->counter);

//         // 若整个Arena被归还，则清空分配给Arena的页
//         dword amount = (PAGE_SIZE - sizeof(Arena)) / arenaSize[arena->type];
//         // printf("---MemoryManager::release---: arena->counter: %d, amount: %d\n", arena->counter, amount);

//         if (arena->counter == amount)
//         {
//             // 将属于Arena的内存块从链上删除
//             while (itemPtr)
//             {
//                 if ((dword)arena != ((dword)itemPtr & 0xfffff000))
//                 {
//                     itemPtr = itemPtr->next;
//                     continue;
//                 }

//                 if (itemPtr->previous == nullptr) // 链表中的第一个节点
//                 {
//                     arenas[arena->type] = itemPtr->next;
//                     if (itemPtr->next)
//                     {
//                         itemPtr->next->previous = nullptr;
//                     }
//                 }
//                 else
//                 {
//                     itemPtr->previous->next = itemPtr->next;
//                 }

//                 if (itemPtr->next)
//                 {
//                     itemPtr->next->previous = itemPtr->previous;
//                 }

//                 itemPtr = itemPtr->next;
//             }

//             mutex.P();
//             releasePage((dword)address, 1);
//             mutex.V();
//         }
//     }
// }