#ifndef PROGRAM_CONFIGURE
#define PROGRAM_CONFIGURE

// 最大线程/进程数
#define MAX_PROGRAM_AMOUNT 16
// 最大线程名
#define MAX_PROGRAM_NAME 16
// 用户进程栈起始地址
#define USER_STACK_VADDR (0xc0000000 - 0x1000)
// 用户堆虚拟地址起始地址
#define USER_VADDR_START 0x8048000

#endif