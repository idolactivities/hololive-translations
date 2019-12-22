#!/usr/bin/env bash

suffix_day() {
  case $1 in
    1|21|31) printf "${1}st";;
    2|22)    printf "${1}nd";;
    3|23)    printf "${1}rd";;
    *)       printf "${1}th";;
  esac
}

source_date="$1"
if [ -z "$2" ]; then
    target_date="today"
else
    target_date="$2"
fi

# We need localized date strings
export LANG=en_US.UTF-8
# But also need the dates to follow Hololive's schedule
export TZ=Asia/Tokyo

date_old=$(date -d "$source_date" +"%Y-%m-%d")
date_new=$(date -d "$target_date" +"%Y-%m-%d")
day_old=$(date -d "$source_date" +%-d)
day_new=$(date -d "$target_date" +%-d)
month_old=$(date -d "$source_date" +%B)
month_new=$(date -d "$target_date" +%B)
weekday_old=$(date -d "$source_date" +%A)
weekday_new=$(date -d "$target_date" +%A)

cp $date_old.ass $date_new.ass
sed -i -e "s/${weekday_old}/${weekday_new}/g" \
    -e "s/${month_old} ${day_old}../${month_new} $(suffix_day $day_new)/g" \
    -e "s/${date_old}/${date_new}/g" \
    -e "/^Scroll Position/d" -e "/^Video Position/d" -e "/^Active Line/d" \
    $date_new.ass
