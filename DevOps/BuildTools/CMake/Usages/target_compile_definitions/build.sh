#!/usr/bin/env bash

source ../../../../../cshello/setup.bash

MD_BASENAME=$(basename $(pwd))


cat << EOF > main.cpp
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

EOF


cat << EOF > CMakeLists.txt

cmake_minimum_required(VERSION 3.2)

project(hello)

add_definitions(-DCCC)

add_executable(hello main.cpp)

target_compile_definitions(hello PUBLIC AAA)

target_compile_definitions(hello PUBLIC -DBBB)



EOF

cmake -B build .
cmake --build build 


cat << EOF > ${MD_BASENAME}.md

# ${MD_BASENAME}

## 示例1
- SRC main.cpp
$(wrapercode cpp "$(cat main.cpp)")

- SRC CMakelists.txt
$(wrapercode cmake "$(cat CMakeLists.txt)")

- OUTPUT 
$(wrapercode txt "$(build/hello)")


EOF






