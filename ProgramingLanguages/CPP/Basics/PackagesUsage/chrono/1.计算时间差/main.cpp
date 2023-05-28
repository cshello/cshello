
#include <iostream>
#include <chrono>

using namespace std;

 
long fibonacci(unsigned n)
{
    if (n < 2) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}
 
int main()
{
    // # auto start = std::chrono::steady_clock::now();
    // # std::cout << "f(20) = " << fibonacci(20) << '\n';
    // # auto end = std::chrono::steady_clock::now();
    // # std::chrono::duration<double> elapsed_seconds = end-start;
    // # std::cout << "elapsed time: " << elapsed_seconds.count() << "s\n";
    // # printf("printf elapsed time: %.4lf ", elapsed_seconds.count());
    
    int k = 5;
    auto last_time = std::chrono::steady_clock::now();    
    while (--k) {
	printf("diff time: %.4lf ms  \n", std::chrono::duration<double>(
	    std::chrono::steady_clock::now() - last_time).count());
	last_time = std::chrono::steady_clock::now();
	fibonacci(25);
    }

}

