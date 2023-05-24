
cmake_minimum_required(VERSION 3.2)

project(hello)

add_definitions(-DCCC)

add_executable(hello main.cpp)

target_compile_definitions(hello PUBLIC AAA)

target_compile_definitions(hello PUBLIC -DBBB)



