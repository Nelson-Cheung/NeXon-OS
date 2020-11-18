#ifndef PROGRAM_MANAGER
#define PROGRAM_MANAGER

#include "thread.h"
#include "../memory/memory.h"
#include "threadlist.h"
#include "../cstdio.h"

extern "C" void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp);

// 两个PCB指针
extern "C" void _switch_thread_to(void *cur, void *next);
extern "C" void sys_fork_entry(PCB *parent, PCB *child);
extern "C" void sys_start_process(dword esp);
extern "C" dword sys_update_cr3(dword address);

// 向外提供的系统调用
void sysExit(dword status);
// 复制进程
void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp);
// 从文件名加载进程运行, 用户进程初始化，构建用户进程上下文环境
void startProcess(void *filename);

class ProgramManager
{
public:
    PCB *currentRunning; // 当前执行的线程/进程的PCB
    ThreadList allPrograms, readyPrograms;

public:
    // 初始化
    void initialize();
    // 线程调度
    void schedule();
    // 阻塞线程
    void block();
    // 唤醒线程
    void wakeUp(PCB *program);
    // 正在执行的线程/进程的pid
    PCB *running();
    
    // 创建线程并运行，返回pid
    dword executeThread(ThreadFunction func, void *arg, const char *name, byte priority);

    // 创建用户进程
    dword executeProcess(void *filename, const char *name, dword priority);

    dword fork();
    // 进程退出
    void exit(dword status);
    // 父进程等待其所有子进程完成后再执行，以实现进程同步
    dword wait(dword *wstatus);

private:
    /**
     * 线程/进程的函数
     */

    // 找到一个可用的pid
    dword allocatePid();
    // 创建一个线程的PCB并返回
    PCB *buildThreadPCB(ThreadFunction func, void *arg, const char *name, byte priority);
    // 按pid查找线程
    PCB *findProgramByPid(dword pid);

    PCB *threadListItem2PCB(ThreadListItem *item);

    // 激活线程或进程页目录表
    void activatePageDir(PCB *thread);

    // 激活线程或进程页表
    void activatePageTab(PCB *thread);

    // 创建用户进程的页目录表
    dword *createPageDir();

    // 创建用户虚拟地址池
    void createUserVaddrPool(PCB *pcb);

    // 查找一个子进程
    PCB *findChildProcess(dword parentPid);

    /**
     * fork相关函数
     */

    /**
     * wait、exit相关函数
     */
    // 唤醒父进程
    void backToParent();

    friend void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp);
};

ProgramManager sysProgramManager;

#endif