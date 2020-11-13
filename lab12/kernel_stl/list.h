#ifndef KERNEL_LIST_H
#define KERNEL_LIST_H

#ifdef DEBUG
#include "my_api.h"
#endif

#ifndef DEBUG
#include "../syscall.h"
#endif

/************************
涉及模板的需要在同一个文件下实现
************************/
template <typename T>
struct ListItem
{
    T value;
    ListItem<T> *previous;
    ListItem<T> *next;

    ListItem()
    {
    }
    ListItem(T value)
    {
        this->value = value;
    }
};

// T 类型应该实现copy constructor, operator =
template <typename T, typename LessThan>
class List
{
public:
    ListItem<T> head;

public:
    List(); // 初始化List
    ~List();

    void initialize(); // 显式初始化List

    int size(); // 返回List元素个数

    bool empty(); // 返回List是否为空

    bool back(T &item); // 将List最后一个元素赋值给item，并返回true。如果没有则不做修改，返回false

    void push_back(const T &item); // 将一个元素加入到List的结尾

    void pop_back(); // 删除ThreadList最后一个元素

    bool front(T &item); //将List第一个元素赋值给item，并返回true。如果没有则不做修改，返回false

    void push_front(const T &item); // 将一个元素加入到ThreadList的头部

    void pop_front(); // 删除ThreadList第一个元素

    void insert(int pos, const T &item); // 将一个元素插入到pos的位置处

    void erase(int pos); // 删除pos位置处的元素

    bool at(int pos, T &item); // 返回指向pos位置处的元素的指针

    int find(const T &item); // 返回给定元素在ThreadList中的序号

    bool assgin(int pos, const T &item); // 赋值给pos指向的位置的元素
private:
    // 判断元素是否相等
    bool equal(const T &a, const T &b);
    ListItem<T> *back();
    ListItem<T> *front();
    ListItem<T> *at(int pos);
};

template <typename T, typename LessThan>
List<T, LessThan>::List()
{
    head.next = head.previous = 0;
}

template <typename T, typename LessThan>
List<T, LessThan>::~List()
{
    while (size())
    {
        pop_front();
    }
}
template <typename T, typename LessThan>
void List<T, LessThan>::initialize()
{
    head.next = head.previous = 0;
}

template <typename T, typename LessThan>
int List<T, LessThan>::size()
{
    ListItem<T> *temp = head.next;
    int counter = 0;

    while (temp)
    {
        temp = temp->next;
        ++counter;
    }

    return counter;
}

template <typename T, typename LessThan>
bool List<T, LessThan>::empty()
{
    return size() == 0;
}

template <typename T, typename LessThan>
bool List<T, LessThan>::back(T &item)
{
    ListItem<T> *temp = back();
    if (temp)
    {
        item = temp->value;
        return true;
    }
    else
    {
        return false;
    }
}

template <typename T, typename LessThan>
ListItem<T> *List<T, LessThan>::back()
{
    ListItem<T> *temp = head.next;
    if (!temp)
        return nullptr;

    while (temp->next)
    {
        temp = temp->next;
    }

    return temp;
}

template <typename T, typename LessThan>
void List<T, LessThan>::push_back(const T &item)
{
    ListItem<T> *temp = back();
    ListItem<T> *itemPtr = (ListItem<T> *)(malloc(sizeof(T)));
    *itemPtr = item;

    if (temp == nullptr)
        temp = &head;
    temp->next = itemPtr;
    itemPtr->previous = temp;
    itemPtr->next = nullptr;
}

template <typename T, typename LessThan>
void List<T, LessThan>::pop_back()
{
    ListItem<T> *temp = back();
    if (temp)
    {
        temp->previous->next = nullptr;
        free(temp);
    }
}

template <typename T, typename LessThan>
bool List<T, LessThan>::front(T &item)
{
    ListItem<T> *temp = front();
    if (temp)
    {
        item = temp->value;
        return true;
    }
    else
    {
        return false;
    }
}

template <typename T, typename LessThan>
ListItem<T> *List<T, LessThan>::front()
{
    if (head.next)
    {
        return head.next;
    }
    else
    {
        return nullptr;
    }
}

template <typename T, typename LessThan>
void List<T, LessThan>::push_front(const T &item)
{
    ListItem<T> *temp = head.next;
    ListItem<T> *itemPtr = (ListItem<T> *)malloc(sizeof(T));
    *itemPtr = item;

    if (temp)
    {
        temp->previous = itemPtr;
    }
    head.next = itemPtr;
    itemPtr->previous = &head;
    itemPtr->next = temp;
}

template <typename T, typename LessThan>
void List<T, LessThan>::pop_front()
{
    ListItem<T> *temp = head.next;
    if (temp)
    {
        if (temp->next)
        {
            temp->next->previous = &head;
        }
        head.next = temp->next;
        free(temp);
    }
}

template <typename T, typename LessThan>
void List<T, LessThan>::insert(int pos, const T &item)
{
    if (pos == 0)
    {
        push_front(item);
    }
    else
    {
        int length = size();
        if (pos == length)
        {
            push_back(item);
        }
        else if (pos < length)
        {
            ListItem<T> *itemPtr = (ListItem<T> *)malloc(sizeof(T));
            *itemPtr = item;

            ListItem<T> *temp = at(pos);

            itemPtr->previous = temp->previous;
            itemPtr->next = temp;
            temp->previous->next = itemPtr;
            temp->previous = itemPtr;
        }
    }
}

template <typename T, typename LessThan>
void List<T, LessThan>::erase(int pos)
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
            ListItem<T> *temp = at(pos);

            temp->previous->next = temp->next;
            if (temp->next)
            {
                temp->next->previous = temp->previous;
            }

            free(temp);
        }
    }
}

template <typename T, typename LessThan>
bool List<T, LessThan>::at(int pos, T &item)
{
    ListItem<T> *temp = at(pos);
    if (temp)
    {
        item = temp->value;
        return true;
    }
    else
    {
        return false;
    }
}

template <typename T, typename LessThan>
ListItem<T> *List<T, LessThan>::at(int pos)
{
    ListItem<T> *temp = head.next;

    for (int i = 0; (i < pos) && temp; ++i, temp = temp->next)
    {
    }

    return temp;
}

template <typename T, typename LessThan>
int List<T, LessThan>::find(const T &item)
{
    ListItem<T> *temp = head.next;
    int pos = 0;

    while (temp && (!equal(temp->value, item)))
    {
        temp = temp->next;
        ++pos;
    }

    if (temp)
    {
        return pos;
    }
    else
    {
        return -1;
    }
}

template <typename T, typename LessThan>
bool List<T, LessThan>::equal(const T &a, const T &b)
{
    LessThan lt;
    return (lt(a, b) == false) && (lt(b, a) == false);
}

template <typename T, typename LessThan>
bool List<T, LessThan>::assgin(int pos, const T &item)
{
    ListItem<T> *temp = head.next;

    for (int i = 0; (i < pos) && temp; ++i, temp = temp->next)
    {
    }

    if (!temp)
        return false;
    temp->value = item;
    return true;
}
#endif