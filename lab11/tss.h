#ifndef TSS_H
#define TSS_H

#include "type.h"
#include "thread.h"
#include "memory.h"

// 3特权级下的数据段和代码段
#define USER_CODE_LOW 0x0000ffff
#define USER_CODE_HIGH 0x00cff800

#define USER_DATA_LOW 0x0000ffff
#define USER_DATA_HIGH 0x00cff200

extern "C" dword sys_add_gd(dword low, dword high);
extern "C" void sys_init_tss(dword selector);

class Tss
{
private:
    dword backlink;
    dword *esp0;
    dword ss0;
    dword *esp1;
    dword ss1;
    dword *esp2;
    dword ss2;
    dword cr3;
    dword (*eip)(void);
    dword eflags;
    dword eax;
    dword ecx;
    dword edx;
    dword ebx;
    dword esp;
    dword ebp;
    dword esi;
    dword edi;
    dword es;
    dword cs;
    dword ss;
    dword ds;
    dword fs;
    dword gs;
    dword ldt;
    dword trace;
    dword ioMap;

public:
    void updateEsp0(PCB *thread) {
        esp0 = (dword*)((dword)thread + PAGE_SIZE);
    }

    void initialize() {
        dword size = sizeof(Tss);
        memset((byte *)this, 0, size);
        ss0 = 0x10; // 系统堆栈段选择子
        dword low, high, temp;
        low = 0;
        temp = (size - 1) & 0xff;
        low = low | temp;
        temp = (dword)this << 16;
        low = low | temp;

        high = 0;
        temp = (dword)this & 0xff000000;
        high = high | temp;
        temp = (dword)this & 0x00ff0000;
        temp = temp >> 16;
        high = high | temp;
        temp = (size - 1) & 0xff00;
        temp = temp << 16;
        high = high | temp;
        high = high | 0x00008900;

        temp = sys_add_gd(low, high);
        temp = temp << 3;
        sys_init_tss(temp);
        sys_add_gd(USER_CODE_LOW, USER_CODE_HIGH);
        sys_add_gd(USER_DATA_LOW, USER_DATA_HIGH);

        ioMap = (dword)this + size;
    }
};

Tss tss;

#endif