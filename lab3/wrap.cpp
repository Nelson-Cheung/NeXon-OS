#include <iostream>
#include <fstream>
#include <windows.h>
#include <io.h>
#include <sys\stat.h>
using namespace std;

int main(int argc, char *argv[]) {
    fstream fstrm;

    int size;
    HANDLE handle = CreateFile(argv[argc-1], FILE_READ_EA, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0);
    if (handle != INVALID_HANDLE_VALUE)
    {
        size = GetFileSize(handle, NULL);
        cout<<size<<endl;
        CloseHandle(handle);
    } else {
        cout << "can not open file!" << endl;
    }


    fstrm.open(argv[argc-1], ios::in|ios::out|ios::binary);
    if( !fstrm.is_open() ) {
        cout << "can not read file." << endl;
        return -1;
    }

    fstrm.seekp(ios::beg);
    int temp = size;
    char c;

    for ( int i = 0; i < 4; ++i ) {
        c = temp & 0xff;
        temp = temp >> 8;
        fstrm << c;
    }

    fstrm.close();
}