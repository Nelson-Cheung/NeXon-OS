    
    // 和进程的创建基本一致
    PCB *child = (PCB *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!child)
    {
        return nullptr;
    }
    PCB *parent = (PCB *)_running_thread();

    /****************************************
     * 内核空间寻址，因为是内核空间的内容，所以不需要切换父子进程页表也可以进行正常寻址
     ****************************************/

    //主要是为了复制栈的内容

    memcpy(parent, child, PAGE_SIZE);
    child->status = ThreadStatus::READY;
    child->ticksPassedBy = 0;

    child->pageDir = nullptr;

    return child;


    return child;