    .section .note.GNU-stack,""
    .global hailstone_length_c
    .global hailstone_length
    .global hailstone_length_cmov
    .text

haistone_length_c:
    ret

hailstone_length:
    mov $0, %rax
loop_h:
    mov %rdi, %r8
    cmp $1, %r8
    je done_h
    and $1, %r8
    jz is_even
    add $1, %rax
    imul $3, %rdi
    add $1, %rdi
    jmp loop_h
is_even:
    shr $1, %rdi
    add $1, %rax
    cmp $1, %rdi
    je done_h
    jmp loop_h
done_h:
    ret

hailstone_length_cmov:
    mov $0, %rax
loop:
    mov %rdi, %r8
