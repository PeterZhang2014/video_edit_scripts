#! /bin/bash 

#rm -rf /mnt/hgfs/sharedfile/test_video_edit_scripts/*.mp4
./get_video_from_video.sh ../zhangfyTest_zhangfy_2016-04-29_17-34-02.mp4 \
	00:01:00 00:10:00 /mnt/hgfs/sharedfile/test_video_edit_scripts/test_get_video_from_video_00.mp4
EXITCODE=$?
echo "$EXITCODE"
./get_video_from_video.sh ../zhangfyTest_zhangfy_2016-04-29_17-34-02.mp4 \
	00:10:00 00:10:00 /mnt/hgfs/sharedfile/test_video_edit_scripts/test_get_video_from_video_01.mp4
EXITCODE=$?
echo "$EXITCODE"
