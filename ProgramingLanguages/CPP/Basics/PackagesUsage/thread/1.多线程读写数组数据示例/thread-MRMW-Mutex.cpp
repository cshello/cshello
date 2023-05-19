#include <iostream>
#include <string>
#include <thread>
#include <vector>
#include <mutex>
using namespace std;

static const size_t size = 10;

static long long data[size];

static long long sum;
std::mutex g_pages_mutex;

void tR() {
    int i = 0;
    while (i++ < 1e6) {
        sum += 1;
    }
}

void tWA() {
    int i = 0;
    while (i++ < 1e6) {
        std::lock_guard<std::mutex> guard(g_pages_mutex);
        data[i%size] += 1;
        // data[i%100] -= 1;
    }
}
void tWS() {
    int i = 0;
    while (i++ < 1e6) {
        std::lock_guard<std::mutex> guard(g_pages_mutex);
        // data[i%100] += 1;
        data[i%size] -= 1;
    }
}

int main(int argc, char const **argv ){
    cout << "Hello, file; " << __FILE__ << endl;
    for (size_t i = 0; i < size; ++i) {
        data[i] = int(i);
    }

    vector<thread> r_threads;
    vector<thread> w_threads;

    int rn = 15;
    r_threads.reserve(rn);
    for (int i = 0; i < rn; i++) {
            r_threads.emplace_back(tR);
    }

    int wn = 1;
    w_threads.reserve(wn*2);
    for (int i = 0; i < wn; i++) {
        w_threads.emplace_back(tWA);
        w_threads.emplace_back(tWS);
    }

    for (int i = 0; i < rn; i++) {
        r_threads[i].join();
    }

    for (int i = 0; i < wn * 2; i++) {
        w_threads[i].join();
    }


    for (long long i : data) {
        cout << i << ", ";
    }

    cout << endl;
    return 0;
}



