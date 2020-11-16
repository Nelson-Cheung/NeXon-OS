#include <iostream>
using namespace std;

class A {
public:
    void x() {
        void (*p)() = y;
        p();
    }

    void y() {
        cout << "y" << endl;
    }
};

int main() {

}