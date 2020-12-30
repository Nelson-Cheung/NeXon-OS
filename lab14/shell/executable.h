#ifndef EXECUTABLE_H
#define EXECUTABLE_H

#include "../type.h"
#include "../syscall.h"

#define SHELL_EXE_MULTIPROCESS "multiprocess"

namespace executable
{
    dword threadCounter;
    Semaphore mutex;

    void initialize()
    {
        threadCounter = 0;
        mutex.initialize(1);
    }
    void delay()
    {
        dword temp = 0x7ffff;
        while (temp)
        {
            --temp;
        }
    }

    void multiprocess_1(void *arg)
    {
        mutex.P();
        ++threadCounter;
        mutex.V();

        dword x, y, xd, yd, x0, y0, width, height, counter;

        x0 = 0, y0 = 0, width = 40, height = 25;

        x = 5, y = 0, xd = 1, yd = 1, counter = 0;
        while (counter < 100)
        {
            delay();

            x += xd;
            y += yd;

            if (x == x0 + height)
            {
                x = x0 + height - 2;
                xd = -1;
            }
            else if (x == x0 - 1)
            {
                x = x0 + 1;
                xd = 1;
            }
            else if (y == y0 + width)
            {
                y = y0 + width - 2;
                yd = -1;
            }
            else if (y == y0 - 1)
            {
                y = y0 + 1;
                yd = 1;
            }

            moveCursor(x * 80 + y);
            putc('$');
            ++counter;
        }

        mutex.P();
        --threadCounter;
        mutex.V();
    }

    void multiprocess_2(void *arg)
    {
        mutex.P();
        ++threadCounter;
        mutex.V();

        dword x, y, xd, yd, x0, y0, width, height, counter;

        x0 = 0, y0 = 40, width = 40, height = 25;

        x = 5, y = 40, xd = 1, yd = 1, counter = 0;
        while (counter < 100)
        {
            delay();

            x += xd;
            y += yd;

            if (x == x0 + height)
            {
                x = x0 + height - 2;
                xd = -1;
            }
            else if (x == x0 - 1)
            {
                x = x0 + 1;
                xd = 1;
            }
            else if (y == y0 + width)
            {
                y = y0 + width - 2;
                yd = -1;
            }
            else if (y == y0 - 1)
            {
                y = y0 + 1;
                yd = 1;
            }

            moveCursor(x * 80 + y);
            putc('$');
            ++counter;
        }

        mutex.P();
        --threadCounter;
        mutex.V();
    }

}; // namespace executable
#endif