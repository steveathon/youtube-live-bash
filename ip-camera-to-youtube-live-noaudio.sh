#!/bin/sh

# Enter the FPS you want to stream out at.
FPS="30"

# This is the standard YT Live URL
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"

# What is your RTSP source?
SOURCE="rtsp://admin:password@device.address/camera1?stream=1"

# What is your KEY?
KEY="enter-your-key-here"

# This script will keep restarting the ffmpeg stream even when it crashes, (which sometimes happens on IP cameras),
# however it will stop if you exit ffmpeg gracefully.

while true; do
ffmpeg -f lavfi -i anullsrc -rtsp_transport tcp -i "$SOURCE"  \
-tune zerolatency -pix_fmt + -c:v copy -c:a aac -strict experimental \
-r $FPS -g $(($FPS * 2))  \
-f flv "$YOUTUBE_URL/$KEY" && break;
done
