#ifndef THREAD_H
#define THREAD_H

#include "type.h"
#include "bitmap.h"

#define offset(struct_type, member) (int)(&((struct_type *)0)->member)
#define elem2entry(struct_type, struct_member_name, elem_ptr) \
    (struct_type *)((int)elem_ptr - offset(struct_type, struct_member_name))

typedef void ThreadFunction(void *);

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

struct ThreadListItem
{
    ThreadListItem *previous;
    ThreadListItem *next;
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
    void (*eip)(void);
    dword cs;
    dword eflags;
    void *esp;
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
    dword magic;
};

// 创建线程，返回pid
dword createThread(PCB *thread, ThreadFunction func, void *arg, byte priority);

class ThreadList
{
public:
    ThreadListItem head;

public:
    // 初始化ThreadList
    ThreadList();
    // 显式初始化ThreadList
    void initialize();
    // 返回ThreadList元素个数
    int size();
    // 返回ThreadList是否为空
    bool empty();
    // 返回指向ThreadList最后一个元素的指针
    // 若没有，则返回nullptr
    ThreadListItem *back();
    // 将一个元素加入到ThreadList的结尾
    void push_back(ThreadListItem *itemPtr);
    // 删除ThreadList最后一个元素
    void pop_back();
    // 返回指向ThreadList第一个元素的指针
    // 若没有，则返回nullptr
    ThreadListItem *front();
    // 将一个元素加入到ThreadList的头部
    void push_front(ThreadListItem *itemPtr);
    // 删除ThreadList第一个元素
    void pop_front();
    // 将一个元素插入到pos的位置处
    void insert(int pos, ThreadListItem *itemPtr);
    // 删除pos位置处的元素
    void erase(int pos);
    // 返回指向pos位置处的元素的指针
    ThreadListItem *at(int pos);
    // 返回给定元素在ThreadList中的序号
    int find(ThreadListItem *itemPtr);
};

ThreadList _all_threads,_ready_threads = ThreadList();

void _schedule_thread();
void _thread_switch_save(PCB *thread);
void _thread_switch_recover(PCB *thread);
void _block_thread();
void _wake_up_thread(PCB *thread);

#endif