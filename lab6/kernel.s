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
	.globl	PID
	.section	.bss
	.align 4
	.type	PID, @object
	.size	PID, 4
PID:
	.zero	4
	.globl	_all_threads
	.align 4
	.type	_all_threads, @object
	.size	_all_threads, 8
_all_threads:
	.zero	8
	.globl	_ready_threads
	.align 4
	.type	_ready_threads, @object
	.size	_ready_threads, 8
_ready_threads:
	.zero	8
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
	.globl	_Z7IsSpacei
	.type	_Z7IsSpacei, @function
_Z7IsSpacei:
.LFB26:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	cmpl	$32, 8(%ebp)
	je	.L92
	cmpl	$9, 8(%ebp)
	je	.L92
	cmpl	$13, 8(%ebp)
	je	.L92
	cmpl	$10, 8(%ebp)
	je	.L92
	cmpl	$11, 8(%ebp)
	je	.L92
	cmpl	$12, 8(%ebp)
	jne	.L93
.L92:
	movb	$1, %al
	jmp	.L94
.L93:
	movb	$0, %al
.L94:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	_Z7IsSpacei, .-_Z7IsSpacei
	.globl	_Z7IsDigiti
	.type	_Z7IsDigiti, @function
_Z7IsDigiti:
.LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	cmpl	$47, 8(%ebp)
	jle	.L97
	cmpl	$57, 8(%ebp)
	jg	.L97
	movb	$1, %al
	jmp	.L98
.L97:
	movb	$0, %al
.L98:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE27:
	.size	_Z7IsDigiti, .-_Z7IsDigiti
	.globl	_Z7getcharv
	.type	_Z7getcharv, @function
_Z7getcharv:
.LFB28:
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
.L102:
	call	sys_getc
	movl	%eax, -12(%ebp)
	leal	-268(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	.L101
	jmp	.L102
.L101:
	leal	-268(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$13, -12(%ebp)
	jne	.L103
	call	_Z7NewLinev
	jmp	.L104
.L103:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z7putcharj
	addl	$16, %esp
.L104:
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE28:
	.size	_Z7getcharv, .-_Z7getcharv
	.globl	_Z7putcharj
	.type	_Z7putcharj, @function
_Z7putcharj:
.LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	cmpl	$10, 8(%ebp)
	je	.L107
	andl	$255, 8(%ebp)
	orl	$1792, 8(%ebp)
	subl	$12, %esp
	pushl	8(%ebp)
	call	sys_putc
	addl	$16, %esp
	jmp	.L109
.L107:
	call	_Z7NewLinev
.L109:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE29:
	.size	_Z7putcharj, .-_Z7putcharj
	.globl	_Z5scanfPKcz
	.type	_Z5scanfPKcz, @function
_Z5scanfPKcz:
.LFB30:
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
.L126:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L111
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$37, %al
	jne	.L112
	incl	8(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	.L113
	movl	-28(%ebp), %eax
	jmp	.L127
.L113:
	movl	-32(%ebp), %eax
	leal	4(%eax), %edx
	movl	%edx, -32(%ebp)
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	cmpl	$100, %eax
	je	.L116
	cmpl	$115, %eax
	je	.L117
	cmpl	$99, %eax
	je	.L118
	jmp	.L112
.L118:
	call	_Z7getcharv
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	jmp	.L112
.L116:
	call	_Z7getcharv
	movsbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	$0, -20(%ebp)
.L121:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7IsDigiti
	addl	$16, %esp
	testb	%al, %al
	je	.L120
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
	jmp	.L121
.L120:
	movl	$0, -24(%ebp)
.L123:
	movl	-24(%ebp), %eax
	cmpl	$3, %eax
	ja	.L128
	movl	-20(%ebp), %eax
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	sarl	$8, -20(%ebp)
	incl	-24(%ebp)
	incl	-12(%ebp)
	jmp	.L123
.L117:
	call	_Z7getcharv
	movl	%eax, -16(%ebp)
.L125:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7IsSpacei
	addl	$16, %esp
	xorl	$1, %eax
	testb	%al, %al
	je	.L124
	movl	-16(%ebp), %eax
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	incl	-12(%ebp)
	call	_Z7getcharv
	movl	%eax, -16(%ebp)
	jmp	.L125
.L124:
	movl	-12(%ebp), %eax
	movb	$0, (%eax)
	jmp	.L112
.L128:
	nop
.L112:
	incl	8(%ebp)
	jmp	.L126
.L111:
	movl	-28(%ebp), %eax
.L127:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE30:
	.size	_Z5scanfPKcz, .-_Z5scanfPKcz
	.globl	_Z6printfPKcz
	.type	_Z6printfPKcz, @function
_Z6printfPKcz:
.LFB31:
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
.L144:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L130
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$37, %al
	je	.L131
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	.L132
	call	_Z7NewLinev
	jmp	.L133
.L132:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7putcharj
	addl	$16, %esp
.L133:
	incl	-16(%ebp)
	jmp	.L134
.L131:
	incl	8(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	cmpl	$99, %eax
	je	.L136
	cmpl	$99, %eax
	jg	.L137
	testl	%eax, %eax
	je	.L138
	jmp	.L134
.L137:
	cmpl	$100, %eax
	je	.L139
	cmpl	$115, %eax
	je	.L140
	jmp	.L134
.L138:
	movl	-16(%ebp), %eax
	jmp	.L145
.L139:
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
	jmp	.L134
.L136:
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
	jmp	.L134
.L140:
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	movl	%edx, -28(%ebp)
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	$0, -12(%ebp)
.L143:
	movl	-20(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L146
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
	jmp	.L143
.L146:
	nop
.L134:
	incl	8(%ebp)
	jmp	.L144
.L130:
	movl	-16(%ebp), %eax
.L145:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE31:
	.size	_Z6printfPKcz, .-_Z6printfPKcz
	.globl	_Z9print_intjj
	.type	_Z9print_intjj, @function
_Z9print_intjj:
.LFB32:
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
.L149:
	testl	%eax, %eax
	js	.L148
	movl	$0, (%edx)
	addl	$4, %edx
	decl	%eax
	jmp	.L149
.L148:
	movl	$0, -12(%ebp)
.L151:
	cmpl	$0, 8(%ebp)
	je	.L150
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
	jmp	.L151
.L150:
	movl	-16(%ebp), %eax
	decl	%eax
	movl	%eax, -12(%ebp)
.L153:
	cmpl	$0, -12(%ebp)
	js	.L152
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	testl	%eax, %eax
	jne	.L152
	decl	-12(%ebp)
	jmp	.L153
.L152:
	cmpl	$0, -12(%ebp)
	jns	.L154
	subl	$12, %esp
	pushl	$48
	call	_Z7putcharj
	addl	$16, %esp
	jmp	.L155
.L154:
	cmpl	$0, -12(%ebp)
	js	.L155
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7putcharj
	addl	$16, %esp
	decl	-12(%ebp)
	jmp	.L154
.L155:
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
.LFE32:
	.size	_Z9print_intjj, .-_Z9print_intjj
	.globl	TimeInterruptResponse
	.type	TimeInterruptResponse, @function
TimeInterruptResponse:
.LFB33:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$0, timeInterruptCount
	pushl	$message
	call	_Z6StrLenPh
	addl	$4, %esp
	movl	%eax, -16(%ebp)
	call	_Z9GetCursorv
	movl	%eax, -20(%ebp)
	movl	start, %eax
	testl	%eax, %eax
	jne	.L157
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
.L157:
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
.L159:
	movl	-12(%ebp), %eax
	cmpl	-32(%ebp), %eax
	ja	.L158
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
	jmp	.L159
.L158:
	call	_Z9GetCursorv
	cmpl	$79, %eax
	setbe	%al
	testb	%al, %al
	je	.L160
	movl	$1792, -24(%ebp)
	orl	$32, -24(%ebp)
	subl	$12, %esp
	pushl	-24(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	jmp	.L158
.L160:
	subl	$12, %esp
	pushl	-20(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	movl	start, %eax
	decl	%eax
	movl	%eax, start
	call	_running_thread
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	16(%eax), %eax
	leal	-1(%eax), %edx
	movl	-40(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	-40(%ebp), %eax
	movl	20(%eax), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	-40(%ebp), %eax
	movl	16(%eax), %eax
	testl	%eax, %eax
	jne	.L162
	call	_Z16_schedule_threadv
.L162:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE33:
	.size	TimeInterruptResponse, .-TimeInterruptResponse
	.globl	Int38HResponse
	.type	Int38HResponse, @function
Int38HResponse:
.LFB34:
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
.LFE34:
	.size	Int38HResponse, .-Int38HResponse
	.globl	_Z3maxjj
	.type	_Z3maxjj, @function
_Z3maxjj:
.LFB35:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	.L165
	movl	8(%ebp), %eax
	jmp	.L167
.L165:
	movl	12(%ebp), %eax
.L167:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE35:
	.size	_Z3maxjj, .-_Z3maxjj
	.globl	_Z3minjj
	.type	_Z3minjj, @function
_Z3minjj:
.LFB36:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	.L169
	movl	12(%ebp), %eax
	jmp	.L171
.L169:
	movl	8(%ebp), %eax
.L171:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE36:
	.size	_Z3minjj, .-_Z3minjj
	.globl	_Z16CallInterrupt38Hv
	.type	_Z16CallInterrupt38Hv, @function
_Z16CallInterrupt38Hv:
.LFB37:
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
.LFE37:
	.size	_Z16CallInterrupt38Hv, .-_Z16CallInterrupt38Hv
	.globl	_Z16CallInterrupt36Hv
	.type	_Z16CallInterrupt36Hv, @function
_Z16CallInterrupt36Hv:
.LFB38:
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
.LFE38:
	.size	_Z16CallInterrupt36Hv, .-_Z16CallInterrupt36Hv
	.globl	_Z14_set_interruptb
	.type	_Z14_set_interruptb, @function
_Z14_set_interruptb:
.LFB39:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	8(%ebp), %eax
	movb	%al, -12(%ebp)
	cmpb	$0, -12(%ebp)
	je	.L175
	call	_enable_interrupt
	jmp	.L177
.L175:
	call	_disable_interrupt
.L177:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE39:
	.size	_Z14_set_interruptb, .-_Z14_set_interruptb
	.align 2
	.globl	_ZN6BitMapC2Ev
	.type	_ZN6BitMapC2Ev, @function
_ZN6BitMapC2Ev:
.LFB41:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	movl	$0, 4(%eax)
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE41:
	.size	_ZN6BitMapC2Ev, .-_ZN6BitMapC2Ev
	.globl	_ZN6BitMapC1Ev
	.set	_ZN6BitMapC1Ev,_ZN6BitMapC2Ev
	.align 2
	.globl	_ZN6BitMap9setBitMapEPhj
	.type	_ZN6BitMap9setBitMapEPhj, @function
_ZN6BitMap9setBitMapEPhj:
.LFB43:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, -4(%ebp)
	movl	16(%ebp), %eax
	andl	$7, %eax
	testl	%eax, %eax
	je	.L180
	incl	-4(%ebp)
.L180:
	movl	$0, -8(%ebp)
.L182:
	movl	-8(%ebp), %eax
	cmpl	%eax, -4(%ebp)
	jbe	.L183
	movl	-8(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	incl	-8(%ebp)
	jmp	.L182
.L183:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE43:
	.size	_ZN6BitMap9setBitMapEPhj, .-_ZN6BitMap9setBitMapEPhj
	.align 2
	.globl	_ZN6BitMap3getEj
	.type	_ZN6BitMap3getEj, @function
_ZN6BitMap3getEj:
.LFB44:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	12(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, -4(%ebp)
	movl	12(%ebp), %eax
	notl	%eax
	andl	$7, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	$1, %edx
	movb	%al, %cl
	sall	%cl, %edx
	movl	%edx, %eax
	movb	%al, -9(%ebp)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	andb	-9(%ebp), %al
	testb	%al, %al
	setne	%al
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE44:
	.size	_ZN6BitMap3getEj, .-_ZN6BitMap3getEj
	.align 2
	.globl	_ZN6BitMap3setEjb
	.type	_ZN6BitMap3setEjb, @function
_ZN6BitMap3setEjb:
.LFB45:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	movl	16(%ebp), %eax
	movb	%al, -20(%ebp)
	movl	12(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, -12(%ebp)
	movl	12(%ebp), %eax
	notl	%eax
	andl	$7, %eax
	movl	%eax, -16(%ebp)
	movb	$-2, -1(%ebp)
	movl	$0, -8(%ebp)
.L188:
	movl	-8(%ebp), %eax
	cmpl	%eax, -16(%ebp)
	jbe	.L187
	movb	-1(%ebp), %al
	sall	%eax
	incl	%eax
	movb	%al, -1(%ebp)
	incl	-8(%ebp)
	jmp	.L188
.L187:
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movl	8(%ebp), %edx
	movl	4(%edx), %ecx
	movl	-12(%ebp), %edx
	addl	%ecx, %edx
	andb	-1(%ebp), %al
	movb	%al, (%edx)
	movzbl	-20(%ebp), %edx
	movl	-16(%ebp), %eax
	movb	%al, %cl
	sall	%cl, %edx
	movl	%edx, %eax
	movb	%al, -1(%ebp)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movl	8(%ebp), %edx
	movl	4(%edx), %ecx
	movl	-12(%ebp), %edx
	addl	%ecx, %edx
	orb	-1(%ebp), %al
	movb	%al, (%edx)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE45:
	.size	_ZN6BitMap3setEjb, .-_ZN6BitMap3setEjb
	.align 2
	.globl	_ZN6BitMap8allocateEj
	.type	_ZN6BitMap8allocateEj, @function
_ZN6BitMap8allocateEj:
.LFB46:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	cmpl	$0, 12(%ebp)
	jne	.L190
	movl	$-1, %eax
	jmp	.L191
.L190:
	movl	$0, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jnb	.L192
.L196:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jnb	.L193
	pushl	-4(%ebp)
	pushl	8(%ebp)
	call	_ZN6BitMap3getEj
	addl	$8, %esp
	testb	%al, %al
	je	.L193
	movb	$1, %al
	jmp	.L194
.L193:
	movb	$0, %al
.L194:
	testb	%al, %al
	je	.L195
	incl	-4(%ebp)
	jmp	.L196
.L195:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jne	.L197
	movl	$-1, %eax
	jmp	.L191
.L197:
	movl	$0, -8(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, -16(%ebp)
.L201:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jnb	.L198
	pushl	-4(%ebp)
	pushl	8(%ebp)
	call	_ZN6BitMap3getEj
	addl	$8, %esp
	xorl	$1, %eax
	testb	%al, %al
	je	.L198
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jnb	.L198
	movb	$1, %al
	jmp	.L199
.L198:
	movb	$0, %al
.L199:
	testb	%al, %al
	je	.L200
	incl	-8(%ebp)
	incl	-4(%ebp)
	jmp	.L201
.L200:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jne	.L202
	movl	$0, -12(%ebp)
.L204:
	movl	-12(%ebp), %eax
	cmpl	%eax, 12(%ebp)
	jbe	.L202
	movl	-12(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	pushl	$1
	pushl	%eax
	pushl	8(%ebp)
	call	_ZN6BitMap3setEjb
	addl	$12, %esp
	incl	-12(%ebp)
	jmp	.L204
.L202:
	movl	-16(%ebp), %eax
	jmp	.L191
.L192:
	movl	$-1, %eax
.L191:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE46:
	.size	_ZN6BitMap8allocateEj, .-_ZN6BitMap8allocateEj
	.align 2
	.globl	_ZN6BitMap7releaseEjj
	.type	_ZN6BitMap7releaseEjj, @function
_ZN6BitMap7releaseEjj:
.LFB47:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L207:
	movl	-4(%ebp), %eax
	cmpl	%eax, 16(%ebp)
	jbe	.L208
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	pushl	$0
	pushl	%eax
	pushl	8(%ebp)
	call	_ZN6BitMap3setEjb
	addl	$12, %esp
	incl	-4(%ebp)
	jmp	.L207
.L208:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE47:
	.size	_ZN6BitMap7releaseEjj, .-_ZN6BitMap7releaseEjj
	.globl	kernelVrirtualPool
	.section	.bss
	.align 4
	.type	kernelVrirtualPool, @object
	.size	kernelVrirtualPool, 12
kernelVrirtualPool:
	.zero	12
	.globl	kernelPool
	.align 4
	.type	kernelPool, @object
	.size	kernelPool, 12
kernelPool:
	.zero	12
	.globl	userPool
	.align 4
	.type	userPool, @object
	.size	userPool, 12
userPool:
	.zero	12
	.text
	.align 2
	.globl	_ZN11AddressPoolC2Ev
	.type	_ZN11AddressPoolC2Ev, @function
_ZN11AddressPoolC2Ev:
.LFB49:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	pushl	%eax
	call	_ZN6BitMapC1Ev
	addl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE49:
	.size	_ZN11AddressPoolC2Ev, .-_ZN11AddressPoolC2Ev
	.globl	_ZN11AddressPoolC1Ev
	.set	_ZN11AddressPoolC1Ev,_ZN11AddressPoolC2Ev
	.align 2
	.globl	_ZN11AddressPool12setResourcesEPhj
	.type	_ZN11AddressPool12setResourcesEPhj, @function
_ZN11AddressPool12setResourcesEPhj:
.LFB51:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	pushl	16(%ebp)
	pushl	12(%ebp)
	pushl	%eax
	call	_ZN6BitMap9setBitMapEPhj
	addl	$12, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE51:
	.size	_ZN11AddressPool12setResourcesEPhj, .-_ZN11AddressPool12setResourcesEPhj
	.align 2
	.globl	_ZN11AddressPool15setStartAddressEj
	.type	_ZN11AddressPool15setStartAddressEj, @function
_ZN11AddressPool15setStartAddressEj:
.LFB52:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%eax)
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE52:
	.size	_ZN11AddressPool15setStartAddressEj, .-_ZN11AddressPool15setStartAddressEj
	.align 2
	.globl	_ZN11AddressPool8allocateEj
	.type	_ZN11AddressPool8allocateEj, @function
_ZN11AddressPool8allocateEj:
.LFB53:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	pushl	12(%ebp)
	pushl	%eax
	call	_ZN6BitMap8allocateEj
	addl	$8, %esp
	movl	%eax, -4(%ebp)
	cmpl	$-1, -4(%ebp)
	je	.L213
	movl	-4(%ebp), %eax
	sall	$12, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	addl	%edx, %eax
	jmp	.L215
.L213:
	movl	$-1, %eax
.L215:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE53:
	.size	_ZN11AddressPool8allocateEj, .-_ZN11AddressPool8allocateEj
	.section	.rodata
	.align 4
.LC0:
	.string	"kernel pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n"
	.align 4
.LC1:
	.string	"user pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n"
	.align 4
.LC2:
	.string	"kernel virtual pool\n    start address: %d\n    total pages: %d\n    bit map start address: %d\n"
	.text
	.globl	_Z14initMemoryPoolj
	.type	_Z14initMemoryPoolj, @function
_Z14initMemoryPoolj:
.LFB54:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	$2097152, -20(%ebp)
	movl	8(%ebp), %eax
	subl	-20(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	shrl	$12, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	shrl	%eax
	movl	%eax, -32(%ebp)
	movl	-28(%ebp), %eax
	subl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-32(%ebp), %eax
	sall	$12, %eax
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -44(%ebp)
	movl	$-1073676288, -48(%ebp)
	movl	-32(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, %edx
	movl	-48(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	movl	-32(%ebp), %eax
	andl	$7, %eax
	testl	%eax, %eax
	je	.L217
	incl	-12(%ebp)
.L217:
	pushl	-32(%ebp)
	pushl	-48(%ebp)
	pushl	$kernelPool
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$12, %esp
	pushl	-40(%ebp)
	pushl	$kernelPool
	call	_ZN11AddressPool15setStartAddressEj
	addl	$8, %esp
	pushl	-36(%ebp)
	pushl	-12(%ebp)
	pushl	$userPool
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$12, %esp
	pushl	-44(%ebp)
	pushl	$userPool
	call	_ZN11AddressPool15setStartAddressEj
	addl	$8, %esp
	movl	-36(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%ebp)
	movl	-36(%ebp), %eax
	andl	$7, %eax
	testl	%eax, %eax
	je	.L218
	incl	-16(%ebp)
.L218:
	pushl	-32(%ebp)
	pushl	-16(%ebp)
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$12, %esp
	pushl	$-1072693248
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPool15setStartAddressEj
	addl	$8, %esp
	pushl	-48(%ebp)
	pushl	-32(%ebp)
	pushl	-40(%ebp)
	pushl	$.LC0
	call	_Z6printfPKcz
	addl	$16, %esp
	pushl	-12(%ebp)
	pushl	-36(%ebp)
	pushl	-44(%ebp)
	pushl	$.LC1
	call	_Z6printfPKcz
	addl	$16, %esp
	pushl	-16(%ebp)
	pushl	-36(%ebp)
	pushl	$-1072693248
	pushl	$.LC2
	call	_Z6printfPKcz
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE54:
	.size	_Z14initMemoryPoolj, .-_Z14initMemoryPoolj
	.type	_ZL20allocateVirtualPages15AddressPoolTypej, @function
_ZL20allocateVirtualPages15AddressPoolTypej:
.LFB55:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	cmpl	$0, 8(%ebp)
	jne	.L220
	pushl	12(%ebp)
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPool8allocateEj
	addl	$8, %esp
	movl	%eax, -4(%ebp)
	cmpl	$-1, -4(%ebp)
	je	.L221
	movl	-4(%ebp), %eax
	jmp	.L223
.L221:
	movl	$0, %eax
	jmp	.L223
.L220:
	movl	$0, %eax
.L223:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE55:
	.size	_ZL20allocateVirtualPages15AddressPoolTypej, .-_ZL20allocateVirtualPages15AddressPoolTypej
	.type	_ZL20allocatePhysicalPage15AddressPoolType, @function
_ZL20allocatePhysicalPage15AddressPoolType:
.LFB56:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	cmpl	$0, 8(%ebp)
	jne	.L225
	pushl	$1
	pushl	$kernelPool
	call	_ZN11AddressPool8allocateEj
	addl	$8, %esp
	movl	%eax, -4(%ebp)
	cmpl	$-1, -4(%ebp)
	je	.L226
	movl	-4(%ebp), %eax
	jmp	.L228
.L226:
	movl	$0, %eax
	jmp	.L228
.L225:
	movl	$0, %eax
.L228:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE56:
	.size	_ZL20allocatePhysicalPage15AddressPoolType, .-_ZL20allocatePhysicalPage15AddressPoolType
	.type	_ZL26connectPhysicalVritualPagejj, @function
_ZL26connectPhysicalVritualPagejj:
.LFB57:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	_ZL5toPDEj
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	8(%ebp)
	call	_ZL5toPTEj
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L230
	movl	12(%ebp), %eax
	orl	$7, %eax
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%edx, (%eax)
	jmp	.L231
.L230:
	subl	$12, %esp
	pushl	$0
	call	_ZL20allocatePhysicalPage15AddressPoolType
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	jne	.L232
	movb	$0, %al
	jmp	.L233
.L232:
	movl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	orl	$7, %eax
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	movl	%edx, (%eax)
	movl	-20(%ebp), %eax
	andl	$-4096, %eax
	movl	%eax, -32(%ebp)
	movl	$0, -12(%ebp)
.L235:
	cmpl	$4095, -12(%ebp)
	jg	.L234
	movl	-12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	incl	-12(%ebp)
	jmp	.L235
.L234:
	movl	12(%ebp), %eax
	orl	$7, %eax
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%edx, (%eax)
.L231:
	movb	$1, %al
.L233:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE57:
	.size	_ZL26connectPhysicalVritualPagejj, .-_ZL26connectPhysicalVritualPagejj
	.type	_ZL5toPDEj, @function
_ZL5toPDEj:
.LFB58:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	shrl	$22, %eax
	addl	$1073740800, %eax
	sall	$2, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE58:
	.size	_ZL5toPDEj, .-_ZL5toPDEj
	.type	_ZL5toPTEj, @function
_ZL5toPTEj:
.LFB59:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	shrl	$10, %eax
	andl	$4190208, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	shrl	$12, %eax
	andl	$1023, %eax
	sall	$2, %eax
	addl	%edx, %eax
	subl	$4194304, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE59:
	.size	_ZL5toPTEj, .-_ZL5toPTEj
	.globl	_Z13allocatePages15AddressPoolTypej
	.type	_Z13allocatePages15AddressPoolTypej, @function
_Z13allocatePages15AddressPoolTypej:
.LFB60:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	_ZL20allocateVirtualPages15AddressPoolTypej
	addl	$8, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L241
	movl	$0, %eax
	jmp	.L242
.L241:
	movl	-12(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	$0, -16(%ebp)
.L246:
	movl	-16(%ebp), %eax
	cmpl	%eax, 12(%ebp)
	jbe	.L243
	pushl	8(%ebp)
	call	_ZL20allocatePhysicalPage15AddressPoolType
	addl	$4, %esp
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	jne	.L244
	movl	$0, %eax
	jmp	.L242
.L244:
	subl	$8, %esp
	pushl	-24(%ebp)
	pushl	-12(%ebp)
	call	_ZL26connectPhysicalVritualPagejj
	addl	$16, %esp
	xorl	$1, %eax
	testb	%al, %al
	je	.L245
	movl	$0, %eax
	jmp	.L242
.L245:
	incl	-16(%ebp)
	addl	$4096, -12(%ebp)
	jmp	.L246
.L243:
	movl	-20(%ebp), %eax
.L242:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE60:
	.size	_Z13allocatePages15AddressPoolTypej, .-_Z13allocatePages15AddressPoolTypej
	.globl	_Z14_start_programj
	.type	_Z14_start_programj, @function
_Z14_start_programj:
.LFB61:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE61:
	.size	_Z14_start_programj, .-_Z14_start_programj
	.globl	_Z6memsetPhhj
	.type	_Z6memsetPhhj, @function
_Z6memsetPhhj:
.LFB62:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	movl	12(%ebp), %eax
	movb	%al, -20(%ebp)
	movl	$0, -4(%ebp)
.L250:
	movl	-4(%ebp), %eax
	cmpl	%eax, 16(%ebp)
	jbe	.L251
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movb	-20(%ebp), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	jmp	.L250
.L251:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE62:
	.size	_Z6memsetPhhj, .-_Z6memsetPhhj
	.type	_ZL12kernelThreadPFvPvES_, @function
_ZL12kernelThreadPFvPvES_:
.LFB63:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	12(%ebp)
	movl	8(%ebp), %eax
	call	*%eax
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE63:
	.size	_ZL12kernelThreadPFvPvES_, .-_ZL12kernelThreadPFvPvES_
	.globl	_Z12createThreadPFvPvES_h
	.type	_Z12createThreadPFvPvES_h, @function
_Z12createThreadPFvPvES_h:
.LFB64:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	16(%ebp), %eax
	movb	%al, -28(%ebp)
	subl	$8, %esp
	pushl	$1
	pushl	$0
	call	_Z13allocatePages15AddressPoolTypej
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L254
	movl	$-1, %eax
	jmp	.L255
.L254:
	subl	$4, %esp
	pushl	$4096
	pushl	$0
	pushl	-12(%ebp)
	call	_Z6memsetPhhj
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	$1, 4(%eax)
	movl	-12(%ebp), %eax
	movb	-28(%ebp), %dl
	movb	%dl, 8(%eax)
	movzbl	-28(%ebp), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 20(%eax)
	movl	-12(%ebp), %eax
	movl	$428280086, 44(%eax)
	movl	PID, %eax
	leal	1(%eax), %edx
	movl	%edx, PID
	movl	-12(%ebp), %edx
	movl	%eax, 12(%edx)
	movl	PID, %eax
	cmpl	$-1, %eax
	jne	.L256
	movl	$0, PID
.L256:
	movl	-12(%ebp), %eax
	addl	$3988, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	$_ZL12kernelThreadPFvPvES_, 16(%eax)
	movl	-16(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 24(%eax)
	movl	-16(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 28(%eax)
	movl	-16(%ebp), %eax
	movl	$0, 8(%eax)
	movl	-16(%ebp), %eax
	movl	8(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	-16(%ebp), %eax
	movl	12(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	movl	4(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, (%eax)
	call	_interrupt_status
	movb	%al, -17(%ebp)
	call	_disable_interrupt
	movl	-12(%ebp), %eax
	addl	$32, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$_all_threads
	call	_ZN10ThreadList9push_backEP14ThreadListItem
	addl	$16, %esp
	movl	-12(%ebp), %eax
	addl	$24, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$_ready_threads
	call	_ZN10ThreadList9push_backEP14ThreadListItem
	addl	$16, %esp
	movzbl	-17(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z14_set_interruptb
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	12(%eax), %eax
.L255:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE64:
	.size	_Z12createThreadPFvPvES_h, .-_Z12createThreadPFvPvES_h
	.globl	_Z16_schedule_threadv
	.type	_Z16_schedule_threadv, @function
_Z16_schedule_threadv:
.LFB65:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_running_thread
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$32, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$_all_threads
	call	_ZN10ThreadList4findEP14ThreadListItem
	addl	$16, %esp
	cmpl	$-1, %eax
	sete	%al
	testb	%al, %al
	jne	.L261
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	.L260
	movl	-12(%ebp), %eax
	movl	$1, 4(%eax)
	movl	-12(%ebp), %eax
	movb	8(%eax), %al
	movzbl	%al, %edx
	movl	-12(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	-12(%ebp), %eax
	addl	$24, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$_ready_threads
	call	_ZN10ThreadList9push_backEP14ThreadListItem
	addl	$16, %esp
.L260:
	subl	$12, %esp
	pushl	$_ready_threads
	call	_ZN10ThreadList5frontEv
	addl	$16, %esp
	subl	$24, %eax
	movl	%eax, -16(%ebp)
	subl	$12, %esp
	pushl	$_ready_threads
	call	_ZN10ThreadList9pop_frontEv
	addl	$16, %esp
	movl	-16(%ebp), %eax
	movl	$0, 4(%eax)
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	-12(%ebp)
	call	_switch_thread_to
	addl	$16, %esp
	jmp	.L257
.L261:
	nop
.L257:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE65:
	.size	_Z16_schedule_threadv, .-_Z16_schedule_threadv
	.section	.rodata
.LC3:
	.string	"In thread list constructor\n"
	.text
	.align 2
	.globl	_ZN10ThreadListC2Ev
	.type	_ZN10ThreadListC2Ev, @function
_ZN10ThreadListC2Ev:
.LFB67:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	$.LC3
	call	_Z6printfPKcz
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE67:
	.size	_ZN10ThreadListC2Ev, .-_ZN10ThreadListC2Ev
	.globl	_ZN10ThreadListC1Ev
	.set	_ZN10ThreadListC1Ev,_ZN10ThreadListC2Ev
	.align 2
	.globl	_ZN10ThreadList10initializeEv
	.type	_ZN10ThreadList10initializeEv, @function
_ZN10ThreadList10initializeEv:
.LFB69:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE69:
	.size	_ZN10ThreadList10initializeEv, .-_ZN10ThreadList10initializeEv
	.align 2
	.globl	_ZN10ThreadList4sizeEv
	.type	_ZN10ThreadList4sizeEv, @function
_ZN10ThreadList4sizeEv:
.LFB70:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	movl	$0, -8(%ebp)
.L266:
	cmpl	$0, -4(%ebp)
	je	.L265
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	incl	-8(%ebp)
	jmp	.L266
.L265:
	movl	-8(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE70:
	.size	_ZN10ThreadList4sizeEv, .-_ZN10ThreadList4sizeEv
	.align 2
	.globl	_ZN10ThreadList5emptyEv
	.type	_ZN10ThreadList5emptyEv, @function
_ZN10ThreadList5emptyEv:
.LFB71:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	8(%ebp)
	call	_ZN10ThreadList4sizeEv
	addl	$4, %esp
	testl	%eax, %eax
	sete	%al
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE71:
	.size	_ZN10ThreadList5emptyEv, .-_ZN10ThreadList5emptyEv
	.align 2
	.globl	_ZN10ThreadList4backEv
	.type	_ZN10ThreadList4backEv, @function
_ZN10ThreadList4backEv:
.LFB72:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	jne	.L271
	movl	$0, %eax
	jmp	.L272
.L271:
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	.L273
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	jmp	.L271
.L273:
	movl	-4(%ebp), %eax
.L272:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE72:
	.size	_ZN10ThreadList4backEv, .-_ZN10ThreadList4backEv
	.align 2
	.globl	_ZN10ThreadList9push_backEP14ThreadListItem
	.type	_ZN10ThreadList9push_backEP14ThreadListItem, @function
_ZN10ThreadList9push_backEP14ThreadListItem:
.LFB73:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	pushl	8(%ebp)
	call	_ZN10ThreadList4backEv
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	jne	.L275
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
.L275:
	movl	-4(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	12(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, (%eax)
	movl	12(%ebp), %eax
	movl	$0, 4(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE73:
	.size	_ZN10ThreadList9push_backEP14ThreadListItem, .-_ZN10ThreadList9push_backEP14ThreadListItem
	.align 2
	.globl	_ZN10ThreadList8pop_backEv
	.type	_ZN10ThreadList8pop_backEv, @function
_ZN10ThreadList8pop_backEv:
.LFB74:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	pushl	8(%ebp)
	call	_ZN10ThreadList4backEv
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	je	.L278
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	$0, 4(%eax)
.L278:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE74:
	.size	_ZN10ThreadList8pop_backEv, .-_ZN10ThreadList8pop_backEv
	.align 2
	.globl	_ZN10ThreadList5frontEv
	.type	_ZN10ThreadList5frontEv, @function
_ZN10ThreadList5frontEv:
.LFB75:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE75:
	.size	_ZN10ThreadList5frontEv, .-_ZN10ThreadList5frontEv
	.align 2
	.globl	_ZN10ThreadList10push_frontEP14ThreadListItem
	.type	_ZN10ThreadList10push_frontEP14ThreadListItem, @function
_ZN10ThreadList10push_frontEP14ThreadListItem:
.LFB76:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	je	.L282
	movl	-4(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, (%eax)
.L282:
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	movl	12(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, 4(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE76:
	.size	_ZN10ThreadList10push_frontEP14ThreadListItem, .-_ZN10ThreadList10push_frontEP14ThreadListItem
	.align 2
	.globl	_ZN10ThreadList9pop_frontEv
	.type	_ZN10ThreadList9pop_frontEv, @function
_ZN10ThreadList9pop_frontEv:
.LFB77:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	je	.L286
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	.L285
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%eax)
.L285:
	movl	-4(%ebp), %eax
	movl	4(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
.L286:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE77:
	.size	_ZN10ThreadList9pop_frontEv, .-_ZN10ThreadList9pop_frontEv
	.align 2
	.globl	_ZN10ThreadList6insertEiP14ThreadListItem
	.type	_ZN10ThreadList6insertEiP14ThreadListItem, @function
_ZN10ThreadList6insertEiP14ThreadListItem:
.LFB78:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	cmpl	$0, 12(%ebp)
	jne	.L288
	pushl	16(%ebp)
	pushl	8(%ebp)
	call	_ZN10ThreadList10push_frontEP14ThreadListItem
	addl	$8, %esp
	jmp	.L291
.L288:
	pushl	8(%ebp)
	call	_ZN10ThreadList4sizeEv
	addl	$4, %esp
	movl	%eax, -12(%ebp)
	movl	12(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jne	.L290
	pushl	16(%ebp)
	pushl	8(%ebp)
	call	_ZN10ThreadList9push_backEP14ThreadListItem
	addl	$8, %esp
	jmp	.L291
.L290:
	movl	12(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jge	.L291
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	_ZN10ThreadList2atEi
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	movl	16(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, (%eax)
.L291:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE78:
	.size	_ZN10ThreadList6insertEiP14ThreadListItem, .-_ZN10ThreadList6insertEiP14ThreadListItem
	.align 2
	.globl	_ZN10ThreadList5eraseEi
	.type	_ZN10ThreadList5eraseEi, @function
_ZN10ThreadList5eraseEi:
.LFB79:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	cmpl	$0, 12(%ebp)
	jne	.L293
	pushl	8(%ebp)
	call	_ZN10ThreadList9pop_frontEv
	addl	$4, %esp
	jmp	.L296
.L293:
	pushl	8(%ebp)
	call	_ZN10ThreadList4sizeEv
	addl	$4, %esp
	movl	%eax, -12(%ebp)
	movl	12(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jge	.L296
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	_ZN10ThreadList2atEi
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	movl	-16(%ebp), %edx
	movl	4(%edx), %edx
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	.L296
	movl	-16(%ebp), %eax
	movl	4(%eax), %eax
	movl	-16(%ebp), %edx
	movl	(%edx), %edx
	movl	%edx, (%eax)
.L296:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE79:
	.size	_ZN10ThreadList5eraseEi, .-_ZN10ThreadList5eraseEi
	.align 2
	.globl	_ZN10ThreadList2atEi
	.type	_ZN10ThreadList2atEi, @function
_ZN10ThreadList2atEi:
.LFB80:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	movl	$0, -8(%ebp)
.L299:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jge	.L298
	cmpl	$0, -4(%ebp)
	je	.L298
	incl	-8(%ebp)
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -4(%ebp)
	jmp	.L299
.L298:
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE80:
	.size	_ZN10ThreadList2atEi, .-_ZN10ThreadList2atEi
	.align 2
	.globl	_ZN10ThreadList4findEP14ThreadListItem
	.type	_ZN10ThreadList4findEP14ThreadListItem, @function
_ZN10ThreadList4findEP14ThreadListItem:
.LFB81:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -8(%ebp)
.L303:
	cmpl	$0, -8(%ebp)
	je	.L302
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	je	.L302
	movl	-8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -8(%ebp)
	incl	-4(%ebp)
	jmp	.L303
.L302:
	cmpl	$0, -8(%ebp)
	je	.L304
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jne	.L304
	movl	-4(%ebp), %eax
	jmp	.L305
.L304:
	movl	$-1, %eax
.L305:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE81:
	.size	_ZN10ThreadList4findEP14ThreadListItem, .-_ZN10ThreadList4findEP14ThreadListItem
	.globl	_Z4testi
	.type	_Z4testi, @function
_Z4testi:
.LFB82:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE82:
	.size	_Z4testi, .-_Z4testi
	.section	.rodata
.LC4:
	.string	" "
.LC5:
	.string	"?"
.LC6:
	.string	"\n"
	.text
	.globl	Kernel
	.type	Kernel, @function
Kernel:
.LFB83:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	subl	$12, %esp
	pushl	$0
	call	_Z10MoveCursorj
	addl	$16, %esp
	call	_Z5Clearv
	movl	$0, -12(%ebp)
.L314:
	cmpl	$9, -12(%ebp)
	ja	.L309
	movl	$10, -16(%ebp)
.L311:
	movl	-16(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jbe	.L310
	subl	$12, %esp
	pushl	$.LC4
	call	_Z6printfPKcz
	addl	$16, %esp
	decl	-16(%ebp)
	jmp	.L311
.L310:
	movl	$0, -20(%ebp)
.L313:
	movl	-20(%ebp), %eax
	cmpl	-12(%ebp), %eax
	ja	.L312
	subl	$12, %esp
	pushl	$.LC5
	call	_Z6printfPKcz
	addl	$16, %esp
	incl	-20(%ebp)
	jmp	.L313
.L312:
	subl	$12, %esp
	pushl	$.LC6
	call	_Z6printfPKcz
	addl	$16, %esp
	incl	-12(%ebp)
	jmp	.L314
.L309:
	movl	$0, -24(%ebp)
.L320:
	cmpl	$8, -24(%ebp)
	ja	.L315
	movl	$0, -28(%ebp)
.L317:
	movl	-24(%ebp), %eax
	incl	%eax
	cmpl	%eax, -28(%ebp)
	ja	.L316
	subl	$12, %esp
	pushl	$.LC4
	call	_Z6printfPKcz
	addl	$16, %esp
	incl	-28(%ebp)
	jmp	.L317
.L316:
	movl	$9, -32(%ebp)
.L319:
	movl	-32(%ebp), %eax
	cmpl	-24(%ebp), %eax
	jbe	.L318
	subl	$12, %esp
	pushl	$.LC5
	call	_Z6printfPKcz
	addl	$16, %esp
	decl	-32(%ebp)
	jmp	.L319
.L318:
	subl	$12, %esp
	pushl	$.LC6
	call	_Z6printfPKcz
	addl	$16, %esp
	incl	-24(%ebp)
	jmp	.L320
.L315:
	jmp	.L315
	.cfi_endproc
.LFE83:
	.size	Kernel, .-Kernel
	.globl	_Z6_shellPv
	.type	_Z6_shellPv, @function
_Z6_shellPv:
.LFB84:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	call	_enable_interrupt
	call	_Z5Clearv
	movl	$3, -16(%ebp)
	movl	$20, -12(%ebp)
	movl	$3, -24(%ebp)
	movl	$51, -20(%ebp)
	movl	$14, -32(%ebp)
	movl	$20, -28(%ebp)
	movl	$14, -40(%ebp)
	movl	$51, -36(%ebp)
	subl	$4, %esp
	pushl	$1
	leal	-16(%ebp), %eax
	pushl	%eax
	pushl	$_Z11printMatrixPv
	call	_Z12createThreadPFvPvES_h
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	leal	-24(%ebp), %eax
	pushl	%eax
	pushl	$_Z11printMatrixPv
	call	_Z12createThreadPFvPvES_h
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	leal	-32(%ebp), %eax
	pushl	%eax
	pushl	$_Z11printMatrixPv
	call	_Z12createThreadPFvPvES_h
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	leal	-40(%ebp), %eax
	pushl	%eax
	pushl	$_Z11printMatrixPv
	call	_Z12createThreadPFvPvES_h
	addl	$16, %esp
.L322:
	jmp	.L322
	.cfi_endproc
.LFE84:
	.size	_Z6_shellPv, .-_Z6_shellPv
	.section	.rodata
.LC7:
	.string	"Hello Thread!\n"
.LC8:
	.string	"%s"
	.text
	.globl	_Z5printPv
	.type	_Z5printPv, @function
_Z5printPv:
.LFB85:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
.L324:
	subl	$8, %esp
	pushl	$.LC7
	pushl	$.LC8
	call	_Z6printfPKcz
	addl	$16, %esp
	jmp	.L324
	.cfi_endproc
.LFE85:
	.size	_Z5printPv, .-_Z5printPv
	.section	.rodata
.LC9:
	.string	"reboot"
.LC10:
	.string	"nelsoncheung"
	.align 4
.LC11:
	.string	"invalid command or parameters!\n"
	.align 4
.LC12:
	.string	"load [...]: load program.\nclear: clear the whole screen.\nreboot: reboot NSNOS.\nls: list all the program in the disk.\nnelsoncheung: the information of the author\n"
	.align 4
.LC13:
	.byte	0x20,0x20,0x4e,0x65,0x6c,0x73,0x6f,0x6e,0x20,0x43,0x68,0x65,0x75
	.string	"ng, or zhangjunyu in Chinese, is the author of Nelson Core 0.0.\n  It takes Nelson 2 days to learn the protect mode, 3 days to program the core, oslib and shell.\n  If you have any comments or advice, please contact the author at zhangjunyu@nelson-cheung.cn\n"
.LC14:
	.string	"interrupt"
	.text
	.globl	_Z5parsePh
	.type	_Z5parsePh, @function
_Z5parsePh:
.LFB86:
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
	movl	$.LC9, %ebx
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
	movl	$.LC10, %ebx
	movl	$13, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-104(%ebp), %eax
	movl	$.LC11, %ebx
	movl	$8, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsl
	leal	-266(%ebp), %eax
	movl	$.LC12, %ebx
	movl	$162, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-536(%ebp), %eax
	movl	$.LC13, %ebx
	movl	$270, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-546(%ebp), %eax
	movl	$.LC14, %ebx
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
	je	.L326
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
.L326:
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
	jne	.L334
	leal	-44(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$8, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L328
	call	_Z5Clearv
	subl	$12, %esp
	pushl	$80
	call	_Z10MoveCursorj
	addl	$16, %esp
	jmp	.L334
.L328:
	subl	$8, %esp
	leal	-51(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L329
	call	_Z6Rebootv
	jmp	.L334
.L329:
	subl	$8, %esp
	leal	-54(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L330
	call	_Z2Lsv
	jmp	.L334
.L330:
	subl	$8, %esp
	leal	-59(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L331
	subl	$8, %esp
	leal	-266(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L334
.L331:
	subl	$8, %esp
	leal	-72(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L332
	subl	$8, %esp
	leal	-536(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L334
.L332:
	subl	$8, %esp
	leal	-546(%ebp), %eax
	pushl	%eax
	pushl	-32(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L333
	call	_Z16CallInterrupt38Hv
	jmp	.L334
.L333:
	subl	$8, %esp
	leal	-104(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
.L334:
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
.LFE86:
	.size	_Z5parsePh, .-_Z5parsePh
	.globl	_Z2Lsv
	.type	_Z2Lsv, @function
_Z2Lsv:
.LFB87:
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
.L340:
	cmpl	$511, -12(%ebp)
	ja	.L341
	movl	$0, -16(%ebp)
.L338:
	cmpl	$31, -16(%ebp)
	ja	.L337
	movl	-16(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	-532(%ebp,%eax), %al
	leal	-564(%ebp), %ecx
	movl	-16(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	incl	-16(%ebp)
	jmp	.L338
.L337:
	movb	-564(%ebp), %al
	testb	%al, %al
	je	.L339
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
.L339:
	addl	$32, -12(%ebp)
	jmp	.L340
.L341:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE87:
	.size	_Z2Lsv, .-_Z2Lsv
	.section	.rodata
	.align 4
.LC15:
	.string	"kernel loading Done.\nNSNOS 0.0, from Nelson Core 0.0\nDo the last check...\n"
	.text
	.globl	_Z4initv
	.type	_Z4initv, @function
_Z4initv:
.LFB88:
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
	movl	$.LC15, %ebx
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
.LFE88:
	.size	_Z4initv, .-_Z4initv
	.globl	_Z11printMatrixPv
	.type	_Z11printMatrixPv, @function
_Z11printMatrixPv:
.LFB89:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	subl	$372, %esp
	.cfi_offset 7, -12
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)
	movl	%edx, -40(%ebp)
	movl	$9, -24(%ebp)
	movl	$9, -28(%ebp)
	movl	$81, -32(%ebp)
	movl	$1000000, -36(%ebp)
	leal	-368(%ebp), %edx
	movl	$81, %ecx
	movl	$0, %eax
	movl	%edx, %edi
	rep stosl
	movl	$0, -12(%ebp)
	movl	$0, -16(%ebp)
	movl	$1, -20(%ebp)
.L353:
	cmpl	$81, -20(%ebp)
	jg	.L344
.L346:
	cmpl	$8, -16(%ebp)
	jg	.L345
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%edx, %eax
	movl	-368(%ebp,%eax,4), %eax
	testl	%eax, %eax
	jne	.L345
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%eax, -368(%ebp,%edx,4)
	call	_disable_interrupt
	movl	-44(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	-40(%ebp), %eax
	addl	%eax, %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$42
	call	_Z7putcharj
	addl	$16, %esp
	call	_enable_interrupt
	incl	-20(%ebp)
	incl	-16(%ebp)
	subl	$12, %esp
	pushl	$1000000
	call	_Z4waiti
	addl	$16, %esp
	jmp	.L346
.L345:
	decl	-16(%ebp)
	incl	-12(%ebp)
.L348:
	cmpl	$8, -12(%ebp)
	jg	.L347
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%edx, %eax
	movl	-368(%ebp,%eax,4), %eax
	testl	%eax, %eax
	jne	.L347
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%eax, -368(%ebp,%edx,4)
	call	_disable_interrupt
	movl	-44(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	-40(%ebp), %eax
	addl	%eax, %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$42
	call	_Z7putcharj
	addl	$16, %esp
	call	_enable_interrupt
	incl	-20(%ebp)
	incl	-12(%ebp)
	subl	$12, %esp
	pushl	$1000000
	call	_Z4waiti
	addl	$16, %esp
	jmp	.L348
.L347:
	decl	-12(%ebp)
	decl	-16(%ebp)
.L350:
	cmpl	$0, -16(%ebp)
	js	.L349
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%edx, %eax
	movl	-368(%ebp,%eax,4), %eax
	testl	%eax, %eax
	jne	.L349
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%eax, -368(%ebp,%edx,4)
	call	_disable_interrupt
	movl	-44(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	-40(%ebp), %eax
	addl	%eax, %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$42
	call	_Z7putcharj
	addl	$16, %esp
	call	_enable_interrupt
	incl	-20(%ebp)
	decl	-16(%ebp)
	subl	$12, %esp
	pushl	$1000000
	call	_Z4waiti
	addl	$16, %esp
	jmp	.L350
.L349:
	incl	-16(%ebp)
	decl	-12(%ebp)
.L352:
	cmpl	$0, -12(%ebp)
	js	.L351
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%edx, %eax
	movl	-368(%ebp,%eax,4), %eax
	testl	%eax, %eax
	jne	.L351
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%eax, -368(%ebp,%edx,4)
	call	_disable_interrupt
	movl	-44(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	-40(%ebp), %eax
	addl	%eax, %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$42
	call	_Z7putcharj
	addl	$16, %esp
	call	_enable_interrupt
	incl	-20(%ebp)
	decl	-12(%ebp)
	subl	$12, %esp
	pushl	$1000000
	call	_Z4waiti
	addl	$16, %esp
	jmp	.L352
.L351:
	incl	-12(%ebp)
	incl	-16(%ebp)
	jmp	.L353
.L344:
	jmp	.L344
	.cfi_endproc
.LFE89:
	.size	_Z11printMatrixPv, .-_Z11printMatrixPv
	.globl	_Z4waiti
	.type	_Z4waiti, @function
_Z4waiti:
.LFB90:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
.L356:
	cmpl	$0, 8(%ebp)
	je	.L357
	decl	8(%ebp)
	jmp	.L356
.L357:
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE90:
	.size	_Z4waiti, .-_Z4waiti
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB91:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	cmpl	$1, 8(%ebp)
	jne	.L360
	cmpl	$65535, 12(%ebp)
	jne	.L360
	subl	$12, %esp
	pushl	$_all_threads
	call	_ZN10ThreadListC1Ev
	addl	$16, %esp
	subl	$12, %esp
	pushl	$_ready_threads
	call	_ZN10ThreadListC1Ev
	addl	$16, %esp
	subl	$12, %esp
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPoolC1Ev
	addl	$16, %esp
	subl	$12, %esp
	pushl	$kernelPool
	call	_ZN11AddressPoolC1Ev
	addl	$16, %esp
	subl	$12, %esp
	pushl	$userPool
	call	_ZN11AddressPoolC1Ev
	addl	$16, %esp
.L360:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE91:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry, @function
_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry:
.LFB92:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$8, %esp
	pushl	$65535
	pushl	$1
	call	_Z41__static_initialization_and_destruction_0ii
	addl	$16, %esp
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE92:
	.size	_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry, .-_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry
	.section	.ctors,"aw",@progbits
	.align 4
	.long	_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry
	.ident	"GCC: (GNU) 7.1.0"
