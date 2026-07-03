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
    test %rsi, %rsi
    jle fill_done
    # generate random number
    call randint
    and $0xff, %rax
    sub $128, %rax
    # add number to array
    mov %rax, (%rdi)
    # go to next array element
    add $8, %rdi            # must be 8 because using 64-bit registers
    # n--
    dec %rsi
    jmp fill_loop
fill_done:
    ret
dot:
dot_loop:
    # check if length == 0
    test %rdx, %rdx
    jle dot_done
    # load first element of each array
    mov (%rdi), %r8
    mov (%rsi), %r9
    # mulitply the elements together
    imul %r9, %r8
    # add to the result
    add %r8, %rax
    # move to next element of each array
    add $8, %rdi
    add $8, %rsi
    # length--
    dec %rdx
    # jump to top of loop
    jmp dot_loop
dot_done:
    ret
dot_struct:
    ret