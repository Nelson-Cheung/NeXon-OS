fork的作用是利用老进程克隆出一个新进程并使新进程执行。

新进程之所以能够执行，本质上是它具备程序体，这其中包括代码和数据等资源。因此 fork 就是把某个进程的全部资源复制了一份，然后让处理器的 cs:eip寄存器指向新进程的指令部分。  

fork的实现分为两步，复制进程资源，然后跳转执行

子进程复制的资源



进程的PCB

位图

内核空间分配的页表

用户空间分配出去的页表



用户栈

内核栈

虚拟地址池

页表



具体实现

PCB所在的页表页表

虚拟地址位图存取的内核空间分配的页表）

虚拟地址中的有效页表



复制PCB时需要单独实现，因为esp会随着函数过程运行而时刻发生变化，并且PCB::stack并不会实时更新，也就是说，在复制PCB之前需要“冻结”PCB的内容，找到恰当的esp来进行复制。此后，即使esp发生变化也无需考虑。

复制PCB时，GCC对局部变量的访问统一使用ss::esp的方式来访问。因此，复制了PCB也就复制的线程。

但是，子线程的PCB的stack变量需要发生变化来作为子线程的esp。同时，ebp也需要发生对应的变化。由于父子线程的数据是一一对应的，只要对父进程的stack和ebp加上dst-src的偏移即可。

关键过程最好在汇编中完成。一个巧妙的设计，可以将线程打包为一个等待中的线程，然后其会从fork发生点往下运行。

```asm
sys_fork_entry:
    push eax
    push ebp
    mov ebp, esp ;进程冻结点

    push ebx
    push edi
    push esi
    ; 参数从右向左依次入栈
    push ebp

    ; 子进程fork进入点
    push FORK_ENTRY

    ; child
    mov eax, [ebp + 4 * 4]
    push eax

    ; parent
    mov eax, [ebp + 4 * 3]
    push eax

    call copyProcess
    add esp, 4 * 7
FORK_ENTRY:
    pop ebp
    pop eax
    ret
```



内核线程无法fork，因为fork需要镜像地对源线程进行复制，并且fork之前的指令非常有可能使用源线程的地址。因此，我们无法简单地修改虚拟地址来镜像复制源线程，虚拟地址必须保持不变。我们唯有改变虚拟地址对应的物理地址来实现线程的复制。显然，内核虚拟地址对应的物理地址是无法随意更换的。注意到每一个进程都有自己的页目录表和页表，所以对于进程而言，我们可以为子进程创建一个和父进程完全相同的页目录表和页表，但物理地址显然不同，然后将父进程页表的内容复制到子进程的页表即可。

所以，只有用户进程才可以实现fork，内核线程无法实现fork。

内核中PCB对应的页表和页目录项也需要重新复制和修改。

```cpp
    //将父进程PCB虚拟地址对应的物理页修改为子进程的物理页
    dword childPCBaddr = vaddr2paddr((dword)child);
    // 存放PCB地址的页表
    dword *pageOfPCB = (dword *)allocatePages(AddressPoolType::KERNEL, 1);
    if (!pageOfPCB)
    {
        // 释放前面分配的资源
        return;
    }

    dword pde, pte;
    pde = ((dword)parent & 0xffc00000) >> 22;
    pte = ((dword)parent & 0x003ff000) >> 12;

    //printf("%d %d\n", pde, pte);

    dword *parentPageOfPCB = (dword *)(0xffc00000 + (pde << 12));
    memcpy(parentPageOfPCB, pageOfPCB, PAGE_SIZE);
    pageOfPCB[pte] = childPCBaddr | 0x7;
    dword pageOfPCBaddr = vaddr2paddr((dword)pageOfPCB);
    child->pageDir[pde] = pageOfPCBaddr | 0x7;
```

