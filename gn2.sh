#!/bin/bash
# Version: 4.0
# Author: jiwenkangatech@foxmail.com

# Exit on exceptions.
  set -e

# color code
RED="31m"      # Error message
GREEN="32m"    # Success message
YELLOW="33m"   # Warning message
BLUE="36m"     # Info message

colorEcho(){
    COLOR=$1
    echo -e "\033[${COLOR}${@:2}\033[0m"
}

logging(){
    local COLOR=$1
    local logging=$2
    local service=$3
    colorEcho ${1} "$(date +'%F %T') $2 $3" | sudo tee -a /var/tmp/lctt.log
}

function Look_for_HELP() {
    echo "Online help: <https://github.com/lctt/lctt-cli>"
}


function check_cfg_exist() {
  if [[ ! -f /tmp/lctt.cfg ]] ;then
    Look_for_HELP
    logging ${RED} "\n\tERROR: Please SEE example.cfg File."
    return 1
  fi
}

function set_var_to_golbal() {
  function read_var_from_file(){
    awk -F "$1=" '{ print $2}' /tmp/lctt.cfg 
  }
  export username=$(read_var_from_file username)
  export project=$(read_var_from_file project)
  export sshkey=$(read_var_from_file sshkey)
}

function var_check() {
  if [ -z $username ] && [ -z $project ];then
    logging ${RED} "\n\tERROR: LCTT-CLI Project need variable in configuration."
    Look_for_HELP
    return 1
  elif [ -z $sshkey ];then
    logging ${YELLOW} "\n\tWARNING: You did not fill in sshkey variable."
    return 2
  else
    echo "hi "$username" It is $(date +%T)"
  fi
}

#--------------------#

usage(){
  echo "Online help: <https://github.com/lctt/lctt-cli>"
  echo "                                        "
  echo "Usage: $0 [PARAMETER...]                 "
  echo "                                        "
  echo "Parameters:                               "
  echo "  --list      List LCTT Acticles       "
  echo "  --commit    Commit Sendto Github        "
  echo "  --help      Show help Messages          "
  echo "For example:                            "
  echo "  $0 --help                               "
  echo "                                        "
}

if [ ! "$#" -lt 1  ];then
  case $1 in
    --list)
      bash $(dirname $(readlink -f $0))/options/list/list.sh
      ;;
    --commit)
      bash $(dirname $(readlink -f $0))/options/commit/commit.sh
      ;;
    --help)
      usage
      ;;
   *)
      echo "Please to use  \"$0 --help\"."
      exit
      ;;
  esac
else
      usage
fi

# 检查配置文件是否存在
check_cfg_exist
# 读取内容并设为全局变量
set_var_to_golbal
# 确定变量有内容
var_check
