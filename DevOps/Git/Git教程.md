---
author: Bangguo Chen
title: Git教程
description: 记录Git常用操作，满足日常所需。
date: 2022-03-30
categories:
    - DevOps
    - Basic
tags: 
    - Git

---


# Git教程

## Git练习01

## Git练习02

### 创建一个新目录
`mkdir build-GitTest01`

### 初始化仓库
`git init`

### 创建a.txt文件，增加内容
`touch 123 > a.txt`

### 将修改的文件从工作区转换到暂存区
#### 转换所有文件
`git add .`
#### 转换指定文件
`git add a.txt`
#### 转换多个指定文件
`git add a1.txt a2.txt`

### 将文件从暂存区转换到工作区
#### 转换所有文件

#### 转换指定文件
##### 将工作区内容直接重置为暂存区的内容

##### 与工作区内容合并，不管文件是否修改
- `git reset a.txt`
##### 将工作区内容重置为暂存区内容
- `git checkout -- a.txt`



#### 转换多个指定文件


### 区域文件删除

##### 删除工作区文件
- `git rm a.txt -f`

##### 删除暂存区文件
- `git rm a.txt --cached`



