#include "threadlist.h"
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