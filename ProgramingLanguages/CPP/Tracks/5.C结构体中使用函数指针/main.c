#include <stdio.h>
#include <malloc.h>

struct A {
    int a;
    int b;
    int (*func)(int a, int b);
    int c;
};



// typedef int ()(int a, int b) Func;
typedef int Func1(int a, int b);
// typedef int (*)(int a, int b) Func2;
typedef int (*Func3)(int a, int b);

int add(int a, int b) {return a + b;};
int sub(int a, int b) {return a - b;};
int mul(int a, int b) {return a * b;};



int main(int argc, char *argv[]) {
    printf("Hello, file: %s\n", __FILE__);

    struct A a;

    printf("&a.func: %p\n", &a.func);
    printf("&a.c   : %p\n", &a.c);

    a.func = add;

    printf("add a.func(1, 2) = %d\n", a.func(1, 2));
    
    a.func = sub;
    printf("sub a.func(2, 1) = %d\n", a.func(2, 1));

    Func1 *fc1 = add;
    printf("add fc1(2, 1) = %d\n", fc1(2, 1));

    Func3 fc3 = add;
    printf("add fc3(2, 1) = %d\n", fc3(2, 1));


    return 0;
}
