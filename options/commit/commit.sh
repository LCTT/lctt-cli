#!/bin/bash
# Version: 5.0
# Authors: jiwenkangatech@foxmail.com

# var.
  LCTT_USER=$USERNAME
  LCTT_PROJECT=$PROJECT

# 接受用户输入
  read -p "Please enter the number: " SELECT
  NUMBER=$(cat $(echo $NWF) | sed -n "$SELECT p" | xargs -0)
  NUMBER_PATH=$(find $(echo $LCTT_PROJECT) -iname "$NUMBER" 2>/dev/null)
  echo "$NUMBER_PATH"

# 切换到 TranslateProject 项目位置
  cd $(dirname "$NUMBER_PATH")
  # 选中文件并提交给 Github 等待进一步处理
  sed -i "1i **translating by [$(echo ${LCTT_USER})](https://github.com/$(echo ${LCTT_USER}))** \n\n" "$NUMBER_PATH"
  git_time=$(date +%s)
  git branch ${git_time} master
  git checkout ${git_time}
  git add "$NUMBER_PATH"
  git commit -am "Translating By $(echo ${LCTT_USER}) "
  git push origin ${git_time}
  git checkout master

# 给志愿者一个回馈语
  test $? -eq 0 && {
  echo -e "\e[1;33m   Done.\e[0m"
  echo -e "\e[1;33mNext Pull New Requert,Please\e[0m"
  read && clear
  echo -e "\e[1;33mThanks @$(echo ${LCTT_USER}) https://linux.cn/\e[0m\n"
  }
