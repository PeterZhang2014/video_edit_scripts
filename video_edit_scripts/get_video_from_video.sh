#! /bin/bash 

# 2016/05/04, GPL V3.0
# FileName    : get_video_from_video.sh
# Description : Gets a specified length of video A (target) from the specified
#               position of the video B (source) .
# Author      : peter zhang
# Date        : 17:02 May 4, 2016
#
# Example     : ./get_video_from_video.sh SOURCE_VIDEO_PATH CUT_START(hh:mm:ss) CUT_DURATION(hh:mm:ss) TARGET_VIDEO_PATH 

SOURCE_VIDEO_PATH=$1
CUT_START=$2
CUT_DURATION=$3
TARGET_VIDEO_PATH=$4

./ffmpeg -i $SOURCE_VIDEO_PATH -ss $CUT_START -t $CUT_DURATION -y -vcodec copy \
	-acodec copy $TARGET_VIDEO_PATH > /dev/null 2>&1
exit $?
