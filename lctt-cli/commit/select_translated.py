#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import wget,os,git,re

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

def read_translate():
    file=os.path.dirname(__file__)+'/../test/tmp/translate_choose.txt'
    with open(file=file,mode='r',encoding='utf-8') as fd:
        for fds in fd.readlines():
            fileid=fds.split(' ')[0]                # ID
            filename=' '.join(fds.split(' ')[1:])   # NM
            print(filename)

        # 因为 for 的问题出现 bug...仅能查找到单个
        '''
        for fds in fd.readlines():
            print('Please Choose:')
            while True:
                try:
                    if re.findall(r'^%d$' % (int(input())) ,fds.split(' ')[0]):
                        print(' '.join(fds.split(' ')[1:]))
                except ValueError:
                    print('Input Error')
                    continue
        '''
read_translate()
