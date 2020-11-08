#ifndef FS_H
#define FS_H

// 文件系统的实现

#include "super_block.h"
#include "inode.h"
#include "directory_entry.h"
#include "fs_constant.h"

#include "../disk/disk.h"
#include "../disk/disk_bitmap.h"
#include "../configure/os_configure.h"

struct OpenedFile
{
    Inode inode; // 文件对应的inode
    dword count; // 文件被多少个线程/进程打开，未打开文件count=0
    bool rw;     // 文件属于写/读，true=读，false=写
    dword type;  // 文件类型
};

class FileSystem
{
private:
    SuperBlock sb;                                   // 超级块
    OpenedFile openedFiles[MAX_SYSTEM_OPENED_FILES]; // 打开文件表, 0, 1, 2提前占用
    DiskBitMap blockBitmap;                          // 空闲块位图，用于管理数据区
    DiskBitMap inodeBitmap;                          // inode位图，用于管理inode table

public:
    /**********************************/
    // 未考虑多线程的情况
    /*********************************/
    FileSystem();

    // 初始化，查看磁盘中是否建立了文件系统，若为建立，则需要建立一个后写入
    void init();

    // 按路径path打开文件，创建一个OpenedFile对象放入openedFiles中，并将其下标作为文件句柄返回。未找到或打开文件表已满则返回-1
    dword openFile(const char *path, bool rw, dword type);

    // 按路径删除文件
    dword deleteFile(const char *path, dword type);

    // 按路径创建文件
    dword createFile(const char *path, dword type);

    // 清除文件句柄对应的文件内容
    dword clearFile(dword handle);

    // 读取文件句柄的文件数据块到buffer中，要求buffer需要至少SERCTOR_SIZE的大小
    dword readFile(dword handle, dword start, void *buf);

    // 写入文件句柄的文件内容到buffer中
    dword writeFile(dword handle, dword start, void *buf);

    // 关闭文件
    dword closeFile(dword handle);

public:
    // 找到路径path对应的inode
    Inode pathToInode(const char *path, dword type);

    // 找到在inode table中下标为index对应的inode
    Inode getInode(dword index);

    // 找到文件所在的目录
    DirectoryEntry getDirectoryOfFile(const char *path);

    // 在给定目录current中找到名字为filename，文件类型为type的目录项
    DirectoryEntry getEntryInDirectory(const DirectoryEntry &current, const char *filename, dword type);

    // 从路径path中解析出文件名
    void getFileNameInPath(const char *path, char *filename);

    // 删除在目录current中名字为name，类型为type的目录项
    dword deleteEntryInDirectory(const DirectoryEntry &current, const char *name, dword type);

    // 在目录current中新建名字为name，类型为type的目录项
    dword createEntryInDirectory(const DirectoryEntry &current, const char *name, dword type);

    // 分配一个数据块，若分配成功，则返回逻辑扇区号，否则返回-1
    dword allocateDataBlock();
};

FileSystem sysFileSystem;



#endif