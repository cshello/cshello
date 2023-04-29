


# Protobuf

## Protobuf是什么？
Protocol Buffers（简称：ProtoBuf）是一种开源跨平台的序列化数据结构的协议。其对于存储资料或在网络上进行通信的程序是很有用的。这个方法包含一个接口描述语言，描述一些数据结构，并提供程序工具根据这些描述产生代码，这些代码将用来生成或解析代表这些数据结构的字节流。

## Protobuf有哪些优缺点
### 特点
1. 高效，相比xml，序列化效率高20～100倍，内存占用率低3～10倍。
2. 代码自动生成。对常见的python，cpp，java等自动生成，结构化清晰。
3. 高兼容性。

### 缺点
1. 二进制格式可读性差。
2. 自描述性差，需要配合proto文件理解字段描述。



## 在Ubuntu上安装protoc
```sh

apt install -y protobuf-compiler

# 查看安装版本
protoc --version

```



## 基本使用





## Refer
- https://protobuf.dev/
