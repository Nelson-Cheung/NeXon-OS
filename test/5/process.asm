BITS 16
extern save
global gobackKernel

gobackKernel:
    call save
    add sp, 10 ;ip(before int), cs,flags(pushf),afterRun,cs
    mov bp, sp
    pop sp
    jmp far [bp-4]
