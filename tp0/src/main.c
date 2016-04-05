#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DECIMALS 2

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

int readFromStdInput(int argumentCount);
void printHelp();
void printVersion();

int main (int argc, char *argv[])
{
    char* line = malloc(sizeof(char));
    char* param;
    char c;
    int chars_per_line = 0;
    int matrix_dimension = 0;
    int elements_per_matrix = 0;
    int print_result = 0;

    if (readFromStdInput(argc)) {
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
                double* element_pointer = read_arguments(line, chars_per_line,
                                                 &matrix_dimension);

                // Calculo la cantidad de elementos de ambas matrices.
                elements_per_matrix = get_amount_of_matrix_elements(matrix_dimension);

                // Seteo los arrays de elementos para ambas matrices
                double* m1_elements = element_pointer;
                double* m2_elements = &element_pointer[elements_per_matrix];

                matrix_t* m1 = create_matrix(matrix_dimension, matrix_dimension);
                m1->array = m1_elements;

                matrix_t* m2 = create_matrix(matrix_dimension, matrix_dimension);
                m2->array = m2_elements;

                matrix_t* product_matrix = matrix_multiply(m1, m2);
                print_result = print_matrix(stdout, product_matrix);

                free(element_pointer);
                destroy_matrix(m1);
                destroy_matrix(m2);
                free(product_matrix->array);
                destroy_matrix(product_matrix);

                chars_per_line = 0;
            }
        }
    } else if (argc >= 2) { // Parseo los argumentos
        param = *(argv + 1);
        if ((strcmp(param, "-h") == 0) || (strcmp(param, "--help") == 0) ) {
            printHelp();
        }
        else if ((strcmp(param, "-V") == 0) || (strcmp(param, "--version") == 0)) {
            printVersion();
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
    free(m);
}

/*
Imprime matrix_t sobre el file pointer fp en el formato solicitado
por el enunciado
*/
int print_matrix(FILE* fp, matrix_t* m)
{
    // FIXME: imprimir por fp.

    // char* text = "";
    int i = 0;
    int dim = m->rows;

    for (i = 0; i < dim * dim; i++) {
        // fputs(gcvt(m->array[i], DECIMALS, text), fp);
        // fputs(". ", fp);
        printf("%f ", m->array[i]);
    }
    // fputs("\n", fp);
    printf("\n");

    return 0;
}

matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2)
{
    matrix_t* result = create_matrix(m1->rows, m1->cols);
    result->array = malloc(m1->rows * m1->cols * sizeof(double));
    double temp;
    int dim = m1->rows;
    int i = 0;
    int j = 0;
    int k = 0;
    int x = 0;

    for(; k < (dim * dim) ; i += dim){
        for(; x < dim; j++, k++, x++){
            temp = 0;

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

    /*
     Leo la dimensión de la matriz, que está en la primer posición
     de la línea.
    */
    first_token = strtok(line, search);
    *matrix_dimension = atoi(first_token);

    matrix_elements = malloc((get_amount_element(*matrix_dimension)) * sizeof(double));
    pointer_to_first_element = matrix_elements;

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

int readFromStdInput(int argumentCount) {
    return (int)(argumentCount < 2);
}

void printHelp()
{
    fprintf(stdout, "$ tp0 -h\n");
    fprintf(stdout, "Usage:\n");
    fprintf(stdout, "  tp0 -h\n");
    fprintf(stdout, "  tp0 -V\n");
    fprintf(stdout, "  tp0 < in_file > out_file\n");
    fprintf(stdout, "Options:\n");
    fprintf(stdout, "  -V, --version    Print version and quit.\n");
    fprintf(stdout, "  -h, --help       Print this information and quit.\n\n");
    fprintf(stdout, "Examples:\n");
    fprintf(stdout, "  tp0 < in.txt > out.txt\n");
    fprintf(stdout, "  cat in.txt | tp0 > out.txt\n\n");
}

void printVersion()
{
    fprintf(stdout, "Copyright (c) 2016\n");
    fprintf(stdout, "MIPS - Infraestructura básica. v1.0.0\n\n");
}
