#!/usr/bin/env bash


source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))


cat << EOF > ${md_basename}.md

# ${md_basename}  


## 案例
$(wrapercode sh "$(cat gencert.sh)")

EOF




