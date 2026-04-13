#include <stdio.h>
#include <string.h>

int main() {
    char buffer[16];
    char input[100];

    printf("Enter input: ");
    fgets(input, sizeof(input), stdin);

    strcpy(buffer, input);   // unsafe copy (intentional)

    printf("You entered: %s\n", buffer);

    return 0;
}

/*
1. What happens with long input?
If input exceeds 16 characters, it overflows the buffer and overwrites memory.

2. Why is this dangerous?
It can crash the program or allow attackers to execute malicious code.

3. How to fix it?
Use strncpy() or limit input size properly.
*/