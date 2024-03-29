#ifndef SYS_CALL_H
#define SYS_CALL_H

#include "type.h"

// 如果要获取eax寄存器的内容，geteax需要首先被调用
extern "C" dword sysGetEax();
extern "C" dword sysGetEbx();
extern "C" dword sysGetEcx();
extern "C" dword sysGetEdx();
extern "C" dword sysGetEsi();
extern "C" dword sysGetEdi();
extern "C" void sysSetEax(dword value);
extern "C" void sysSetEbx(dword value);
extern "C" void sysSetEcx(dword value);
extern "C" void sysSetEdx(dword value);
extern "C" void sysSetEsi(dword value);
extern "C" void sysSetEdi(dword value);
extern "C" void *sysStartSysCall();

#define SYSCALL_AMOUNT 30
void *syscallTable[SYSCALL_AMOUNT]; // 系统调用函数表

#define SYSCALL_FIRST_SYS_CALL 0
#define SYSCALL_WRITE 1
#define SYSCALL_SCHEDULE_THREAD 2
#define SYSCALL_MALLOC 3
#define SYSCALL_FREE 4
#define SYSCALL_KERNEL_MALLOC 5
#define SYSCALL_KERNEL_FREE 6
#define SYSCALL_FORK 7
#define SYSCALL_EXIT 8
#define SYSCALL_WAIT 9
#define SYSCALL_MOVE_CURSOR 10
#define SYSCALL_PUT_CHAR 11
#define SYSCALL_GET_CHAR 12
#define SYSCALL_GET_CURSOR 13
#define SYSCALL_FILE_OPEN 14
#define SYSCALL_FILE_CLOSE 15
#define SYSCALL_FILE_READ 16
#define SYSCALL_FILE_WRITE 17

// 初始化系统调用表
void sysInitializeSysCall();

/***************************************************************/

// 系统调用函数
void *syscall(dword function, dword ebx = 0, dword ecx = 0,
              dword edx = 0, dword esi = 0, dword edi = 0);

/***************************************************************/

// 内核空间的系统调用函数, 从0号开始依次排列下去
void sysFirstSysCall();                                      // 0号系统调用，首个系统调用
void sysWrite();                                             // 1号系统调用，打印特定字符串
void sysScheduleThread();                                    // 2号系统调用，进程/线程切换
void *sysMalloc();                                           // 3号系统调用，内存分配
void sysFree();                                              // 4号系统调用，内存释放
void *sysKernelMalloc();                                     // 5号系统调用，内核内存分配
void sysKernelFree();                                        // 6号系统调用，内核内存释放
dword sysFork();                                             // 7号系统调用，fork
extern void sysExit(dword status);                           // 8号系统调用，exit
dword sysWait(dword *sstatus);                               // 9号系统调用，wait
void sysMoveCursor(dword pos);                               // 10号系统调用
byte sysGetc();                                              // 11号系统调用
void sysPutc(byte c);                                        // 12号系统调用
dword sysGetCursor();                                        // 13号系统调用
dword sysFileOpen(const char *path, dword mode, dword type); // 14号系统调用，打开文件
void sysFileClose(dword handle);                             // 15号系统调用，关闭文件
void sysFileRead(dword handle, dword index, void *buffer);   // 16号系统调用，读取文件
void sysFileWrite(dword handle, dword index, void *buffer);  // 17号系统调用，写入文件

/***************************************************************/

// 用户空间的系统调用
void firstSysCall();
void write(const char *ptr);
void userScheduleThread();
void *malloc(dword size);
void free(void *address);
void *kernelMalloc(dword size);
void kernelFree(void *address);
dword fork();
void exit(dword status);
dword wait(dword *sstatus);
void moveCursor(dword pos);
byte getc();
void putc(byte c);
dword getCursor();

dword open(const char *path, dword mode, dword type);
void close(dword handle);
void read(dword handle, dword index, void *buffer);
void write(dword handle, dword index, void *buffer);

/***************************************************************/
#endif