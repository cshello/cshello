#!/usr/bin/env bash

echo '1. 生成根证书'
echo '1.1. 创建私钥'
openssl genrsa -out root.key 2048

echo '1.2. 根据私钥生成证书请求文件(csr文件)'
openssl req -new -out root.csr -key root.key -keyform PEM -subj "/C=CN/ST=myprovince/L=mycity/O=myorganization/OU=mygroup/CN=myname"

echo '1.3. 自签名生成根证书(crt文件)'
openssl x509 -req -in root.csr -out root.crt -signkey root.key -CAcreateserial -days 365


echo '2. 生成服务端证书'
echo '2.1. 创建服务端私钥'
openssl genrsa -out server.key 2048

echo '2.2. 根据服务端私钥 生成证书请求文件'
openssl req -new -out server.csr -key server.key -keyform PEM -subj "/C=CN/ST=myprovince/L=mycity/O=myorganization/OU=mygroup/CN=myname"

echo '2.3. 使用root根证书签发服务器证书'
openssl x509 -req -in server.csr -out server.crt -CA root.crt -CAkey root.key -CAcreateserial -days 365




# Ref 
# https://www.jianshu.com/p/2676cdc688f9



