	.file	"ser.c"
	.text
	.comm	emp_buf,308,32
	.comm	mes_buf,61,32
	.globl	sql
	.bss
	.align 32
	.type	sql, @object
	.size	sql, 500
sql:
	.zero	500
	.globl	db
	.align 8
	.type	db, @object
	.size	db, 8
db:
	.zero	8
	.section	.rodata
	.align 8
.LC0:
	.string	"insert into account_table values(\"%s\",\"%s\",\"%s\",%d);"
	.align 8
.LC1:
	.string	"UNIQUE constraint failed: account_table.account_name"
.LC2:
	.string	"ser.c"
.LC3:
	.string	"%s:%s:%d\n"
.LC4:
	.string	"sqlite3_exec"
	.text
	.globl	do_register
	.type	do_register, @function
do_register:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movq	$48, -32(%rbp)
	movq	$0, -24(%rbp)
	movl	$0, -16(%rbp)
	leaq	-32(%rbp), %rax
	movl	$0, %r9d
	movq	%rax, %r8
	leaq	41+mes_buf(%rip), %rcx
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC0(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-40(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L2
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-40(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L3
	movb	$69, mes_buf(%rip)
	movl	-52(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	jmp	.L4
.L3:
	movl	$39, %ecx
	leaq	__func__.6065(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC4(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L6
.L2:
	movl	-52(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
.L4:
	movl	$0, %eax
.L6:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	do_register, .-do_register
	.section	.rodata
	.align 8
.LC5:
	.string	"select * from account_table where account_name=\"%s\" and passwd=\"%s\";"
.LC6:
	.string	"0"
	.align 8
.LC7:
	.string	"insert into employee_table values(\"%s\", \"%s\", %d, \"%s\" ,%f, \"%s\", \"%s\");"
	.align 8
.LC8:
	.string	"UNIQUE constraint failed: employee_table.wkno"
	.align 8
.LC9:
	.string	"update account_table set workno=\"%s\" where account_name=\"%s\" ;"
	.text
	.globl	employee_add
	.type	employee_add, @function
employee_add:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-36(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	leaq	41+mes_buf(%rip), %rcx
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC5(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -24(%rbp)
	movq	$0, -16(%rbp)
	movq	db(%rip), %rax
	leaq	-24(%rbp), %rdi
	leaq	-28(%rbp), %rsi
	leaq	-32(%rbp), %rcx
	leaq	-16(%rbp), %rdx
	movq	%rdi, %r9
	movq	%rsi, %r8
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movq	-16(%rbp), %rax
	movl	-32(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	-28(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$16, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L9
	movb	$101, mes_buf(%rip)
	movl	-36(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$-1, %eax
	jmp	.L13
.L9:
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movss	156+emp_buf(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	24+emp_buf(%rip), %edx
	leaq	180+emp_buf(%rip), %rax
	pushq	%rax
	leaq	160+emp_buf(%rip), %rax
	pushq	%rax
	leaq	28+emp_buf(%rip), %r9
	movl	%edx, %r8d
	leaq	20+emp_buf(%rip), %rcx
	leaq	emp_buf(%rip), %rdx
	leaq	.LC7(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$1, %eax
	call	sprintf@PLT
	addq	$16, %rsp
	movq	db(%rip), %rax
	leaq	-24(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L11
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-24(%rbp), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L12
	movb	$69, mes_buf(%rip)
	movl	-36(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$-1, %eax
	jmp	.L13
.L12:
	movl	$81, %ecx
	leaq	__func__.6073(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC4(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L13
.L11:
	movl	-36(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	leaq	1+mes_buf(%rip), %rcx
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC9(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-24(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	movl	$0, %eax
.L13:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	employee_add, .-employee_add
	.section	.rodata
	.align 8
.LC10:
	.string	"update employee_table set name=\"%s\",age=%d,address=\"%s\",phone=\"%s\" where wkno=\"%s\";"
	.text
	.globl	employee_modif
	.type	employee_modif, @function
employee_modif:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movl	%edi, -548(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	41+mes_buf(%rip), %rcx
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -528(%rbp)
	movq	$0, -520(%rbp)
	movq	db(%rip), %rax
	leaq	-528(%rbp), %r8
	leaq	-532(%rbp), %rdi
	leaq	-536(%rbp), %rcx
	leaq	-520(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	-532(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$16, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	160+emp_buf(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L16
	movb	$69, mes_buf(%rip)
	jmp	.L17
.L16:
	leaq	-512(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	movl	24+emp_buf(%rip), %edx
	leaq	-512(%rbp), %rax
	subq	$8, %rsp
	leaq	160+emp_buf(%rip), %rcx
	pushq	%rcx
	leaq	180+emp_buf(%rip), %r9
	leaq	28+emp_buf(%rip), %r8
	movl	%edx, %ecx
	leaq	emp_buf(%rip), %rdx
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	addq	$16, %rsp
	leaq	-512(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	db(%rip), %rax
	leaq	-528(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
.L17:
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L19
	call	__stack_chk_fail@PLT
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	employee_modif, .-employee_modif
	.section	.rodata
	.align 8
.LC11:
	.string	"select * from employee_table where wkno=\"%s\";"
	.text
	.globl	employee_search
	.type	employee_search, @function
employee_search:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1072, %rsp
	movl	%edi, -1060(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-1060(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	leaq	-1024(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-1024(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -1040(%rbp)
	movq	$0, -1032(%rbp)
	movq	db(%rip), %rax
	leaq	-1040(%rbp), %r8
	leaq	-1044(%rbp), %rdi
	leaq	-1048(%rbp), %rcx
	leaq	-1032(%rbp), %rdx
	leaq	-1024(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movl	-1048(%rbp), %eax
	testl	%eax, %eax
	jne	.L21
	movb	$69, mes_buf(%rip)
	movl	-1060(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	jmp	.L22
.L21:
	movl	-1060(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	41+mes_buf(%rip), %rcx
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-1040(%rbp), %r8
	leaq	-1044(%rbp), %rdi
	leaq	-1048(%rbp), %rcx
	leaq	-1032(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	-1044(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$16, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	-1044(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$16, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	160+emp_buf(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L23
	leaq	-1024(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	leaq	-1024(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-1040(%rbp), %r8
	leaq	-1044(%rbp), %rdi
	leaq	-1048(%rbp), %rcx
	leaq	-1032(%rbp), %rdx
	leaq	-1024(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movl	$308, %edx
	movl	$0, %esi
	leaq	emp_buf(%rip), %rdi
	call	memset@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$1, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	20+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$5, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	160+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$6, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	180+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movl	-1060(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$308, %edx
	movl	$0, %esi
	leaq	emp_buf(%rip), %rdi
	call	memset@PLT
	jmp	.L22
.L23:
	leaq	-1024(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	leaq	-1024(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-1040(%rbp), %r8
	leaq	-1044(%rbp), %rdi
	leaq	-1048(%rbp), %rcx
	leaq	-1032(%rbp), %rdx
	leaq	-1024(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movl	$308, %edx
	movl	$0, %esi
	leaq	emp_buf(%rip), %rdi
	call	memset@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$1, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	20+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	addq	$2, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, 24+emp_buf(%rip)
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$3, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	28+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$4, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, 156+emp_buf(%rip)
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$5, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	160+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-1032(%rbp), %rax
	movl	-1048(%rbp), %ecx
	movl	-1044(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$6, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	180+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movl	-1060(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$308, %edx
	movl	$0, %esi
	leaq	emp_buf(%rip), %rdi
	call	memset@PLT
.L22:
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	employee_search, .-employee_search
	.section	.rodata
	.align 8
.LC12:
	.string	"update account_table set flag = 0 where account_name=\"%s\" ;"
.LC13:
	.string	"sqlite3_exec:%s %d\n"
	.text
	.globl	do_back
	.type	do_back, @function
do_back:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC12(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L28
	movq	-16(%rbp), %rax
	movl	$188, %edx
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L30
.L28:
	movl	$0, %eax
.L30:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L31
	call	__stack_chk_fail@PLT
.L31:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	do_back, .-do_back
	.section	.rodata
	.align 8
.LC14:
	.string	"update account_table set flag = 1 where account_name=\"%s\" ;"
	.text
	.globl	employee_load
	.type	employee_load, @function
employee_load:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movl	%edi, -548(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	41+mes_buf(%rip), %rcx
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -528(%rbp)
	movq	$0, -520(%rbp)
	movq	db(%rip), %rax
	leaq	-528(%rbp), %r8
	leaq	-532(%rbp), %rdi
	leaq	-536(%rbp), %rcx
	leaq	-520(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	testl	%eax, %eax
	je	.L33
	movq	-528(%rbp), %rax
	movl	$204, %edx
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L38
.L33:
	movl	-536(%rbp), %eax
	testl	%eax, %eax
	jne	.L35
	movb	$78, mes_buf(%rip)
	jmp	.L36
.L35:
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	-532(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L37
	movb	$79, mes_buf(%rip)
	leaq	-512(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	leaq	-512(%rbp), %rax
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-528(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L36
	movq	-528(%rbp), %rax
	movl	$222, %edx
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L38
.L37:
	movb	$69, mes_buf(%rip)
	movl	$20, %esi
	leaq	1+mes_buf(%rip), %rdi
	call	bzero@PLT
.L36:
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$0, %eax
.L38:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L39
	call	__stack_chk_fail@PLT
.L39:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	employee_load, .-employee_load
	.section	.rodata
	.align 8
.LC15:
	.string	"select * from admin_table where admin_name=\"%s\" and passwd=\"%s\";"
	.align 8
.LC16:
	.string	"update admin_table set flag = 1 where admin_name=\"%s\" ;"
	.text
	.globl	admin_load
	.type	admin_load, @function
admin_load:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movl	%edi, -548(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	41+mes_buf(%rip), %rcx
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC15(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -528(%rbp)
	movq	$0, -520(%rbp)
	movq	db(%rip), %rax
	leaq	-528(%rbp), %r8
	leaq	-532(%rbp), %rdi
	leaq	-536(%rbp), %rcx
	leaq	-520(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	testl	%eax, %eax
	je	.L41
	movq	-528(%rbp), %rax
	movl	$247, %edx
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L46
.L41:
	movl	-536(%rbp), %eax
	testl	%eax, %eax
	jne	.L43
	movb	$78, mes_buf(%rip)
	jmp	.L44
.L43:
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	-532(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L45
	movb	$79, mes_buf(%rip)
	leaq	-512(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	leaq	-512(%rbp), %rax
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC16(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-528(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L44
	movq	-528(%rbp), %rax
	movl	$265, %edx
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L46
.L45:
	movb	$69, mes_buf(%rip)
	movl	$20, %esi
	leaq	1+mes_buf(%rip), %rdi
	call	bzero@PLT
.L44:
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$0, %eax
.L46:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L47
	call	__stack_chk_fail@PLT
.L47:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	admin_load, .-admin_load
	.globl	admin_add
	.type	admin_add, @function
admin_add:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-20(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movss	156+emp_buf(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	24+emp_buf(%rip), %edx
	leaq	180+emp_buf(%rip), %rax
	pushq	%rax
	leaq	160+emp_buf(%rip), %rax
	pushq	%rax
	leaq	28+emp_buf(%rip), %r9
	movl	%edx, %r8d
	leaq	20+emp_buf(%rip), %rcx
	leaq	emp_buf(%rip), %rdx
	leaq	.LC7(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$1, %eax
	call	sprintf@PLT
	addq	$16, %rsp
	movq	db(%rip), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L49
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-16(%rbp), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L50
	movb	$69, mes_buf(%rip)
	movl	-20(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$-1, %eax
	jmp	.L52
.L50:
	movl	$302, %ecx
	leaq	__func__.6115(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC4(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L52
.L49:
	movl	-20(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$0, %eax
.L52:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L53
	call	__stack_chk_fail@PLT
.L53:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	admin_add, .-admin_add
	.section	.rodata
	.align 8
.LC17:
	.string	"delete from employee_table where wkno=\"%s\";"
	.text
	.globl	admin_del
	.type	admin_del, @function
admin_del:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movl	%edi, -548(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -528(%rbp)
	movq	$0, -520(%rbp)
	movq	db(%rip), %rax
	leaq	-528(%rbp), %r8
	leaq	-532(%rbp), %rdi
	leaq	-536(%rbp), %rcx
	leaq	-520(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movl	-536(%rbp), %eax
	testl	%eax, %eax
	jne	.L55
	movb	$69, mes_buf(%rip)
	jmp	.L56
.L55:
	leaq	-512(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	leaq	-512(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC17(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	-512(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	db(%rip), %rax
	leaq	-528(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
.L56:
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L58
	call	__stack_chk_fail@PLT
.L58:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	admin_del, .-admin_del
	.section	.rodata
	.align 8
.LC18:
	.string	"update employee_table set name=\"%s\",sex=\"%s\",age=%d,address=\"%s\",salary=%f,phone=\"%s\" where wkno=\"%s\";"
	.text
	.globl	admin_modif
	.type	admin_modif, @function
admin_modif:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movl	%edi, -548(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -528(%rbp)
	movq	$0, -520(%rbp)
	movq	db(%rip), %rax
	leaq	-528(%rbp), %r8
	leaq	-532(%rbp), %rdi
	leaq	-536(%rbp), %rcx
	leaq	-520(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movl	-536(%rbp), %eax
	testl	%eax, %eax
	jne	.L60
	movb	$69, mes_buf(%rip)
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	jmp	.L61
.L60:
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	leaq	-512(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	bzero@PLT
	movss	156+emp_buf(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	24+emp_buf(%rip), %ecx
	leaq	-512(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	pushq	%rdx
	leaq	180+emp_buf(%rip), %rdx
	pushq	%rdx
	leaq	28+emp_buf(%rip), %r9
	movl	%ecx, %r8d
	leaq	20+emp_buf(%rip), %rcx
	leaq	emp_buf(%rip), %rdx
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	sprintf@PLT
	addq	$16, %rsp
	movq	db(%rip), %rax
	leaq	-528(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
.L61:
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L63
	call	__stack_chk_fail@PLT
.L63:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	admin_modif, .-admin_modif
	.globl	admin_search
	.type	admin_search, @function
admin_search:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movl	%edi, -548(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	leaq	-512(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	leaq	-512(%rbp), %rax
	leaq	160+emp_buf(%rip), %rdx
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	$0, -528(%rbp)
	movq	$0, -520(%rbp)
	movq	db(%rip), %rax
	leaq	-528(%rbp), %r8
	leaq	-532(%rbp), %rdi
	leaq	-536(%rbp), %rcx
	leaq	-520(%rbp), %rdx
	leaq	-512(%rbp), %rsi
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	sqlite3_get_table@PLT
	movl	-536(%rbp), %eax
	testl	%eax, %eax
	jne	.L65
	movb	$69, mes_buf(%rip)
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	jmp	.L66
.L65:
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	addq	$1, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	20+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	imull	%ecx, %edx
	movslq	%edx, %rdx
	addq	$2, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, 24+emp_buf(%rip)
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$3, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	28+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$4, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, 156+emp_buf(%rip)
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$5, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	160+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movq	-520(%rbp), %rax
	movl	-536(%rbp), %ecx
	movl	-532(%rbp), %edx
	addl	%ecx, %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addq	$6, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	180+emp_buf(%rip), %rdi
	call	strcpy@PLT
	movl	-548(%rbp), %eax
	movl	$0, %ecx
	movl	$308, %edx
	leaq	emp_buf(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	movl	$308, %edx
	movl	$0, %esi
	leaq	emp_buf(%rip), %rdi
	call	memset@PLT
.L66:
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L68
	call	__stack_chk_fail@PLT
.L68:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	admin_search, .-admin_search
	.section	.rodata
	.align 8
.LC19:
	.string	"update admin_table set flag = 0 where admin_name=\"%s\" ;"
	.text
	.globl	admin_back
	.type	admin_back, @function
admin_back:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	leaq	1+mes_buf(%rip), %rdx
	leaq	.LC19(%rip), %rsi
	leaq	sql(%rip), %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	db(%rip), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	testl	%eax, %eax
	je	.L70
	movq	-16(%rbp), %rax
	movl	$411, %edx
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L72
.L70:
	movl	$0, %eax
.L72:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L73
	call	__stack_chk_fail@PLT
.L73:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	admin_back, .-admin_back
	.section	.rodata
.LC20:
	.string	"%ld\n"
.LC21:
	.string	"recv"
.LC22:
	.string	"%d\345\205\263\351\227\255\n"
.LC23:
	.string	"\344\270\273\350\217\234\345\215\225\357\274\232\350\257\267\351\207\215\346\226\260\350\276\223\345\205\245"
	.text
	.globl	rcv_cli_msg
	.type	rcv_cli_msg, @function
rcv_cli_msg:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	pthread_self@PLT
	movq	%rax, %rdi
	call	pthread_detach@PLT
	movq	-56(%rbp), %rcx
	movq	(%rcx), %rax
	movq	8(%rcx), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movl	16(%rcx), %eax
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -44(%rbp)
	movq	$0, -40(%rbp)
.L92:
	movl	-44(%rbp), %eax
	movl	$0, %ecx
	movl	$61, %edx
	leaq	mes_buf(%rip), %rsi
	movl	%eax, %edi
	call	recv@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jns	.L75
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$432, %ecx
	leaq	__func__.6150(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC21(%rip), %rdi
	call	perror@PLT
	jmp	.L76
.L75:
	cmpq	$0, -40(%rbp)
	jne	.L76
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %edi
	call	pthread_exit@PLT
.L76:
	movzbl	mes_buf(%rip), %eax
	movsbl	%al, %eax
	subl	$65, %eax
	cmpl	$50, %eax
	ja	.L77
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L79(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax, %rdx
	leaq	.L79(%rip), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L79:
	.long	.L78-.L79
	.long	.L80-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L81-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L82-.L79
	.long	.L83-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L84-.L79
	.long	.L85-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L86-.L79
	.long	.L87-.L79
	.long	.L77-.L79
	.long	.L88-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L89-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L77-.L79
	.long	.L90-.L79
	.text
.L84:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	do_register
	jmp	.L91
.L82:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	employee_load
	jmp	.L91
.L78:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	employee_add
	jmp	.L91
.L81:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	employee_modif
	jmp	.L91
.L85:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	employee_search
	jmp	.L91
.L80:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	do_back
	jmp	.L91
.L83:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	admin_load
	jmp	.L91
.L86:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	admin_add
	jmp	.L91
.L88:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	admin_del
	jmp	.L91
.L89:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	admin_modif
	jmp	.L91
.L90:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	admin_search
	jmp	.L91
.L87:
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	admin_back
	jmp	.L91
.L77:
	leaq	.LC23(%rip), %rdi
	call	puts@PLT
.L91:
	jmp	.L92
	.cfi_endproc
.LFE17:
	.size	rcv_cli_msg, .-rcv_cli_msg
	.section	.rodata
.LC24:
	.string	"socket"
.LC25:
	.string	"setsockopt"
.LC26:
	.string	"192.168.1.188"
.LC27:
	.string	"bind"
.LC28:
	.string	"listen"
.LC29:
	.string	"\350\256\276\347\275\256\347\233\221\345\220\254\346\210\220\345\212\237"
.LC30:
	.string	"accept"
.LC31:
	.string	"newfd=%d \n"
	.text
	.globl	init_net
	.type	init_net, @function
init_net:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, -80(%rbp)
	cmpl	$0, -80(%rbp)
	jns	.L95
	movl	$492, %ecx
	leaq	__func__.6169(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC24(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L102
.L95:
	movl	$1, -88(%rbp)
	leaq	-88(%rbp), %rdx
	movl	-80(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt@PLT
	testl	%eax, %eax
	jns	.L97
	movl	$498, %ecx
	leaq	__func__.6169(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC25(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L102
.L97:
	movw	$2, -64(%rbp)
	movl	$1024, %edi
	call	htons@PLT
	movw	%ax, -62(%rbp)
	leaq	.LC26(%rip), %rdi
	call	inet_addr@PLT
	movl	%eax, -60(%rbp)
	leaq	-64(%rbp), %rcx
	movl	-80(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
	testl	%eax, %eax
	jns	.L98
	movl	$508, %ecx
	leaq	__func__.6169(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC27(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L102
.L98:
	movl	-80(%rbp), %eax
	movl	$10, %esi
	movl	%eax, %edi
	call	listen@PLT
	testl	%eax, %eax
	jns	.L99
	movl	$514, %ecx
	leaq	__func__.6169(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC28(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L102
.L99:
	leaq	.LC29(%rip), %rdi
	call	puts@PLT
	movl	$16, -84(%rbp)
.L101:
	leaq	-84(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	movl	-80(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept@PLT
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	jns	.L100
	movl	$531, %ecx
	leaq	__func__.6169(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC30(%rip), %rdi
	call	perror@PLT
	movl	$-1, %eax
	jmp	.L102
.L100:
	movl	-76(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC31(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-76(%rbp), %eax
	movl	%eax, -16(%rbp)
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	leaq	-32(%rbp), %rdx
	leaq	-72(%rbp), %rax
	movq	%rdx, %rcx
	leaq	rcv_cli_msg(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	jmp	.L101
.L102:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L103
	call	__stack_chk_fail@PLT
.L103:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	init_net, .-init_net
	.section	.rodata
.LC32:
	.string	"./my.db"
.LC33:
	.string	"%s\n"
.LC34:
	.string	"\346\211\223\345\274\200\346\225\260\346\215\256\345\272\223"
.LC35:
	.string	"\345\210\233\345\273\272\350\241\250\346\210\220\345\212\237"
	.text
	.globl	create_mydatebase
	.type	create_mydatebase, @function
create_mydatebase:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	subq	$1552, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	movq	%fs:40, %rax
	movq	%rax, -40(%rbp)
	xorl	%eax, %eax
	movq	$0, -1576(%rbp)
	leaq	db(%rip), %rsi
	leaq	.LC32(%rip), %rdi
	call	sqlite3_open@PLT
	testl	%eax, %eax
	je	.L105
	movq	db(%rip), %rax
	movq	%rax, %rdi
	call	sqlite3_errmsg@PLT
	movq	%rax, %rdx
	movq	stderr(%rip), %rax
	leaq	.LC33(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$-1, %eax
	jmp	.L107
.L105:
	leaq	.LC34(%rip), %rdi
	call	puts@PLT
	movabsq	$8367799658179031651, %r14
	movabsq	$2334669044699652705, %r15
	movq	%r14, -1568(%rbp)
	movq	%r15, -1560(%rbp)
	movabsq	$8316310562647863150, %rax
	movabsq	$8462091503334880116, %rdx
	movq	%rax, -1552(%rbp)
	movq	%rdx, -1544(%rbp)
	movabsq	$7308324466019234926, %rax
	movabsq	$8389772277107089704, %rdx
	movq	%rax, -1536(%rbp)
	movq	%rdx, -1528(%rbp)
	movabsq	$7521891422637747807, %rax
	movabsq	$7020383334368834145, %rdx
	movq	%rax, -1520(%rbp)
	movq	%rdx, -1512(%rbp)
	movabsq	$8082968907719145842, %rax
	movabsq	$7521891418511733601, %rdx
	movq	%rax, -1504(%rbp)
	movq	%rdx, -1496(%rbp)
	movabsq	$7956578989746451041, %rax
	movabsq	$7362385253532639343, %rdx
	movq	%rax, -1488(%rbp)
	movq	%rdx, -1480(%rbp)
	movabsq	$2987133850647748972, %r12
	movl	$0, %r13d
	movq	%r12, -1472(%rbp)
	movq	%r13, -1464(%rbp)
	leaq	-1456(%rbp), %rdx
	movl	$0, %eax
	movl	$48, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	movq	db(%rip), %rax
	leaq	-1576(%rbp), %rdx
	leaq	-1568(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	movq	%r14, -1056(%rbp)
	movq	%r15, -1048(%rbp)
	movabsq	$8316310562647863150, %rax
	movabsq	$7956010494620365684, %rdx
	movq	%rax, -1040(%rbp)
	movq	%rdx, -1032(%rbp)
	movabsq	$7000957136928863327, %rax
	movabsq	$7881702179028430180, %rdx
	movq	%rax, -1024(%rbp)
	movq	%rdx, -1016(%rbp)
	movabsq	$8079583494191390821, %rax
	movabsq	$7719303293480823154, %rdx
	movq	%rax, -1008(%rbp)
	movq	%rdx, -1000(%rbp)
	movabsq	$8607350175166134629, %rax
	movabsq	$7362385253532639332, %rdx
	movq	%rax, -992(%rbp)
	movq	%rdx, -984(%rbp)
	movq	%r12, -976(%rbp)
	movq	%r13, -968(%rbp)
	leaq	-960(%rbp), %rdx
	movl	$0, %eax
	movl	$50, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	movq	db(%rip), %rax
	leaq	-1576(%rbp), %rdx
	leaq	-1056(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movabsq	$7575182607914331753, %r12
	movabsq	$7596838514762675310, %r13
	movq	%r12, sql(%rip)
	movq	%r13, 8+sql(%rip)
	movabsq	$2334391151659081582, %rax
	movabsq	$2821632046146543990, %rdx
	movq	%rax, 16+sql(%rip)
	movq	%rdx, 24+sql(%rip)
	movabsq	$3181566012045485153, %rsi
	movabsq	$2825504314535063847, %rdi
	movq	%rsi, 32+sql(%rip)
	movq	%rdi, 40+sql(%rip)
	movl	$992555052, 48+sql(%rip)
	movb	$0, 52+sql(%rip)
	movq	db(%rip), %rax
	leaq	-1576(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movq	%r12, sql(%rip)
	movq	%r13, 8+sql(%rip)
	movabsq	$2334391151659081582, %rax
	movabsq	$2821632046146543990, %rdx
	movq	%rax, 16+sql(%rip)
	movq	%rdx, 24+sql(%rip)
	movabsq	$3181567111557112929, %rax
	movabsq	$2823809949886328871, %rdx
	movq	%rax, 32+sql(%rip)
	movq	%rdx, 40+sql(%rip)
	movl	$992555052, 48+sql(%rip)
	movb	$0, 52+sql(%rip)
	movq	db(%rip), %rax
	leaq	-1576(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	movq	%r14, -544(%rbp)
	movq	%r15, -536(%rbp)
	movabsq	$8316310562647863150, %rax
	movabsq	$8028915850845123444, %rdx
	movq	%rax, -528(%rbp)
	movq	%rdx, -520(%rbp)
	movabsq	$7809911856258442617, %rax
	movabsq	$7142820529470056549, %rdx
	movq	%rax, -512(%rbp)
	movq	%rdx, -504(%rbp)
	movabsq	$2339731551760310632, %rax
	movabsq	$7306915763957360739, %rdx
	movq	%rax, -496(%rbp)
	movq	%rdx, -488(%rbp)
	movabsq	$7234013745023707424, %rax
	movabsq	$7018969010283963762, %rdx
	movq	%rax, -480(%rbp)
	movq	%rdx, -472(%rbp)
	movabsq	$8751164144053595250, %rax
	movabsq	$8587366551318717984, %rdx
	movq	%rax, -464(%rbp)
	movq	%rdx, -456(%rbp)
	movabsq	$8241983568019943019, %rax
	movabsq	$8751164148482732064, %rdx
	movq	%rax, -448(%rbp)
	movq	%rdx, -440(%rbp)
	movabsq	$8027789672105470752, %rax
	movabsq	$2986556603867620718, %rdx
	movq	%rax, -432(%rbp)
	movq	%rdx, -424(%rbp)
	movq	$0, -416(%rbp)
	movq	$0, -408(%rbp)
	leaq	-400(%rbp), %rdx
	movl	$0, %eax
	movl	$44, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	movq	db(%rip), %rax
	leaq	-1576(%rbp), %rdx
	leaq	-544(%rbp), %rsi
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	leaq	.LC35(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
.L107:
	movq	-40(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L108
	call	__stack_chk_fail@PLT
.L108:
	addq	$1552, %rsp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	create_mydatebase, .-create_mydatebase
	.globl	main
	.type	main, @function
main:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	call	create_mydatebase
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movabsq	$6998705371458334837, %rax
	movabsq	$7089075241680989540, %rdx
	movq	%rax, sql(%rip)
	movq	%rdx, 8+sql(%rip)
	movabsq	$7359009770195412332, %rax
	movabsq	$4264944294028599660, %rdx
	movq	%rax, 16+sql(%rip)
	movq	%rdx, 24+sql(%rip)
	movb	$0, 32+sql(%rip)
	movq	db(%rip), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	movl	$500, %esi
	leaq	sql(%rip), %rdi
	call	bzero@PLT
	movabsq	$6998705371458334837, %rax
	movabsq	$8385549048952611683, %rdx
	movq	%rax, sql(%rip)
	movq	%rdx, 8+sql(%rip)
	movabsq	$8387236464025166433, %rax
	movabsq	$2323048611181258272, %rdx
	movq	%rax, 16+sql(%rip)
	movq	%rdx, 24+sql(%rip)
	movw	$15152, 32+sql(%rip)
	movb	$0, 34+sql(%rip)
	movq	db(%rip), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	sql(%rip), %rsi
	movq	%rax, %rdi
	call	sqlite3_exec@PLT
	call	init_net
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L111
	call	__stack_chk_fail@PLT
.L111:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__func__.6065, @object
	.size	__func__.6065, 12
__func__.6065:
	.string	"do_register"
	.align 8
	.type	__func__.6073, @object
	.size	__func__.6073, 13
__func__.6073:
	.string	"employee_add"
	.align 8
	.type	__func__.6115, @object
	.size	__func__.6115, 10
__func__.6115:
	.string	"admin_add"
	.align 8
	.type	__func__.6150, @object
	.size	__func__.6150, 12
__func__.6150:
	.string	"rcv_cli_msg"
	.align 8
	.type	__func__.6169, @object
	.size	__func__.6169, 9
__func__.6169:
	.string	"init_net"
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
