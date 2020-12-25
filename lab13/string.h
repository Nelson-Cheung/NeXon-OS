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

dword ToInt(const byte *str)
{
    dword i, ans;

    ans = 0;
    for (i = 0; str[i] != '\0'; ++i)
    {
        ans = ans * 10 + str[i] - '0';
    }

    return ans;
}

// ******************************************************//

dword firstInString(const byte *str, const byte c)
{
    dword i = 0;
    while (str[i] && str[i] != c)
    {
        ++i;
    }

    return i;
}

namespace strlib
{
    int len(const char *str)
    {
        int len = 0;
        while (str[len])
            ++len;
        return len;
    }

    int firstIn(const char *str, const char c)
    {
        int i = 0;
        while (str[i] && str[i] != c)
        {
            ++i;
        }

        return i;
    }

    int lastIn(const char *str, const char c)
    {
        int index = len(str) - 1;
        while (index > -1 && str[index] != c)
        {
            --index;
        }
        return index;
    }

    void strcpy(const char *src, char *dst, dword start, dword len)
    {
        for (int i = 0; i < len; ++i)
        {
            dst[i] = src[start + i];
        }
        dst[len] = '\0';
    }

    int strcmp(const char *left, const char *right)
    {
        int i;

        for (i = 0; left[i] && right[i]; ++i)
        {
            if (left[i] < right[i])
                return -1;
            else if (left[i] > right[i])
                return 1;
        }

        if (left[i] < right[i])
            return -1;
        else if (left[i] > right[i])
            return 1;
        else
            return 0;
    }
} // namespace strlib
#endif