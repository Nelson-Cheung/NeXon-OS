#ifndef FS_H
#define FS_H

// 文件系统的实现

#include "super_block.h"
#include "inode.h"
#include "directory_entry.h"
#include "fs_constant.h"
#include "fs_descriptor.h"
#include "../disk/disk.h"
#include "../disk/disk_bitmap.h"
#include "../configure/os_configure.h"

struct OpenedFile
{
    Inode inode;             // 文件对应的inode
    //DirectoryEntry dirEntry; // 文件在目录中的目录项
    dword count;             // 文件被多少个线程/进程打开，未打开文件count=0
    bool rw;                 // 文件属于写/读，true=读，false=写
    dword type; // 文件类型
};

class FileSystem
{
private:
    SuperBlock sb; // 
    OpenedFile openedFiles[MAX_SYSTEM_OPENED_FILES]; // 打开文件表, 0, 1, 2提前占用
    DiskBitMap blockBitmap; // 空闲块位图，用于管理数据区
    DiskBitMap inodeBitmap; // inode位图，用于管理inode table

public:
    /**********************************/
    // 未考虑多线程的情况
    /*********************************/
    FileSystem();

    void init(); // 初始化，查看磁盘中是否建立了文件系统，若为建立，则需要建立一个后写入

    dword openFile(const char *path, bool rw, dword type); // 按路径path打开文件，创建一个OpenedFile对象放入openedFiles中，并将其下标作为文件句柄返回。未找到或打开文件表已满则返回-1

    dword deleteFile(const char *path, dword type); // 按路径删除文件

    dword createFile(const char *path, dword type); // 按路径创建文件

    dword clearFile(dword handle); // 清除文件句柄对应的文件内容

    dword readFile(dword handle, dword start, void *buf); // 读取文件句柄的文件数据块到buffer中，要求buffer需要至少SERCTOR_SIZE的大小

    dword writeFile(dword handle, dword start, void *buf); // 写入文件句柄的文件内容到buffer中

    dword closeFile(dword handle); // 关闭文件

private:
    Inode pathToInode(const char *path, dword type);
    Inode getInode(dword index);
    DirectoryEntry getDirectoryOfFile(const char *path);
    DirectoryEntry getEntryInDirectory(const DirectoryEntry &current, const char *filename, dword type);
    void getFileNameInPath(const char *path, char *filename);
    dword deleteEntryInDirectory(const DirectoryEntry &current, const char *name, dword type);
    dword createEntryInDirectory(const DirectoryEntry &current, const char *name, dword type);
};

#endif