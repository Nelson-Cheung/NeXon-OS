; 常量定义区
; _____________Loader__________________
; 加载器扇区数
LOADER_SECTOR_COUNT equ 5
; 加载器起始扇区
LOADER_START_SECTOR equ 1
; 加载器被加载地址
LOADER_START_ADDRESS equ 0x7e00
; ______________GDT_____________________
; GDT起始位置
GDT_START_ADDRESS equ 0x8800
;平坦模式数据段选择子
DATA_SELECTOR equ 0x8
;平坦模式栈段选择子
STACK_SELECTOR equ 0x10
;平坦模式视频段选择子
VIDEO_SELECTOR equ 0x18
VIDEO_NUM equ 0x18
;平坦模式代码段选择子
CODE_SELECTOR equ 0x20
TSS_SELECTOR equ 0x2b
USER_CODE_SELECTOR equ 0x33
USER_DATA_SELECTOR equ 0x3b


; __________Page__________
; 页目录表位置
PAGE_DIR_TABLE_POS equ 0x100000
; __________kernel_________
KERNEL_START_SECTOR equ 6
KERNEL_SECTOR_COUNT equ 95
KERNEL_START_ADDRESS equ 0x20000
; _________IDT_______________
IDT_START_ADDRESS equ 0xc0018800