    .section .note.GNU-stack,""
    .global _start
    .text

do_something: # Hershey Batore | 301454123
    push %rbx
    mov $1, %rcx
    mov $0, %rbx
    
loop_top:
    add %rcx, %rbx
    add $2, %rcx    
    cmp %rdi, %rbx
    jl loop_top
        
    mov %rbx, %rax
    pop %rbx
    ret

_start:
    mov $4, %rdi
    call do_something
        
    # exit
    mov $0, %rdi
    call syscall_exit
