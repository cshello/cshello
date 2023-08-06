#!/usr/bin/env bash 

source /cshello/cshello/setup.bash 

md_basename=$(basename $(pwd))

cat << EOF > ${md_basename}.md

# $md_basename  
操作流程
1. 搭建一个rtsp服务
2. 安装ffmpeg
3. 使用python推图片流
4. 使用python解图片流


## 搭建一个RTSP服务  
在 [下载网址](https://github.com/bluenviron/mediamtx/releases) 下载指定mediamtx，并运行
$(wrapercode txt "$(cat mediamtx.log)")


## 安装FFmpeg

## 使用python推图片流
basename pyrtsp.py
$(wrapercode py "$(cat pyrtsp.py)")


## 使用python解图片流
$(wrapercode py "$(cat ocv-show-rstp.py)")


## 参考资料
- https://www.cnblogs.com/Manuel/p/15006727.html
- https://stackoverflow.com/questions/17961318/read-frames-from-rtsp-stream-in-python
- https://stackoverflow.com/questions/33883405/stream-mp4-video-successfully-to-rtmp-with-ffmpeg

EOF

