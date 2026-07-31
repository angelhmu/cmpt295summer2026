#include <stdint.h>
#include <stdlib.h>
#include "vectorclass.h"
#include "lab11.h"

double dot_double_vc(double* arr1, double* arr2, uint64_t n) {
    Vec2d total = 0.0;
    for (uint64_t i = 0; i + 1 < n; i+=2) {
        Vec2d a = Vec2d().load(arr1 + i);
        Vec2d b = Vec2d().load(arr2 + i);
        total += a * b;
    }
    double result = horizontal_add(total);
    return result;
}

float dot_single_vc(float* arr1, float* arr2, uint64_t n) {
    Vec4f total = 0.0;
    for (uint64_t i = 0; i + 3 < n; i+=4) {
        Vec4f a = Vec4f().load(arr1 + i);
        Vec4f b = Vec4f().load(arr2 + i);
        total += a * b;
    }
    float result = horizontal_add(total);
    return result;
}

void map_poly_double_vc(double* input, double* output, uint64_t length, double a, double b, double c, double d) {
    Vec2d va = a, vb = b, vc = c, vd = d;
    for (uint64_t i = 0; i + 1 < length; i+=2) {
        Vec2d x = Vec2d().load(input + i);
        Vec2d result = ((va*x + vb)*x + vc)*x + vd;
        result.store(output + i);
    }
}
void map_poly_single_vc(float* input, float* output, uint64_t length, float a, float b, float c, float d) {
    Vec4f va = a, vb = b, vc = c, vd = d;
    for (uint64_t i = 0; i + 3 < length; i+=4) {
        Vec4f x = Vec4f().load(input + i);
        Vec4f result = ((va*x + vb)*x + vc)*x + vd;
        result.store(output + i);
    }
}