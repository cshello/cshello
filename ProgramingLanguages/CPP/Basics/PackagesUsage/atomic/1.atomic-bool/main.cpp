#include <iostream>
#include <atomic>
#include <thread>
#include <chrono>

using namespace std;

std::atomic<bool> gReady(false);

std::atomic<int> gValue(0);

#define NUM 100

void valadd() {
    int i = 0;
    while (i++ < NUM) {
	gReady.exchange(true);
	gValue.fetch_add(i);
    }
}

void valsub() {
    int i = 0;
    while (i++ < NUM) {
	gReady.exchange(false);
	gValue.fetch_sub(i);
    }

}


int main(int argc, char *argv[]) {
    printf("Hello, file: %s\n", __FILE__);

    thread tadd(valadd);
    thread tsub(valsub);

    tadd.join();
    tsub.join();
    
    printf("gReady: %d\n", gReady.load(std::memory_order_relaxed));
    printf("gValue: %d\n", gValue.load(std::memory_order_relaxed)); 
    return 0;
}
