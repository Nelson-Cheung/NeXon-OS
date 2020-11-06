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

#endif