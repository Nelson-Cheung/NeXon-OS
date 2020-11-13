#ifndef DISK_H
#define DISK_H

#include "type.h"
#include "sync.h"
#include "configure/os_configure.h"

class Disk
{
private:
    dword SEC_SIZE = 512;
    Semaphore mutex;
    // 分区起始地址，但只有两个分区，系统区和文件区
    // 系统区是放置操作系统的，不可以随意修改
    // 文件区是建立文件系统的
    dword partitionStartSector[PARTITIONS_AMOUNT];

public:
    // start 开始逻辑扇区
    // size 数据字节数
    // buf 数据缓冲区
    Disk();
    void initialize();
    void write(dword partition, dword start, byte *buf, dword size);
    void read(dword partition, dword start, byte *buf, dword size);
    
private:
    // 等待磁盘就绪 amount 扇区数
    void waitForDisk(dword start, dword amount, dword type);
};

Disk sysDiskManager;

#endif