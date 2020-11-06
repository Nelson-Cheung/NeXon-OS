#ifndef ADDRESS_POOL_H
#define ADDRESS_POOL_H

#include "sync.h"
#include "bitmap.h"

enum AddressPoolType
{
    KERNEL,
    USER
};

// 地址池
class AddressPool
{
private:
    Semaphore semaphore;
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

#endif