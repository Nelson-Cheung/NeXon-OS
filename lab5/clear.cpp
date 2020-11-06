#include <iostream>
#include <fstream>
#include <cstring>
#include <algorithm>
using namespace std;

int main(int argc, char *argv[])
{
    if (argc < 2)
        return 0;

    ifstream fin;
    ofstream fout;
    long long size;
    char buffer[1024];

    fin.open(argv[1], ios::binary | ios::in);
    if (!fin.is_open())
    {
        cout << "Can not open file!" << endl;
        return 0;
    }
    fin.seekg(0, ios::end);
    size = fin.tellg();
    fin.close();

    fout.open(argv[1], ios::binary | ios::trunc);
    if (!fout.is_open())
    {
        cout << "Can not open file!" << endl;
        return 0;
    }
    while (size)
    {
        memset(buffer, 0, 1024);
        fout.write(buffer, min((long long)1024, size));
        size -= min((long long)1024, size);
    }
    fout.close();
}
