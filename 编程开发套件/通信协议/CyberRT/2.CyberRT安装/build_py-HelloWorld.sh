#!/usr/bin/env bash 


SRC_DIR="cyber/demo_py_HelloWorld"
MAIN_BASENAME="HelloWorld"

mkdir -p $SRC_DIR

cat << EOF > ${SRC_DIR}/${MAIN_BASENAME}.py

from cyber.python.cyber_py3 import cyber

if __name__ == "__main__":
    cyber.init()
    print("Hello World!")

EOF




cat << EOF > ${SRC_DIR}/BUILD
py_binary(
    name = "${MAIN_BASENAME}",
    srcs = ["${MAIN_BASENAME}.py"],
    deps = ["//cyber/python/cyber_py3:cyber"]
)
EOF


bazel build ${SRC_DIR}:${MAIN_BASENAME}

bazel run ${SRC_DIR}:${MAIN_BASENAME}



