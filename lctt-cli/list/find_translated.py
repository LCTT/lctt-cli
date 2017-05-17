#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os,re

class create_and_del():
    # 定义初始变量
    def __init__(self,dir=None,file=None):
        self.dir=os.path.dirname(__file__)+'/../test/tmp'
        self.file=os.path.dirname(__file__)+'/../test/tmp/translate_choose.txt'

    def create_and_putfiles(self,write=None):
        with open(self.file,'ab') as fd:
            fd.write(str(write).encode('utf-8'))
            fd.close()

    def make_list_was_clean(self):
        if not os.path.isdir(self.dir):
            os.makedirs(self.dir)
        elif os.path.exists(self.file):
            os.remove(self.file)

def list_and_find():
    # initialize var
    num=0
    # 保证文件为空，无历史信息
    create_and_del().make_list_was_clean()
    # 如果用户直接解压进去list，保证程序找得到
    if os.path.exists('.\list\TranslateProject-master'): os.rename('.\list\TranslateProject-master','.\list\TranslateProject')
    rootdir=os.path.dirname(__file__)+'/TranslateProject/sources/'
    # 三个参数：分别返回1.父目录 2.所有文件夹名字（不含路径） 3.所有文件名字
    for parent,dirnames,filenames in os.walk(rootdir):
        # 单个进行处理
        for filename in filenames:
            # 排除 "README.md" 后输出
            if 'README.md' not in filename:
                # 将文件位置进行列出
                source_strings=os.path.join(parent,filename).replace('\\','/')   # 完整路径
                # 将完整路径进行读取
                with open(source_strings,'r',encoding='utf-8') as files:
                    # 仅仅读取首行
                    read_of_translating=files.readlines()[0]
                    translated=re.findall(r'(?i)(translated|translating|fanyi|翻译中|申请翻译|github.com)',read_of_translating)
                    if translated == []:
                        write=filename
                        for (write) in list(write.split(',')):
                            num+=1
                            create_and_del().create_and_putfiles(write+'\n')
                            print(num,write)
                    files.close()
