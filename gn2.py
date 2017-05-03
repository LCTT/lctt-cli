#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# @function: solve lctt select contect
import os,platform
lctt_of_python_need_download=('requests','wxPython','GitPython')

def package_pip_check():
    for import_pip in lctt_of_python_need_download:
        try:
            exec(str('import')+' '+ import_pip)
        except ModuleNotFoundError:
            os.system('pip install'+' '+import_pip)

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

def main():
    # Not Windows Platform still to use gn2.sh
    def windows_platform_check():
        if platform.system()!=str("Windows"):
            os.system("git clone https://github.com/lctt/lctt-cli /usr/local/lctt-cli ; \
            ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2")
        else:
            # Check package alive
            package_pip_check()
            git_command_check()
            # Check git.exe Found
    windows_platform_check()

    def git_clone():  # 将 git clone 内容放置于 TranslateProject Folder
        import git
        if not os.path.isdir("TranslateProject"):
            os.makedirs("TranslateProject")
        print("Folder alive.Now Downloading From Github...")
        git.Repo.clone_from(url="https://erlinux@github.com/lctt/TranslateProject", to_path="TranslateProject")
    # git_clone()
main()

