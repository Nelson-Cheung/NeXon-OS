#include "keyboard.h"

void keyboardInterruptHandler()
{
    dword scanCode = _in_port(0x60);
    printf("press code: 0x%x\n", scanCode);
    sysKeyboard.push(scanCode);
}

Keyboard::Keyboard()
{
    initialize();
}
void Keyboard::initialize()
{
    for (int i = 0; i < KEYBOARD_BUFFER_SIZE; ++i)
    {
        buffer[i] = 0;
    }
    head = end = 0;
}
bool Keyboard::push(byte code)
{
    if ((end + 1) % KEYBOARD_BUFFER_SIZE == head)
    {
        return false;
    }

    buffer[end] = code;
    end = (end + 1) % KEYBOARD_BUFFER_SIZE;
    return true;
}
bool Keyboard::pop(byte *code)
{
    if (head == end)
        return false;
    *code = buffer[head];
    head = (head + 1) % KEYBOARD_BUFFER_SIZE;
    return true;
}