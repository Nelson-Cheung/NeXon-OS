#ifndef SYS_CALL_H
#define SYS_CALL_H

#include "type.h"

enum SYSCALL_NR
{
SYS_GET_PID
};

dword getpid();
#endif