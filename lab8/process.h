#ifndef PROCESS_H
#define PROCESS_H

#include "thread.h"

#define USER_STACK_VADDR (0xc0000000 - 0x1000)
#define USER_VADDR_START 0x8048000

// 用户进程初始化，构建用户进程上下文环境
void startProcess(void *filename);
// 激活线程或进程页目录表
void activatePageDir(PCB *thread);
// 激活线程或进程页表
void activatePageTab(PCB *thread);
// 创建用户进程的页目录表
dword *createPageDir();
// 创建用户虚拟地址池
void createUserVaddrPool(PCB *pcb);
// 创建用户进程
void executeProcess(void *filename, char *name);

#endif