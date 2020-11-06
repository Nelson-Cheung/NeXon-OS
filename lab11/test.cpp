#include "string.h"
#include <iostream>
using namespace std;

int main()
{
    cout << strlib::strcmp("I am Nelson", "I am Nelson") << endl
         << strlib::strcmp("I am nelson", "I am nelson cheung") << endl
         << strlib::strcmp("I am nelson cheugn", "I am nelson") << endl
         << strlib::strcmp("I am Nelson", "I am nelson") << endl
         << strlib::strcmp("I am nelson", "I am Nelson") << endl;


    char a[128];

    strlib::strcpy("I am nelson", a, 0, strlib::len("I am nelson"));
    cout << a << endl;
    strlib::strcpy("I am nelson", a, 2, 4);
    cout << a << endl;
}