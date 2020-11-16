#ifndef PROGRAM_MANAGER
#define PROGRAM_MANAGER

#include "thread.h"
#include "../memory.h"
#include "threadlist.h"
#include "../cstdio.h"

extern "C" void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp);

// 两个PCB指针
extern "C" void _switch_thread_to(void *cur, void *next);
extern "C" void sys_fork_entry(PCB *parent, PCB *child);

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

    dword fork();
    // 进程退出
    void exit(dword status);
    // 父进程等待其所有子进程完成后再执行，以实现进程同步
    void wait(dword *wstatus);

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

    /**
     * fork相关函数
     */

    // 复制当前进程到一个新进程中，返回进程的PCB
    //PCB *copyProcess();

    /**
     * wait、exit相关函数
     */
    // 唤醒父进程
    void backToParent(dword pid);
};

ProgramManager sysProgramManager;

// 向外提供的系统调用
void sysExit(dword status)
{
    printf("thread exit, pid: 0x%x\n", sysProgramManager.running()->pid);
    while(1){}
    //sysProgramManager.exit(status);
}

void copyProcess(PCB *parent, PCB *child, dword entry, dword esp, dword esi, dword edi, dword ebx, dword ebp) {

}
#endif