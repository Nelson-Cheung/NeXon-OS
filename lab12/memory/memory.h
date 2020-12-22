#ifndef MEMORY_H
#define MEMORY_H

#include "../type.h"
#include "../bitmap.h"

#include "../program/addresspool.h"
#include "../program/program_manager.h"
#include "../program/sync.h"

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

// 释放虚拟页
void releaseVirtualPage(const dword vaddr, const dword count);
// 释放物理页
void releasePhysicalPage(const dword paddr);

#endif