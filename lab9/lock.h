#ifndef LOCK_H
#define LOCK_H

class Lock
{
private:
    bool lock;

public:
    Lock();
    void initialize();
    void request();
    void release();
};

#endif