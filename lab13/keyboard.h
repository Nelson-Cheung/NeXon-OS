#ifndef OLD_KEYBOARD_H
#define OLD_KEYBOARD_H

#include "type.h"

#define FUNCTION_CODE 0xE0
#define BACKSPACE 0x0E
#define ENTER 0x1c

void initKeyboard(byte *keymap)
{
    int index = 0;

    while(index < 256) {
        keymap[index] = 0;
        ++index;
    }

    keymap[0x1e] = 'a';
    keymap[0x30] = 'b';
    keymap[0x2e] = 'c';
    keymap[0x20] = 'd';
    keymap[0x12] = 'e';
    keymap[0x21] = 'f';
    keymap[0x22] = 'g';
    keymap[0x23] = 'h';
    keymap[0x17] = 'i';
    keymap[0x24] = 'j';
    keymap[0x25] = 'k';
    keymap[0x26] = 'l';
    keymap[0x32] = 'm';
    keymap[0x31] = 'n';
    keymap[0x18] = 'o';
    keymap[0x19] = 'p';
    keymap[0x10] = 'q';
    keymap[0x13] = 'r';
    keymap[0x1f] = 's';
    keymap[0x14] = 't';
    keymap[0x16] = 'u';
    keymap[0x2f] = 'v';
    keymap[0x11] = 'w';
    keymap[0x2d] = 'x';
    keymap[0x15] = 'y';
    keymap[0x2c] = 'z';

    keymap[0xb] = '0';
    keymap[0x2] = '1';
    keymap[0x3] = '2';
    keymap[0x4] = '3';
    keymap[0x5] = '4';
    keymap[0x6] = '5';
    keymap[0x7] = '6';
    keymap[0x8] = '7';
    keymap[0x9] = '8';
    keymap[0xa] = '9';

    keymap[0x39] = ' ';
    // CR
    keymap[0x1c] = 0x0d;
    // BS
    keymap[0x0e] = 0x08;
}

#endif