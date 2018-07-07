#!/bin/bash
# Version: 5.0
# Authors: jiwenkangatech@foxmail.com

# var.
  LCTT=$PROJECT
  LCTT_USER=$USERNAME

# 切换到 TranslateProject 项目位置
  cd $LCTT/sources/
  # 找到未被翻译文章并列出
  ``grep -RHEi "translated|translating|fanyi|翻译中|申请翻译" | \
  awk -F ":" '{print $1}' | awk -F "/" '{print $2}'`` > /tmp/aaa.txt
  ``find -type f 2>/dev/null | sed -e "s#^[ . ]/##" | awk -F '/' '{print $2}' | grep -v yearbook2015 | \
  grep -v README.md``| grep -v "$( cat  /tmp/aaa.txt)"`` > /tmp/aa.txt
  sed '/^$/d' /tmp/aa.txt | cat -n | less
