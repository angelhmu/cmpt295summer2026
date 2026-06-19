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

    mov %rdx, %rax
    imul %rdi, %rsi
    add %rsi, %rax

    imul %rdi, %rsi
    add %rsi, %rax

    
    ret
###
polynomial3:
    ret
###
is_odd1:
    ret
###
is_odd2:
    ret
###
mul1:
    ret
###
mul2:
    ret
###
mul3:
    ret
