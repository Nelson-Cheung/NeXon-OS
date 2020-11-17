#include "program_manager.h"
#include "../interrupt.h"
#include "../cstdlib.h"

// 线程调度
void ProgramManager::schedule()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    // 只剩下一个线程/进程
    if (allPrograms.find(&(currentRunning->tagInAllList)) == -1)
        return;

    if (currentRunning->status == ThreadStatus::RUNNING)
    {
        currentRunning->status = ThreadStatus::READY;
        currentRunning->ticks = currentRunning->priority;
        readyPrograms.push_back(&(currentRunning->tagInGeneralList));
        //printf("schedule %x\n", currentRunning);
    }
    else
    {
    }

    ThreadListItem *item = readyPrograms.front();
    PCB *next = (PCB *)(((dword)item) & 0xfffff000);
    PCB *cur = currentRunning;
    next->status = ThreadStatus::RUNNING;
    currentRunning = next;

    readyPrograms.pop_front();

    activatePageTab(next);

    _switch_thread_to(cur, next);
    _enable_interrupt();
}

// 阻塞当前线程
void ProgramManager::block()
{
    currentRunning->status = ThreadStatus::BLOCKED;
    schedule();
}

// 唤醒线程
void ProgramManager::wakeUp(PCB *program)
{
    program->status = ThreadStatus::READY;
    readyPrograms.push_front(&(program->tagInGeneralList));
}

// 正在执行的线程/进程的pcb
PCB *ProgramManager::running()
{
    return currentRunning;
}

dword ProgramManager::executeThread(ThreadFunction func, void *arg, const char *name, byte priority)
{
    PCB *thread = buildThreadPCB(func, arg, name, priority);

    if (!thread)
        return -1;

    // 加入线程队列
    bool interruptStatus = _interrupt_status();
    _disable_interrupt();
    allPrograms.push_back(&(thread->tagInAllList));
    readyPrograms.push_back(&(thread->tagInGeneralList));
    _set_interrupt(interruptStatus);

    return thread->pid;
}

// 找到一个可用的pid
dword ProgramManager::allocatePid()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    // 0号线程
    if (allPrograms.empty())
        return 0;

    dword pid = -1;
    PCB *program;

    for (int i = 0; i < MAX_PROGRAM_AMOUNT; ++i)
    {
        program = findProgramByPid(i);
        if (!program)
        {
            pid = i;
            break;
        }
    }

    _set_interrupt(status);

    return pid;
}

PCB *ProgramManager::findProgramByPid(dword pid)
{
    bool status = _interrupt_status();
    _disable_interrupt();

    ThreadListItem *item = allPrograms.head.next;
    PCB *program, *ans;

    ans = nullptr;
    while (item)
    {

        program = (PCB *)(((dword)item) & 0xfffff000);
        //printf("find pid: %d\n", program->pid);
        if (program->pid == pid)
        {
            ans = program;
            break;
        }
        item = item->next;
    }

    _set_interrupt(status);

    return ans;
}

// 创建一个线程的PCB并返回
PCB *ProgramManager::buildThreadPCB(ThreadFunction func, void *arg, const char *name, byte priority)
{
    PCB *thread = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!thread)
        return nullptr;

    memset((byte *)thread, 0, PAGE_SIZE);

    for (int i = 0; i < MAX_PROGRAM_NAME && name[i]; ++i)
    {
        (thread->name)[i] = name[i];
    }

    thread->status = ThreadStatus::READY;
    thread->priority = priority;
    thread->ticks = priority;
    thread->ticksPassedBy = 0;
    thread->pageDir = nullptr;

    /*
    // 初始化文件描述符数组
    for (dword i = 0; i < MAX_FILE_OPEN_PER_PROCESS; ++i)
    {
        if (i < 3)
        {
            // 预留三个标准输入流，标准输出流，标准错误流
            thread->fileDescriptors[i] = i;
        }
        else
        {
            thread->fileDescriptors[i] = -1;
        }
    }
*/

    thread->pid = allocatePid();
    if (thread->pid == -1)
    {
        // 释放前面分配的资源
        releaseKernelPage((dword)thread, 1);
        return nullptr;
    }

    thread->stack = (dword *)((dword)thread + PAGE_SIZE - sizeof(ThreadInterruptStack) - sizeof(ThreadStack));

    ThreadStack *threadStack = (ThreadStack *)thread->stack;
    threadStack->eip = (dword)func;
    threadStack->ret = (dword)sysExit; // kernelThread返回地址
    threadStack->arg = arg;
    threadStack->ebp = 0;
    threadStack->ebx = 0;
    threadStack->esi = 0;
    threadStack->edi = 0;

    return thread;
}

PCB *ProgramManager::threadListItem2PCB(ThreadListItem *item) {
    return (PCB *)(((dword)item) & 0xfffff000);
}