    .section .note.GNU-stack,""
    .global dot_double, dot_single, map_poly_double, map_poly_single, sin_x87
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
    pxor %xmm0, %xmm0
    xor %rcx, %rcx
ds_loop:
    cmp %rcx, %rdx
    jle ds_done
    movss (%rdi, %rcx, 4), %xmm1    
    movss (%rsi, %rcx, 4), %xmm2
    mulss %xmm2, %xmm1
    addss %xmm1, %xmm0
    inc %rcx
    jmp ds_loop
ds_done:
    ret

map_poly_double:
    xor %rcx, %rcx
md_loop:
    cmp %rcx, %rdx
    jle md_done

    movsd (%rdi, %rcx, 8), %xmm4    # x
    movsd %xmm4, %xmm6              # temp

    mulsd %xmm0, %xmm6  # 1. x * a
    addsd %xmm1, %xmm6  # 2. b + [1]
    mulsd %xmm4, %xmm6  # 3. x * [2]
    addsd %xmm2, %xmm6  # 4. c + [3]
    mulsd %xmm4, %xmm6  # 5. x * [4]
    addsd %xmm3, %xmm6  # 6. d + [5]
    
    movsd %xmm6, (%rsi, %rcx, 8)

    inc %rcx
    jmp md_loop
md_done:
    ret

map_poly_single:
    xor %rcx, %rcx
ms_loop:
    cmp %rcx, %rdx
    jle ms_done

    movss (%rdi, %rcx, 4), %xmm4    # x
    movss %xmm4, %xmm6              # temp

    mulss %xmm0, %xmm6  # 1. x * a
    addss %xmm1, %xmm6  # 2. b + [1]
    mulss %xmm4, %xmm6  # 3. x * [2]
    addss %xmm2, %xmm6  # 4. c + [3]
    mulss %xmm4, %xmm6  # 5. x * [4]
    addss %xmm3, %xmm6  # 6. d + [5]
    
    movss %xmm6, (%rsi, %rcx, 4)

    inc %rcx
    jmp ms_loop
ms_done:
    ret

sin_x87:
    mov $0, %rcx
s87_loop:
    cmp %rdx, %rcx
    jae s87_ret
    fldl (%rdi, %rcx, 8)
    fsin
    fstpl (%rsi, %rcx, 8)
    inc %rcx
    jmp s87_loop
s87_ret:
    ret