#include "sync.h"
#include "interrupt.h"
#include "cstdio.h"

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
        _disable_interrupt();
        PCB *cur = (PCB *)_running_thread();
        waiters.push_back(&(cur->tagInGeneralList));
        cur->status = ThreadStatus::BLOCKED;
        _enable_interrupt(); // 调度前需要开中断，否则进程无法被调度
        userScheduleThread();
        //_schedule_thread();
    }

    --counter;
}

void Semaphore::V()
{
    _disable_interrupt();

    ++counter;
    if (waiters.size())
    {
        PCB *thread = elem2entry(PCB, tagInGeneralList, waiters.front());
        waiters.pop_front();
        _wake_up_thread(thread);
    }

    _enable_interrupt();
}
