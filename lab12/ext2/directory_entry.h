#ifndef DIRECTORY_ENTRY
#define DIRECTORY_ENTRY

#include "inode.h"
#include "fs_constant.h"

// 目录项用于目录中，用于建立文件名和文件对应的inode之间的联系

struct DirectoryEntry
{
    dword inode;                  // 用来描述目录文件的inode在inode table的下标地址
    char name[MAX_FILE_NAME + 1]; // 文件名或目录名
    dword type;                   // 文件类型，普通文件、目录文件和设备文件

    DirectoryEntry()
    {
        inode = -1;
    }

    DirectoryEntry(const DirectoryEntry &entry)
    {
        inode = entry.inode;
        type = entry.type;
        int i = 0;
        for (; entry.name[i]; ++i)
        {
            name[i] = entry.name[i];
        }
        name[i] = '\0';
    }

    DirectoryEntry &operator=(const DirectoryEntry &entry)
    {
        inode = entry.inode;
        type = entry.type;
        int i = 0;
        for (; entry.name[i]; ++i)
        {
            name[i] = entry.name[i];
        }
        name[i] = '\0';

        return *this;
    }

    void setName(const char *name)
    {
        int i = 0;
        for (; i < MAX_FILE_NAME && name[i]; ++i)
        {
            this->name[i] = name[i];
        }
        this->name[i] = '\0';
    }

    const char *getName()
    {
        return name;
    }
};

#endif