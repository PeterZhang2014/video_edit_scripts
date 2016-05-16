#! /bin/bash 

# 2016/05/11 , GPL V3.0
# FileName    : spelice_video_files.sh
# Description : Multiple video files together into a video file 
# Author      : peter zhang
# Date        : 09:21 May 11,2016

#SOURCE_VIDEO_FILE_PATH=$1
#TARGET_VIDEO_PATH=$2

SOURCE_1_PATH=$1
SOURCE_2_PATH=$2
TARGET_VIDEO_PATH=$3
MODE=$4

if [ $MODE -eq 0 ];
then
	echo "Current mode is $MODE"
	echo "file '$SOURCE_1_PATH'" >>source_video_list.txt
	echo "file '$SOURCE_2_PATH'" >>source_video_list.txt
	./ffmpeg -f concat -i source_video_list.txt -c copy -y $TARGET_VIDEO_PATH >/dev/null 2>&1
	EXITCODE=$?
	rm -rf source_video_list.txt
	exit $EXITCODE
fi

if [ $MODE -eq 1 ];
then
	echo "Current mode is $MODE"
	./ffmpeg -i $SOURCE_1_PATH  -qscale 10 -y -s 1280x720 -r 29.97 -b 2048 -ar 44100 -ac 2 -strict -2 -f mp4 $SOURCE_1_PATH.mp4 >/dev/null 2>&1
	EXITCODE=$?
	if [ $EXITCODE -eq 0 ];
	then 
		echo "file '$SOURCE_1_PATH.mp4'" >>source_video_list.txt 
		./ffmpeg -i $SOURCE_2_PATH  -qscale 10 -y -s 1280x720 -r 29.97 -b 2048 -ar 44100 -ac 2 -strict -2 -f mp4 $SOURCE_2_PATH.mp4 >/dev/null 2>&1
		EXITCODE=$?
		if [ $EXITCODE -eq 0 ];
		then
			echo "file '$SOURCE_2_PATH.mp4'" >>source_video_list.txt
			./ffmpeg -f concat -i source_video_list.txt -c copy -y $TARGET_VIDEO_PATH >/dev/null 2>&1
			EXITCODE=$?
			rm -rf source_video_list.txt
			rm -rf $SOURCE_1_PATH.mp4
			rm -rf $SOURCE_2_PATH.mp4
			exit $EXITCODE
		else
			rm -rf source_video_list.txt
			rm -rf $SOURCE_1_PATH.mp4
			exit $EXITCODE
		fi
    else
		exit $EXITCODE
    fi
fi

echo "Current mode is default"
./ffmpeg -i $SOURCE_1_PATH -f mpeg -qscale 0 -y -s 1280x720 -r 29.97 -b:v 2048 -ar 44100 -ac 2 $SOURCE_1_PATH.actemp 
EXITCODE=$?
if [ $EXITCODE -eq 0 ] ;
then
	./ffmpeg -i $SOURCE_2_PATH -f mpeg -qscale 0  -y -s 1280x720 -r 29.97 -b:v 2048 -ar 44100 -ac 2 $SOURCE_2_PATH.actemp
	EXITCODE=$?
	if [ $EXITCODE -eq 0 ] ;
	then 
		cat $SOURCE_1_PATH.actemp $SOURCE_2_PATH.actemp > $TARGET_VIDEO_PATH.actemp
		EXITCODE=$?
		if [ $EXITCODE -eq 0 ] ;
		then 
			./ffmpeg -f mpeg -i $TARGET_VIDEO_PATH.actemp -qscale 0 -s 1280x720 -r 29.97 -b:v 2048 -strict -2 -f mp4 -y $TARGET_VIDEO_PATH
			EXITCODE=$?
			rm -rf $SOURCE_1_PATH.actemp
			rm -rf $SOURCE_2_PATH.actemp
			rm -rf $TARGET_VIDEO_PATH.actemp
			exit $EXITCODE
		else
			rm -rf $SOURCE_1_PATH.actemp
			rm -rf $SOURCE_2_PATH.actemp
			exit $EXITCODE
		fi
	else
		rm -rf $SOURCE_1_PATH.actemp
		exit $EXITCODE
	fi
else
	exit $EXITCODE
fi
