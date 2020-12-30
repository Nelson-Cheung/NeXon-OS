#ifndef MY_API_H
#define MY_API_H

#define dword unsigned int

namespace NeXon
{
    void *malloc(dword size);
    void free(void *address);
} // namespace NeXon

#endif