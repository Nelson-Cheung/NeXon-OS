#ifndef THREAD_H
#define THREAD_H

#include "../configure/type.h"
#include "sync.h"
#include "program_configure.h"
#include "threadlist.h"
#include "addresspool.h"

// 定义标识符ThreadFunction为函数指针void (*)(void *)类型
typedef void (*ThreadFunction)(void *);

enum ArenaType
{
    ARENA_16,
    ARENA_32,
    ARENA_64,
    ARENA_128,
    ARENA_256,
    ARENA_512,
    ARENA_1024,
    ARENA_MORE
};

struct Arena
{
    ArenaType type; // Arena的类型
    dword counter;  // 如果是ARENA_MORE则counter表明页框数，否则counter表明内存块的数量
};

// 对于每个空闲的Arena内存块，利用其中的空间来存储链表中的节点的previus和next指针

struct MemoryBlockListItem
{
    MemoryBlockListItem *previous, *next;
};

// MemoryManager是在内核态调用的内存管理对象

class MemoryManager
{

private:
    // 16, 32, 64, 128, 256, 512, 1024
    static const dword MEM_BLOCK_TYPES = 7; // 内存块的类型数目
    static const dword minSize = 16;        // 内存块的最小大小
    dword arenaSize[MEM_BLOCK_TYPES];       // 每种类型对应的内存块大小
    MemoryBlockListItem *arenas[MEM_BLOCK_TYPES]; // 每种类型的arena内存块的指针
    Semaphore mutex;

public:
    MemoryManager();
    void initialize();
    void *allocate(dword size);  // 分配一块地址
    void release(void *address); // 释放一块地址

private:
    bool getNewArena(AddressPoolType type, dword index);

};

// 线程的状态
enum ThreadStatus
{
    RUNNING,
    READY,
    BLOCKED,
    DEAD
};

// 线程中断栈
struct ThreadInterruptStack
{
    dword interruptNumber;
    dword edi;
    dword esi;
    dword ebp;
    dword esp_dummy;
    dword ebx;
    dword edx;
    dword ecx;
    dword eax;
    dword gs;
    dword fs;
    dword es;
    dword ds;
    dword err_code;
    dword eip;
    dword cs;
    dword eflags;
    dword esp;
    dword ss;
};

struct ThreadStack
{
    dword ebp;
    dword ebx;
    dword edi;
    dword esi;
    dword eip; 
    dword ret; // kernelThread的返回地址
    void *arg;
};

struct PCB
{
    dword *stack;                    // 栈指针，用于调度时保存esp
    char name[MAX_PROGRAM_NAME];     // 线程名
    enum ThreadStatus status;        // 线程的状态
    byte priority;                   // 线程优先级
    dword pid;                       // 线程pid
    dword ticks;                     // 线程时间片总时间
    dword ticksPassedBy;             // 线程已执行时间
    ThreadListItem tagInGeneralList; // 线程队列标识
    ThreadListItem tagInAllList;     // 线程队列标识

    
    dword *pageDir;                                   // 页目录表地址，虚拟地址，位于内核空间
    AddressPool userVaddr;                            // 进程用户地址池
    MemoryManager memoryManager;                      // 进程内存管理者
    //dword fileDescriptors[MAX_FILE_OPEN_PER_PROCESS]; // 保存的是文件表中的下标
    dword parentPid;                                  // 父进程pid
    dword returnStatus;                               // 返回状态保存
    
};

MemoryManager sysMemoryManager;

#endif