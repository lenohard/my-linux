1: 
ffmpeg -i The.Half.Of.It.2020.720p.NF.WEB-DL.DDP5.1.x264-NTG.mkv -vf scale=-1:360 -c:v libx264 -crf 18 -preset veryslow -c:a copy half.mkv
把视频转换成360p的，因为脸部识别，对分辨率的要求不高，但分辨率高的话影响速度

2:
face.py
以一张图片上的人脸为标准，从一个电影中，读取所有含有这张脸的Frame，保存成图片

3:
reorder.py
2中把帧数都保存在文件名里，由于1,所以需要从原视频中提取高清图像，同时由于使用ffmepg合成视频，文件名要连续，所以顺便更改文件名，从0开始

4:
ffmpeg -framerate 25 -i %d.jpg -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p output.mp4

to-do
face.py中为了速度考虑，设置了step，会漏掉很多
在最终的MP4中，有很多画面一闪而过，所以在reorder中，应该根据帧率的连续数量，特意设置重复图片，保证最终结果中显示的足够时间
