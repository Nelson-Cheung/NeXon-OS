#ifndef CSTDLIB_H
#define CSTDLIB_H

#include "oslib.h"

// 加载用户程序
void _start_program(dword num);
void memset(byte *buffer, byte value, dword length);

void _start_program(dword num)
{
    /*byte buffer[512];

    switch (num)
    {
    case 4:
        sys_read_hd(1089);

        break;

    default:
        break;
    }
    */
}

void memset(byte *buffer, byte value, dword length)
{
    for (int i = 0; i < length; ++i)
    {
        buffer[i] = value;
    }
}
#endif