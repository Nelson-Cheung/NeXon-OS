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

#define READ 0x1 
#define WRITE 0x2

struct OpenedFile
{
    Inode inode; // 文件对应的inode
    dword count; // 文件被多少个线程/进程打开，未打开文件count=0
    dword mode; // 文件打开模式
    dword type;  // 文件类型
};

class FileSystem
{
public:
    SuperBlock sb;                                   // 超级块
    OpenedFile openedFiles[MAX_SYSTEM_OPENED_FILES]; // 打开文件表, 0, 1, 2提前占用
    DiskBitMap blockBitmap;                          // 空闲块位图，用于管理数据区
    DiskBitMap inodeBitmap;                          // inode位图，用于管理inode table

public:
    /**********************************/
    // 未考虑多线程的情况，多线程应该在系统调用中同步
    /*********************************/
    FileSystem();

    // 初始化，查看磁盘中是否建立了文件系统，若为建立，则需要建立一个后写入
    void init(); // pass

    // 按路径path打开文件，创建一个OpenedFile对象放入openedFiles中，并将其下标作为文件句柄返回。未找到或打开文件表已满则返回-1
    dword openFile(const char *path, dword mode, dword type); // pass
    dword openFile(DirectoryEntry entry, dword mode, dword type); // pass
    
    // 关闭文件
    dword closeFile(dword handle); // pass

    // 按路径创建目录文件、普通文件
    dword createFile(const char *path, dword type); // pass

    // 读取文件句柄的文件数据块到buffer中，要求buffer需要至少SERCTOR_SIZE的大小
    dword readFileBlock(dword handle, dword block, void *buf);

    // 将buffer的内容写到文件已存在的块中
    dword writeFileBlock(dword handle, dword block, void *buf);

    // 为文件新增一个数据块
    dword appendFileBlock(dword handle);

    // 删除文件最后一个数据块
    dword popFileBlock(dword handle);

    // 按路径删除文件
    dword deleteFile(const char *path, dword type);

public:
    // 找到路径path对应的inode
    Inode pathToInode(const char *path, dword type); // pass

    // 找到在inode table中下标为index对应的inode
    Inode getInode(dword index); // pass

    // 找到文件所在的目录
    DirectoryEntry getDirectoryOfFile(const char *path); // pass

    // 在给定目录current中找到名字为filename，文件类型为type的目录项
    DirectoryEntry getEntryInDirectory(const DirectoryEntry &current, const char *filename, dword type); // pass

    // 从路径path中解析出文件名
    void getFileNameInPath(const char *path, char *filename); // pass

    // 在目录current中新建名字为name，类型为type的目录项
    dword createEntryInDirectory(const DirectoryEntry &current, const char *name, dword type); // pass

    // 分配一个数据块，若分配成功，则返回逻辑扇区号，否则返回-1
    dword allocateDataBlock(); // pass

    // 获取根目录
    Inode getRootInode(); // pass

    // 删除在目录current中名字为name，类型为type的目录项
    dword deleteEntryInDirectory(const DirectoryEntry &current, const char *name, dword type);
};

FileSystem sysFileSystem;

#endif