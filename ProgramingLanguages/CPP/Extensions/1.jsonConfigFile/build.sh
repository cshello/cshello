#!/usr/bin/env bash


source /cshello/cshello/setup.bash

MDNAME=$(basename $(pwd))


rm -rf ./build/*
cmake -B build . 
cmake --build build 


cat << EOF > ${MDNAME}.md

# ${MDNAME}  

## SRC Config.h 
$(wrapercode cpp "$(cat Config.h)")


## SRC Config.cpp
$(wrapercode cpp "$(cat Config.cpp)")


## SRC CMakeLists.txt 
$(wrapercode cmake "$(cat CMakeLists.txt)")


## OUTPUT 
$(wrapercode txt "$(cd build && ./hello)")

EOF


