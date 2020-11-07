#include "disk_bitmap.h"
#include "../math.h"

DiskBitMap::DiskBitMap()
{
    length = start = -1;
    byte mask = 128;

    // 全局变量不调用构造函数
    for (int i = 0; i < 8; ++i)
    {
        masks[i] = mask;
        mask = mask >> 1;
    }
}

DiskBitMap::DiskBitMap(const DiskBitMap &other)
{
    length = other.length;
    start = other.start;
}

DiskBitMap &DiskBitMap::operator=(const DiskBitMap &other)
{
    length = other.length;
    start = other.start;
    return *this;
}

void DiskBitMap::setBitMap(const dword start, const dword length)
{
    this->start = start;
    this->length = length;

    dword mask = 128;
    for (int i = 0; i < 8; ++i)
    {
        masks[i] = mask;
        mask = mask >> 1;
    }
}

dword DiskBitMap::allocate()
{
    byte *buffer = (byte *)kernelMalloc(SECTOR_SIZE);
    if (!buffer)
    {
        return -1;
    }

    // 对于每一个字节，为了更直观地在二进制数中看到分配情况，
    // 采用从高位向低位设置的方式

    dword sectors = stdmath::roundup(length, BITS_PER_SECTOR);
    dword counter = 0;

    for (int i = 0; i < sectors && counter < length; ++i)
    {
        Disk::read(i + start, buffer);
        for (int j = 0; j < SECTOR_SIZE; ++j)
        {
            if (buffer[j] == 0xff)
            {
                counter += 8;
                continue;
            }

            for (int k = 0; k < 8; ++k)
            {
                if (buffer[j] & masks[k])
                    continue;
                if (k + counter < length)
                {
                    // 置位
                    buffer[j] = buffer[j] | masks[k];
                    // 同步化到磁盘
                    printf("---%d %d\n", i + start, buffer[j]);
                    Disk::write(i + start, buffer);
                    kernelFree(buffer);
                    return k + counter;
                }
            }
        }
    }

    kernelFree(buffer);
    return -1;
}

void DiskBitMap::release(const dword index)
{
    if (index >= length)
        return;

    dword sector = index / BITS_PER_SECTOR;
    dword offset = (index % BITS_PER_SECTOR) / 8;
    dword bit = index % BITS_PER_SECTOR % 8;

    byte *buffer = (byte *)kernelMalloc(SECTOR_SIZE);
    if (!buffer)
    {
        return;
    }

    Disk::read(start + sector, buffer);
    buffer[offset] = buffer[offset] & (~masks[bit]);

    Disk::write(start + sector, buffer);
}