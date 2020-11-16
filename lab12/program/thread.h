#ifndef THREAD_H
#define THREAD_H

#include "../configure/type.h"
#include "program_configure.h"
#include "threadlist.h"
#include "addresspool.h"

// 定义标识符ThreadFunction为函数指针void (*)(void *)类型
typedef void (*ThreadFunction)(void *);

// 线程的状态
enum ThreadStatus
{
    RUNNING,
    READY,
    BLOCKED,
    WAITING,
    HANGING,
    DIED
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
    //MemoryManager memoryManager;                      // 进程内存管理者
    //dword fileDescriptors[MAX_FILE_OPEN_PER_PROCESS]; // 保存的是文件表中的下标
    dword parentPid;                                  // 父进程pid
    dword returnStatus;                               // 返回状态保存
    
};

#endif