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
	testl	%eax, %eax
	jne	.L161
	call	_Z16_schedule_threadv
.L161:
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
	jb	.L164
	movl	8(%ebp), %eax
	jmp	.L166
.L164:
	movl	12(%ebp), %eax
.L166:
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
	jb	.L168
	movl	12(%ebp), %eax
	jmp	.L170
.L168:
	movl	8(%ebp), %eax
.L170:
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
	je	.L174
	call	_enable_interrupt
	jmp	.L176
.L174:
	call	_disable_interrupt
.L176:
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
	je	.L179
	incl	-4(%ebp)
.L179:
	movl	$0, -8(%ebp)
.L181:
	movl	-8(%ebp), %eax
	cmpl	%eax, -4(%ebp)
	jbe	.L182
	movl	-8(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	incl	-8(%ebp)
	jmp	.L181
.L182:
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
.L187:
	movl	-8(%ebp), %eax
	cmpl	%eax, -16(%ebp)
	jbe	.L186
	movb	-1(%ebp), %al
	sall	%eax
	incl	%eax
	movb	%al, -1(%ebp)
	incl	-8(%ebp)
	jmp	.L187
.L186:
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
	jne	.L189
	movl	$-1, %eax
	jmp	.L190
.L189:
	movl	$0, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jnb	.L191
.L195:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jnb	.L192
	pushl	-4(%ebp)
	pushl	8(%ebp)
	call	_ZN6BitMap3getEj
	addl	$8, %esp
	testb	%al, %al
	je	.L192
	movb	$1, %al
	jmp	.L193
.L192:
	movb	$0, %al
.L193:
	testb	%al, %al
	je	.L194
	incl	-4(%ebp)
	jmp	.L195
.L194:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jne	.L196
	movl	$-1, %eax
	jmp	.L190
.L196:
	movl	$0, -8(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, -16(%ebp)
.L200:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, -4(%ebp)
	jnb	.L197
	pushl	-4(%ebp)
	pushl	8(%ebp)
	call	_ZN6BitMap3getEj
	addl	$8, %esp
	xorl	$1, %eax
	testb	%al, %al
	je	.L197
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jnb	.L197
	movb	$1, %al
	jmp	.L198
.L197:
	movb	$0, %al
.L198:
	testb	%al, %al
	je	.L199
	incl	-8(%ebp)
	incl	-4(%ebp)
	jmp	.L200
.L199:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jne	.L201
	movl	$0, -12(%ebp)
.L203:
	movl	-12(%ebp), %eax
	cmpl	%eax, 12(%ebp)
	jbe	.L201
	movl	-12(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	pushl	$1
	pushl	%eax
	pushl	8(%ebp)
	call	_ZN6BitMap3setEjb
	addl	$12, %esp
	incl	-12(%ebp)
	jmp	.L203
.L201:
	movl	-16(%ebp), %eax
	jmp	.L190
.L191:
	movl	$-1, %eax
.L190:
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
.L206:
	movl	-4(%ebp), %eax
	cmpl	%eax, 16(%ebp)
	jbe	.L207
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	pushl	$0
	pushl	%eax
	pushl	8(%ebp)
	call	_ZN6BitMap3setEjb
	addl	$12, %esp
	incl	-4(%ebp)
	jmp	.L206
.L207:
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
	.size	kernelVrirtualPool, 24
kernelVrirtualPool:
	.zero	24
	.globl	kernelPool
	.align 4
	.type	kernelPool, @object
	.size	kernelPool, 24
kernelPool:
	.zero	24
	.globl	userPool
	.align 4
	.type	userPool, @object
	.size	userPool, 24
userPool:
	.zero	24
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
.LFB48:
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
	je	.L209
	incl	-12(%ebp)
.L209:
	subl	$4, %esp
	pushl	-32(%ebp)
	pushl	-48(%ebp)
	pushl	$kernelPool
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$16, %esp
	subl	$8, %esp
	pushl	-40(%ebp)
	pushl	$kernelPool
	call	_ZN11AddressPool15setStartAddressEj
	addl	$16, %esp
	subl	$4, %esp
	pushl	-36(%ebp)
	pushl	-12(%ebp)
	pushl	$userPool
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$16, %esp
	subl	$8, %esp
	pushl	-44(%ebp)
	pushl	$userPool
	call	_ZN11AddressPool15setStartAddressEj
	addl	$16, %esp
	movl	-36(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%ebp)
	movl	-36(%ebp), %eax
	andl	$7, %eax
	testl	%eax, %eax
	je	.L210
	incl	-16(%ebp)
.L210:
	subl	$4, %esp
	pushl	-32(%ebp)
	pushl	-16(%ebp)
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$16, %esp
	subl	$8, %esp
	pushl	$-1072693248
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPool15setStartAddressEj
	addl	$16, %esp
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
.LFE48:
	.size	_Z14initMemoryPoolj, .-_Z14initMemoryPoolj
	.type	_ZL20allocateVirtualPages15AddressPoolTypej, @function
_ZL20allocateVirtualPages15AddressPoolTypej:
.LFB49:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$-1, -12(%ebp)
	cmpl	$0, 8(%ebp)
	jne	.L212
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	$kernelVrirtualPool
	call	_ZN11AddressPool8allocateEj
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	jmp	.L213
.L212:
	cmpl	$1, 8(%ebp)
	jne	.L213
	call	_running_thread
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	$44, %eax
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	%eax
	call	_ZN11AddressPool8allocateEj
	addl	$16, %esp
	movl	%eax, -12(%ebp)
.L213:
	cmpl	$-1, -12(%ebp)
	je	.L214
	movl	-12(%ebp), %eax
	jmp	.L216
.L214:
	movl	$0, %eax
.L216:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE49:
	.size	_ZL20allocateVirtualPages15AddressPoolTypej, .-_ZL20allocateVirtualPages15AddressPoolTypej
	.type	_ZL20allocatePhysicalPage15AddressPoolType, @function
_ZL20allocatePhysicalPage15AddressPoolType:
.LFB50:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$-1, -12(%ebp)
	cmpl	$0, 8(%ebp)
	jne	.L218
	subl	$8, %esp
	pushl	$1
	pushl	$kernelPool
	call	_ZN11AddressPool8allocateEj
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	jmp	.L219
.L218:
	cmpl	$1, 8(%ebp)
	jne	.L219
	subl	$8, %esp
	pushl	$1
	pushl	$userPool
	call	_ZN11AddressPool8allocateEj
	addl	$16, %esp
	movl	%eax, -12(%ebp)
.L219:
	cmpl	$-1, -12(%ebp)
	je	.L220
	movl	-12(%ebp), %eax
	jmp	.L222
.L220:
	movl	$0, %eax
.L222:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE50:
	.size	_ZL20allocatePhysicalPage15AddressPoolType, .-_ZL20allocatePhysicalPage15AddressPoolType
	.type	_ZL26connectPhysicalVritualPagejj, @function
_ZL26connectPhysicalVritualPagejj:
.LFB51:
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
	je	.L224
	movl	12(%ebp), %eax
	orl	$7, %eax
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%edx, (%eax)
	jmp	.L225
.L224:
	subl	$12, %esp
	pushl	$0
	call	_ZL20allocatePhysicalPage15AddressPoolType
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	jne	.L226
	movb	$0, %al
	jmp	.L227
.L226:
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
.L229:
	cmpl	$4095, -12(%ebp)
	jg	.L228
	movl	-12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	incl	-12(%ebp)
	jmp	.L229
.L228:
	movl	12(%ebp), %eax
	orl	$7, %eax
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%edx, (%eax)
.L225:
	movb	$1, %al
.L227:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE51:
	.size	_ZL26connectPhysicalVritualPagejj, .-_ZL26connectPhysicalVritualPagejj
	.type	_ZL5toPDEj, @function
_ZL5toPDEj:
.LFB52:
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
.LFE52:
	.size	_ZL5toPDEj, .-_ZL5toPDEj
	.type	_ZL5toPTEj, @function
_ZL5toPTEj:
.LFB53:
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
.LFE53:
	.size	_ZL5toPTEj, .-_ZL5toPTEj
	.globl	_Z13allocatePages15AddressPoolTypej
	.type	_Z13allocatePages15AddressPoolTypej, @function
_Z13allocatePages15AddressPoolTypej:
.LFB54:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	_ZL20allocateVirtualPages15AddressPoolTypej
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L235
	movl	$0, %eax
	jmp	.L236
.L235:
	movl	-12(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	$0, -16(%ebp)
.L240:
	movl	-16(%ebp), %eax
	cmpl	%eax, 12(%ebp)
	jbe	.L237
	subl	$12, %esp
	pushl	8(%ebp)
	call	_ZL20allocatePhysicalPage15AddressPoolType
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	jne	.L238
	movl	$0, %eax
	jmp	.L236
.L238:
	subl	$8, %esp
	pushl	-24(%ebp)
	pushl	-12(%ebp)
	call	_ZL26connectPhysicalVritualPagejj
	addl	$16, %esp
	xorl	$1, %eax
	testb	%al, %al
	je	.L239
	movl	$0, %eax
	jmp	.L236
.L239:
	incl	-16(%ebp)
	addl	$4096, -12(%ebp)
	jmp	.L240
.L237:
	movl	-20(%ebp), %eax
.L236:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE54:
	.size	_Z13allocatePages15AddressPoolTypej, .-_Z13allocatePages15AddressPoolTypej
	.globl	_Z11vaddr2paddrj
	.type	_Z11vaddr2paddrj, @function
_Z11vaddr2paddrj:
.LFB55:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	8(%ebp)
	call	_ZL5toPTEj
	addl	$4, %esp
	andl	$-4096, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	andl	$4095, %eax
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE55:
	.size	_Z11vaddr2paddrj, .-_Z11vaddr2paddrj
	.globl	_Z20specifyPaddrForVaddr15AddressPoolTypej
	.type	_Z20specifyPaddrForVaddr15AddressPoolTypej, @function
_Z20specifyPaddrForVaddr15AddressPoolTypej:
.LFB56:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	_ZL20allocatePhysicalPage15AddressPoolType
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L244
	movl	$0, %eax
	jmp	.L245
.L244:
	movl	-12(%ebp), %eax
	subl	$8, %esp
	pushl	%eax
	pushl	12(%ebp)
	call	_ZL26connectPhysicalVritualPagejj
	addl	$16, %esp
	movb	%al, -13(%ebp)
	cmpb	$0, -13(%ebp)
	je	.L246
	movl	12(%ebp), %eax
	jmp	.L248
.L246:
	movl	$0, %eax
.L248:
	nop
.L245:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE56:
	.size	_Z20specifyPaddrForVaddr15AddressPoolTypej, .-_Z20specifyPaddrForVaddr15AddressPoolTypej
	.globl	_Z14_start_programj
	.type	_Z14_start_programj, @function
_Z14_start_programj:
.LFB57:
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
.LFE57:
	.size	_Z14_start_programj, .-_Z14_start_programj
	.globl	_Z6memsetPhhj
	.type	_Z6memsetPhhj, @function
_Z6memsetPhhj:
.LFB58:
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
.L252:
	movl	-4(%ebp), %eax
	cmpl	%eax, 16(%ebp)
	jbe	.L253
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movb	-20(%ebp), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	jmp	.L252
.L253:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE58:
	.size	_Z6memsetPhhj, .-_Z6memsetPhhj
	.globl	_Z6memcpyPhS_j
	.type	_Z6memcpyPhS_j, @function
_Z6memcpyPhS_j:
.LFB59:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L256:
	movl	-4(%ebp), %eax
	cmpl	%eax, 16(%ebp)
	jbe	.L257
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %ecx
	movl	12(%ebp), %edx
	addl	%ecx, %edx
	movb	(%eax), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	jmp	.L256
.L257:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE59:
	.size	_Z6memcpyPhS_j, .-_Z6memcpyPhS_j
	.globl	_Z12kernelThreadPFvPvES_
	.type	_Z12kernelThreadPFvPvES_, @function
_Z12kernelThreadPFvPvES_:
.LFB60:
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
.LFE60:
	.size	_Z12kernelThreadPFvPvES_, .-_Z12kernelThreadPFvPvES_
	.globl	_Z12createThreadPFvPvES_h
	.type	_Z12createThreadPFvPvES_h, @function
_Z12createThreadPFvPvES_h:
.LFB61:
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
	jne	.L260
	movl	$-1, %eax
	jmp	.L261
.L260:
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
	movl	$0, 40(%eax)
	movl	-12(%ebp), %eax
	movl	$428280086, 68(%eax)
	movl	PID, %eax
	leal	1(%eax), %edx
	movl	%edx, PID
	movl	-12(%ebp), %edx
	movl	%eax, 12(%edx)
	movl	PID, %eax
	cmpl	$-1, %eax
	jne	.L262
	movl	$0, PID
.L262:
	movl	-12(%ebp), %eax
	addl	$3988, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	$_Z12kernelThreadPFvPvES_, 16(%eax)
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
.L261:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE61:
	.size	_Z12createThreadPFvPvES_h, .-_Z12createThreadPFvPvES_h
	.globl	_Z16_schedule_threadv
	.type	_Z16_schedule_threadv, @function
_Z16_schedule_threadv:
.LFB62:
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
	jne	.L267
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	.L266
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
.L266:
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
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z15activatePageTabP3PCB
	addl	$16, %esp
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	-12(%ebp)
	call	_switch_thread_to
	addl	$16, %esp
	jmp	.L263
.L267:
	nop
.L263:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE62:
	.size	_Z16_schedule_threadv, .-_Z16_schedule_threadv
	.globl	_Z13_block_threadv
	.type	_Z13_block_threadv, @function
_Z13_block_threadv:
.LFB63:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_interrupt_status
	movb	%al, -9(%ebp)
	call	_disable_interrupt
	call	_running_thread
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	$2, 4(%eax)
	call	_Z16_schedule_threadv
	movzbl	-9(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z14_set_interruptb
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE63:
	.size	_Z13_block_threadv, .-_Z13_block_threadv
	.globl	_Z15_wake_up_threadP3PCB
	.type	_Z15_wake_up_threadP3PCB, @function
_Z15_wake_up_threadP3PCB:
.LFB64:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_interrupt_status
	movb	%al, -9(%ebp)
	call	_disable_interrupt
	movl	8(%ebp), %eax
	movl	$1, 4(%eax)
	movl	8(%ebp), %eax
	addl	$24, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$_ready_threads
	call	_ZN10ThreadList10push_frontEP14ThreadListItem
	addl	$16, %esp
	call	_Z16_schedule_threadv
	movzbl	-9(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z14_set_interruptb
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE64:
	.size	_Z15_wake_up_threadP3PCB, .-_Z15_wake_up_threadP3PCB
	.globl	_Z4testv
	.type	_Z4testv, @function
_Z4testv:
.LFB65:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	_disable_interrupt
	call	_enable_interrupt
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE65:
	.size	_Z4testv, .-_Z4testv
	.align 2
	.globl	_ZN9SemaphoreC2Ev
	.type	_ZN9SemaphoreC2Ev, @function
_ZN9SemaphoreC2Ev:
.LFB67:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %eax
	addl	$4, %eax
	subl	$12, %esp
	pushl	%eax
	call	_ZN10ThreadListC1Ev
	addl	$16, %esp
	movl	8(%ebp), %eax
	movb	$0, (%eax)
	movl	8(%ebp), %eax
	addl	$4, %eax
	subl	$12, %esp
	pushl	%eax
	call	_ZN10ThreadList10initializeEv
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE67:
	.size	_ZN9SemaphoreC2Ev, .-_ZN9SemaphoreC2Ev
	.globl	_ZN9SemaphoreC1Ev
	.set	_ZN9SemaphoreC1Ev,_ZN9SemaphoreC2Ev
	.align 2
	.globl	_ZN9Semaphore10initializeEh
	.type	_ZN9Semaphore10initializeEh, @function
_ZN9Semaphore10initializeEh:
.LFB69:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movb	%al, -12(%ebp)
	movl	8(%ebp), %eax
	movb	-12(%ebp), %dl
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
	addl	$4, %eax
	subl	$12, %esp
	pushl	%eax
	call	_ZN10ThreadList10initializeEv
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE69:
	.size	_ZN9Semaphore10initializeEh, .-_ZN9Semaphore10initializeEh
	.align 2
	.globl	_ZN9Semaphore1PEv
	.type	_ZN9Semaphore1PEv, @function
_ZN9Semaphore1PEv:
.LFB70:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_interrupt_status
	movb	%al, -9(%ebp)
	call	_disable_interrupt
.L275:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	.L274
	call	_running_thread
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	addl	$4, %eax
	movl	-16(%ebp), %edx
	addl	$24, %edx
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	_ZN10ThreadList9push_backEP14ThreadListItem
	addl	$16, %esp
	call	_Z13_block_threadv
	jmp	.L275
.L274:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	leal	-1(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	movzbl	-9(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z14_set_interruptb
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE70:
	.size	_ZN9Semaphore1PEv, .-_ZN9Semaphore1PEv
	.align 2
	.globl	_ZN9Semaphore1VEv
	.type	_ZN9Semaphore1VEv, @function
_ZN9Semaphore1VEv:
.LFB71:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	_interrupt_status
	movb	%al, -9(%ebp)
	call	_disable_interrupt
	movl	8(%ebp), %eax
	movb	(%eax), %al
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
	addl	$4, %eax
	subl	$12, %esp
	pushl	%eax
	call	_ZN10ThreadList4sizeEv
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L277
	movl	8(%ebp), %eax
	addl	$4, %eax
	subl	$12, %esp
	pushl	%eax
	call	_ZN10ThreadList5frontEv
	addl	$16, %esp
	subl	$24, %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	addl	$4, %eax
	subl	$12, %esp
	pushl	%eax
	call	_ZN10ThreadList9pop_frontEv
	addl	$16, %esp
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z15_wake_up_threadP3PCB
	addl	$16, %esp
.L277:
	movzbl	-9(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z14_set_interruptb
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE71:
	.size	_ZN9Semaphore1VEv, .-_ZN9Semaphore1VEv
	.section	.text._ZN3Tss10updateEsp0EP3PCB,"axG",@progbits,_ZN3Tss10updateEsp0EP3PCB,comdat
	.align 2
	.weak	_ZN3Tss10updateEsp0EP3PCB
	.type	_ZN3Tss10updateEsp0EP3PCB, @function
_ZN3Tss10updateEsp0EP3PCB:
.LFB72:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	12(%ebp), %eax
	addl	$4096, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE72:
	.size	_ZN3Tss10updateEsp0EP3PCB, .-_ZN3Tss10updateEsp0EP3PCB
	.section	.text._ZN3Tss10initializeEv,"axG",@progbits,_ZN3Tss10initializeEv,comdat
	.align 2
	.weak	_ZN3Tss10initializeEv
	.type	_ZN3Tss10initializeEv, @function
_ZN3Tss10initializeEv:
.LFB73:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$108, -12(%ebp)
	pushl	-12(%ebp)
	pushl	$0
	pushl	8(%ebp)
	call	_Z6memsetPhhj
	addl	$12, %esp
	movl	8(%ebp), %eax
	movl	$16, 8(%eax)
	movl	$0, -16(%ebp)
	movl	-12(%ebp), %eax
	decl	%eax
	andl	$255, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	orl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	sall	$16, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	orl	%eax, -16(%ebp)
	movl	$0, -24(%ebp)
	movl	8(%ebp), %eax
	andl	$-16777216, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	orl	%eax, -24(%ebp)
	movl	8(%ebp), %eax
	andl	$16711680, %eax
	movl	%eax, -20(%ebp)
	shrl	$16, -20(%ebp)
	movl	-20(%ebp), %eax
	orl	%eax, -24(%ebp)
	movl	-12(%ebp), %eax
	decl	%eax
	andl	$65280, %eax
	movl	%eax, -20(%ebp)
	sall	$16, -20(%ebp)
	movl	-20(%ebp), %eax
	orl	%eax, -24(%ebp)
	orl	$35072, -24(%ebp)
	subl	$8, %esp
	pushl	-24(%ebp)
	pushl	-16(%ebp)
	call	sys_add_gd
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	sall	$3, -20(%ebp)
	subl	$12, %esp
	pushl	-20(%ebp)
	call	sys_init_tss
	addl	$16, %esp
	subl	$8, %esp
	pushl	$13629440
	pushl	$65535
	call	sys_add_gd
	addl	$16, %esp
	subl	$8, %esp
	pushl	$13627904
	pushl	$65535
	call	sys_add_gd
	addl	$16, %esp
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 104(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE73:
	.size	_ZN3Tss10initializeEv, .-_ZN3Tss10initializeEv
	.globl	tss
	.section	.bss
	.align 32
	.type	tss, @object
	.size	tss, 108
tss:
	.zero	108
	.text
	.globl	_Z12startProcessPv
	.type	_Z12startProcessPv, @function
_Z12startProcessPv:
.LFB74:
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
	movl	(%eax), %eax
	addl	$32, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	$0, 36(%eax)
	movl	-16(%ebp), %eax
	movl	36(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 32(%eax)
	movl	-16(%ebp), %eax
	movl	32(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 28(%eax)
	movl	-16(%ebp), %eax
	movl	28(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	-16(%ebp), %eax
	movl	20(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	-16(%ebp), %eax
	movl	16(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	-16(%ebp), %eax
	movl	12(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	-16(%ebp), %eax
	movl	8(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	movl	$59, 48(%eax)
	movl	-16(%ebp), %eax
	movl	48(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 72(%eax)
	movl	-16(%ebp), %eax
	movl	72(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 44(%eax)
	movl	-16(%ebp), %eax
	movl	44(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 40(%eax)
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 56(%eax)
	movl	-16(%ebp), %eax
	movl	$51, 60(%eax)
	movl	-16(%ebp), %eax
	movl	$12802, 64(%eax)
	subl	$8, %esp
	pushl	$-1073745920
	pushl	$1
	call	_Z20specifyPaddrForVaddr15AddressPoolTypej
	addl	$16, %esp
	leal	4096(%eax), %edx
	movl	-16(%ebp), %eax
	movl	%edx, 68(%eax)
	call	sys_start_process
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE74:
	.size	_Z12startProcessPv, .-_Z12startProcessPv
	.globl	_Z15activatePageDirP3PCB
	.type	_Z15activatePageDirP3PCB, @function
_Z15activatePageDirP3PCB:
.LFB75:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$1048576, -12(%ebp)
	movl	8(%ebp), %eax
	movl	40(%eax), %eax
	testl	%eax, %eax
	je	.L282
	movl	8(%ebp), %eax
	movl	40(%eax), %eax
	pushl	%eax
	call	_Z11vaddr2paddrj
	addl	$4, %esp
	movl	%eax, -12(%ebp)
.L282:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	sys_update_cr3
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE75:
	.size	_Z15activatePageDirP3PCB, .-_Z15activatePageDirP3PCB
	.globl	_Z15activatePageTabP3PCB
	.type	_Z15activatePageTabP3PCB, @function
_Z15activatePageTabP3PCB:
.LFB76:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	_Z15activatePageDirP3PCB
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	40(%eax), %eax
	testl	%eax, %eax
	je	.L285
	subl	$8, %esp
	pushl	8(%ebp)
	pushl	$tss
	call	_ZN3Tss10updateEsp0EP3PCB
	addl	$16, %esp
.L285:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE76:
	.size	_Z15activatePageTabP3PCB, .-_Z15activatePageTabP3PCB
	.section	.rodata
	.align 4
.LC3:
	.string	"can not create page from kernel\n"
	.text
	.globl	_Z13createPageDirv
	.type	_Z13createPageDirv, @function
_Z13createPageDirv:
.LFB77:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$0
	call	_Z13allocatePages15AddressPoolTypej
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L287
	subl	$12, %esp
	pushl	$.LC3
	call	_Z6printfPKcz
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L288
.L287:
	movl	-12(%ebp), %eax
	addl	$3072, %eax
	subl	$4, %esp
	pushl	$1024
	pushl	%eax
	pushl	$-1024
	call	_Z6memcpyPhS_j
	addl	$16, %esp
	movl	-12(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z11vaddr2paddrj
	addl	$16, %esp
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	$4092, %eax
	orl	$7, %edx
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
.L288:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE77:
	.size	_Z13createPageDirv, .-_Z13createPageDirv
	.globl	_Z19createUserVaddrPoolP3PCB
	.type	_Z19createUserVaddrPoolP3PCB, @function
_Z19createUserVaddrPoolP3PCB:
.LFB78:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$753592, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$7, %eax
	shrl	$3, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	$4095, %eax
	shrl	$12, %eax
	movl	%eax, -20(%ebp)
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	$0
	call	_Z13allocatePages15AddressPoolTypej
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	movl	8(%ebp), %eax
	addl	$44, %eax
	subl	$4, %esp
	pushl	-12(%ebp)
	pushl	-24(%ebp)
	pushl	%eax
	call	_ZN11AddressPool12setResourcesEPhj
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$44, %eax
	subl	$8, %esp
	pushl	$134512640
	pushl	%eax
	call	_ZN11AddressPool15setStartAddressEj
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE78:
	.size	_Z19createUserVaddrPoolP3PCB, .-_Z19createUserVaddrPoolP3PCB
	.globl	_Z14executeProcessPvPKcj
	.type	_Z14executeProcessPvPKcj, @function
_Z14executeProcessPvPKcj:
.LFB79:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$0
	call	_Z13allocatePages15AddressPoolTypej
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L291
	movl	$-1, %eax
	jmp	.L292
.L291:
	subl	$4, %esp
	pushl	$4096
	pushl	$0
	pushl	-12(%ebp)
	call	_Z6memsetPhhj
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	$1, 4(%eax)
	movl	16(%ebp), %eax
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, 8(%eax)
	movl	-12(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, 16(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 20(%eax)
	call	_Z13createPageDirv
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, 40(%eax)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_Z19createUserVaddrPoolP3PCB
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	$428280086, 68(%eax)
	movl	-12(%ebp), %eax
	addl	$3988, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	$_Z12kernelThreadPFvPvES_, 16(%eax)
	movl	-16(%ebp), %eax
	movl	$_Z12startProcessPv, 24(%eax)
	movl	-16(%ebp), %eax
	movl	8(%ebp), %edx
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
.L292:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE79:
	.size	_Z14executeProcessPvPKcj, .-_Z14executeProcessPvPKcj
	.section	.rodata
.LC4:
	.string	"user process A"
	.text
	.globl	Kernel
	.type	Kernel, @function
Kernel:
.LFB80:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	_Z4initv
	subl	$4, %esp
	pushl	$1
	pushl	$.LC4
	pushl	$_Z12userProcessAPv
	call	_Z14executeProcessPvPKcj
	addl	$16, %esp
.L294:
	jmp	.L294
	.cfi_endproc
.LFE80:
	.size	Kernel, .-Kernel
	.globl	_Z4initv
	.type	_Z4initv, @function
_Z4initv:
.LFB81:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	_disable_interrupt
	subl	$12, %esp
	pushl	$33554432
	call	_Z14initMemoryPoolj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$_all_threads
	call	_ZN10ThreadList10initializeEv
	addl	$16, %esp
	subl	$12, %esp
	pushl	$_ready_threads
	call	_ZN10ThreadList10initializeEv
	addl	$16, %esp
	movl	$0, PID
	subl	$12, %esp
	pushl	$tss
	call	_ZN3Tss10initializeEv
	addl	$16, %esp
	call	_enable_interrupt
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE81:
	.size	_Z4initv, .-_Z4initv
	.section	.rodata
.LC5:
	.string	"user process created!\n"
	.text
	.globl	_Z12userProcessAPv
	.type	_Z12userProcessAPv, @function
_Z12userProcessAPv:
.LFB82:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	subl	$12, %esp
	pushl	$.LC5
	call	_Z6printfPKcz
	addl	$16, %esp
.L297:
	jmp	.L297
	.cfi_endproc
.LFE82:
	.size	_Z12userProcessAPv, .-_Z12userProcessAPv
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB83:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	cmpl	$1, 8(%ebp)
	jne	.L300
	cmpl	$65535, 12(%ebp)
	jne	.L300
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
.L300:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE83:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry, @function
_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry:
.LFB84:
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
.LFE84:
	.size	_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry, .-_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry
	.section	.ctors,"aw",@progbits
	.align 4
	.long	_GLOBAL__sub_I__Z15CreateFileEntryPhP9FileEntry
	.ident	"GCC: (GNU) 7.1.0"
