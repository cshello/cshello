#include <stdio.h>

typedef struct _A {
   char a;
   int b;
   char *c;
   char d[5];
   float e;
} A;

#define PRINT_SIZEOF(type) printf("sizeof(%s): %lu\n", #type, sizeof(type))
#define PRINT_ADDR(p) printf("%s: %p\n", #p, p)

int main(int argc, char *argv[]) {
    printf("Hello, file: %s\n", __FILE__);
    A a;

    PRINT_SIZEOF(void *);
    PRINT_SIZEOF(char);
    PRINT_SIZEOF(int);
    PRINT_SIZEOF(long);
    PRINT_SIZEOF(long long);

    PRINT_ADDR(&a);
    PRINT_ADDR(&a.a);
    PRINT_ADDR(&a.b);
    PRINT_ADDR(&a.c);
    PRINT_ADDR(&a.d);
    PRINT_ADDR(&a.d[0]);
    PRINT_ADDR(&a.d[1]);
    PRINT_ADDR(&a.d[2]);
    PRINT_ADDR(&a.d[3]);
    PRINT_ADDR(&a.d[4]);
    PRINT_ADDR(&a.e);
    
    return 0;
}





