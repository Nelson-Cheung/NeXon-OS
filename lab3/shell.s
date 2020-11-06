	.file	"shell.c"
	.text
	.globl	_Z7PutCharj
	.type	_Z7PutCharj, @function
_Z7PutCharj:
.LFB0:
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
.LFE0:
	.size	_Z7PutCharj, .-_Z7PutCharj
	.globl	_Z7GetCharv
	.type	_Z7GetCharv, @function
_Z7GetCharv:
.LFB1:
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
.LFE1:
	.size	_Z7GetCharv, .-_Z7GetCharv
	.globl	_Z10MoveCursorj
	.type	_Z10MoveCursorj, @function
_Z10MoveCursorj:
.LFB2:
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
.LFE2:
	.size	_Z10MoveCursorj, .-_Z10MoveCursorj
	.globl	_Z9GetCursorv
	.type	_Z9GetCursorv, @function
_Z9GetCursorv:
.LFB3:
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
.LFE3:
	.size	_Z9GetCursorv, .-_Z9GetCursorv
	.globl	_Z4PutshPh
	.type	_Z4PutshPh, @function
_Z4PutshPh:
.LFB4:
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
.L11:
	movl	12(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L12
	movl	12(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	.L9
	call	_Z7NewLinev
	jmp	.L10
.L9:
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
.L10:
	incl	-12(%ebp)
	jmp	.L11
.L12:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	_Z4PutshPh, .-_Z4PutshPh
	.globl	_Z5Clearv
	.type	_Z5Clearv, @function
_Z5Clearv:
.LFB5:
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
.L15:
	cmpl	$1999, -12(%ebp)
	ja	.L14
	subl	$12, %esp
	pushl	$1792
	call	_Z7PutCharj
	addl	$16, %esp
	incl	-12(%ebp)
	jmp	.L15
.L14:
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
.LFE5:
	.size	_Z5Clearv, .-_Z5Clearv
	.globl	_Z7NewLinev
	.type	_Z7NewLinev, @function
_Z7NewLinev:
.LFB6:
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
	ja	.L17
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
	jmp	.L19
.L17:
	subl	$12, %esp
	pushl	$1999
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1792
	call	_Z7PutCharj
	addl	$16, %esp
.L19:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	_Z7NewLinev, .-_Z7NewLinev
	.globl	_Z16EnterDataSectionv
	.type	_Z16EnterDataSectionv, @function
_Z16EnterDataSectionv:
.LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	sys_enter_data_section
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	_Z16EnterDataSectionv, .-_Z16EnterDataSectionv
	.globl	_Z16LeaveDataSectionv
	.type	_Z16LeaveDataSectionv, @function
_Z16LeaveDataSectionv:
.LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	sys_leave_data_section
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	_Z16LeaveDataSectionv, .-_Z16LeaveDataSectionv
	.globl	_Z4LoadPh
	.type	_Z4LoadPh, @function
_Z4LoadPh:
.LFB9:
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
.LFE9:
	.size	_Z4LoadPh, .-_Z4LoadPh
	.globl	_Z4Putihj
	.type	_Z4Putihj, @function
_Z4Putihj:
.LFB10:
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
	jne	.L24
	movzbl	-60(%ebp), %eax
	sall	$8, %eax
	movl	%eax, -16(%ebp)
	orl	$48, -16(%ebp)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	jmp	.L30
.L24:
	movb	$0, -9(%ebp)
.L27:
	cmpl	$0, 12(%ebp)
	je	.L26
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
	jmp	.L27
.L26:
	movb	-9(%ebp), %al
	movb	%al, -10(%ebp)
.L29:
	decb	-10(%ebp)
	movzbl	-10(%ebp), %eax
	movl	-56(%ebp,%eax,4), %eax
	subl	$12, %esp
	pushl	%eax
	call	_Z7PutCharj
	addl	$16, %esp
	cmpb	$0, -10(%ebp)
	je	.L30
	jmp	.L29
.L30:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	_Z4Putihj, .-_Z4Putihj
	.globl	_Z6ReadHDjPh
	.type	_Z6ReadHDjPh, @function
_Z6ReadHDjPh:
.LFB11:
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
.LFE11:
	.size	_Z6ReadHDjPh, .-_Z6ReadHDjPh
	.globl	_Z6Rebootv
	.type	_Z6Rebootv, @function
_Z6Rebootv:
.LFB12:
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
.LFE12:
	.size	_Z6Rebootv, .-_Z6Rebootv
	.globl	_Z4Waitj
	.type	_Z4Waitj, @function
_Z4Waitj:
.LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
.L35:
	cmpl	$0, 8(%ebp)
	je	.L36
	decl	8(%ebp)
	jmp	.L35
.L36:
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE13:
	.size	_Z4Waitj, .-_Z4Waitj
	.globl	_Z15CreateFileEntryPhP9FileEntry
	.type	_Z15CreateFileEntryPhP9FileEntry, @function
_Z15CreateFileEntryPhP9FileEntry:
.LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L43:
	cmpl	$31, -4(%ebp)
	ja	.L44
	cmpl	$10, -4(%ebp)
	ja	.L39
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movl	12(%ebp), %ecx
	movl	-4(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	jmp	.L40
.L39:
	cmpl	$14, -4(%ebp)
	ja	.L41
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	-11(%edx), %ecx
	movb	(%eax), %dl
	movl	12(%ebp), %eax
	movb	%dl, 11(%eax,%ecx)
	jmp	.L40
.L41:
	cmpl	$16, -4(%ebp)
	ja	.L42
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	-15(%edx), %ecx
	movb	(%eax), %dl
	movl	12(%ebp), %eax
	movb	%dl, 15(%eax,%ecx)
	jmp	.L40
.L42:
	cmpl	$31, -4(%ebp)
	ja	.L40
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	-17(%edx), %ecx
	movb	(%eax), %dl
	movl	12(%ebp), %eax
	movb	%dl, 17(%eax,%ecx)
.L40:
	incl	-4(%ebp)
	jmp	.L43
.L44:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	_Z15CreateFileEntryPhP9FileEntry, .-_Z15CreateFileEntryPhP9FileEntry
	.globl	_Z12initKeyboardPh
	.type	_Z12initKeyboardPh, @function
_Z12initKeyboardPh:
.LFB15:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L47:
	cmpl	$255, -4(%ebp)
	jg	.L46
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	incl	-4(%ebp)
	jmp	.L47
.L46:
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
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE15:
	.size	_Z12initKeyboardPh, .-_Z12initKeyboardPh
	.globl	_Z6StrLenPh
	.type	_Z6StrLenPh, @function
_Z6StrLenPh:
.LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L50:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L49
	incl	-4(%ebp)
	jmp	.L50
.L49:
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE16:
	.size	_Z6StrLenPh, .-_Z6StrLenPh
	.globl	_Z9StrAppendPhS_
	.type	_Z9StrAppendPhS_, @function
_Z9StrAppendPhS_:
.LFB17:
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
.L54:
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L53
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
	jmp	.L54
.L53:
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
.LFE17:
	.size	_Z9StrAppendPhS_, .-_Z9StrAppendPhS_
	.globl	_Z10CharAppendPhh
	.type	_Z10CharAppendPhh, @function
_Z10CharAppendPhh:
.LFB18:
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
.LFE18:
	.size	_Z10CharAppendPhh, .-_Z10CharAppendPhh
	.globl	_Z9StrAssignPhS_
	.type	_Z9StrAssignPhS_, @function
_Z9StrAssignPhS_:
.LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L58:
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L57
	movl	-4(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %ecx
	movl	8(%ebp), %edx
	addl	%ecx, %edx
	movb	(%eax), %al
	movb	%al, (%edx)
	incl	-4(%ebp)
	jmp	.L58
.L57:
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
.LFE19:
	.size	_Z9StrAssignPhS_, .-_Z9StrAssignPhS_
	.globl	_Z8StrEqualPhS_
	.type	_Z8StrEqualPhS_, @function
_Z8StrEqualPhS_:
.LFB20:
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
	je	.L60
	movl	$0, %eax
	jmp	.L61
.L60:
	movl	$0, -8(%ebp)
.L64:
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L62
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %dl
	movl	12(%ebp), %ecx
	movl	-8(%ebp), %eax
	addl	%ecx, %eax
	movb	(%eax), %al
	cmpb	%al, %dl
	je	.L63
	movl	$0, %eax
	jmp	.L61
.L63:
	incl	-8(%ebp)
	jmp	.L64
.L62:
	movl	$1, %eax
.L61:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	_Z8StrEqualPhS_, .-_Z8StrEqualPhS_
	.globl	_Z7FirstInhPh
	.type	_Z7FirstInhPh, @function
_Z7FirstInhPh:
.LFB21:
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
.L67:
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L66
	movl	12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	%al, -20(%ebp)
	je	.L66
	incl	-4(%ebp)
	jmp	.L67
.L66:
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	_Z7FirstInhPh, .-_Z7FirstInhPh
	.globl	_Z7ToLowerPh
	.type	_Z7ToLowerPh, @function
_Z7ToLowerPh:
.LFB22:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
.L72:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L73
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$64, %al
	jbe	.L71
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$90, %al
	ja	.L71
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %dl
	movl	8(%ebp), %ecx
	movl	-4(%ebp), %eax
	addl	%ecx, %eax
	addl	$32, %edx
	movb	%dl, (%eax)
.L71:
	incl	-4(%ebp)
	jmp	.L72
.L73:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	_Z7ToLowerPh, .-_Z7ToLowerPh
	.globl	_Z10BytesToDecPhj
	.type	_Z10BytesToDecPhj, @function
_Z10BytesToDecPhj:
.LFB23:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	cmpl	$0, 12(%ebp)
	jne	.L75
	movl	$0, %eax
	jmp	.L76
.L75:
	movl	$0, -4(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -8(%ebp)
.L78:
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
	je	.L77
	jmp	.L78
.L77:
	movl	-4(%ebp), %eax
.L76:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	_Z10BytesToDecPhj, .-_Z10BytesToDecPhj
	.section	.rodata
.LC0:
	.string	"[root@nelson-cheung.cn] #"
	.text
	.globl	console
	.type	console, @function
console:
.LFB24:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$572, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	_Z4initv
	leal	-70(%ebp), %eax
	movl	$.LC0, %ebx
	movl	$26, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	subl	$12, %esp
	leal	-326(%ebp), %eax
	pushl	%eax
	call	_Z12initKeyboardPh
	addl	$16, %esp
	call	_Z5Clearv
.L86:
	movb	$0, -583(%ebp)
	movl	$0, -28(%ebp)
	movl	$0, -32(%ebp)
	subl	$8, %esp
	leal	-70(%ebp), %eax
	pushl	%eax
	pushl	$2
	call	_Z4PutshPh
	addl	$16, %esp
.L84:
	call	_Z7GetCharv
	movl	%eax, -36(%ebp)
	call	_Z7GetCharv
	movl	%eax, -40(%ebp)
	cmpl	$224, -36(%ebp)
	je	.L84
	cmpl	$14, -36(%ebp)
	jne	.L81
	cmpl	$0, -28(%ebp)
	je	.L84
	call	_Z9GetCursorv
	decl	%eax
	movl	%eax, -44(%ebp)
	subl	$12, %esp
	pushl	-44(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1792
	call	_Z7PutCharj
	addl	$16, %esp
	subl	$12, %esp
	pushl	-44(%ebp)
	call	_Z10MoveCursorj
	addl	$16, %esp
	decl	-28(%ebp)
	leal	-583(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	jmp	.L84
.L81:
	cmpl	$28, -36(%ebp)
	jne	.L82
	call	_Z7NewLinev
	nop
	cmpl	$0, -28(%ebp)
	je	.L86
	jmp	.L87
.L82:
	leal	-326(%ebp), %edx
	movl	-36(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	testb	%al, %al
	je	.L84
	movl	$1792, -44(%ebp)
	leal	-326(%ebp), %edx
	movl	-36(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	orl	%eax, -44(%ebp)
	subl	$12, %esp
	pushl	-44(%ebp)
	call	_Z7PutCharj
	addl	$16, %esp
	leal	-326(%ebp), %edx
	movl	-36(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	leal	-583(%ebp), %ecx
	movl	-28(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	incl	-28(%ebp)
	jmp	.L84
.L87:
	leal	-583(%ebp), %edx
	movl	-28(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	subl	$12, %esp
	leal	-583(%ebp), %eax
	pushl	%eax
	call	_Z5parsePh
	addl	$16, %esp
	jmp	.L86
	.cfi_endproc
.LFE24:
	.size	console, .-console
	.section	.rodata
.LC1:
	.string	"reboot"
.LC2:
	.string	"nelsoncheung"
	.align 4
.LC3:
	.string	"invalid command or parameters!\n"
	.align 4
.LC4:
	.string	"load [...]: load program.\nclear: clear the whole screen.\nreboot: reboot NSNOS.\nls: list all the program in the disk.\nnelsoncheung: the information of the author\n"
	.align 4
.LC5:
	.byte	0x20,0x20,0x4e,0x65,0x6c,0x73,0x6f,0x6e,0x20,0x43,0x68,0x65,0x75
	.string	"ng, or zhangjunyu in Chinese, is the author of Nelson Core 0.0.\n  It takes Nelson 2 days to learn the protect mode, 3 days to program the core, oslib and shell.\n  If you have any comments or advice, please contact the author at zhangjunyu@nelson-cheung.cn\n"
	.text
	.globl	_Z5parsePh
	.type	_Z5parsePh, @function
_Z5parsePh:
.LFB25:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$1052, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	_Z16EnterDataSectionv
	movl	$1684107116, -41(%ebp)
	movb	$0, -37(%ebp)
	movl	$1634036835, -47(%ebp)
	movw	$114, -43(%ebp)
	leal	-54(%ebp), %eax
	movl	$.LC1, %ebx
	movl	$7, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	movw	$29548, -57(%ebp)
	movb	$0, -55(%ebp)
	movl	$1886152040, -62(%ebp)
	movb	$0, -58(%ebp)
	leal	-75(%ebp), %eax
	movl	$.LC2, %ebx
	movl	$13, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-107(%ebp), %eax
	movl	$.LC3, %ebx
	movl	$8, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsl
	leal	-269(%ebp), %eax
	movl	$.LC4, %ebx
	movl	$162, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	leal	-539(%ebp), %eax
	movl	$.LC5, %ebx
	movl	$270, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	call	_Z16LeaveDataSectionv
	subl	$8, %esp
	pushl	8(%ebp)
	leal	-796(%ebp), %eax
	pushl	%eax
	call	_Z9StrAssignPhS_
	addl	$16, %esp
	subl	$12, %esp
	leal	-796(%ebp), %eax
	pushl	%eax
	call	_Z7ToLowerPh
	addl	$16, %esp
	subl	$8, %esp
	leal	-796(%ebp), %eax
	pushl	%eax
	pushl	$32
	call	_Z7FirstInhPh
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	leal	-796(%ebp), %eax
	movl	%eax, -36(%ebp)
	subl	$12, %esp
	leal	-796(%ebp), %eax
	pushl	%eax
	call	_Z6StrLenPh
	addl	$16, %esp
	cmpl	%eax, -32(%ebp)
	setb	%al
	testb	%al, %al
	je	.L89
	movl	-36(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	movb	%al, -25(%ebp)
	movl	-36(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
.L89:
	subl	$8, %esp
	pushl	-36(%ebp)
	leal	-1053(%ebp), %eax
	pushl	%eax
	call	_Z9StrAssignPhS_
	addl	$16, %esp
	subl	$8, %esp
	leal	-41(%ebp), %eax
	pushl	%eax
	pushl	-36(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L90
	cmpb	$0, -25(%ebp)
	je	.L99
	movl	-32(%ebp), %eax
	incl	%eax
	addl	%eax, -36(%ebp)
	call	_Z5Clearv
	subl	$12, %esp
	pushl	-36(%ebp)
	call	_Z4LoadPh
	addl	$16, %esp
	call	_Z5Clearv
	jmp	.L88
.L90:
	subl	$8, %esp
	leal	-47(%ebp), %eax
	pushl	%eax
	pushl	-36(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L94
	call	_Z5Clearv
	jmp	.L88
.L94:
	subl	$8, %esp
	leal	-54(%ebp), %eax
	pushl	%eax
	pushl	-36(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L95
	call	_Z6Rebootv
	jmp	.L88
.L95:
	subl	$8, %esp
	leal	-57(%ebp), %eax
	pushl	%eax
	pushl	-36(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L96
	call	_Z2Lsv
	jmp	.L88
.L96:
	subl	$8, %esp
	leal	-62(%ebp), %eax
	pushl	%eax
	pushl	-36(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L97
	subl	$8, %esp
	leal	-269(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L88
.L97:
	subl	$8, %esp
	leal	-75(%ebp), %eax
	pushl	%eax
	pushl	-36(%ebp)
	call	_Z8StrEqualPhS_
	addl	$16, %esp
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L98
	subl	$8, %esp
	leal	-539(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L88
.L98:
	subl	$8, %esp
	leal	-107(%ebp), %eax
	pushl	%eax
	pushl	$7
	call	_Z4PutshPh
	addl	$16, %esp
	jmp	.L88
.L99:
	nop
.L88:
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
.LFE25:
	.size	_Z5parsePh, .-_Z5parsePh
	.globl	_Z2Lsv
	.type	_Z2Lsv, @function
_Z2Lsv:
.LFB26:
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
.L105:
	cmpl	$511, -12(%ebp)
	ja	.L106
	movl	$0, -16(%ebp)
.L103:
	cmpl	$31, -16(%ebp)
	ja	.L102
	movl	-16(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	-532(%ebp,%eax), %al
	leal	-564(%ebp), %ecx
	movl	-16(%ebp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	incl	-16(%ebp)
	jmp	.L103
.L102:
	movb	-564(%ebp), %al
	testb	%al, %al
	je	.L104
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
.L104:
	addl	$32, -12(%ebp)
	jmp	.L105
.L106:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	_Z2Lsv, .-_Z2Lsv
	.section	.rodata
	.align 4
.LC6:
	.string	"kernel loading Done.\nNSNOS 0.0, from Nelson Core 0.0\nDo the last check...\n"
	.text
	.globl	_Z4initv
	.type	_Z4initv, @function
_Z4initv:
.LFB27:
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
	call	_Z16EnterDataSectionv
	leal	-99(%ebp), %eax
	movl	$.LC6, %ebx
	movl	$75, %edx
	movl	%eax, %edi
	movl	%ebx, %esi
	movl	%edx, %ecx
	rep movsb
	movl	$1701736292, -105(%ebp)
	movw	$10, -101(%ebp)
	call	_Z16LeaveDataSectionv
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
.LFE27:
	.size	_Z4initv, .-_Z4initv
	.ident	"GCC: (GNU) 7.1.0"
