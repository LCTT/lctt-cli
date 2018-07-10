#!/bin/bash
# Version: 5.0
# Authors: jiwenkangatech@foxmail.com

# Exit on exceptions.
  set -e

# color code
RED="31m"      # Error message
GREEN="32m"    # Success message
YELLOW="33m"   # Warning message
BLUE="36m"     # Info message

function colorEcho(){
    COLOR=$1
    echo -e "\033[${COLOR}${@:2}\033[0m"
}

function logging(){
    local COLOR=$1
    local logging=$2
    local service=$3
    colorEcho ${1} "$(date +'%F %T') $2 $3" | sudo tee -a /var/tmp/lctt.log
}

function Look_for_HELP() {
    echo "Online help: <https://github.com/lctt/lctt-cli>"
}

function check_cfg_exist() {
  if [ ! -f /tmp/example.cfg ];then
    Look_for_HELP
    logging ${RED} "\n\tERROR: Please SEE example.cfg File."
    return 1
  fi
}

# 这段代码完全可以直接去掉 funciton 来写，但原意是想加入到上列 if 判断中
# 但是涉及到俩次 function 后的全局变量赋值，故暂时如此写
function set_var_to_files(){
  function read_var_from_file() {
    awk -F "$1=" '{ print $2}' /tmp/example.cfg
  }
  # 这么写有一个坏处，读取变量的时候需要 echo VAR 而不能简单的 VAR 直接调用
  # 解决方法也很简单，在头部重新声明下 VAR2 = echo VAR1
  # 将在后续版本中解决
  export USERNAME=$(read_var_from_file username)
  export PROJECT=$(read_var_from_file project)  
  export SSHKEY=$(read_var_from_file sshkey)     
}
# export 为了其他文件能读取变量 ; export -f 为了$0能读取变量
export -f set_var_to_files
# 读取应用以后还需要执行
set_var_to_files

function var_check() {
  if [ -z $USERNAME ] && [ -z $PROJECT ];then
    logging ${RED} "\n\tERROR: LCTT-CLI Project need variable in configuration."
    return 1
  elif [ -z $SSHKEY ];then
    logging ${YELLOW} "\n\tWARNING: You did not fill in sshkey variable."
    return 2
  fi
}

#--------------------#

usage(){
  echo "Online help: <https://github.com/lctt/lctt-cli>"
  echo "                                        "
  echo "Usage: $0 [PARAMETER...]                "
  echo "                                        "
  echo "Parameters:                             "
  echo "  --commit    Commit Sendto Github      "
  echo "  --help      Show Help                 "
  echo "For example:                            "
  echo "  $0 --help                             "
  echo "                                        "
}

if [ ! "$#" -lt 1  ];then
  echo "hi"$USERNAME"! It is $(date +%T)"
  case $1 in
    --list )
      bash $(dirname $(readlink -f $0))/options/list/list.sh
      ;;
    --commit )
      bash $(dirname $(readlink -f $0))/options/list/list.sh
      ;;
    --help)
      usage
      ;;
   *)
      echo "Please use  \"$0 --help\" to Get Help."
      exit 2
      ;;
  esac
else
      usage
fi

# 检查配置文件是否存在
check_cfg_exist
# 确定变量有内容
var_check
