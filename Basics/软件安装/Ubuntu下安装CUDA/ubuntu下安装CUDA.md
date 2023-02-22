---
author: Bangguo Chen
title: Ubuntu下安装CUDA
description: 在ubuntu系统上安装`NVIDIA Driver`, `CUDAToolkit`, `cuDNN`。
date: 2023-02-22
categories:
    - 软件安装
    - Ubuntu
tags: 
    - NVIDIA Driver
    - CUDAToolkit
    - cuDNN
---

- [Ubuntu下安装CUDA](#ubuntu下安装cuda)
  - [安装NVIDIA Driver, CUDAToolkit, cuDNN](#安装nvidia-driver-cudatoolkit-cudnn)
    - [安装前注意事项](#安装前注意事项)
    - [在线安装](#在线安装)
    - [本地安装](#本地安装)
  - [参考文档](#参考文档)



# Ubuntu下安装CUDA

## 安装NVIDIA Driver, CUDAToolkit, cuDNN
### 安装前注意事项
1. 注意驱动和cuda的版本对应，会影响pytorch的gpu版本
2. 注意安装驱动时，关闭图像界面，使用文本界面安装


```sh
# 1. 卸载nviida驱动
sudo apt-get remove --purge nvidia*

# 2. 卸载cuda
sudo apt-get remove --purge cuda*
sudo rm -rf /usr/local/cuda*

# 3. 查看本机显卡设备
lspci | grep -i nvidia
lspci |grep VGA

```

### 在线安装
```sh
# 选择合适的驱动版本
ubuntu-drivers devices

# apt安装
apt-get install nvidia-driver-515

```

### 本地安装
1. 下载.run驱动文件，文件如下 [下载地址](https://www.nvidia.com/en-us/drivers/unix/)  
   ![驱动文件](./screenshot-20230218-152639.png)
2. 正确执行安装前准备工作
3. 执行`sudo telinit 3`, 让系统进入文本界面
4. 执行bash安装, 安装驱动，有弹框选择默认


## 参考文档
- https://blog.csdn.net/Perfect886/article/details/119109380

