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
#define color_1 07 // 黑底白字
#define BUF_SIZE 1024

dword thread_test;
dword thread_test_2;
Semaphore semaphore;

void init();
extern "C" void Kernel();

void userProcessA(void *arg);
void userProcessB(void *arg);
void firstThread(void *arg);

// 从shell返回一定会出错
/*********************************************************
 gs = 0, 用户进程当前不可以使用与gs相关的函数，即printf类函数*
************************************************************/
void Kernel()
{
    init();
    dword pid = createThread(&firstThread, nullptr, 2);

    PCB *next = elem2entry(PCB, tagInGeneralList, _ready_threads.front());
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
    thread_test = thread_test_2 = 0;
    // 初始化TSS
    tss.initialize();
}

void userProcessA(void *arg)
{
    while (1)
    {
        ++thread_test;
    }
}

void userProcessB(void *arg)
{
    firstSysCall();
    while(1);
}
void firstThread(void *arg)
{
    dword *ptr = (dword *)(0xfffff000);
    _enable_interrupt();
    semaphore.initialize(1);
    //createThread(userProcessA, nullptr, 1);
    //createThread(userProcessB, nullptr, 1);
    executeProcess((void *)userProcessA, "user process", 1);
    executeProcess((void *)userProcessB, "user process", 1);
    while (1)
    {
        printf("%d %d\n", thread_test, thread_test_2);
    }
}