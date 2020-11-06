#ifndef DISK_H
#define DISK_H

#include "../type.h"
#include "../configure/os_configure.h"
#include "../oslib.h"
#include "../cstdio.h"

// 实现硬盘按块存取，按字节存取

class Disk
{
private:
    Disk();

public:
    // 按块写入，每次写一个块
    static void write(dword start, void *buf)
    {
        byte *buffer = (byte *)buf;

        waitForDisk(start, SECTOR_SIZE, 0x30);

        for (int i = 0; i < SECTOR_SIZE; i += 2)
        {
            dword temp = (buffer[i] << 8) + buffer[i];
            // intel下需要按小端方式写，因为读的时候是按小端方式读取的
            outw_port(0x1f0, temp); // 每次需要向ox1f0写入一个字

            temp = _in_port(0x1f7);
            if (temp & 0x1)
            {
                temp = _in_port(0x1f1);
                printf("---Disk::write---\n"
                       "Disk Error: 0x%x\n",
                       temp);
                return;
            }
        }
    }

    // 按块读出
    static void read(dword start, void *buf)
    {
        byte *buffer = (byte *)buf;

        waitForDisk(start, SECTOR_SIZE, 0x20);

        for (int i = 0; i < SECTOR_SIZE; i += 2)
        {
            dword temp = inw_port(0x1f0); // 0x1f0需要读入一个字，否则会发生错误
            buffer[i] = temp & 0xff;
            temp = temp >> 8;
            buffer[i + 1] = temp & 0xff;

            temp = _in_port(0x1f7);
            if (temp & 0x1)
            {
                temp = _in_port(0x1f1);
                printf("---Disk::read---\n"
                       "Disk Error: 0x%x\n",
                       temp);
                return;
            }
        }
    }

    // 按字节写入
    static void writeBytes(dword startByte, void *buf, dword size)
    {
        byte *buffer = (byte *)buf;
        byte *temp = (byte *)kernelMalloc(SECTOR_SIZE);
        if (!temp)
        {
            printf("---Disk::writeBytes---\n"
                   "can not allocate memory from kernel\n");
        }

        dword startSector = startByte / SECTOR_SIZE;
        // 易错
        dword endSector = (startByte + size - 1) / SECTOR_SIZE;

        dword offset, len, totalBytes;
        // 处理头
        read(startSector, temp);
        offset = startByte - startSector * SECTOR_SIZE;
        len = size < (SECTOR_SIZE - offset) ? size : SECTOR_SIZE - offset;
        totalBytes = 0;

        for (int i = 0; i < len; ++i)
        {
            temp[i + offset] = buffer[i];
        }

        write(startSector, temp);
        totalBytes += len;

        // 处理中间
        for (int i = startSector + 1; i < endSector; ++i)
        {
            write(i, buffer + totalBytes);
            totalBytes += SECTOR_SIZE;
        }

        // 处理尾部
        len = size - totalBytes;
        if (len)
        {
            read(endSector, temp);
            for (int i = 0; i < len; ++i)
            {
                temp[i] = buffer[totalBytes + i];
            }
            write(endSector, temp);
        }

        kernelFree(temp);
    }

    // 按字节读出
    static void readBytes(dword startByte, void *buf, dword size)
    {
        byte *buffer = (byte *)buf;
        byte *temp = (byte *)kernelMalloc(SECTOR_SIZE);
        if (!temp)
        {
            printf("---Disk::readBytes---\n"
                   "can not allocate memory from kernel\n");
        }

        dword startSector = startByte / SECTOR_SIZE;
        // 注意下标
        dword endSector = (startByte + size - 1) / SECTOR_SIZE;

        dword offset, len, totalBytes;

        // 处理头
        read(startSector, temp);
        offset = startByte - startSector * SECTOR_SIZE;
        len = size < (SECTOR_SIZE - offset) ? size : SECTOR_SIZE - offset;
        totalBytes = 0;

        for (int i = 0; i < len; ++i)
        {
            buffer[i] = temp[i + offset];
        }

        totalBytes += len;

        // 处理中间
        for (int i = startSector + 1; i < endSector; ++i)
        {
            read(i, buffer + totalBytes);
            totalBytes += SECTOR_SIZE;
        }

        // 处理尾部
        len = size - totalBytes;
        if (len)
        {
            read(endSector, temp);
            for (int i = 0; i < len; ++i)
            {
                buffer[totalBytes + i] = temp[i];
            }
        }

        kernelFree(temp);
    }

private:
    static void waitForDisk(dword start, dword amount, dword type)
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
                printf("---Disk::wairForDisk---\n"
                       "Disk Error: 0x%x\n",
                       temp);
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
};

#endif