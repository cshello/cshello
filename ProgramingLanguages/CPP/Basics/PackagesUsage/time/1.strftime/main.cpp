#include <iostream>
#include <ctime>



int main() {
    printf("Hello, file: %s\n", __FILE__);
    
    time_t t = time(0);
    char tmp[64] = {0x0};
    strftime(tmp, sizeof(tmp), "%Y-%m-%d_%H:%M:%S", localtime(&t));
    
    printf("tmp: %s\n", tmp);

}
