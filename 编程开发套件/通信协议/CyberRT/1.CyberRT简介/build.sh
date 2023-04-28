#!/usr/bin/env bash

source ../../../../cshello/setup.bash

md_basename=$(basename "$(pwd)").md

echo ${md_basename}



cat << EOF > ${md_basename}

# ${md_basename}
$(wrapercode txt "
Apollo Cyber RT是一个专门为自动驾驶场景设计的开源高性能运行时框架。基于集中式计算模型，对自动驾驶的高并发、低延迟、高吞吐量进行了极致的优化。
"
)

EOF



