#ifndef SYNC_H
#define SYNC_H

#include "threadlist.h"
#include "../kernel/type.h"

class Semaphore
{
public:
    byte counter;
    ThreadList waiters;

public:
    Semaphore();
    void initialize(byte counter);
    void P();
    void V();
};

#endif