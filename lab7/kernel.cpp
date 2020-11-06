#include "oslib.h"
#include "keyboard.h"
#include "string.h"
#include "utils.h"
#include "interrupt.h"
#include "cstdio.h"
#include "bitmap.cpp"
#include "memory.cpp"
#include "thread.cpp"
#include "sync.cpp"
#include <stdarg.h>
#define color_1 07 // 黑底白字
#define BUF_SIZE 1024

void init();
void parse(byte *command);
void Ls();
void _shell(void *arg);

void _thread1(void *arg);
void _thread2(void *arg);
void _thread3(void *arg);

Semaphore _screan;
Semaphore saveAndTake;
Semaphore fruit_empty;
Semaphore fruit_full;
Semaphore bless_empty;
Semaphore bless_full;
Semaphore mutex;

Semaphore rw;
Semaphore w;

int counter;
int fruit;
int bless;

int money;

struct Point
{
    int x;
    int y;
};

void printMatrix(void *point);
void wait(int ticks);
void writer(void *arg);
void reader(void *arg);

void test(int x)
{
    return;
}
extern "C" void Kernel();

// 从shell返回一定会出错
void Kernel()
{
    // 32MB内存，bochs内置
    _screan = Semaphore();
    initMemoryPool(0x2000000);
    _all_threads.initialize();
    _ready_threads.initialize();
    _screan.initialize(1);
    PID = 0;

    dword pid = createThread(&_shell, nullptr, 2);

    PCB *next = elem2entry(PCB, tagInGeneralList, _ready_threads.front());
    next->status = ThreadStatus::RUNNING;
    _ready_threads.pop_front();
    _switch_thread_to((void *)0x9f000, next);
    while (1)
        ;

    /*
    byte message[25] = {'r', 'o', 'o', 't', '@', 'n', 'e', 'l', 's', 'o', 'n',
                        '-', 'c', 'h', 'e', 'u', 'n', 'g', '.', 'c', 'n', ']',
                        ' ', '#', 0};
    byte keyboard[256];
    initKeyboard(keyboard);

    // 两个局部变量之间可以使用函数
    byte buffer[BUF_SIZE + 1] = {'\0'};

    dword c1, c2, temp, len, index;
    //len = 0;

    Clear();
    MoveCursor(80);
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
    }*/
}

void _shell(void *arg)
{

    _enable_interrupt();
    Clear();
    MoveCursor(80);

    mutex.initialize(1);
    w.initialize(1);
    rw.initialize(1);
    counter = 0;

    for (int i = 0; i < 2; ++i)
    {
        createThread(&writer, nullptr, i+1);
    }

    for (int i = 0; i < 3; ++i)
    {
        createThread(&reader, nullptr, i+1);
    }

    while (1)
    {
    }
}

void _thread1(void *arg)
{
    while (1)
    {
        fruit_full.P();
        bless_full.P();
        mutex.P();
        --fruit;
        --bless;
        printf("Father: get bless and fruit, fruit left: %d, bless left: %d\n", fruit, bless);
        mutex.V();
        wait(0x2fffff);
        fruit_empty.V();
        bless_empty.V();
    }
}

void _thread2(void *arg)
{
    while (1)
    {
        fruit_empty.P();
        mutex.P();
        ++fruit;
        printf("son one: put fruit, fruit left: %d\n", fruit);
        mutex.V();
        wait(0x5fffff);
        fruit_full.V();
    }
}

void _thread3(void *arg)
{
    while (1)
    {
        bless_empty.P();
        mutex.P();
        ++bless;
        printf("son two: give blessing, bless left: %d\n", bless);
        mutex.V();
        wait(0x8fffff);
        bless_full.V();
    }
}

void writer(void *arg)
{
    PCB *cur = (PCB *)_running_thread();
    while (1)
    {
        w.P();
        rw.P();
        printf("writer: %d, write start\n", cur->pid);
        wait(0xffffff);
        printf("writer: %d, write complete\n", cur->pid);
        rw.V();
        w.V();
    }
}

void reader(void *arg)
{
    PCB *cur = (PCB *)_running_thread();
    while (1)
    {
        w.P();
        mutex.P();
        if (counter == 0)
        {
            rw.P();
        }
        ++counter;
        mutex.V();
        w.V();

        printf("reader: %d, read start\n", cur->pid);
        wait(0x5fffff);
        printf("reader: %d, read complete\n", cur->pid);

        mutex.P();
        --counter;
        if (counter == 0)
        {
            rw.V();
        }
        mutex.V();
    }
}

void print(void *arg)
{
    while (1)
    {
        _screan.P();
        printf("%s", "Hello Thread!\n");
        _screan.V();
    }
}
void parse(byte *command)
{
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
    byte INTERRUPT[] = "interrupt";
    byte buffer[BUF_SIZE + 1];
    byte temp[BUF_SIZE + 1];
    dword size, index;
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
        /*if (prmExt == 0)
            return;
        ptr = ptr + index + 1;
        Clear();
        Load(ptr);
        Clear();
        MoveCursor(80);*/
    }
    else if (StrEqual(ptr, CLEAR))
    {
        Clear();
        MoveCursor(80);
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
    else if (StrEqual(ptr, INTERRUPT))
    {
        CallInterrupt38H();
        /*if (index >= StrLen(buffer))
            return;
        ptr = ptr + index + 1;
        dword num = ToInt(ptr);
        switch (num)
        {
        case 36:
            CallInterrupt36H();
            break;
        case 38:
            CallInterrupt38H();
        default:
            break;
        }*/
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
    byte Message[] = "kernel loading Done.\n"
                     "NSNOS 0.0, from Nelson Core 0.0\n"
                     "Do the last check...\n";
    byte DONE[] = "done\n";

    Puts(0x03, Message);
    Wait(0xffffff2);

    Puts(0x03, DONE);
    Wait(0xffffff);
}

void printMatrix(void *arg)
{
    Point point = *((Point *)arg);
    const int ROW = 9;
    const int COL = 9;
    const int TOTAL = ROW * COL;
    const int TICKS = 1000000;

    int array[ROW][COL] = {0};
    int row, col, counter;

    row = 0;
    col = 0;
    counter = 1;

    while (counter <= TOTAL)
    {
        while (col < COL && !array[row][col])
        {
            array[row][col] = counter;
            _disable_interrupt();
            MoveCursor((point.x + row) * 80 + point.y + col);
            putchar('*');
            _enable_interrupt();
            ++counter;
            ++col;
            wait(TICKS);
        }

        --col;
        ++row;

        while (row < ROW && !array[row][col])
        {
            array[row][col] = counter;
            _disable_interrupt();
            MoveCursor((point.x + row) * 80 + point.y + col);
            putchar('*');
            _enable_interrupt();
            ++counter;
            ++row;
            wait(TICKS);
        }

        --row;
        --col;

        while (col >= 0 && !array[row][col])
        {
            array[row][col] = counter;
            _disable_interrupt();
            MoveCursor((point.x + row) * 80 + point.y + col);
            putchar('*');
            _enable_interrupt();
            ++counter;
            --col;
            wait(TICKS);
        }

        ++col;
        --row;

        while (row >= 0 && !array[row][col])
        {
            array[row][col] = counter;
            _disable_interrupt();
            MoveCursor((point.x + row) * 80 + point.y + col);
            putchar('*');
            _enable_interrupt();
            ++counter;
            --row;
            wait(TICKS);
        }

        ++row;
        ++col;
    }
    while (1)
        ;
}

void wait(int ticks)
{
    while (ticks)
        --ticks;
}