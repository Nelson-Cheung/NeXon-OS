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
#include "disk/disk_bitmap.cpp"

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

void testThreadReturn(void *arg)
{
    for (int i = 0; i < 5; ++i)
    {
        dword temp = 0xffffff;
        while (temp)
            --temp;
        printf("I will return\n");
    }

    printf("ok, I return\n");
}

void testThreadNotReturn(void *arg)
{
    while (1)
    {
        dword temp = 0xffffff;
        while (temp)
            --temp;
        printf("I never return\n");
    }
}
void firstThread(void *arg)
{
    _enable_interrupt();

    // 第2次初始化，上层建筑
    secondInit();

    DiskBitMap diskBitMap;
    dword length = 2 * SECTOR_SIZE;

    diskBitMap.setBitMap(PARTITION_1_START, length);
    dword first = diskBitMap.allocate();
    printf("allocate first resource %d\n", first);

    diskBitMap.release(first);

    dword second = diskBitMap.allocate();
    printf("release first and allocate second resource %d\n", second);

    diskBitMap.release(second);
    printf("release second\n");

    second = diskBitMap.allocate();
    printf("release second and allocate second resource %d\n", second);

    diskBitMap.release(second);


    printf("allocate 2 * SECTOR_SIZE\n");
    for (int i = 0; i < length; ++i)
    {
        dword temp = diskBitMap.allocate();
        if (temp == -1)
        {
            printf("allocate did not pass, %d\n", i);
            break;
        }
    }

    first = diskBitMap.allocate();
    printf("allocate pass bound, %d\n", first);

    printf("release 2 * SECTOR_SIZE\n");
    for (int i = 0; i < length; ++i)
    {
        diskBitMap.release(i);
    }

    first = diskBitMap.allocate();
    printf("allocate one more %d\n", first);

    diskBitMap.release(first);

    while (1)
    {
    }
}