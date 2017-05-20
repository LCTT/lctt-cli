#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import wget,git,os

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
            # 删除解压文件并移动
            os.system('python -m zipfile -e .\TranslateProject.zip .\list')

        try:
            wget_zip_download()
            unzip()
        except:
            git_github_clone()
        # 删除重名操作 保证文件摆放位置正确
        finally:
            # wget 操作
            if os.path.exists('.\TranslateProject.zip'): os.remove('.\TranslateProject.zip')
            if os.path.exists('.\list\TranslateProject-master'): os.rename('.\list\TranslateProject-master','.\list\TranslateProject')
            # git 操作
            if os.path.exists('.\TranslateProject'): os.rename('.\TranslateProject','.\list\TranslateProject')
