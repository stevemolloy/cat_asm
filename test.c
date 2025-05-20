#include <sys/stat.h>
#include <stddef.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(void) {
    printf("%%define O_RDONLY %d\n", O_RDONLY);

    int fd = open("./cat.asm", O_RDONLY, 0);
    printf("fd = %d\n", fd);
    
    printf("st_size offset: %zu\n", offsetof(struct stat, st_size));
    printf("sizeof(struct stat) offset: %zu\n", sizeof(struct stat));

    return 0;
}
