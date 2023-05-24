
# target_compile_definitions

## 示例1
- SRC main.cpp
```cpp
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
```

- SRC CMakelists.txt
```cmake

cmake_minimum_required(VERSION 3.2)

project(hello)

add_definitions(-DCCC)

add_executable(hello main.cpp)

target_compile_definitions(hello PUBLIC AAA)

target_compile_definitions(hello PUBLIC -DBBB)
```

- OUTPUT 
```txt
Hello, file: /root/progs/wd_notes/cshello/DevOps/BuildTools/CMake/Usages/target_compile_definitions/main.cpp
Hello AAA
Hello BBB
Hello CCC
End. 
```


