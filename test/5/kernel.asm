%include "header.inc"
BITS 16
extern Greet
extern shell
extern syscaller
extern sys_int22
extern TimerWithDate
extern gobackKernel

global _start
_start:
    MOVE_VECTOR 08h,39H
    VECTOR_IN 08h,TimerWithDate
    VECTOR_IN 20h,gobackKernel
    VECTOR_IN 21h,syscaller
    VECTOR_IN 22h,sys_int22
    call dword Greet
    int 22h
WaitForKey:
    mov ah, 0
    int 16h
    cmp al, 0dh   
    jne WaitForKey
    call dword shell
    jmp WaitForKey