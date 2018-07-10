#!/bin/bash
# Version: 5.0
# Authors: jiwenkangatech@foxmail.com

# var.
  LCTT=$PROJECT
  LCTT_USER=$USERNAME
  export ODF=$(mktemp)
  export NWF=$(mktemp)

# 切换到 TranslateProject 项目位置
  cd $LCTT/sources/
  # 找到未被翻译文章并列出
  grep -RHEi "translated|translating|fanyi|翻译中|申请翻译" | \
  awk -F ":" '{print $1}' | awk -F "/" '{print $2}' > $(echo $ODF)
  find -type f 2>/dev/null | sed -e "s#^[ . ]/##" | awk -F '/' '{print $2}' | grep -v yearbook2015 | \
  grep -v README.md``| grep -v "$( cat $(echo $ODF))" > $(echo $NWF)
  sed '/^$/d' $(echo $NWF) | cat -n | less

bash "$(dirname $0)/../commit/commit.sh"
test $? -eq 0 && exit 0
