#!/usr/bin/env bash 

source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))


# -rdynamic 打印具体的函数
exec_compile_str="gcc -o main main.c -g"

cat << EOF > ${md_basename}.md

# $md_basename

## 案例1
- main.c

$(wrapercode C "$(cat main.c)")

- OUTPUT
$(wrapercode txt "$($(${exec_compile_str}) && ./main)")


EOF

rm -rf ./main;


