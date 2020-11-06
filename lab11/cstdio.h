#ifndef CSTDIO_H
#define CSTDIO_H

#include <stdarg.h>
#include "type.h"
#include "keyboard.h"
#include "ctype.h"
#include "oslib.h"
#include "syscall.h"

#define CR 0x0d
#define BS 0x08

extern "C" void sys_putc(dword c);
extern "C" dword sys_getc();
dword getchar();
void putchar(dword c);
void print_int(dword val, dword base);
dword scanf(const char *fmt, ...);
dword printf(const char *fmt, ...);
dword itoa(char *buf, dword index, const dword BUF_LENGTH, dword val, dword base);

template <class T>
class Pair
{
public:
    T first, second;
};

dword getchar()
{
    byte keymap[256];
    initKeyboard(keymap);
    dword c;
    do
    {
        c = sys_getc();
    } while (!keymap[c]);
    c = keymap[c];
    if (c == CR)
    {
        NewLine();
    }
    else
    {
        putchar(c);
    }
    return c;
}

void putchar(dword c)
{
    if (c != '\n')
    {
        c = c & 0xff;
        c = c | 0x0700;
        sys_putc(c);
    }
    else
    {
        NewLine();
    }
}

dword scanf(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);

    int counter = 0;
    char *var;
    int c, ival;

    while (*fmt)
    {
        if (*fmt == '%')
        {
            ++fmt;
            if (*fmt == '\0')
            {
                va_end(ap);
                return counter;
            }

            var = va_arg(ap, char *);

            switch (*fmt)
            {
            case 'c':
                *var = (char)getchar();
                break;
            case 'd':
                c = (char)getchar();
                ival = 0;
                while (IsDigit(c))
                {
                    c -= '0';
                    ival = ival * 10 + c;
                    c = (char)getchar();
                }
                for (int i = 0; i < sizeof(int); ++i, ++var)
                {
                    *var = ival & 0xff;
                    ival = ival >> 8;
                }
                break;
            case 's':
                c = getchar();
                while (!IsSpace(c))
                {
                    *var = c;
                    ++var;
                    c = getchar();
                }
                *var = '\0';
                break;
            default:
                break;
            }
        }
        ++fmt;
    }

    va_end(ap);
    return counter;
}

dword printf(const char *fmt, ...)
{
    char buf[1024] = {0};
    const dword BUF_LENGTH = 1024;

    va_list ap;
    va_start(ap, fmt);
    int ival;
    double dval;
    char *sval;
    dword index = 0;
    dword buf_index = 0;

    int counter = 0;

    while (*fmt)
    {
        if (*fmt != '%')
        {
            buf[buf_index] = *fmt;
            ++counter;
            ++buf_index;
            if (buf_index >= BUF_LENGTH)
            {
                buf_index = 0;
            }
        }
        else
        {
            ++fmt;
            switch (*fmt)
            {
            case 0:
                va_end(ap);
                buf[buf_index] = '\0';
                write(buf);
                return counter;

            case 'd':
                ival = va_arg(ap, int);
                if (ival & 0x80000000)
                {
                    buf[buf_index] = '-';
                    ++buf_index;
                    if (buf_index >= BUF_LENGTH)
                    {
                        buf_index = 0;
                    }
                    ival = (~ival) + 1;
                }
                buf_index = itoa(buf, buf_index, BUF_LENGTH, ival, 10);
                break;

            case 'c':
                ival = va_arg(ap, int);
                buf[buf_index] = (char)(ival);
                ++buf_index;
                if (buf_index >= BUF_LENGTH)
                {
                    buf_index = 0;
                }
                break;

            case 's':
                sval = va_arg(ap, char *);
                index = 0;
                while (sval[index])
                {
                    buf[buf_index] = sval[index];
                    ++index;
                    ++buf_index;
                    if (buf_index >= BUF_LENGTH)
                    {
                        buf_index = 0;
                    }
                }
                break;

            case 'x':
                ival = va_arg(ap, int);
                buf_index = itoa(buf, buf_index, BUF_LENGTH, ival, 16);
                break;

            default:
                break;
            }
        }
        ++fmt;
    }
    va_end(ap);
    write(buf);
    return counter;
}

void print_int(dword val, dword base)
{
    dword len = sizeof(dword) * 8;
    dword temp[len] = {0};
    int index = 0;

    while (val)
    {
        temp[index] = (val % base) + '0';
        temp[index] = temp[index] | 0x0700;
        val /= base;
        ++index;
    }

    index = len - 1;
    while ((index >= 0) && (!temp[index]))
        --index;
    if (index < 0)
        putchar('0');
    else
    {
        while (index >= 0)
        {
            putchar(temp[index]);
            --index;
        }
    }
}

dword itoa(char *buf, dword index, const dword BUF_LENGTH, dword val, dword base)
{
    if (base > 16)
        return index;

    dword temp;
    dword number[10];
    dword numberIndex = 0;

    do
    {
        temp = val % base;
        val /= base;

        number[numberIndex] = (temp > 9) ? (temp - 10 + 'A') : (temp + '0');
        ++numberIndex;
    } while (val && (numberIndex < 10));

    while (numberIndex)
    {
        buf[index] = number[numberIndex - 1];
        ++index;
        if (index >= BUF_LENGTH)
        {
            index = 0;
        }
        --numberIndex;
    }
    return index;
}

#endif