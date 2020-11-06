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
#include <stdarg.h>
#include "disk.cpp"
#include "lock.cpp"
#include "fs/file_system.cpp"
#include "fs/inode.h"

//A a;

#define color_1 07 // 黑底白字
#define BUF_SIZE 1024

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
    sysDiskManager.initialize();
}

void secondInit()
{
    // 初始化文件系统
    //sysFileSystem.initialize();
}

void kernelThreadA(void *arg)
{
    void *ptr = kernelMalloc(512);
    printf("0x%x\n", (dword)ptr);
    kernelFree(ptr);
    ptr = nullptr;
    ptr = kernelMalloc(512);
    printf("0x%x\n", (dword)ptr);
    while (1)
        ;
}
void firstThread(void *arg)
{
    _enable_interrupt();
    // 第2次初始化，上层建筑
    secondInit();

    executeProcess((void *)kernelThreadA, "Kernel Thread A", 1);
    //List<Inode, Inode::LessThan> l;
    //printf("Hello World\n");
    while (1)
    {
    }
}