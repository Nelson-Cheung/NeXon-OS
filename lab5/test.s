	.file	"test.cpp"
	.intel_syntax noprefix
	.text
	.globl	_Z15CreateFileEntryPhP9FileEntry
	.type	_Z15CreateFileEntryPhP9FileEntry, @function
_Z15CreateFileEntryPhP9FileEntry:
.LFB0:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 16
	mov	DWORD PTR [ebp-4], 0
.L7:
	cmp	DWORD PTR [ebp-4], 31
	ja	.L8
	cmp	DWORD PTR [ebp-4], 10
	ja	.L3
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp-4]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	mov	ecx, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [ebp-4]
	add	edx, ecx
	mov	BYTE PTR [edx], al
	jmp	.L4
.L3:
	cmp	DWORD PTR [ebp-4], 14
	ja	.L5
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp-4]
	add	eax, edx
	mov	edx, DWORD PTR [ebp-4]
	lea	ecx, [edx-11]
	mov	dl, BYTE PTR [eax]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax+11+ecx], dl
	jmp	.L4
.L5:
	cmp	DWORD PTR [ebp-4], 16
	ja	.L6
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp-4]
	add	eax, edx
	mov	edx, DWORD PTR [ebp-4]
	lea	ecx, [edx-15]
	mov	dl, BYTE PTR [eax]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax+15+ecx], dl
	jmp	.L4
.L6:
	cmp	DWORD PTR [ebp-4], 31
	ja	.L4
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp-4]
	add	eax, edx
	mov	edx, DWORD PTR [ebp-4]
	lea	ecx, [edx-17]
	mov	dl, BYTE PTR [eax]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [eax+17+ecx], dl
.L4:
	inc	DWORD PTR [ebp-4]
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
	.globl	_Z12initKeyboardPh
	.type	_Z12initKeyboardPh, @function
_Z12initKeyboardPh:
.LFB1:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 16
	mov	DWORD PTR [ebp-4], 0
.L11:
	cmp	DWORD PTR [ebp-4], 255
	jg	.L10
	mov	edx, DWORD PTR [ebp-4]
	mov	eax, DWORD PTR [ebp+8]
	add	eax, edx
	mov	BYTE PTR [eax], 0
	inc	DWORD PTR [ebp-4]
	jmp	.L11
.L10:
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 30
	mov	BYTE PTR [eax], 97
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 48
	mov	BYTE PTR [eax], 98
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 46
	mov	BYTE PTR [eax], 99
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 32
	mov	BYTE PTR [eax], 100
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 18
	mov	BYTE PTR [eax], 101
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 33
	mov	BYTE PTR [eax], 102
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 34
	mov	BYTE PTR [eax], 103
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 35
	mov	BYTE PTR [eax], 104
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 23
	mov	BYTE PTR [eax], 105
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 36
	mov	BYTE PTR [eax], 106
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 37
	mov	BYTE PTR [eax], 107
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 38
	mov	BYTE PTR [eax], 108
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 50
	mov	BYTE PTR [eax], 109
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 49
	mov	BYTE PTR [eax], 110
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 24
	mov	BYTE PTR [eax], 111
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 25
	mov	BYTE PTR [eax], 112
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 16
	mov	BYTE PTR [eax], 113
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 19
	mov	BYTE PTR [eax], 114
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 31
	mov	BYTE PTR [eax], 115
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 20
	mov	BYTE PTR [eax], 116
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 22
	mov	BYTE PTR [eax], 117
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 47
	mov	BYTE PTR [eax], 118
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 17
	mov	BYTE PTR [eax], 119
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 45
	mov	BYTE PTR [eax], 120
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 21
	mov	BYTE PTR [eax], 121
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 44
	mov	BYTE PTR [eax], 122
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 11
	mov	BYTE PTR [eax], 48
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 2
	mov	BYTE PTR [eax], 49
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 3
	mov	BYTE PTR [eax], 50
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 4
	mov	BYTE PTR [eax], 51
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 5
	mov	BYTE PTR [eax], 52
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 6
	mov	BYTE PTR [eax], 53
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 7
	mov	BYTE PTR [eax], 54
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 8
	mov	BYTE PTR [eax], 55
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 9
	mov	BYTE PTR [eax], 56
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 10
	mov	BYTE PTR [eax], 57
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 57
	mov	BYTE PTR [eax], 32
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 28
	mov	BYTE PTR [eax], 13
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 14
	mov	BYTE PTR [eax], 8
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	_Z12initKeyboardPh, .-_Z12initKeyboardPh
	.globl	_Z7IsSpacei
	.type	_Z7IsSpacei, @function
_Z7IsSpacei:
.LFB2:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	cmp	DWORD PTR [ebp+8], 32
	je	.L13
	cmp	DWORD PTR [ebp+8], 9
	je	.L13
	cmp	DWORD PTR [ebp+8], 13
	je	.L13
	cmp	DWORD PTR [ebp+8], 10
	je	.L13
	cmp	DWORD PTR [ebp+8], 11
	je	.L13
	cmp	DWORD PTR [ebp+8], 12
	jne	.L14
.L13:
	mov	al, 1
	jmp	.L15
.L14:
	mov	al, 0
.L15:
	pop	ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	_Z7IsSpacei, .-_Z7IsSpacei
	.globl	_Z7IsDigiti
	.type	_Z7IsDigiti, @function
_Z7IsDigiti:
.LFB3:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	cmp	DWORD PTR [ebp+8], 47
	jle	.L18
	cmp	DWORD PTR [ebp+8], 57
	jg	.L18
	mov	al, 1
	jmp	.L19
.L18:
	mov	al, 0
.L19:
	pop	ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	_Z7IsDigiti, .-_Z7IsDigiti
	.globl	_Z10BytesToDecPhj
	.type	_Z10BytesToDecPhj, @function
_Z10BytesToDecPhj:
.LFB4:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 16
	cmp	DWORD PTR [ebp+12], 0
	jne	.L22
	mov	eax, 0
	jmp	.L23
.L22:
	mov	DWORD PTR [ebp-4], 0
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [ebp-8], eax
.L25:
	dec	DWORD PTR [ebp-8]
	mov	eax, DWORD PTR [ebp-4]
	sal	eax, 8
	mov	ecx, eax
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp-8]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	movzx	eax, al
	add	eax, ecx
	mov	DWORD PTR [ebp-4], eax
	cmp	DWORD PTR [ebp-8], 0
	je	.L24
	jmp	.L25
.L24:
	mov	eax, DWORD PTR [ebp-4]
.L23:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	_Z10BytesToDecPhj, .-_Z10BytesToDecPhj
	.globl	_Z7bcd2intj
	.type	_Z7bcd2intj, @function
_Z7bcd2intj:
.LFB5:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 48
	mov	DWORD PTR [ebp-4], 0
	mov	DWORD PTR [ebp-8], 0
.L28:
	cmp	DWORD PTR [ebp-8], 7
	jg	.L27
	mov	eax, DWORD PTR [ebp+8]
	and	eax, 15
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-8]
	mov	DWORD PTR [ebp-44+eax*4], edx
	shr	DWORD PTR [ebp+8], 4
	inc	DWORD PTR [ebp-8]
	jmp	.L28
.L27:
	mov	DWORD PTR [ebp-12], 7
.L30:
	cmp	DWORD PTR [ebp-12], 0
	js	.L29
	mov	edx, DWORD PTR [ebp-4]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [ebp-44+eax*4]
	add	eax, edx
	mov	DWORD PTR [ebp-4], eax
	dec	DWORD PTR [ebp-12]
	jmp	.L30
.L29:
	mov	eax, DWORD PTR [ebp-4]
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	_Z7bcd2intj, .-_Z7bcd2intj
	.globl	_Z7PutCharj
	.type	_Z7PutCharj, @function
_Z7PutCharj:
.LFB6:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	sub	esp, 12
	push	DWORD PTR [ebp+8]
	call	sys_putc
	add	esp, 16
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	_Z7PutCharj, .-_Z7PutCharj
	.globl	_Z7GetCharv
	.type	_Z7GetCharv, @function
_Z7GetCharv:
.LFB7:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	call	sys_getc
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	_Z7GetCharv, .-_Z7GetCharv
	.globl	_Z10MoveCursorj
	.type	_Z10MoveCursorj, @function
_Z10MoveCursorj:
.LFB8:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	sub	esp, 12
	push	DWORD PTR [ebp+8]
	call	sys_move_cursor
	add	esp, 16
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	_Z10MoveCursorj, .-_Z10MoveCursorj
	.globl	_Z9GetCursorv
	.type	_Z9GetCursorv, @function
_Z9GetCursorv:
.LFB9:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	call	sys_get_cursor
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	_Z9GetCursorv, .-_Z9GetCursorv
	.globl	_Z4PutshPh
	.type	_Z4PutshPh, @function
_Z4PutshPh:
.LFB10:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 40
	mov	eax, DWORD PTR [ebp+8]
	mov	BYTE PTR [ebp-28], al
	mov	DWORD PTR [ebp-12], 0
.L42:
	mov	edx, DWORD PTR [ebp+12]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	test	al, al
	je	.L43
	mov	edx, DWORD PTR [ebp+12]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	cmp	al, 10
	jne	.L40
	call	_Z7NewLinev
	jmp	.L41
.L40:
	movzx	eax, BYTE PTR [ebp-28]
	sal	eax, 8
	mov	DWORD PTR [ebp-16], eax
	mov	edx, DWORD PTR [ebp+12]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	movzx	eax, al
	or	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7PutCharj
	add	esp, 16
.L41:
	inc	DWORD PTR [ebp-12]
	jmp	.L42
.L43:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	_Z4PutshPh, .-_Z4PutshPh
	.globl	_Z5Clearv
	.type	_Z5Clearv, @function
_Z5Clearv:
.LFB11:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 24
	mov	DWORD PTR [ebp-12], 0
	sub	esp, 12
	push	0
	call	_Z10MoveCursorj
	add	esp, 16
.L46:
	cmp	DWORD PTR [ebp-12], 1999
	ja	.L45
	sub	esp, 12
	push	1792
	call	_Z7PutCharj
	add	esp, 16
	inc	DWORD PTR [ebp-12]
	jmp	.L46
.L45:
	sub	esp, 12
	push	0
	call	_Z10MoveCursorj
	add	esp, 16
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE11:
	.size	_Z5Clearv, .-_Z5Clearv
	.globl	_Z7NewLinev
	.type	_Z7NewLinev, @function
_Z7NewLinev:
.LFB12:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 24
	call	_Z9GetCursorv
	mov	DWORD PTR [ebp-12], eax
	mov	eax, DWORD PTR [ebp-12]
	mov	edx, -858993459
	mul	edx
	mov	eax, edx
	shr	eax, 6
	mov	DWORD PTR [ebp-12], eax
	cmp	DWORD PTR [ebp-12], 23
	ja	.L48
	inc	DWORD PTR [ebp-12]
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	sal	eax, 4
	mov	DWORD PTR [ebp-12], eax
	sub	esp, 12
	push	DWORD PTR [ebp-12]
	call	_Z10MoveCursorj
	add	esp, 16
	jmp	.L50
.L48:
	sub	esp, 12
	push	1999
	call	_Z10MoveCursorj
	add	esp, 16
	sub	esp, 12
	push	1792
	call	_Z7PutCharj
	add	esp, 16
.L50:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE12:
	.size	_Z7NewLinev, .-_Z7NewLinev
	.globl	_Z4LoadPh
	.type	_Z4LoadPh, @function
_Z4LoadPh:
.LFB13:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	sub	esp, 12
	push	DWORD PTR [ebp+8]
	call	sys_load
	add	esp, 16
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE13:
	.size	_Z4LoadPh, .-_Z4LoadPh
	.globl	_Z4Putihj
	.type	_Z4Putihj, @function
_Z4Putihj:
.LFB14:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 72
	mov	eax, DWORD PTR [ebp+8]
	mov	BYTE PTR [ebp-60], al
	cmp	DWORD PTR [ebp+12], 0
	jne	.L53
	movzx	eax, BYTE PTR [ebp-60]
	sal	eax, 8
	mov	DWORD PTR [ebp-16], eax
	or	DWORD PTR [ebp-16], 48
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7PutCharj
	add	esp, 16
	jmp	.L59
.L53:
	mov	BYTE PTR [ebp-9], 0
.L56:
	cmp	DWORD PTR [ebp+12], 0
	je	.L55
	movzx	eax, BYTE PTR [ebp-60]
	sal	eax, 8
	mov	DWORD PTR [ebp-16], eax
	mov	eax, DWORD PTR [ebp+12]
	mov	ecx, 10
	mov	edx, 0
	div	ecx
	mov	eax, edx
	add	eax, 48
	or	DWORD PTR [ebp-16], eax
	movzx	eax, BYTE PTR [ebp-9]
	mov	edx, DWORD PTR [ebp-16]
	mov	DWORD PTR [ebp-56+eax*4], edx
	inc	BYTE PTR [ebp-9]
	mov	eax, DWORD PTR [ebp+12]
	mov	edx, -858993459
	mul	edx
	mov	eax, edx
	shr	eax, 3
	mov	DWORD PTR [ebp+12], eax
	jmp	.L56
.L55:
	mov	al, BYTE PTR [ebp-9]
	mov	BYTE PTR [ebp-10], al
.L58:
	dec	BYTE PTR [ebp-10]
	movzx	eax, BYTE PTR [ebp-10]
	mov	eax, DWORD PTR [ebp-56+eax*4]
	sub	esp, 12
	push	eax
	call	_Z7PutCharj
	add	esp, 16
	cmp	BYTE PTR [ebp-10], 0
	je	.L59
	jmp	.L58
.L59:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	_Z4Putihj, .-_Z4Putihj
	.globl	_Z6ReadHDjPh
	.type	_Z6ReadHDjPh, @function
_Z6ReadHDjPh:
.LFB15:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	sub	esp, 8
	push	DWORD PTR [ebp+12]
	push	DWORD PTR [ebp+8]
	call	sys_read_hd
	add	esp, 16
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE15:
	.size	_Z6ReadHDjPh, .-_Z6ReadHDjPh
	.globl	_Z6Rebootv
	.type	_Z6Rebootv, @function
_Z6Rebootv:
.LFB16:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	call	sys_reboot
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE16:
	.size	_Z6Rebootv, .-_Z6Rebootv
	.globl	_Z4Waitj
	.type	_Z4Waitj, @function
_Z4Waitj:
.LFB17:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
.L64:
	cmp	DWORD PTR [ebp+8], 0
	je	.L65
	dec	DWORD PTR [ebp+8]
	jmp	.L64
.L65:
	nop
	pop	ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE17:
	.size	_Z4Waitj, .-_Z4Waitj
	.globl	PrintTime
	.type	PrintTime, @function
PrintTime:
.LFB18:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 24
	mov	DWORD PTR [ebp-12], 1837
	sub	esp, 8
	push	9
	push	112
	call	_out_port
	add	esp, 16
	sub	esp, 12
	push	113
	call	_in_port
	add	esp, 16
	mov	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7bcd2intj
	add	esp, 16
	add	eax, 2000
	sub	esp, 8
	push	eax
	push	7
	call	_Z4Putihj
	add	esp, 16
	sub	esp, 12
	push	DWORD PTR [ebp-12]
	call	_Z7PutCharj
	add	esp, 16
	sub	esp, 8
	push	8
	push	112
	call	_out_port
	add	esp, 16
	sub	esp, 12
	push	113
	call	_in_port
	add	esp, 16
	mov	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7bcd2intj
	add	esp, 16
	sub	esp, 8
	push	eax
	push	7
	call	_Z4Putihj
	add	esp, 16
	sub	esp, 12
	push	DWORD PTR [ebp-12]
	call	_Z7PutCharj
	add	esp, 16
	mov	DWORD PTR [ebp-12], 1824
	sub	esp, 8
	push	7
	push	112
	call	_out_port
	add	esp, 16
	sub	esp, 12
	push	113
	call	_in_port
	add	esp, 16
	mov	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7bcd2intj
	add	esp, 16
	sub	esp, 8
	push	eax
	push	7
	call	_Z4Putihj
	add	esp, 16
	sub	esp, 12
	push	DWORD PTR [ebp-12]
	call	_Z7PutCharj
	add	esp, 16
	mov	DWORD PTR [ebp-12], 1850
	sub	esp, 8
	push	4
	push	112
	call	_out_port
	add	esp, 16
	sub	esp, 12
	push	113
	call	_in_port
	add	esp, 16
	mov	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7bcd2intj
	add	esp, 16
	sub	esp, 8
	push	eax
	push	7
	call	_Z4Putihj
	add	esp, 16
	sub	esp, 12
	push	DWORD PTR [ebp-12]
	call	_Z7PutCharj
	add	esp, 16
	sub	esp, 8
	push	2
	push	112
	call	_out_port
	add	esp, 16
	sub	esp, 12
	push	113
	call	_in_port
	add	esp, 16
	mov	DWORD PTR [ebp-16], eax
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7bcd2intj
	add	esp, 16
	sub	esp, 8
	push	eax
	push	7
	call	_Z4Putihj
	add	esp, 16
	call	_Z7NewLinev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	PrintTime, .-PrintTime
	.globl	_Z7getcharv
	.type	_Z7getcharv, @function
_Z7getcharv:
.LFB19:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 280
	lea	eax, [ebp-268]
	push	eax
	call	_Z12initKeyboardPh
	add	esp, 4
.L69:
	call	sys_getc
	mov	DWORD PTR [ebp-12], eax
	lea	edx, [ebp-268]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	test	al, al
	jne	.L68
	jmp	.L69
.L68:
	lea	edx, [ebp-268]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	movzx	eax, al
	mov	DWORD PTR [ebp-12], eax
	cmp	DWORD PTR [ebp-12], 13
	jne	.L70
	call	_Z7NewLinev
	jmp	.L71
.L70:
	sub	esp, 12
	push	DWORD PTR [ebp-12]
	call	_Z7putcharj
	add	esp, 16
.L71:
	mov	eax, DWORD PTR [ebp-12]
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE19:
	.size	_Z7getcharv, .-_Z7getcharv
	.globl	_Z7putcharj
	.type	_Z7putcharj, @function
_Z7putcharj:
.LFB20:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 8
	cmp	DWORD PTR [ebp+8], 10
	je	.L74
	and	DWORD PTR [ebp+8], 255
	or	DWORD PTR [ebp+8], 1792
	sub	esp, 12
	push	DWORD PTR [ebp+8]
	call	sys_putc
	add	esp, 16
	jmp	.L76
.L74:
	call	_Z7NewLinev
.L76:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	_Z7putcharj, .-_Z7putcharj
	.globl	_Z5scanfPKcz
	.type	_Z5scanfPKcz, @function
_Z5scanfPKcz:
.LFB21:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 40
	lea	eax, [ebp+12]
	mov	DWORD PTR [ebp-32], eax
	mov	DWORD PTR [ebp-28], 0
.L93:
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	test	al, al
	je	.L78
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	cmp	al, 37
	jne	.L79
	inc	DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	test	al, al
	jne	.L80
	mov	eax, DWORD PTR [ebp-28]
	jmp	.L94
.L80:
	mov	eax, DWORD PTR [ebp-32]
	lea	edx, [eax+4]
	mov	DWORD PTR [ebp-32], edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [ebp-12], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	movsx	eax, al
	cmp	eax, 100
	je	.L83
	cmp	eax, 115
	je	.L84
	cmp	eax, 99
	je	.L85
	jmp	.L79
.L85:
	call	_Z7getcharv
	mov	dl, al
	mov	eax, DWORD PTR [ebp-12]
	mov	BYTE PTR [eax], dl
	jmp	.L79
.L83:
	call	_Z7getcharv
	movsx	eax, al
	mov	DWORD PTR [ebp-16], eax
	mov	DWORD PTR [ebp-20], 0
.L88:
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7IsDigiti
	add	esp, 16
	test	al, al
	je	.L87
	sub	DWORD PTR [ebp-16], 48
	mov	edx, DWORD PTR [ebp-20]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-16]
	add	eax, edx
	mov	DWORD PTR [ebp-20], eax
	call	_Z7getcharv
	movsx	eax, al
	mov	DWORD PTR [ebp-16], eax
	jmp	.L88
.L87:
	mov	DWORD PTR [ebp-24], 0
.L90:
	mov	eax, DWORD PTR [ebp-24]
	cmp	eax, 3
	ja	.L95
	mov	eax, DWORD PTR [ebp-20]
	mov	dl, al
	mov	eax, DWORD PTR [ebp-12]
	mov	BYTE PTR [eax], dl
	sar	DWORD PTR [ebp-20], 8
	inc	DWORD PTR [ebp-24]
	inc	DWORD PTR [ebp-12]
	jmp	.L90
.L84:
	call	_Z7getcharv
	mov	DWORD PTR [ebp-16], eax
.L92:
	sub	esp, 12
	push	DWORD PTR [ebp-16]
	call	_Z7IsSpacei
	add	esp, 16
	xor	eax, 1
	test	al, al
	je	.L91
	mov	eax, DWORD PTR [ebp-16]
	mov	dl, al
	mov	eax, DWORD PTR [ebp-12]
	mov	BYTE PTR [eax], dl
	inc	DWORD PTR [ebp-12]
	call	_Z7getcharv
	mov	DWORD PTR [ebp-16], eax
	jmp	.L92
.L91:
	mov	eax, DWORD PTR [ebp-12]
	mov	BYTE PTR [eax], 0
	jmp	.L79
.L95:
	nop
.L79:
	inc	DWORD PTR [ebp+8]
	jmp	.L93
.L78:
	mov	eax, DWORD PTR [ebp-28]
.L94:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	_Z5scanfPKcz, .-_Z5scanfPKcz
	.globl	_Z6printfPKcz
	.type	_Z6printfPKcz, @function
_Z6printfPKcz:
.LFB22:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	sub	esp, 40
	lea	eax, [ebp+12]
	mov	DWORD PTR [ebp-28], eax
	mov	DWORD PTR [ebp-12], 0
	mov	DWORD PTR [ebp-16], 0
.L111:
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	test	al, al
	je	.L97
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	cmp	al, 37
	je	.L98
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	cmp	al, 10
	jne	.L99
	call	_Z7NewLinev
	jmp	.L100
.L99:
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	movsx	eax, al
	sub	esp, 12
	push	eax
	call	_Z7putcharj
	add	esp, 16
.L100:
	inc	DWORD PTR [ebp-16]
	jmp	.L101
.L98:
	inc	DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp+8]
	mov	al, BYTE PTR [eax]
	movsx	eax, al
	cmp	eax, 99
	je	.L103
	cmp	eax, 99
	jg	.L104
	test	eax, eax
	je	.L105
	jmp	.L101
.L104:
	cmp	eax, 100
	je	.L106
	cmp	eax, 115
	je	.L107
	jmp	.L101
.L105:
	mov	eax, DWORD PTR [ebp-16]
	jmp	.L112
.L106:
	mov	eax, DWORD PTR [ebp-28]
	lea	edx, [eax+4]
	mov	DWORD PTR [ebp-28], edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [ebp-24], eax
	mov	eax, DWORD PTR [ebp-24]
	sub	esp, 8
	push	10
	push	eax
	call	_Z9print_intjj
	add	esp, 16
	jmp	.L101
.L103:
	mov	eax, DWORD PTR [ebp-28]
	lea	edx, [eax+4]
	mov	DWORD PTR [ebp-28], edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [ebp-24], eax
	mov	eax, DWORD PTR [ebp-24]
	sub	esp, 12
	push	eax
	call	_Z7putcharj
	add	esp, 16
	jmp	.L101
.L107:
	mov	eax, DWORD PTR [ebp-28]
	lea	edx, [eax+4]
	mov	DWORD PTR [ebp-28], edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [ebp-20], eax
	mov	DWORD PTR [ebp-12], 0
.L110:
	mov	edx, DWORD PTR [ebp-20]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	test	al, al
	je	.L113
	mov	edx, DWORD PTR [ebp-20]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	mov	al, BYTE PTR [eax]
	movsx	eax, al
	sub	esp, 12
	push	eax
	call	_Z7putcharj
	add	esp, 16
	inc	DWORD PTR [ebp-12]
	jmp	.L110
.L113:
	nop
.L101:
	inc	DWORD PTR [ebp+8]
	jmp	.L111
.L97:
	mov	eax, DWORD PTR [ebp-16]
.L112:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	_Z6printfPKcz, .-_Z6printfPKcz
	.globl	_Z9print_intjj
	.type	_Z9print_intjj, @function
_Z9print_intjj:
.LFB23:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	esi
	push	ebx
	sub	esp, 16
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	mov	eax, esp
	mov	ebx, eax
	mov	DWORD PTR [ebp-16], 32
	mov	eax, DWORD PTR [ebp-16]
	lea	ecx, [eax-1]
	mov	DWORD PTR [ebp-20], ecx
	mov	eax, ecx
	inc	eax
	sal	eax, 2
	lea	edx, [eax+3]
	mov	eax, 16
	dec	eax
	add	eax, edx
	mov	esi, 16
	mov	edx, 0
	div	esi
	imul	eax, eax, 16
	sub	esp, eax
	mov	eax, esp
	add	eax, 3
	shr	eax, 2
	sal	eax, 2
	mov	DWORD PTR [ebp-24], eax
	mov	eax, DWORD PTR [ebp-24]
	mov	DWORD PTR [eax], 0
	lea	edx, [eax+4]
	lea	eax, [ecx-1]
.L116:
	test	eax, eax
	js	.L115
	mov	DWORD PTR [edx], 0
	add	edx, 4
	dec	eax
	jmp	.L116
.L115:
	mov	DWORD PTR [ebp-12], 0
.L118:
	cmp	DWORD PTR [ebp+8], 0
	je	.L117
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, 0
	div	DWORD PTR [ebp+12]
	mov	eax, edx
	lea	ecx, [eax+48]
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, DWORD PTR [ebp-12]
	mov	DWORD PTR [eax+edx*4], ecx
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [eax+edx*4]
	or	ah, 7
	mov	ecx, eax
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, DWORD PTR [ebp-12]
	mov	DWORD PTR [eax+edx*4], ecx
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, 0
	div	DWORD PTR [ebp+12]
	mov	DWORD PTR [ebp+8], eax
	inc	DWORD PTR [ebp-12]
	jmp	.L118
.L117:
	mov	eax, DWORD PTR [ebp-16]
	dec	eax
	mov	DWORD PTR [ebp-12], eax
.L120:
	cmp	DWORD PTR [ebp-12], 0
	js	.L119
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [eax+edx*4]
	test	eax, eax
	jne	.L119
	dec	DWORD PTR [ebp-12]
	jmp	.L120
.L119:
	cmp	DWORD PTR [ebp-12], 0
	jns	.L121
	sub	esp, 12
	push	48
	call	_Z7putcharj
	add	esp, 16
	jmp	.L122
.L121:
	cmp	DWORD PTR [ebp-12], 0
	js	.L122
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, DWORD PTR [ebp-12]
	mov	eax, DWORD PTR [eax+edx*4]
	sub	esp, 12
	push	eax
	call	_Z7putcharj
	add	esp, 16
	dec	DWORD PTR [ebp-12]
	jmp	.L121
.L122:
	mov	esp, ebx
	nop
	lea	esp, [ebp-8]
	pop	ebx
	.cfi_restore 3
	pop	esi
	.cfi_restore 6
	pop	ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	_Z9print_intjj, .-_Z9print_intjj
	.section	.rodata
.LC0:
	.string	"%s"
.LC1:
	.string	"%d"
.LC2:
	.string	"ch=%c, a=%d, str=%s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	lea	ecx, [esp+4]
	.cfi_def_cfa 1, 0
	and	esp, -16
	push	DWORD PTR [ecx-4]
	push	ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	mov	ebp, esp
	push	ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	sub	esp, 100
	call	_Z7getcharv
	mov	BYTE PTR [ebp-9], al
	sub	esp, 8
	lea	eax, [ebp-89]
	push	eax
	push	OFFSET FLAT:.LC0
	call	_Z5scanfPKcz
	add	esp, 16
	sub	esp, 8
	lea	eax, [ebp-96]
	push	eax
	push	OFFSET FLAT:.LC1
	call	_Z5scanfPKcz
	add	esp, 16
	movsx	eax, BYTE PTR [ebp-9]
	sub	esp, 12
	push	eax
	call	_Z7putcharj
	add	esp, 16
	sub	esp, 8
	lea	eax, [ebp-89]
	push	eax
	push	OFFSET FLAT:.LC0
	call	_Z6printfPKcz
	add	esp, 16
	mov	edx, DWORD PTR [ebp-96]
	movsx	eax, BYTE PTR [ebp-9]
	lea	ecx, [ebp-89]
	push	ecx
	push	edx
	push	eax
	push	OFFSET FLAT:.LC2
	call	_Z6printfPKcz
	add	esp, 16
	mov	eax, 0
	mov	ecx, DWORD PTR [ebp-4]
	.cfi_def_cfa 1, 0
	leave
	.cfi_restore 5
	lea	esp, [ecx-4]
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (GNU) 7.1.0"
