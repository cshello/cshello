import numpy as np 
import cv2
import os
#Below code will capture the video frames and will sve it a folder (in current working directory)

dirname = 'images'
#video path
# cap = cv2.VideoCapture("demo.mp4")
cap = cv2.VideoCapture("rtsp://127.0.0.1:8554/test")
count = 0
while(cap.isOpened()):
    ret, frame = cap.read()
    # ret = True
    # frame = np.random.randint(0, 255, (480, 640, 3), dtype=np.uint8)
    if not ret:
        break
    else:
        cv2.imshow('frame', frame)
        #The received "frame" will be saved. Or you can manipulate "frame" as per your needs.
        name = "rec_frame"+str(count)+".jpg"
        # cv2.imwrite(os.path.join(dirname,name), frame)
        count += 1
    if cv2.waitKey(20) & 0xFF == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()
