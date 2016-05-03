#include <mips/regdef.h>

    .rdata
    .align    2
CHAR_d:
    .ascii    "%d\000"
    .align    2
CHAR_g:
    .ascii    " %g\000"
    .align    2
CHAR_enter:
    .ascii    "\n\000"

    .text
    .align    2
    .globl    print_matrix
    .ent    print_matrix

print_matrix:
    .frame    $fp,48,ra
    .set    noreorder
    .set    reorder
    subu    sp,sp,48
    .cprestore 16

    # Salvo los registros
    sw    ra,40(sp)
    sw    $fp,36(sp)
    sw    gp,32(sp)
    move    $fp,sp

    # Cargo los argumentos
    sw    a0,48($fp)    # puntero a fp
    sw    a1,52($fp)    # puntero a m

    sw    zero,24($fp)  # i = 0

    lw    v0,52($fp)    # Obtengo el comienzo del struct y lo guardo en V0
    lw    v0,0(v0)      # Obtengo el 'rows' (posicion 0) del struct
    sw    v0,28($fp)    # dim = m->rows;

    # Llamado a la funcion: fprintf(fp, "%d", dim);
    lw    a0,48($fp)    # Cargo fp en a0
    la    a1,CHAR_d     # Cargo "%d" en a1
    lw    a2,28($fp)    # Cargo dim en a2
    la    t9,fprintf    # llamo a la funcion fprintf
    jal    ra,t9

    sw    zero,24($fp)  # i = 0
FOR:
    lw    v1,28($fp)    # Cargo dim en v1
    lw    v0,28($fp)    # Cargo dim en v0
    mult    v1,v0       # dim * dim
    mflo    v1          # Me quedo con la parte Low del resultado
    lw    v0,24($fp)    # Cargo en v0 el valor de 'i'

    # Si v0 es menor a v1, v0 vale 1. Si no, 0
    # Si i es menor a (dim * dim), v0 vale 1. Si no, 0
    slt    v0,v0,v1     # i < dim * dim ? 1 = si, 0 = no
    bne    v0,zero,FOR_START    # Si v0 <> 0, entro al FOR
    b    FOR_END        # No se cumple que i < dim * dim, salgo del FOR

FOR_START:
    lw    a0,52($fp)    # Cargo el comienzo de m en a0
    lw    v0,24($fp)    # Cargo el valor de 'i' en v0
    sll    v1,v0,3      # Me muevo de a 8 bytes, pues double* array
    lw    v0,8(a0)      # Cargo en comienzo de m.array
    addu    v0,v1,v0    # Me posiciono en la posicion 'i' del array

    lw    a0,48($fp)    # Cargo fp en a0
    la    a1,CHAR_g     # Cargo "%g" en a1
    lw    a2,0(v0)      # Cargo los bytes mas bajos de 'm->array[i]'
    lw    a3,4(v0)      # Cargo los bytes mas altos de 'm->array[i]'
    la    t9,fprintf    # Llamo a la funcion fprintf
    jal   ra,t9

    lw    v0,24($fp)    # Cargo i en v0
    addu  v0,v0,1       # i++
    sw    v0,24($fp)    # Guardo el valor incrementado de 'i'
    b    FOR            # Vuelvo al comienzo del for

FOR_END:
    # Imprimo el enter final
    la    a1,CHAR_enter # Cargo '\n' en a1
    la    t9,fprintf    # Llamo a la funcion fprintf
    jal   ra,t9

    move  v0,zero       # Cargo 0 en v0 (return 0)
    move  sp,$fp

    # Restauro los valores los registros
    lw    a0,48($fp)
    lw    ra,40(sp)
    lw    $fp,36(sp)
    addu  sp,sp,48
    j     ra

    .end    print_matrix
    .size   print_matrix, .-print_matrix
