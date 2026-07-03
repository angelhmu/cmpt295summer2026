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
    ret
dot:
    ret
dot_struct:
    ret