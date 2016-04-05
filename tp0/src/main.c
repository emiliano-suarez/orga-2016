#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ERROR_OPEN_FILE 10

typedef struct matrix {
    size_t rows;
    size_t cols;
    double* array;
} matrix_t;

// Constructor de matrix_t
matrix_t* create_matrix(size_t rows, size_t cols);

// Destructor de matrix_t
void destroy_matrix(matrix_t* m);

// Imprime matrix_t sobre el file pointer fp en el formato solicitado
// por el enunciado
int print_matrix(FILE* fp, matrix_t* m);

// Multiplica las matrices en m1 y m2
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2);

// Lee una linea por stdin y devuelve los elementos de la matriz y la
// dimension por referencia.
double* read_arguments(char* line, int line_size,
                       int *matrix_dimension);

// Devuele la cantidad total de elementos de ambas matrices.
int get_amount_element(int dimension);

// Devuelve la cantidad de elementos de una matriz.
int get_matrix_elements(int dimension);

void printHelp();
void printVersion();
int readFromStdInput(int argumentCount);

int matrices_multiply(FILE* input, FILE* output);

int main (int argc, char *argv[])
{
    char* param;
    int result = 0;
    FILE* input;
    FILE* output;

    // Valores por defecto
    input = stdin;
    output = stdout;

    if (readFromStdInput(argc)) {
        // Leo desde stdin
        result = matrices_multiply(input, output);

    } else if (argc >= 2) { // Parseo los argumentos
        param = *(argv + 1);
        if ((strcmp(param, "-h") == 0)
            || (strcmp(param, "--help") == 0) ) {
            printHelp();
            return 0;
        }
        else if ((strcmp(param, "-V") == 0)
                || (strcmp(param, "--version") == 0)) {
            printVersion();
            return 0;
        }
        else if (argc == 2) {
            // Tengo archivo de output unicamente.
            if (NULL == (output = fopen(argv[1], "w+"))) {
                fprintf(stderr,
                        "Output File '%s' doesn't exist.\n", argv[1]);
                exit(ERROR_OPEN_FILE);
            }
        }
        else {
            // Tengo archivo de input y output
            if (NULL == (input = fopen(argv[1], "r"))) {
                fprintf(stderr,
                        "Input File '%s' doesn't exist.\n", argv[1]);
                exit(ERROR_OPEN_FILE);
            }
            if (NULL == (output = fopen(argv[2], "w+"))) {
                fprintf(stderr,
                        "Output File '%s' doesn't exist.\n", argv[2]);
                exit(ERROR_OPEN_FILE);
            }
        }
        result = matrices_multiply(input, output);
    }

    return result;
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

// Imprime matrix_t sobre el file pointer fp en el formato solicitado
// por el enunciado
int print_matrix(FILE* fp, matrix_t* m)
{
    int i = 0;
    int dim = m->rows;

    fprintf(fp, "%d", dim);
    for (i = 0; i < dim * dim; i++) {
        fprintf(fp, " %f", m->array[i]);
    }
    fprintf(fp, "\n");
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

double* read_arguments(char* line, int line_size,
                       int *matrix_dimension) {
    char *first_token;  
    char *search = " ";
    double element = 0;
    double* matrix_elements;
    double* pointer_to_first_element;
    int number_of_elements = 0;

     // Leo la dimension de la matriz, que esta en la primer posicion
     // de la linea.
    first_token = strtok(line, search);
    *matrix_dimension = atoi(first_token);
    number_of_elements = (get_amount_element(*matrix_dimension));
    matrix_elements = malloc(number_of_elements * sizeof(double));
    pointer_to_first_element = matrix_elements;

    while ( (first_token = strtok( NULL, search)) != NULL) {
        element = atof(first_token);
        *matrix_elements = element;
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

int get_matrix_elements(int dimension)
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
    fprintf(stdout, "  -h, --help       ");
    fprintf(stdout, "Print this information and quit.\n\n");
    fprintf(stdout, "Examples:\n");
    fprintf(stdout, "  tp0 < in.txt > out.txt\n");
    fprintf(stdout, "  cat in.txt | tp0 > out.txt\n\n");
}

void printVersion()
{
    fprintf(stdout, "Copyright (c) 2016\n");
    fprintf(stdout, "MIPS - Infraestructura basica. v1.0.0\n\n");
}

int matrices_multiply(FILE* input, FILE* output)
{
    char c;
    char* line = malloc(sizeof(char));
    int chars_per_line = 0;
    int matrix_dimension = 0;
    int amount_elements = 0;
    int elements_per_matrix = 0;
    int print_result = 0;
    double* element_pointer;
    double* m1_elements;
    double* m2_elements;
    matrix_t* m1;
    matrix_t* m2;
    matrix_t* product_matrix;

    while( (c = getc(input)) != EOF)
    {
        chars_per_line++;
        
        // Incremento la cantidad de memoria en funcion de la cantidad
        // de caracteres de la linea.
        // Luego, asigno el caracter a la linea
        line = realloc(line, chars_per_line * sizeof(char));
        line[chars_per_line - 1] = c;

        // Si finalizo la linea, multiplico las matrices
        if ('\n' == c) {
            element_pointer = read_arguments(line, chars_per_line,
                                             &matrix_dimension);

            // Calculo la cantidad de elementos de ambas matrices.
            amount_elements = get_amount_element(matrix_dimension);
            elements_per_matrix = get_matrix_elements(matrix_dimension);

            // Seteo los arrays de elementos para ambas matrices
            m1_elements = element_pointer;
            m2_elements = &element_pointer[elements_per_matrix];

            m1 = create_matrix(matrix_dimension, matrix_dimension);
            m1->array = m1_elements;

            m2 = create_matrix(matrix_dimension, matrix_dimension);
            m2->array = m2_elements;

            product_matrix = matrix_multiply(m1, m2);
            print_result = print_matrix(output, product_matrix);

            destroy_matrix(m1);
            destroy_matrix(m2);
            destroy_matrix(product_matrix);
            free(element_pointer);

            chars_per_line = 0;
        }
    }

    free(line);

    return print_result;
}

