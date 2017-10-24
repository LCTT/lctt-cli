#!/bin/bash
# Help To Linux'CN Translate Team 
# Filename: $0  Version: 3.1.2  Author:jiwenkangatech@foxmail.com

# Exit on exceptions.
set -e

# Head and thanks
USER=$(git config --list | awk -F "name=" '{print $2}' | xargs)
printf "Hi! $USER ${BOLD}$(date "+Time Now: %T")${NORMAL}\n"

# GetNewTwo Usage
usage(){
  echo "Online help: <https://github.com/lctt/lctt-cli>"
  echo "                                        "
  echo "Usage: $0 [PARAMETER...]                 "
  echo "                                        "
  echo "Parameters:                               "
  echo "  --list      List LCTT Acticles       " 
  echo "  --commit    Commit Sendto Github        "
  echo "  --check     Check for Errors            "
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
    --check)
      bash $(dirname $(readlink -f $0))/options/check/check.sh
      ;;
    --help)
      usage      
      ;;
   *)
      echo "Please to use  \"$0 --help\"  if your need help."      
      exit
      ;;
  esac
else
      usage      
fi