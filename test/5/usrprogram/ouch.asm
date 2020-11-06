%include "utility.inc"

Ouch:
    sti
    pusha
    push ds
    mov ax,cs
    mov ds,ax
	PRINT msg, msg_len, 20, 40
    call Delay
	PRINT clearMsg, msg_len, 20, 40
    
    int 40h

    mov al,20h           ; AL = EOI
    out 20h,al           ; 发送EOI到主8529A
    out 0A0h,al          ; 发送EOI到从8529A

    pop ds
    popa
    cli
    iret
msg db 'OUCH! OUCH!'
msg_len equ $-msg
clearMsg db '           '

Delay:
    pusha
    mov ax,500
dd:
    mov cx,50000
ddd:
    loop ddd
    dec ax
    cmp ax,0
    jne dd
    popa
    ret
