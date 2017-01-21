#!/bin/bash
# Usages: Help To Linux'CN Translate Team
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

# Get Github User detail
  read -p "Github User: " Iname
  read -p "Github Mail: " Email
 ## git clone https://$Iname@github.com/$Iname/TranslateProject 
  echo "git clone finshed"
  #! Warm£∫Please add Key login later
  cd ./TranslateProject
  git config --global user.name  "$Iname"
  git config --global user.email "$Email"
 #cd ..
  echo -e "\e[1;32mlctt-cli was got ready\e[0m"
  echo -e "\n\e[1;42m Press any key to continue \e[0m"
  read 

# Show the thime and Say think you
  echo -e "\e[1;33mWelcome, "$Iname"! "$(date "+Time Now: %T")"\e[0m\n"
  #! Warm: Later add morning afternoon

# Set Chinease Language
  LCTT_Language=$(export | grep L)
  #! NOT SO STRONG
  if [[ ! $LCTT_Language =~ "zh_CN.UTF-8" ]];then
     export LC_ALL="zh_CN.UTF-8"
     export LANG="zh_CN.UTF-8"
  fi 

# Show the "lctttranslatemodle" file or not
  echo -e "\033[37;33;5m \
  $(cat "$(find . -inum $(ls -i |grep LCTT | awk '{print $1}'))" | head -n 1)\033[39;49;0m"
  cat "$(find . -inum $(ls -i |grep LCTT | awk '{print $1}'))" | grep -vi \#
  #£°Warm: Not has not do it...

# Find KEYWORDS File.
  {
     KEYWORDS='Translated|translating|fanyi|∑≠“Î÷–|…Í«Î∑≠“Î'
     grep -RLEi "${KEYWORDS}" ../TranslateProject
     } || { 
     find "$PWD" -type f -iname "*.md" | \
     grep -vE '(README\.md|translated\.md)$' | sed 's#^[^/]*/##'
  }
