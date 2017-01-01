#!/bin/bash 
#
##Script for help to "LCTT"	author:jiwenkangatech@foxmail.com


##主功能调用区
which=/usr/bin/which
function enter_dir() {
if [ ! -d "../TranslateProject" ];then
	$(command -v echo) -e "\e[1;31m "Please Run In the \"TranslateProject\" directory" \e[0m"
	command exit 4
fi
}
function maths_now() {
if [  -d "./sources/" ];then
	tech=./sources/tech/			
	echo $tech 目录共有$($(command -v find)  $tech  -type f | $( command -v grep) -v README.md |  $(command -v wc) -l)个文件
	talk=./sources/talk/	
	echo $talk 目录共有$($(command -v find)  $talk  -type f | $( command -v grep) -v README.md |  $(command -v wc) -l)个文件
else
	echo "Missing folders"	
	command exit 1
fi
}
function find_translated() {
	cat /dev/null > /tmp/TranslateProject_talk.txt
	cat /dev/null > /tmp/TranslateProject_tech.txt
	for i in translating fanyi 翻译中 申请翻译
	do
		cd $talk && grep -RHi $i | grep -v LCTT翻译规范.md | grep -v .git | cut -d ":" -f 1 >> /tmp/TranslateProject_talk.txt && cd ../..
		cd $tech && grep -RHi $i | grep -v LCTT翻译规范.md | grep -v .git | cut -d ":" -f 1 >> /tmp/TranslateProject_tech.txt && cd ../..
	done	
}
function zuihou(){
cat /dev/null > /tmp/TranslateProject.txt
find $tech -type f |grep -v README.md | grep  -v "$( cat /tmp/TranslateProject_tech.txt  | uniq  | cut -d "/" -f 3 )" >> /tmp/TranslateProject.txt
find $talk -type f |grep -v README.md | grep  -v "$( cat /tmp/TranslateProject_talk.txt  | uniq  | cut -d "/" -f 3 )" >> /tmp/TranslateProject.txt
#这样写肯定不好，并且最好一条会有漏网之鱼
}
##其他的小功能
function first_display() {
	echo -e "\n" 
	echo -e "\033[37;33;5m$(cat LCTT翻译规范.md | head -n 1)\033[39;49;0m"
	cat LCTT翻译规范.md | tail -n 3		# 这里有bug,一旦文件被添加只能显示最后三行
	echo -e "\n" 
        $(command -v echo) -e "\e[1;42m Press any key to continue \e[0m"
	read anykey
}

##这里是主代码区
enter_dir	# 确定用户在 “TranslateProject” 目录
first_display	# 给用户展示 “Linux中国翻译规范” 文件
maths_now	# 告知用户 “LCTT” 总共有多少文件（全部）
find_translated	# 综合 "keyword" 至 /tmp/TranslateProject.txt 文件
zuihou
echo $tech 已翻译$(cat /tmp/TranslateProject_tech.txt | wc -l)个文章
echo $talk 已翻译$(cat /tmp/TranslateProject_talk.txt | wc -l)个文章
	echo -e "\n" 
cat /tmp/TranslateProject.txt | less
