#!/bin/bash
# Help To Linux'CN Translate Team
# Filename: $0 	Version: 2.0.1 	Author:jiwenkangatech@foxmail.com

# Exit the exception.
  set -e

# Check Soft whether existed.
  for git in soft
  do
 	 hash $soft >/dev/null 2>&1 || {
 	 echo "Error: $soft is not installed"
  	 exit 1
  	 }
  done

# Set Chinease Language
  LCTT_Language=$(echo $LANG)
  #! NOT SO STRONG
  if [[ ! $LCTT_Language =~ "zh_CN.UTF-8" ]];then
    export LANG="zh_CN.UTF-8" || export LC_ALL="zh_CN.UTF-8" 
    test  $? -eq 0 || { 
    echo -e "\e[1;31mPlease Check \"Chinese Support\" was install or not\e[0m\n"
    exit 1
    }
  fi 

# Get Github User detail
  read -p "Github User: " Iname
  read -p "Github Mail: " Email
  #! Warm: Test User INPUT
  #git clone https://$Iname@github.com/$Iname/TranslateProject 
  #! Warm£ºPlease add Key login later
  cd $PWD/TranslateProject
  git config --global user.name  "$Iname"
  git config --global user.email "$Email"
  echo -e "\e[1;32mlctt-cli was got ready\e[0m"
  echo -e "\n\e[1;42m Press any key to continue \e[0m"
  read 

# Show the "lctttranslatemodle" file or not
  echo -e "\033[37;33;5m \
  $(cat "$(find . -inum $(ls -i |grep LCTT | \
  awk '{print $1}'))" | head -n 1)\033[39;49;0m"
  cat "$(find . -inum $(ls -i |grep LCTT | awk '{print $1}'))" | grep -vi \#
  #£¡Warm: Not has not do it...

# Show the thime and Say think you
  echo -e "\e[1;33m\nWelcome, "$Iname"! "$(date "+Time Now: %T")"\e[0m\n"
  #! Warm: Later add morning afternoon

# Find File.
# KEYWORDS="*translated|*translating|*fanyi|*·­ÒëÖÐ|*ÉêÇë·­Òë"
# cd $PWD/../TranslateProject/sources/tech/
# grep -RHEvi ${KEYWORDS} * | grep -Ev "LCTT·­Òë¹æ·¶.md|.git|README" | \
# grep -RHEvi ${KEYWORDS} * | grep -Ev "$(find . -type d | sed 's#[^/]*/##' | \
# awk -F '[/]' '{print $2}')|LCTT·­Òë¹æ·¶.md|.git|README" | \
#  cut -d "/" -f2  | awk -F '.md:' '{print $1}' | sort -u | sed -s 's/$/.md/'
# sed -s 's/^/"/;s/$/",/' | less 
  if [[ -d "$PWD/../TranslateProject/sources/tech/" ]]; then
    tech="$PWD/../TranslateProject/sources/tech/"
    find  $tech  -type f | grep -v README.md |  wc -l
  fi
  if [[ -d "$PWD/../TranslateProject/sources/talk/" ]]; then
    talk="$PWD/../TranslateProject/sources/talk/"
    find  $talk  -type f | grep -v README.md |  wc -l
  fi

# Show File.
  cat /dev/null > /tmp/TranslateProject_talk.txt
  cat /dev/null > /tmp/TranslateProject_tech.txt
  cat /dev/null > /tmp/TranslateProject.txt

  for i in translated translating fanyi ·­ÒëÖÐ ÉêÇë·­Òë 
  do
  cd $talk && grep -RHi $i *| cut -d ":" -f 1 >> /tmp/TranslateProject_talk.txt 
  cd $tech && grep -RHi $i *| cut -d ":" -f 1 >> /tmp/TranslateProject_tech.txt
  done

  find $tech -type f |grep -v README.md |\
  grep -v "$(cat /tmp/TranslateProject_tech.txt |\
  sort -u )" >> /tmp/TranslateProject.txt
  find $talk -type f |grep -v README.md |\
  grep -v "$(cat /tmp/TranslateProject_talk.txt |\
  sort -u )" >> /tmp/TranslateProject.txt
