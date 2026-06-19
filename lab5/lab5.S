    .section .note.GNU-stack,""
    .global fibonacci
    .global polynomial1
    .global polynomial2
    .global is_odd1
    .global is_odd2
    .global mul1
    .global mul2
    .text

###
fibonacci:
    # if n <= 1: return n
    cmp $1, %rdi
    jbe a

    # else: reutrn fibonacci(n-1) + fibonacci(n-2)
    dec %rdi
    push %rdi
    call fibonacci

    pop %rdi
    dec %rdi
    push %rax
    call fibonacci

    pop %r8
    add %r8, %rax
    ret
a:
    mov %rdi, %rax
    ret
    
###
polynomial1:
    #   %rdi,   %rsi,   %rdx,   %rcx,   %r8
    #   x,      a,      b,      c,      d
    # (x, a, b, c, d)
    # a*x*x*x + b*x*x + c*x + d
    mov %rdi, %r9       # r9 = x
    mov %r8, %rax

    mov %rcx, %r10
    imul %r9, %r10
    add %r10, %rax

    mov %r9, %r11
    imul %r9, %r11      # r11 = x^2

    mov %rdx, %r10
    imul %r11, %r10
    add %r10, %rax  

    mov %r11, %r10
    imul %r9, %r10      # r10 = x^3   

    imul %rsi, %r10
    add %r10, %rax

    ret
###
polynomial2:
    #   %rdi,   %rsi,   %rdx,   %rcx,   %r8
    #   x,      a,      b,      c,      d
    # x*(x*(a*x + b) + c) + d
    mov %rdx, %rax
    imul %rdi, %rsi     # %rsi: a*x
    add %rsi, %rax      # %rax: a*x + b

    imul %rdi, %rax     # %rax: x*(a*x + b)
    add %rcx, %rax      # %rax: x*(a*x + b) + c

    imul %rdi, %rax     # %rax: x*(x*(a*x + b) + c)
    add %r8, %rax       # %rax: x*(x*(a*x + b) + c) + d
    ret
    
###
polynomial3:
    ret
###
is_odd1:
    mov %rdi, %rax
    mov $2, %r8
    mov $0, %rdx
    idiv %r8
    test %rdx, %rdx
    je even
    mov $1, %rax
    ret
even:
    mov $0, %rax
    ret

###
is_odd2:
    mov %rdi, %rax
    and $1, %rax
    ret
###
mul1:
    mov %rdi, %rax
    mov $65537, %r8
    mul %r8
    ret
###
mul2:
    mov %rdi, %rax
    mov %rdi, %rdx
    shl $16, %rax
    add %rdx, %rax
    ret
###
mul3:
    ret
