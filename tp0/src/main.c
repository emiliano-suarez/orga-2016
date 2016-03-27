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


int read_arguments(char* line, int line_size, double* matrix_elements);

int main (int argc, char *argv[])
{
    char* line = malloc(sizeof(char));
    char c;
    int i = 0;
    int chars_per_line = 0;
    int matrix_dimension = 0;
    int amount_elements = 0;
    double matrix_elements = 0;
    double* element_pointer = 0;

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
            matrix_dimension = read_arguments(line, chars_per_line,
                                              &matrix_elements);

            // Calculo la cantidad de elementos de ambas matrices.
            amount_elements = matrix_dimension * matrix_dimension * 2;

            printf("matrix_dimension: %d\n", matrix_dimension);
            printf("amount_elements: %d\n", amount_elements);

            element_pointer = &matrix_elements;

            i = 0;
            do {
                printf("element[%d]: %f\n", i, *element_pointer);
                i++;
                element_pointer++;
            } while(i < amount_elements);

            chars_per_line = 0;
        }
       
    }

    free(line);
    return 0;
}

// Constructor de matrix_t
matrix_t* create_matrix(size_t rows, size_t cols)
{
    int matrix_size = rows + cols + sizeof(double);
    double* matrix_array = malloc(matrix_size);

    matrix_t* new_matrix = malloc(sizeof(matrix_t));
    new_matrix->rows = rows;
    new_matrix->cols = cols;
    new_matrix->array = matrix_array;

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

// Multiplica las matrices en m1 y m2
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2)
{
    matrix_t* result = malloc(sizeof(matrix_t));

    return result;
}

int read_arguments(char* line, int line_size, double* matrix_elements) {

    char *first_token;
    char *search = " ";
    double element = 0;
    int dimension = 0;

    /*
     Leo la dimensión de la matriz, que está en la primer posición
     de la línea.
    */
    first_token = strtok(line, search);
    dimension = atoi(first_token);

    while ( (first_token = strtok( NULL, search)) != NULL) {
        element = atof(first_token);
        *matrix_elements = element;
        // printf( "x: %f\n", *matrix_elements);
        matrix_elements++;
    }

    return dimension;
}
