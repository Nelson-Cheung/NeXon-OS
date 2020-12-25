#ifndef UTILS_H
#define UTILS_H

#include "type.h"

// 小端方式
dword BytesToDec(byte *s, dword len)
{
    if (len == 0)
        return 0;

    dword ans, index;

    // 无符号数的处理
    ans = 0;
    index = len;
    do
    {
        --index;
        ans = ans * 256 + s[index];
    } while (index > 0);

    return ans;
}

dword bcd2int(dword bcd) {
    dword ints[8];
    dword ans = 0;

    for( int i = 0; i < 8; ++i ) {
        ints[i] = bcd & 0xf;
        bcd = bcd >> 4;
    }

    for( int i = 7; i >= 0; --i) {
        ans = ans * 10 + ints[i];
    }

    return ans;
}
#endif