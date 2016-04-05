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
    int print_result = 0;
    double* element_pointer;
    double* m1_elements = malloc(sizeof(double));
    double* m2_elements = malloc(sizeof(double));
    matrix_t* m1 = malloc(sizeof(matrix_t));
    matrix_t* m2 = malloc(sizeof(matrix_t));
    matrix_t* product_matrix = malloc(sizeof(matrix_t));

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

        // Si finalizó la línea, multiplico las matrices
        if ('\n' == c) {
            element_pointer = read_arguments(line, chars_per_line,
                                             &matrix_dimension);

            // Calculo la cantidad de elementos de ambas matrices.
            amount_elements = get_amount_element(matrix_dimension);
            elements_per_matrix = get_amount_of_matrix_elements(matrix_dimension);

            printf("amount_elements: %d\n", amount_elements);
            printf("matrix_dimension: %d\n", matrix_dimension);

            // Seteo los arrays de elementos para ambas matrices
            m1_elements = element_pointer;
            m2_elements = &element_pointer[elements_per_matrix];

            m1 = create_matrix(matrix_dimension, matrix_dimension);
            m1->array = m1_elements;

            m2 = create_matrix(matrix_dimension, matrix_dimension);
            m2->array = m2_elements;

            product_matrix = matrix_multiply(m1, m2);
            //print_result = print_matrix(stdout, product_matrix);

            chars_per_line = 0;
        }
       
    }

    free(line);
    return print_result;
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
    double temp;
    int dim = m1->rows;
    int i = 0;
    int j = 0;
    int k = 0;
    int x = 0;
    int elements_per_matrix = 0;

    elements_per_matrix = get_amount_of_matrix_elements(m1->rows);

    for (i = 0; i < elements_per_matrix; i++) {
        printf("m1->array[%d]: %f\n", i, m1->array[i]);
    }
    printf("\n");
    for (i = 0; i < elements_per_matrix; i++) {
        printf("m2->array[%d]: %f\n", i, m2->array[i]);
    }

    for(; k < (dim * dim) ; i += dim){
        printf("1. (%d,%d)\n", i, j);
        for(; x < dim; j++, k++, x++){
            printf("2. (%d,%d)\n", i, j);
            temp = 0;

            for (;j < (dim * dim); i++, j += dim){
                printf("3. (%d,%d)\n", i, j);
                temp = temp + m1->array[i] * m2->array[j];
            }

            j -= (dim * dim);
            i -= dim;
            printf("k = %d\n", k);
            printf("temp = %f\n", temp);
            // result->array[k] = temp;
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
        // printf( "x: %f\n", *matrix_elements);
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
