BITS 16
global Timer
global TimerWithDate
extern printDate


; 在屏幕右下角显示字符‘!’	
	mov ah,0Fh		; 0000：黑底、1111：亮白字（默认值为07h）
	mov al,'!'			; AL = 显示字符值（默认值为20h=空格符）
	mov [gs:((80*12+39)*2)],ax	; 屏幕第 24 行, 第 79 列
	jmp $			; 死循环
; 时钟中断处理程序
	delay equ 4		; 计时器延迟计数
	count db delay		; 计时器计数变量，初值=delay
    wheel db '-\|/'
    wheelOffset dw 0
	color db 07h
Timer:
	sti
    pusha
    push gs
    push ds
    mov ax,cs
    mov ds,ax
	mov	ax,0B800h		; 文本窗口显存起始地址
	mov	gs,ax		; GS = B800h

	dec byte [count]		; 递减计数变量
	jnz Exit			; >0：跳转
	mov byte[count],delay		; 重置计数变量=初值delay
    
    mov ah,[color]
	dec byte[color]
	jz restoreColor
draw:
    mov si, wheel
    add si, [wheelOffset]
    mov al,[si]
	mov [gs:((80*24+79)*2)],ax	; =0：递增显示字符的ASCII码值
    inc byte[wheelOffset]
    cmp byte[wheelOffset],4
    jne Exit
    mov byte[wheelOffset],0
Exit:
	mov al,20h			; AL = EOI
	out 20h,al			; 发送EOI到主8529A
	out 0A0h,al			; 发送EOI到从8529A
    pop ds
    pop gs
    popa
	cli
	iret			; 从中断返回

restoreColor:
	mov byte[color], 07h
	jmp draw

TimerWithDate:
	sti
    pusha
    push gs
    push ds
    mov ax,cs
    mov ds,ax
	mov	ax,0B800h		; 文本窗口显存起始地址
	mov	gs,ax		; GS = B800h

	dec byte [count]		; 递减计数变量
	jnz Exit1			; >0：跳转
	mov byte[count],delay		; 重置计数变量=初值delay
    
    mov ah,[color]
	dec byte[color]
	jz restoreColor1
draw1:
    mov si, wheel
    add si, [wheelOffset]
    mov al,[si]
	mov [gs:((80*24+79)*2)],ax	; =0：递增显示字符的ASCII码值
    inc byte[wheelOffset]
    cmp byte[wheelOffset],4
    jne Exit1
    mov byte[wheelOffset],0
Exit1:
	call dword printDate
	mov al,20h			; AL = EOI
	out 20h,al			; 发送EOI到主8529A
	out 0A0h,al			; 发送EOI到从8529A
    pop ds
    pop gs
    popa
	cli
	iret			; 从中断返回

restoreColor1:
	mov byte[color], 07h
	jmp draw1
