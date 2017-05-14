#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import wget,os,git

class download_translate_project():
    # 定义初始变量
    def __init__(self,url=None,filename=None):
        self.url='http://codeload.github.com/LCTT/TranslateProject/zip/master.zip'
        self.filename='TranslateProject.zip'
    # 定义下载模块
    def downloading_now(self,url=None,filename=None):
        # 使用wget进行下载
        def wget_zip_download():
            wget.download(self.url,self.filename)
        # 使用git进行克隆
        def git_github_clone():
            if not os.path.isdir("TranslateProject"):
                os.makedirs("TranslateProject")
                git.Repo.clone_from(url="https://github.com/lctt/TranslateProject", to_path="TranslateProject")
        # 解压wget下载的文件
        def unzip():
            os.system('python -m zipfile -e .\TranslateProject.zip .\list')
        # 删除解压文件并移动
        def del_and_remove_downloaing():
            # wget 操作
            if os.path.exists('.\TranslateProject.zip'): os.remove('.\TranslateProject.zip')
            if os.path.exists('.\list\TranslateProject-master'): os.rename('.\list\TranslateProject-master','.\list\TranslateProject')
            # git 操作
            if os.path.exists('.\TranslateProject'): os.rename('.\TranslateProject','.\list\TranslateProject')
        try:
            wget_zip_download()
            unzip()
            del_and_remove_downloaing()
        except:
            git_github_clone()
            del_and_remove_downloaing()
        finally:
            del_and_remove_downloaing()



##################################################

def input_check():
    import re
    select_translate_math = input("Please input The arctive You like: ")
    try:
        if re.findall(r'^[0-9]{1,3}?$',select_translate_math)[0]:
            print(select_translate_math)
    except:
        print('Input Error.Retry')

