#ifndef PANIC_H
#define PANIC_H

#include "interrupt.h"
#include "cstdio.h"

#define PANIC_MEMORY_EXHAUSTED 0

class PANIC
{
public:
    static void halt(dword type, const char *position = "", const char *information = "")
    {
        printf("---PANIC---\n"
               "-type: %d\n"
               "-position: %s\n"
               "-information: %s\n",
               type, position, information);
        _disable_interrupt();
        while (1)
        {
        }
    }
};
#endif