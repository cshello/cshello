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





