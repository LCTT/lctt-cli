#!/bin/bash

# Exit the exoeption.
  set -e

# Check Soft whether exised.
  for git in soft
  do
    hash $soft 1>/dev/null 2>&1 || {
    echo "Error: COMMAND $soft is not esised"
    exit 1
    }
  done

# Set Chinese Language
  LANGUAGE1=$(echo $LANG | awk -F "." '{ print $1 }')
  LANGUAGE2=$(echo $LANG | awk -F "." '{ print $2 }')
  test $LANGUAGE1 = zh_CN || echo "Error: OS Language $LANGUAGE1" 
  test $LANGUAGE2 = UTF-8 || echo "Error: OS Language $LANGUAGE2" 
