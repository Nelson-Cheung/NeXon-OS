#ifndef THREAD_LIST_H
#define THREAD_LIST_H

struct ThreadListItem
{
    ThreadListItem *previous;
    ThreadListItem *next;
};

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

#endif