#!/bin/bash

# 2016/05/15 , GPL V3.0
# FileName    : get_videofile_info.sh
# Description : Get the infomations of the video file
# Parameter   : $1---->mp4 file being analyzed
#               $2---->the result file to save the infomations got from the mp4-file($1)
# Author      : peter zhang
# Date        : 10:16 May 16, 2016

#return value : 0 success other:failed
#audiochannel : stereo 双声道  mono 单声道 


if [ -z "$1" ] || [ -z "$2" ];then 
    echo "input error !"
    exit 1
else
    if [ "${1##*.}" != "mp4" ] && [ "${1##*.}" != "MP4" ];then 
    	echo "input media filename error ! file_name: $1"
        exit 1
    elif [ ! -f $1 ];then
    	echo "file not exist ! file_name: $1"
	exit 1
    fi
fi

ret=0
#删除旧的信息文件
if [ -f $2 ];then 
    rm $2 -f
fi
#时长
./ffmpeg -i $1 2>&1 |grep -w "Duration:"|awk -F "Duration:" '{print $2}'|awk -F "," '{print "mediatime="$1}' > $2
let ret=$ret+$?
#视频信息
./ffmpeg -i $1 2>&1 |grep -w "Stream"|grep -w "Video"|awk -F "," '{print "videoresolutionrate="$3"\nvideoframerate="$5}' >> $2
let ret=$ret+$?
#音频信息
./ffmpeg -i $1 2>&1 |grep -w "Stream"|grep -w "Audio"|awk -F "," '{print "audiosamprate="$2"\naudiochannel="$3}' >> $2
let ret=$ret+$?
#echo Exec $0 $1 $2 done ! ret = $ret
exit $ret
