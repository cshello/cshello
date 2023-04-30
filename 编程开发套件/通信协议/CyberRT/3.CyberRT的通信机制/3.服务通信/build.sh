#!/usr/bin/env bash 


source ../../../../../cshello/setup.bash

MD_BASENAME=$(basename $(pwd))


cat << EOF > "${MD_BASENAME}.md"

# ${MD_BASENAME}

## 案例1
$(wrapercode sh "$(cat build_demo-server-cc.sh)")

EOF


