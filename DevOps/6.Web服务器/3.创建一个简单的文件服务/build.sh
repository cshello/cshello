#!/usr/bin/env bash


source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))


cat << EOF > ${md_basename}.md

# $md_basename  

## 一个简单的HTTP文件服务 
$(wrapercode py "$(cat runHttpServer.py)")


## 一个简单的HTTPS文件服务  
$(wrapercode py "$(cat runHttpsServer.py)")

EOF



