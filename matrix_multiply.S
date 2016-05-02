#include <mips/regdef.h>
#include <sys/syscall.h>

	.text			# segmento de texto del programa

	.abicalls
	.align 2		# alineacion 2^2

	.globl	matrix_multiply
	.ent	matrix_multiply
matrix_multiply:
	.frame	$fp, 56, ra	# $fp: registro usado como frame pointer
				# 40: tamañodel stack frame
				# ra: registro que almacena el return address

	# bloque para codigo PIC
	.set noreorder		# apaga reordenamiento de instrucciones
	.cpload t9		# directiva usada para codigo PIC
	.set reorder		# enciende reordenamiento de instrucciones

	# creo stack frame
	subu sp, sp, 56		# 4 (SRA) + 6 (LTA) + 4 (ABA)

	# directiva para codigo PIC
	.cprestore 40		# inserta aqui "sw gp, 40(sp)",
				# mas "lw gp, 40(sp)" luego de cada jal.

	# salvado de callee-saved regs en SRA	
	sw $fp, 44(sp)
	sw ra, 48(sp)

	# de aqui al fin de la funcion uso $fp en lugar de sp.
	move $fp, sp
	
	# salvo 1er arg y 2do arg
	sw a0, 56($fp)		# m1: a0, sp+56
	sw a1, 60($fp)		# m2: a1, sp+60

	#guardo variables
	/*
	matrix_t* result = create_matrix(m1->rows, m1->cols);
    	result->array = malloc(m1->rows * m1->cols * sizeof(double));
	*/

	addu t0, 0($zero)
	sw t0, 16($fp)	# temp: t0, sp+16

	/*
	addu t1, 0($zero)
	sw t1, 20($fp)	#guardar dim = m1->rows ??
	*/

	addu t2, 0($zero)
	sw t2, 24($fp)	# i: t2, sp+24
	
	addu t3, 0($zero)
	sw t3, 28($fp)	# j: t3, sp+28

	addu t4, 0($zero)
	sw t4, 32($fp)	# k: t4, sp+32

	addu t5, 0($zero)
	sw t5, 36($fp)	# x: t5, sp+36

	mult t1, t1	# (dim * dim)
	mflo t6		# t6 = (dim * dim)

	#primer loop
L1:
	bge t4, t6, DONE1	# branch to DONE1 if  $t4 >= $t6 (k >= (dim*dim))
	
	#segundo loop
L2:	
	bge t5, t1, DONE2	# branch to DONE2 if  $t5 >= $t1 (x >= dim)
	
	#tercer loop
L3:
	bge t3, t6, DONE3	# branch to DONE3 if  $t3 >= $t6 (j >= (dim*dim))
	/*
	mult a0(t2), a1(t3)	# m1->array[i] * m2->array[j] ??
	mflo t7
	*/
	add t0, t0, t7		# temp = temp + m1->array[i] * m2->array[j]
	
	addi t2, t2, 1		# i++
	add t3, t3, t1		# j += dim
	b L3			# vuelvo al loop 3

	#termina loop 3
DONE3:
	subu t3, t3, t6		# j -= (dim * dim)
	subu t2, t2, t1		# i -= dim
	/*
	result->array[k] = temp;	# temp = t0
	*/
	addi t3, t3, 1		# j++
	addi t4, t4, 1		# k++
	addi t5, t5, 1		# x++
	b L2			# vuelvo al loop 2

	#termina loop 2
DONE2:
	addu t5, 0($zero)	# x = 0
	addu t3, 0($zero)	# j = 0
	addu t2, t2, t1		# i += dim
	b L1			# vuelvo al loop 1

	#termina loop 1
DONE1:
	#return

	/*
	return result;
	*/

	# restauro callee-saved regs
	lw gp, 40(sp)
	lw $fp, 44(sp)
	lw ra, 48(sp)
	# destruyo stack frame
	addu sp, sp, 56
	# vuelvo a funcion llamante
	jr ra

	.end	matrix_multiply
	.size	matrix_multiply,.-matrix_multiply

