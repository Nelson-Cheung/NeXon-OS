#ifndef MEMORY_H
#define MEMORY_H

#include "type.h"
#include "bitmap.h"

#include "program/addresspool.h"
#include "program/program_manager.h"

#define BITMAP_START_ADDRESS 0xc0010000
#define PAGE_SIZE 4096
#define KERNEL_HEAP_START 0xc0100000

AddressPool kernelVrirtualPool, kernelPool, userPool;

// 初始化地址池
void initMemoryPool(const dword totalMemory);
// 从虚拟地址池中分配count个连续页
static void *allocateVirtualPages(enum AddressPoolType type, const dword count);
// 从物理地址池中分配1个页
static void *allocatePhysicalPage(enum AddressPoolType type);
// 建立虚拟地址和物理地址的联系
static bool connectPhysicalVritualPage(const dword virtualAddress, const dword physicalPageAddress);
// 获取virtualAddress对应的PDE虚拟地址
static dword *toPDE(const dword virtualAddress);
// 获取virtualAddress对应的PTE虚拟地址T
static dword *toPTE(const dword virtualAddress);
// 分配count个连续的页地址空间并返回起始地址
void *allocatePages(enum AddressPoolType type, const dword count);
// 返回虚拟地址对应的物理地址
dword vaddr2paddr(dword vaddr);
// 为指定的虚拟地址分配物理地址
void *specifyPaddrForVaddr(enum AddressPoolType type, const dword vaddr);
// 释放物理地址
void releasePhysicalPage(dword address);
// 释放虚拟地址
void releaseVirtualPage(dword address);
// 释放空间
void releasePage(const dword virtualAddress, const dword count);
// 归还从内核空间中分配的页
void releaseKernelPage(const dword virtualAddress, const dword count);

enum ArenaType
{
    ARENA_16,
    ARENA_32,
    ARENA_64,
    ARENA_128,
    ARENA_256,
    ARENA_512,
    ARENA_1024,
    ARENA_MORE
};

struct Arena
{
    ArenaType type; // Arena的类型
    dword counter;  // 如果是ARENA_MORE则counter表明页框数，否则counter表明内存块的数量
};

// 对于每个空闲的Arena内存块，利用其中的空间来存储链表中的节点的previus和next指针

struct MemoryBlockListItem
{
    MemoryBlockListItem *previous, *next;
};

// MemoryManager是在内核态调用的内存管理对象

// class MemoryManager
// {

// private:
//     // 16, 32, 64, 128, 256, 512, 1024
//     static const dword MEM_BLOCK_TYPES = 7; // 内存块的类型数目
//     static const dword minSize = 16;        // 内存块的最小大小
//     dword arenaSize[MEM_BLOCK_TYPES];       // 每种类型对应的内存块大小
//     MemoryBlockListItem *arenas[MEM_BLOCK_TYPES]; // 每种类型的arena内存块的指针
//     Semaphore mutex;

// public:
//     MemoryManager();
//     void initialize();
//     void *allocate(dword size);  // 分配一块地址
//     void release(void *address); // 释放一块地址

// private:
//     bool getNewArena(AddressPoolType type, dword index);

// };

// MemoryManager sysMemoryManager;

#endif