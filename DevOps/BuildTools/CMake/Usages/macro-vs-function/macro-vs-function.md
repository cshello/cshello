
# macro-vs-function
## CMakeLists.txt
```cmake
cmake_minimum_required(VERSION 3.2)
project(hello)


# Usage macro 
# func_macro(p1 p2 1 2 3)
macro (func_macro param1 param2) 
    message(param1: ${param1})
    message(param2: ${param2})
    message(ARGC: ${ARGC})
    message(ARGV0: ${ARGV0})
    message(ARGV1: ${ARGV1})
    message(ARGV5: ${ARGV5})
    message(ARGN: ${ARGN})
    # message(ARGV#: ${ARGV#})
    set(func_macro_aaa 123)
endmacro()

# func_function(p1 p2 1 2 3)
function(func_function param1 param2)
    message(param1: ${param1})
    message(param2: ${param2})
    message(ARGC: ${ARGC})
    message(ARGV0: ${ARGV0})
    message(ARGV1: ${ARGV1})
    message(ARGV5: ${ARGV5})
    message(ARGN: ${ARGN})
    set(func_function_aaa 123)
endfunction()

macro(bar)
  message(ARGN:${ARGN})
  foreach(arg IN LISTS ARGN)
    message(macroarg:${arg})
  endforeach()
endmacro()

function(foo)
  message(ARGN:${ARGN})
  bar(x y z)
  foreach(arg IN LISTS ARGN)
    message(runc arg:${arg})
  endforeach()
endfunction()

message(STATUS Run foo)
foo(a b c)
message(STATUS Run bar)
bar(a b c)

message(STATUS Run func_macro)
func_macro(p1 p2 1 2 3)
message(func_macro_aaa:${func_macro_aaa})


message(STATUS Run func_function)
func_function(p1 p2 1 2 3)
message(func_function_aaa:${func_function_aaa})
```

## Generate
```sh
-- The C compiler identification is GNU 9.4.0
-- The CXX compiler identification is GNU 9.4.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Runfoo
ARGN:abc
ARGN:xyz
macroarg:a
macroarg:b
macroarg:c
runcarg:a
runcarg:b
runcarg:c
-- Runbar
ARGN:abc
-- Runfunc_macro
param1:p1
param2:p2
ARGC:5
ARGV0:p1
ARGV1:p2
ARGV5:
ARGN:123
func_macro_aaa:123
-- Runfunc_function
param1:p1
param2:p2
ARGC:5
ARGV0:p1
ARGV1:p2
ARGV5:
ARGN:123
func_function_aaa:
-- Configuring done
-- Generating done
-- Build files have been written to: /root/progs/wd_notes/cshello/DevOps/BuildTools/CMake/Usages/macro-vs-function/build-
```

