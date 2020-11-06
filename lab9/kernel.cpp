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
#include "lock.cpp"

#define color_1 07 // 黑底白字
#define BUF_SIZE 1024

dword thread_test;
dword thread_test_2;
dword counter;
Semaphore semaphore;
Lock lock;

void init();
extern "C" void Kernel();

void userProcessA(void *arg);
void userProcessB(void *arg);
void firstThread(void *arg);

// 从shell返回一定会出错
void Kernel()
{
    init();
    //printf("\n--%d--\n", (dword)userScheduleThread);
    //while(1);

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
    thread_test = thread_test_2 = 0;
    // 初始化TSS
    tss.initialize();
    // 初始化系统调用表
    sysInitializeSysCall();
    // 初始化堆内存分配
    semaphore.initialize(1);
    lock.initialize();
    sysMemoryManager.initialize();
}

void kernelThreadA(void *arg)
{
    dword time = 1000;
    void *ans;

    for (int i = 0; i < 1000; ++i)
    {
        //semaphore.P();
        ans = malloc(16);
        //printf("A %d 0x%x\n", i, ans);
       // semaphore.V();
    }

    while (1)
        ;
}

void kernelThreadB(void *arg)
{
    dword time = 1000;
    void *ans;

    printf("---------Enter B---------\n");
    for (int i = 0; i < 1000; ++i)
    {
        ans = malloc(16);

        while (time)
            --time;
        time = 1000;
    }
    while(1);
}

void kernelThreadC(void *arg)
{

    for (int i = 0; i < 1000; ++i)
    {
        malloc(16);
    }

    while (1)
        ;
    dword counter = 0;
    void *addr;

    void *addr1 = malloc(1024);
    void *addr2 = malloc(1024);

    printf("C allocate, addr1: 0x%x, addr2: 0x%x\n", addr1, addr2);

    free(addr2);
    addr2 = malloc(1024);

    printf("C free addr2 and allocate: 0x%x\n", addr2);

    free(addr1);
    free(addr2);
    addr1 = malloc(16);
    addr2 = malloc(16);

    printf("C free page and allocate, addr1: 0x%x, addr2: 0x%x\n", addr1, addr2);

    while (1)
        ;
    /*
    dword addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);
    addr1024 = (dword)malloc(1024);
    printf("%x\n", addr1024);

    while (1)
        ;

        */
    /*
    dword addr16 = (dword)malloc(16);
    dword addr32 = (dword)malloc(32);
    dword addr64 = (dword)malloc(64);
    dword addr128 = (dword)malloc(128);
    dword addr256 = (dword)malloc(256);
    dword addr512 = (dword)malloc(512);
    dword addr1024 = (dword)malloc(1024);

    printf("-----\n%x\n%x\n%x\n%x\n%x\n%x\n%x\n-----\n", addr16, addr32, addr64, addr128, addr256, addr512, addr1024);

    addr16 = (dword)malloc(16);
    addr32 = (dword)malloc(32);
    addr64 = (dword)malloc(64);
    addr128 = (dword)malloc(128);
    addr256 = (dword)malloc(256);
    addr512 = (dword)malloc(512);
    addr1024 = (dword)malloc(1024);

    printf("-----\n%x\n%x\n%x\n%x\n%x\n%x\n%x\n-----\n", addr16, addr32, addr64, addr128, addr256, addr512, addr1024);
    while (1)
        ;
        */
}

void firstThread(void *arg)
{
    _enable_interrupt();

    //  createThread(kernelThreadA, nullptr, 1);
    //createThread(kernelThreadA, nullptr, 1);
    // createThread(kernelThreadB, nullptr, 1);

    executeProcess((void *)kernelThreadA, "Kernel Thread A", 1);
    executeProcess((void *)kernelThreadB, "Kernel Thread A", 1);
    // executeProcess((void *)kernelThreadC, "Kernel Thread A", 1);
    while (1)
    {
        //++counter;
        //printf("%d %d %d\n", counter, thread_test, thread_test_2);
    }
}