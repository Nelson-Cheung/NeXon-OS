#include "bitmap.h"

BitMap::BitMap()
{
    bitmap = nullptr;
    length = 0;
}

void BitMap::setBitMap(byte *bitmap, const dword length)
{
    this->bitmap = bitmap;
    this->length = length;

    dword len = length / 8;
    if (length % 8)
        ++len;

    for (int i = 0; i < len; ++i)
    {
        bitmap[i] = 0;
    }
}

bool BitMap::get(const dword index)
{
    dword pos = index / 8;
    dword offset = (7 - (index % 8));
    byte mask = 1 << offset;

    return (bitmap[pos] & mask);
}

void BitMap::set(const dword index, const bool status)
{
    dword pos = index / 8;
    dword offset = (7 - (index % 8));
    byte mask = 0xfe;
    for (int i = 0; i < offset; ++i)
    {
        mask = (mask << 1) + 1;
    }
    bitmap[pos] = bitmap[pos] & mask;

    mask = status << offset;
    bitmap[pos] = bitmap[pos] | mask;
}

dword BitMap::allocate(const dword count)
{
    if (count == 0)
        return -1;

    dword index = 0, empty, start;

    while (index < length)
    {
        while (index < length && get(index))
            ++index;

        if (index == length)
            return -1;

        empty = 0;
        start = index;
        while ((index < length) && (!get(index)) && (empty < count))
        {
            ++empty;
            ++index;
        }

        if (empty == count)
        {
            for (int i = 0; i < count; ++i)
            {
                set(start + i, true);
            }
        }
        return start;
    }

    return -1;
}

void BitMap::release(const dword index, const dword count)
{
    for (int i = 0; i < count; ++i)
    {
        set(index + i, false);
    }
}

void *BitMap::getBitmapData() {
    return bitmap;
}