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
    // sysDiskManager.initialize();
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

    //sysFileSystem.init();

    Inode root;
    Disk::readBytes(103 * SECTOR_SIZE, &root, sizeof(root));
    printf("root size: %d, block amount: %d, id: %d, blocks[0]: %d\n",
           root.size, root.blockAmount, root.id, root.blocks[0]);
    /*
    DirectoryEntry entry;
    Disk::readBytes(492 * SECTOR_SIZE, &entry, sizeof(DirectoryEntry));
    printf("inode: %d, name: %s, type: %d\n",
           entry.inode, entry.name, entry.type);

    printf("%d\n", sizeof(DirectoryEntry));
    Disk::readBytes(492 * SECTOR_SIZE + sizeof(DirectoryEntry), &entry, sizeof(DirectoryEntry));
    printf("inode: %d, name: %d %d, type: %d\n",
           entry.inode, entry.name[0], entry.name[1], entry.type);

        Inode root;
    Disk::readBytes(103 * SECTOR_SIZE, &root, sizeof(root));
    

    DirectoryEntry rootDir;
    rootDir.inode = 0;
    rootDir.type = DIRECTORY_FILE;

    DirectoryEntry entry;

    entry = sysFileSystem.getEntryInDirectory(rootDir, ".", DIRECTORY_FILE);
    printf("inode: %d, name: %d %d, type: %d\n",
           entry.inode, entry.name[0], entry.name[1], entry.type);

    entry = sysFileSystem.getEntryInDirectory(rootDir, "..", DIRECTORY_FILE);
    printf("inode: %d, name: %d %d, type: %d\n",
           entry.inode, entry.name[0], entry.name[1], entry.type);

    entry = sysFileSystem.getEntryInDirectory(rootDir, ".", REGULAR_FILE);
    printf("inode: %d\n", entry.inode);

    entry = sysFileSystem.getEntryInDirectory(rootDir, "nelson", REGULAR_FILE);
    printf("inode: %d\n", entry.inode);
    */

    bool ans;
    DirectoryEntry rootDir, current;

    rootDir.inode = 0;
    rootDir.type = DIRECTORY_FILE;

    ans = sysFileSystem.createEntryInDirectory(rootDir, "first file", REGULAR_FILE);
    printf("create file in /, result: %d\n", ans);

    printFileSystem(0, rootDir);

    ans = sysFileSystem.createEntryInDirectory(rootDir, "first dir", DIRECTORY_FILE);
    printf("create directory in /, result: %d\n", ans);

    printFileSystem(0, rootDir);

    current = sysFileSystem.getEntryInDirectory(rootDir, "first dir", DIRECTORY_FILE);
    //printf("inode: %d, name: %s, type: %d\n", current.inode, current.name, current.type);

    if (current.inode != -1)
    {
        ans = sysFileSystem.createEntryInDirectory(current, "first file", REGULAR_FILE);
        printf("create file in /first dir/, result: %d\n", ans);
        printFileSystem(0, rootDir);

        ans = sysFileSystem.createEntryInDirectory(current, "first dir", DIRECTORY_FILE);
        printf("create directory in /first dir/, result: %d\n", ans);
        printFileSystem(0, rootDir);
    }
    while (1)
    {
    }
}