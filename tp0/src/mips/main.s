	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"-h\000"
	.align	2
$LC1:
	.ascii	"--help\000"
	.align	2
$LC2:
	.ascii	"-V\000"
	.align	2
$LC3:
	.ascii	"--version\000"
	.align	2
$LC4:
	.ascii	"w+\000"
	.align	2
$LC5:
	.ascii	"Output File '%s' doesn't exist.\n\000"
	.align	2
$LC6:
	.ascii	"r\000"
	.align	2
$LC7:
	.ascii	"Input File '%s' doesn't exist.\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,64,$31		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$31,56($sp)
	sw	$fp,52($sp)
	sw	$28,48($sp)
	move	$fp,$sp
	sw	$4,64($fp)
	sw	$5,68($fp)
	sw	$0,28($fp)
	la	$2,__sF
	sw	$2,32($fp)
	la	$2,__sF+88
	sw	$2,36($fp)
	lw	$4,64($fp)
	la	$25,readFromStdInput
	jal	$31,$25
	beq	$2,$0,$L18
	lw	$4,32($fp)
	lw	$5,36($fp)
	la	$25,matrices_multiply
	jal	$31,$25
	sw	$2,28($fp)
	b	$L19
$L18:
	lw	$2,64($fp)
	slt	$2,$2,2
	bne	$2,$0,$L19
	lw	$2,68($fp)
	addu	$2,$2,4
	lw	$2,0($2)
	sw	$2,24($fp)
	lw	$4,24($fp)
	la	$5,$LC0
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L22
	lw	$4,24($fp)
	la	$5,$LC1
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L21
$L22:
	la	$25,printHelp
	jal	$31,$25
	sw	$0,40($fp)
	b	$L17
$L21:
	lw	$4,24($fp)
	la	$5,$LC2
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L25
	lw	$4,24($fp)
	la	$5,$LC3
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L24
$L25:
	la	$25,printVersion
	jal	$31,$25
	sw	$0,40($fp)
	b	$L17
$L24:
	lw	$3,64($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L27
	lw	$2,68($fp)
	addu	$2,$2,4
	lw	$4,0($2)
	la	$5,$LC4
	la	$25,fopen
	jal	$31,$25
	sw	$2,36($fp)
	lw	$2,36($fp)
	bne	$2,$0,$L23
	lw	$2,68($fp)
	addu	$2,$2,4
	la	$4,__sF+176
	la	$5,$LC5
	lw	$6,0($2)
	la	$25,fprintf
	jal	$31,$25
	li	$4,10			# 0xa
	la	$25,exit
	jal	$31,$25
$L27:
	lw	$2,68($fp)
	addu	$2,$2,4
	lw	$4,0($2)
	la	$5,$LC6
	la	$25,fopen
	jal	$31,$25
	sw	$2,32($fp)
	lw	$2,32($fp)
	bne	$2,$0,$L30
	lw	$2,68($fp)
	addu	$2,$2,4
	la	$4,__sF+176
	la	$5,$LC7
	lw	$6,0($2)
	la	$25,fprintf
	jal	$31,$25
	li	$4,10			# 0xa
	la	$25,exit
	jal	$31,$25
$L30:
	lw	$2,68($fp)
	addu	$2,$2,8
	lw	$4,0($2)
	la	$5,$LC4
	la	$25,fopen
	jal	$31,$25
	sw	$2,36($fp)
	lw	$2,36($fp)
	bne	$2,$0,$L23
	lw	$2,68($fp)
	addu	$2,$2,8
	la	$4,__sF+176
	la	$5,$LC5
	lw	$6,0($2)
	la	$25,fprintf
	jal	$31,$25
	li	$4,10			# 0xa
	la	$25,exit
	jal	$31,$25
$L23:
	lw	$4,32($fp)
	lw	$5,36($fp)
	la	$25,matrices_multiply
	jal	$31,$25
	sw	$2,28($fp)
$L19:
	lw	$2,28($fp)
	sw	$2,40($fp)
$L17:
	lw	$2,40($fp)
	move	$sp,$fp
	lw	$31,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$31
	.end	main
	.size	main, .-main
	.align	2
	.globl	create_matrix
	.ent	create_matrix
create_matrix:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	sw	$4,48($fp)
	sw	$5,52($fp)
	li	$4,12			# 0xc
	la	$25,malloc
	jal	$31,$25
	sw	$2,24($fp)
	lw	$3,24($fp)
	lw	$2,48($fp)
	sw	$2,0($3)
	lw	$3,24($fp)
	lw	$2,52($fp)
	sw	$2,4($3)
	lw	$2,24($fp)
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	create_matrix
	.size	create_matrix, .-create_matrix
	.align	2
	.globl	destroy_matrix
	.ent	destroy_matrix
destroy_matrix:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	lw	$4,40($fp)
	la	$25,free
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	destroy_matrix
	.size	destroy_matrix, .-destroy_matrix
	.rdata
	.align	2
$LC8:
	.ascii	"%d\000"
	.align	2
$LC9:
	.ascii	" %f\000"
	.align	2
$LC10:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	print_matrix
	.ent	print_matrix
print_matrix:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	sw	$4,48($fp)
	sw	$5,52($fp)
	sw	$0,24($fp)
	lw	$2,52($fp)
	lw	$2,0($2)
	sw	$2,28($fp)
	lw	$4,48($fp)
	la	$5,$LC8
	lw	$6,28($fp)
	la	$25,fprintf
	jal	$31,$25
	sw	$0,24($fp)
$L35:
	lw	$3,28($fp)
	lw	$2,28($fp)
	mult	$3,$2
	mflo	$3
	lw	$2,24($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L38
	b	$L36
$L38:
	lw	$4,52($fp)
	lw	$2,24($fp)
	sll	$3,$2,3
	lw	$2,8($4)
	addu	$2,$3,$2
	lw	$4,48($fp)
	la	$5,$LC9
	lw	$6,0($2)
	lw	$7,4($2)
	la	$25,fprintf
	jal	$31,$25
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	b	$L35
$L36:
	lw	$4,48($fp)
	la	$5,$LC10
	la	$25,fprintf
	jal	$31,$25
	move	$2,$0
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	print_matrix
	.size	print_matrix, .-print_matrix
	.align	2
	.globl	matrix_multiply
	.ent	matrix_multiply
matrix_multiply:
	.frame	$fp,80,$31		# vars= 40, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$28,68($sp)
	sw	$16,64($sp)
	move	$fp,$sp
	sw	$4,80($fp)
	sw	$5,84($fp)
	lw	$2,80($fp)
	lw	$3,80($fp)
	lw	$4,0($2)
	lw	$5,4($3)
	la	$25,create_matrix
	jal	$31,$25
	sw	$2,24($fp)
	lw	$16,24($fp)
	lw	$2,80($fp)
	lw	$3,80($fp)
	lw	$4,0($2)
	lw	$2,4($3)
	mult	$4,$2
	mflo	$2
	sll	$2,$2,3
	move	$4,$2
	la	$25,malloc
	jal	$31,$25
	sw	$2,8($16)
	lw	$2,80($fp)
	lw	$2,0($2)
	sw	$2,40($fp)
	sw	$0,44($fp)
	sw	$0,48($fp)
	sw	$0,52($fp)
	sw	$0,56($fp)
$L40:
	lw	$3,40($fp)
	lw	$2,40($fp)
	mult	$3,$2
	mflo	$3
	lw	$2,52($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L44
	b	$L41
$L44:
	lw	$2,56($fp)
	lw	$3,40($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L47
	b	$L45
$L47:
	sw	$0,32($fp)
	sw	$0,36($fp)
$L48:
	lw	$3,40($fp)
	lw	$2,40($fp)
	mult	$3,$2
	mflo	$3
	lw	$2,48($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L51
	b	$L49
$L51:
	lw	$4,80($fp)
	lw	$2,44($fp)
	sll	$3,$2,3
	lw	$2,8($4)
	addu	$5,$3,$2
	lw	$4,84($fp)
	lw	$2,48($fp)
	sll	$3,$2,3
	lw	$2,8($4)
	addu	$2,$3,$2
	l.d	$f2,0($5)
	l.d	$f0,0($2)
	mul.d	$f2,$f2,$f0
	l.d	$f0,32($fp)
	add.d	$f0,$f0,$f2
	s.d	$f0,32($fp)
	lw	$2,44($fp)
	addu	$2,$2,1
	sw	$2,44($fp)
	lw	$3,48($fp)
	lw	$2,40($fp)
	addu	$2,$3,$2
	sw	$2,48($fp)
	b	$L48
$L49:
	lw	$3,40($fp)
	lw	$2,40($fp)
	mult	$3,$2
	mflo	$3
	lw	$2,48($fp)
	subu	$2,$2,$3
	sw	$2,48($fp)
	lw	$3,44($fp)
	lw	$2,40($fp)
	subu	$2,$3,$2
	sw	$2,44($fp)
	lw	$4,24($fp)
	lw	$2,52($fp)
	sll	$3,$2,3
	lw	$2,8($4)
	addu	$2,$3,$2
	l.d	$f0,32($fp)
	s.d	$f0,0($2)
	lw	$2,48($fp)
	addu	$2,$2,1
	sw	$2,48($fp)
	lw	$2,52($fp)
	addu	$2,$2,1
	sw	$2,52($fp)
	lw	$2,56($fp)
	addu	$2,$2,1
	sw	$2,56($fp)
	b	$L44
$L45:
	sw	$0,56($fp)
	sw	$0,48($fp)
	lw	$2,44($fp)
	lw	$3,40($fp)
	addu	$2,$2,$3
	sw	$2,44($fp)
	b	$L40
$L41:
	lw	$2,24($fp)
	move	$sp,$fp
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$16,64($sp)
	addu	$sp,$sp,80
	j	$31
	.end	matrix_multiply
	.size	matrix_multiply, .-matrix_multiply
	.rdata
	.align	2
$LC11:
	.ascii	" \000"
	.text
	.align	2
	.globl	read_arguments
	.ent	read_arguments
read_arguments:
	.frame	$fp,72,$31		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$31,64($sp)
	sw	$fp,60($sp)
	sw	$28,56($sp)
	move	$fp,$sp
	sw	$4,72($fp)
	sw	$5,76($fp)
	sw	$6,80($fp)
	la	$2,$LC11
	sw	$2,28($fp)
	sw	$0,32($fp)
	sw	$0,36($fp)
	sw	$0,48($fp)
	lw	$4,72($fp)
	lw	$5,28($fp)
	la	$25,strtok
	jal	$31,$25
	sw	$2,24($fp)
	lw	$4,24($fp)
	la	$25,atoi
	jal	$31,$25
	move	$3,$2
	lw	$2,80($fp)
	sw	$3,0($2)
	lw	$2,80($fp)
	lw	$4,0($2)
	la	$25,get_amount_element
	jal	$31,$25
	sw	$2,48($fp)
	lw	$2,48($fp)
	sll	$2,$2,3
	move	$4,$2
	la	$25,malloc
	jal	$31,$25
	sw	$2,40($fp)
	lw	$2,40($fp)
	sw	$2,44($fp)
$L53:
	move	$4,$0
	lw	$5,28($fp)
	la	$25,strtok
	jal	$31,$25
	sw	$2,24($fp)
	lw	$2,24($fp)
	bne	$2,$0,$L55
	b	$L54
$L55:
	lw	$4,24($fp)
	la	$25,atof
	jal	$31,$25
	s.d	$f0,32($fp)
	lw	$2,40($fp)
	l.d	$f0,32($fp)
	s.d	$f0,0($2)
	lw	$2,40($fp)
	addu	$2,$2,8
	sw	$2,40($fp)
	b	$L53
$L54:
	lw	$2,40($fp)
	sw	$0,0($2)
	sw	$0,4($2)
	lw	$2,44($fp)
	sw	$2,40($fp)
	lw	$2,40($fp)
	move	$sp,$fp
	lw	$31,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$31
	.end	read_arguments
	.size	read_arguments, .-read_arguments
	.align	2
	.globl	get_amount_element
	.ent	get_amount_element
get_amount_element:
	.frame	$fp,16,$31		# vars= 0, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,16
	.cprestore 0
	sw	$fp,12($sp)
	sw	$28,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	lw	$3,16($fp)
	lw	$2,16($fp)
	mult	$3,$2
	mflo	$2
	sll	$2,$2,1
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$31
	.end	get_amount_element
	.size	get_amount_element, .-get_amount_element
	.align	2
	.globl	get_matrix_elements
	.ent	get_matrix_elements
get_matrix_elements:
	.frame	$fp,16,$31		# vars= 0, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,16
	.cprestore 0
	sw	$fp,12($sp)
	sw	$28,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	lw	$3,16($fp)
	lw	$2,16($fp)
	mult	$3,$2
	mflo	$2
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$31
	.end	get_matrix_elements
	.size	get_matrix_elements, .-get_matrix_elements
	.align	2
	.globl	readFromStdInput
	.ent	readFromStdInput
readFromStdInput:
	.frame	$fp,16,$31		# vars= 0, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,16
	.cprestore 0
	sw	$fp,12($sp)
	sw	$28,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	lw	$2,16($fp)
	slt	$2,$2,2
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$31
	.end	readFromStdInput
	.size	readFromStdInput, .-readFromStdInput
	.rdata
	.align	2
$LC12:
	.ascii	"$ tp0 -h\n\000"
	.align	2
$LC13:
	.ascii	"Usage:\n\000"
	.align	2
$LC14:
	.ascii	"  tp0 -h\n\000"
	.align	2
$LC15:
	.ascii	"  tp0 -V\n\000"
	.align	2
$LC16:
	.ascii	"  tp0 < in_file > out_file\n\000"
	.align	2
$LC17:
	.ascii	"Options:\n\000"
	.align	2
$LC18:
	.ascii	"  -V, --version    Print version and quit.\n\000"
	.align	2
$LC19:
	.ascii	"  -h, --help       \000"
	.align	2
$LC20:
	.ascii	"Print this information and quit.\n\n\000"
	.align	2
$LC21:
	.ascii	"Examples:\n\000"
	.align	2
$LC22:
	.ascii	"  tp0 < in.txt > out.txt\n\000"
	.align	2
$LC23:
	.ascii	"  cat in.txt | tp0 > out.txt\n\n\000"
	.text
	.align	2
	.globl	printHelp
	.ent	printHelp
printHelp:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	la	$4,__sF+88
	la	$5,$LC12
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC13
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC14
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC15
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC16
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC17
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC18
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC19
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC20
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC21
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC22
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC23
	la	$25,fprintf
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	printHelp
	.size	printHelp, .-printHelp
	.rdata
	.align	2
$LC24:
	.ascii	"Copyright (c) 2016\n\000"
	.align	2
$LC25:
	.ascii	"MIPS - Infraestructura b\303\241sica. v1.0.0\n\n\000"
	.text
	.align	2
	.globl	printVersion
	.ent	printVersion
printVersion:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	la	$4,__sF+88
	la	$5,$LC24
	la	$25,fprintf
	jal	$31,$25
	la	$4,__sF+88
	la	$5,$LC25
	la	$25,fprintf
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	printVersion
	.size	printVersion, .-printVersion
	.align	2
	.globl	matrices_multiply
	.ent	matrices_multiply
matrices_multiply:
	.frame	$fp,96,$31		# vars= 56, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,96
	.cprestore 16
	sw	$31,88($sp)
	sw	$fp,84($sp)
	sw	$28,80($sp)
	move	$fp,$sp
	sw	$4,96($fp)
	sw	$5,100($fp)
	li	$4,1			# 0x1
	la	$25,malloc
	jal	$31,$25
	sw	$2,28($fp)
	sw	$0,32($fp)
	sw	$0,36($fp)
	sw	$0,40($fp)
	sw	$0,44($fp)
	sw	$0,48($fp)
$L62:
	lw	$3,96($fp)
	lw	$2,96($fp)
	lw	$2,4($2)
	addu	$2,$2,-1
	sw	$2,4($3)
	bgez	$2,$L65
	lw	$4,96($fp)
	la	$25,__srget
	jal	$31,$25
	sb	$2,76($fp)
	b	$L66
$L65:
	lw	$2,96($fp)
	lw	$3,0($2)
	move	$4,$3
	lbu	$4,0($4)
	sb	$4,76($fp)
	addu	$3,$3,1
	sw	$3,0($2)
$L66:
	lbu	$2,76($fp)
	sb	$2,24($fp)
	sll	$2,$2,24
	sra	$3,$2,24
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L64
	b	$L63
$L64:
	lw	$2,32($fp)
	addu	$2,$2,1
	sw	$2,32($fp)
	lw	$4,28($fp)
	lw	$5,32($fp)
	la	$25,realloc
	jal	$31,$25
	sw	$2,28($fp)
	lw	$3,28($fp)
	lw	$2,32($fp)
	addu	$2,$3,$2
	addu	$3,$2,-1
	lbu	$2,24($fp)
	sb	$2,0($3)
	lb	$3,24($fp)
	li	$2,10			# 0xa
	bne	$3,$2,$L62
	addu	$2,$fp,36
	lw	$4,28($fp)
	lw	$5,32($fp)
	move	$6,$2
	la	$25,read_arguments
	jal	$31,$25
	sw	$2,52($fp)
	lw	$4,36($fp)
	la	$25,get_amount_element
	jal	$31,$25
	sw	$2,40($fp)
	lw	$4,36($fp)
	la	$25,get_matrix_elements
	jal	$31,$25
	sw	$2,44($fp)
	lw	$2,52($fp)
	sw	$2,56($fp)
	lw	$2,44($fp)
	sll	$3,$2,3
	lw	$2,52($fp)
	addu	$2,$2,$3
	sw	$2,60($fp)
	lw	$4,36($fp)
	lw	$5,36($fp)
	la	$25,create_matrix
	jal	$31,$25
	sw	$2,64($fp)
	lw	$3,64($fp)
	lw	$2,56($fp)
	sw	$2,8($3)
	lw	$4,36($fp)
	lw	$5,36($fp)
	la	$25,create_matrix
	jal	$31,$25
	sw	$2,68($fp)
	lw	$3,68($fp)
	lw	$2,60($fp)
	sw	$2,8($3)
	lw	$4,64($fp)
	lw	$5,68($fp)
	la	$25,matrix_multiply
	jal	$31,$25
	sw	$2,72($fp)
	lw	$4,100($fp)
	lw	$5,72($fp)
	la	$25,print_matrix
	jal	$31,$25
	sw	$2,48($fp)
	lw	$4,64($fp)
	la	$25,destroy_matrix
	jal	$31,$25
	lw	$4,68($fp)
	la	$25,destroy_matrix
	jal	$31,$25
	lw	$4,72($fp)
	la	$25,destroy_matrix
	jal	$31,$25
	lw	$4,52($fp)
	la	$25,free
	jal	$31,$25
	sw	$0,32($fp)
	b	$L62
$L63:
	lw	$4,28($fp)
	la	$25,free
	jal	$31,$25
	lw	$2,48($fp)
	move	$sp,$fp
	lw	$31,88($sp)
	lw	$fp,84($sp)
	addu	$sp,$sp,96
	j	$31
	.end	matrices_multiply
	.size	matrices_multiply, .-matrices_multiply
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
