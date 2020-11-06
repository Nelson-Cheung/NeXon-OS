#ifndef MEMORY_H
#define MEMORY_H

#include "type.h"
#include "bitmap.h"

#define BITMAP_START_ADDRESS 0xc0010000
#define PAGE_SIZE 4096
#define KERNEL_HEAP_START 0xc0100000

enum AddressPoolType
{
    KERNEL,
    USER
};

// 地址池
class AddressPool
{
private:
    BitMap resources;
    dword startAddress;
public:
    AddressPool();
    // 设置地址池BitMap
    void setResources(byte *start, const dword length);
    // 设置地址池的起始地址
    void setStartAddress(const dword startAddress);
    // 从地址池中分配count个连续页
    dword allocate(const dword count);
};

AddressPool kernelVrirtualPool, kernelPool, userPool;

// 初始化地址池
void initMemoryPool(const dword totalMemory);
// 从虚拟地址池中分配count个连续页
static void* allocateVirtualPages(enum AddressPoolType type, const dword count);
// 从物理地址池中分配1个页
static void* allocatePhysicalPage(enum AddressPoolType type);
// 建立虚拟地址和物理地址的联系
static bool connectPhysicalVritualPage(const dword virtualAddress, const dword physicalPageAddress);
// 获取virtualAddress对应的PDE虚拟地址
static dword *toPDE(const dword virtualAddress);
// 获取virtualAddress对应的PTE虚拟地址T
static dword *toPTE(const dword virtualAddress);
// 分配count个连续的页地址空间并返回起始地址
void *allocatePages(enum AddressPoolType type, const dword count);

#endif