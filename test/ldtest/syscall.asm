BITS 16
global syscall_putchar
global syscall_getch
syscall_putchar:
    mov ah,0
    int 21h
    ret
syscall_getch:
    mov ah,1
    int 21h
    ret