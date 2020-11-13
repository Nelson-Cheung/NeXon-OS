#include <stdio.h>
#include <unistd.h>

int main() {
    int pid = 1;
    pid = fork();
    if(pid) {
        printf("father\n");
    } else {
        printf("children\n");
    }
}