#ifndef FS_CONSTANT_H
#define FS_CONSTANT_H

// 文件名的最大长度
#define MAX_FILE_NAME 15
// 系统打开文件表数目
#define MAX_SYSTEM_OPENED_FILES 32
// 用户打开文件表数目
#define MAX_USER_OPENED_FILES 4

// 文件打开模式
// truncate
#define FILE_OPEN_TRUNCATE 0
// append
#define FILE_OPEN_APPEND 1
// read
#define FILE_OPEN_READ 2
// read and write
#define FILE_OPEN_RW 3

//文件类型
// 普通文件
#define REGULAR_FILE 0
// 目录文件
#define DIRECTORY_FILE 1
// 设备文件
#define DEVICE_FILE 2

#endif