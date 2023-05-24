#include <iostream>

using namespace std;

int main() {
    cout << "Hello, file: " << __FILE__ << endl;
#ifdef AAA
    cout << "Hello AAA" << endl;
#endif 

#ifdef BBB
    cout << "Hello BBB" << endl;
#endif 

#ifdef CCC
    cout << "Hello CCC" << endl;
#endif 

    cout << "End. " << endl;
}

