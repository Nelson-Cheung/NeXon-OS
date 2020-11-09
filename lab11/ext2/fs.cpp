#include "fs.h"
#include "directory_entry.h"

#include "../cstdlib.h"
#include "../syscall.h"
#include "../cstdio.h"
#include "../string.h"
#include "../math.h"

FileSystem::FileSystem()
{
    init();
}

void FileSystem::init()
{
    // 文件系统管理的第一块扇区是超级块
    Disk::read(PARTITION_1_START, (byte *)&sb);
    bool flag;

    flag = false;

    // 判断文件系统是否已经建立，若未建立则需先建立
    if (sb.magic == 0x19241112)
    {
        printf("file system has been built\n");
        flag = true;
    }
    else
    {
        // 致敬 1924.11.12
        sb.magic = 0x19241112;
        // 文件系统所能管理的扇区数，0分区用于内核代码，1分区是文件系统管理区
        sb.totalSectors = HADR_DISK_SECTOR_AMOUNT - PARTITION_1_START + 1;
        // 越过超级块
        sb.inodeBitmapStartSector = 1 + PARTITION_1_START;
        sb.inodeBitmapLength = stdmath::roundup(MAX_FILES, BITS_PER_SECTOR);

        sb.inodeTableStartSector = sb.inodeBitmapStartSector + sb.inodeBitmapLength;
        sb.inodeTableLength = stdmath::roundup(sizeof(Inode) * MAX_FILES, SECTOR_SIZE);

        sb.blockBimapStartSector = sb.inodeTableStartSector + sb.inodeTableLength;
        sb.blockBimapLength = stdmath::roundup(sb.totalSectors - sb.blockBimapStartSector, BITS_PER_SECTOR);
        // 粗略地估算，事实上，后面会剩下若干个扇区无法被管理
        sb.blockBimapLength = stdmath::roundup(sb.totalSectors - sb.blockBimapStartSector - sb.blockBimapLength, BITS_PER_SECTOR);

        sb.dataFieldStartSector = sb.blockBimapStartSector + sb.blockBimapLength;
        sb.dataFieldLength = sb.totalSectors - sb.blockBimapStartSector - sb.blockBimapLength; // 一个字节是8位

        // 超级块被放置在文件系统管理的扇区的第一个扇区
        Disk::write(PARTITION_1_START, (byte *)&sb);
    }

    printf("build up file system\n"
           "magic: 0x%x\n"
           "totalSectors: %d\n"
           "inode bitmap start: %d, length: %d\n"
           "inode table start: %d, length: %d\n"
           "block bitmap start: %d, length: %d\n"
           "data field start: %d, length: %d\n"
           "size of super block: %d\n",
           sb.magic,
           sb.totalSectors,
           sb.inodeBitmapStartSector,
           sb.inodeBitmapLength,
           sb.inodeTableStartSector,
           sb.inodeTableLength,
           sb.blockBimapStartSector,
           sb.blockBimapLength,
           sb.dataFieldStartSector,
           sb.dataFieldLength,
           sizeof(SuperBlock));

    // 初始化打开文件表
    for (int i = 0; i < MAX_SYSTEM_OPENED_FILES; ++i)
    {
        openedFiles[i].inode.id = -1;
    }

    blockBitmap.setBitMap(sb.blockBimapStartSector, sb.dataFieldLength);
    inodeBitmap.setBitMap(sb.inodeBitmapStartSector, MAX_FILES);

    // 文件系统存在说明根目录已存在
    if (flag)
        return;

    // 初始化根目录，保证root的下标均为0
    dword index = blockBitmap.allocate();
    printf("%d\n", index);
    if (index)
    {
        printf("root init failed\n");
        while (1)
        {
        }
    }

    index = inodeBitmap.allocate();
    printf("%d\n", index);
    if (index)
    {
        printf("root init failed\n");
        while (1)
        {
        }
    }

    DirectoryEntry dir;

    byte *buffer = (byte *)kernelMalloc(SECTOR_SIZE);
    for (int i = 0; i < SECTOR_SIZE; ++i)
    {
        buffer[i] = 0xff;
    }

    dir.inode = 0;
    dir.name[0] = '.';
    dir.name[1] = '\0';
    dir.type = DIRECTORY_FILE;
    memcpy(&dir, buffer, sizeof(DirectoryEntry));

    dir.name[0] = '.';
    dir.name[1] = '.';
    dir.name[2] = '\0';
    memcpy(&dir, buffer + sizeof(DirectoryEntry), sizeof(DirectoryEntry));

    // 首地址必须是字节
    Disk::write(sb.dataFieldStartSector, buffer);

    Inode root;
    root.blocks[0] = sb.dataFieldStartSector;
    root.size = 2 * sizeof(DirectoryEntry);
    root.blockAmount = 1;
    root.id = 0;

    // 首地址必须是字节
    Disk::writeBytes(sb.inodeTableStartSector * SECTOR_SIZE, &root, sizeof(Inode));
}

dword FileSystem::openFile(const char *path, bool rw, dword type)
{
    // 目录文件禁止外界写
    if (rw == false && type == DIRECTORY_FILE)
        return false;

    // 查找是否有对应的文件
    Inode inode = pathToInode(path, type);

    // 未找到对应的文件
    if (inode.id == -1)
        return -1;

    dword index;
    // 检查是否已在打开文件表中
    for (index = 0; index < MAX_SYSTEM_OPENED_FILES; ++index)
    {
        if (openedFiles[index].inode.id == inode.id &&
            openedFiles[index].type == type)
            break;
    }

    // 存在于打开文件表中

    /**********************************/
    // 应考虑多线程的情况
    /*********************************/
    if (index < MAX_SYSTEM_OPENED_FILES)
    {
        // 以读方式打开
        if (rw)
        {
            // 已打开文件是以读方式打开的
            if (openedFiles[index].rw)
            {
                ++openedFiles[index].count;
                return index;
            }
            else
            {
                return -1;
            }
        }
        else
        {
            // 以写方式打开，只能有一个写者
            if (!openedFiles[index].count)
            {
                ++openedFiles[index].count;
                return index;
            }
            else
            {
                return -1;
            }
        }
    }

    // 找空位
    for (index = 0; index < MAX_SYSTEM_OPENED_FILES; ++index)
    {
        if (openedFiles[index].inode.id == -1)
            break;
    }

    if (index < MAX_SYSTEM_OPENED_FILES)
    {
        openedFiles[index].inode = inode;
        openedFiles[index].count = 1;
        openedFiles[index].rw = rw;
        openedFiles[index].type = type;
        return index;
    }

    // 替换其中一个打开文件，FIFO法则
    for (index = 0; index < MAX_SYSTEM_OPENED_FILES; ++index)
    {
        // 没有进程打开此文件
        if (openedFiles[index].count == 0)
            break;
    }

    if (index < MAX_SYSTEM_OPENED_FILES)
    {
        openedFiles[index].inode = inode;
        openedFiles[index].count = 1;
        openedFiles[index].rw = rw;
        openedFiles[index].type = type;
        return index;
    }

    // 打开文件表已满
    return -1;
}

dword FileSystem::closeFile(dword handle)
{
    if (handle >= 0 && handle < MAX_SYSTEM_OPENED_FILES)
        --openedFiles[handle].count;
}

dword FileSystem::createFile(const char *path, dword type)
{
    char filename[MAX_FILE_NAME + 1];
    getFileNameInPath(path, filename);

    if (strlib::len(filename) == 0 ||
        strlib::strcmp(filename, ".") == 0 ||
        strlib::strcmp(filename, "..") == 0)
        return false;

    DirectoryEntry entry = getDirectoryOfFile(path);

    //printf("%d %d %s\n", entry.type, entry.inode, filename);

    if (entry.inode == -1)
        return false;

    return createEntryInDirectory(entry, filename, type);
}

dword FileSystem::readFileBlock(dword handle, dword block, void *buf)
{
    if (handle >= MAX_SYSTEM_OPENED_FILES ||
        block >= openedFiles[handle].inode.blockAmount)
        return false;

    openedFiles[handle].inode.readBlock(block, buf);
    return true;
}

dword FileSystem::writeFileBlock(dword handle, dword block, void *buf)
{
    if (handle >= MAX_SYSTEM_OPENED_FILES ||
        block >= openedFiles[handle].inode.blockAmount)
        return false;

    openedFiles[handle].inode.writeBlock(block, buf);
    return true;
}

dword FileSystem::appendFileBlock(dword handle)
{
    dword block = allocateDataBlock();
    if (block == -1 || handle >= MAX_SYSTEM_OPENED_FILES)
        return false;

    openedFiles[handle].inode.blockPushBack(block);
}

dword FileSystem::popFileBlock(dword handle)
{
    if (handle >= MAX_SYSTEM_OPENED_FILES)
        return false;

    dword block = openedFiles[handle].inode.blockPopBack() - sb.dataFieldStartSector;
    // 在disk bitmap中block只是偏移
    blockBitmap.release(block);
    return true;
}

dword FileSystem::deleteFile(const char *path, dword type)
{
    char filename[MAX_FILE_NAME + 1];
    getFileNameInPath(path, filename);


    if (strlib::len(filename) == 0||
        strlib::strcmp(filename, ".") == 0 ||
        strlib::strcmp(filename, "..") == 0)
        return false;

    DirectoryEntry entry = getDirectoryOfFile(path);

    if (entry.inode == -1)
        return false;


    return deleteEntryInDirectory(entry, filename, type);
}

Inode FileSystem::pathToInode(const char *path, dword type)
{
    DirectoryEntry dir = getDirectoryOfFile(path);

    // 文件目录不存在
    if (dir.inode == -1)
        return Inode();

    char filename[MAX_FILE_NAME + 1];
    getFileNameInPath(path, filename);

    // 特例 "/"
    if (dir.inode == 0 && strlib::len(filename) == 0)
    {
        return getRootInode();
    }

    if (strlib::len(filename) == 0)
        return Inode();

    DirectoryEntry entry = getEntryInDirectory(dir, filename, type);
    return getInode(entry.inode);
}

Inode FileSystem::getInode(dword index)
{
    Inode inode;
    if (index == -1)
        return inode;

    dword startByte = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * index;
    Disk::readBytes(startByte, &inode, sizeof(Inode));
    return inode;
}

DirectoryEntry FileSystem::getDirectoryOfFile(const char *path)
{
    /**********************/
    //不考虑当前目录
    /**********************/

    dword inodeNumber = 0;
    DirectoryEntry entry;
    char filename[MAX_FILE_NAME + 1];

    dword first, last, next, len;
    first = strlib::firstIn(path, '/');
    last = strlib::lastIn(path, '/');

    DirectoryEntry current;

    if (first == 0)
    {
        // 根目录
        current.inode = 0;
        current.type = DIRECTORY_FILE;
        //strlib::strcpy("/", current.name, 0, strlib::len("/"));
    }
    else if (last == -1)
    {
        // path就是当前目录下的文件名
        current.inode = -1;
        return current;
    }
    else
    {
        // 暂时不考虑进程当前目录
        current.inode = -1;
        return current;
    }

    // 允许多个'/'整合成为一个'/'
    while (first < last && path[first] == '/')
        ++first;

    while (first < last)
    {
        next = strlib::firstIn(path + first, '/') + first;

        // 非法文件名
        if (next - first > MAX_FILE_NAME)
        {
            printf("invalid file name\n");
            return DirectoryEntry();
        }
        strlib::strcpy(path, filename, first, next - first);
        //printf("file name: %s\n", filename);

        current = getEntryInDirectory(current, filename, DIRECTORY_FILE);

        // 不存在此目录
        if (current.inode == -1)
            return current;

        first = next + 1;
        while (first < last && path[first] == '/')
            ++first;
    }

    return current;
}

DirectoryEntry FileSystem::getEntryInDirectory(const DirectoryEntry &current, const char *filename, dword type)
{
    Inode inode;
    dword startBytes = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * current.inode;
    Disk::readBytes(startBytes, &inode, sizeof(Inode));
    DirectoryEntry entry;
    bool flag;

    for (int offset = 0; offset < inode.size; offset += sizeof(DirectoryEntry))
    {
        flag = inode.read(offset, &entry, sizeof(entry));
        if (!flag)
        {
            // 读取文件内容失败
            return DirectoryEntry();
        }

        //目录是按照顺序紧密排列的，不会出现分散的情况
        if (entry.inode == -1)
            return entry;

        // 目录项匹配的条件：类型+文件名
        if (entry.type == type && strlib::strcmp(entry.getName(), filename) == 0)
        {
            return entry;
        }
    }

    return DirectoryEntry();
}

void FileSystem::getFileNameInPath(const char *path, char *filename)
{
    int start = strlib::lastIn(path, '/');
    if (start < 0)
        start = 0;
    else
        start += 1;

    strlib::strcpy(path, filename, start, strlib::len(path) - start);
}

dword FileSystem::deleteEntryInDirectory(const DirectoryEntry &current, const char *name, dword type)
{
    DirectoryEntry entry, innerEntry;
    dword block, offset;
    bool flag;
    Inode currentInode = getInode(current.inode);

    // 找到name, type对应的Directory Entry
    for (offset = 0; offset < currentInode.size; offset += sizeof(DirectoryEntry))
    {
        flag = currentInode.read(offset, &entry, sizeof(entry));
        if (!flag)
        {
            // 读取文件内容失败
            return false;
        }

        //目录是按照顺序紧密排列的，不会出现分散的情况
        if (entry.inode == -1)
            return false;

        // 目录项匹配的条件：类型+文件名
        if (entry.type == type && strlib::strcmp(entry.getName(), name) == 0)
        {
            break;
        }
    }

    // 无相关文件
    if(offset == currentInode.size) return false;

    Inode entryInode = getInode(entry.inode);

    // 递归删除
    if (entry.type == DIRECTORY_FILE)
    {
        for (int i = 0; i < entryInode.size; i += sizeof(DirectoryEntry))
        {
            entryInode.read(i, &innerEntry, sizeof(DirectoryEntry));
            deleteEntryInDirectory(entry, innerEntry.name, innerEntry.type);
        }
    }

    // 释放分配的数据块
    while (entryInode.blockAmount)
    {
        block = entryInode.blockPopBack() - sb.dataFieldStartSector;
        blockBitmap.release(block);
    }

    // 删除目录
    if (currentInode.size > sizeof(DirectoryEntry))
    {
        dword lastByte = currentInode.size - sizeof(DirectoryEntry);
        DirectoryEntry temp;
        // 用最后一个目录项来填补当前的目录项，以实现目录项的紧密排列
        currentInode.read(lastByte, &temp, sizeof(DirectoryEntry));
        currentInode.write(offset, &temp, sizeof(DirectoryEntry));
    }

    // 从当前目录中删去指定的目录项
    currentInode.size -= sizeof(DirectoryEntry);
    dword blockAmount = stdmath::roundup(currentInode.size, SECTOR_SIZE);
    while (blockAmount < currentInode.blockAmount)
    {
        block = currentInode.blockPopBack() - sb.dataFieldStartSector;
        blockBitmap.release(block);
    }

    // 从inode table中删去该目录
    Disk::writeBytes(sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * currentInode.id, &currentInode, sizeof(Inode));
    return true;
}

dword FileSystem::createEntryInDirectory(const DirectoryEntry &current, const char *name, dword type)
{
    if (current.type != DIRECTORY_FILE)
        return false;

    DirectoryEntry entry;
    dword startByte;

    // 判断是否存在一个目录项
    entry = getEntryInDirectory(current, name, type);
    if (entry.inode != -1)
        return false;

    entry.inode = inodeBitmap.allocate();
    if (entry.inode == -1)
        return false;

    entry.type = type;
    strlib::strcpy(name, entry.name, 0, strlib::len(name));

    Inode inode;

    // 初始化entry在inode table对应的inode
    inode.size = 0;
    inode.blockAmount = 0;
    inode.id = entry.inode;
    startByte = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * inode.id;
    Disk::writeBytes(startByte, &inode, sizeof(Inode));

    // 更新当前目录
    inode = getInode(current.inode);

    // 超出inode现有的数据块大小

    if (inode.size + sizeof(DirectoryEntry) > inode.blockAmount * SECTOR_SIZE)
    {
        dword block = allocateDataBlock();
        if (block == -1)
        {
            return false;
        }
        inode.blockPushBack(block);
    }

    // 写入目录项
    inode.write(inode.size, &entry, sizeof(DirectoryEntry));

    // 更新inode
    inode.size += sizeof(DirectoryEntry);
    startByte = sb.inodeTableStartSector * SECTOR_SIZE + sizeof(Inode) * current.inode;
    Disk::writeBytes(startByte, &inode, sizeof(Inode));

    return true;
}

dword FileSystem::allocateDataBlock()
{
    // BlockBitMap::allocate分配的是偏移地址
    dword sector = blockBitmap.allocate();
    if (sector == -1)
        return -1;

    byte *buffer = (byte *)kernelMalloc(SECTOR_SIZE);
    if (!buffer)
    {
        PANIC::halt(PANIC_MEMORY_EXHAUSTED, "FileSystem::allocateDataBlock", "kernelMalloc");
    }
    for (int i = 0; i < SECTOR_SIZE; ++i)
    {
        buffer[i] = 0xff;
    }
    Disk::write(sector + sb.dataFieldStartSector, buffer);
   // printf("allocate datablock: %d\n", sector);
    return sector + sb.dataFieldStartSector;
}

Inode FileSystem::getRootInode()
{
    Inode root;
    Disk::readBytes(sb.inodeTableStartSector * SECTOR_SIZE, &root, sizeof(root));
    return root;
}

void printFileSystem(dword level, const DirectoryEntry &dir)
{
    for (int i = 0; i < level; ++i)
    {
        printf("  ");
    }

    printf("|-%s\n", dir.name);

    if (dir.type != DIRECTORY_FILE ||
        strlib::strcmp(dir.name, ".") == 0 ||
        strlib::strcmp(dir.name, "..") == 0) 
        return;

    Inode inode = sysFileSystem.getInode(dir.inode);

    DirectoryEntry entry;

    dword size = 0;
    while (size < inode.size)
    {
        inode.read(size, &entry, sizeof(DirectoryEntry));
        printFileSystem(level + 1, entry);
        size += sizeof(DirectoryEntry);
    }
}
