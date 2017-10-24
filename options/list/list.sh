#!/bin/bash
# This Can LIST Article

  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

# 异常则退出
  set -e
  
  # 找到文件夹并进入
  export LCTT=$(find / -iname TranslateProject 2>/dev/null |\
  awk -F "TranslateProject"IGNORECASE=1 '{print $1}')
  #export LCTT2=$( dirname $( readlink -f $LCTT) )
  # 进入目录并向主仓库拉取更新
  cd $LCTT/sources/
  
# 列出总数
# if [[ -d "$LCTT/sources/tech/" ]]; then
#   tech="$LCTT/sources/tech/"
#   tech_num=$(find  $tech  -type f | grep -v README.md |  wc -l)
#   echo "tech have $tech_num article."
# fi
# if [[ -d "$LCTT/sources/talk/" ]]; then
#   talk="$LCTT/sources/talk/"
#   talk_num=$(find  $talk  -type f | grep -v README.md |  wc -l)
#   echo "talk have $talk_num article."
# fi

# 开始查找
  ``grep -RHEi "translated|translating|fanyi|翻译中|申请翻译" | \
  awk -F ":" '{print $1}' | awk -F "/" '{print $2}'`` > /tmp/aaa.txt
  ``find -type f 2>/dev/null | sed -e "s#^[ . ]/##" | awk -F '/' '{print $2}' | grep -v yearbook2015 | \
  grep -v README.md``| grep -v "$( cat  /tmp/aaa.txt)"`` > /tmp/aa.txt
  sed '/^$/d' /tmp/aa.txt | cat -n
