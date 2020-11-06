BITS 16
%include "header.inc"

global printPos
global putchar
global cls
global getch
global shutdown
global loadUsrProgram
global getDateInfo
global save
global restart
global syscaller
global sys_int22
global sys_putchar

extern getRegisterImage
extern sysc_int22

extern Timer
extern TimerWithDate

cls:
    pusha
    mov ax, 0003h
    int 10h       ;清屏
    popa
    retf

printPos:
    pusha
    mov si, sp
    add si, 16+4
    mov	ax, cs             ; 置其他段寄存器值与CS相同
    mov	ds, ax             ; 数据段
    mov	bp, [si]           ; BP=当前串的偏移地址
    mov	ax, ds             ; ES:BP = 串地址
    mov	es, ax             ; 置ES=DS
    mov	cx, [si+4]         ; CX = 串长（=9）
    mov	ax, 1300h          ; AH = 13h（功能号）、AL = 00h（光标置于串尾）
    mov	bx, 0007h          ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, [si+8]         ; 行号=0
    mov	dl, [si+12]        ; 列号=0
    int	10h; BIOS的10h功能：显示一行字符
    popa   
    retf

putchar:
    pusha
    mov bp, sp
    add bp, 16+4 
    mov al, [bp] 
    mov bh, 0
    mov ah, 0Eh ;功能码
    int 10h 
    popa
    retf


getch:
    mov ah,0
    int 16h
    mov ah,0
    retf

shutdown:
    mov ax, 2001H
    mov dx, 1004H
    out dx, ax

loadUsrProgram:    
    pusha
    push ds
    push es       
    VECTOR_IN 08h,Timer
    mov bp, sp
    mov bx, [bp+24]        ; 用户程序的段地址
    mov word[program+2],bx
    mov es, bx             ; 用es才能跨段读取,es:bx是读入的数据所在内存地址
    mov bx, [bp+28]        ; 偏移地址; 存放数据的内存偏移地址
    mov ah,2               ; 功能号
    mov al,[bp+32]         ; 扇区数
    mov dl,0               ; 驱动器号; 软盘为0，硬盘和U盘为80H
    mov dh,[bp+36]         ; 磁头号; 起始编号为0
    mov ch,[bp+40]         ; 柱面号; 起始编号为0
    mov cl,[bp+44]         ; 起始扇区号 ; 起始编号为1
    int 13H                ; 调用读磁盘BIOS的13h功能
    mov word[program],0x100
runUsrProgram:
    mov ax, cs
    mov gs, ax
    mov ax,0xffff          ; 用户程序的栈顶为0xffff
    mov cx,sp              ; 保存当前的栈顶，用于返回后恢复
    mov sp,ax              ; 设置用户程序的栈顶
    mov ax,[codeOfInt20]   ; 用ax保存int 20这个语句
    mov bx, es             ; 用户程序的段地址
    mov ds,bx              ; 设置用户程序的数据段和es一致
    mov ss,bx              ; 设置现在的栈段和es一致(以后push和pop就会操作用户程序的栈)
    mov [es:0],ax          ; 在es:0(用户程序所在段首)放置int 20
    push cx                ; 将内核栈顶偏移放入，用于返回后恢复
    push cs                ; 
    push afterRun          ; 将cs ip先后压栈，返回时可以远返回retf
    push dword 0            ; 压栈0，用户程序如果使用ret就会触发ip=0的操作，开始执行从es:0开始的语句
    jmp far [gs:program]   ;远转移至gs:program所指的位置

afterRun:
    mov ax,cs
    mov ss,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    VECTOR_IN 08h,TimerWithDate
    pop es
    pop ds
    popa
    retf

codeOfInt20:
    int 20h

getDateInfo:
    push es
    push bp
    mov bp, sp
    mov al, [bp+8]        ; 偏移地址; 存放数据的内存偏移地址
    out 70h, al
    in al, 71h
    mov ah, 0
    pop bp
    pop es
    retf

save:
    pusha
    mov bp, sp
    call dword getRegisterImage
    mov di, ax
    mov ax, [bp]         ;di
    mov [cs:di+14], ax   ;
    mov ax, [bp+2]       ;si
    mov [cs:di+12], ax   ;
    mov ax, [bp+4]       ;bp
    mov [cs:di+10], ax   ;
    mov ax, [bp+6]       ;sp
    add ax,-24
    mov [cs:di+8], ax    ;
    mov ax, [bp+8]       ;dx
    mov [cs:di+6], ax    ;
    mov ax, [bp+10]      ;cx
    mov [cs:di+4], ax    ;
    mov ax, [bp+12]      ;bx
    mov [cs:di+2], ax    ;
    mov ax, [bp+14]      ;ax
    mov [cs:di], ax      ;
    mov ax, ds           ;ds
    mov [cs:di+16], ax   ;
    mov ax, es           ;es
    mov [cs:di+18], ax   ;
    mov ax, fs           ;fs
    mov [cs:di+20], ax   ;
    mov ax, gs           ;gs
    mov [cs:di+22], ax   ;
    mov ax, ss           ;ss
    mov [cs:di+24], ax   ;
    mov ax, [bp+18]      ;ip
    mov [cs:di+26], ax   ;
    mov ax, [bp+20]      ;cs
    mov [cs:di+28], ax   ;
    mov ax, [bp+22]      ;flags
    mov [cs:di+30], ax   ;
    popa
    ret

restart:
    call dword getRegisterImage
    mov si, ax
    mov ax, [cs:si+0]
    mov cx, [cs:si+2]
    mov dx, [cs:si+4]
    mov bx, [cs:si+6]
    mov sp, [cs:si+8]
    mov bp, [cs:si+10]
    mov di, [cs:si+14]
    mov ds, [cs:si+16]
    mov es, [cs:si+18]
    mov fs, [cs:si+20]
    mov gs, [cs:si+22]
    mov ss, [cs:si+24]
    add sp, 11*2                   ; 恢复正确的sp

    push word[cs:si+30]            ; 新进程flags
    push word[cs:si+28]            ; 新进程cs
    push word[cs:si+26]            ; 新进程ip

    push word[cs:si+12]
    pop si                         ; 恢复si
    ret

syscaller:
    call save ;保存现场
    mov si,cs ;si=0
    mov ds,si ;ds=cs=0
    mov si,ax ;功能号
    shr si,8
    add si,si
    call [sys_table]
    mov [retval],ax
    call restart
    mov ax,[retval]
    iret

sys_putchar: ;系统调用：打印一个字符(不需要返回参数)
    pusha
    mov bp,sp
    push word[bp+10]
    call dword putchar
    pop bx
    popa
    ret

sys_getch: ;系统调用：从键盘获得输入的一个字符(需要返回参数)
    call dword getch
    ret

sys_int22:
    call dword sysc_int22
    ret
program:
dw 0x7c00


sys_table:
    dw 0xffff,0xffff

retval:
    dw 0xff