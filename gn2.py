#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import platform
from check.check_fix_error import *
from list.find_translated import list_and_find

def main():
    # 先测试 Windows 是否可以完整工作， Linux 用户继续使用分支。beta 版本将包括跨平台测试。
    if platform.system()!=str("Windows"):
        os.system("git clone https://github.com/lctt/lctt-cli /usr/local/lctt-cli ; ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2")
        exit(0)
#   # 为 Windows 用户提供参数选择
    try:
        argv_command = sys.argv[1]
        if argv_command == 'list':
            list_and_find()
        elif argv_command == 'commit':
            pass
        elif argv_command == 'check':
            if check() == True:
                print('\n'+'All was ok~'+' '+'Congratulation!')
        # Python-cli 新功能新特性
        elif argv_command ==  '--check-pip':
            package_pip_check()
        elif argv_command == '--check-git':
            git_command_check()
        elif argv_command == 'clone':
            git_github_clone()
        # 不在预期输入内容
        else:
            raise IndexError
        # 返回如下帮助菜单
    except IndexError:
        print('''
usage: gn2.py [--check-pip] [--check-git] [--help]

These are common gn2 commands used in various situations:

check environment.
   check            check environment is complete

clone translateproject.
   clone            clone lctt-cli from github

list articles.
   list             list translated not yet

in fact `git --check-pip` can automatically fix some errors
such as python package management.''')

if __name__ == '__main__':
   main()
