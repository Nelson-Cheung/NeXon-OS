#include "oslib.h"
#include "keyboard.h"
#include "string.h"
#include "utils.h"
#include "interrupt.h"
#include "cstdio.h"
#include "bitmap.cpp"
#include "memory.cpp"
#include "thread.cpp"
#include "sync.cpp"
#include "tss.h"
#include "process.cpp"
#include "addresspool.cpp"
#include "threadlist.cpp"
#include "syscall.cpp"
#include "disk/disk.h"

void init();
void firstThread(void *arg);

extern "C" void Kernel();

// 从shell返回一定会出错
void Kernel()
{
    // 初始化
    init();

    dword pid = createThread(&firstThread, nullptr, 2);

    PCB *next = elem2entry(PCB, tagInGeneralList, _ready_threads.front());
    currentRunningThread = next;

    currentRunningThread = next;
    next->status = ThreadStatus::RUNNING;
    _ready_threads.pop_front();
    _switch_thread_to((void *)0x9f000, next);

    while (1)
        ;
}

void init()
{
    // 32MB内存，bochs内置
    initMemoryPool(0x2000000);
    _all_threads.initialize();
    _ready_threads.initialize();
    PID = 0;

    // 初始化TSS
    tss.initialize();
    // 初始化系统调用表
    sysInitializeSysCall();
    // 初始化内核堆内存分配
    sysMemoryManager.initialize();
    // 初始化磁盘驱动
    // sysDiskManager.initialize();
}

void secondInit()
{
    // 初始化文件系统
    //sysFileSystem.initialize();
}

void firstThread(void *arg)
{
    _enable_interrupt();

    // 第2次初始化，上层建筑
    secondInit();

    byte *buffer = (byte *)kernelMalloc(2 * SECTOR_SIZE);
    dword length = 2 * SECTOR_SIZE;

    if (!buffer)
    {
        printf("---firstThread---\n"
               "can not allocate memory for buffer\n");
    }

    for (int i = 0; i < length; ++i)
    {
        if (i < SECTOR_SIZE)
            buffer[i] = 0x20;
        else
            buffer[i] = 0x19;
    }

    printf("test write blocks\n");
    Disk::write(PARTITION_1_START, buffer);
    Disk::write(PARTITION_1_START + 2, buffer + SECTOR_SIZE);

    for (int i = 0; i < length; ++i)
    {
        buffer[i] = 0;
    }

    printf("test read blocks\n");
    Disk::read(PARTITION_1_START + 2, buffer);
    Disk::read(PARTITION_1_START, buffer + SECTOR_SIZE);

    for (int i = 0; i < length; ++i)
    {
        if (i < SECTOR_SIZE)
        {
            if (buffer[i] != 0x19)
            {
                printf("read block 1 did not pass, positioin: %d\n", i);
                break;
            }
        }
        else
        {
            if (buffer[i] != 0x20)
            {
                printf("read block 2 did not pass, positioin: %d\n", i);
                break;
            }
        }
    }

    printf("write/read blocks pass\n");

    for (int i = 0; i < length; ++i)
    {
        buffer[i] = 0x18;
    }

    printf("test write bytes 1\n");
    Disk::writeBytes(PARTITION_1_START * SECTOR_SIZE + 256, buffer, length);

    printf("test read bytes 1\n");

    for (int i = 0; i < length; ++i)
    {
        buffer[i] = 0;
    }

    Disk::readBytes(PARTITION_1_START * SECTOR_SIZE + 256, buffer, length);

    for (int i = 0; i < length; ++i)
    {
        if (buffer[i] != 0x18)
        {
            printf("write/read bytes 1 not pass");
        }
    }

    printf("test read bytes 2\n");

    for (int i = 0; i < length; ++i)
    {
        buffer[i] = 0;
    }
    Disk::readBytes(PARTITION_1_START * SECTOR_SIZE + 128, buffer, 256);

    for (int i = 0; i < 256; ++i)
    {
        if (i < 128)
        {
            if (buffer[i] != 0x20)
            {
                printf("write/read bytes 1 not pass");
                break;
            }
        }
        else
        {
            if (buffer[i] != 0x18)
            {
                printf("write/read bytes 1 not pass");
                break;
            }
        }
    }

    printf("test read bytes 3\n");
    for (int i = 0; i < length; ++i)
    {
        buffer[i] = 0;
    }

    Disk::readBytes(PARTITION_1_START * SECTOR_SIZE + 256, buffer, 512);

    for (int i = 0; i < 512; ++i)
    {

        if (buffer[i] != 0x18)
        {
            printf("write/read bytes 1 not pass");
            break;
        }
    }

    printf("test write bytes 2\n");

    for (int i = 0; i < 256; ++i)
    {
        buffer[i] = 0x17;
    }

    Disk::writeBytes(PARTITION_1_START * SECTOR_SIZE + 128, buffer, 256);

    for (int i = 0; i < 513; ++i)
    {
        buffer[i] = 0;
    }

    Disk::read(PARTITION_1_START, buffer);

    for (int i = 0; i < 512; ++i)
    {
        if (i < 128)
        {
            if (buffer[i] != 0x20)
            {
                printf("write/read bytes 2 not pass");
                break;
            }
        }
        else if (i < 384)
        {
            if (buffer[i] != 0x17)
            {
                printf("write/read bytes 2 not pass");
                break;
            }
        }
        else
        {
            if (buffer[i] != 0x18)
            {
                printf("write/read bytes 2 not pass");
                break;
            }
        }
    }

    printf("test write bytes 3\n");

    for (int i = 0; i < 512; ++i)
    {
        if (i < 256)
            buffer[i] = 0x16;
        else
        {
            buffer[i] = 0x15;
        }
    }

    Disk::writeBytes(PARTITION_1_START * SECTOR_SIZE + 256, buffer, 512);

    for (int i = 0; i < 513; ++i)
    {
        buffer[i] = 0;
    }

    Disk::readBytes(PARTITION_1_START * SECTOR_SIZE + 256, buffer, 512);

    for (int i = 0; i < 512; ++i)
    {
        if (i < 256)
        {
            if (buffer[i] != 0x16)
            {
                printf("write/read bytes 3 not pass");
                break;
            }
        }
        else
        {
            if (buffer[i] != 0x15)
            {
                printf("write/read bytes 3 not pass");
                break;
            }
        }
    }
    kernelFree(buffer);
    //List<Inode, Inode::LessThan> l;
    //printf("Hello World\n");
    while (1)
    {
    }
}