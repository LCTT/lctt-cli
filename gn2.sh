#!/bin/bash
# Version: 4.0
# Author: jiwenkangatech@foxmail.com

# Exit on exceptions.
  set -e

function LCTT-CLI() {
    echo "Online help: <https://github.com/lctt/lctt-cli>"
    exit 1
}

function check1() {
  if [[ ! -f /tmp/lctt.cfg ]] ;then
    echo "ERROR: LCTT-CLI Project need configuration."
    LCTT-CLI
  fi
}

function var() {
  function model(){
    awk -F "$1"= '{ print $2}' /tmp/lctt.cfg 
  }
  export username=$(model username)
  export project=$(model project)
  export sshkey=$(model sshkey)
}

function check2() {
  if [ -z $username ] && [ -z $project ];then
    echo "ERROR: LCTT-CLI Project need variable in configuration."
    LCTT-CLI
  else
    echo "Hi,"$username"! It's $(date +%T)"
  fi
  if [ -z $sshkey ];then
    echo "WARNING: You did not fill in sshkey variable."
    return 1
  fi
}

# 检查配置文件是否存在
check1
# 读取内容并设为全局变量
var
# 确定变量有内容
check2


#--------------------#


# GetNewTwo Usage
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
