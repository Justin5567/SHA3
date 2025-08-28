#include <iostream>
#include "sha3.h"

// Declare the DPI function prototype
extern "C" void compute_sha3_dpi(const char* input, int len, char* out_hex_str);

int main() {
    const char* input = "Justin";
    int len = strlen(input);
    char out_hex_str[65]; // 64 hex chars + null terminator

    compute_sha3_dpi(input, len, out_hex_str);

    std::cout << "SHA3-256(\"" << input << "\") = " << out_hex_str << std::endl;
    return 0;
}