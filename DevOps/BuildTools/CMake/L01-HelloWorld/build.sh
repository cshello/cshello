#!/usr/bin/env bash

subdir=build-gendir
mkdir $subdir
cd $subdir

cat << EOF > main.cc

#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
    cout << "Hello, file: " << __FILE__ << endl;
    cout << "END. " << endl;
}

EOF


cat << EOF > CMakeLists.txt

cmake_minimum_required(VERSION 3.8)

project(hello)

add_executable(hello main.cc)

EOF



tree_str=`tree ../`

builddir=build-cmake
cmake -B $builddir .
cmake --build $builddir



warpmd() {
echo "\`\`\`$1
$2
\`\`\`
"
}

cat << EOF > ../L01-HelloWorld.md

## SCRIPT
`warpmd sh "$(cat ../build.sh)"`

## OUTPUT
$(warpmd sh "$(${builddir}/hello)")

## TREE
`warpmd sh "${tree_str}"`


EOF





