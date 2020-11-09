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

    DirectoryEntry rootDir;

    rootDir.inode = 0;
    rootDir.type = DIRECTORY_FILE;

    sysFileSystem.createFile("/NeXon", REGULAR_FILE);
    dword handle = sysFileSystem.openFile("/NeXon", true, REGULAR_FILE);
    if (handle == -1)
    {
        while (1)
        {
        }
    }

    printFileSystem(0, rootDir);

    sysFileSystem.appendFileBlock(handle);
    sysFileSystem.writeFileBlock(handle, 0,
                                 (void *)"Welcome to NeXon world!\n"
                                         "Author: Nelson Cheung\n"
                                         "Enjoy your trip\n");
    byte buffer[SECTOR_SIZE + 1];
    sysFileSystem.readFileBlock(handle, 0, buffer);
    printf("file content\n%s\n", buffer);

    sysFileSystem.popFileBlock(handle);

    sysFileSystem.appendFileBlock(handle);
    sysFileSystem.appendFileBlock(handle);

    for (int i = 0; i < SECTOR_SIZE; ++i)
    {
        buffer[i] = 'a';
    }

    buffer[SECTOR_SIZE] = '\0';

    sysFileSystem.writeFileBlock(handle, 0, buffer);

    for (int i = 0; i < SECTOR_SIZE; ++i)
    {
        buffer[i] = 'b';
    }

    buffer[SECTOR_SIZE] = '\0';
    sysFileSystem.writeFileBlock(handle, 1, buffer);

    sysFileSystem.readFileBlock(handle, 0, buffer);
    printf("file content\n%s\n", buffer);
    sysFileSystem.readFileBlock(handle, 1, buffer);
    printf("file content\n%s\n", buffer);
    while (1)
    {
    }
}