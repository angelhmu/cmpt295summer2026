    .section .note.GNU-stack,""
    .global randint
    .global fill_array
    .global dot
    .global dot_struct

    .data
seed:
    .quad 1

.text
randint:
    # load seed
    mov seed(%rip), %rax
    # load multiplier
    movabs $6364136223846793005, %r8
    # seed *= multiplier
    imul %r8, %rax
    # seed += 1
    add $1, %rax
    #save seed
    mov %rax, seed(%rip)
    # seed >> 33
    shr $33, %rax
    # return seed
    ret
fill_array:
fill_loop:
    # check if n == 0
    test %rdi, %rdi
    jle fill_done
    # generate random number
    call randint
    and $0xff, %rax
    sub $128, %rax
    # add number to array
    mov %rax, (%rdi)
    add $4, %rdi
    dec %rsi
    jmp fill_loop
fill_done:
    ret
dot:
    ret
dot_struct:
    ret