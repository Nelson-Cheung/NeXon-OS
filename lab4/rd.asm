video_selector     equ  0x20    ;视频显示缓冲区的段选择子
length dd 0
[BITS 32]
start:	
	mov ax, video_selector
	mov es, ax
	mov byte[current], 0
loop1:
	dec word[count]				; 递减计数变量
	jnz loop1					; >0：跳转;
	mov word[count],delay
	dec word[dcount]				; 递减计数变量 二次循环
    jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay
move:
	inc byte[current]
	mov al, byte[current]
	mov ah, byte[MAX]
	cmp al, ah
	jne go_on
	retf
go_on:
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
DnRt:
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
      mov word[x],23
      mov byte[rdul],Up_Rt	
      jmp show
dr2dl:
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
	mov ax,12
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],78
      mov byte[rdul],Up_Lt	
      jmp show
ur2dr:
      mov word[x],14
      mov byte[rdul],Dn_Rt	
      jmp show

	
	
UpLt:
	dec word[x]
	dec word[y]
	
	mov bx,word[x]
	mov ax,12
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
	mov ax,39
	sub ax,bx
      jz  ul2ur
	jmp show

ul2dl:
      mov word[x],14
      mov byte[rdul],Dn_Lt	
      jmp show
ul2ur:
      mov word[y],41
      mov byte[rdul],Up_Rt	
      jmp show
DnLt:
	inc word[x]
	dec word[y]

	
	mov bx,word[y]
	mov ax,39
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
      mov word[y],41
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
	
	inc byte[char]
	cmp byte[char], 58
	je reset_char
	jmp swap
reset_char:
	mov byte[char], '0'
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
	mov al, byte[color]
	mov ah, byte[color1]
	mov byte[color], ah
	mov byte[color1], al
	jmp loop1
_end:
    jmp $                   ; 停止画框，无限循环 
Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
     Up_Rt equ 2                  ;
     Up_Lt equ 3                  ;
     Dn_Lt equ 4                  ;
     delay equ 50000					; 计时器延迟计数,用于控制画框的速度
     ddelay equ 580					; 计时器延迟计数,用于控制画框的速度
	MONITOR_ADDR equ 0x7c00
	
	MAX db 6
	count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; 第一个方向标志
    x    dw 12 ; 第一个方向的位置
    y    dw 39 ;第一个方向的位置
	rdul1 db Up_Lt ; 第二个方向标志
	x1 dw 25 ; 第二个方向的位置
	y1 dw 80 ;第二个方向的位置
    char db '0' ; 显示字符
	echar db 58 ; 显示字符序列结束标志
	color db 6 ; 显示字符颜色
	color1 db 7
	current db 0 ;已显示字符数