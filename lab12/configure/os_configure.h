#ifndef OS_CONFIGURE_H
#define OS_CONFIGURE_H

/******************************************************************/
// 硬盘所占字节数
#define HARD_DISK_SIZE 10321920
// 扇区字节数
#define SECTOR_SIZE 512
// 硬盘所占扇区数
#define HADR_DISK_SECTOR_AMOUNT (HARD_DISK_SIZE / SECTOR_SIZE)
// 分区数
#define PARTITIONS_AMOUNT 2
// 第1个分区起始扇区
#define PARTITION_0_START 0
// 第2个分区起始扇区
#define PARTITION_1_START 101
/******************************************************************/

/******************************************************************/
// 每个进程打开的最大文件数
#define MAX_FILE_OPEN_PER_PROCESS 8
// 块的字节数
#define BLOCK_SIZE SECTOR_SIZE
// 块的总位数
#define BITS_PER_SECTOR (8 * BLOCK_SIZE)
// 最大文件数量
#define MAX_FILES BITS_PER_SECTOR
/******************************************************************/
#endif