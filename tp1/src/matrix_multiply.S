#include <mips/regdef.h>
#include <sys/syscall.h>

	.text			# segmento de texto del programa

	.abicalls
	.align 2		# alineacion 2^2

	.globl	matrix_multiply
	.ent	matrix_multiply
matrix_multiply:
	.frame	$fp, 64, ra	# $fp: registro usado como frame pointer
				# 64: tamañodel stack frame
				# ra: registro que almacena el return address

	# bloque para codigo PIC
	.set noreorder		# apaga reordenamiento de instrucciones
	.cpload t9		# directiva usada para codigo PIC
	.set reorder		# enciende reordenamiento de instrucciones

	# creo stack frame
	subu sp, sp, 64		# 4 (SRA) + 8 (LTA) + 4 (ABA)

	# directiva para codigo PIC
	.cprestore 48		# inserta aqui "sw gp, 48(sp)",
				# mas "lw gp, 48(sp)" luego de cada jal.

	# salvado de callee-saved regs en SRA	
	sw $fp, 52(sp)
	sw ra, 56(sp)

	# de aqui al fin de la funcion uso $fp en lugar de sp.
	move $fp, sp
	
	# salvo 1er arg y 2do arg
	sw a0, 64($fp)		# m1: a0, sp+64
	sw a1, 68($fp)		# m2: a1, sp+68

	#guardo variables
	
	#Llamado a la funcion: create_matrix(m1->rows, m1->cols);
	lw a0, 64($fp)	# Obtengo el comienzo del struct y lo guardo en a0
	lw a0, 0(a0)	# Obtengo el 'rows' (posicion 0) del struct
	lw a1, 64($fp)	# Obtengo el comienzo del struct y lo guardo en a1
	lw a1, 4(a1)	# Obtengo el 'cols' (posicion 4) del struct
	la t9, create_matrix	# llamo a la funcion create_matrix
	jal ra,t9
	
	sw v0, 44($fp)	# result: v0, sp+44

	#Creacion del array con malloc(m1->rows * m1->cols * sizeof(double));
	lw t0, 64($fp)	# Obtengo el comienzo del struct y lo guardo en t0
	lw t0, 0(t0)	# Obtengo el 'rows' (posicion 0) del struct
	lw t1, 64($fp)	# Obtengo el comienzo del struct y lo guardo en t1
	lw t1, 4(t1)	# Obtengo el 'cols' (posicion 4) del struct
	mult t0,t1	# m1->rows * m1->cols
	mflo t3
	li t4, 8	# sizeof(double)
	mult t3,t4	# m1->rows * m1->cols * sizeof(double)
	mflo t5
	move a0, t5	# a0: espacio que pido en el malloc
	li v0, 9	# syscall 9 (sbrk)
	syscall

	lw t1, 44($fp)	# result: t1, sp+44
	lw t1, 8(t1)	# Obtengo el 'array' (posicion 8) del struct
	sw v0, 0(t1)	# Guardo la direccion que el syscall me devolvio en v0 (comienzo del array)
	
	#sigo declarando variables

	li t0, 0
	sw t0, 16($fp)	# temp: t0, sp+16

	lw    t1,64($fp)    # Obtengo el comienzo del struct y lo guardo en t1
	lw    t1,0(t1)      # Obtengo el 'rows' (posicion 0) del struct
	sw    t1,20($fp)    # dim = m1->rows;

	li t2, 0
	sw t2, 24($fp)	# i: t2, sp+24
	
	li t3, 0
	sw t3, 28($fp)	# j: t3, sp+28

	li t4, 0
	sw t4, 32($fp)	# k: t4, sp+32

	li t5, 0
	sw t5, 36($fp)	# x: t5, sp+36

	mult t1, t1	# (dim * dim)
	mflo t6		# t6 = (dim * dim)
	sw t6, 40($fp)	# (dim * dim): t6, sp+40

	#primer loop
L1:
	bge t4, t6, DONE1	# branch to DONE1 if  $t4 >= $t6 (k >= (dim*dim))
	
	#segundo loop
L2:	
	bge t5, t1, DONE2	# branch to DONE2 if  $t5 >= $t1 (x >= dim)
	
	#tercer loop
L3:
	bge t3, t6, DONE3	# branch to DONE3 if  $t3 >= $t6 (j >= (dim*dim))
	
	lw    a0,64($fp)    	# Cargo el comienzo de m1 en a0
	lw    a0,8(a0)      	# Cargo en comienzo de m1.array
	sll   v0,t2,3      	# Me muevo de a 8 bytes, pues double* array
	addu a0,a0,v0		# Me posiciono en la posicion 'i' del array

	lw    a1,68($fp)    	# Cargo el comienzo de m2 en a1
	lw    a1,8(a1)      	# Cargo en comienzo de m2.array
	sll   v0,t3,3      	# Me muevo de a 8 bytes, pues double* array
	addu a1,a1,v0		# Me posiciono en la posicion 'j' del array
	
	mult a0,a1		# m1->array[i] * m2->array[j]
	mflo t7
	
	add t0, t0, t7		# temp = temp + m1->array[i] * m2->array[j]
	
	addi t2, t2, 1		# i++
	add t3, t3, t1		# j += dim
	b L3			# vuelvo al loop 3

	#termina loop 3
DONE3:
	subu t3, t3, t6		# j -= (dim * dim)
	subu t2, t2, t1		# i -= dim

	lw v0, 44($fp)		# Guardo posicion de result en v0
	lw v0, 8(v0)		# Obtengo el 'array' (posicion 8) del struct
	sll v1,t4,3      	# Me muevo de a 8 bytes, pues double* array
	addu v0,v0,v1		# Me posiciono en la posicion 'k' del array

	sw t0, 0(v0)		# result->array[k] = temp;

	addi t3, t3, 1		# j++
	addi t4, t4, 1		# k++
	addi t5, t5, 1		# x++
	b L2			# vuelvo al loop 2

	#termina loop 2
DONE2:
	li t5, 0		# x = 0
	li t3, 0		# j = 0
	addu t2, t2, t1		# i += dim
	b L1			# vuelvo al loop 1

	#termina loop 1
DONE1:
	#return

	lw v0, 44($fp)		# Guardo posicion de result en v0 (return result)

	# restauro callee-saved regs
	lw gp, 48(sp)
	lw $fp, 52(sp)
	lw ra, 56(sp)
	# destruyo stack frame
	addu sp, sp, 64
	# vuelvo a funcion llamante
	jr ra

	.end	matrix_multiply
	.size	matrix_multiply,.-matrix_multiply
