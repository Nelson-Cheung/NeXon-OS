#include "shell.h"
#include "../cstdio.h"

Shell::Shell()
{
    initialize();
}
void Shell::initialize()
{
    head = end = 0;
}

void Shell::run()
{
    byte code, c;
    bool flag;
    dword counter;

    clear();
    printGraphSymbol();
    while (1)
    {
        const char *head = "root@nelson-cheung.cn # ";
        printf("%s", head);
        flag = true;
        counter = 0;

        while (flag)
        {
            while (!sysKeyboard.pop(&code))
            {
            }

            if (code & 0x80)
            {
                continue;
            }

            c = sysKeyboard.scanCode2Char(code);
            switch (c)
            {
            // 特殊按键
            case 0:
            {
                switch (code)
                {
                case KEY_SPACES:
                {
                    putc(' ');
                    ++counter;
                }
                break;

                default:
                    break;
                }
            }
            break;

            case '\b':
            {
                dword pos = getCursor();
                if (pos && counter)
                {
                    --counter;
                    moveCursor(pos - 1);
                    putc(0);
                    moveCursor(pos - 1);
                }
            }
            break;

            case '\t':

                break;

            case '\r':
            {
                do
                {
                    putc(0);
                } while (getCursor() % 80);
                flag = false;
            }
            break;

            default:
            {
                putc(c);
                ++counter;
            }
            break;
            }
        }
    }
}

void Shell::clear()
{
    dword length = 80 * 25;
    moveCursor(0);
    for (dword i = 0; i < length; ++i)
    {
        putc(0);
    }
    moveCursor(0);
}

void Shell::printGraphSymbol() {
    printf("\n");
    printf("_   _      _                    ____ _                            \n");
    printf("| \\ | | ___| |___  ___  _ __    / ___| |__   ___ _   _ _ __   __ _ \n");
    printf("|  \\| |/ _ \\ / __|/ _ \\| '_ \\  | |   | '_ \\ / _ \\ | | | '_ \\ / _` |\n");
    printf("| |\\  |  __/ \\__ \\ (_) | | | | | |___| | | |  __/ |_| | | | | (_| |\n");
    printf("|_| \\_|\\___|_|___/\\___/|_| |_|  \\____|_| |_|\\___|\\__,_|_| |_|\\__, |\n");
    printf("                                                             |___/ \n\n");
}