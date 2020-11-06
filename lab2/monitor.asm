org  7c00h

Start:
	mov	ax, cs	       ; 置其他段寄存器值与CS相同
	mov	ds, ax	       ; 数据段
	mov ss, ax
	mov sp, ax
	mov ax, ds
	mov es, ax
	
	mov cl, 2 ;起始扇区号 ; 起始编号为1
preload:
	mov ax, 0
	mov al, cl
	sub ax, 2
	mul word[len]
	add ax, word[begin]
    ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
	mov bx, ax  ;偏移地址; 存放数据的内存偏移地址
    mov ah,2                 ; 功能号
    mov al,1                 ;扇区数
    mov dl,0                 ;驱动器号 ; 软盘为0，硬盘和U盘为80H
    mov dh,0                 ;磁头号 ; 起始编号为0
    mov ch,0                 ;柱面号 ; 起始编号为0
    int 13H ;                调用读磁盘BIOS的13h功能
    ; 用户程序a.com已加载到指定内存区域中
	inc cl
	mov ch, 6
	cmp ch, cl
	jne preload
loop2:
	call init
	call gets
	;清屏
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
     jmp $                      ;无限循环	
	 
gets:
	mov byte[act_len], 0
loop1:
	call getchar
	; 回退键
	cmp ax, BS
	jne else1
	call delete
	jmp loop1
else1: 
	; 回车键
	cmp ax,ET
	jne else2
	ret
else2:
	call append
	cmp byte[act_len], BUF_LEN
	jne loop1
	ret
; 读取一个字符,返回值在ax中
getchar:
	mov ah, 0x00
	int 16h
	ret
; 删除字符
delete:
	cmp byte[act_len], 0
	jnz else3
	ret
else3:
	dec byte[act_len]
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
; 在光标处显示字符和写入字符
append:
	; 写入字符
	xor bx, bx
	mov si, BUF
	mov bl, byte[act_len]
	add si, bx
	mov [si], al
	inc byte[act_len]
	; 在光标处显示字符
	mov ah, 0x0e
	mov bx, 0x07
	int 10h
	ret
	
init:
	;清屏
    mov ah,0x00
    mov al,0x03
    int 0x10
	
	mov bp, start_msg
	mov	cx, st_msg_end - start_msg  ; CX = 串长（=9）
	mov dx, 0
	mov	ax, 1301h		 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	bx, 0007h		 ; 页号为0(BH = 0) 黑底白字(BL = 07h)
	int	10h			 ; BIOS的10h功能：显示一行字符
	
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

