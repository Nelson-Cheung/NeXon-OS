#include "program_manager.h"

MemoryManager::MemoryManager()
{
    initialize();
}

void MemoryManager::initialize()
{
    dword size = minSize;
    for (int i = 0; i < MEM_BLOCK_TYPES; ++i)
    {
        arenas[i] = nullptr;
        arenaSize[i] = size;
        size = size << 1;
    }
    mutex.initialize(1); // 内存分配和释放时实现互斥
}

void *MemoryManager::allocate(dword size)
{
    dword index = 0;
    while (index < MEM_BLOCK_TYPES && arenaSize[index] < size)
        ++index;

    PCB *pcb = sysProgramManager.running();
    AddressPoolType poolType = (pcb->pageDir) ? AddressPoolType::USER : AddressPoolType::KERNEL;
    void *ans = nullptr;

    if (index == MEM_BLOCK_TYPES)
    {
        // 上取整
        dword pageAmount = (size + sizeof(Arena) + PAGE_SIZE - 1) / PAGE_SIZE;

        mutex.P();
        ans = allocatePages(poolType, pageAmount);
        mutex.V();

        if (ans)
        {
            Arena *arena = (Arena *)ans;
            arena->type = ArenaType::ARENA_MORE;
            arena->counter = pageAmount;
        }
    }
    else
    {
        //printf("---MemoryManager::allocate----\n");
        if (arenas[index] == nullptr)
        {
            if (!getNewArena(poolType, index))
                return nullptr;
        }

        // 每次取出内存块链表中的第一个内存块
        ans = arenas[index];
        arenas[index] = ((MemoryBlockListItem *)ans)->next;

        if (arenas[index])
        {
            (arenas[index])->previous = nullptr;
        }

        Arena *arena = (Arena *)((dword)ans & 0xfffff000);
        --(arena->counter);
        //printf("---MemoryManager::allocate----\n");
    }

    return ans;
}

bool MemoryManager::getNewArena(AddressPoolType type, dword index)
{
    mutex.P();
    void *ptr = allocatePages(type, 1);
    mutex.V();

    if (ptr == nullptr)
        return false;

    // 内存块的数量
    dword times = (PAGE_SIZE - sizeof(Arena)) / arenaSize[index];
    // 内存块的起始地址
    dword address = (dword)ptr + sizeof(Arena);

    // 记录下内存块的数据
    Arena *arena = (Arena *)ptr;
    arena->type = (ArenaType)index;
    arena->counter = times;
    // printf("---MemoryManager::getNewArena: type: %d, arena->counter: %d\n", index, arena->counter);

    MemoryBlockListItem *prevPtr = (MemoryBlockListItem *)address;
    MemoryBlockListItem *curPtr = nullptr;
    arenas[index] = prevPtr;
    prevPtr->previous = nullptr;
    prevPtr->next = nullptr;
    --times;

    while (times)
    {
        address += arenaSize[index];
        curPtr = (MemoryBlockListItem *)address;
        prevPtr->next = curPtr;
        curPtr->previous = prevPtr;
        curPtr->next = nullptr;
        prevPtr = curPtr;
        --times;
    }

    return true;
}

void MemoryManager::release(void *address)
{
    // 由于Arena是按页分配的，所以其首地址的低12位必定0，
    // 其中划分的内存块的高20位也必定与其所在的Arena首地址相同
    Arena *arena = (Arena *)((dword)address & 0xfffff000);

    if (arena->type == ARENA_MORE)
    {
        dword address = (dword)arena;

        mutex.P();
        releasePage(address, arena->counter);
        mutex.V();
    }
    else
    {
        MemoryBlockListItem *itemPtr = (MemoryBlockListItem *)address;
        itemPtr->next = arenas[arena->type];
        itemPtr->previous = nullptr;

        if (itemPtr->next)
        {
            itemPtr->next->previous = itemPtr;
        }

        arenas[arena->type] = itemPtr;
        ++(arena->counter);

        // 若整个Arena被归还，则清空分配给Arena的页
        dword amount = (PAGE_SIZE - sizeof(Arena)) / arenaSize[arena->type];
        // printf("---MemoryManager::release---: arena->counter: %d, amount: %d\n", arena->counter, amount);

        if (arena->counter == amount)
        {
            // 将属于Arena的内存块从链上删除
            while (itemPtr)
            {
                if ((dword)arena != ((dword)itemPtr & 0xfffff000))
                {
                    itemPtr = itemPtr->next;
                    continue;
                }

                if (itemPtr->previous == nullptr) // 链表中的第一个节点
                {
                    arenas[arena->type] = itemPtr->next;
                    if (itemPtr->next)
                    {
                        itemPtr->next->previous = nullptr;
                    }
                }
                else
                {
                    itemPtr->previous->next = itemPtr->next;
                }

                if (itemPtr->next)
                {
                    itemPtr->next->previous = itemPtr->previous;
                }

                itemPtr = itemPtr->next;
            }

            mutex.P();
            releasePage((dword)address, 1);
            mutex.V();
        }
    }
}