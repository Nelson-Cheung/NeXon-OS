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

#include "shell/shell.cpp"

#include "ext2/fs.cpp"

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

    // 初始化文件系统
    sysFileSystem.init();
}

dword counter;

void firstProcess(void *arg)
{
    dword pid = fork();

    if (pid)
    {
        while ((pid = wait(nullptr)) != -1)
        {
            printf("revoke child process: %d\n", pid);
        }
    }
    else
    {
        printf("pid: %d, I am child!\n", sysProgramManager.currentRunning->parentPid);
    }
}

void secondThread()
{
    printf("process exit\n");
}

void thirdThread(void *arg)
{
    printf("exit third thread\n");
}

void firstThread(void *arg)
{
    counter = 10;

    mutex.initialize(1);
    _enable_interrupt();

   // printf("%x %x %x %x\n", _switch_thread_to, firstProcess, TimeInterruptResponse, syscall);

    //sysProgramManager.executeProcess((void *)firstProcess, nullptr, 1);
    //  sysProgramManager.executeThread((ThreadFunction)secondThread, nullptr, "", 1);

    while (1)
    {
        dword temp = 0xffffff;
        while (temp)
            --temp;
        printf("2\n");
    }
}