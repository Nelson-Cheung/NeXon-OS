#ifndef SUPER_BLOCK_H
#define SUPER_BLOCK_H

#include "../kernel/type.h"
#include "../configure/os_configure.h"

// 超级块保存的是文件系统的配置信息
// 修改超级块后必须修改padding数组

struct SuperBlock
{
    dword magic;                                    // 固定的常数，取0x19241112，用于判断文件系统是否建立
    dword totalSectors;                             // 文件系统管理的总扇区数
    dword inodeBitmapStartSector;                   // inode位图实际的数据区域的起始扇区地址
    dword inodeBitmapLength;                        // inode位图实际的数据区域占据的扇区数
    dword inodeTableStartSector;                    // inode表起始的扇区地址
    dword inodeTableLength;                         // inode表占据的扇区数
    dword blockBimapStartSector;                    // 空闲块位图实际的数据区域的起始扇区地址
    dword blockBimapLength;                         // 空闲块位图实际的数据区域占据的扇区数
    dword dataFieldStartSector;                     // 数据区起始的扇区地址
    dword dataFieldLength;                          // 数据区占据的扇区总数
    byte padding[SECTOR_SIZE - sizeof(dword) * 10]; // 填充字符
};

#endif