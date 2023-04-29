#!/usr/bin/env bash 

source ../../../../../cshello/setup.bash 

MD_BASENAME=$(basename $(pwd))


cat << EOF > ${MD_BASENAME}.md

# ${MD_BASENAME}
在CyberRT中创建一个proto协议的例子
1. 编码。分别创建proto文件，cc文件，py文件
2. 配置。
3. 编译。
4. 执行。

## 案例1
$(wrapercode sh "$(cat build-person-proto-in-cyber.sh)")


EOF






