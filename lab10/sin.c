#define _POSIX_C_SOURCE 199309L
#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "lab10.h"

#define PI 3.14159265

void sin_stdlib(double* input, double* output, uint64_t length) {
    for (uint64_t i = 0; i < length; i++) {
        output[i] = sin ((double)((input[i]*PI) / 180));
    }
}

int main() {
    uint64_t length = 10000000;
    
    double* params = (double*)malloc(length * sizeof(double));
    double* results = (double*)malloc(length * sizeof(double));
    
    if (params == NULL || results == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Initialize the massive array with a repeating series of degree test cases
    for (uint64_t i = 0; i < length; i++) {
        if (i % 3 == 0) params[i] = 0.0;
        else if (i % 3 == 1) params[i] = 30.0;
        else params[i] = 45.0;
    }

    struct timespec start, end;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    sin_stdlib(params, results, length);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; \
    printf("%25s took %7.1f ms\n", "SIN_STDLIB", elapsed * 1000);

    // struct timespec start, end;
    // clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    // sin_x87(params, results, length);
    // clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    // double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; \
    // printf("%25s took %7.1f ms\n", "SIN_X87", elapsed * 1000);

    return 0;
}