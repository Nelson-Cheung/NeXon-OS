#include "disk.h"

class DiskBitMap
{
private:
    dword length; // 管理的资源个数，即总位数
    dword start;  // bitmap保存位置的起始扇区

public:
    // 初始化
    DiskBitMap();

    // 设置BitMap，bitmap=起始地址，length=总位数
    void setBitMap(const dword start, const dword length);

    // 分配count个连续的资源，若没有则返回-1
    dword allocate(const dword count);

    // 释放第index个资源开始的count个资源
    void release(const dword index, const dword count);

    // 获取第index个资源的状态
    bool get(const dword index);

    // 设置第index个资源的状态
    void set(const dword index, const bool status);
};