org  7c00h

Start:
	mov	ax, cs	       ; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       ; ���ݶ�
	mov ss, ax
	mov sp, ax
	mov ax, ds
	mov es, ax
	
	mov cl, 2 ;��ʼ������ ; ��ʼ���Ϊ1
preload:
	mov ax, 0
	mov al, cl
	sub ax, 2
	mul word[len]
	add ax, word[begin]
    ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
	mov bx, ax  ;ƫ�Ƶ�ַ; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 ; ���ܺ�
    mov al,1                 ;������
    mov dl,0                 ;�������� ; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 ;��ͷ�� ; ��ʼ���Ϊ0
    mov ch,0                 ;����� ; ��ʼ���Ϊ0
    int 13H ;                ���ö�����BIOS��13h����
    ; �û�����a.com�Ѽ��ص�ָ���ڴ�������
	inc cl
	mov ch, 6
	cmp ch, cl
	jne preload
loop2:
	call init
	call gets
	;����
    mov ah,0x00
    mov al,0x03
    int 0x10
	mov si, BUF
show:
	cmp byte[act_len], 0
	jne go_on
	mov cx, 2
	jmp preload
go_on:
	xor ax, ax
	mov al, [si]
	sub al, '0'
	mul word[len]
	add ax, word[begin]
	mov bx, ax
	shr ax, 4
	mov ds, ax
	
    call bx
	
	xor ax, ax
	mov ds, ax
	mov es, ax
	
	inc si
	dec byte[act_len]
	jmp show
AfterRun:
     jmp $                      ;����ѭ��	
	 
gets:
	mov byte[act_len], 0
loop1:
	call getchar
	; ���˼�
	cmp ax, BS
	jne else1
	call delete
	jmp loop1
else1: 
	; �س���
	cmp ax,ET
	jne else2
	ret
else2:
	call append
	cmp byte[act_len], BUF_LEN
	jne loop1
	ret
; ��ȡһ���ַ�,����ֵ��ax��
getchar:
	mov ah, 0x00
	int 16h
	ret
; ɾ���ַ�
delete:
	cmp byte[act_len], 0
	jnz else3
	ret
else3:
	dec byte[act_len]
	; ��ȡ���λ��
	mov ah, 0x03
	mov bh, 0
	int 10h
	; ������
	cmp dl, 0
	jne else4
	cmp dh, 0
	jnz else5
	ret
else5:
	dec dh
	mov dl, 79
	jmp reset
else4:
	dec dl
reset:
	mov ah, 0x02
	mov bh, 0
	int 10h
	
	; ɾ���ַ�
	mov cx, dx
	xor ax, ax
	mov al, ch
	mov bx, 80
	mul bx
	add al, cl
	mov bx, 2
	mul bx
	mov bx, 0xb800
	mov gs, bx
	mov di, ax
	mov word[gs:di], 0x0700
	ret
; �ڹ�괦��ʾ�ַ���д���ַ�
append:
	; д���ַ�
	xor bx, bx
	mov si, BUF
	mov bl, byte[act_len]
	add si, bx
	mov [si], al
	inc byte[act_len]
	; �ڹ�괦��ʾ�ַ�
	mov ah, 0x0e
	mov bx, 0x07
	int 10h
	ret
	
init:
	;����
    mov ah,0x00
    mov al,0x03
    int 0x10
	
	mov bp, start_msg
	mov	cx, st_msg_end - start_msg  ; CX = ������=9��
	mov dx, 0
	mov	ax, 1301h		 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
	mov	bx, 0007h		 ; ҳ��Ϊ0(BH = 0) �ڵװ���(BL = 07h)
	int	10h			 ; BIOS��10h���ܣ���ʾһ���ַ�
	
	mov ah, 0x02
	mov bh, 0
	mov dh, 12
	mov dl, 0
	int 10h
	ret	

len dw 200h
begin dw 8100h

BUF resb 8
BUF_LEN equ 8
act_len db 0

BS equ 0x0e08
ET equ 0x1c0d

start_msg db "name      floppy    memory    ",0x0d,0x0a
          db "lu.bin    0x200     0x8100    ",0x0d,0x0a
          db "ru.bin    0x400     0x8300    ",0x0d,0x0a
          db "ld.bin    0x600     0x8500    ",0x0d,0x0a
          db "rd.bin    0x800     0x8700    ",0x0d,0x0a
st_msg_end:

times 510-($-$$) db 0
db 0x55,0xaa

