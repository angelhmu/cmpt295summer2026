    .section .note.GNU-stack,""
    .global dot_double, dot_single, map_poly_double, map_poly_single
    .global dot_double_vec, dot_single_vec, map_poly_double_vec, map_poly_single_vec
    .text

####
dot_double_vec:
    vxorpd %ymm0, %ymm0, %ymm0
    xor %rcx, %rcx
ddv_loop:
    cmp %rdx, %rcx
    jge ddv_done
    vmovupd (%rdi, %rcx, 8), %ymm1
    vmovupd (%rsi, %rcx, 8), %ymm2
    vmulpd %ymm2, %ymm1, %ymm1
    vaddpd %ymm1, %ymm0, %ymm0
    inc %rcx
    jmp ddv_loop
ddv_done:
    ret

dot_single_vec:
    vxorps %ymm0, %ymm0, %ymm0
    xor %rcx, %rcx
dsv_loop:
    cmp %rdx, %rcx
    jge dsv_done
    vmovups (%rdi, %rcx, 4), %ymm1    
    vmovups (%rsi, %rcx, 4), %ymm2
    vmulps %ymm2, %ymm1, %ymm1
    vaddps %ymm1, %ymm0, %ymm0
    inc %rcx
    jmp dsv_loop
dsv_done:
    ret

map_poly_double_vec:
    xor %rcx, %rcx
mdv_loop:
    cmp %rdx, %rcx
    jge mdv_done

    vmovupd (%rdi, %rcx, 8), %ymm4    # x
    vmovupd %ymm4, %ymm6              # temp

    vmulpd %ymm0, %ymm6, %ymm6  # 1. x * a
    vaddpd %ymm1, %ymm6, %ymm6  # 2. b + [1]
    vmulpd %ymm4, %ymm6, %ymm6  # 3. x * [2]
    vaddpd %ymm2, %ymm6, %ymm6  # 4. c + [3]
    vmulpd %ymm4, %ymm6, %ymm6  # 5. x * [4]
    vaddpd %ymm3, %ymm6, %ymm6  # 6. d + [5]
    
    vmovupd %ymm6, (%rsi, %rcx, 8)

    inc %rcx
    jmp mdv_loop
mdv_done:
    ret

map_poly_single_vec:
    xor %rcx, %rcx
msv_loop:
    cmp %rdx, %rcx
    jge msv_done

    vmovups (%rdi, %rcx, 4), %ymm4    # x
    vmovups %ymm4, %ymm6              # temp

    vmulps %ymm0, %ymm6, %ymm6  # 1. x * a
    vaddps %ymm1, %ymm6, %ymm6  # 2. b + [1]
    vmulps %ymm4, %ymm6, %ymm6  # 3. x * [2]
    vaddps %ymm2, %ymm6, %ymm6  # 4. c + [3]
    vmulps %ymm4, %ymm6, %ymm6  # 5. x * [4]
    vaddps %ymm3, %ymm6, %ymm6  # 6. d + [5]
    
    vmovups %ymm6, (%rsi, %rcx, 4)

    inc %rcx
    jmp msv_loop
msv_done:
    ret

####
dot_double:
    pxor %xmm0, %xmm0
    xor %rcx, %rcx
dd_loop:
    cmp %rdx, %rcx
    jge dd_done
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
    cmp %rdx, %rcx
    jge ds_done
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
    cmp %rdx, %rcx
    jge md_done

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
    cmp %rdx, %rcx
    jge ms_done

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