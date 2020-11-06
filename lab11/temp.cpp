#include <iostream>
using namespace std;

#define dword unsigned int

enum ArenaType
{
    ARENA_16,
    ARENA_32,
    ARENA_64,
    ARENA_128,
    ARENA_256,
    ARENA_512,
    ARENA_MORE
};

class Arena
{
private:
    ArenaType type;     // Arena的类型
    dword startAddress; // Arena开始地址
    dword counter;      // 如果是ARENA_MORE则counter表明页框数，否则counter表明内存块的数量
public:
    static Arena *blockToArena(void *address); // 从Arena中的一个块地址得到Arena的地址
    Arena(dword startAddress, ArenaType type, dword counter = 0);
    void *getBlockAddress(dword index);        // 获取Arena中第index个块的地址
    dword getCounter(); // 剩余空闲块数量
};

int main() {
    cout << sizeof(Arena) << endl;
}