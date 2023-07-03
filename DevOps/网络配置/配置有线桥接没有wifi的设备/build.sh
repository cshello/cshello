#!/usr/bin/env bash

source /cshello/cshello/setup.bash

md_basename=$(basename "$(pwd)").md



cat << EOF > ${md_basename}

# ${md_basename}  
有一台没有wifi的设备，它可以通过网线连接上网，
现在通过笔记本桥接网络给设备端上网

## 配置步骤  
1. 设置笔记本桥接模式。配置IP:\`192.168.1.6\`, 掩码:\`255.255.255.0\`, 设置网关和笔记本能上网的Wi-Fi的网关保持一致。
2. 设置设备端的配置文件\`/etc/network/interfaces\`为如下内容:  
$(wrapercode txt "$(cat interfaces)")


EOF




