#ifndef BITMAP_H
#define BITMAP_H

#include "type.h"

class BitMap
{
private:
    // 被管理的资源个数，bitmap的总位数
    dword length;
    // bitmap的起始地址
    byte *bitmap;
public:
    // 初始化
    BitMap();
    // 设置BitMap，bitmap=起始地址，length=总位数
    void setBitMap(byte *bitmap, const dword length);
    // 获取第index个资源的状态
    bool get(const dword index);
    // 设置第index个资源的状态
    void set(const dword index, const bool status);
    // 分配count个连续的资源，若没有则返回-1
    dword allocate(const dword count);
    // 释放第index个资源开始的count个资源
    void release(const dword index, const dword count);
    // 返回数据源
    void *getBitmapData();
};

#endif