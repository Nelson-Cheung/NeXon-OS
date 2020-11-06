#include "oslib.h"
#include "keyboard.h"
#include "string.h"
#include "utils.h"

#define color_1 07 // 黑底白字
#define BUF_SIZE 256

void init();
void parse(byte *command);
void Ls();
extern "C" void console();

void console()
{
    init();
    // 常量放置在内核数据区，需要用EnterDataSection和LeaveDataSection包围来访问常量
    // 访问常量时不可以使用函数
    //EnterDataSection();
    byte message[26] = "[root@nelson-cheung.cn] #";
    //LeaveDataSection();

    byte keyboard[256];
    initKeyboard(keyboard);

    // 两个局部变量之间可以使用函数
    byte buffer[BUF_SIZE + 1];

    dword c1, c2, temp, len, index;
    //len = 0;

    Clear();
    while (1)
    {
        buffer[0] = 0;
        len = 0;

        index = 0;
        Puts(0x02, message);

        while (1)
        {
            c1 = GetChar();
            c2 = GetChar();

            if (c1 != FUNCTION_CODE)
            {
                if (c1 == BACKSPACE)
                {
                    if (len > 0)
                    {
                        temp = GetCursor() - 1;
                        MoveCursor(temp);
                        PutChar(0x0700);
                        MoveCursor(temp);
                        --len;
                        buffer[len] = 0;
                    }
                }
                else if (c1 == ENTER)
                {
                    NewLine();
                    break;
                }
                else
                {
                    if (keyboard[c1])
                    {
                        temp = color_1 << 8;
                        temp = temp | keyboard[c1];
                        PutChar(temp);
                        buffer[len] = keyboard[c1];
                        ++len;
                    }
                }

            }
            else if (c1 == FUNCTION_CODE)
            {
            }
        }

        if (len)
        {
            buffer[len] = 0;
            parse(buffer);
        }
    }
}

void parse(byte *command)
{
    EnterDataSection();
    byte LOAD[] = "load";
    byte CLEAR[] = "clear";
    byte REBOOT[] = "reboot";
    byte LS[] = "ls";
    byte HELP[] = "help";
    byte AUTHOR[] = "nelsoncheung";
    byte ERROR[] = "invalid command or parameters!\n";

    byte HELP_MESSAGE[] = "load [...]: load program.\n"
                          "clear: clear the whole screen.\n"
                          "reboot: reboot NSNOS.\n"
                          "ls: list all the program in the disk.\n"
                          "nelsoncheung: the information of the author\n";
    byte AUTHOR_MESSAGE[] = "  Nelson Cheung, or zhangjunyu in Chinese, "
                            "is the author of Nelson Core 0.0.\n"
                            "  It takes Nelson 2 days to learn the protect mode, "
                            "3 days to program the core, oslib and shell.\n"
                            "  If you have any comments or advice, "
                            "please contact the author at zhangjunyu@nelson-cheung.cn\n";
    LeaveDataSection();

    dword size, index;
    byte buffer[BUF_SIZE + 1];
    byte temp[BUF_SIZE + 1];

    byte *ptr;
    byte prmExt;

    StrAssign(buffer, command);
    ToLower(buffer);

    index = FirstIn(' ', buffer);

    ptr = buffer;
    if (index < StrLen(buffer))
    {
        prmExt = ptr[index];
        ptr[index] = 0;
    }
    StrAssign(temp, ptr);

    if (StrEqual(ptr, LOAD))
    {
        if (prmExt == 0)
            return;
        ptr = ptr + index + 1;
        Clear();
        Load(ptr);
        Clear();
    }
    else if (StrEqual(ptr, CLEAR))
    {
        Clear();
    }
    else if (StrEqual(ptr, REBOOT))
    {
        Reboot();
    }
    else if (StrEqual(ptr, LS))
    {
        Ls();
    }
    else if (StrEqual(ptr, HELP))
    {
        Puts(color_1, HELP_MESSAGE);
    }
    else if (StrEqual(ptr, AUTHOR))
    {
        Puts(color_1, AUTHOR_MESSAGE);
    }
    else
    {
        Puts(0x07, ERROR);
    }
}

void Ls()
{
    byte buffer[BYTES_PER_SECTOR];
    byte raw[FILE_ENTRY_SIZE];
    dword index, pos, temp;
    FileEntry entry;

    ReadHD(ROOT_ENTRY, buffer);
    index = 0;
    while (index < BYTES_PER_SECTOR)
    {
        pos = 0;
        while (pos < FILE_ENTRY_SIZE)
        {
            raw[pos] = buffer[pos + index];
            ++pos;
        }

        if (raw[0])
        {
            CreateFileEntry(raw, &entry);

            // FileEntry改的时候下面必须改
            entry.name[10] = 0;
            Puts(color_1, entry.name);
            temp = color_1 << 8;
            temp = temp | ' ';
            PutChar(temp);

            temp = BytesToDec(entry.size, 4);
            Puti(color_1, temp);
            temp = color_1 << 8;
            temp = temp | ' ';
            PutChar(temp);

            temp = BytesToDec(entry.cluster, 2);
            Puti(color_1, temp);
            NewLine();
        }
        index += FILE_ENTRY_SIZE;
    }
}

void init()
{
    EnterDataSection();
    byte Message[] = "kernel loading Done.\n"
                     "NSNOS 0.0, from Nelson Core 0.0\n"
                     "Do the last check...\n";
    byte DONE[] = "done\n";
    LeaveDataSection();

    Puts(0x03, Message);
    Wait(0xffffff2);

    Puts(0x03, DONE);
    Wait(0xffffff);
}