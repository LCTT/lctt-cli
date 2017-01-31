#!/bin/bash
# Help To Linux'CN Translate Team 
# Filename: $0  Version: 3.1.2  Author:jiwenkangatech@foxmail.com
  
# Exit on exceptions.
set -e

# Environment variable.
#  echo "this need to find user's translateproject"
#  echo "and put it in the environment"

# GetNewOne Usage
usage(){
  echo "Usage: $0 COMMAND [OPTION...]           "
  echo "                                        "
  echo "Options:                                "
  echo "  --list      List LCTT Acticles       " 
  echo "  --commit    Commit Sendto Github        "
  echo "  --check     Check for Errors            "
  echo "  --help      Show help Messages          "
  echo "For example:                            "
  echo "  $0 --check                              "
}

if [ ! "$#" -lt 1  ];then
  case $1 in
    --list)
      bash ./options/list/list.sh
      ;;
    --commit)
      bash ./options/commit/commit.sh
      ;;
    --check)
      bash ./options/check/check.sh
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
