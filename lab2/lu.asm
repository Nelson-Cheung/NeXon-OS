start:	
	mov byte[current], 0
	mov ax, 0xb800
	mov es, ax
loop1:
	dec word[count]				; �ݼ���������
	jnz loop1					; >0����ת;
	mov word[count],delay
	dec word[dcount]				; �ݼ��������� ����ѭ��
    jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay
move:
	inc byte[current]
	mov al, byte[current]
	mov ah, byte[MAX]
	cmp al, ah
	jne go_on
	ret
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
	mov ax,12
	sub ax,bx
      jz  dr2ur
	mov bx,word[y]
	mov ax,40
	sub ax,bx	
      jz  dr2dl
	jmp show
dr2ur:
      mov word[x],10
      mov byte[rdul],Up_Rt	
      jmp show
dr2dl:
      mov word[y],38
      mov byte[rdul],Dn_Lt	
      jmp show

UpRt:
	dec word[x]
	inc word[y]
	
	mov bx,word[y]
	mov ax,40
	sub ax,bx
      jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],38
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
	mov ax,12
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
      mov word[y],1
      mov byte[rdul],Dn_Rt	
      jmp show
	
dl2ul:
      mov word[x],10
      mov byte[rdul],Up_Lt	
      jmp show
	
show:	
    xor ax,ax                 ; �����Դ��ַ
    mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2				;80*25������ һ���������ı�������*2���ֽ����
	mul bx
	mov bx,ax
	mov ah,byte[color]				
	mov al,byte[char]			;  AL = ��ʾ�ַ�ֵ��Ĭ��ֵΪ20h=�ո����
	mov [es:bx],ax  		;  ��ʾ�ַ���ASCII��ֵ
	
	inc byte[color]
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
	jmp loop1
_end:
    jmp $                   ; ֹͣ��������ѭ�� 
Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
     Up_Rt equ 2                  ;
     Up_Lt equ 3                  ;
     Dn_Lt equ 4                  ;
     delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
     ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
	MONITOR_ADDR equ 0x7c00
	
	MAX db 10
	count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; ��һ�������־
    x    dw 0 ; ��һ�������λ��
    y    dw -1 ;��һ�������λ��
	rdul1 db Up_Lt ; �ڶ��������־
	x1 dw 10 ; �ڶ��������λ��
	y1 dw 40 ;�ڶ��������λ��
    char db '0' ; ��ʾ�ַ�
	echar db 58 ; ��ʾ�ַ����н�����־
	color db 0 ; ��ʾ�ַ���ɫ
	current db 0 ;����ʾ�ַ���