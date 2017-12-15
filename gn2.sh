#!/bin/bash
# Help To Linux'CN Translate Team
# Filename: $0  Version: 3.1.2  Author:jiwenkangatech@foxmail.com

# Exit on exceptions.
  set -e

# Head and thanks
  LCTT_USER=$(git config --list | awk -F 'user.name=' '{print $2}' | sort -rn | head -n1)
  printf "Hi! $LCTT_USER ${BOLD}$(date "+Time Now: %T")${NORMAL}\n"
  export LCTT_USER

# GetNewTwo Usage
  usage(){
    echo "Online help: <https://github.com/lctt/lctt-cli>"
    echo "                                        "
    echo "Usage: $0 [PARAMETER...]                 "
    echo "                                        "
    echo "Parameters:                               "
    echo "  --check     Check for Errors            "
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
      --check)
        bash $(dirname $(readlink -f $0))/options/check/check.sh
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
