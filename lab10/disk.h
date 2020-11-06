#ifndef DISK_H
#define DISK_H

#include "type.h"
#include "sync.h"

class Disk
{
    private:
        dword SEC_SIZE = 512;
        Semaphore mutex;
public:
    // start 开始逻辑扇区
    // size 数据字节数
    // buf 数据缓冲区
    Disk();
    void initialize();
    void write(dword start, byte *buf, dword size);
    void read(dword start, byte *buf, dword size);
private:
    // 等待磁盘就绪 amount 扇区数
    void waitForDisk(dword start, dword amount, dword type);
};

Disk sysDiskManager;

#endif