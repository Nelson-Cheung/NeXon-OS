#ifndef THREAD_H
#define THREAD_H

#include "type.h"
#include "bitmap.h"
#include "threadlist.h"
#include "addresspool.h"

#define offset(struct_type, member) (int)(&((struct_type *)0)->member)
#define elem2entry(struct_type, struct_member_name, elem_ptr) \
    (struct_type *)((int)elem_ptr - offset(struct_type, struct_member_name))

typedef void ThreadFunction(void *);
void kernelThread(ThreadFunction *function, void *arg);

dword PID = 0;

extern "C" void *_running_thread();
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

    dword unusedAddress;
    ThreadFunction *function;
    void *funcArg;
};

struct PCB
{
    dword *stack;
    enum ThreadStatus status;
    byte priority;
    dword pid;
    dword ticks;
    dword ticksPassedBy;
    ThreadListItem tagInGeneralList;
    ThreadListItem tagInAllList;
    dword *pageDir;
    AddressPool userVaddr;
    dword magic;
};

// 创建线程，返回pid
dword createThread(PCB *thread, ThreadFunction func, void *arg, byte priority);

ThreadList _all_threads,_ready_threads = ThreadList();

void _schedule_thread();
void _thread_switch_save(PCB *thread);
void _thread_switch_recover(PCB *thread);
void _block_thread();
void _wake_up_thread(PCB *thread);

#endif