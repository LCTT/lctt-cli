#!/bin/bash
# Find The Number.

# Accept user input.
  read -p "Please enter the number: " SELECT
  NUMBER=$( cat /tmp/aa.txt | sed -n "$SELECT p" | xargs -0 )
  NUMBER_PATH=$(find / -name "$NUMBER" 2>/dev/null )
  echo $NUMBER

# Github -> Add file.
  cd $(dirname "$NUMBER_PATH")
# Core: Write And Send.
  sed -i "1i **translating by [$LCTT_USER](https://github.com/$LCTT_USER)**\n" "$NUMBER_PATH"
  echo $NUMBER_PATH
  git add "$NUMBER_PATH"
  git commit -am "Translating By $LCTT_USER "
  git push origin master

# Say Thx
  test $? -eq 0 && {
  echo -e "\e[1;33m   Done.\e[0m"
  echo -e "\e[1;33mNext Pull New Requert,Please\e[0m"
  echo -e "\033[37;36;4mhttps://github.com/$LCTT_USER/TranslateProject/pull/new/master\
  \033[39;49;0m\n"
  read && clear
  echo -e "\e[1;33mThanks @"$LCTT_USER" https://linux.cn/\e[0m\n"
  }
