#ifndef CSTDIO_H
#define CSTDIO_H

#include <stdarg.h>
#include "type.h"
#include "keyboard.h"
#include "ctype.h"
#include "oslib.h"

#define CR 0x0d
#define BS 0x08

extern "C" void sys_putc(dword c);
extern "C" dword sys_getc();
dword getchar();
void putchar(dword c);
void print_int(dword val, dword base);
dword scanf(const char *fmt, ...);
dword printf(const char *fmt, ...);

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
    va_list ap;
    va_start(ap, fmt);
    int ival;
    double dval;
    char *sval;
    dword index = 0;

    int counter = 0;

    while (*fmt)
    {
        if (*fmt != '%')
        {
            if (*fmt == '\n')
                NewLine();
            else
            {
                putchar(*fmt);
            }
            ++counter;
        }
        else
        {
            ++fmt;
            switch (*fmt)
            {
            case 0:
                va_end(ap);
                return counter;

            case 'd':
                ival = va_arg(ap, int);
                print_int(ival, 10);
                break;

            case 'c':
                ival = va_arg(ap, int);
                putchar(ival);
                break;

            case 's':
                sval = va_arg(ap, char *);
                index = 0;
                while (sval[index])
                {
                    putchar(sval[index]);
                    ++index;
                }
                break;

                // case 'f':
                //     dval = va_arg(ap, double);
                //     printf("%f", dval);
                //     break;

            default:
                break;
            }
        }
        ++fmt;
    }
    va_end(ap);
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
#endif