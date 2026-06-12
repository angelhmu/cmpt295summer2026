    .section .note.GNU-stack,""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text
###
is_prime:
    # i = 2
    mov $2, %r8     # r8: i
                    # rdi: n
prime_loop:
    # while i < n
    cmp %rdi, %r8
    jge prime

    # if n % i == 0
    mov $0, %rdx
    mov %rdi, %rax
    div %r8
    test %rdx, %rdx
    je notprime
    add $1, %r8
    jmp prime_loop

notprime:   # rax = 0
    mov $0, %rax
    ret

prime:      # rax = 1
    mov $1, %rax
    ret

###
largest_power_unsigned:
    mov %rdi, %rax      # rax: p
                        # rdi: n
    mov $1, %r8         # r8: i
power_loop:
    mov %rax, %r9       # save p before multiplying
    mul %rdi            # rax * rdi ie. p * n
    jb power_done
    jmp power_loop

power_done:
    mov %r9, %rax
    ret

###
overflowing_subtract:
    sub %rsi, %rdi      # rdi = rdi - rsi ie. a = a - b
    jo overflow
    mov %rdi, %rax
    ret
    
overflow:
    mov $0, %rax
    ret

###
dumb:
    # if a == 0: return b + 1
    test %rdi, %rdi
    je b1

    # elif b == 0: return a
    test %rsi, %rsi
    je a

    #else: return a+a+b+dumb(a-1, b-1)
    push %rdi
    push %rsi
    dec %rdi
    dec %rsi
    call dumb
    pop %rsi
    pop %rdi
    add %rdi, %rax
    add %rdi, %rax
    add %rsi, %rax
    ret

b1:
    add $1, %rsi
    mov %rsi, %rax
    ret
a:
    mov %rdi, %rax
    ret
    