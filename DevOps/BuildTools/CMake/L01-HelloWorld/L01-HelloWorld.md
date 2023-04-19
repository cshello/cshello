
## SCRIPT
```sh
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
```

## OUTPUT
```sh
Hello, file: /root/progs/wd_notes/cshello/DevOps/BuildTools/CMake/L01-HelloWorld/build-gendir/main.cc
END. 
```

## TREE
```sh
../
├── L01-HelloWorld.md
├── build-gendir
│   ├── CMakeLists.txt
│   └── main.cc
└── build.sh

1 directory, 4 files
```


