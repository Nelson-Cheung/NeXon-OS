#include <unistd.h>
#include <iostream>
using namespace std;

int main () {
    int pid = fork();
    if( pid ) {
        cout << "I am father " << getpid() << " " << pid << endl;
    } else {
        cout << "I am children " << getpid() << " " << pid  << endl;
    }
}