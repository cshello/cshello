/*

gcc -o main main.c -g -rdynamic
addr2line -e main 0x***  // 查看当前栈对应的文件名及行数

*/



#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <execinfo.h>

#define _GNU_SOURCE
#include <string.h>

void dump(void) {
    int nptrs = 0;
    void *buf[128];
    char **strs;

    nptrs = backtrace(buf, 128);
    printf("backtrace() returned %d addresses. \n", nptrs);

    strs = backtrace_symbols(buf, nptrs);
    if (strs == NULL) {
        fprintf(stderr, "strs is NULL. \n");
        return;
    }
    for (int i = 0; i < nptrs; i++) {
        printf("  [%02d] %s\n", i, strs[i]);
    }
    free(strs);
    
}

void handler(int signo) {
    printf("\n ==========>> catch signal %d (%s) <<============\n", signo, (char *)strsignal(signo));
    // printf("\n ==========>> catch signal %d (%s) <<============\n", signo, "123");
    dump();
    exit(EXIT_FAILURE);
}


int main(int argc, char *argv[]) {
    printf("Hello, file: %s\n", __FILE__);
    
    signal(SIGFPE, handler);
    signal(SIGSEGV, handler);
    
    int a = 0;
    int c = 2 / a;
    return 0;
}
