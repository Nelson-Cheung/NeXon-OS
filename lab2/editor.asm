gets:
	push bp
	
	sub sp, 6

	mov word[bp-2], ax
	mov word[bp-4], word[bp+4]
	mov word[bp-6], 0
	push ax
	push bx
	push cx
	push dx
	
	cmp word[bp+4], 0
	je return
	
loop1:
	call getchar
	
	mov bx,ax
	; 回退键
	cmp ax, BS
	jne else1
	call delete
	jmp loop1
else1: 
	; 回车键
	cmp ax,ET
	jne else2
	jmp return
else2:
	call append
	
	cmp word[bp+6], word[bp+4]
	je return
	jmp loop1
; 读取一个字符
getchar:
	mov ah, 0x00
	int 16h
	ret
; 在光标处显示字符和写入字符
append:
	; 写入字符
	mov si, [bp+6]
	add si, [bp+2]
	mov [si], al
	inc word[bp+2]
	; 在光标处显示字符
	mov ah, 0x0e
	mov bx, 0x07
	int 10h
	ret
; 删除字符
delete:
	cmp word[bp+6], 0
	jnz else3
	ret
else3:
	dec word[bp+6]
	; 读取光标位置
	mov ah, 0x03
	mov bh, 0
	int 10h
	; 光标回退
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
	
	; 删除字符
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

return:
	mov si, [bp+2]
	add si, [bp+6]
	mov [si], 0

	push dx
	push cx
	push bx
	push ax
	push bp	
BS equ 0x0e08
ET equ 0x1c0d

times 510-($-$$) db 0
                 db 0x55,0xaa