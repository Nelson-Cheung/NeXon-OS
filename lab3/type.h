#ifndef TYPE_H
#define TYPE_H

#define dword unsigned int
#define word unsigned short
#define byte unsigned char

#define ROOT_ENTRY 80
#define BYTES_PER_SECTOR 512
#define FILE_ENTRY_SIZE 32

typedef struct FileEntry
{
    byte name[11];
    byte size[4];
    byte cluster[2];
    byte reserve[15];
} FileEntry;
// 转换由CreateFileEntry提供，修改FileEntry时必须修改CreateFileEntry
void CreateFileEntry(byte *raw, FileEntry *entry)
{
    dword index = 0;

    while (index < 32)
    {
        if (index < 11)
        {
            (entry->name)[index - 0] = raw[index];
        }
        else if (index < 15)
        {
            (entry->size)[index - 11] = raw[index];
        }
        else if (index < 17)
        {
            (entry->cluster)[index - 15] = raw[index];
        }
        else if (index < 32)
        {
            (entry->reserve)[index - 17] = raw[index];
        }
        ++index;
    }
}
#endif