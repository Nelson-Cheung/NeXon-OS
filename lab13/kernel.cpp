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
#include "program/lock.h"

#include "syscall.cpp"

#include "shell/shell.cpp"

#include "ext2/fs.cpp"
#include "disk/disk_bitmap.cpp"

#include "devices/keyboard.cpp"

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

    // 初始化键盘驱动
    sysKeyboard.initialize();
}

dword counter;

void firstProcess(void *arg)
{
    dword pid = fork();

    if (pid)
    {
        while (1)
        {
            wait(nullptr);
        }
    }
    else
    {
        Shell shell;
        shell.run();
    }
}

void secondThread(void *arg)
{
    byte code;
    printf("second wait\n");
    while (1)
    {
        //printf("second wait\n");
        while (!sysKeyboard.pop(&code))
        {
           // printf("second wait\n");
        }
        printf("second: %d\n", code);
    }
}

void thirdThread(void *arg)
{
    byte code;
   // printf("third wait\n");

    while (1)
    {
        while (!sysKeyboard.pop(&code))
        {
           // printf("third wait\n");
        }
        printf("third: %d\n", code);
    }
}
void firstThread(void *arg)
{
    counter = 10;

    mutex.initialize(1);
    _enable_interrupt();

    /*
    bool ans;
    DirectoryEntry rootDir, current;
    rootDir.inode = 0;
    rootDir.type = DIRECTORY_FILE;
    rootDir.setName("/");

    byte buf[SECTOR_SIZE + 1];
    memset(buf, 0, SECTOR_SIZE + 1);

    printFileSystem(0, rootDir);
    */
    // sysProgramManager.executeProcess((void *)firstProcess, "", 1);

    sysProgramManager.executeThread(secondThread, nullptr, "", 1);
    sysProgramManager.executeThread(thirdThread, nullptr, "", 1);
    while(1) {}
    Semaphore mutex;
    mutex.initialize(1);
    mutex.P();
    printf("acquire lock!\n");
    mutex.P();
    printf("acquire lock again\n");

    while (1)
    {
    }
}