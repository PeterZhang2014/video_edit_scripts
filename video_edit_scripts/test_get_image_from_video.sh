#! /bin/bash 

#rm -rf /mnt/hgfs/sharedfile/test_video_edit_scripts/*.jpg
./get_image_from_video.sh /home/zhangfy/MyWork/GIP/zhangfyTest_zhangfy_2016-04-29_17-34-02.mp4 00:00:10 /mnt/hgfs/sharedfile/test_video_edit_scripts/test_get_image_from_video.jpg
#./get_image_from_video.sh /home/zhangfy/MyWork/GIP/test_error.mp4 00:00:10 /mnt/hgfs/sharedfile/test_video_edit_scripts/test_error.jpg
EXITCODE=$?
echo "$EXITCODE"
