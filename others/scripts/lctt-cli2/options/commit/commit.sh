#!/bin/bash
# Find The Number.

USER=$(git config --list | awk -F "name=" '{print $2}' | xargs)                        

   read -p "Please enter the number: " SELECT
   NUMBER=$( cat /tmp/aa.txt | sed -n "$SELECT p" | xargs -0 )
   NUMBER_PATH=$(find / -name "$NUMBER")
   echo $NUMBER

# Github -> Add file
    exec[11]=$(find / -name "$NUMBER")
  if [ "$(expr length "${exec[11]}")" -eq 0 ];then
    echo  "Fail to Find this file,Please retry..." 
  else 
    $(sed -i "1i **translating by [$NAME](https://github.com/$NAME)**" $NUMBER_PATH)
    git add "$NUMBER_PATH"
    git commit -am "Translating By "$NAME" "
    git push origin master
  fi

# test $? -eq 0 && {
# echo -e "\e[1;33m   Done.\e[0m"
# echo -e "\e[1;33mPlease Pull New Requert Next\e[0m"
# echo -e "\033[37;36;4mhttps://github.com/$Uname/TranslateProject/pull/new/master\
# \033[39;49;0m\n"
# read && clear
# echo -e "\e[1;33mThanks @"$Uname" https://linux.cn/\e[0m\n"
# }
# fi
#    git push origin $(git_current_branch)
