---
author: Bangguo Chen
title: 使用Docker安装Jupyter及一些插件
description: "记录服务的安装过程，包括docker配置，插件安装，服务启动等"

date: 2022-01-15
categories:
    - Basics
    - 软件安装
tags: 
    - Jupyter
    - Dockerfile

---

- [使用Docker安装Jupyter及一些插件](#使用docker安装jupyter及一些插件)
  - [通过shell脚本生成docker镜像](#通过shell脚本生成docker镜像)
  - [启动docker服务](#启动docker服务)




# 使用Docker安装Jupyter及一些插件
## 通过shell脚本生成docker镜像
生成的镜像是基于docker的jupyter-lab环境，  
环境中包括了CPP的基础环境，miniconda包管理器，CV算法 深度学习开发的常用py包。  
创建该环境可以用于:  
    1. 基于markdown, ipynb, txt 等文本的笔记记录  
    2. 可以用于CPP， python， 可执行脚本等语言语法特性验证  
如果想使用`jupyter-notebook`, 可以在docker启动时设置 `--entrypoint="jupyter-notebook"`, 来达到使用notebook的需求
```sh
#!/usr/bin/env bash

if [[ `ls |wc -l` > "1" ]]; then
  echo "请在空文件夹中执行此文件"
  exit
else
  ls
fi


# create file
## create ubuntu mirrors
echo "#
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
" > sources.list

## conda mirrors
## https://developer.aliyun.com/mirror/anaconda?spm=a2c6h.13651102.0.0.5bfd1b11gKsy1I
echo "# conda
channels:
  - defaults
show_channel_urls: true
default_channels:
  - http://mirrors.aliyun.com/anaconda/pkgs/main
  - http://mirrors.aliyun.com/anaconda/pkgs/r
  - http://mirrors.aliyun.com/anaconda/pkgs/msys2
custom_channels:
  conda-forge: http://mirrors.aliyun.com/anaconda/cloud
  msys2: http://mirrors.aliyun.com/anaconda/cloud
  bioconda: http://mirrors.aliyun.com/anaconda/cloud
  menpo: http://mirrors.aliyun.com/anaconda/cloud
  pytorch: http://mirrors.aliyun.com/anaconda/cloud
  simpleitk: http://mirrors.aliyun.com/anaconda/cloud

" > .condarc

## pypi mirrors
## https://developer.aliyun.com/mirror/pypi
echo "# pypi
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
" > pip.conf

## py packages
echo "# py packages
numpy
pandas
matplotlib
scipy
scikit-learn

opencv-python
opencv-contrib-python


jupyterlab
# jupyterthemes
# notebook==6.4.12
# jt -t oceans16 -tf merriserif -tfs 10 -nf ptsans -nfs 13
jupyter_contrib_nbextensions
# jupyter contrib nbextension install --user

# jupyterlab extensions
ipydrawio[all]
# https://ipydrawio.readthedocs.io/en/stable/

jupyterlab-kite>=2.0.2
# https://github.com/kiteco/jupyterlab-kite


arxiv
" > requirements.txt

# create Dockerfile

echo "
FROM ubuntu:20.04

WORKDIR /root/progs


# add ubuntu mirrors
COPY sources.list /etc/apt/sources.list


# Install basics
RUN apt-get update -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata

ENV TZ Asia/Shanghai

RUN apt-get install -y build-essential manpages-dev cmake \
&& apt-get install -y apt-utils git curl ca-certificates bzip2 \
&& apt-get install -y tree htop bmon iotop \
&& apt-get install -y wget vim


# can be to use opencv
RUN apt-get -y install lib32z1 libglib2.0-dev \
    libsm6 libxrender1 libxext6 libice6 libxt6 libfontconfig1 libcups2 libgl1-mesa-glx


# Install Miniconda3
RUN wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
&& bash miniconda.sh -b -p /miniconda \
&& rm -rf miniconda.sh

ENV PATH=/miniconda/bin:\$PATH


## Install py packages
RUN python -m pip install --upgrade pip


# Add mirrors
COPY pip.conf /root/.pip/pip.conf
COPY .condarc /root/.condarc

# Add py packages requirements.txt
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt


RUN conda install xeus-cling -c conda-forge -y

#RUN pip install --no-cache-dir torch torchvision
RUN pip install --no-cache-dir torch torchvision --extra-index-url https://download.pytorch.org/whl/cpu


ENTRYPOINT [\"/miniconda/bin/jupyter-lab\"]

" > Dockerfile

# 编译docker文件
docker build -t cshello .


# echo 执行的命令demo
cat << EOF
docker run -itd --name cshello --restart always -p 8888:8888 -v /root/cshello:/root/cshello \
cshello \
-y --allow-root --no-browser \
--ip='0.0.0.0' --notebook-dir=/root/cshello \
--ServerApp.terminado_settings="shell_command=['/bin/bash']" \
--ServerApp.password 'sha1:25981ad2a4fd:87fdfa0a8aeb18fc87130b7991c132c199ff926b' # 密码123
EOF

```

Shell脚本主要是生成一些中间文件和Dockerfile, 按照顺序有以下操作:
1. if判断确保执行脚本的目录下没有其他文件
2. 生成apt镜像配置文件`sources.list`
3. 生成conda镜像配置文件`.condarc`
4. 生成pypi镜像配置文件`pip.conf`
5. 生成安装py第三包的列表文件`requirements.txt`
6. 生成Dockerfile文件，对一写耗时较长的命令，单独RUN一行


## 启动docker服务
```sh
docker run -itd --name {proj-name} --restart always \
-v /root/progs:/root/progs \
-p 8899:8888 \
{docker-mirror-name} \
lab -y --allow-root --no-browser \
--notebook-dir="/root/progs" \
--ip "0.0.0.0" \
--ServerApp.port 8888  \
--ServerApp.password "***" \
--ServerApp.allow_origin="http://notebook.{domain-name}.com"
```

参数设置分为2部分， 一部分是给docker设置参数，另一部分是给`jupyter lab`设置的
- docker参数设置
    - `--name`: 设置docker镜像名称， 可以通过`docker logs <name> -f` 查看镜像内的日志
    - `--restart`: 设置为`always`，当机器重启后会自动run该镜像
    - `-v`: 绑定路径， `本地路径`:`docker路径`
    - `-p`: 绑定端口， `本地端口`:`docker端口`
- jupyter 参数设定
    - `lab`: 设置lab服务
    - `--ServerApp.port`: 设置端口
    - `--ServerApp.password`: 设置密码， 值为加密值，可通过如下命令获取
        ```python
        python -c 'from notebook.auth import passwd; print(passwd("123", algorithm="sha1"))'
        ```
    - `--ServerApp.allow_origin`: 设置允许源


- jupyter 其他可选参数参考

|参数-参考默认值|解释|
|:---|:---|
|`--ServerApp.terminado_settings="shell_command=['/bin/bash']"`|设置terminal终端为bash|

