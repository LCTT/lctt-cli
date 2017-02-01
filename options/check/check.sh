#!/bin/bash

# Exit the exoeption.
  set -e

# Check Soft whether exised.
  for SOFT in git readlink;do
    hash $SOFT 1>/dev/null 2>&1 || {
    echo "Error: COMMAND $SOFT is not esised"
    exit 1
    }
  done

# Set Chinese Language
  LANGUAGE1=$(echo $LANG | awk -F "." '{ print $1 }')
  LANGUAGE2=$(echo $LANG | awk -F "." '{ print $2 }')
  test $LANGUAGE1 = zh_CN || echo "Error: OS Language $LANGUAGE1" 
  test $LANGUAGE2 = UTF-8 || echo "Error: OS Language $LANGUAGE2" 

# Check repositories
 git config --list | awk -F "name=" '{print $2}' | xargs >/dev/null 2>&1
 if [ ! $? -eq 0  ];then
 echo "Error: REPOSITORIES is not found"
 fi
