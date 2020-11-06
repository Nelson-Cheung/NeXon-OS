#include "addresspool.h"

AddressPool::AddressPool()
{
    semaphore.initialize(1);
}

void AddressPool::setResources(byte *start, const dword length)
{
    resources.setBitMap(start, length);
}
void AddressPool::setStartAddress(const dword startAddress)
{
    this->startAddress = startAddress;
}
dword AddressPool::allocate(const dword count)
{
    dword start = resources.allocate(count);
    return (start == -1) ? -1 : (start * PAGE_SIZE + startAddress);
}