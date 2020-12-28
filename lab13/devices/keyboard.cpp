#include "keyboard.h"

void keyboardInterruptHandler()
{
    dword scanCode = _in_port(0x60);
    //printf("press code: 0x%x\n", scanCode);
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

    mutex.initialize(1);

    SHIFT_ON = false;
    CAPS_ON = false;

    keymap[0x00][0] = 0, keymap[0x00][1] = 0;
    keymap[0x01][0] = 0, keymap[0x01][1] = 0; // escape
    keymap[0x02][0] = '1', keymap[0x02][1] = '!';
    keymap[0x03][0] = '2', keymap[0x03][1] = '@';
    keymap[0x04][0] = '3', keymap[0x04][1] = '#';
    keymap[0x05][0] = '4', keymap[0x05][1] = '$';
    keymap[0x06][0] = '5', keymap[0x06][1] = '%';
    keymap[0x07][0] = '6', keymap[0x07][1] = '^';
    keymap[0x08][0] = '7', keymap[0x08][1] = '&';
    keymap[0x09][0] = '8', keymap[0x09][1] = '*';
    keymap[0x0a][0] = '9', keymap[0x0a][1] = '(';
    keymap[0x0b][0] = '0', keymap[0x0b][1] = ')';
    keymap[0x0c][0] = '-', keymap[0x0c][1] = '_';
    keymap[0x0d][0] = '=', keymap[0x0d][1] = '+';
    keymap[0x0e][0] = '\b', keymap[0x0e][1] = '\b'; // backspace

    keymap[0x0f][0] = '\t', keymap[0x0f][1] = '\t'; // HT
    keymap[0x10][0] = 'q', keymap[0x10][1] = 'Q';
    keymap[0x11][0] = 'w', keymap[0x11][1] = 'W';
    keymap[0x12][0] = 'e', keymap[0x12][1] = 'E';
    keymap[0x13][0] = 'r', keymap[0x13][1] = 'R';
    keymap[0x14][0] = 't', keymap[0x14][1] = 'T';
    keymap[0x15][0] = 'y', keymap[0x15][1] = 'Y';
    keymap[0x16][0] = 'u', keymap[0x16][1] = 'U';
    keymap[0x17][0] = 'i', keymap[0x17][1] = 'I';
    keymap[0x18][0] = 'o', keymap[0x18][1] = 'O';
    keymap[0x19][0] = 'p', keymap[0x19][1] = 'P';
    keymap[0x1a][0] = '[', keymap[0x1a][1] = '{';
    keymap[0x1b][0] = ']', keymap[0x1b][1] = '}';
    keymap[0x1c][0] = '\r', keymap[0x1c][1] = '\r'; // CR

    keymap[0x1d][0] = 0, keymap[0x1d][1] = 0; // L ctrl
    keymap[0x1e][0] = 'a', keymap[0x1e][1] = 'A';
    keymap[0x1f][0] = 's', keymap[0x1f][1] = 'S';
    keymap[0x20][0] = 'd', keymap[0x20][1] = 'D';
    keymap[0x21][0] = 'f', keymap[0x21][1] = 'F';
    keymap[0x22][0] = 'g', keymap[0x22][1] = 'G';
    keymap[0x23][0] = 'h', keymap[0x23][1] = 'H';
    keymap[0x24][0] = 'j', keymap[0x24][1] = 'J';
    keymap[0x25][0] = 'k', keymap[0x25][1] = 'K';
    keymap[0x26][0] = 'l', keymap[0x26][1] = 'L';
    keymap[0x27][0] = ';', keymap[0x27][1] = ':';
    keymap[0x28][0] = '\'', keymap[0x28][1] = '\"';

    keymap[0x29][0] = '`', keymap[0x29][1] = '~';
    keymap[0x2a][0] = 0, keymap[0x2a][1] = 0; // L shift
    keymap[0x2b][0] = '\\', keymap[0x2b][1] = '|';
    keymap[0x2c][0] = 'z', keymap[0x2c][1] = 'Z';
    keymap[0x2d][0] = 'x', keymap[0x2d][1] = 'X';
    keymap[0x2e][0] = 'c', keymap[0x2e][1] = 'C';
    keymap[0x2f][0] = 'v', keymap[0x2f][1] = 'V';
    keymap[0x30][0] = 'b', keymap[0x30][1] = 'B';
    keymap[0x31][0] = 'n', keymap[0x31][1] = 'N';
    keymap[0x32][0] = 'm', keymap[0x32][1] = 'M';
    keymap[0x33][0] = ',', keymap[0x33][1] = '<';
    keymap[0x34][0] = '.', keymap[0x34][1] = '>';
    keymap[0x35][0] = '/', keymap[0x35][1] = '?';
    //keymap[0x36][0] = 0, keymap[0x36][1] = 0; // R shift
}

bool Keyboard::push(byte code)
{
    if ((end + 1) % KEYBOARD_BUFFER_SIZE == head)
    {
        printf("keyboard buffer full\n");
        return false;
    }

    buffer[end] = code;
    end = (end + 1) % KEYBOARD_BUFFER_SIZE;
    return true;
}

bool Keyboard::pop(byte *code)
{
    mutex.P();
    if (head == end)
    {
        mutex.V();
        return false;
    }

    *code = buffer[head];
    head = (head + 1) % KEYBOARD_BUFFER_SIZE;

    mutex.V();
    return true;
}

byte Keyboard::scanCode2Char(byte c)
{
    if (c & 0x80)
    {
        return 0;
    }
    else
    {
        if (c < KEY_MAP_NUM && keymap[c])
        {
            return keymap[c][0];
        }
        else
        {
            return 0;
        }
    }
}

byte sysGetc()
{
    byte c;
    while (true)
    {
        while (!sysKeyboard.pop(&c))
        {
        }
        c = sysKeyboard.scanCode2Char(c);
        if (c)
        {
            return c;
        }
    }
}