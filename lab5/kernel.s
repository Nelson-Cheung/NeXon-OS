	.file	"kernel.cpp"
	.text
	.globl	_Z15CreateFileEntryPhP9FileEntry
	.type	_Z15CreateFileEntryPhP9FileEntry, @function
_Z15CreateFileEntryPhP9FileEntry:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L7:
	cmpl	$31, -4(%ebp)
	ja	.L8
	cmpl	$10, -4(%ebp)
	ja	.L3
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movl	12(%ebp), %ecx
	movl	-4(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	jmp	.L4
.L3:
	cmpl	$14, -4(%ebp)
	ja	.L5
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	-11(%edx), %ecx
	movb	(%eax), %dl
	movl	12(%ebp), %eax
	movb	%dl, 11(%eax,%ecx)
	jmp	.L4
.L5:
	cmpl	$16, -4(%ebp)
	ja	.L6
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	-15(%edx), %ecx
	movb	(%eax), %dl
	movl	12(%ebp), %eax
	movb	%dl, 15(%eax,%ecx)
	jmp	.L4
.L6:
	cmpl	$31, -4(%ebp)
	ja	.L4
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	-17(%edx), %ecx
	movb	(%eax), %dl
	movl	12(%ebp), %eax
	movb	%dl, 17(%eax,%ecx)
.L4:
	incl	-4(%ebp)
	jmp	.L7
.L8:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	_Z15CreateFileEntryPhP9FileEntry, .-_Z15CreateFileEntryPhP9FileEntry
	.globl	_Z10BytesToDecPhj
	.type	_Z10BytesToDecPhj, @function
_Z10BytesToDecPhj:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	cmpl	$0, 12(%ebp)
	jne	.L10
	movl	$0, %eax
	jmp	.L11
.L10:
	movl	$0, -4(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -8(%ebp)
.L13:
	decl	-8(%ebp)
	movl	-4(%ebp), %eax
	sall	$8, %eax
	movl	%eax, %ecx
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	addl	%ecx, %eax
	movl	%eax, -4(%ebp)
	cmpl	$0, -8(%ebp)
	je	.L12
	jmp	.L13
.L12:
	movl	-4(%ebp), %eax
.L11:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	_Z10BytesToDecPhj, .-_Z10BytesToDecPhj
	.globl	_Z7bcd2intj
	.type	_Z7bcd2intj, @function
_Z7bcd2intj:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$48, %esp
	movl	$0, -4(%ebp)
	movl	$0, -8(%ebp)
.L16:
	cmpl	$7, -8(%ebp)
	jg	.L15
	movl	8(%ebp), %eax
	andl	$15, %eax
	movl	%eax, %edx
	movl	-8(%ebp), %eax
	movl	%edx, -44(%ebp,%eax,4)
	shrl	$4, 8(%ebp)
	incl	-8(%ebp)
	jmp	.L16
.L15:
	movl	$7, -12(%ebp)
.L18:
	cmpl	$0, -12(%ebp)
	js	.L17
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	-44(%ebp,%eax,4), %eax
	addl	%edx, %eax
	movl	%eax, -4(%ebp)
	decl	-12(%ebp)
	jmp	.L18
.L17:
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	_Z7bcd2intj, .-_Z7bcd2intj
	.globl	_Z7PutCharj
	.type	_Z7PutCharj, @function
_Z7PutCharj:
.LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	sys_putc
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	_Z7PutCharj, .-_Z7PutCharj
	.globl	_Z7GetCharv
	.type	_Z7GetCharv, @function
_Z7GetCharv:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	sys_getc
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	_Z7GetCharv, .-_Z7GetCharv
	.globl	_Z10MoveCursorj
	.type	_Z10MoveCursorj, @function
_Z10MoveCursorj:
.LFB5:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	sys_move_cursor
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	_Z10MoveCursorj, .-_Z10MoveCursorj
	.globl	_Z9GetCursorv
	.type	_Z9GetCursorv, @function
_Z9GetCursorv:
.LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	sys_get_cursor
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	_Z9GetCursorv, .-_Z9GetCursorv
	.globl	_Z4PutshPh
	.type	_Z4PutshPh, @function
_Z4PutshPh:
.LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	8(%ebp), %eax
	movb	%al, -28(%ebp)
	movl	$0, -12(%ebp)
.L30:
	movl	12(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L31
	movl	12(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	.L28
	call	_Z7NewLinev
	jmp	.L29
.L28:
	movzbl	-28(%ebp), %eax
	sall	$8, %eax
	movl	%eax, -16(%ebp)
	movl	12(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	orl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
.L29:
	incl	-12(%ebp)
	jmp	.L30
.L31:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	_Z4PutshPh, .-_Z4PutshPh
	.globl	_Z5Clearv
	.type	_Z5Clearv, @function
_Z5Clearv:
.LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$0, -12(%ebp)
	subl	$12, %esp
	pushl	$0
	call	_Z10MoveCursorj
	addl	$16, %esp
.L34:
	cmpl	$1999, -12(%ebp)
	ja	.L33
	subl	$12, %esp
	pushl	$1792
	call	_Z7PutCharj
	addl	$16, %esp
	incl	-12(%ebp)
	jmp	.L34
.L33:
	subl	$12, %esp
	pushl	$0
	call	_Z10MoveCursorj
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	_Z5Clearv, .-_Z5Clearv
	.globl	_Z7NewLinev
	.type	_Z7NewLinev, @function
_Z7NewLinev:
.LFB9:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_Z9GetCursorv
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	$-858993459, %edx
	mull	%edx
	movl	%edx, %eax
	shrl	$6, %eax
	movl	%eax, -12(%ebp)
	cmpl	$23, -12(%ebp)
	ja	.L36
	incl	-12(%ebp)
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	jmp	.L38
.L36:
	subl	$12, %esp
	pushl	$1999
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1792
	call	_Z7PutCharj
	addl	$16, %esp
.L38:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	_Z7NewLinev, .-_Z7NewLinev
	.globl	_Z4LoadPh
	.type	_Z4LoadPh, @function
_Z4LoadPh:
.LFB10:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	sys_load
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	_Z4LoadPh, .-_Z4LoadPh
	.globl	_Z4Putihj
	.type	_Z4Putihj, @function
_Z4Putihj:
.LFB11:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$72, %esp
	movl	8(%ebp), %eax
	movb	%al, -60(%ebp)
	cmpl	$0, 12(%ebp)
	jne	.L41
	movzbl	-60(%ebp), %eax
	sall	$8, %eax
	movl	%eax, -16(%ebp)
	orl	$48, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	jmp	.L47
.L41:
	movb	$0, -9(%ebp)
.L44:
	cmpl	$0, 12(%ebp)
	je	.L43
	movzbl	-60(%ebp), %eax
	sall	$8, %eax
	movl	%eax, -16(%ebp)
	movl	12(%ebp), %eax
	movl	$10, %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	addl	$48, %eax
	orl	%eax, -16(%ebp)
	movzbl	-9(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, -56(%ebp,%eax,4)
	incb	-9(%ebp)
	movl	12(%ebp), %eax
	movl	$-858993459, %edx
	mull	%edx
	movl	%edx, %eax
	shrl	$3, %eax
	movl	%eax, 12(%ebp)
	jmp	.L44
.L43:
	movb	-9(%ebp), %al
	movb	%al, -10(%ebp)
.L46:
	decb	-10(%ebp)
	movzbl	-10(%ebp), %eax
	movl	-56(%ebp,%eax,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7PutCharj
	addl	$16, %esp
	cmpb	$0, -10(%ebp)
	je	.L47
	jmp	.L46
.L47:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE11:
	.size	_Z4Putihj, .-_Z4Putihj
	.globl	_Z6ReadHDjPh
	.type	_Z6ReadHDjPh, @function
_Z6ReadHDjPh:
.LFB12:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	sys_read_hd
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE12:
	.size	_Z6ReadHDjPh, .-_Z6ReadHDjPh
	.globl	_Z6Rebootv
	.type	_Z6Rebootv, @function
_Z6Rebootv:
.LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	sys_reboot
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE13:
	.size	_Z6Rebootv, .-_Z6Rebootv
	.globl	_Z4Waitj
	.type	_Z4Waitj, @function
_Z4Waitj:
.LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
.L52:
	cmpl	$0, 8(%ebp)
	je	.L53
	decl	8(%ebp)
	jmp	.L52
.L53:
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	_Z4Waitj, .-_Z4Waitj
	.globl	PrintTime
	.type	PrintTime, @function
PrintTime:
.LFB15:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$1837, -12(%ebp)
	subl	$8, %esp
	pushl	$9
	pushl	$112
	call	_out_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	_in_port
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7bcd2intj
	addl	$16, %esp
	addl	$2000, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$8, %esp
	pushl	$8
	pushl	$112
	call	_out_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	_in_port
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7bcd2intj
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	movl	$1824, -12(%ebp)
	subl	$8, %esp
	pushl	$7
	pushl	$112
	call	_out_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	_in_port
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7bcd2intj
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	movl	$1850, -12(%ebp)
	subl	$8, %esp
	pushl	$4
	pushl	$112
	call	_out_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	_in_port
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7bcd2intj
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$8, %esp
	pushl	$2
	pushl	$112
	call	_out_port
	addl	$16, %esp
	subl	$12, %esp
	pushl	$113
	call	_in_port
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7bcd2intj
	addl	$16, %esp
	subl	$8, %esp
	pushl	%eax
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	call	_Z7NewLinev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE15:
	.size	PrintTime, .-PrintTime
	.globl	_Z12initKeyboardPh
	.type	_Z12initKeyboardPh, @function
_Z12initKeyboardPh:
.LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L57:
	cmpl	$255, -4(%ebp)
	jg	.L56
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	incl	-4(%ebp)
	jmp	.L57
.L56:
	movl	8(%ebp), %eax
	addl	$30, %eax
	movb	$97, (%eax)
	movl	8(%ebp), %eax
	addl	$48, %eax
	movb	$98, (%eax)
	movl	8(%ebp), %eax
	addl	$46, %eax
	movb	$99, (%eax)
	movl	8(%ebp), %eax
	addl	$32, %eax
	movb	$100, (%eax)
	movl	8(%ebp), %eax
	addl	$18, %eax
	movb	$101, (%eax)
	movl	8(%ebp), %eax
	addl	$33, %eax
	movb	$102, (%eax)
	movl	8(%ebp), %eax
	addl	$34, %eax
	movb	$103, (%eax)
	movl	8(%ebp), %eax
	addl	$35, %eax
	movb	$104, (%eax)
	movl	8(%ebp), %eax
	addl	$23, %eax
	movb	$105, (%eax)
	movl	8(%ebp), %eax
	addl	$36, %eax
	movb	$106, (%eax)
	movl	8(%ebp), %eax
	addl	$37, %eax
	movb	$107, (%eax)
	movl	8(%ebp), %eax
	addl	$38, %eax
	movb	$108, (%eax)
	movl	8(%ebp), %eax
	addl	$50, %eax
	movb	$109, (%eax)
	movl	8(%ebp), %eax
	addl	$49, %eax
	movb	$110, (%eax)
	movl	8(%ebp), %eax
	addl	$24, %eax
	movb	$111, (%eax)
	movl	8(%ebp), %eax
	addl	$25, %eax
	movb	$112, (%eax)
	movl	8(%ebp), %eax
	addl	$16, %eax
	movb	$113, (%eax)
	movl	8(%ebp), %eax
	addl	$19, %eax
	movb	$114, (%eax)
	movl	8(%ebp), %eax
	addl	$31, %eax
	movb	$115, (%eax)
	movl	8(%ebp), %eax
	addl	$20, %eax
	movb	$116, (%eax)
	movl	8(%ebp), %eax
	addl	$22, %eax
	movb	$117, (%eax)
	movl	8(%ebp), %eax
	addl	$47, %eax
	movb	$118, (%eax)
	movl	8(%ebp), %eax
	addl	$17, %eax
	movb	$119, (%eax)
	movl	8(%ebp), %eax
	addl	$45, %eax
	movb	$120, (%eax)
	movl	8(%ebp), %eax
	addl	$21, %eax
	movb	$121, (%eax)
	movl	8(%ebp), %eax
	addl	$44, %eax
	movb	$122, (%eax)
	movl	8(%ebp), %eax
	addl	$11, %eax
	movb	$48, (%eax)
	movl	8(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	8(%ebp), %eax
	addl	$3, %eax
	movb	$50, (%eax)
	movl	8(%ebp), %eax
	addl	$4, %eax
	movb	$51, (%eax)
	movl	8(%ebp), %eax
	addl	$5, %eax
	movb	$52, (%eax)
	movl	8(%ebp), %eax
	addl	$6, %eax
	movb	$53, (%eax)
	movl	8(%ebp), %eax
	addl	$7, %eax
	movb	$54, (%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movb	$55, (%eax)
	movl	8(%ebp), %eax
	addl	$9, %eax
	movb	$56, (%eax)
	movl	8(%ebp), %eax
	addl	$10, %eax
	movb	$57, (%eax)
	movl	8(%ebp), %eax
	addl	$57, %eax
	movb	$32, (%eax)
	movl	8(%ebp), %eax
	addl	$28, %eax
	movb	$13, (%eax)
	movl	8(%ebp), %eax
	addl	$14, %eax
	movb	$8, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE16:
	.size	_Z12initKeyboardPh, .-_Z12initKeyboardPh
	.globl	_Z6StrLenPh
	.type	_Z6StrLenPh, @function
_Z6StrLenPh:
.LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L60:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L59
	incl	-4(%ebp)
	jmp	.L60
.L59:
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE17:
	.size	_Z6StrLenPh, .-_Z6StrLenPh
	.globl	_Z9StrAppendPhS_
	.type	_Z9StrAppendPhS_, @function
_Z9StrAppendPhS_:
.LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	pushl	8(%ebp)
	call	_Z6StrLenPh
	addl	$4, %esp
	movl	%eax, -8(%ebp)
	movl	$0, -4(%ebp)
.L64:
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L63
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %ecx
	movl	-8(%ebp), %edx
	addl	%edx, %ecx
	movl	8(%ebp), %edx
	addl	%ecx, %edx
	movb	(%eax), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	jmp	.L64
.L63:
	movl	-4(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	_Z9StrAppendPhS_, .-_Z9StrAppendPhS_
	.globl	_Z10CharAppendPhh
	.type	_Z10CharAppendPhh, @function
_Z10CharAppendPhh:
.LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	movl	12(%ebp), %eax
	movb	%al, -20(%ebp)
	pushl	8(%ebp)
	call	_Z6StrLenPh
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%eax, %edx
	movb	-20(%ebp), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE19:
	.size	_Z10CharAppendPhh, .-_Z10CharAppendPhh
	.globl	_Z9StrAssignPhS_
	.type	_Z9StrAssignPhS_, @function
_Z9StrAssignPhS_:
.LFB20:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L68:
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L67
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %ecx
	movl	8(%ebp), %edx
	addl	%ecx, %edx
	movb	(%eax), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	jmp	.L68
.L67:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	_Z9StrAssignPhS_, .-_Z9StrAssignPhS_
	.globl	_Z8StrEqualPhS_
	.type	_Z8StrEqualPhS_, @function
_Z8StrEqualPhS_:
.LFB21:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 3, -12
	pushl	8(%ebp)
	call	_Z6StrLenPh
	addl	$4, %esp
	movl	%eax, %ebx
	pushl	12(%ebp)
	call	_Z6StrLenPh
	addl	$4, %esp
	cmpl	%eax, %ebx
	setne	%al
	testb	%al, %al
	je	.L70
	movl	$0, %eax
	jmp	.L71
.L70:
	movl	$0, -8(%ebp)
.L74:
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L72
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %dl
	movl	12(%ebp), %ecx
	movl	-8(%ebp), %eax
	addl	%ecx, %eax
	movb	(%eax), %al
	cmpb	%al, %dl
	je	.L73
	movl	$0, %eax
	jmp	.L71
.L73:
	incl	-8(%ebp)
	jmp	.L74
.L72:
	movl	$1, %eax
.L71:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	_Z8StrEqualPhS_, .-_Z8StrEqualPhS_
	.globl	_Z7FirstInhPh
	.type	_Z7FirstInhPh, @function
_Z7FirstInhPh:
.LFB22:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	movl	8(%ebp), %eax
	movb	%al, -20(%ebp)
	movl	$0, -4(%ebp)
.L77:
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L76
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	%al, -20(%ebp)
	je	.L76
	incl	-4(%ebp)
	jmp	.L77
.L76:
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	_Z7FirstInhPh, .-_Z7FirstInhPh
	.globl	_Z7ToLowerPh
	.type	_Z7ToLowerPh, @function
_Z7ToLowerPh:
.LFB23:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L82:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L83
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$64, %al
	jbe	.L81
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$90, %al
	ja	.L81
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %dl
	movl	8(%ebp), %ecx
	movl	-4(%ebp), %eax
	addl	%ecx, %eax
	addl	$32, %edx
	movb	%dl, (%eax)
.L81:
	incl	-4(%ebp)
	jmp	.L82
.L83:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	_Z7ToLowerPh, .-_Z7ToLowerPh
	.globl	_Z5ToIntPKh
	.type	_Z5ToIntPKh, @function
_Z5ToIntPKh:
.LFB24:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -8(%ebp)
	movl	$0, -4(%ebp)
.L86:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L85
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %ecx
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	addl	%ecx, %eax
	subl	$48, %eax
	movl	%eax, -8(%ebp)
	incl	-4(%ebp)
	jmp	.L86
.L85:
	movl	-8(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	_Z5ToIntPKh, .-_Z5ToIntPKh
	.globl	message
	.data
	.align 4
	.type	message, @object
	.size	message, 28
message:
	.byte	78
	.byte	83
	.byte	78
	.byte	79
	.byte	83
	.byte	32
	.byte	48
	.byte	46
	.byte	48
	.byte	44
	.byte	32
	.byte	112
	.byte	111
	.byte	119
	.byte	101
	.byte	114
	.byte	101
	.byte	100
	.byte	32
	.byte	98
	.byte	121
	.byte	32
	.byte	78
	.byte	67
	.byte	111
	.byte	114
	.byte	101
	.byte	0
	.globl	msgLen
	.align 4
	.type	msgLen, @object
	.size	msgLen, 4
msgLen:
	.long	27
	.globl	start
	.align 4
	.type	start, @object
	.size	start, 4
start:
	.long	106
	.globl	timeInterruptCount
	.align 4
	.type	timeInterruptCount, @object
	.size	timeInterruptCount, 4
timeInterruptCount:
	.long	3
	.text
	.globl	KeyboardInterruptResponse
	.type	KeyboardInterruptResponse, @function
KeyboardInterruptResponse:
.LFB25:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_Z9GetCursorv
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	$1920
	call	_Z10MoveCursorj
	addl	$16, %esp
	movl	8(%ebp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L89
	movl	$1792, -16(%ebp)
	andl	$65280, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	jmp	.L90
.L89:
	movl	$3328, -16(%ebp)
	andl	$65280, -16(%ebp)
	orl	$116, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$121, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$112, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$105, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$110, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$103, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$46, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$46, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	andl	$65280, -16(%ebp)
	orl	$46, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
.L90:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	KeyboardInterruptResponse, .-KeyboardInterruptResponse
	.globl	TimeInterruptResponse
	.type	TimeInterruptResponse, @function
TimeInterruptResponse:
.LFB26:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	timeInterruptCount, %eax
	cmpl	$1, %eax
	jbe	.L92
	movl	timeInterruptCount, %eax
	decl	%eax
	movl	%eax, timeInterruptCount
	jmp	.L91
.L92:
	movl	$0, timeInterruptCount
	pushl	$message
	call	_Z6StrLenPh
	addl	$4, %esp
	movl	%eax, -16(%ebp)
	call	_Z9GetCursorv
	movl	%eax, -20(%ebp)
	movl	start, %eax
	testl	%eax, %eax
	jne	.L94
	movl	msgLen, %eax
	addl	$79, %eax
	movl	%eax, start
	subl	$12, %esp
	pushl	$0
	call	_Z10MoveCursorj
	addl	$16, %esp
	movl	$1792, -24(%ebp)
	orl	$32, -24(%ebp)
	subl	$12, %esp
	pushl	-24(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
.L94:
	movl	start, %edx
	movl	msgLen, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	_Z3maxjj
	addl	$16, %esp
	movl	%eax, %edx
	movl	start, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -28(%ebp)
	movl	start, %edx
	movl	msgLen, %eax
	addl	%edx, %eax
	leal	-1(%eax), %edx
	movl	msgLen, %eax
	addl	$79, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	_Z3minjj
	addl	$16, %esp
	movl	%eax, %edx
	movl	start, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -32(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	start, %edx
	movl	msgLen, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	_Z3maxjj
	addl	$16, %esp
	movl	%eax, %edx
	movl	msgLen, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -36(%ebp)
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
.L96:
	movl	-12(%ebp), %eax
	cmpl	-32(%ebp), %eax
	ja	.L95
	movl	$2304, -24(%ebp)
	movl	-12(%ebp), %eax
	addl	$message, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	orl	%eax, -24(%ebp)
	subl	$12, %esp
	pushl	-24(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	incl	-12(%ebp)
	jmp	.L96
.L95:
	call	_Z9GetCursorv
	cmpl	$79, %eax
	setbe	%al
	testb	%al, %al
	je	.L97
	movl	$1792, -24(%ebp)
	orl	$32, -24(%ebp)
	subl	$12, %esp
	pushl	-24(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	jmp	.L95
.L97:
	subl	$12, %esp
	pushl	-20(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	movl	start, %eax
	decl	%eax
	movl	%eax, start
.L91:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	TimeInterruptResponse, .-TimeInterruptResponse
	.globl	Int38HResponse
	.type	Int38HResponse, @function
Int38HResponse:
.LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$542395977, -20(%ebp)
	movl	$4732979, -16(%ebp)
	call	_Z9GetCursorv
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	leal	-20(%ebp), %eax
	pushl	%eax
	call	_Z6StrLenPh
	addl	$16, %esp
	movl	$1999, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$8, %esp
	leal	-20(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE27:
	.size	Int38HResponse, .-Int38HResponse
	.globl	_Z3maxjj
	.type	_Z3maxjj, @function
_Z3maxjj:
.LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	.L100
	movl	8(%ebp), %eax
	jmp	.L102
.L100:
	movl	12(%ebp), %eax
.L102:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE28:
	.size	_Z3maxjj, .-_Z3maxjj
	.globl	_Z3minjj
	.type	_Z3minjj, @function
_Z3minjj:
.LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	.L104
	movl	12(%ebp), %eax
	jmp	.L106
.L104:
	movl	8(%ebp), %eax
.L106:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE29:
	.size	_Z3minjj, .-_Z3minjj
	.globl	_Z16CallInterrupt38Hv
	.type	_Z16CallInterrupt38Hv, @function
_Z16CallInterrupt38Hv:
.LFB30:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	_interrupt_38h
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE30:
	.size	_Z16CallInterrupt38Hv, .-_Z16CallInterrupt38Hv
	.globl	_Z16CallInterrupt36Hv
	.type	_Z16CallInterrupt36Hv, @function
_Z16CallInterrupt36Hv:
.LFB31:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	_interrupt_36h
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE31:
	.size	_Z16CallInterrupt36Hv, .-_Z16CallInterrupt36Hv
	.globl	_Z7IsSpacei
	.type	_Z7IsSpacei, @function
_Z7IsSpacei:
.LFB32:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	cmpl	$32, 8(%ebp)
	je	.L110
	cmpl	$9, 8(%ebp)
	je	.L110
	cmpl	$13, 8(%ebp)
	je	.L110
	cmpl	$10, 8(%ebp)
	je	.L110
	cmpl	$11, 8(%ebp)
	je	.L110
	cmpl	$12, 8(%ebp)
	jne	.L111
.L110:
	movb	$1, %al
	jmp	.L112
.L111:
	movb	$0, %al
.L112:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE32:
	.size	_Z7IsSpacei, .-_Z7IsSpacei
	.globl	_Z7IsDigiti
	.type	_Z7IsDigiti, @function
_Z7IsDigiti:
.LFB33:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	cmpl	$47, 8(%ebp)
	jle	.L115
	cmpl	$57, 8(%ebp)
	jg	.L115
	movb	$1, %al
	jmp	.L116
.L115:
	movb	$0, %al
.L116:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE33:
	.size	_Z7IsDigiti, .-_Z7IsDigiti
	.globl	_Z7getcharv
	.type	_Z7getcharv, @function
_Z7getcharv:
.LFB34:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$280, %esp
	leal	-268(%ebp), %eax
	pushl	%eax
	call	_Z12initKeyboardPh
	addl	$4, %esp
.L120:
	call	sys_getc
	movl	%eax, -12(%ebp)
	leal	-268(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	.L119
	jmp	.L120
.L119:
	leal	-268(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$13, -12(%ebp)
	jne	.L121
	call	_Z7NewLinev
	jmp	.L122
.L121:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z7putcharj
	addl	$16, %esp
.L122:
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE34:
	.size	_Z7getcharv, .-_Z7getcharv
	.globl	_Z7putcharj
	.type	_Z7putcharj, @function
_Z7putcharj:
.LFB35:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	cmpl	$10, 8(%ebp)
	je	.L125
	andl	$255, 8(%ebp)
	orl	$1792, 8(%ebp)
	subl	$12, %esp
	pushl	8(%ebp)
	call	sys_putc
	addl	$16, %esp
	jmp	.L127
.L125:
	call	_Z7NewLinev
.L127:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE35:
	.size	_Z7putcharj, .-_Z7putcharj
	.globl	_Z5scanfPKcz
	.type	_Z5scanfPKcz, @function
_Z5scanfPKcz:
.LFB36:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	leal	12(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	$0, -28(%ebp)
.L144:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L129
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$37, %al
	jne	.L130
	incl	8(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	.L131
	movl	-28(%ebp), %eax
	jmp	.L145
.L131:
	movl	-32(%ebp), %eax
	leal	4(%eax), %edx
	movl	%edx, -32(%ebp)
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	cmpl	$100, %eax
	je	.L134
	cmpl	$115, %eax
	je	.L135
	cmpl	$99, %eax
	je	.L136
	jmp	.L130
.L136:
	call	_Z7getcharv
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	jmp	.L130
.L134:
	call	_Z7getcharv
	movsbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	$0, -20(%ebp)
.L139:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7IsDigiti
	addl	$16, %esp
	testb	%al, %al
	je	.L138
	subl	$48, -16(%ebp)
	movl	-20(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -20(%ebp)
	call	_Z7getcharv
	movsbl	%al, %eax
	movl	%eax, -16(%ebp)
	jmp	.L139
.L138:
	movl	$0, -24(%ebp)
.L141:
	movl	-24(%ebp), %eax
	cmpl	$3, %eax
	ja	.L146
	movl	-20(%ebp), %eax
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	sarl	$8, -20(%ebp)
	incl	-24(%ebp)
	incl	-12(%ebp)
	jmp	.L141
.L135:
	call	_Z7getcharv
	movl	%eax, -16(%ebp)
.L143:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7IsSpacei
	addl	$16, %esp
	xorl	$1, %eax
	testb	%al, %al
	je	.L142
	movl	-16(%ebp), %eax
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	incl	-12(%ebp)
	call	_Z7getcharv
	movl	%eax, -16(%ebp)
	jmp	.L143
.L142:
	movl	-12(%ebp), %eax
	movb	$0, (%eax)
	jmp	.L130
.L146:
	nop
.L130:
	incl	8(%ebp)
	jmp	.L144
.L129:
	movl	-28(%ebp), %eax
.L145:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE36:
	.size	_Z5scanfPKcz, .-_Z5scanfPKcz
	.globl	_Z6printfPKcz
	.type	_Z6printfPKcz, @function
_Z6printfPKcz:
.LFB37:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	leal	12(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	$0, -12(%ebp)
	movl	$0, -16(%ebp)
.L162:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L148
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$37, %al
	je	.L149
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	.L150
	call	_Z7NewLinev
	jmp	.L151
.L150:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7putcharj
	addl	$16, %esp
.L151:
	incl	-16(%ebp)
	jmp	.L152
.L149:
	incl	8(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	cmpl	$99, %eax
	je	.L154
	cmpl	$99, %eax
	jg	.L155
	testl	%eax, %eax
	je	.L156
	jmp	.L152
.L155:
	cmpl	$100, %eax
	je	.L157
	cmpl	$115, %eax
	je	.L158
	jmp	.L152
.L156:
	movl	-16(%ebp), %eax
	jmp	.L163
.L157:
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	movl	%edx, -28(%ebp)
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	subl	$8, %esp
	pushl	$10
	pushl	%eax
	call	_Z9print_intjj
	addl	$16, %esp
	jmp	.L152
.L154:
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	movl	%edx, -28(%ebp)
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7putcharj
	addl	$16, %esp
	jmp	.L152
.L158:
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	movl	%edx, -28(%ebp)
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	$0, -12(%ebp)
.L161:
	movl	-20(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L164
	movl	-20(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7putcharj
	addl	$16, %esp
	incl	-12(%ebp)
	jmp	.L161
.L164:
	nop
.L152:
	incl	8(%ebp)
	jmp	.L162
.L148:
	movl	-16(%ebp), %eax
.L163:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE37:
	.size	_Z6printfPKcz, .-_Z6printfPKcz
	.globl	_Z9print_intjj
	.type	_Z9print_intjj, @function
_Z9print_intjj:
.LFB38:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	movl	%esp, %eax
	movl	%eax, %ebx
	movl	$32, -16(%ebp)
	movl	-16(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	%ecx, -20(%ebp)
	movl	%ecx, %eax
	incl	%eax
	sall	$2, %eax
	leal	3(%eax), %edx
	movl	$16, %eax
	decl	%eax
	addl	%edx, %eax
	movl	$16, %esi
	movl	$0, %edx
	divl	%esi
	imull	$16, %eax, %eax
	subl	%eax, %esp
	movl	%esp, %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	$0, (%eax)
	leal	4(%eax), %edx
	leal	-1(%ecx), %eax
.L167:
	testl	%eax, %eax
	js	.L166
	movl	$0, (%edx)
	addl	$4, %edx
	decl	%eax
	jmp	.L167
.L166:
	movl	$0, -12(%ebp)
.L169:
	cmpl	$0, 8(%ebp)
	je	.L168
	movl	8(%ebp), %eax
	movl	$0, %edx
	divl	12(%ebp)
	movl	%edx, %eax
	leal	48(%eax), %ecx
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%ecx, (%eax,%edx,4)
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	orb	$7, %ah
	movl	%eax, %ecx
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%ecx, (%eax,%edx,4)
	movl	8(%ebp), %eax
	movl	$0, %edx
	divl	12(%ebp)
	movl	%eax, 8(%ebp)
	incl	-12(%ebp)
	jmp	.L169
.L168:
	movl	-16(%ebp), %eax
	decl	%eax
	movl	%eax, -12(%ebp)
.L171:
	cmpl	$0, -12(%ebp)
	js	.L170
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	testl	%eax, %eax
	jne	.L170
	decl	-12(%ebp)
	jmp	.L171
.L170:
	cmpl	$0, -12(%ebp)
	jns	.L172
	subl	$12, %esp
	pushl	$48
	call	_Z7putcharj
	addl	$16, %esp
	jmp	.L173
.L172:
	cmpl	$0, -12(%ebp)
	js	.L173
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7putcharj
	addl	$16, %esp
	decl	-12(%ebp)
	jmp	.L172
.L173:
	movl	%ebx, %esp
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE38:
	.size	_Z9print_intjj, .-_Z9print_intjj
	.globl	Kernel
	.type	Kernel, @function
Kernel:
.LFB39:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	_Z5Clearv
	subl	$12, %esp
	pushl	$80
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$56
	call	_call_interrupt
	addl	$32, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE39:
	.size	Kernel, .-Kernel
	.section	.rodata
.LC0:
	.string	"reboot"
.LC1:
	.string	"nelsoncheung"
	.align 4
.LC2:
	.string	"invalid command or parameters!\n"
	.align 4
.LC3:
	.string	"load [...]: load program.\nclear: clear the whole screen.\nreboot: reboot NSNOS.\nls: list all the program in the disk.\nnelsoncheung: the information of the author\n"
	.align 4
.LC4:
	.byte	0x20,0x20,0x4e,0x65,0x6c,0x73,0x6f,0x6e,0x20,0x43,0x68,0x65,0x75
	.string	"ng, or zhangjunyu in Chinese, is the author of Nelson Core 0.0.\n  It takes Nelson 2 days to learn the protect mode, 3 days to program the core, oslib and shell.\n  If you have any comments or advice, please contact the author at zhangjunyu@nelson-cheung.cn\n"
.LC5:
	.string	"interrupt"
	.text
	.globl	_Z5parsePh
	.type	_Z5parsePh, @function
_Z5parsePh:
.LFB40:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$2588, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	$1684107116, -38(%ebp)
	movb	$0, -34(%ebp)
	movl	$1634036835, -44(%ebp)
	movw	$114, -40(%ebp)
	leal	-51(%ebp), %eax
	movl	$.LC0, %ebx
	movl	$7, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	movw	$29548, -54(%ebp)
	movb	$0, -52(%ebp)
	movl	$1886152040, -59(%ebp)
	movb	$0, -55(%ebp)
	leal	-72(%ebp), %eax
	movl	$.LC1, %ebx
	movl	$13, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-104(%ebp), %eax
	movl	$.LC2, %ebx
	movl	$8, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsl
	leal	-266(%ebp), %eax
	movl	$.LC3, %ebx
	movl	$162, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-536(%ebp), %eax
	movl	$.LC4, %ebx
	movl	$270, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-546(%ebp), %eax
	movl	$.LC5, %ebx
	movl	$10, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	pushl	8(%ebp)
	leal	-1571(%ebp), %eax
	pushl	%eax
	call	_Z9StrAssignPhS_
	addl	$8, %esp
	leal	-1571(%ebp), %eax
	pushl	%eax
	call	_Z7ToLowerPh
	addl	$4, %esp
	leal	-1571(%ebp), %eax
	pushl	%eax
	pushl	$32
	call	_Z7FirstInhPh
	addl	$8, %esp
	movl	%eax, -28(%ebp)
	leal	-1571(%ebp), %eax
	movl	%eax, -32(%ebp)
	leal	-1571(%ebp), %eax
	pushl	%eax
	call	_Z6StrLenPh
	addl	$4, %esp
	cmpl	%eax, -28(%ebp)
	setb	%al
	testb	%al, %al
	je	.L177
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
.L177:
	pushl	-32(%ebp)
	leal	-2596(%ebp), %eax
	pushl	%eax
	call	_Z9StrAssignPhS_
	addl	$8, %esp
	leal	-38(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$8, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	jne	.L185
	leal	-44(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$8, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L179
	call	_Z5Clearv
	subl	$12, %esp
	pushl	$80
	call	_Z10MoveCursorj
	addl	$16, %esp
	jmp	.L185
.L179:
	subl	$8, %esp
	leal	-51(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L180
	call	_Z6Rebootv
	jmp	.L185
.L180:
	subl	$8, %esp
	leal	-54(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L181
	call	_Z2Lsv
	jmp	.L185
.L181:
	subl	$8, %esp
	leal	-59(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L182
	subl	$8, %esp
	leal	-266(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L185
.L182:
	subl	$8, %esp
	leal	-72(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L183
	subl	$8, %esp
	leal	-536(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L185
.L183:
	subl	$8, %esp
	leal	-546(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L184
	call	_Z16CallInterrupt38Hv
	jmp	.L185
.L184:
	subl	$8, %esp
	leal	-104(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
.L185:
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE40:
	.size	_Z5parsePh, .-_Z5parsePh
	.globl	_Z2Lsv
	.type	_Z2Lsv, @function
_Z2Lsv:
.LFB41:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$600, %esp
	subl	$8, %esp
	leal	-532(%ebp), %eax
	pushl	%eax
	pushl	$80
	call	_Z6ReadHDjPh
	addl	$16, %esp
	movl	$0, -12(%ebp)
.L191:
	cmpl	$511, -12(%ebp)
	ja	.L192
	movl	$0, -16(%ebp)
.L189:
	cmpl	$31, -16(%ebp)
	ja	.L188
	movl	-16(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	-532(%ebp,%eax), %al
	leal	-564(%ebp), %ecx
	movl	-16(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	incl	-16(%ebp)
	jmp	.L189
.L188:
	movb	-564(%ebp), %al
	testb	%al, %al
	je	.L190
	subl	$8, %esp
	leal	-596(%ebp), %eax
	pushl	%eax
	leal	-564(%ebp), %eax
	pushl	%eax
	call	_Z15CreateFileEntryPhP9FileEntry
	addl	$16, %esp
	movb	$0, -586(%ebp)
	subl	$8, %esp
	leal	-596(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	movl	$1792, -20(%ebp)
	orl	$32, -20(%ebp)
	subl	$12, %esp
	pushl	-20(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$8, %esp
	pushl	$4
	leal	-596(%ebp), %eax
	addl	$11, %eax
	pushl	%eax
	call	_Z10BytesToDecPhj
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	movl	$1792, -20(%ebp)
	orl	$32, -20(%ebp)
	subl	$12, %esp
	pushl	-20(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$8, %esp
	pushl	$2
	leal	-596(%ebp), %eax
	addl	$15, %eax
	pushl	%eax
	call	_Z10BytesToDecPhj
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	$7
	call	_Z4Putihj
	addl	$16, %esp
	call	_Z7NewLinev
.L190:
	addl	$32, -12(%ebp)
	jmp	.L191
.L192:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE41:
	.size	_Z2Lsv, .-_Z2Lsv
	.section	.rodata
	.align 4
.LC6:
	.string	"kernel loading Done.\nNSNOS 0.0, from Nelson Core 0.0\nDo the last check...\n"
	.text
	.globl	_Z4initv
	.type	_Z4initv, @function
_Z4initv:
.LFB42:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$108, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	leal	-99(%ebp), %eax
	movl	$.LC6, %ebx
	movl	$75, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	movl	$1701736292, -105(%ebp)
	movw	$10, -101(%ebp)
	subl	$8, %esp
	leal	-99(%ebp), %eax
	pushl	%eax
	pushl	$3
	call	_Z4PutshPh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$268435442
	call	_Z4Waitj
	addl	$16, %esp
	subl	$8, %esp
	leal	-105(%ebp), %eax
	pushl	%eax
	pushl	$3
	call	_Z4PutshPh
	addl	$16, %esp
	subl	$12, %esp
	pushl	$16777215
	call	_Z4Waitj
	addl	$16, %esp
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE42:
	.size	_Z4initv, .-_Z4initv
	.ident	"GCC: (GNU) 7.1.0"
