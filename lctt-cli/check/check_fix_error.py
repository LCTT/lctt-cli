#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import sys,os

lctt_of_python_need_download=('requests','wxPython','GitPython')

def __init__(self,keyword):
    self.keyword = '111111'

def package_pip_check():
    for import_pip in lctt_of_python_need_download:
        try:
            exec('import '+ import_pip)
        except ModuleNotFoundError:
            os.system('pip install '+import_pip)
    return True

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

def git_github_clone():
   import git
   if not os.path.isdir("TranslateProject"):
       os.makedirs("TranslateProject")
       git.Repo.clone_from(url="https://github.com/lctt/TranslateProject", to_path="TranslateProject")
