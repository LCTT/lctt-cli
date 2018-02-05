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

#Install 'locate' command package for specific platform
  #Get OS type
  OSTYPE=$(cat /etc/issue | awk 'BEGIN {FS=" ";linecount = 0;nonzero = 1} {if(linecount == 0)print $1;linecount=nonzero}')
  #Try to install mlocate package according to 'OSTYPE'
  if [ "$OSTYPE" = "Ubuntu" ]; then
#	printf "The OS of this computer is Ubuntu.\n"
	hash locate 1>/dev/null 2>&1 || {
#		printf "Trying to install package which provides 'locate' command, press 'enter' to continue or 'ctrl + c' to quit.\n" && read
		sudo apt install mlocate
		sudo updatedb            #when first install mlocate, we have to generate database
	}
  elif [ "$OSTYPE" = "CentOS" ]; then
#	printf "The OS of this computer is Centos.\n"
	hash locate 1>/dev/null 2>&1 || {
#		printf "Trying to install package which provides 'locate' command, press 'enter' to continue or 'ctrl + c' to quit.\n" && read
		sudo yum install -y mlocate
		sudo updatedb
	}
 elif [ "$OSTYPE" = "Arch" ]; then
#	printf "The OS of this computer is Arch.\n"
	hash locate 1>/dev/null 2>&1 || {
#		printf "Trying to install package which provides 'locate' command, press 'enter' to continue or 'ctrl + c' to quit.\n" && read
		sudo pacman -Sy --noconfirm mlocate
		sudo updatedb
	}
  else
	printf "fatal:Can't detect OS type of this Computer!Please install 'mlocate' package manually and restart the program!\n" && exit
  fi

  # Update Github Repo
  # Found folder
    export LCTT=$(locate --ignore-case --basename TranslateProject 2>/dev/null |\
    awk -F "TranslateProject"IGNORECASE=1 '{print $1}')
  cd $LCTT && git pull https://github.com/lctt/translateproject.git
