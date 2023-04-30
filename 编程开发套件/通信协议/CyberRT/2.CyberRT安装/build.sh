#!/usr/bin/env bash

# wrapercode
source ../../../../cshello/setup.bash

md_basename=$(basename "$(pwd)").md


cat << EOF > ${md_basename}

# ${md_basename}

## 安装准备基础环境
$(wrapercode txt "
1. 安装Ubuntu系统
2. 安装NVIDIA驱动
3. 安装docker
4. 安装nvidia-docker
")

## CyberRT安装
### 1. git克隆源码
$(wrapercode sh "
git clone https://github.com/ApolloAuto/apollo --depth=1
")

### 2. 启动docker容器
$(wrapercode sh "
# 如果仅使用CyberRT功能
./docker/scripts/cyber_start.sh

# 启动开发容器
./docker/scripts/dev_start.sh
")

### 3. 开启docker容器
$(wrapercode sh "
# 如果仅开启CyberRT功能
./docker/scripts/cyber_into.sh

# 开启开发容器
./docker/scripts/dev_into.sh
")


### 4. 在容器中构建CyberRT
$(wrapercode sh "
# 构建Apollo
./apollo.sh build

# 仅构建CyberRT
./apollo.sh build cyber
")


### 5. 测试CyberRT
$(wrapercode sh "
# 在窗口1中执行talker
source cyber/setup.bash
export GLOG_alsologtostderr=1
./bazel-bin/cyber/examples/talker

# 在窗口2中执行listener
source cyber/setup.bash 
export GLOG_alsologtostderr=1
./bazel-bin/cyber/examples/listener

")


## 使用CyberRT创建并打印HelloWorld
在容器apollo目录直接执行如下C++或Py脚本。
### 编写C++输出HelloWorld
$(wrapercode sh "$(cat build_cpp-HelloWorld.sh)")

### 编写Py输出HelloWorld
$(wrapercode sh "$(cat build_py-HelloWorld.sh)")
EOF





