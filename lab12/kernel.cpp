#include "oslib.h"
#include "keyboard.h"
#include "string.h"
#include "utils.h"
#include "interrupt.h"
#include "cstdio.h"
#include "bitmap.cpp"

#include "memory/memory.cpp"
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

    /*
    dword pid = createThread(&firstThread, nullptr, 2);

    PCB *next = elem2entry(PCB, tagInGeneralList, _ready_threads.front());
    currentRunningThread = next;

    currentRunningThread = next;
    next->status = ThreadStatus::RUNNING;
    _ready_threads.pop_front();
    _switch_thread_to((void *)0x9f000, next);
    */

    while (1)
        ;
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
    //sysMemoryManager.initialize();
}

dword counter;

void firstProcess(void *arg) {
    
    mutex.P();
    printf("I am first process\n");
    mutex.V();
    while(1){

    }
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

    sysProgramManager.executeProcess((void *)secondThread, "second process", 1);
    sysProgramManager.executeProcess((void *)thirdThread, "third process", 1);
    while (1)
    {
        //printf("YES\n");
    }
}