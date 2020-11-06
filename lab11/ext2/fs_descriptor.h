#ifndef FS_DESCRIPTOR
#define FS_DESCRIPTOR

#include "bitmap.h"

struct FSDescriptor
{
    BitMap blockBitmap; // 空闲块位图，用于管理数据区
    BitMap inodeBitmap; // inode位图，用于管理inode table
};
#endif