#include "sync.h"
#include "program_manager.h"
#include "../interrupt.h"
#include "../cstdio.h"

Semaphore::Semaphore()
{
    this->counter = 0;
    waiters.initialize();
}

void Semaphore::initialize(byte counter)
{
    this->counter = counter;
    waiters.initialize();
}

void Semaphore::P()
{

    PCB *cur;

    while (!counter)
    {
        bool status = _interrupt_status();
        _disable_interrupt();

        PCB *cur = sysProgramManager.running();
        waiters.push_back(&(cur->tagInGeneralList));
        cur->status = ThreadStatus::BLOCKED;

        _set_interrupt(status); // 调度前需要开中断，否则进程无法被调度
        userScheduleThread();
    }

    --counter;
}

void Semaphore::V()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    ++counter;
    if (waiters.size())
    {
        ThreadListItem *item = waiters.front();
        PCB *thread = (PCB *)(((dword)item) & 0xfffff000);
        waiters.pop_front();
        sysProgramManager.wakeUp(thread);
    }

    _set_interrupt(status);
}
