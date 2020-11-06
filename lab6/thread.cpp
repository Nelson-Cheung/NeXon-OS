#include "thread.h"
#include "memory.h"
#include "cstdio.h"
#include "cstdlib.h"
#include "interrupt.h"

static void kernelThread(ThreadFunction *function, void *arg)
{
    function(arg);
}

dword createThread(ThreadFunction func, void *arg, byte priority)
{
    PCB *thread = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!thread)
        return -1;

    memset((byte *)thread, 0, PAGE_SIZE);

    thread->status = ThreadStatus::READY;
    thread->priority = priority;
    thread->ticks = priority;
    thread->ticksPassedBy = 0;
    thread->magic = 0x19870916;

    thread->pid = PID++;
    if (PID == -1)
        PID = 0;

    thread->stack = (dword *)((dword)thread + PAGE_SIZE - sizeof(ThreadInterruptStack) - sizeof(ThreadStack));

    ThreadStack *threadStack = (ThreadStack *)thread->stack;
    threadStack->eip = kernelThread;
    threadStack->function = func;
    threadStack->funcArg = arg;
    threadStack->ebp =
        threadStack->ebx =
            threadStack->esi =
                threadStack->edi = 0;

    bool interruptStatus = _interrupt_status();
    _disable_interrupt();
     _all_threads.push_back(&(thread->tagInAllList));
    _ready_threads.push_back(&(thread->tagInGeneralList));
    _set_interrupt(interruptStatus);

    return thread->pid;
}

void _schedule_thread()
{
    PCB *cur = (PCB *)_running_thread();
    if (_all_threads.find(&(cur->tagInAllList)) == -1)
        return;

    if (cur->status == ThreadStatus::RUNNING)
    {
        cur->status = ThreadStatus::READY;
        cur->ticks = cur->priority;
        _ready_threads.push_back(&(cur->tagInGeneralList));
    }
    else
    {
    }

    PCB *next = elem2entry(PCB, tagInGeneralList, _ready_threads.front());
    _ready_threads.pop_front();
    next->status = ThreadStatus::RUNNING;

    _switch_thread_to(cur, next);
}

ThreadList::ThreadList()
{
    printf("In thread list constructor\n");
    head.next = head.previous = 0;
}

void ThreadList::initialize()
{
    head.next = head.previous = 0;
}

int ThreadList::size()
{
    ThreadListItem *temp = head.next;
    int counter = 0;

    while (temp)
    {
        temp = temp->next;
        ++counter;
    }

    return counter;
}

bool ThreadList::empty()
{
    return size() == 0;
}

ThreadListItem *ThreadList::back()
{
    ThreadListItem *temp = head.next;
    if (!temp)
        return nullptr;

    while (temp->next)
    {
        temp = temp->next;
    }

    return temp;
}

void ThreadList::push_back(ThreadListItem *itemPtr)
{
    ThreadListItem *temp = back();
    if (temp == nullptr)
        temp = &head;
    temp->next = itemPtr;
    itemPtr->previous = temp;
    itemPtr->next = nullptr;
}

void ThreadList::pop_back()
{
    ThreadListItem *temp = back();
    if (temp)
    {
        temp->previous->next = nullptr;
        // 还应该释放内存
    }
}

ThreadListItem *ThreadList::front()
{
    return head.next;
}

void ThreadList::push_front(ThreadListItem *itemPtr)
{
    ThreadListItem *temp = head.next;
    if (temp)
    {
        temp->previous = itemPtr;
    }
    head.next = itemPtr;
    itemPtr->previous = &head;
    itemPtr->next = temp;
}

void ThreadList::pop_front()
{
    ThreadListItem *temp = head.next;
    if (temp)
    {
        if (temp->next)
        {
            temp->next->previous = &head;
        }
        head.next = temp->next;
        // 还应该释放内存
    }
}

void ThreadList::insert(int pos, ThreadListItem *itemPtr)
{
    if (pos == 0)
    {
        push_front(itemPtr);
    }
    else
    {
        int length = size();
        if (pos == length)
        {
            push_back(itemPtr);
        }
        else if (pos < length)
        {
            ThreadListItem *temp = at(pos);

            itemPtr->previous = temp->previous;
            itemPtr->next = temp;
            temp->previous->next = itemPtr;
            temp->previous = itemPtr;
        }
    }
}

void ThreadList::erase(int pos)
{
    if (pos == 0)
    {
        pop_front();
    }
    else
    {
        int length = size();
        if (pos < length)
        {
            ThreadListItem *temp = at(pos);

            temp->previous->next = temp->next;
            if (temp->next)
            {
                temp->next->previous = temp->previous;
            }
        }
    }
}

ThreadListItem *ThreadList::at(int pos)
{
    ThreadListItem *temp = head.next;

    for (int i = 0; (i < pos) && temp; ++i, temp = temp->next)
    {
    }

    return temp;
}

int ThreadList::find(ThreadListItem *itemPtr)
{
    int pos = 0;
    ThreadListItem *temp = head.next;
    while (temp && temp != itemPtr)
    {
        temp = temp->next;
        ++pos;
    }

    if (temp && temp == itemPtr)
    {
        return pos;
    }
    else
    {
        return -1;
    }
}