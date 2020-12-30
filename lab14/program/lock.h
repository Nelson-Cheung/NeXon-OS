#ifndef LOCK_H
#define LOCK_H

#include "../interrupt.h"

class Lock{
private:
    bool lock;
public:
    Lock() {
        initialize();
    }

    void initialize() {
        lock = false;
    }

    void acquire() {
        bool flag = true;

        while(flag) {
            bool status = _interrupt_status();
            _disable_interrupt();
            if(!lock) {
                flag = false;
                lock = true;
            }
            _set_interrupt(status);
        }
    }

    void release() {
        bool status = _interrupt_status();
        _disable_interrupt();

        if(lock) {
            lock = false;
        }

        _set_interrupt(status);        
    }
};
#endif