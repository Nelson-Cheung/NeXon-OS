#ifndef INTERRUPT_H
#define INTERRUPT_H

#include "type.h"
#include "oslib.h"
#include "string.h"

extern "C" void KeyboardInterruptResponse(dword param);
extern "C" void TimeInterruptResponse();

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

void TimeInterruptResponse()
{
    EnterDataSection();
    // 延时
    if(timeInterruptCount > 1) {
        --timeInterruptCount;
        return;
    }

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
    LeaveDataSection();
}

dword max(dword x, dword y)
{
    return (x >= y ? x : y);
}

dword min(dword x, dword y)
{
    return (x >= y ? y : x);
}

#endif