#!/bin/bash
# Usages: Help To Linux'CN Translate Team
# Filename: $0 	Version: 2.0.1 	Author:jiwenkangatech@foxmail.com

# exit on exceptions.
  set -e 	#变量不存在或异常直接退出

# Determine whether the tool exists
#  for soft in git locate #测试 “$soft” 是否存在
   for soft in git #测试 “$soft” 是否存在
    do
		hash $soft >/dev/null 2>&1 || {
		echo "Error: $soft is not installed"
    		exit 1
          }
    done
#  $( command -v updatedb & ) #更新系统 "locate" 数据表

# Clone Github's Repositories
#function Github_Clone () {
#  Github_User="$(cat ./TranslateProject/.git/config | sed -n '8p' | \
#  cut -d / -f4 1>/dev/null)" #检测 .git/config 文件内容
#  if [[ $Github_User = lctt ]] && [ -f ~/.ssh/id_rsa ] ;then
  	read -p "Github User: " Iname
	read -p "Github Mail: " Email
	git clone https://github.com/$Iname/TranslateProject 	
	cd ./TranslateProject
     git config --global user.name  $Iname
     git config --global user.email $Email
	cd ..
#	while true && touch /tmp/lctt$(date +%m) 
	echo -en "\e[1;32mlctt-cli was got ready "
#    else
#  	read -p "请输入 Github 账户: " Iname
#	git clone git@github.com:$Iname/TranslateProject
#	touch /tmp/lctt$(date +%m) 
#	echo -e "\e[1;32m lctt-cli was got ready "
#  fi }


# Determine the location And Change to $0 floder
##  $SHELL -c "export LCTT_DIR="$(dirname "$(readlink -f "$0")")"" 
  					   #设置环境变量(无法执行)
##  $(export LCTT_PWD="$PWD") #设置环境变量(不能执行)
##  exec[11]=$(test -f /tmp/lctt$(date +%m) || locate -i translate | \
##  awk "/project/" GNORECASE=0 ) #/tmp文件存在，则检查 "translateproject" 是否存在
##  if [ "$(expr length "${exec[11]}")" -eq 0  ] || [ -z "$(expr length \
##  "${exec[11]}")" ] ;then       #检测有结果 或者 检测为空(没检查)
 #  	git clone https://github.com/lctt/TranslateProject #克隆 LCTT 仓库
##	Github_Clone #执行函数式
##  else
##	echo -e "\e[1;31m Please CHECK \"TranslateProject\" Floder\e[0m"
##  fi

# Welcome and Run
	echo -e "\e[1;33m\nWelcome join the LCTT,thank you! $Iname \e[0m"
