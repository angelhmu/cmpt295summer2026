    .section .note.GNU-stack,""
    .global abs_value
    .global power2
    .global hailstone_length
    .text

abs_value:
    mov %rdi, %rax
    cmp $0, %rax
    jl is_negative
    ret
is_negative:
    neg %rax
    ret

power2:
    mov %rdi, %r12      #%r12: n
    mov $0, %r14        #r14: i
    mov $1, %r13        #%r13: result = 1
loop_p:
    cmp %r14, %r12
    jl done
    mov %r13, %rdi
    call print_uint64

    add %r13, %r13
    add $1, %r14
    jmp loop_p

done:
    ret 

hailstone_length:
loop_h:
    and $1, %rdi
    jnz is_even
    imul $3, %rdi
    add $1, %rdi
    jmp loop_h

is_even:
    shr $1, %rdi
    cmp $1, %rdi
    je done
    jmp loop_h
