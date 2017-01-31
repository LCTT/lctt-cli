#!/bin/bash
# Help To Linux'CN Translate Team 
# Filename: $0  Version: 3.1.2  Author:jiwenkangatech@foxmail.com

  if which tput >/dev/null 2>&1; then                                                  
      ncolors=$(tput colors)                                                           
  fi                                                                                   
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then                       
    RED="$(tput setaf 1)"                                                              
    GREEN="$(tput setaf 2)"                                                            
    YELLOW="$(tput setaf 3)"                                                           
    BLUE="$(tput setaf 4)"                                                             
    BOLD="$(tput bold)"                                                                
    NORMAL="$(tput sgr0)"                                                              
  else                                                                                 
    RED=""                                                                             
    GREEN=""                                                                           
    YELLOW=""                                                                          
    BLUE=""                                                                            
    BOLD=""                                                                            
    NORMAL=""                                                                          
  fi   

# Exit on exceptions.
set -e

# Head and thanks
USER=$(git config --list | awk -F "name=" '{print $2}' | xargs)
printf "Hi! $USER ${BOLD}$(date "+Time Now: %T")${NORMAL}\n"

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
      source "$PWD/options/list/list.sh"
      ;;
    --commit)
      source "$PWD/options/commit/commit.sh"
      ;;
    --check)
      source "$PWD/options/check/check.sh"
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
