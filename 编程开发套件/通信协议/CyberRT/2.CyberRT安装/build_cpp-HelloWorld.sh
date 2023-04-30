#!/uar/bin/env bash 

# 写一个简单的例子，一般可以分为4部分
# 1. 编码
# 2. 配置
# 3. 编译
# 4. 执行


echo 当前目录为: $(pwd)

HelloWorld_SRC_DIR="cyber/demo-cc-HelloWorld"
MAIN_BASENAME="HelloWorld"

mkdir -p ${HelloWorld_SRC_DIR}


cat << EOF > ${HelloWorld_SRC_DIR}/${MAIN_BASENAME}.cc

#include "cyber/cyber.h"

int main(int argc, char const *argv[]) {
    apollo::cyber::Init(argv[0]);
    ADEBUG << "Hello World, ADEBUG";
    AINFO << "Hello World, AINFO";
    AWARN << "Hello World, AWARN";
    AERROR << "Hello World, AERROR";
    // AFATAL << "Hello World, AFATAL";    
}

EOF


cat << EOF > ${HelloWorld_SRC_DIR}/BUILD

cc_binary(
    name = "${MAIN_BASENAME}",
    srcs = ["${MAIN_BASENAME}.cc"],
    deps = ["//cyber"]
)

EOF






bazel build ${HelloWorld_SRC_DIR}/${MAIN_BASENAME}

bazel run ${HelloWorld_SRC_DIR}/${MAIN_BASENAME}

