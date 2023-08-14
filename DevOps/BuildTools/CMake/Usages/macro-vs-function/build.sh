#!/usr/bin/env bash

source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))


cmake -B build- . &> output

cat << EOF > ${md_basename}.md

# $md_basename
## CMakeLists.txt
$(wrapercode cmake "`cat CMakeLists.txt`")

## Generate
$(wrapercode sh "`cat output`")

EOF
