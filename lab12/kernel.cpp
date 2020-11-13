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
#include "ext2/fs.cpp"
#include "disk/disk_bitmap.cpp"
#include "disk/disk.h"
#include "panic.h"
#include "ext2/inode.h"
#include "ext2/directory_entry.h"
#include "program/program_manager.cpp"

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
}

void secondInit()
{
    // 初始化文件系统
    sysFileSystem.init();
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

    fork();

    PCB *process = (PCB *)_running_thread();
    if (process->pid)
    {
        printf("I am child, %d\n", process->pid);
    }
    else
    {
        printf("I am father, %d\n", process->pid);
    }

    while (1)
    {
    }
}
void firstThread(void *arg)
{
    _enable_interrupt();

    // 第2次初始化，上层建筑
    secondInit();

    printf("%x\n", _switch_thread_to);
    //while(1) {}

    //createThread(testThreadNotReturn, nullptr, 1);
    executeProcess((void *)testThreadNotReturn, "", 1);

    while (1)
    {

    }
}