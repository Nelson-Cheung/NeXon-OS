#include "lock.h"

Lock::Lock()
{
    initialize();
}

void Lock::initialize()
{
    lock = false;
}

void Lock::request()
{
    while (lock)
        ;
    lock = true;
}

void Lock::release()
{
    lock = false;
}