#!/bin/bash

export TZ=Asia/Tokyo

tweet=$(twurl "/1.1/search/tweets.json?q=from:hololivetv #おはようホロライブ&result_type=mixed&count=1" | jq -cr '.statuses[0]')
#date=$(date -d @"$(echo "$tweet" | jq '.created_at')" +'%Y-%m-%d')
#date=$(date %a %b %d %H:%M:%S %z %Y
date=$(date +'%Y-%m-%d')
id=$(echo "$tweet" | jq -r '.id_str')

youtube-dl -o "$date.mp4" https://twitter.com/i/web/status/$id
