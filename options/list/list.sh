#!/bin/bash
# This Can LIST Article

# Exit the exoeption.
  set -e

# Found folder
  export LCTT=$(find / -iname TranslateProject 2>/dev/null |\
  awk -F "TranslateProject"IGNORECASE=1 '{print $1}')

# List Translating.
  cd $LCTT
  grep -RHEni 'github.com/erlinux' | awk -F ':1:' '/:1:/{ print $1 }'
  echo -e "\e[1;33mYou translating...\e[0m" && read

# Core: Goto Find untransalte Acticle.
  cd $LCTT/sources/
  # Found folder And Enter.
  ``grep -RHEi "translated|translating|fanyi|翻译中|申请翻译" | \
  awk -F ":" '{print $1}' | awk -F "/" '{print $2}'`` > /tmp/aaa.txt
  ``find -type f 2>/dev/null | sed -e "s#^[ . ]/##" | awk -F '/' '{print $2}' | grep -v yearbook2015 | \
  grep -v README.md``| grep -v "$( cat  /tmp/aaa.txt)"`` > /tmp/aa.txt
  sed '/^$/d' /tmp/aa.txt | cat -n
