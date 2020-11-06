;键盘中断的处理
key_interrupt:
                            pushad
			xor eax,eax
			  
                             mov al,0x20                        ;中断结束命令EOI
                            out 0xa0,al                        ;向8259A从片发送
                                 out 0x20,al
			  
                             mov al,0xAD                        ;关闭键盘
			  out 0x64,al
			  
			  ;获取状态
			  in al,0x64
			  test al,0x01
			  jz .end                            ;结束 输出缓冲区没有内容
			  
			  
			  in al,0x60                         ;读取数据
			  test al,0x80
			  jnz .end
			  
			  mov ecx,eax
                             ;得到数据段的地址
                                  mov eax,core_data_seg_sel
                             mov ds,eax
                             mov ebx,key_map
                             mov byte cl,[ebx+ecx]			  
 
			  call put_char
			  
        .end:	
                             mov al,0xAE                        ;开启键盘
			  out 0x64,al
			  
			  popad
                             iret