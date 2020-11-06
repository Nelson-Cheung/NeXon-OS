#include "disk_bitmap.h"
DiskBitMap::DiskBitMap()
{
    length = start = -1;
}

// 设置BitMap，bitmap=起始地址，length=总位数
void DiskBitMap::setBitMap(const dword start, const dword length)
{
    this->start = start;
    this->length = length;
}

// 分配count个连续的资源，若没有则返回-1
dword DiskBitMap::allocate(const dword count) {
    
}

// 释放第index个资源开始的count个资源
void DiskBitMap::release(const dword index, const dword count);

// 获取第index个资源的状态
bool DiskBitMap::get(const dword index);

// 设置第index个资源的状态
void DiskBitMap::set(const dword index, const bool status);