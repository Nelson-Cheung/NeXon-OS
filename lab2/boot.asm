; 程序源代码（stone.asm）
; 本程序在文本方式显示器上从左边射出一个*号,以45度向右下运动，撞到边框后反射,如此类推.
;  凌应标 2014/3
;   MASM汇编格式
     Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
     Up_Rt equ 2                  ;
     Up_Lt equ 3                  ;
     Dn_Lt equ 4                  ;
     delay equ 50000					; 计时器延迟计数,用于控制画框的速度
     ddelay equ 580					; 计时器延迟计数,用于控制画框的速度
;     .386
;     org 100h					; 程序加载到100h，可用于生成COM/7c00H引导扇区程序

jmp near start
	 
start:	
	;xor ax,ax					; AX = 0   程序加载到0000：100h才能正确执行
	mov ax,0x7c0                  ;设置数据段基地址 
	mov ds,ax
;   mov ax,cs
;	mov es,ax					; ES = 0
;	mov ds,ax					; DS = CS
;	mov es,ax					; ES = CS
	mov ax,0B800h				; 文本窗口显存起始地址
	mov es,ax					; GS = B800h
loop1:
	dec word[count]				; 递减计数变量
	jnz loop1					; >0：跳转;
	mov word[count],delay
	dec word[dcount]				; 递减计数变量 二次循环
    jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay
move:
    mov al,1
    cmp al,byte[rdul]
	jz  DnRt
	
    mov al,2
    cmp al,byte[rdul]
	jz  UpRt
	
    mov al,3
    cmp al,byte[rdul]
	jz  UpLt
	
    mov al,4
    cmp al,byte[rdul]
	jz  DnLt

	;jmp DnRt
    ;jmp $	

DnRt:
; if(x == 25) call dr2ur;
; else if(y == 80) call dr2dl;
; else call show
	inc word[x]
	inc word[y]

	
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dr2ur
	mov bx,word[y]
	mov ax,80
	sub ax,bx	
      jz  dr2dl
	jmp show
dr2ur:
; x = 23; rdul = Up_Rt; call show
      mov word[x],23
      mov byte[rdul],Up_Rt	
      jmp show
dr2dl:
; y = 78; rdul = DnLt; call show;
      mov word[y],78
      mov byte[rdul],Dn_Lt	
      jmp show

UpRt:
	dec word[x]
	inc word[y]
	
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],78
      mov byte[rdul],Up_Lt	
      jmp show
ur2dr:
      mov word[x],1
      mov byte[rdul],Dn_Rt	
      jmp show

	
	
UpLt:
	dec word[x]
	dec word[y]
	
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur
	jmp show

ul2dl:
      mov word[x],1
      mov byte[rdul],Dn_Lt	
      jmp show
ul2ur:
      mov word[y],1
      mov byte[rdul],Up_Rt	
      jmp show
DnLt:
	inc word[x]
	dec word[y]

	
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
      mov word[y],1
      mov byte[rdul],Dn_Rt	
      jmp show
	
dl2ul:
      mov word[x],23
      mov byte[rdul],Up_Lt	
      jmp show
	
show:	
    xor ax,ax                 ; 计算显存地址
    mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2				;80*25个文字 一个文字由文本和属性*2个字节组成
	mul bx
	mov bx,ax
	mov ah,byte[color]				
	mov al,byte[char]			;  AL = 显示字符值（默认值为20h=空格符）
	mov [es:bx],ax  		;  显示字符的ASCII码值
	
	inc byte[color]
	inc byte[char]
	cmp byte[char], 58
	je reset_char
	jmp show_name
reset_char:
	mov byte[char], '0'
show_name:
	mov cx, 0
	loop2:
		mov si, nameStr
		add si, cx
		mov ax, 2
		mov bx, cx
		add bx, 32
		mul bx
		mov di, ax
		mov al, [si]
		mov ah, 0x82
		mov word[es:di], ax
		inc cx
		cmp cx, word[nameLen]
		jnz loop2
swap:
	mov ax, word[x]
	mov bx, word[x1] 
	mov word[x], bx
	mov word[x1], ax
	mov ax, word[y]
	mov bx, word[y1] 
	mov word[y], bx
	mov word[y1], ax
	mov al, byte[rdul]
	mov ah, byte[rdul1]
	mov byte[rdul], ah
	mov byte[rdul1], al
	jmp loop1
_end:
    jmp $                   ; 停止画框，无限循环 
	
datadef:	
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; 第一个方向标志
    x    dw 7 ; 第一个方向的位置
    y    dw 0 ;第一个方向的位置
	rdul1 db Up_Lt ; 第二个方向标志
	x1 dw 17 ; 第二个方向的位置
	y1 dw 79 ;第二个方向的位置
    char db '0' ; 显示字符
	echar db 58 ; 显示字符序列结束标志
	color db 0 ; 显示字符颜色
	nameStr db "Nelson 18340211" ; 个人信息
	nameLen dw 15 ;个人信息长度
;    ASSUME cs:code,ds:code
;   code SEGMENT

times 510-($-$$) db 0
			   db 0x55,0xaa
;code ENDS
;     END start
