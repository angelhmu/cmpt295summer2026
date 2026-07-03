    .section .note.GNU-stack,""
    .global calculate
    .text

#   calculate should take 1 argument
#   has 4 local variables: 
#       a = x + 3
#       b = f(x, a)
#       c = f(b, x)
#       d = f(x, c)
#   returns the sum of all

calculate:
    # save
    push %rbx
    push %r12
    push %r13
    push %r14
    push %r15

    mov %rdi, %rbx  # rbx = x

    # a = x + 3
    mov %rbx, %r12
    add $3, %r12    # r12 = a

    # b = f(x, a)
    mov %rbx, %rdi
    mov %r12, %rsi
    call f
    mov %rax, %r13  # r13 = b

    # c = f(b, x)
    mov %r13, %rdi
    mov %rbx, %rsi
    call f
    mov %rax, %r14  # r14 = c

    # d = f(x, c)
    mov %rbx, %rdi
    mov %r14, %rsi
    call f
    mov %rax, %r15  # r15 = d

    # return d + c + b + a
    mov %r15, %rax
    add %r13, %rax
    add %r14, %rax
    add %r12, %rax

    # restore
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %rbx

    ret