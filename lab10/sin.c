#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#define PI 3.14159265

void sin_stdlib(double* input, double* output, uint64_t length) {
    for (uint64_t i = 0; i < length; i++) {
        output[i] = sin ((double)((input[i]*PI) / 180));
    }
}

int main() {
    double params[] = {0.0, 30.0, 45.0};
    double results[3];
    uint64_t length = 3;

    sin_stdlib(params, results, length);

    for(uint64_t i = 0; i < length; i++) {
        printf("degree %.4f, result %.4f\n", params[i], results[i]);
    }
    
    return 0;
}