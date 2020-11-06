#include "disk.h"
#include "oslib.h"

Disk::Disk()
{
    initialize();
}

void Disk::initialize()
{
    SEC_SIZE = 512;
    partitionStartSector[0] = PARTITION_0_START;
    partitionStartSector[1] = PARTITION_1_START;
    // mutex.initialize(1);
}

void Disk::write(dword partition, dword start, byte *buf, dword size)
{
    // 只能写偶数个字节，因为每次是按一个字写入磁盘的，如果不是偶数字节，就会覆盖其他的数据
    if (!partition || (size % 2)) return;

    start += partitionStartSector[partition];

    dword secSize = (size + SEC_SIZE - 1) / SEC_SIZE;
    dword temp;

    waitForDisk(start, secSize, 0x30);

    dword index = 0;
    while (index < size)
    {
        temp = buf[index];
        ++index;
        if (index < size)
        {
            // intel下需要按小端方式写，因为读的时候是按小端方式读取的
            temp = (temp << 8) + buf[index];
            ++index;
        }
        outw_port(0x1f0, temp); // 每次需要向ox1f0写入一个字

        temp = _in_port(0x1f7);
        if (temp & 0x1)
        {
            temp = _in_port(0x1f1);
            printf("Disk Error: 0x%x\n", temp);
            return;
        }
    }
}

void Disk::read(dword partition, dword start, byte *buf, dword size)
{
    start += partitionStartSector[partition];

    dword secSize = (size + SEC_SIZE - 1) / SEC_SIZE;
    dword temp;

    waitForDisk(start, secSize, 0x20); // 读命令

    dword index = 0;

    while (index < size)
    {
        temp = inw_port(0x1f0); // 0x1f0需要读入一个字，否则会发生错误
        buf[index] = temp & 0xff;
        ++index;
        if (index == size)
            return;
        temp = temp >> 8;
        buf[index] = temp & 0xff;
        ++index;

        temp = _in_port(0x1f7);
        if (temp & 0x1)
        {
            temp = _in_port(0x1f1);
            printf("Disk Error: 0x%x\n", temp);
            return;
        }
    }
}

void Disk::waitForDisk(dword start, dword amount, dword type)
{
    dword temp;

    temp = start;
    _out_port(0x1f2, amount);
    _out_port(0x1f3, temp & 0xff);
    temp = temp >> 8;
    _out_port(0x1f4, temp & 0xff);
    temp = temp >> 8;
    _out_port(0x1f5, temp & 0xff);
    temp = temp >> 8;
    _out_port(0x1f6, (temp & 0xf) | 0xe0);
    _out_port(0x1f7, type);

    while (1)
    {
        temp = _in_port(0x1f7);
        if (temp & 0x1)
        {
            temp = _in_port(0x1f1);
            printf("Disk Error: 0x%x\n", temp);
            return;
        }
        else
        {
            if ((temp & 0x88) == 0x8)
            {
                return;
            }
        }
    }
}