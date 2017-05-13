#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import re,you_get,os

def wget_download(url='http://codeload.github.com/LCTT/TranslateProject/zip/master',filename='TranslateProject.zip'):
    import wget,os
    def downloaing():
        wget.download(url,filename)
    def unzip():
        os.system('python -m zipfile -e .\TranslateProject.zip ..\list')
    def del_downloaing():
        if os.path.exists('.\TranslateProject.zip'): os.remove('.\TranslateProject.zip')
        if os.path.exists('..\list\TranslateProject-master'): os.rename('..\list\TranslateProject-master','..\list\TranslateProject')

    downloaing()
    unzip()
    del_downloaing()
    return True
wget_download()

def input_check():
    select_translate_math = input("Please input The arctive You like: ")
    try:
        if re.findall(r'^[0-9]{1,3}?$',select_translate_math)[0]:
            print(select_translate_math)
    except:
        print('Input Error.Retry')



###########################################################################

# 不使用该方法，改为 Download ZIP 然后解压。
def git_github_clone():
    import git,os
    if not os.path.isdir("TranslateProject"):
        os.makedirs("TranslateProject")
        git.Repo.clone_from(url="https://github.com/lctt/TranslateProject", to_path="TranslateProject")

