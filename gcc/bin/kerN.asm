
[BITS 16]
dssave dw 0
sisave dw 0
retaddr dw 0
kernelsp dw 0	
targetaddr dw 0
stackBottom dw 0
timeoffset dw 0
timebase dw 0

; external functions
    EXTERN MainProc
    EXTERN CreateProcess
    EXTERN Schedule
    EXTERN GetPcbPtr
	EXTERN CMDline
	EXTERN CurrentProc

    ; external variables
    EXTERN processCount
   
	
	GLOBAL start
	GLOBAL LoadProgram
	GLOBAL lock1
	GLOBAL unlock
  
	
%macro PUSH 1
        push word 0
        push %1
%endmacro


%macro CALL 2
        push eax
        mov ax, %1
        mov [targetAddr+2], ax ;targetaddr为0
        mov ax, %2
        mov [targetAddr], ax
        pop eax
        call far [targetAddr]
%endmacro
start:
    cli
    mov ax, cs
    mov dx, ax
    mov es, ax
    mov ss, ax
    mov sp, stackBottom
    mov dword[ds:processCount], 0

    ;PUSH 0
    ;PUSH cs
    ;PUSH kernel_entrance
    ;CALL cs, _CreateProcess
	
     PUSH 0
     PUSH cs
     PUSH kernel_entrance

	
	;****************************************************
initimer:  ;初始化时钟中断
    mov ax,[es:4*8]
	mov word[timeoffset],ax
	mov ax,[es:4*8+2]
	mov word[timebase],ax

;******************************************** 
    push ax
	mov ax,cs
	mov [targetaddr+2],ax
	mov ax,CreateProcess   ;带_,说明这是C中的函数
	mov [targetaddr],ax
	pop ax
     call far [targetaddr]
	
	
	pop cx
	
    PUSH dword 0
	
    ;CALL cs, _GetPcbPtr
	;push ax
	;mov ax,cs
	;mov [targetaddr+2],ax
	;mov ax,_GetPcbPtr
	;mov [targetaddr],ax
	;pop ax
	;call far [targetaddr]
	
    pop cx

  
kernel_entrance:
    mov ax, cs
    mov dx, ax
    mov es, ax
    mov ss, ax
    mov esp, stackBottom
    sti

    ;CALL cs, _MainProc
    push ax
	mov ax,cs
	mov [targetaddr+2],ax
	mov ax,MainProc
	mov [targetaddr],ax
	pop ax
	call far [targetaddr]
	
    jmp $

	
;****************************************************

lock1 :
  ;恢复原来的时间中断向量

	push es
	push ax
	push ds
	mov ax,cs
	mov ds,ax
	mov ax,0
	mov es,ax
	mov ax,word[timeoffset]
	mov [es:4*8],ax
	mov ax,word[timebase]
	mov [es:4*8+2],ax
	pop ds
	pop ax
	pop es
	ret


unlock:    ;修改时间中断向量使其指向timer函数

	push es
	push ax
	push ds
	mov ax,cs
	mov ds,ax
	mov ax,0
	mov es,ax
	mov ax,[es:4*8]
	mov word[timeoffset],ax ;改之前先存起来
	mov ax,[es:4*8+2]
	mov word[timebase],ax
	mov word[es:4*8], timer
    mov word[es:4*8+2], 9000h
	pop ds
	pop ax
	pop es
	ret

;************************************************
timer:
 ;这里加修改时钟中断
	push ax
	mov ax,cs
	mov [targetaddr+2],ax
	mov ax,Save 
	mov [targetaddr],ax
	pop ax
	call far [targetaddr]
	 
	push ax
	mov ax,cs
	mov [targetaddr+2],ax
	mov ax,Schedule   ;带_,说明这是C中的函数
	mov [targetaddr],ax
	pop ax
	call far [targetaddr]
	 
	push ax
	mov ax,cs
	mov [targetaddr+2],ax
	mov ax,Restart  
	mov [targetaddr],ax
	pop ax
	call far [targetaddr]
	 


;************************************************
Save:
    push ds
	push cs
	push ds  ;ds=cs ds指向内核 
	pop word[ds:dssave]
	pop word[ds:retaddr]
	pop word[ds:retaddr+2]
    
	mov [ds:sisave],si
	mov si,[ds:CurrentProc]
	pop word[ds:si+44]   ;依次pop出用户栈顶的cs,ip,flag
	pop word[ds:si+48]
	pop word[ds:si+52]

	;保存各寄存器的值
	mov [ds:si],ax
	mov [ds:si+4], bx
    mov [ds:si+8], cx
    mov [ds:si+12], dx
    mov ax, [ds:sisave]
    mov [ds:si+16], ax
    mov [ds:si+20], di
    mov [ds:si+24], bp
	
	xor ax,ax
	mov ax,es
	mov[ds:si+28],ax
	mov ax,[ds:dssave]
	mov [ds:si+32],ax
	mov ax,ss
	mov [ds:si+36],ax
	mov [ds:si+40],sp
	
	mov ax,ds
	mov ss,ax
	mov es,ax
	
	mov sp,[kernelsp];切换到内核的栈
	
	jmp far [ds:retaddr]
	
;************************************************
Restart:
    pop cx
	
	;恢复寄存器值
	mov si,[ds:CurrentProc]
	mov bx,[ds:si+4]
    mov cx, [ds:esi+8]
    mov dx, [ds:esi+12]
    mov di, [ds:esi+20]
    mov bp, [ds:esi+24]

    mov [ds:kernelsp], sp
    mov ax, [ds:si+36]
    mov ss, ax
    mov sp, [ds:si+40]

    push word[ds:si+52]
    push word[ds:si+48]
    push word[ds:si+44]
	
    push dword[ds:si]
    push dword[ds:si+16]
    push word[ds:si+28]
    push word[ds:si+32]
	
	pop ds
	pop es
	pop esi
	
	mov al,20h			; AL = EOI
	out 20h,al			; 发送EOI到主8529A
	out 0A0h,al			; 发送EOI到从8529A
	pop ax
	iret				; 从中断返回

;**************************************************
LoadProgram: ;这里C中有调用
    push bp
    mov bp, sp
    push es
    push bx

    mov ax, [bp+24];取seg存进es
    mov es, ax
    mov ax, [bp+28];取offset存进bx
    mov bx, ax

    mov ax, [bp+8]
    mov dh, al   ;dh磁头号，对应软盘即面号
    mov ax, [bp+12]
    mov ch, al   ;ch磁道号
    mov ax, [bp+16]
    mov cl, al   ;cl扇区号
    mov ax, [bp+20]

    mov ah, 0x02  ;int 13h的功能号 2表示读扇区，3表示写扇区
    mov dl, 0
    int 0x13  ;调用int 13h

    pop bx
    pop es    ;ex:bx表示收取扇区读入的内存区
    pop bp

    RET
;******************************************************
ReadCommand:

        push es
        push ds
		push cx
		push bx
		push ax
		push si
		push di
		mov cx,20
        mov bx,0b800h
		mov es,bx
        mov si, CMDline
		mov di,650
readchar@1:   
		mov ah,0
        int 16h
        cmp al,0Dh
        jz  endcmd@1
		mov [si],al
		mov [es:di],al
        inc di
		mov word[es:di],0fh
        inc si
        inc di
        loop readchar@1
	
endcmd@1:
		pop	  di
		pop	  si
		pop	  ax
		pop	  bx
		pop	  cx
        pop   es
        pop   ds
        ret
