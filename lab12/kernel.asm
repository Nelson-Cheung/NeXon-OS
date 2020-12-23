[bits 32]
%include "include/boot.inc"
global _start
global sys_putc ;将一个字符写入光标处并推进光标
global sys_getc ;从键盘缓冲区中读入一个字符
global sys_get_cursor ;获取光标位置
global sys_move_cursor ;移动光标位置
global sys_load ;加载用户程序
global sys_read_hd ;读取磁盘
global sys_reboot ;重启
global sys_add_gd ;参数high，low，加入全局描述符，并返回序号
global sys_init_tss
global sys_get_return_address ; 找到函数返回地址
global _save
global _restart
global _interrupt_36h
global _interrupt_37h
global _interrupt_38h
global _call_interrupt
global _in_port
global _out_port
global PrintTime
global _begin_thread
global _disable_interrupt
global _enable_interrupt
global _interrupt_status
global _running_thread
global _switch_thread_to
global inw_port
global outw_port
global sys_add_gd
global sys_start_process
global sysGetEax
global sysGetEbx
global sysGetEcx
global sysGetEdx
global sysGetEsi
global sysGetEdi
global sysSetEax
global sysSetEbx
global sysSetEcx
global sysSetEdx
global sysSetEsi
global sysSetEdi
global sysStartSysCall
global sys_update_cr3
global sys_interrupt_exit

extern TimeInterruptResponse
extern KeyboardInterruptResponse
extern Int38HResponse
extern Kernel
extern PrintTime
extern syscallTable
extern copyProcess

_start:
    cli
    cmp byte[status], 1
    je enter_kernel 
    ; 中断测试
    call init_8259A
    call init_interrupt
    call init_user_interrupt
    call init_keyboard_interrupt
    call init_time_interrupt
    call init_sys_call_interrupt

    mov al, 0xf9 ; 键盘，IRQ2
    out 0x21, al

    mov al, 0xfe ; 实时钟，硬盘中断
    out 0xa1, al


    mov al, 1
    mov byte[status], al

enter_kernel:
    call Kernel
    jmp $

_in_port:
    push edx
    xor eax, eax
    mov edx, dword[esp+8]
    in al, dx
    pop edx
    ret

_out_port:
    push edx
    mov edx, dword[esp+8]
    mov eax, dword[esp+12]
    out dx, al
    pop edx
    ret

inw_port:
    push edx
    xor eax, eax
    mov edx, dword[esp+8]
    in ax, dx
    pop edx
    ret

outw_port:
    push edx
    mov edx, dword[esp+8]
    mov eax, dword[esp+12]
    out dx, ax
    pop edx
    ret
time_interrupt:
    cli
    call _save

    mov al, 0x20
    out 0x20, al
    out 0xa0, al

    ; 读寄存器C，标志位清0，否则只发生一次中断
    mov al, 0x0c
    out 0x70, al
    in al, 0x71

    sti
    
    call TimeInterruptResponse

    cli
    call _restart
    sti

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
    shl bx,1
    mov [gs:bx],cx

    ;以下将光标位置推进一个字符
    shr bx,1
    inc bx

.roll_screen:
    cmp bx,2000                        ;光标超出屏幕？滚屏
    jl .set_cursor

    mov ecx, 24 * 80
    mov bx, 160
.move_up_one_line:
    mov ax, word[gs:bx]
    sub bx, 160
    mov word[gs:bx], ax
    add bx, 162
    loop .move_up_one_line

    mov bx,3840                        ;清除屏幕最底一行
    mov ecx,80                         ;32位程序应该使用ECX
.cls:
    mov word[gs:bx],0x0720
    add bx,2
    loop .cls

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
wait_input:
    sti
    nop
    nop
    nop
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

    push es


    sgdt [pgdt]

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
sys_load: ;需要修改
    push ebp
    push eax
    push ebx
    push ecx
    push esi
    push ds
    push es

    xor eax, eax
    mov es, ax
    
    ;mov eax, user_program_in_disk
    ;mov ebx, user_program_address
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
    ;mov ax, user_data_selector_1
    mov ds, ax
    ;call user_program_selector_1:4
    pop ds
    pop es
    inc esi
    jmp run_after_load
p1:
    cmp byte [esi], '1' 
    jnz p2
    push es
    push ds
    ;mov ax, user_data_selector_2
    mov ds, ax
    ;call user_program_selector_2:4
    pop ds
    pop es
    inc esi
    jmp run_after_load
p2:
    cmp byte [esi], '2' 
    jnz p3
    push es
    push ds
    ;mov ax, user_data_selector_3
    mov ds, ax
    ;call user_program_selector_3:4
    pop ds
    pop es
    inc esi
    jmp run_after_load
p3:
    cmp byte [esi], '3' 
    jnz load_program_return
    push es
    push ds
    ;mov ax, user_data_selector_4
    mov ds, ax
    ;call user_program_selector_4:4
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

    mov ecx, 256
    mov ebx, IDT_START_ADDRESS
loop_init_idt:
    mov dword [ebx], 0
    mov dword [ebx+4], 0
    add ebx, 8
    loop loop_init_idt

    mov word [idt], 0x7ff
    mov dword [idt+0x2], IDT_START_ADDRESS
    lidt [idt]

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

    mov eax, keyboard_interrput
    mov ebx, CODE_SELECTOR
    shl ebx, 16
    or eax, ebx
    mov [IDT_START_ADDRESS+0x21*8], eax

    mov eax, keyboard_interrput
    and eax, 0xffff0000
    or eax, 0x00008e00
    mov [IDT_START_ADDRESS+0x21*8+4],eax

    popad
    ret
keyboard_interrput:
    push eax
    push esi

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

    pop esi
    pop eax
    iret
; 时钟中断
init_time_interrupt:
    pushad

    mov eax, CODE_SELECTOR
    shl eax, 16
    mov ebx, time_interrupt
    or ax, bx
    mov dword[IDT_START_ADDRESS+0x28*8], eax
    
    mov eax, time_interrupt
    and eax, 0xffff0000
    or eax, 0x00008e00
    mov dword[IDT_START_ADDRESS+0x28*8+4], eax

    ;设置和时钟中断相关的硬件 
    mov al,0x0b ;RTC寄存器B        0000_1011
    or al,0x80  ;阻断NMI           1000_0000  
    out 0x70,al
		   
    mov al,0x12 ;设置寄存器B，禁止周期性中断，开放更 
    out 0x71,al ;新结束后中断，BCD码，24小时制 
 
    mov al,0x0c
    out 0x70,al
    in al,0x71  ;读RTC寄存器C，复位未决的中断状态

    popad
    ret
; 中断本身会将eflags，cs，eip保护
_save:
    pop dword[temp]
    push ds
    push es
    push gs
    push fs
    push ss
    pushad ;EAX,ECX,EDX,EBX,ESP,EBP,ESI,EDI
    push dword[temp]
    ; 进行页目录表的保存
    ret
_restart:
    pop dword[temp]
    popad
    pop ss
    pop fs
    pop gs
    pop es
    pop ds
    ; 进行页目录表的恢复
    push dword[temp]
    ret

_interrupt_36h:
    ; 退出中断前压栈的内容
    cli
    call _save
    sti

    call KERNEL_START_ADDRESS

    cli
    call _restart
    sti

    iret
_interrupt_38h:
    cli
    call _save
    sti

    call Int38HResponse

    cli
    call _restart
    sti

    iret

_interrupt_37h:
    cli
    call _save
    sti

.0_func:
    cmp ax, 0
    jne .1_func
    push ebx
    call sys_putc
    pop ebx
    jmp .int_return

.1_func:
    cmp ax, 1
    jne .2_func
    push ebx
    call sys_move_cursor
    pop ebx
    jmp .int_return

.2_func:
    cmp ax, 2
    jne .int_return
    call PrintTime
.int_return:
    cli
    call _restart
    sti

    iret
_call_interrupt:
    push esi
    push eax
    push ebx
    push ecx
    push edx

    mov esi, dword[esp+24]
    mov eax, dword[esp+28]
    mov ebx, dword[esp+32]
    mov ecx, dword[esp+36]
    mov edx, dword[esp+40]
    
.int_36h:
    cmp esi, 0x36
    jne .int_37h
    int 0x36
    jmp .call_interrupt_return
.int_37h:
    cmp esi, 0x37
    jne .int_38h
    int 0x37
    jmp .call_interrupt_return
.int_38h:
    cmp esi, 0x38
    jne .call_interrupt_return
    int 0x38
    
.call_interrupt_return:
    pop edx
    pop ecx
    pop ebx
    pop eax
    pop esi

    ret
init_user_interrupt:
    ; 36h
    mov ebx, _interrupt_36h
    and ebx, 0x0000ffff
    mov eax, CODE_SELECTOR
    shl eax, 16
    or eax, ebx
    mov dword[IDT_START_ADDRESS+0x36*8], eax

    mov eax, _interrupt_36h
    and eax, 0xffff0000
    or eax, 0x00008e00

    mov dword[IDT_START_ADDRESS+0x36*8+4], eax

    ;37h
    mov ebx, _interrupt_37h
    and ebx, 0x0000ffff
    mov eax, CODE_SELECTOR
    shl eax, 16
    or eax, ebx
    mov dword[IDT_START_ADDRESS+0x37*8], eax

    mov eax, _interrupt_37h
    and eax, 0xffff0000
    or eax, 0x00008e00

    mov dword[IDT_START_ADDRESS+0x37*8+4], eax

    ;38h
    mov ebx, _interrupt_38h
    and ebx, 0x0000ffff
    mov eax, CODE_SELECTOR
    shl eax, 16
    or eax, ebx
    mov dword[IDT_START_ADDRESS+0x38*8], eax

    mov eax, _interrupt_38h
    and eax, 0xffff0000
    or eax, 0x00008e00

    mov dword[IDT_START_ADDRESS+0x38*8+4], eax

    ret
_begin_thread:
    jmp $
    pop dword[temp]
    pop dword[temp]
    mov esp, dword[temp]
    pop ebp
    pop ebx
    pop edi
    pop esi
    ret

_running_thread:
    mov eax, esp;
    and eax, 0xfffff000
    ret
_disable_interrupt:
    cli
    nop
    ret
_enable_interrupt:
    sti
    nop
    ret
_interrupt_status:
    xor eax, eax
    pushfd
    pop eax
    shr eax, 9
    and eax, 0x1
    ret
_switch_thread_to:

    push ebp
    push ebx
    push edi
    push esi

    mov eax, dword[esp + 4 * 5]
    mov [eax], esp

    mov eax, dword[esp + 4 * 6]
    mov esp, [eax]

    pop esi
    pop edi
    pop ebx
    pop ebp
    
    sti
    ret
sys_add_gd: ; low, high
    push ebx
    push ecx

    sgdt [pgdt]
    xor ebx, ebx
    mov bx, [pgdt]
    inc ebx
    mov eax, ebx
    add ebx, [pgdt+2]

    mov ecx, [esp+12]
    mov [ebx], ecx
    mov ecx, [esp+16]
    mov [ebx+4], ecx

    mov ebx, eax
    shr eax, 3
    add ebx, 8
    dec ebx
    mov [pgdt], bx
    lgdt [pgdt]

    pop ecx
    pop ebx
    ret

sys_init_tss:
    ltr word[esp+4]
    ret

sys_start_process:
    mov eax, dword[esp+4]
    mov esp, eax
    add esp, 4 ; 越过中断向量号
    popad
    pop gs;
    pop fs;
    pop es;
    pop ds;
    add esp, 4 ; 越过错误码
    iret
sys_update_cr3:
    push eax
    mov eax, dword[esp+8]
    mov cr3, eax
    pop eax
    ret

init_sys_call_interrupt: ; 0x80中断
    pushad
    
    mov eax, CODE_SELECTOR
    shl eax, 16
    mov ebx, syscall_handler
    and ebx, 0xffff
    or eax, ebx
    mov [IDT_START_ADDRESS+0x80*8], eax

    mov eax, 0xee00 ; DPL = 3s
    mov ebx, syscall_handler
    and ebx, 0xffff0000 
    or eax, ebx
    mov [IDT_START_ADDRESS+0x80*8+4], eax

    popad
    ret

syscall_handler: ; 系统调用时的中断处理函数
    cli

    sub esp, 4 ; 越过错误码
    push ds
    push es
    push fs
    push gs
    pushad
    sub esp, 4 ; 越过中断向量号

    ; 参数压栈
    push edi
    push esi
    push edx
    push ecx
    push ebx

    mov dword[temp], eax
    mov eax, DATA_SELECTOR
    mov ds, eax
    mov es, eax
    mov eax, STACK_SELECTOR
    mov ss, eax
    mov eax, VIDEO_SELECTOR
    mov gs, eax
    mov eax, dword[temp]
    sti    

    call dword[syscallTable+eax*4]

    cli
    add esp, 4 * 5

    mov [temp], eax ; 保存返回值
    add esp, 4 ; 越过中断向量号
    popad
    pop gs
    pop fs
    pop es
    pop ds
    add esp, 4 ; 越过错误码
    mov eax, [temp]
    sti

    iret

sysSetEax:
    mov eax, dword[esp+4]
    ret
sysSetEbx:
    mov ebx, dword[esp+4]
    ret
sysSetEcx:
    mov ecx, dword[esp+4]
    ret
sysSetEdx:
    mov edx, dword[esp+4]
    ret
sysSetEsi:
    mov esi, dword[esp+4]
    ret
sysSetEdi:
    mov edi, dword[esp+4]
    ret

sysGetEax:
    ret
sysGetEbx:
    mov eax, ebx
    ret
sysGetEcx:
    mov eax, ecx
    ret
sysGetEdx:
    mov eax, edx
    ret
sysGetEsi:
    mov eax, esi
    ret
sysGetEdi:
    mov eax, edi
    ret
sysStartSysCall:
    push ds
    push es
    push gs
    push fs
    push ss

    int 0x80

    pop ss
    pop fs
    pop gs
    pop es
    pop ds

    ret

sys_interrupt_exit:
    add esp, 4 ; 越过中断向量号
    popad
    pop gs
    pop fs
    pop es
    pop ds
    add esp, 4 ; 越过错误码
    iretd
init_disk_interrupt:
    pushad

    mov eax, disk_interrupt
    mov ebx, CODE_SELECTOR
    shl ebx, 16
    or eax, ebx
    mov [IDT_START_ADDRESS+0x2e*8], eax

    mov eax, disk_interrupt
    and eax, 0xffff0000
    or eax, 0x00008e00
    mov [IDT_START_ADDRESS+0x2e*8+4],eax

    popad
    ret

disk_interrupt:
    pushad

    ;call sysDiskInterrupt

    ; 发送EOI消息
    mov al, 0x20
    out 0x20, al
    out 0xa0, al

    popad
    iret

pgdt dw 0
     dd 0
idt dw 0
     dd 0
status db 0
input_buffer:
    times 1024 db 0
input_buffer_start dd 0
input_buffer_end dd 0
input_buffer_length equ 1024
interrupt_status db 0
temp dd 0

_end: