#!/usr/bin/env bash


source ../../../../cshello/setup.bash


MD_BASENAME=$(basename $(pwd))

mkdir -p build-

cat << EOF > "${MD_BASENAME}.md"

# ${MD_BASENAME}


## 示例1
- SRC
$(wrapercode cpp "$(cat main.cpp)")

- OUTPUT(不开启OpenMP)
$(wrapercode sh "$(g++ -o build-/main main.cpp; build-/main)")

- OUTPUT(开启OpenMP)
$(wrapercode sh "$(g++ -o build-/main main.cpp -fopenmp && build-/main)")

EOF


