#include "my_api.h"
void *NeXon::malloc(dword size)
{
    return new char[size];
}

void NeXon::free(void *address)
{
    delete (char *)address;
}