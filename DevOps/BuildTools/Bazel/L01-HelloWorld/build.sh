#!/usr/bin/env bash


SUBDIR=build-gendir

mkdir -p $SUBDIR

cd $SUBDIR

touch WORKSPACE

cat << EOF > main.cc

#include <iostream>

using namespace std;

int main(int argc, char *argv[]){
    cout << "Hello, file: " << __FILE__ << endl;
    cout << "END. " << endl;
}

EOF

cat << EOF > BUILD

cc_binary(
    name = "main",
    srcs = ["main.cc"],
)
EOF


bazel build //:main

output=`bazel run //:main`
script_str=`cat ../build.sh`
#exit
# warpmd sh txt
warpmd() {
echo "\`\`\`$1
$2
\`\`\`  
"
}

cat << EOF > ../L01-HelloWorld.md
## SCRIPT
`warpmd sh "${script_str}"`

## OUTPUT
`warpmd sh "$(bazel run //:main)"`


## TREE
`warpmd sh "$(bazel clean && tree ../)"`
EOF
