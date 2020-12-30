#define DEBUG
#include "list.h"
#include <iostream>
using namespace std;
using namespace NeXon;

struct LessThan
{
    bool operator()(const int &a, const int &b)
    {
        return a < b;
    }
};

void printList(const List<int, LessThan> &list)
{
    const ListItem<int> *ptr = list.head.next;
    while (ptr)
    {
        cout << ptr->value << " ";
        ptr = ptr->next;
    }
    cout << endl;
}

int main()
{
    List<int, LessThan> list;
    
    int item;

    cout << list.empty() << " " << list.size() << endl;

    list.push_back(123);
    list.push_back(1234);
    list.push_back(12345);
    printList(list);

    list.push_front(123456);
    list.push_front(1234567);
    list.push_front(12345678);
    printList(list);

    cout << list.front(item) << item  << endl;
    cout << list.back(item) << item  << endl;

    list.insert(2, 321);
    list.insert(4, 4321);

    printList(list);

    cout << list.at(2, item) << item << endl; 
    cout << list.at(4, item) << item << endl;

    int pos = list.find(4321);
    if(pos != -1) list.assgin(-1, 1122);
    printList(list);

    list.erase(4);
    list.erase(2);
    printList(list);

    cout << list.find(4321) << endl;
}