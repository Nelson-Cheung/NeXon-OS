org 0x7c00

mov byte[si], 0
times 510 - ($-$$) db 0
				 dw 0xaa55