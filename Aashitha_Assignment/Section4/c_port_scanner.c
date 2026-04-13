#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

void scan_port(int port) {
    int sock;
    struct sockaddr_in target;

    sock = socket(AF_INET, SOCK_STREAM, 0);

    target.sin_family = AF_INET;
    target.sin_port = htons(port);
    target.sin_addr.s_addr = inet_addr("127.0.0.1");

    if (connect(sock, (struct sockaddr*)&target, sizeof(target)) == 0) {
        printf("Port %d: OPEN\n", port);
    } else {
        printf("Port %d: CLOSED\n", port);
    }

    close(sock);
}

int main() {
    int ports[] = {22, 80, 443, 3306};
    int i;

    for (i = 0; i < 4; i++) {
        scan_port(ports[i]);
    }

    return 0;
}