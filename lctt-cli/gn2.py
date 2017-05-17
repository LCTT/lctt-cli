#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import platform,sys

try:
    from .check.check_fix_error import *
    from .list.find_translated import *
    from .clone.clone_translate import *
    from .commit.select_translated import *
except ModuleNotFoundError:
    from check.check_fix_error import *
    from list.find_translated import *
    from clone.clone_translate import *
    from commit.select_translated import *

def main():
    # beta 版本将包括跨平台测试。
    # 先测试 Windows 是否可以完整工作， Linux 用户继续使用分支。
    if platform.system()!=str("Windows"):
        os.system("git clone https://github.com/lctt/lctt-cli /usr/local/lctt-cli ; ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2")
        exit(0)
    # 仅为 Windows 用户提供参数选择
    try:
        argv_command = sys.argv[1]
        # 显示参数
        print(argv_command+'\n')
        if argv_command == 'version' or argv_command == '-V':
            print('''
            Version: 0.0.4
            # 重新命名并小幅改动，修复部分bug
            ''')
        elif argv_command == 'check' or argv_command =='-ck' or argv_command == '--check-pip':
            if package_pip_check()==True: print('OK!\n')
        elif argv_command == '--check-git':
            git_check()
        elif argv_command == 'clone' or argv_command =='-cp':
            print('You can put \'TranslateProject\' to \'./lctt-cli/test/tmp/\' by youself.')
            print('Then you can pass follow. -> ( Ctrl+C )')
            print('')
            try:
                input('Press Enter to continue...')
            except KeyboardInterrupt:
                print('Program stop')
                exit(0)
            download_translate_project().downloading_now()
        elif argv_command == 'list' or argv_command == '-ls':
            list_and_find()
        elif argv_command == 'commit' or argv_command =='-cm':
            select_translated()
        else:
            # 不在预期输入内容
            raise IndexError
            # 返回如下帮助菜单
    except IndexError:
        print('''
usage: gn2.py [--check-pip] [--check-git] [--help]

These are common gn2 commands used in various situations:

Startup options:
    -V | version                      Print version and exit.
    -h | help                         Print help and exit.

Definite options:
   -ck | check                        Check environment and fix.
   -cp | clone                        clone lctt-cli and exit.
   -ls | list                         list not translated yet.
   -cm | commit                       commit and send github.
   
in fact `git --check-pip` can automatically fix some errors such as python package management.
'''        )

if __name__ == '__main__':
    main()
