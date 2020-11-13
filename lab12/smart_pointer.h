#ifndef SMART_POINTER
#define SMART_POINTER

#include "type.h"

class SmartPointer
{
private:
    void *pointer;
    dword size;
    bool borrow;

public:
    SmartPointer();
    SmartPointer(const SmartPointer &other);
    SmartPointer &operator=(const SmartPointer &other);

    SmartPointer(void *pointer);

    ~SmartPointer();
private:
    void release();
};
#endif