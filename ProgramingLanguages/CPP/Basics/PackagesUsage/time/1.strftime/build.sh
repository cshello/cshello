#!/usr/bin/env bash

source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))

cat << EOF > $md_basename.md

# $md_basename

## demo01
$(wrapercode cpp "$(cat main.cpp)")


EOF

