#ifndef FILE_H
#define FILE_H

#include "../kernel/type.h"
#include "../configure/os_configure.h"
#include "fs_constant.h"

class File
{
private:
    dword handle;   // 操作的文件的handle在handle table的下标，-1表示文件未打开(句柄)
    dword position; // 文件指针，以字节为单位，即读取或写入的光标在文件的第几个字节
    dword mode;     // 文件打开模式
public:
    File();
    ~File();
    void open(const char *path, dword mode); // 打开文件
    bool isOpen();                           // 判断文件是否打开

    // 文件未打开时下面函数不会执行系统调用

    void read(void *buf, dword size);  // 从position的位置读取size个字节到buf
    void write(void *buf, dword size); // 将buf中的size个字节写入文件
    dword seek();                      // 返回文件指针
    void reset(dword position);        // 重置文件指针
    void close();                      // 关闭文件
};
#endif