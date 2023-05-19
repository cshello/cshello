#!/usr/bin/env bash


source ../../../../../../cshello/setup.bash

MD_BASENAME=$(basename $(pwd))

NAME_SWMR=thread-MRSW
NAME_MWMR=thread-MRMW
NAME_MUTEX=thread-MRMW-Mutex

cat << EOF > ${MD_BASENAME}.md

# ${MD_BASENAME}  

## 多线程与单写多读
- EXAMPLE
$(wrapercode cpp "$(cat ${NAME_SWMR}.cpp)")
- OUTPUT
$(wrapercode sh "$(NAME=$NAME_SWMR; g++ -o build-/${NAME} ${NAME}.cpp -lpthread; build-/$NAME )")


## 多线程与多写多读
- EXAMPLE
$(wrapercode cpp "$(cat ${NAME_SWMR}.cpp)")
- OUTPUT
$(wrapercode sh "$(NAME=$NAME_MWMR; g++ -o build-/${NAME} ${NAME}.cpp -lpthread; build-/$NAME )")

## 多线程与锁
- EXAMPLE
$(wrapercode cpp "$(cat ${NAME_SWMR}.cpp)")
- OUTPUT
$(wrapercode sh "$(NAME=$NAME_MUTEX; g++ -o build-/${NAME} ${NAME}.cpp -lpthread; build-/$NAME )")




EOF




