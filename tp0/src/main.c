#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct matrix {
    size_t rows;
    size_t cols;
    double* array;
} matrix_t;

// Constructor de matrix_t
matrix_t* create_matrix(size_t rows, size_t cols);

// Destructor de matrix_t
void destroy_matrix(matrix_t* m);

/*
Imprime matrix_t sobre el file pointer fp en el formato solicitado
por el enunciado
*/
int print_matrix(FILE* fp, matrix_t* m);

// Multiplica las matrices en m1 y m2
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2);

/*
Lee una línea por stdin y devuelve los elementos de la matriz y la
dimensión por referencia.
*/
double* read_arguments(char* line, int line_size, int *matrix_dimension);

// Devuele la cantidad total de elementos de ambas matrices.
int get_amount_element(int dimension);

// Devuelve la cantidad de elementos de una matriz.
int get_amount_of_matrix_elements(int dimension);

int main (int argc, char *argv[])
{
    char* line = malloc(sizeof(char));
    char c;
    int i = 0;
    int chars_per_line = 0;
    int matrix_dimension = 0;
    int amount_elements = 0;
    int elements_per_matrix = 0;
    double* matrix_elements_pointer;
    double* element_pointer;
    double* m1_elements = malloc(10 * sizeof(double));
    double* m2_elements = malloc(10 * sizeof(double));
    matrix_t* m1;
    matrix_t* m2;

    // Leo desde stdin
    while( (c = getc(stdin)) != EOF)
    {
        chars_per_line++;

        /*
        Incremento la cantidad de memoria en funcion de la cantidad
        de caracteres de la linea.
        Luego, asigno el caracter a la linea
        */
        line = realloc(line, chars_per_line * sizeof(char));
        line[chars_per_line - 1] = c;
/*
        x = chars_per_line * sizeof(double);
        element_pointer = realloc(element_pointer, x);
*/
        // Si finalizó la línea, multiplico las matrices
        if ('\n' == c) {
            matrix_elements_pointer = read_arguments(line, chars_per_line,
                                              &matrix_dimension);

            // Calculo la cantidad de elementos de ambas matrices.
            amount_elements = get_amount_element(matrix_dimension);
            element_pointer = matrix_elements_pointer;

            printf("amount_elements: %d\n", amount_elements);
            printf("matrix_dimension: %d\n", matrix_dimension);

            elements_per_matrix = get_amount_of_matrix_elements(matrix_dimension);

            // Seteo los arrays de elementos para ambas matrices
            i = 0;
            do {
                if (i < elements_per_matrix) {
                    // printf("m1_element[%d]: %f\n", i, *element_pointer);
                    *m1_elements = *element_pointer;
                    m1_elements++;
                } else {
                    // printf("m2_element[%d]: %f\n", i, *element_pointer);
                    *m2_elements = *element_pointer;
                    m2_elements++;
                }

                i++;
                element_pointer++;
            } while(i < amount_elements);

            for (i = 0; i < elements_per_matrix; i++) {
                printf("m1[%d]: %f\n", i, m1_elements[i]);
            }
printf("***********************************************\n");
/*
            printf("elements_per_matrix: %d\n",  elements_per_matrix);
            do {
printf("-> i[%d]: %f\n", i, *element_pointer);
                if (i < elements_per_matrix) {
                    m1_elements[i] = *element_pointer;
printf("m1[%d]: %f (%f)\n", i, m1_elements[i], *element_pointer);
                } else {
                    m1_elements[i] = '\0';
                    m2_elements[i - elements_per_matrix] = *element_pointer;
printf("m2[%d]: %f (%f)\n", i - elements_per_matrix, m2_elements[i - elements_per_matrix], *element_pointer);
                }
                i++;
                element_pointer++;
            } while(i < amount_elements);

            m2_elements[i] = '\0';

printf("***********************************************\n");
            for (i = 0; i < (amount_elements / 2); i++) {
                printf("m1[%d]: %f\n", i, m1_elements[i]);
            }
*/

            // m1 = create_matrix(matrix_dimension, matrix_dimension);
            // m1->array = element_pointer;
/*
            i = 0;
            do {
                printf("element[%d]: %f\n", i, *element_pointer);
                i++;
                element_pointer++;
            } while(i < amount_elements);
*/
            // printf("m1.col: %d\n", m1->cols);
            // printf("m1.rows: %d\n", m1->rows);

            chars_per_line = 0;
        }
       
    }

    free(line);
    return 0;
}

// Constructor de matrix_t
matrix_t* create_matrix(size_t rows, size_t cols)
{
    matrix_t* new_matrix = malloc(sizeof(matrix_t));
    new_matrix->rows = rows;
    new_matrix->cols = cols;

    return new_matrix;
}

// Destructor de matrix_t
void destroy_matrix(matrix_t* m)
{
}

/*
Imprime matrix_t sobre el file pointer fp en el formato solicitado
por el enunciado
*/
int print_matrix(FILE* fp, matrix_t* m)
{
    return 0;
}

matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2)
{
    matrix_t* result = create_matrix(m1->rows, m1->cols);
    int dim = m1->rows;
    int i,j,k,x = 0;

    for(; k < (dim * dim) ; i += dim){

        for(; x < dim; j++, k++, x++){

            int temp = 0;

            for (;j < (dim * dim); i++, j += dim){
                temp = temp + m1->array[i] * m2->array[j];
            }

            j -= (dim * dim);
            i -= dim;
            result->array[k] = temp;
        }
        x = 0;
        j = 0;
    }

    return result;
}

double* read_arguments(char* line, int line_size, int *matrix_dimension) {
    char *first_token;  
    char *search = " ";
    double element = 0;
    double* matrix_elements;
    double* pointer_to_first_element;

    matrix_elements = malloc(sizeof(double));
    pointer_to_first_element = matrix_elements;

    /*
     Leo la dimensión de la matriz, que está en la primer posición
     de la línea.
    */
    first_token = strtok(line, search);
    *matrix_dimension = atoi(first_token);

    while ( (first_token = strtok( NULL, search)) != NULL) {
        element = atof(first_token);
        *matrix_elements = element;
        printf( "x: %f\n", *matrix_elements);
        matrix_elements++;
    }

    // Seteo el fin del array
    *matrix_elements = '\0';

    matrix_elements = pointer_to_first_element;

    return matrix_elements;
}

int get_amount_element(int dimension)
{
    return dimension * dimension * 2;
}

int get_amount_of_matrix_elements(int dimension)
{
    return dimension * dimension;
}
