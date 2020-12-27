#ifndef SHELL_H
#define SHELL_H

class Shell
{
private:
    byte keymap[47][2];
    
public:
    Shell();
    void initialize();
    void run();
};

#endif