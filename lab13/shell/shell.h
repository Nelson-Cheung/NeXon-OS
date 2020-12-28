#ifndef SHELL_H
#define SHELL_H

#define SHELL_BUFFER_SIZE 64

#include "../type.h"
#include "../devices/keyboard.h"

class Shell
{
private:
    byte buffer[SHELL_BUFFER_SIZE];
    dword head, end;

public:
    Shell();
    void initialize();
    void run();
private:
    void clear();
    void printGraphSymbol();
};

#endif