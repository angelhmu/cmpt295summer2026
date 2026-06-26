    .section .note.GNU-stack,""
    .global strlen_mine
    .global strlen_utf8
    .text

strlen_mine:
    #takes a pointer to byte array so use (%rdi)
    mov $0, %r8     #count
len_loop:
    #first check if the byte is null
    cmpb $0, (%rdi)
    je len_end
    inc %r8         #count++
    inc %rdi        #next byte
    jmp len_loop
len_end:
    mov %r8, %rax
    ret

strlen_utf8:
    mov $0, %r8     #count
utf_loop1:
    cmpb $0, (%rdi)
    je utf_end
    mov (%rdi), %r9
    and $0xC0, %r9
    cmp $0x80, %r9
    je utf_loop2    #if continuation byte, dont increment count
    inc %r8         #else incrememnt count
utf_loop2:
    inc %rdi
    jmp utf_loop1

utf_end:
    mov %r8, %rax
    ret
