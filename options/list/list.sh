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
  export LCTT=$(find ~ -iname TranslateProject 2>/dev/null |\
  awk -F "TranslateProject"IGNORECASE=1 '{print $1}')
  #export LCTT2=$( dirname $( readlink -f $LCTT) )
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

  function file-translating-p ()
  {
      local file="$@"
      head "$file" |egrep "translate|fanyi|翻译" >/dev/null 2>&1
  }

  function show-if-not-translating ()
  {
      local file="$@"
      if ! file-translating-p "$file";then
          echo "$file"
      fi
  }
# 开始查找
  # find ./ -type f -print0|xargs -0 -I{} bash ./show_if_not_translating.sh {} |cat -n
  find ./ -type f -name "2*.md" -print|while read file
  do
      show-if-not-translating $file
  done | sed -e "s#^[ . ]/##" | awk -F '/' '{print $2}' |cat -n
