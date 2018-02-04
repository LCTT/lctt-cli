#!/bin/bash

# Exit the exoeption.
  set -e

# Check Soft whether exised.
  for SOFT in git readlink ssh
  do
    hash $SOFT 1>/dev/null 2>&1 || {
        echo "Error: COMMAND $SOFT could not be called"
    }
  done

# Set Chinese Language.
  LANGUAGE=$(echo $LANG | awk -F "." '{ print $1 }')
  test $LANGUAGE = 'zh_CN' ||  test $LANGUAGE = 'UTF-8' || printf "Error: OS Language $LANGUAGE \nYou can try to set 'LANG=zh_CN.UTF-8'\nWarning: Query result maybe happen wroing becaue OS not support Chinese Langagues.\n"

# Check USER NAME EXIST.
  if [ -z "${LCTT_USER}" ];then
    echo 'Error: Configure user.name AND user.email.'
  fi

# Update Github Repo
  # Found folder
    export LCTT=$(find / -iname TranslateProject 2>/dev/null |\
    awk -F "TranslateProject"IGNORECASE=1 '{print $1}')
  cd $LCTT && git pull https://github.com/lctt/translateproject.git
