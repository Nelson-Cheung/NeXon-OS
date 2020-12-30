#ifndef INODE_H
#define INODE_H

#include "../type.h"
#include "../disk/disk.h"
#include "../configure/os_configure.h"
#include "../panic.h"

#define INODE_BLOCK_DIRECT 8                            // 直接数据块数目，此后，一级，二级等多级根区块均为1个
#define INODE_BLOCK_FIRST (SECTOR_SIZE / sizeof(dword)) // 一级数据块的数目
#define FILE_INDEX_BLOCKS 9

// inode的作用是描述文件的属性，如文件大小，文件标志和文件的数据块索引
struct Inode
{
    dword size;                      // 文件大小
    dword blockAmount;               // 文件数据块的数目
    dword blocks[FILE_INDEX_BLOCKS]; // 文件数据块，保存的是文件数据块对应的逻辑扇区号，0~7是直接数据块，8是一级数据块
    dword id;                        // inode在inode table中的下标

    // 涉及指针的一定要有constructor，operator=
    Inode()
    {
        id = -1;
        size = 0;
        blockAmount = 0;
        for (int i = 0; i < FILE_INDEX_BLOCKS; ++i)
        {
            blocks[i] = -1;
        }
    }

    Inode(const Inode &inode)
    {
        size = inode.size;
        blockAmount = inode.blockAmount;
        id = inode.id;
        for (int i = 0; i < 9; ++i)
        {
            blocks[i] = inode.blocks[i];
        }
    }

    Inode &operator=(const Inode &inode)
    {
        size = inode.size;
        blockAmount = inode.blockAmount;
        id = inode.id;
        for (int i = 0; i < 9; ++i)
        {
            blocks[i] = inode.blocks[i];
        }
    }

    // 读取字节流，隐藏离散的扇区的信息
    bool read(dword startByte, void *buf, dword size)
    {
        byte *buffer = (byte *)buf;
        dword startBlock = startByte / SECTOR_SIZE;
        dword endBlock = (startByte + size - 1) / SECTOR_SIZE;
        dword first, len, totalBytes;

        byte *temp = (byte *)kernelMalloc(SECTOR_SIZE);
        if (!temp)
        {
            PANIC::halt(PANIC_MEMORY_EXHAUSTED, "Inode::read", "kernelMalloc");
        }

        // 处理头部区块
        readBlock(startBlock, temp);
        // 读取的数据的首字节在数据块中的偏移
        first = startByte - startBlock * SECTOR_SIZE;
        // 判断是否跨越一个扇区
        len = (SECTOR_SIZE - first) > size ? size : SECTOR_SIZE - first;
        totalBytes = 0;

        for (int i = 0; i < len; ++i)
        {
            buffer[i] = temp[i + first];
        }

        totalBytes += len;

        // 处理中间区块
        for (int block = startBlock + 1; block < endBlock; ++block)
        {
            readBlock(block, temp);
            for (int i = 0; i < SECTOR_SIZE; ++i)
            {
                buffer[i + totalBytes] = temp[i];
            }
            totalBytes += SECTOR_SIZE;
        }

        // 处理尾部区块
        len = size - totalBytes;
        if (len)
        {
            readBlock(endBlock, temp);
            for (int i = 0; i < len; ++i)
            {
                buffer[i + totalBytes] = temp[i];
            }
        }

        kernelFree(temp);
        return true;
    }

    // buf的大小一定是SECTOR_SIZE
    void readBlock(dword index, void *buf)
    {
        if (index < INODE_BLOCK_DIRECT)
        {
            // 处理直接数据块
            Disk::read(blocks[index], buf);
        }
        else if (index - INODE_BLOCK_DIRECT < INODE_BLOCK_FIRST)
        {
            // 处理一级数据块
            dword *temp = (dword *)kernelMalloc(SECTOR_SIZE);
            if (!temp)
            {
                PANIC::halt(PANIC_MEMORY_EXHAUSTED, "Inode::readBlock", "kernelMalloc");
            }
            
            Disk::read(blocks[INODE_BLOCK_DIRECT + 0], temp);
            dword offset = index - INODE_BLOCK_DIRECT;
            
            Disk::read(temp[offset], buf);
            kernelFree(temp);
        }
        else
        {
            // 更高级的数据块
            while (1)
            {
            }
        }

        return;
    }

    // 读取字节流，隐藏离散的扇区的信息
    void write(dword startByte, void *buf, dword size)
    {
        byte *temp = (byte *)kernelMalloc(SECTOR_SIZE);
        if (!temp)
        {
            PANIC::halt(PANIC_MEMORY_EXHAUSTED, "Inode::write");
        }

        byte *buffer = (byte *)buf;
        dword startBlock = startByte / SECTOR_SIZE;
        dword endBlock = (startByte + size - 1) / SECTOR_SIZE;
        dword first, len, totalBytes;

        // 处理头部区块

        readBlock(startBlock, temp);
        // 读取的数据的首字节在数据块中的偏移
        first = startByte - startBlock * SECTOR_SIZE;
        // 判断是否跨越一个扇区
        len = (SECTOR_SIZE - first) > size ? size : SECTOR_SIZE - first;
        totalBytes = 0;

        for (int i = 0; i < len; ++i)
        {
            temp[i + first] = buffer[i];
        }

        writeBlock(startBlock, temp);

        totalBytes += len;

        // 处理中间区块
        for (int block = startBlock + 1; block < endBlock; ++block)
        {
            for (int i = 0; i < SECTOR_SIZE; ++i)
            {
                temp[i] = buffer[i + totalBytes];
            }
            totalBytes += SECTOR_SIZE;
            writeBlock(block, temp);
        }

        // 处理尾部区块
        len = size - totalBytes;
        if (len)
        {
            readBlock(endBlock, temp);
            for (int i = 0; i < len; ++i)
            {
                temp[i] = buffer[i + totalBytes];
            }
            writeBlock(endBlock, temp);
        }

        kernelFree(temp);
    }

    // buf的大小一定是SECTOR_SIZE
    void writeBlock(dword index, void *buf)
    {
        //printf("%d write block %s\n", index, buf);
        if (index < INODE_BLOCK_DIRECT)
        {
            // 处理直接数据块
            Disk::write(blocks[index], buf);
        }
        else if (index < INODE_BLOCK_FIRST)
        {
            // 处理一级数据块
            dword *temp = (dword *)kernelMalloc(SECTOR_SIZE);
            if (!temp)
            {
                PANIC::halt(PANIC_MEMORY_EXHAUSTED, "Inode::write");
            }
            Disk::read(blocks[INODE_BLOCK_DIRECT + 0], temp);
            dword offset = index - INODE_BLOCK_DIRECT;
            //printf("%d %d %d\n", blocks[INODE_BLOCK_DIRECT + 0], offset, temp[offset]);
            Disk::write(temp[offset], buf);
            kernelFree(temp);
        }
        else
        {
            // 更高级的数据块
            return;
        }
    }

    void blockPushBack(dword block)
    {
        if (blockAmount < INODE_BLOCK_DIRECT)
        {
            blocks[blockAmount] = block;
        }
        else if (blockAmount - INODE_BLOCK_DIRECT < INODE_BLOCK_FIRST)
        {
            dword offset = blockAmount - INODE_BLOCK_DIRECT;
            dword *temp = (dword *)kernelMalloc(SECTOR_SIZE);
            if (!temp)
            {
                PANIC::halt(PANIC_MEMORY_EXHAUSTED);
            }
            Disk::read(blocks[INODE_BLOCK_DIRECT + 0], temp);
            temp[offset] = block;
            //printf("%d %d %d\n", blocks[INODE_BLOCK_DIRECT + 0], offset, temp[offset]);
            Disk::write(blocks[INODE_BLOCK_DIRECT + 0], temp);
            kernelFree(temp);
        }

        ++blockAmount;
    }

    dword blockPopBack()
    {
        if (!blockAmount)
            return -1;

        dword lastBlock;

        if (blockAmount < INODE_BLOCK_DIRECT)
        {
            lastBlock = blocks[blockAmount - 1];
        }
        else if (blockAmount - INODE_BLOCK_DIRECT < INODE_BLOCK_FIRST)
        {
            dword offset = blockAmount - INODE_BLOCK_DIRECT;
            dword *temp = (dword *)kernelMalloc(SECTOR_SIZE);
            if (!temp)
            {
                PANIC::halt(PANIC_MEMORY_EXHAUSTED, "FileSystem::blockPopBack");
            }
            Disk::read(blocks[INODE_BLOCK_DIRECT + 0], temp);
            lastBlock = temp[offset];
        }

        --blockAmount;
        return lastBlock;
    }
};
#endif