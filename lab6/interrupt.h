#ifndef INTERRUPT_H
#define INTERRUPT_H

#include "type.h"
#include "oslib.h"
#include "string.h"
#include "thread.h"

extern "C" void KeyboardInterruptResponse(dword param);
extern "C" void TimeInterruptResponse();
extern "C" void Int38HResponse();
extern "C" void _interrupt_36h();
extern "C" void _interrupt_38h();
extern "C" void _enable_interrupt();
extern "C" void _disable_interrupt();
extern "C" bool _interrupt_status();

void _set_interrupt(bool status);

dword max(dword x, dword y);
dword min(dword x, dword y);

byte message[] = {'N', 'S', 'N', 'O', 'S', ' ', '0', '.', '0', ',', ' ',
                  'p', 'o', 'w', 'e', 'r', 'e', 'd', ' ', 'b', 'y', ' ',
                  'N', 'C', 'o', 'r', 'e', '\0'};
dword msgLen = 27;
dword start = 106;
dword timeInterruptCount = 3;

void KeyboardInterruptResponse(dword param)
{
    dword temp = GetCursor();
    dword c;

    MoveCursor(24 * 80);
    if (param & 0x80)
    {
        c = 0x07 << 8;
        c = c & 0xff00;
        PutChar(c);
        PutChar(c);
        PutChar(c);
        PutChar(c);
        PutChar(c);
        PutChar(c);
        PutChar(c);
        PutChar(c);
        PutChar(c);
    }
    else
    {
        c = 0x0d << 8;
        c = c & 0xff00;
        c = c | 't';
        PutChar(c);

        c = c & 0xff00;
        c = c | 'y';
        PutChar(c);

        c = c & 0xff00;
        c = c | 'p';
        PutChar(c);

        c = c & 0xff00;
        c = c | 'i';
        PutChar(c);

        c = c & 0xff00;
        c = c | 'n';
        PutChar(c);

        c = c & 0xff00;
        c = c | 'g';
        PutChar(c);

        c = c & 0xff00;
        c = c | '.';
        PutChar(c);

        c = c & 0xff00;
        c = c | '.';
        PutChar(c);

        c = c & 0xff00;
        c = c | '.';
        PutChar(c);
    }
    MoveCursor(temp);
}

#include "cstdio.h"

void TimeInterruptResponse()
{
    // 延时
    timeInterruptCount = 0;

    dword len = StrLen(message);
    dword temp = GetCursor();
    dword c;

    if (start == 0)
    {
        start = msgLen + 79;
        MoveCursor(0);
        c = 0x07 << 8;
        c = c | ' ';
        PutChar(c);
    }

    dword left = max(msgLen, start) - start;
    dword right = min(msgLen + 79, start + msgLen - 1) - start;
    dword index = left;
    dword startPos = max(msgLen, start) - msgLen;

    MoveCursor(startPos);
    while (index <= right)
    {
        c = 0x09 << 8;
        c = c | ((dword)message[index]);
        PutChar(c);
        ++index;
    }

    while (GetCursor() < 80)
    {
        c = 0x07 << 8;
        c = c | ' ';
        PutChar(c);
    }

    MoveCursor(temp);

    --start;

    PCB *cur = (PCB *)_running_thread();
    --cur->ticks;
    ++cur->ticksPassedBy;
    if (!cur->ticks)
    {
        _schedule_thread();
    }

}

void Int38HResponse()
{
    byte message[] = "INT 38H";
    dword pos = GetCursor();
    MoveCursor(25 * 80 - StrLen(message) - 1);
    Puts(0x07, message);
    /*Wait(100000);
    MoveCursor(25 * 80 - StrLen(message) - 1);
    dword index = StrLen(message);
    while(index) {
        PutChar(0x0700);
        --index;
    }*/
    MoveCursor(pos);
}

dword max(dword x, dword y)
{
    return (x >= y ? x : y);
}

dword min(dword x, dword y)
{
    return (x >= y ? y : x);
}

void CallInterrupt38H()
{
    _interrupt_38h();
}

void CallInterrupt36H()
{
    _interrupt_36h();
}

void _set_interrupt(bool status)
{
    if (status)
        _enable_interrupt();
    else
        _disable_interrupt();
}
#endif