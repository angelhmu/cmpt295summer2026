    .section .note.GNU-stack,""
    .global random
    .text
    
random:
    mov $7, %eax
    add $5, %eax
    sub $3, %eax
    ret
