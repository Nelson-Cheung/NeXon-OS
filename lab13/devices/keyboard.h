#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "../oslib.h"
#include "../configure/type.h"
#include "../cstdio.h"

#define KEYBOARD_BUFFER_SIZE 256

extern "C" void keyboardInterruptHandler();

// 处理键盘输入

class Keyboard
{
private:
    byte buffer[KEYBOARD_BUFFER_SIZE];
    dword head, end;

public:
    Keyboard();
    void initialize();
    bool push(byte code);
    bool pop(byte *code);
};

Keyboard sysKeyboard;

#endif