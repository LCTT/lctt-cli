#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# @function: solve lctt select contect
import sys,os
import platform
from list.find_translated import list_and_find

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
    else:
        print('It\'s ok! Congratulation')

def git_github_clone():
    import git
    if not os.path.isdir("TranslateProject"):
        os.makedirs("TranslateProject")
    git.Repo.clone_from(url="https://github.com/lctt/TranslateProject", to_path="TranslateProject")

def main():
    if platform.system()!=str("Windows"):
        os.system("git clone https://github.com/LCTT/lctt-cli/ -b shell-cli /usr/local/lctt-cli ; ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2
")
        sys.exit(0)

    # print "第%d个参数是：%s" % (sys.argv[i])
    try:
        argv_command = sys.argv[1]
        if argv_command ==  '--check-pip':
            package_pip_check()
        elif argv_command == '--check-git':
            git_command_check()
        elif argv_command == '--clone':
            git_github_clone()
        elif argv_command == '--list':
            list_and_find()
    except IndexError:
        print('''
         [*] --check-pip
         [*] --check-git
         [*] --clone
         [*] --list
        ''')

if __name__ == '__main__':
    main()
