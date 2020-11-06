[bits 32]
global _start ;程序入口点
global sys_putc ;将一个字符写入光标处并推进光标
global sys_getc ;从键盘缓冲区中读入一个字符
global sys_get_cursor ;获取光标位置
global sys_move_cursor ;移动光标位置
global sys_load ;加载用户程序
global sys_enter_data_section ;进入内核数据区
global sys_leave_data_section ;离开内核数据区
global sys_read_hd ;读取磁盘
global sys_reboot ;重启
extern console ;Shell接口
extern KeyboardInterruptResponse ;键盘中断输入字符处理
extern TimeInterruptResponse ;时钟中断处理
_start:

;选择子
all_data_selector    equ  0x08    ;整个0-4GB内存的段的选择子
stack_selector    equ  0x18    ;内核堆栈段选择子
video_selector     equ  0x20    ;视频显示缓冲区的段选择子
kernel_code_selector equ 0x28 ;内核代码选择子
kernel_data_selector equ 0x30 ;内核数据选择子
user_program_selector_1 equ 0x38;用户代码选择子0
user_data_selector_1 equ 0x40;用户数据选择子0
user_program_selector_2 equ 0x48;用户代码选择子1
user_data_selector_2 equ 0x50;用户数据选择子1
user_program_selector_3 equ 0x58;用户代码选择子2
user_data_selector_3 equ 0x60;用户数据选择子2
user_program_selector_4 equ 0x68;用户代码选择子3
user_data_selector_4 equ 0x70;用户数据选择子3

user_program_in_disk equ 1081 ;用户程序在磁盘的逻辑扇区
user_program_address equ 0x100000 ;用户程序加载位置
idt_base equ 0x17e00

;内核头部信息
kernel_length dd 0 ;链接后写入
kernel_entry dd kernel_start
             dw kernel_code_selector    
;-----------------------------------------------
kernel_start:
    ; 中断测试
    call init_8259A
    call init_interrupt
    call init_keyboard_interrupt
    call init_time_interrupt

    mov al, 0xf9
    out 0x21, al

    mov al, 0xfe
    out 0xa1, al
    sti

    xor eax, eax
    xor ebx, ebx
    xor esi, esi

    mov eax, 0x100000
    mov ebx, 0x3ff
    mov ecx, 0x00409800
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100000
    mov ebx, 0x3ff
    mov ecx, 0x00409200
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100400
    mov ebx, 0x3ff
    mov ecx, 0x00409800
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100400
    mov ebx, 0x3ff
    mov ecx, 0x00409200
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100800
    mov ebx, 0x3ff
    mov ecx, 0x00409800
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100800
    mov ebx, 0x3ff
    mov ecx, 0x00409200
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100c00
    mov ebx, 0x3ff
    mov ecx, 0x00409800
    call make_gdt_descriptor
    call set_up_selector

    mov eax, 0x100c00
    mov ebx, 0x3ff
    mov ecx, 0x00409200
    call make_gdt_descriptor
    call set_up_selector

    mov ax, kernel_data_selector
    mov ds, ax
    mov ax, ss
    mov es, ax
    mov ds, ax
    call console
    jmp $

time_interrupt:
    pushad
    push ds

    call TimeInterruptResponse

    pop ds
    popad

    mov al, 0x20
    out 0x20, al
    out 0xa0, al

    ; 读寄存器C，标志位清0，否则只发生一次中断
    mov al, 0x0c
    out 0x70, al
    in al, 0x71

    iret
;-----------------------------------------------
sys_putc:                                   
;在当前光标处显示一个字符,并推进
;光标。仅用于段内调用 
;输入：显示字符和属性
    push ebp
    pushad ;EAX,ECX,EDX,EBX,ESP,EBP,ESI,EDI顺序入栈
    mov ebp, esp
    mov ecx, [ebp+10*4]
    
    ;以下取当前光标位置
    mov dx,0x3d4
    mov al,0x0e
    out dx,al
    inc dx                             ;0x3d5
    in al,dx                           ;高字
    mov ah,al

    dec dx                             ;0x3d4
    mov al,0x0f
    out dx,al
    inc dx                             ;0x3d5
    in al,dx                           ;低字
    mov bx,ax                          ;BX=代表光标位置的16位数

    cmp cl,0x0d                        ;回车符？
    jnz .put_0a
    mov ax,bx
    mov bl,80
    div bl
    mul bl
    mov bx,ax
    jmp .set_cursor

.put_0a:
    cmp cl,0x0a                        ;换行符？
    jnz .put_other
    add bx,80
    jmp .roll_screen

.put_other:                               ;正常显示字符
    push es
    mov eax,video_selector          ;0x800b8000段的选择子
    mov es,eax
    shl bx,1
    mov [es:bx],cx
    pop es

    ;以下将光标位置推进一个字符
    shr bx,1
    inc bx

.roll_screen:
    cmp bx,2000                        ;光标超出屏幕？滚屏
    jl .set_cursor

    push ds
    push es
    mov eax,video_selector
    mov ds,eax
    mov es,eax
    cld
    mov esi,0xa0                       ;小心！32位模式下movsb/w/d 
    mov edi,0x00                       ;使用的是esi/edi/ecx 
    mov ecx,1920
    rep movsd
    mov bx,3840                        ;清除屏幕最底一行
    mov ecx,80                         ;32位程序应该使用ECX
.cls:
    mov word[es:bx],0x0720
    add bx,2
    loop .cls

    pop es
    pop ds

    mov bx,1920

.set_cursor:
    mov dx,0x3d4
    mov al,0x0e
    out dx,al
    inc dx                             ;0x3d5
    mov al,bh
    out dx,al
    dec dx                             ;0x3d4
    mov al,0x0f
    out dx,al
    inc dx                             ;0x3d5
    mov al,bl
    out dx,al

    popad
    pop ebp
    ret

sys_getc:
    push ebx
    push ds
wait_input:
    sti
    nop
    nop
    nop
    mov bx, kernel_data_selector
    mov ds, bx
    cli
    mov eax, dword[input_buffer_start]
    cmp eax, dword[input_buffer_end]
    je wait_input

    mov ebx, input_buffer
    add ebx, dword[input_buffer_start]
    xor eax, eax
    mov al, byte[ebx]
    inc dword[input_buffer_start]
    cmp dword[input_buffer_start], input_buffer_length
    jne sys_getc_return
    mov dword[input_buffer_start], 0
sys_getc_return:
    pop ds
    pop ebx
    sti
    ret
    
read_hd:                           
;从硬盘读取一个逻辑扇区
;EAX=逻辑扇区号
;DS:EBX=目标缓冲区地址
;返回：EBX=EBX+512    
    push eax
    push ecx
    push edx
    push eax

    mov dx,0x1f2
    mov al,1
    out dx,al                          ;读取的扇区数

    inc dx                             ;0x1f3
    pop eax
    out dx,al                          ;LBA地址7~0

    inc dx                             ;0x1f4
    mov cl,8
    shr eax,cl
    out dx,al                          ;LBA地址15~8

    inc dx                             ;0x1f5
    shr eax,cl
    out dx,al                          ;LBA地址23~16

    inc dx                             ;0x1f6
    shr eax,cl
    or al,0xe0                         ;第一硬盘  LBA地址27~24
    out dx,al

    inc dx                             ;0x1f7
    mov al,0x20                        ;读命令
    out dx,al

  .waits:
    in al,dx
    and al,0x88
    cmp al,0x08
    jnz .waits                         ;不忙，且硬盘已准备好数据传输 

    mov ecx,256                        ;总共要读取的字数
    mov dx,0x1f0
  .readw:
    in ax,dx
    mov [ebx],ax
    add ebx,2
    loop .readw

    pop edx
    pop ecx
    pop eax
    ret                               ;段间返回 
    
sys_move_cursor:
    push ebp
    pushad
    mov ebp, esp
    
    ;判断是否出界
    xor ebx, ebx
    mov ebx, [ebp+10*4]
    cmp ebx, 0
    jnl cursor_is_out
    jmp move_cursor_return
cursor_is_out:
    cmp ebx, 2000
    jnl move_cursor_return
    
    mov dx,0x3d4
    mov al,0x0e
    out dx,al
    inc dx                             ;0x3d5
    mov al,bh
    out dx,al
    dec dx                             ;0x3d4
    mov al,0x0f
    out dx,al
    inc dx                             ;0x3d5
    mov al,bl
    out dx,al
move_cursor_return:
    popad
    pop ebp
    ret
    
sys_get_cursor:
    xor eax, eax
    
    mov dx,0x3d4
    mov al,0x0e
    out dx,al
    inc dx                             ;0x3d5
    in al,dx                           ;高字
    mov ah,al

    dec dx                             ;0x3d4
    mov al,0x0f
    out dx,al
    inc dx                             ;0x3d5
    in al,dx                           ;低字
    ret
;----------------------------------------------
set_up_selector:
;edx段描述符高32位
;eax段描述符低32位
;ax选择子

    push ds
    push es

    mov ebx, kernel_data_selector
    mov ds, ebx

    sgdt [pgdt]

    mov ebx, all_data_selector
    mov es, ebx

    movzx ebx, word[pgdt]
    inc bx
    add bx, word[pgdt+2]
    mov [es:ebx], eax
    mov [es:ebx+4], edx

    add word[pgdt], 8

    lgdt [pgdt]

    mov ax, word[pgdt]
    mov bx, 8
    xor dx, dx
    div bx
    shl ax, 3

    pop es
    pop ds
    ret

make_gdt_descriptor: 
;构造描述符
;输入：EAX=线性基地址
;EBX=段界限
;ECX=属性（各属性位都在原始;位置，其它没用到的位置0） 
;返回：EDX:EAX=完整的描述符
    mov edx,eax
    shl eax,16                     
    or ax,bx                        ;描述符前32位(EAX)构造完毕
      
    and edx,0xffff0000              ;清除基地址中无关的位
    rol edx,8
    bswap edx                       ;装配基址的31~24和23~16  (80486+)
      
    xor bx,bx
    or edx,ebx                      ;装配段界限的高4位
    
    or edx,ecx                      ;装配属性 
      
    ret
sys_load:
    push ebp
    push eax
    push ebx
    push ecx
    push esi
    push ds
    push es

    xor eax, eax
    mov ax, all_data_selector
    mov ds, ax
    mov es, ax
    
    mov eax, user_program_in_disk
    mov ebx, user_program_address
    mov ecx, 8
read_user_program:
    call read_hd
    inc eax
    dec ecx
    cmp ecx, 0
    jne read_user_program

    pop es
    pop ds

    mov esi, [esp+6*4];
run_after_load:
    cmp byte [esi], 0
    jz load_program_return
p0:
    cmp byte [esi], '0' 
    jnz p1
    push es
    push ds
    mov ax, user_data_selector_1
    mov ds, ax
    call user_program_selector_1:4
    pop ds
    pop es
    inc esi
    jmp run_after_load
p1:
    cmp byte [esi], '1' 
    jnz p2
    push es
    push ds
    mov ax, user_data_selector_2
    mov ds, ax
    call user_program_selector_2:4
    pop ds
    pop es
    inc esi
    jmp run_after_load
p2:
    cmp byte [esi], '2' 
    jnz p3
    push es
    push ds
    mov ax, user_data_selector_3
    mov ds, ax
    call user_program_selector_3:4
    pop ds
    pop es
    inc esi
    jmp run_after_load
p3:
    cmp byte [esi], '3' 
    jnz load_program_return
    push es
    push ds
    mov ax, user_data_selector_4
    mov ds, ax
    call user_program_selector_4:4
    pop ds
    pop es
    inc esi
    jmp run_after_load

load_program_return:
    pop esi
    pop ecx
    pop ebx
    pop eax
    pop ebp
ret

sys_enter_data_section:
    mov ax, kernel_data_selector
    mov ds, ax
    ret

sys_leave_data_section:
    mov ax, ss
    mov ds, ax
    ret

sys_read_hd:
    push eax
    push ebx
    mov eax, [esp+3*4];
    mov ebx, [esp+4*4];
    call read_hd
    pop ebx
    pop eax
    ret

sys_reboot:
    ret

; 中断描述符表初始化
init_interrupt:
    pushad
    push ds

    mov ax, all_data_selector
    mov ds, ax
    mov ecx, 256
    mov ebx, idt_base
loop_init_idt:
    mov dword [ebx], 0
    mov dword [ebx+4], 0
    add ebx, 8
    loop loop_init_idt

    mov ax, kernel_data_selector
    mov ax, ds
    mov word [idt], 0x7ff
    mov dword [idt+0x2], idt_base
    lidt [idt]

    pop ds
    popad
    ret
; 8259A初始化
init_8259A:
    mov al, 0x11
    out 0x20, al
    out 0xa0, al

    mov al, 0x20
    out 0x21, al
    mov al, 0x28
    out 0xa1, al

    mov al, 4
    out 0x21, al
    mov al, 2
    out 0xa1, al

    mov al, 1
    out 0x21, al
    out 0xa1, al

    mov al, 0xff
    out 0x21, al
    out 0xa1, al

    ret

; 键盘中断
init_keyboard_interrupt:
    pushad
    push ds

    mov ax, all_data_selector
    mov ds, ax

    mov eax, keyboard_interrput
    mov ebx, kernel_code_selector
    shl ebx, 16
    or eax, ebx
    mov [idt_base+0x21*8], eax

    mov eax, keyboard_interrput
    and eax, 0xffff0000
    or eax, 0x00008e00
    mov [idt_base+0x21*8+4],eax

    pop ds
    popad
    ret
keyboard_interrput:
    push eax
    push esi
    push ds

    mov ax, kernel_data_selector
    mov ds, ax

    in al, 0x60
    mov esi, input_buffer
    add esi, dword[input_buffer_end]

    mov byte[esi], al

    push eax
    call KeyboardInterruptResponse
    pop eax

    inc dword[input_buffer_end]
    cmp dword[input_buffer_end], input_buffer_length
    jne keyboard_interrput_return
    mov dword[input_buffer_end], 0
keyboard_interrput_return:
    ; 发送EOI消息
    mov al, 0x20
    out 0x20, al
    out 0xa0, al

    pop ds
    pop esi
    pop eax
    iret
; 时钟中断
init_time_interrupt:
    pushad
    push ds

    mov ax, all_data_selector
    mov ds, ax

    mov eax, kernel_code_selector
    shl eax, 16
    mov ebx, time_interrupt
    or ax, bx
    mov dword[idt_base+0x28*8], eax
    
    mov eax, time_interrupt
    and eax, 0xffff0000
    or eax, 0x00008e00
    mov dword[idt_base+0x28*8+4], eax

    ;设置和时钟中断相关的硬件 
    mov al,0x0b ;RTC寄存器B        0000_1011
    or al,0x80  ;阻断NMI           1000_0000  
    out 0x70,al
		   
    mov al,0x12 ;设置寄存器B，禁止周期性中断，开放更 
    out 0x71,al ;新结束后中断，BCD码，24小时制 
 
    mov al,0x0c
    out 0x70,al
    in al,0x71  ;读RTC寄存器C，复位未决的中断状态

    pop ds
    popad
    ret
pgdt dw 0
     dd 0
idt dw 0
     dd 0
input_buffer:
    times 1024 db 0
input_buffer_start dd 0
input_buffer_end dd 0
input_buffer_length equ 1024
_end:
