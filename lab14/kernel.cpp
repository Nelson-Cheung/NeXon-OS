#include "kernel/oslib.h"
#include "clib/string.h"
#include "clib/utils.h"
#include "kernel/interrupt.h"
#include "clib/cstdio.h"
#include "shell/executable.h"
#include "shell/multiprocess.h"
#include "program/lock.h"

#include "memory/memory.cpp"
#include "program/memory_manager.cpp"
#include "program/thread.cpp"
#include "program/process.cpp"
#include "program/program_manager.cpp"
#include "program/threadlist.cpp"
#include "program/addresspool.cpp"
#include "program/sync.cpp"
#include "kernel/syscall.cpp"
#include "shell/shell.cpp"
#include "ext2/fs.cpp"
#include "disk/disk_bitmap.cpp"
#include "devices/keyboard.cpp"

void init();
void firstThread(void *arg);

extern "C" void Kernel();

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

void firstProcess(void *arg)
{
    dword pid = fork();

    if (pid)
    {
        while (true)
        {
            pid = wait(nullptr);
        }
    }
    else
    {
        Shell shell;
        shell.run();
    }
}

void firstThread(void *arg)
{
    _enable_interrupt();
    sysProgramManager.executeProcess((void *)firstProcess, "", 1);
    while (1)
    {
    }
}