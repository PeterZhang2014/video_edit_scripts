#! /bin/bash 

# 2016/05/04 , GNU V3.0
# FileName    : get_image_from_video.sh
# Description : Get a picture in JPG format at the beginning of the video in MP4
#               format and the default size of the picture is 256x144
# Author      : peter zhang
# Date        : 14:12 May 4, 2016
#
# Example     : ./get_image_from_video.sh xxx/xxx/.../xxx.mp4 xx(h):xx(m):xx(s) xxx/xxx/.../xxx.jpg

SOURCE_VIDEO_PATH=$1
TIME_POINT=$2
TARGET_IMAGE_PATH=$3

./ffmpeg -i $SOURCE_VIDEO_PATH -y -f image2 -ss $TIME_POINT -y \
	-vframes 1 -s 256x144 $TARGET_IMAGE_PATH > /dev/null 2>&1
exit $?
