#ifndef THREAD_H
#define THREAD_H

#include "type.h"
#include "bitmap.h"
#include "threadlist.h"
#include "addresspool.h"
#include "memory.h"
#include "configure/os_configure.h"

// 找到结构体成员在结构体中的偏移
#define offset(struct_type, member) (int)(&((struct_type *)0)->member)
// 通过结构体中的某个成员的地址找到结构体的地址
#define elem2entry(struct_type, struct_member_name, elem_ptr) \
    (struct_type *)((int)elem_ptr - offset(struct_type, struct_member_name))

typedef void ThreadFunction(void *);
void kernelThread(ThreadFunction *function, void *arg);
void kernelThreadReturn();

dword PID = 0;

// 两个PCB指针
extern "C" void _switch_thread_to(void *cur, void *next);

enum ThreadStatus
{
    RUNNING,
    READY,
    BLOCKED,
    WAITING,
    HANGING,
    DIED
};

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
    void (*eip)(ThreadFunction *func, void *arg);

    dword unusedAddress; // kernelThread的返回地址
    ThreadFunction *function;
    void *funcArg;
};

struct PCB
{
    dword *stack;                    // 栈指针，用于调度时保存esp
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
    dword fileDescriptors[MAX_FILE_OPEN_PER_PROCESS]; // 保存的是文件表中的下标
    dword parentPid;                                  // 父进程pid
    dword returnStatus;                               // 返回状态保存

    dword magic; // 魔数
};

// 创建线程，返回pid
dword createThread(PCB *thread, ThreadFunction func, void *arg, byte priority);

ThreadList _all_threads, _ready_threads;

void _schedule_thread();
//void _thread_switch_save(PCB *thread);
//void _thread_switch_recover(PCB *thread);
void _block_thread();
void _wake_up_thread(PCB *thread);
void *_running_thread();

PCB *currentRunningThread;

#endif