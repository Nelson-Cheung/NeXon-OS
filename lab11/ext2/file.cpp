#include "file.h"
#include "../thread.h"

File::File()
{
    handle = -1;
}

File::~File()
{
    // 关闭文件
    close();
}

// 打开文件
void File::open(const char *filename, dword mode)
{
    this->mode = mode;
    position = 0;

    int descPos = 3;
    PCB *pcb = (PCB *)_running_thread();

    for (; descPos < MAX_FILE_OPEN_PER_PROCESS; ++descPos)
    {
        if (pcb->fileDescriptors[descPos] == -1)
            break;
    }

    if (descPos == MAX_FILE_OPEN_PER_PROCESS)
        return;

    switch (mode)
    {
    case FILE_OPEN_READ:
    case FILE_OPEN_RW:
    case FILE_OPEN_APPEND:
        handle = openFile(filename);
        if (handle != -1 && mode == FILE_OPEN_APPEND)
        {
            position = getFileSize(handle);
        }
        break;

    case FILE_OPEN_TRUNCATE:
        handle = openFile(filename);
        if (handle == -1)
        {
            handle = createFile(filename);
        }
        else
        {
            clearFile(handle);
        }
        break;
    default:
        break;
    }

    pcb->fileDescriptors[descPos] = handle;
}

bool File::isOpen()
{
    return handle != -1;
}

void File::read(void *buf, dword size)
{
    if (!isOpen() || mode == FILE_OPEN_TRUNCATE || mode == FILE_OPEN_APPEND)
        return;

    dword ans = readFile(handle, position, buf, size);
    if (ans)
        position += size;
}

void File::write(void *buf, dword size)
{
    if (!isOpen() || mode == FILE_OPEN_READ)
        return;

    dword ans = writeFile(handle, position, buf, size);
    if (ans)
        position += size;
}

dword File::seek()
{
    return position;
}

void File::reset(dword position)
{
    this->position = position;
}

void File::close()
{
    closeFile(handle);
    PCB *pcb = (PCB *)_running_thread();
    for (int i = 3; i < MAX_FILE_OPEN_PER_PROCESS; ++i)
    {
        if (pcb->fileDescriptors[i] == handle)
        {
            pcb->fileDescriptors[i] = -1;
            break;
        }
    }
    handle = -1;
}