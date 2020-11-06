#ifndef DISK_H
#define DISK_H

#include "../type.h"
#include "../configure/os_configure.h"
#include "../oslib.h"
#include "../cstdio.h"

class Disk
{
private:
    Disk();

public:
    static void write(dword start, byte *buf, dword size)
    {
        dword secSize = (size + SECTOR_SIZE - 1) / SECTOR_SIZE;
        byte afterLastByte;

        // 每次写入一个字，size为奇数的时候就会发生覆盖的问题
        if (size % 2)
        {
            byte buffer[SECTOR_SIZE];
            read(start + secSize - 1, buffer, SECTOR_SIZE);
            dword offset = size - (secSize - 1) * SECTOR_SIZE;
            afterLastByte = buffer[offset];
        }

        dword temp;

        waitForDisk(start, secSize, 0x30);

        dword index = 0;
        while (index < size)
        {
            temp = buf[index];
            ++index;
            // intel下需要按小端方式写，因为读的时候是按小端方式读取的
            if (size % 2 && index == size)
            {
                temp = (temp << 8) + afterLastByte;
            }
            else
            {
                temp = (temp << 8) + buf[index];
            }
            ++index;
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

    static void read(dword start, byte *buf, dword size)
    {

        dword secSize = (size + SECTOR_SIZE - 1) / SECTOR_SIZE;
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

    // 按字节写入
    static void writeBytes(dword startByte, void *buf, dword size)
    {
        byte *buffer = (byte *)buf;
        byte *temp = (byte *)kernelMalloc(SECTOR_SIZE);
        if (!temp)
            return;

        dword startSector = startByte / SECTOR_SIZE;
        dword endSector = (startByte + size) / SECTOR_SIZE;

        dword offset, len, totalBytes;
        // 处理头
        read(startSector, temp, SECTOR_SIZE);
        offset = startByte - startSector * SECTOR_SIZE;
        len = size < (SECTOR_SIZE - offset) ? size : SECTOR_SIZE;
        totalBytes = 0;

        for (int i = 0; i < len; ++i)
        {
            temp[i + offset] = buffer[i];
        }

        write(startSector, temp, SECTOR_SIZE);
        totalBytes += len;

        // 处理中间
        for (int i = startSector + 1; i < endSector; ++i)
        {
            write(i, buffer + totalBytes, SECTOR_SIZE);
            totalBytes += SECTOR_SIZE;
        }

        // 处理尾部
        len = size - totalBytes;
        if (len)
        {
            read(endSector, temp, SECTOR_SIZE);
            for (int i = 0; i < len; ++i)
            {
                temp[i] = buffer[totalBytes + i];
            }
            write(endSector, temp, SECTOR_SIZE);
        }

        kernelFree(temp);
    }

    static void readBytes(dword startByte, void *buf, dword size)
    {
        byte *buffer = (byte *)buf;
        byte *temp = (byte *)kernelMalloc(SECTOR_SIZE);
        if (!temp)
            return;

        dword startSector = startByte / SECTOR_SIZE;
        // 注意下标
        dword endSector = (startByte + size - 1) / SECTOR_SIZE;

        dword offset, len, totalBytes;
        // 处理头
        read(startSector, temp, SECTOR_SIZE);
        offset = startByte - startSector * SECTOR_SIZE;
        len = size < (SECTOR_SIZE - offset) ? size : SECTOR_SIZE;
        totalBytes = 0;

        for (int i = 0; i < len; ++i)
        {
            buffer[i] = temp[i + offset];
        }

        totalBytes += len;

        // 处理中间
        for (int i = startSector + 1; i < endSector; ++i)
        {
            read(i, buffer + totalBytes, SECTOR_SIZE);
            totalBytes += SECTOR_SIZE;
        }

        // 处理尾部
        len = size - totalBytes;
        if (len)
        {
            read(endSector, temp, SECTOR_SIZE);
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
};

#endif