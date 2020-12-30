%include "boot.inc"
section LOADER vstart=LOADER_START_ADDRESS   
    ;ds=0
    ;双字 dd dword 32位
    ;0#号空描述符
    mov dword [GDT_START_ADDRESS+0x00],0x00
    mov dword [GDT_START_ADDRESS+0x04],0x00  

    ;创建1#描述符，这是一个数据段，对应0~4GB的线性地址空间
    mov dword [GDT_START_ADDRESS+0x08],0x0000ffff    ;基地址为0，段界限为0xFFFFF
    mov dword [GDT_START_ADDRESS+0x0c],0x00cf9200    ;粒度为4KB，存储器段描述符 

    ;建立保护模式下的堆栈段描述符      ;基地址为0x00000000，界限0x0 
    mov dword [GDT_START_ADDRESS+0x10],0x00000000    ;粒度为1个字节
    mov dword [GDT_START_ADDRESS+0x14],0x00409600


    ;建立保护模式下的显示缓冲区描述符   
    mov dword [GDT_START_ADDRESS+0x18],0x80007fff    ;基地址为0x000B8000，界限0x07FFF 
    mov dword [GDT_START_ADDRESS+0x1c],0x0040920b    ;粒度为字节

    ;创建保护模式下平坦模式代码段描述符
    mov dword [GDT_START_ADDRESS+0x20],0x0000ffff
    mov dword [GDT_START_ADDRESS+0x24],0x00cf9800    ;粒度为4kb，代码段描述符 

    ;初始化描述符表寄存器GDTR
    mov word [pgdt],39      ;描述符表的界限   
 
    lgdt [pgdt]
      
    in al,0x92                         ;南桥芯片内的端口 
    or al,0000_0010B
    out 0x92,al                        ;打开A20

    cli                                ;中断机制尚未工作

    mov eax,cr0
    or eax,1
    mov cr0,eax                        ;设置PE位
      
    ;以下进入保护模式
    jmp dword CODE_SELECTOR:protect_mode_begin            
    ;16位的描述符选择子：32位偏移
    ;清流水线并串行化处理器
    [bits 32]               
protect_mode_begin:                              
    mov eax, DATA_SELECTOR                     ;加载数据段(0..4GB)选择子
    mov ds, eax
    mov es, eax
    mov eax, STACK_SELECTOR
    mov ss, eax
    mov eax, VIDEO_SELECTOR
    mov gs, eax

    call setup_page

    sgdt [pgdt]
    ; 更新视频段
    mov ebx, [pgdt+2]
    or dword [ebx+VIDEO_NUM+4], 0xc0000000

    add dword[pgdt+2], 0xc0000000
    add esp, 0xc0000000

    mov eax, PAGE_DIR_TABLE_POS
    mov cr3, eax

    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    lgdt[pgdt]

    mov byte [gs:160], 'V' 
    mov byte [gs:162], 'i' 
    mov byte [gs:164], 'r' 
    mov byte [gs:166], 't'
    mov byte [gs:168], 'u' 
    mov byte [gs:170], 'a' 
    mov byte [gs:172], 'l'

   call load_kernel
   jmp 0xc0020000
pgdt dw 0
     dd GDT_START_ADDRESS

setup_page:
;先把页目录占用的空间逐字节清0
   mov ecx, 4096
   mov esi, 0
.clear_page_dir:
   mov byte [PAGE_DIR_TABLE_POS + esi], 0
   inc esi
   loop .clear_page_dir

;开始创建页目录项(PDE)
.create_pde:				     ; 创建Page Directory Entry
   mov eax, PAGE_DIR_TABLE_POS
   add eax, 0x1000 			     ; 此时eax为第一个页表的位置及属性
   mov ebx, eax				     ; 此处为ebx赋值，是为.create_pte做准备，ebx为基址。

;   下面将页目录项0和0xc00都存为第一个页表的地址，
;   一个页表可表示4MB内存,这样0xc03fffff以下的地址和0x003fffff以下的地址都指向相同的页表，
;   这是为将地址映射为内核地址做准备
   or eax, 0x7	     ; 页目录项的属性RW和P位为1,US为1,表示用户属性,所有特权级别都可以访问.
   mov [PAGE_DIR_TABLE_POS + 0x0], eax       ; 第1个目录项,在页目录表中的第1个目录项写入第一个页表的位置(0x101000)及属性(7)
   mov [PAGE_DIR_TABLE_POS + 0xc00], eax     ; 一个页表项占用4字节,0xc00表示第768个页表占用的目录项,0xc00以上的目录项用于内核空间,
					     ; 也就是页表的0xc0000000~0xffffffff共计1G属于内核,0x0~0xbfffffff共计3G属于用户进程.
   sub eax, 0x1000
   mov [PAGE_DIR_TABLE_POS + 4092], eax	     ; 使最后一个目录项指向页目录表自己的地址

;下面创建页表项(PTE)
   mov ecx, 256				     ; 1M低端内存 / 每页大小4k = 256
   mov esi, 0
   mov edx, 0x7	     ; 属性为7,US=1,RW=1,P=1
.create_pte:				     ; 创建Page Table Entry
   mov [ebx+esi*4],edx			     ; 此时的ebx已经在上面通过eax赋值为0x101000,也就是第一个页表的地址 
   add edx,4096      ; edx
   inc esi
   loop .create_pte

;创建内核其它页表的PDE
   mov eax, PAGE_DIR_TABLE_POS
   add eax, 0x2000 		     ; 此时eax为第二个页表的位置
   or eax, 0x7  ; 页目录项的属性US,RW和P位都为1
   mov ebx, PAGE_DIR_TABLE_POS
   mov ecx, 254			     ; 范围为第769~1022的所有目录项数量
   mov esi, 769
.create_kernel_pde:
   mov [ebx+esi*4], eax
   inc esi
   add eax, 0x1000
   loop .create_kernel_pde
   ret

load_kernel:
   pushad

   mov ecx, KERNEL_SECTOR_COUNT
   mov eax, KERNEL_START_SECTOR
   mov ebx, KERNEL_START_ADDRESS
.load_all_kernel:
   call read_hd
   inc eax
   loop .load_all_kernel

   popad
   ret
read_hd:                           
;从硬盘读取一个逻辑扇区
;EAX=逻辑扇区号
;DS:EBX=目标缓冲区地址
;返回：EBX=EBX+512
    push eax 
    push ecx
    push edx
      
    push eax
         
    mov dx,0x1f2
    mov al,1
    out dx,al   ;读取的扇区数

    inc dx  ;0x1f3
    pop eax
    out dx,al   ;LBA地址7~0

    inc dx  ;0x1f4
    mov cl,8
    shr eax,cl
    out dx,al   ;LBA地址15~8

    inc dx  ;0x1f5
    shr eax,cl
    out dx,al   ;LBA地址23~16

    inc dx  ;0x1f6
    shr eax,cl
    or al,0xe0  ;第一硬盘  LBA地址27~24
    out dx,al

    inc dx  ;0x1f7
    mov al,0x20 ;读命令
    out dx,al

    ;不忙，且硬盘已准备好数据传输 
  .waits:
    in al,dx
    and al,0x88
    cmp al,0x08
    jnz .waits                         
    

    ;总共要读取的字数s
    mov ecx,256                        
    mov dx,0x1f0
  .readw:
    in ax,dx
    mov [ebx],ax
    add ebx,2
    loop .readw

    pop edx
    pop ecx
    pop eax
      
    ret
