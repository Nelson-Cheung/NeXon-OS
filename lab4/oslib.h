#ifndef OSLIB_H
#define OSLIB_H

#define dword unsigned int
#define word unsigned short
#define byte unsigned char

extern "C" void sys_putc(dword c);
extern "C" dword sys_getc();
extern "C" void sys_move_cursor(dword pos);
extern "C" dword sys_get_cursor();
extern "C" void sys_enter_data_section();
extern "C" void sys_leave_data_section();
extern "C" void sys_load(byte *params);
extern "C" void sys_read_hd(dword sector, byte *buffer);
extern "C" void sys_reboot();

// 打印字符到显示屏，颜色字符预先指定
void PutChar(dword c);
// 从键盘缓冲区读入字符
dword GetChar();
// 移动光标
void MoveCursor(dword pos);
// 获取光标位置
dword GetCursor();
// 打印字符串
void Puts(byte color, byte *str);
// 清屏
void Clear();
// 换行
void NewLine();
// 进入内核数据区
void EnterDataSection();
// 离开内核数据区
void LeaveDataSection();
// 加载用户程序，此函数接口具有一般性，实现不具备一般性
void Load(byte *params);
// 读取编号为sector的一个扇区到buffer
void ReadHD(dword sector, byte *buffer);
// 重启
void Reboot();
// 等待
void Wait(dword time);

void PutChar(dword c)
{
    sys_putc(c);
}

dword GetChar()
{
    return sys_getc();
}

void MoveCursor(dword pos)
{
    sys_move_cursor(pos);
}

dword GetCursor()
{
    return sys_get_cursor();
}

void Puts(byte color, byte *str)
{
    dword index, c;
    index = 0;
    while (str[index])
    {
        if (str[index] == '\n')
        {
            NewLine();
        }
        else
        {
            c = color << 8;
            c = c | str[index];
            PutChar(c);
        }
        ++index;
    }
}

void Clear()
{
    dword index;

    index = 0;
    MoveCursor(0);
    while (index < 2000)
    {
        PutChar(0x0700);
        ++index;
    }
    MoveCursor(0);
}

void NewLine()
{
    dword temp;
    temp = GetCursor();
    temp /= 80;
    if (temp < 24)
    {
        ++temp;
        temp *= 80;
        MoveCursor(temp);
    }
    else
    {
        MoveCursor(1999);
        PutChar(0x0700);
    }
}

void EnterDataSection()
{
    sys_enter_data_section();
}

void LeaveDataSection()
{
    sys_leave_data_section();
}

void Load(byte *params)
{
    sys_load(params);
}

void Puti(byte color, dword value)
{
    dword temp;

    if (value == 0)
    {
        temp = color << 8;
        temp = temp | '0';
        PutChar(temp);
    }
    else
    {
        dword buffer[10];
        byte counter;

        counter = 0;

        while (value)
        {
            temp = color << 8;
            temp = temp | ((value % 10) + '0');
            buffer[counter] = temp;
            ++counter;
            value /= 10;
        }

        byte index = counter;
        do {
            --index;
            PutChar(buffer[index]);
        } while(index > 0);
    }
}

void ReadHD(dword sector, byte *buffer)
{
    sys_read_hd(sector, buffer);
}

void Reboot() {
    sys_reboot();
}

void Wait(dword time) {
    while(time) --time;
}
#endif