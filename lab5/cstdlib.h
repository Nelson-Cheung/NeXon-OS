#ifndef CSTDLIB_H
#define CSTDLIB_H

#include "oslib.h"

// 加载用户程序
void _start_program(dword num);

void _start_program(dword num) {
    byte buffer[512];

    switch (num)
    {
    case 4:
        sys_read_hd(1089);
        
        break;
    
    default:
        break;
    }
}

#endif