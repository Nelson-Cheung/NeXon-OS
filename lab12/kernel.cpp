#include "oslib.h"
#include "keyboard.h"
#include "string.h"
#include "utils.h"
#include "interrupt.h"
#include "cstdio.h"
#include "bitmap.cpp"

#include "memory/memory.cpp"
#include "program/memory_manager.cpp"
#include "program/thread.cpp"
#include "program/process.cpp"
#include "program/program_manager.cpp"
#include "program/threadlist.cpp"
#include "program/addresspool.cpp"
#include "program/sync.cpp"

#include "syscall.cpp"

Semaphore mutex;

void init();
void firstThread(void *arg);

extern "C" void Kernel();

// 从shell返回一定会出错
void Kernel()
{
    // 初始化
    init();

    dword pid = sysProgramManager.executeThread(firstThread, nullptr, "first thread", 2);
    ThreadListItem *item = sysProgramManager.readyPrograms.front();
    PCB *thread = (PCB *)(((dword)item) & 0xfffff000);
    thread->status = ThreadStatus::RUNNING;
    sysProgramManager.currentRunning = thread;
    sysProgramManager.readyPrograms.pop_front();

    _switch_thread_to((void *)0x9f000, thread);
}

void init()
{
    // 32MB内存，bochs内置
    initMemoryPool(0x2000000);

    // 初始化系统调用表
    sysInitializeSysCall();

    // 初始化程序管理器
    sysProgramManager.initialize();

    // 初始化TSS
    tss.initialize();

    // 初始化内核堆内存分配
    sysMemoryManager.initialize();
}

dword counter;

void firstProcess(void *arg) {
    /*
    for (int i = 0; i < 1000; ++i)
    {
        malloc(16);
    }

    while (1);
    */
        /*
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
        */
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
        
}

void secondThread(void *arg)
{
    PCB *cur = sysProgramManager.running();

    mutex.P();
    printf("1 counter: %d\n",counter);
    counter += 1;
    dword temp = 0xffffff;
    while (temp)
        --temp;
    printf("1 counter: %d\n", counter);
    mutex.V();
    while(1){}
}

void thirdThread(void *arg)
{
    PCB *cur = sysProgramManager.running();

    mutex.P();
    printf("2 counter: %d\n", counter);
    counter -= 1;
    printf("2 counter: %d\n", counter);
    mutex.V();
    while(1) {}
}

void firstThread(void *arg)
{
    counter = 10;

    mutex.initialize(1);
    _enable_interrupt();

    sysProgramManager.executeProcess((void *)firstProcess, "second process", 1);

    while (1)
    {
        //printf("YES\n");
    }
}