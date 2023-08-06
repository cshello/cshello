import cv2
import subprocess as sp
import os 
import time

rtspUrl = 'rtsp://127.0.0.1:8554/test' #这里改成本地ip，端口号不变，文件夹自定义

# 视频来源 地址需要替换自己的可识别文件地址
filePath='./'
camera = cv2.VideoCapture(os.path.join(filePath, "demo.mp4")) # 从文件读取视频

# 视频属性
size = (int(camera.get(cv2.CAP_PROP_FRAME_WIDTH)), int(camera.get(cv2.CAP_PROP_FRAME_HEIGHT)))
sizeStr = str(size[0]) + 'x' + str(size[1])
fps = camera.get(cv2.CAP_PROP_FPS)  # 30p/self
fps = int(fps)
hz = int(1000.0 / fps)
print('size:'+ sizeStr + ' fps:' + str(fps) + ' hz:' + str(hz))

# 视频文件输出
fourcc = cv2.VideoWriter_fourcc(*'XVID')
out = cv2.VideoWriter(filePath+'res_mv.avi',fourcc, fps, size)
# 直播管道输出
# ffmpeg推送rtmp 重点 ： 通过管道 共享数据的方式
command = [
    'ffmpeg',
    # 're',#
    # '-y', # 无需询问即可覆盖输出文件
    '-f', 'rawvideo', # 强制输入或输出文件格式
    '-vcodec','rawvideo', # 设置视频编解码器。这是-codec:v的别名
    '-pix_fmt', 'bgr24', # 设置像素格式
    '-s', sizeStr, # 设置图像大小
    '-r', str(fps), # 设置帧率
    '-i', '-', # 输入
    '-c:v', 'libx264',
    '-pix_fmt', 'yuv420p',
    '-preset', 'ultrafast',
    '-f', 'rtsp',# 强制输入或输出文件格式
    rtspUrl]
print(f"command: {' '.join(command)}")
#管道特性配置
# pipe = sp.Popen(command, stdout = sp.PIPE, bufsize=10**8)
pipe = sp.Popen(command, stdin=sp.PIPE) #,shell=False
# pipe.stdin.write(frame.tostring())
while (camera.isOpened()):
    ret, frame = camera.read() # 逐帧采集视频流
    if not ret:
        break
    ############################图片输出
    # 结果帧处理 存入文件 / 推流 / ffmpeg 再处理
    pipe.stdin.write(frame.tostring())  # 存入管道用于直播
    out.write(frame)    #同时 存入视频文件 记录直播帧数据
    # time.sleep(0.05)
    cv2.waitKey(50)
camera.release()
out.release()
