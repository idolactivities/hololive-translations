#!/bin/bash

export TZ=Asia/Tokyo

if [ -z "$1" ]; then
    date=$(date +'%Y-%m-%d');
else
    date="$1"
fi

ffmpeg -i "$date.mp4" \
    -c:v libx264 -profile:v high -level 3.2 -preset veryslow -tune film \
    -vf "format=pix_fmts=rgb32,subtitles=$date.ass,format=pix_fmts=yuv420p,scale=1280:720" \
    -c:a copy "$date-subbed.mp4"
