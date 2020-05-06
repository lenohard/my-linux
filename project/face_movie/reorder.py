from os import walk
from shutil import copyfile
import re
import os
import face_recognition
import time
import numpy as np
import cv2

def idx(name):
    i = int(re.search('^(\d+).jpg$', name).groups()[0])
    return i

f = []
for (dirpath, dirnames, filenames) in walk(".."):
    for file in filenames:
        if(re.search('^(\d+).jpg$', file)):
            f.append(file)
    break

f.sort(key=idx)

cap = cv2.VideoCapture('/mnt/data/half/The.Half.Of.It.2020.720p.NF.WEB-DL.DDP5.1.x264-NTG.mkv')
amount_of_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
print("total {}".format(amount_of_frames))

for i,val in enumerate(f):
    if cap.isOpened():
        frame_no = idx(val)
        cap.set(1,frame_no);
        frame_no = val
        ret,frame = cap.read()
        if ret:
            file_name = "%d.jpg"%i
            cv2.imshow('averst',frame)
            cv2.imwrite(file_name, frame)
        else:
            print("read error")
            break
    else:
        print("cap is closed")
        break

cap.release()
cv2.destroyAllWindows()  # destroy all the opened windows

