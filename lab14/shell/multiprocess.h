#ifndef MULTIPROCESS_H
#define MULTIPROCESS_H

#include "../type.h"
#include "../syscall.h"

namespace Multiprocess
{
    struct LaunchParameter
    {
        dword x, y, x0, y0, width, height;
    };

    void multiprocess(void *arg)
    {
        //LaunchParameter *parameter = (LaunchParameter *)arg;
        printf("%x\n", arg);
    }
}; // namespace Multiprocess

#endif