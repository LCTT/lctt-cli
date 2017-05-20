#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os

def package_pip_check():
    # 包名集合
    lctt_of_python_need_download=['wget','requests','git']
    # 单个处理
    for import_pip in lctt_of_python_need_download:
        try:
            exec('import '+ import_pip)
        except ModuleNotFoundError:
            os.system('pip install '+import_pip)
        finally:
            exec('import '+ import_pip)
    return True
package_pip_check()

def git_command_check_and_fix():
    import requests
    # initialize var
    set_length=0
    set_command='git'
    # 查看命令行数
    for null in os.popen(set_command).readlines():
        set_length+=1
    # 如何小于八行即为命令未安装成功
    if set_length<8:
        print("Now Downloading...")
        git_url='https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.2/PortableGit-2.12.2.2-32-bit.7z.exe'
        response=requests.get(git_url)
        with open("PortableGit-7z.exe","wb") as code:
            code.write(response.content)
        print("Downloading Finished.Please Set PATH and Make Progrme Find \"git\"!")
        os.system("PortableGit-2.12.2.2-32-bit.7z.exe")
    return True

def git_check():
    if git_command_check_and_fix() == True:
        print('Git Command ............  was ok')

