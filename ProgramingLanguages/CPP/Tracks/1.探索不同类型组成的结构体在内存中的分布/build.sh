#!/usr/bin/env bash


source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))


exec_main='gcc -o main main.c'


cat << EOF > ${md_basename}.md

# $md_basename  

## 案例1  
- main.c

$(wrapercode C "$(cat main.c)")


- OUTPUT
BUILD: \`$exec_main\`

$(wrapercode txt "$($($exec_main) && ./main )")


EOF

rm -rf ./main;



