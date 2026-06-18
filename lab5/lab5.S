    .section .note.GNU-stack,""
    .global fibonacci
    .global warmup
    .global polynomial1
    .global polynomial2
    .global polynomial3
    .global is_odd1
    .global is_odd2
    .global is_odd3
    .global mul1
    .global mul2
    .global mul3
    .text

fibonacci:
    # if n <= 1: return n
    cmp $1, %rdi
    jbe a

    # else: reutrn fibonacci(n-1) + fibonacci(n-2)
    dec %rdi
    push %rdi
    call fibonacci
    push %rax
    pop %rdi
    dec %rdi
    call fibonacci
    pop %r12
    add %r12, %rax
    ret
a:
    mov %rdi, %rax
    ret

warmup:
    ret
polynomial1:
    ret
polynomial2:
    ret
polynomial3:
    ret
is_odd1:
    ret
is_odd2:
    ret
is_odd3:
    ret
mul1:
    ret
mul2:
    ret
mul3:
    ret
