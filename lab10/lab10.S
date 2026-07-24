    .section .note.GNU-stack,""
    .global dot_double, dot_single, map_poly_double, map_poly_single
    .text
dot_double:
    pxor %xmm0, %xmm0
    xor %rcx, %rcx
dd_loop:
    cmp %rcx, %rdx
    jle dd_done
    movsd (%rdi, %rcx, 8), %xmm1
    movsd (%rsi, %rcx, 8), %xmm2
    mulsd %xmm2, %xmm1
    addsd %xmm1, %xmm0
    inc %rcx
    jmp dd_loop
dd_done:
    ret

dot_single:
    ret

map_poly_double:
    ret

map_poly_single:
    ret