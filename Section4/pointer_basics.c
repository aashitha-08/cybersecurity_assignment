#include <stdio.h>

int main() {
    int port = 80;
    int *ptr;

    ptr = &port;

    printf("Port value using variable: %d\n", port);
    printf("Port value using pointer: %d\n", *ptr);

    *ptr = 443;

    printf("New port value: %d\n", port);

    return 0;
}