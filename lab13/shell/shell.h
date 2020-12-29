#ifndef SHELL_H
#define SHELL_H

#define SHELL_BUFFER_SIZE 64
#define SHELL_COMMAND_SIZE 8

#include "../type.h"
#include "../devices/keyboard.h"
#include "../ext2/fs.h"

#define SHELL_LS "ls"
#define SHELL_TREE "tree"
#define SHELL_CD "cd"
#define SHELL_MKDIR "mkdir"
#define SHELL_NELSON "nelson"
#define SHELL_EXEC "exec"
#define SHELL_RM "rm"
#define SHELL_CAT "cat"
#define SHELL_ECHO "echo"
#define SHELL_TOUCH "touch"

class Shell
{
private:
    byte buffer[SHELL_BUFFER_SIZE];
    byte cmd[SHELL_COMMAND_SIZE + 1];
    dword head, end;

public:
    Shell();
    void initialize();
    void run();

private:
    void clear();
    void printGraphSymbol();
    void printDirectoy(dword level, const DirectoryEntry &dir);
    // 从buffer中提取用户输入的命令
    void extractCommand();
    // 等待用户输入命令
    void inputAndShow();
};

#endif