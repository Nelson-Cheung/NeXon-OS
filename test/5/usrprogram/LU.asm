%include "header.inc"
%include "utility.inc"

org 100h

left equ -1    
top equ -1     
right equ 40   
bottom equ 13
ori_x equ 7
ori_y equ 0
jmp near start
 
start:
	pusha
	call cls
	MOVE_VECTOR 09h,40h
	VECTOR_IN 09h,Ouch
	mov ax,cs                 
	mov ds,ax
	mov ax,0B800h			
	mov gs,ax				
    mov byte[char],'H'
	PRINT hint,hintlen,16,35
initialize:
    mov byte[color], 07h
    mov word[count], delay
    mov word[dcount], ddelay
    mov byte[rdul], Dn_Rt  ; 向右下运动
    mov word[x], ori_x
    mov word[y], ori_y
loop1:
	dec word[count]			
	jnz loop1				
	mov word[count],delay
	dec word[dcount]			
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



DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,bottom
	sub ax,bx
      jz  dr2ur
	mov bx,word[y]
	mov ax,right
	sub ax,bx	
      jz  dr2dl
	jmp show
dr2ur:
      mov word[x],bottom-2
      mov byte[rdul],Up_Rt	
      jmp show
dr2dl:
      mov word[y],right-2
      mov byte[rdul],Dn_Lt	
      jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,right
	sub ax,bx
      jz  ur2ul
	mov bx,word[x]
	mov ax,top
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],right-2
      mov byte[rdul],Up_Lt	
      jmp show
ur2dr:
      mov word[x],top+2
      mov byte[rdul],Dn_Rt	
      jmp show

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
    mov ax,top
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
    mov ax,left
	sub ax,bx
      jz  ul2ur
	jmp show

ul2dl:
    mov word[x],top+2
      mov byte[rdul],Dn_Lt	
      jmp show
ul2ur:
    mov word[y],left+2
      mov byte[rdul],Up_Rt	
      jmp show

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
    mov ax,left
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
    mov ax,bottom
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
    mov word[y],left+2
      mov byte[rdul],Dn_Rt	
      jmp show
	
dl2ul:
    mov word[x],bottom-2
      mov byte[rdul],Up_Lt	
      jmp show
	
show:	
      xor ax,ax                
      mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2			
	mul bx
	mov bx,ax
	mov ah,[color]
	dec byte[color]
	jz restoreColor
draw:
	mov al,byte[char]		
	mov [gs:bx],ax  
	mov ah, 01h
	int 16h
	jz Continue
	mov ah, 0
	int 16h
	cmp al,27
	; je OffsetOfKernel
	je _end
	

Continue:
	jmp loop1

restoreColor:
	mov byte[color], 07h
	jmp draw
_end:
	MOVE_VECTOR 40h,09h
	popa
	pop ax
	ret
	
cls:
    pusha
    mov ax, 0003h
    int 10h
    popa
    ret

datadef:	
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt        
    x    dw ori_x
    y    dw ori_y
    char db 'A'
	color db 07h
hint:
	 db 'LU is running.press Esc to return'
hintlen  equ ($-hint)

%include "ouch.asm"
times 1022-($-$$) db 0
			   db 0x55,0xaa
