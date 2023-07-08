#!/usr/bin/env bash

source /cshello/cshello/setup.bash

md_basename=$(basename $(pwd))

cat << EOF > ${md_basename}.md

# ${md_basename}  
## Nginx有什么作用呢？
1. 反向代理  
2. 负载均衡  
3. 动静分离

### 反向代理  
\`\`\`txt 
server {
    listen 80; # 监听服务器的端口号
    location / {
	proxy_pass http://{ip}:{port};  # 转发到指定的服务地址
}

}
\`\`\`

### 负载均衡 
\`\`\`txt

upstream app_server {
    server 192.168.1.5:8080; # 应用服务1
    server 192.168.1.7; # 应用服务2
    server 192.168.2.5:8090; # 应用服务3
}

upstream app_server_weight {
    server 192.168.1.5:8080 weight 10; # 应用服务1，权重占10份
    server 192.168.1.7      weight 30; # 应用服务2，权重占30份
    server 192.168.2.5:8090 weight 20; # 应用服务3，权重占20份
}


server {
    listen 80;
    location / {
	proxy_pass http://app_server; 
	# proxy_pass http://app_server_weight;
    }
}

\`\`\`


### 动静分离  
\`\`\`txt
server {
    listen 80; # 端口号
    location / {
	root /usr/share/nginx/html; # 静态文件路径
    }
}

\`\`\`

## 使用nginx配置https服务  
HTTPS 协议（HyperText Transfer Protocol over Secure Socket Layer）：一般理解为HTTP+SSL/TLS，
通过 SSL证书来验证服务器的身份，并为浏览器和服务器之间的通信进行加密。


### 如何使用nginx配置https服务
#### 1. 需要有一个域名，我们以\`aliyun.com\`为例
#### 2. 需要域名数字证书，域名服务商一般会提供个人免费的证书
#### 3. 需要一个服务程序，例如: \`python3 -m http.server 8080\`
#### 4. 安装nginx，安装成功后会生成nginx的配置路径。我们以\`/etc/nginx\`路径为例
#### 5. 我们查看文件\`/etc/nginx/nginx.conf\` 
从文件中可以看到，会加载符合\`/etc/nginx/conf.d/*.conf\`正则表达的所有配置文件，所以当你有很多个
子域名的时候，可以很方便的配置，一个子域名对应一个配置文件。
$(wrapercode txt "$(cat nginx.conf)")
#### 6. 给子域名\`file.aliyun.com\`配置服务
$(wrapercode txt "$(cat file-aliyun-com.conf)")


EOF



