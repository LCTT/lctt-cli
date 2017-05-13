#!/usr/bin/env python3
# -*- coding:utf-8 -*-

def package_pip_check():
    import os
    lctt_of_python_need_download=['wget']
    for import_pip in lctt_of_python_need_download:
        try:
            exec('import '+ import_pip)
        except ModuleNotFoundError:
            os.system('pip install '+import_pip)
    print('OK!'+'\n')
    return True
package_pip_check()

###############################################################

# 方法已经更改，不在需要如下
def git_command_check():
    import requests
    set_length=0
    set_command='git'
    for null in os.popen(set_command).readlines():
        set_length+=1
    # ls_git:
    if set_length<8:
        print("Now Downloading...")
        git_url='https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.2/PortableGit-2.12.2.2-32-bit.7z.exe'
        response=requests.get(git_url)
        with open("PortableGit-7z.exe","wb") as code:
            code.write(response.content)
        print("Downloading Finished.Please Set PATH and Make Progrme Find \"git\"!")
        os.system("PortableGit-2.12.2.2-32-bit.7z.exe")
    return True

def check():
    if package_pip_check() == True:
        print('\n')
        print('Python Package Management was ok')
    if git_command_check() == True:
        print('Git Command ............  was ok')
    return True
