    .section .note.GNU-stack,""
    .global hailstone_length
    .global hailstone_length_cmov
    .text

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
    xor %rax, %rax
loop:
    cmp $1, %rdi
    je done

    # odd case
    mov %rdi, %r8
    imul $3, %r8
    add $1, %r8
    # even case
    mov %rdi, %r9
    shr $1, %r9
    test $1, %rdi
    mov %r8, %rdi
    cmovz %r9, %rdi

    inc %rax
    jmp loop
done:
    ret
