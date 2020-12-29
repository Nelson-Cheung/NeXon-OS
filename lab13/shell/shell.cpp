#include "shell.h"
#include "../cstdio.h"
#include "../cstdlib.h"

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
    const char *user = "root@nelson-cheung.cn # ";

    clear();
    printGraphSymbol();
    while (true)
    {

        printf("%s", user);
        inputAndShow();   // 等待用户输入
        extractCommand(); // 提取用户命令

        // 处理内部命令
        if (strlib::strcmp((char *)cmd, SHELL_LS) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_TREE) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_CD) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_MKDIR) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_NELSON) == 0)
        {
            printGraphSymbol();
        }
        else if (strlib::strcmp((char *)cmd, SHELL_EXEC) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_RM) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_CAT) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_ECHO) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else if (strlib::strcmp((char *)cmd, SHELL_TOUCH) == 0)
        {
            printf("you enter command \"%s\"\n", cmd);
        }
        else
        {
            printf("command \"%s\" is not supported\n", cmd);
        }

        head = end = 0;
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

void Shell::printGraphSymbol()
{
    printf("\n");
    printf("          ________   _______      ___    ___ ________  ________\n");
    printf("         |\\   ___  \\|\\  ___ \\    |\\  \\  /  /|\\   __  \\|\\   ___  \n");
    printf("         \\ \\  \\\\ \\  \\ \\   __/|   \\ \\  \\/  / | \\  \\|\\  \\ \\  \\\\ \\  \\\n");
    printf("          \\ \\  \\\\ \\  \\ \\  \\_|/__  \\ \\    / / \\ \\  \\\\\\  \\ \\  \\\\ \\  \\\n");
    printf("           \\ \\  \\\\ \\  \\ \\  \\_|\\ \\  /     \\/   \\ \\  \\\\\\  \\ \\  \\\\ \\  \\ \n");
    printf("            \\ \\__\\\\ \\__\\ \\_______\\/  /\\   \\    \\ \\_______\\ \\__\\\\ \\__\\\n");
    printf("             \\|__| \\|__|\\|_______/__/ /\\ __\\    \\|_______|\\|__| \\|__|\n");
    printf("                                 |__|/ \\|__|                         \n\n");
}

void Shell::inputAndShow()
{
    byte code;
    dword counter = 0;
    byte c;

    while (1)
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
                buffer[end] = ' ';
                end = (end + 1) % SHELL_BUFFER_SIZE;
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
                --end;
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
            return;
        }
        break;

        default:
        {
            putc(c);
            ++counter;
            buffer[end] = c;
            end = (end + 1) % SHELL_BUFFER_SIZE;
        }
        break;
        }
    }
}

void Shell::extractCommand()
{
    memset(cmd, '\0', SHELL_COMMAND_SIZE + 1);

    dword i = 0;
    while ((head != end) &&
           (i < SHELL_COMMAND_SIZE) &&
           (buffer[head] != ' '))
    {
        cmd[i] = buffer[head];
        head = (head + 1) % SHELL_BUFFER_SIZE;
        ++i;
    }

    // 命令太长，截断处理
    while ((head != end) && (buffer[head] != ' '))
    {
        head = (head + 1) % SHELL_BUFFER_SIZE;
    }

    if((head != end)) {
        head = (head + 1) % SHELL_BUFFER_SIZE;
    }
}