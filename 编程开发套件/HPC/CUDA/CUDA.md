---
author: Bangguo Chen
title: CUDA
description: CUDA
date: 2022-01-15
categories:
    - Basics
    - HPC
tags: 
    - CUDA

---




# CUDA  

## [CUDA安装](../../../../Basics/%E8%BD%AF%E4%BB%B6%E5%AE%89%E8%A3%85/Ubuntu%E4%B8%8B%E5%AE%89%E8%A3%85CUDA/ubuntu%E4%B8%8B%E5%AE%89%E8%A3%85CUDA.md)

## nvcc用法
```sh
# nvcc
nvcc *.cu \
    --generate-code arch=compute_50,code=sm_50 \ # 
    -o hello-world


```

## [cuda-base](cuda-base)



## 参考文档
- [CUDA Toolkit](https://docs.nvidia.com/cuda/index.html)
- [Hands-On-GPU-Accelerated-Computer-Vision-with-OpenCV-and-CUDA](https://github.com/PacktPublishing/Hands-On-GPU-Accelerated-Computer-Vision-with-OpenCV-and-CUDA)













