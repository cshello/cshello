cmake_minimum_required(VERSION 3.2)


project(hello)

add_executable(hello main.cpp Config.cpp Config.h)

target_include_directories(hello PUBLIC include)


