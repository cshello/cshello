#!/usr/bin/env bash


echo 1.系统已经设置的变量

echo :位置变量
echo \$0: [${0}]
echo \$0: [$0]
echo \$1: [$1]
echo \$2: [$2]

echo :变量传递的参数的个数
echo \$#: [$#]

echo :传递的所有变量
echo \$@: [$@]

echo :最近运行进程的退出状态
echo \$?: [$?]

echo :当前脚本的进程号
echo \$\$: [$$]

echo :用户名
echo \$USER: [$USER]

echo :主机名称
echo \$HOSTNAME: [$HOSTNAME]

echo :当前脚本运行了多少秒
sleep 1 && echo \$SECONDS: [$SECONDS]

echo :返回一个随机数
echo \$RANDOM: [$RANDOM]

echo :返回当前所在脚本的行号
echo \$LINENO: [$LINENO]

echo :使用 env 可以查看所有的环境变量
echo --------------- env start
env
echo --------------- env end

echo :使用 set 可以查看所有当前定义的Shell变量

echo :使用 unset 用来清除环境变量


echo 2.自定义变量
myvariable=HelloVariable
echo $myvariable ${myvariable}


echo "
3. 给变量加上引号
    - 单引号\'，严格按照字符输出
    - 双引号\"，对字符串内的变量进行替换
"
myvar='Hello World'
echo $myvar
newvar="More $myvar"
echo $newvar
newvar='More $myvar'
echo $newvar


echo "
4. 命令替换(Command Substitution)
"
myvar=$( ls /etc |wc -l )
echo Three are $myvar entries in the directory /etc.



echo "
5. 导出变量(Exporting Variables)
"
export myvar
# 你可以在执行的终端执行echo $myvar 将打印最后一次赋值的内容






wrapmd() {
echo "\`\`\`$1
$2
\`\`\`
"
}

tmpbuild() {
cp build.sh build-tmp.sh
bash build-tmp.sh $@
}

cat << EOF > 2.Variables.md

# 2.Variables

## SCRIPT
$(wrapmd sh "$(cat build.sh)")

## OUTPUT

### ./build.sh a 1 b 2 c 3
$(wrapmd sh "")

EOF










