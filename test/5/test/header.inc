OffsetOfKernel equ  08100h

%macro VECTOR_IN 2
    pusha            ; 保护现场
    push es
    mov ax, 0
    mov	es, ax       ; 数据段
    mov word[es:%1*4],%2
    mov ax, cs
    mov word[es:%1*4+2],ax
    pop es
    popa             ; 恢复现场
%endmacro


%macro MOVE_VECTOR 2
    pusha            ; 保护现场
    push es
    mov ax, 0
    mov	es, ax       ; 数据段
    mov ax, word[es:%1*4]
    mov word[es:%2*4],ax
    mov ax, word[es:%1*4+2]
    mov word[es:%2*4+2],ax
    pop es
    popa             ; 恢复现场
%endmacro

%macro PRINT 4
    pusha            ; 保护现场
    mov	ax, cs       ; 置其他段寄存器值与CS相同
    mov	ds, ax       ; 数据段
    mov	bp, %1       ; BP=当前串的偏移地址(%1)
    mov	ax, ds       ; ES:BP = 串地址
    mov	es, ax       ; 置ES=DS
    mov	cx, %2       ; CX = 串长（=%2）
    mov	ax, 1301h    ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
    mov	bx, 0007h    ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, %3       ; 行号=%3
    mov	dl, %4       ; 列号=%4
    int	10h          ; BIOS的10h功能：显示一行字符
    popa             ; 恢复现场
%endmacro