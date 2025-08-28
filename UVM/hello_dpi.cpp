// sha3_dpi.c
#include <stdio.h>
#include <string.h>

extern "C" {
    void hello_dpi(int n);
}

void hello_dpi(int n) {
    n +=3;
    printf("[DPI-C] Hello, %d\n", n);
}