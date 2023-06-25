

## 如何安装benchmark
```sh
# 1. 下载源码， 
git clone https://github.com/google/benchmark.git
# 2. 编译源码
cd benchmark/
mkdir build && cd build
cmake -DBENCHMARK_DOWNLOAD_DEPENDENCIES=on -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=install ../
make -j8
make install 

```


