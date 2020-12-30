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
#define SHELL_NELSON "nexon"
#define SHELL_EXEC "exec"
#define SHELL_RM "rm"
#define SHELL_CAT "cat"
#define SHELL_ECHO "echo"
#define SHELL_TOUCH "touch"
#define SHELL_PWD "pwd"

#define SHELL_RM_FILE "-f"
#define SHELL_RM_DIR "-d"
class Shell
{
private:
    byte buffer[SHELL_BUFFER_SIZE];
    byte cmd[SHELL_COMMAND_SIZE + 1];
    byte parameter[SHELL_BUFFER_SIZE + 1];
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
    // 打印当前目录
    void printCurrentDirectory();
    // 打印当前目录树
    void printCurrentDirectoryTree(dword level, const DirectoryEntry &dir);
    // 提取用户参数
    void extractNextParameter();
    // 获取path所在的目录
    DirectoryEntry getDirectoryOfFile(const char *path);
    // 从路径中解析出文件名
    void getFileNameInPath(const char *path, char *filename);
    // 创建文件
    void createFile(const char *path, dword type);
    // rm
    void rm(const char *path, dword type);
    // ls
    void ls();
    // cd
    void cd(const char *path);
};

#endif