#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import platform,os,sys

def main():
    # 先测试 Windows 是否可以完整工作， Linux 用户继续使用分支。beta 版本将包括跨平台测试。
    if platform.system()!=str("Windows"):
        os.system("git clone https://github.com/lctt/lctt-cli /usr/local/lctt-cli ; ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2")
        exit(0)
    # 为 Windows 用户提供参数选择
    try:
        argv_command = sys.argv[1]
        if argv_command == '-V':
        #   print(__version__)
            print('0.0.1')
        elif argv_command == '--list' or argv_command == '-ls':
            pass
        elif argv_command == '--commit' or argv_command =='-cm':
            pass
        elif argv_command == '--check' or argv_command =='-ck':
            pass
        elif argv_command == '--clone' or argv_command =='-cp':
            pass
        else:
            # 不在预期输入内容
            raise IndexError
            # 返回如下帮助菜单
    except IndexError:
        print('''
usage: gn2.py [--check-pip] [--check-git] [--help]

These are common gn2 commands used in various situations:

Startup options:
    -V | --version                      Print version and exit.
    -h | --help                         Print help and exit.

Definite options:
   -ck | --check                        Check environment and fix.
   -cp | --clone                        clone lctt-cli and exit.
   -ls | --list                         list not translated yet.
   -cm | --commit                       commit and send github.
   
in fact `git --check-pip` can automatically fix some errors such as python package management.
'''        )

if __name__ == '__main__':
   main()
