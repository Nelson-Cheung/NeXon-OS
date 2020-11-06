OffsetOfKernel equ  08100h

OffsetOfUserPrg1 equ  0A100h
OffsetOfUserPrg2 equ  0A300h
OffsetOfUserPrg3 equ  0A700h
OffsetOfUserPrg4 equ  0AB00h
Dn_Rt equ 1                 
Up_Rt equ 2                 
Up_Lt equ 3                 
Dn_Lt equ 4      
delay equ 10000
ddelay equ 580  
bigdelay equ 30000
; 用于在指定位置显示字符串，参数：(字符串首地址, 字符串字节数, 行数, 列数)
