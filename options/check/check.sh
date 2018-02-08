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
  test $(echo $LANG | awk -F "." '{ print $2 }') = 'UTF-8' || printf "Error: OS Language\n"

# Check USER NAME EXIST.
  if [ -z "${LCTT_USER}" ];then
    echo 'ERROR: Configure user.name and user.email in git repository.'
  fi

# Install 'locate' command package for specific platform
  # Get OS type
  OSTYPE=$(cat /etc/issue | awk 'BEGIN {FS=" ";linecount = 0;nonzero = 1} {if(linecount == 0)print $1;linecount=nonzero}')
  # Try to install mlocate package according to 'OSTYPE'
  if [ "$OSTYPE" = "Ubuntu" ]; then
  # printf "The OS of this computer is Ubuntu.\n"
	hash locate 1>/dev/null 2>&1 || {
  # printf "Trying to install package which provides 'locate' command, press 'enter' to continue or 'ctrl + c' to quit.\n" && read
		sudo apt install -y mlocate
		sudo updatedb            #when first install mlocate, we have to generate database
	}
  elif [ "$OSTYPE" = "CentOS" ]; then
  # printf "The OS of this computer is Centos.\n"
	hash locate 1>/dev/null 2>&1 || {
		sudo yum install -y mlocate
		sudo updatedb
	}
  elif [ "$OSTYPE" = "Arch" ]; then
  # printf "The OS of this computer is Arch.\n"
 	hash locate 1>/dev/null 2>&1 || {
 		sudo pacman -Sy --noconfirm mlocate
 		sudo updatedb
	}
  else
	printf "fatal:Can't detect OS type of this Computer! \ 
                Please install 'mlocate' package manually and restart the program!\n"
        exit 1
  fi

# Found folder
  export LCTT=$(locate --ignore-case --basename TranslateProject 2>/dev/null |\
  awk -F "TranslateProject"IGNORECASE=1 '{print $1}')

# Update Github Repo
  cd $LCTT && git pull https://github.com/lctt/translateproject.git
