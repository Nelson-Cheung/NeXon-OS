#include "fs.h"
#include "../cstdlib.h"
#include "../syscall.h"
#include "../cstdio.h"
#include "directory_entry.h"
#include "../string.h"

FileSystem::FileSystem()
{
    init();
}

void FileSystem::init()
{
    Disk::read(PARTITION_1_START, (byte *)&sb, sizeof(SuperBlock));
    // 判断文件系统是否已经建立，若未建立则需先建立
    if (sb.magic == 0x19241112)
    {
        printf("file system has been built\n");
    }
    else
    {
        // 致敬 1924.11.12
        sb.magic = 0x19241112;
        // 文件系统所能管理的扇区数，0分区用于内核代码，1分区是文件系统管理区
        sb.totalSectors = HADR_DISK_SECTOR_AMOUNT - PARTITION_1_START + 1;
        // 越过超级块
        sb.inodeBitmapStartSector = 1 + PARTITION_1_START;
        sb.inodeBitmapLength = MAX_FILES / BITS_PER_SECTOR;

        sb.inodeTableStartSector = sb.inodeBitmapStartSector + sb.inodeBitmapLength;
        sb.inodeTableLength = (sizeof(Inode) * MAX_FILES) / SECTOR_SIZE;

        sb.blockBimapStartSector = sb.inodeTableStartSector + sb.inodeTableLength;
        sb.blockBimapLength = (sb.totalSectors - sb.blockBimapStartSector) / BITS_PER_SECTOR;
        // 粗略地估算，事实上，后面会剩下若干个扇区无法被管理
        sb.blockBimapLength = (sb.totalSectors - sb.blockBimapStartSector - sb.blockBimapLength) / BITS_PER_SECTOR;

        sb.dataFieldStartSector = sb.blockBimapStartSector + sb.blockBimapLength;
        sb.dataFieldLength = sb.blockBimapLength * 8; // 一个字节是8位

        // 超级块被放置在文件系统管理的扇区的第一个扇区
        Disk::write(PARTITION_1_START, (byte *)&sb, SECTOR_SIZE);
    }

    // 初始化打开文件表
    for (int i = 0; i < MAX_SYSTEM_OPENED_FILES; ++i)
    {
        openedFiles[i].inode.id = -1;
    }

    blockBitmap.setBitMap(sb.blockBimapStartSector, sb.dataFieldLength);
    inodeBitmap.setBitMap(sb.inodeBitmapStartSector, MAX_FILES);

    // 初始化根目录
    blockBitmap.set(0, true);
    inodeBitmap.set(0, true);

    DirectoryEntry dir;

    byte buffer[2 * sizeof(DirectoryEntry)];

    dir.inode = 0;
    dir.name[0] = '.';
    dir.name[1] = '\0';
    dir.type = DIRECTORY_FILE;
    memcpy(&dir, buffer, sizeof(DirectoryEntry));
    
    dir.name[0] = '.';
    dir.name[1] = '.';
    dir.name[2] = '\0';
    memcpy(&dir, buffer + sizeof(DirectoryEntry), sizeof(DirectoryEntry));

    Disk::write(sb.dataFieldStartSector, buffer, 2 * sizeof(DirectoryEntry));

    Inode root;
    root.blocks[0] = sb.dataFieldStartSector;
    root.size = 2 * sizeof(DirectoryEntry);

    Disk::write(sb.inodeTableStartSector, (byte *)&root, sizeof(Inode));
}


// dword FileSystem::openFile(const char *path, bool rw, dword type)
// {
//     // 先在打开文件表中寻找
//     Inode inode = pathToInode(path, type);

//     // 未找到对应的文件
//     if (inode.id == -1)
//         return -1;

//     dword index;
//     // 检查是否已在打开文件表中
//     for (index = 0; index < MAX_SYSTEM_OPENED_FILES; ++index)
//     {
//         if (openedFiles[index].inode.id == inode.id &&
//             openedFiles[index].type == type)
//             break;
//     }

//     // 存在于打开文件表中
//     /**********************************/
//     // 应考虑多线程的情况
//     /*********************************/
//     if (index < MAX_SYSTEM_OPENED_FILES)
//     {
//         // 以读方式打开
//         if (rw)
//         {
//             // 已打开文件是以读方式打开的
//             if (openedFiles[index].rw)
//             {
//                 ++openedFiles[index].count;
//                 return index;
//             }
//             else
//             {
//                 return -1;
//             }
//         }
//         else
//         {
//             // 以写方式打开，只能有一个写者
//             if (!openedFiles[index].count)
//             {
//                 ++openedFiles[index].count;
//                 return index;
//             }
//             else
//             {
//                 return -1;
//             }
//         }
//     }

//     for (index = 0; index < MAX_SYSTEM_OPENED_FILES; ++index)
//     {
//         if (openedFiles[index].count == 0)
//             break;
//     }

//     // 打开文件表已满

//     if (index == MAX_SYSTEM_OPENED_FILES)
//         return -1;
//     // 将inode加载进内存
//     openedFiles[index].inode = inode;
//     openedFiles[index].count = 1;
//     openedFiles[index].rw = rw;
//     return index;
// }

// dword FileSystem::deleteFile(const char *path, dword type)
// {
//     DirectoryEntry entry = getDirectoryOfFile(path);
//     if (entry.inode == -1)
//         return false;

//     char filename[MAX_FILE_NAME + 1];
//     getFileNameInPath(path, filename);

//     return deleteEntryInDirectory(entry, filename, type);
// }

// dword FileSystem::createFile(const char *path, dword type)
// {
//     DirectoryEntry entry = getDirectoryOfFile(path);
//     if (entry.inode == -1)
//         return false;

//     char filename[MAX_FILE_NAME + 1];
//     getFileNameInPath(path, filename);
//     createEntryInDirectory(entry, filename, REGULAR_FILE);
// }


// dword FileSystem::readFile(dword handle, dword start, void *buf)
// {
//     Inode inode = openedFiles[handle].inode;
//     inode.readBlock(start, buf);
// }

// dword FileSystem::writeFile(dword handle, dword start, void *buf)
// {
//     if(openedFiles[handle].rw) return false;
//     openedFiles[handle].inode.writeBlock(start, buf);
// }

// dword FileSystem::closeFile(dword handle)
// {
//     --openedFiles[handle].count;
// }

// Inode FileSystem::pathToInode(const char *path, dword type)
// {
//     DirectoryEntry dir = getDirectoryOfFile(path);

//     char filename[MAX_FILE_NAME];
//     getFileNameInPath(path, filename);
//     DirectoryEntry entry = getEntryInDirectory(dir, filename, type);
//     if (entry.inode == -1)
//         return Inode();
//     return getInode(entry.inode);
// }

// Inode FileSystem::getInode(dword index)
// {
//     Inode inode;
//     dword startByte = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * index;
//     Disk::readBytes(startByte, &inode, sizeof(Inode));
//     return inode;
// }
// DirectoryEntry FileSystem::getDirectoryOfFile(const char *path)
// {
//     /**********************/
//     //不考虑当前目录
//     /**********************/

//     dword inodeNumber = 0;
//     DirectoryEntry entry;
//     char filename[MAX_FILE_NAME + 1];

//     dword first, last, next, len;
//     first = strlib::firstIn(path, '/');
//     last = strlib::firstIn(path, '/');

//     DirectoryEntry current;

//     if (first == 0)
//     {
//         // 根目录
//         current.inode = 0;
//     }
//     else if (last == -1)
//     {
//         // path就是当前目录下的文件名
//         current.inode = 0;
//         return current;
//     }
//     else
//     {
//         // 暂时不考虑进程当前目录
//         current.inode = 0;
//         return current;
//     }

//     // 允许多个'/'整合成为一个'/'
//     while (last >= 0 && path[last] == '/')
//         --last;
//     ++last;

//     while (first < last && path[first] == '/')
//         ++first;

//     while (first < last)
//     {
//         next = strlib::firstIn(path + first, '/');
//         strlib::strcpy(path, filename, first, next - first);
//         current = getEntryInDirectory(current, filename, DIRECTORY_FILE);
//         first = next + 1;
//         while (first < last && path[first] == '/')
//             ++first;
//     }

//     return current;
// }

// DirectoryEntry FileSystem::getEntryInDirectory(const DirectoryEntry &current, const char *filename, dword type)
// {
//     Inode inode;
//     dword startBytes = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * current.inode;
//     Disk::readBytes(startBytes, &inode, sizeof(Inode));
//     DirectoryEntry entry;

//     for (int offset = 0; offset < inode.size; offset += sizeof(DirectoryEntry))
//     {
//         inode.read(offset, &entry, sizeof(entry));
//         if (entry.inode != -1 && entry.type == type && strlib::strcmp(entry.getName(), filename))
//         {
//             return entry;
//         }
//     }

//     return DirectoryEntry();
// }

// void FileSystem::getFileNameInPath(const char *path, char *filename)
// {
//     int start = strlib::lastIn(path, '/');
//     if (start < 0)
//         start = 0;
//     else
//         start += 1;

//     strlib::strcpy(path, filename, start, strlib::len(path) - start + 1);
// }

// dword FileSystem::deleteEntryInDirectory(const DirectoryEntry &current, const char *name, dword type)
// {
//     DirectoryEntry entry;
//     Inode inode = getInode(current.inode);
//     dword offset;
//     for (offset = 0; offset < inode.size; offset += sizeof(DirectoryEntry))
//     {
//         inode.read(offset, &entry, sizeof(DirectoryEntry));
//         if (strlib::strcmp(entry.getName(), name) == 0 &&
//             entry.type == type)
//         {
//             dword startByte = inode.size - sizeof(DirectoryEntry);
//             inode.read(startByte, &entry, sizeof(DirectoryEntry));
//             inode.write(offset, &entry, sizeof(DirectoryEntry));
//             inode.size -= sizeof(DirectoryEntry);

//             dword blockAmount = (inode.size + SECTOR_SIZE - 1) / SECTOR_SIZE;
//             if (blockAmount < inode.blockAmount)
//             {
//                 if (blockAmount == INODE_BLOCK_DIRECT)
//                 {
//                     dword block = inode.blocks[INODE_BLOCK_DIRECT + 0] - sb.dataFieldStartSector;
//                     blockBitmap.release(block, 1);
//                 }
//                 dword block = inode.blockPopBack() - sb.dataFieldStartSector;
//                 blockBitmap.release(block, 1);
//             }

//             startByte = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * current.inode;
//             Disk::writeBytes(startByte, &inode, sizeof(Inode));

//             return true;
//         }
//     }

//     return false;
// }
// dword FileSystem::createEntryInDirectory(const DirectoryEntry &current, const char *name, dword type)
// {
//     DirectoryEntry entry;
//     // 判断是否存在一个目录项
//     entry = getEntryInDirectory(current, name, type);
//     if (entry.inode != -1)
//         return false;

//     entry.inode = inodeBitmap.allocate(1);
//     if (entry.inode == -1)
//         return -1;

//     entry.type = type;
//     strlib::strcpy(name, entry.name, 0, strlib::len(name));

//     Inode inode = getInode(current.inode);

//     // 超出inode现有的数据块大小
//     if (inode.size + sizeof(DirectoryEntry) > inode.getBlockAmount() * SECTOR_SIZE)
//     {
//         dword block = blockBitmap.allocate(1) + sb.dataFieldStartSector;
//         if (block == -1)
//             return false;
//         inode.blockPushBack(block);
//         dword startBytes = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * inode.id;
//         Disk::writeBytes(startBytes, &inode, sizeof(Inode));
//     }

//     inode.write(inode.size, &entry, sizeof(DirectoryEntry));

//     return true;
// }