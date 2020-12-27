#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "../oslib.h"
#include "../configure/type.h"
#include "../cstdio.h"
#include "../program/sync.h"

#define KEYBOARD_BUFFER_SIZE 16

extern "C" void keyboardInterruptHandler();

// 处理键盘输入
#define KEY_MAP_NUM 54
#define KEY_ESC 0x01
#define KEY_LEFT_CTRL 0x1d
#define KEY_LEFT_SHIFT 0x2a

class Keyboard
{
private:
    byte buffer[KEYBOARD_BUFFER_SIZE];
    byte keymap[KEY_MAP_NUM][2];
    dword head, end;
    Semaphore mutex;

    bool SHIFT_ON;
    bool CAPS_ON;

public:
    Keyboard();
    void initialize();
    bool push(byte code);
    bool pop(byte *code);
};

Keyboard sysKeyboard;

#endif