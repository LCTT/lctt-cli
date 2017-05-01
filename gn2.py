#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# @function 解决LinuxCN择题困难

import os,platform
lctt_of_python_need_download=['requests']

# this Zone Can resolve pip_check
def package_pip_check():
    pip_import=list(lctt_of_python_need_download)
    for import_pip in pip_import:
        try:
            import import_pip
        except ModuleNotFoundError:
            os.system('pip install'+' '+import_pip)
            raise ImportError("Not Package Name Was"+import_pip+"Now Downloaded")

# Not Windows Platform still to use gn2.sh
def windows_platform_check():
    # ls_windows:
    if platform.system()!=str("Windows"):
        os.system("git clone https://github.com/lctt/lctt-cli /usr/local/lctt-cli ; \
        ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2")
    else:
        package_pip_check()

# Check git.exe Found
def git_command_check():
    set_length=0
    set_command='git'
    # ck_git:
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
git_command_check()
