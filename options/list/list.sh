#!/bin/bash
# This Can LIST Article

# Show The Color.
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

# Exit the exoeption.
  set -e
  
# Found folder And Enter.
  export LCTT=$(find / -iname TranslateProject 2>/dev/null |\
  awk -F "TranslateProject"IGNORECASE=1 '{print $1}')
  cd $LCTT/sources/
  
# Core: Goto Find untransalte Acticle.
  ``grep -RHEi "translated|translating|fanyi|翻译中|申请翻译" | \
  awk -F ":" '{print $1}' | awk -F "/" '{print $2}'`` > /tmp/aaa.txt
  ``find -type f 2>/dev/null | sed -e "s#^[ . ]/##" | awk -F '/' '{print $2}' | grep -v yearbook2015 | \
  grep -v README.md``| grep -v "$( cat  /tmp/aaa.txt)"`` > /tmp/aa.txt
  sed '/^$/d' /tmp/aa.txt | cat -n
