---
author: Bangguo Chen
title: CUDA
description: CUDA
slug: slug-CUDA
date: 2022-01-15
categories:
    - Basics
tags: 
    - HPC
    - CUDA
---




# CUDA  

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













