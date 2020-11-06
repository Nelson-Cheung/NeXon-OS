; ����Դ���루stone.asm��
; ���������ı���ʽ��ʾ���ϴ�������һ��*��,��45���������˶���ײ���߿����,�������.
;  ��Ӧ�� 2014/3
;   MASM����ʽ
     Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
     Up_Rt equ 2                  ;
     Up_Lt equ 3                  ;
     Dn_Lt equ 4                  ;
     delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
     ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
;     .386
;     org 7c00h					; ������ص�100h������������COM/7c00H������������

jmp near start
	 
start:
	;xor ax,ax					; AX = 0   ������ص�0000��100h������ȷִ��
	mov ax,0x7c0                  ;�������ݶλ���ַ 
	mov ds,ax
;   mov ax,cs
;	mov es,ax					; ES = 0
;	mov ds,ax					; DS = CS
;	mov es,ax					; ES = CS
	mov ax,0B800h				; �ı������Դ���ʼ��ַ
	mov es,ax					; GS = B800h
    mov byte[char],'A'
loop1:
	dec word[count]				; �ݼ���������
	jnz loop1					; >0����ת;
	mov word[count],delay
	dec word[dcount]				; �ݼ��������� ����ѭ��
    jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay

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
      xor ax,ax                 ; �����Դ��ַ
      mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2				;80*25������ һ���������ı�������*2���ֽ����
	mul bx
	mov bx,ax
	mov ah,0Fh				;  0000���ڵס�1111�������֣�Ĭ��ֵΪ07h��
	mov al,byte[char]			;  AL = ��ʾ�ַ�ֵ��Ĭ��ֵΪ20h=�ո����
	mov [es:bx],ax  		;  ��ʾ�ַ���ASCII��ֵ
	jmp loop1
	
_end:
    jmp $                   ; ֹͣ��������ѭ�� 
	
datadef:	
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; �������˶�
    x    dw 7
    y    dw 0
    char db 'A'
	
;    ASSUME cs:code,ds:code
;   code SEGMENT

times 510-($-$$) db 0
			   db 0x55,0xaa
;code ENDS
;     END start
