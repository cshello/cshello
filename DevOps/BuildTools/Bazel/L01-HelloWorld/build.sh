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

cat << EOF > ../L01-HelloWorld.md
## SCRIPT
\`\`\`sh
`cat ../build.sh`
\`\`\`


## OUTPUT
\`\`\`sh
`bazel run //:main`
\`\`\`

## TREE
\`\`\`sh
`bazel clean && tree ../`
\`\`\`


