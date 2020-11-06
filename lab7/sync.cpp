#include "sync.h"
#include "interrupt.h"
#include "cstdio.h"
void test()
{
    _disable_interrupt();
    _enable_interrupt();
}
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
    bool status = _interrupt_status();
    _disable_interrupt();

    PCB *cur;

    while (!counter)
    {
        PCB *cur = (PCB *)_running_thread();
        //printf("block thread, pid: %d\n", cur->pid);
        waiters.push_back(&(cur->tagInGeneralList));
        _block_thread();
    }

    --counter;
    _set_interrupt(status);
}

void Semaphore::V()
{
    bool status = _interrupt_status();
    _disable_interrupt();

    ++counter;
    if (waiters.size())
    {
        PCB *thread = elem2entry(PCB, tagInGeneralList, waiters.front());
        waiters.pop_front();
        //printf("wake up thread, pid: %d, status: %d\n", thread->pid, status);
        _wake_up_thread(thread);
    }

    _set_interrupt(status);
}
