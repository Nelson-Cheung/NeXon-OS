#ifndef DISK_BITMAP_H
#define DISK_BITMAP_H

#include "disk.h"

class DiskBitMap
{
private:
    dword length;  // 管理的资源个数，即总位数
    dword start;   // bitmap保存位置的起始扇区
    byte masks[8]; // 128, 64, 32, 16, 8, 4, 2, 1

public:
    // 初始化
    DiskBitMap();
    DiskBitMap(const DiskBitMap &other);
    DiskBitMap &operator=(const DiskBitMap &other);

    // 设置BitMap，bitmap=起始地址，length=总位数
    void setBitMap(const dword start, const dword length);

    // 分配一个资源并返回其下标，若没有则返回-1
    dword allocate();

    // 释放第index个资源
    void release(const dword index);
};

#endif