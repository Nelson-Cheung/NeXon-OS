#ifndef STRING_H
#define STRING_H

#include "type.h"

dword StrLen(byte *str)
{
    dword index;
    index = 0;
    while (str[index])
    {
        ++index;
    }
    return index;
}

void StrAppend(byte *s1, byte *s2)
{
    dword start = StrLen(s1);
    dword index;

    index = 0;
    while (s2[index])
    {
        s1[index + start] = s2[index];
        ++index;
    }
    s1[index + start] = 0;
}

void CharAppend(byte *s1, byte c)
{
    dword len = StrLen(s1);
    s1[len] = c;
    ++len;
    s1[len] = 0;
}

void StrAssign(byte *s1, byte *s2)
{
    int index = 0;
    while (s2[index])
    {
        s1[index] = s2[index];
        ++index;
    }
    s1[index] = 0;
}

dword StrEqual(byte *s1, byte *s2)
{
    if (StrLen(s1) != StrLen(s2))
    {
        return 0;
    }

    dword index = 0;
    while (s1[index])
    {
        if (s1[index] != s2[index])
        {
            return 0;
        }
        ++index;
    }

    return 1;
}


dword FirstIn(byte div, byte *str)
{
    dword index;

    index = 0;
    while (str[index] && (str[index] != div))
    {
        ++index;
    }

    return index;
}

void ToLower(byte *str)
{
    dword index = 0;
    while (str[index])
    {
        if (str[index] >= 'A' && str[index] <= 'Z')
        {
            str[index] = 'a' + str[index] - 'A';
        }
        ++index;
    }
}

dword ToInt(const byte *str) {
    dword i, ans;

    ans = 0;
    for( i = 0; str[i] != '\0'; ++i ) {
        ans = ans * 10 + str[i] - '0';
    }

    return ans;
}
#endif