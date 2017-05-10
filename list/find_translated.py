#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os,re

# def __init__(self,list_num):
#     list_num=self.list_num=0

def create_and_putfiles(write1=None,write2=None):
    if not os.path.isdir("tmp"):
        os.makedirs("tmp")
    with open('tmp/translate_choose.txt','wb') as fd1:
        fd1.write(write1.encode('utf-8'))
        fd1.close()
    with open('tmp/translate_choose.txt','ab') as fd2:
        fd2.write(write2.encode('utf-8'))
        fd1.close()

def list_and_find():
    list_num=0
    rootdir=os.path.dirname(__file__)+'/../TranslateProject/sources/'
    # 三个参数：分别返回1.父目录 2.所有文件夹名字（不含路径） 3.所有文件名字
    for parent,dirnames,filenames in os.walk(rootdir):
        for filename in filenames:
            # 排除 "README.md" 后输出
            if 'README.md' not in filename:
                # 将文件位置进行列出
                source_strings=os.path.join(parent,filename).replace('\\','/')   # 完整路径
                source_string=filename                                           # 仅文件名
                # 将完整路径进行读取
                with open(source_strings,'r',encoding='utf-8') as files:
                    # 仅仅读取首行
                    read_of_translating=files.readlines()[0]
                    list_num+=1
                    translated=re.findall(r'(?i)(translated|translating|fanyi|翻译中|申请翻译|github.com)',read_of_translating)
                    if translated == []:
                        if list_num <=9:
                            write1='0'+str(list_num)+' '+filename
                            for write1 in list(write1.split(',')):
                                create_and_putfiles(write1=write1+'\n')
                        if list_num  >9:
                            write2=str(list_num)+' '+filename
                            for write2 in list(write2.split(',')):
                                create_and_putfiles(write2=write2+'\n')
                    files.close()

# list_and_find()
# AttributeError: 'NoneType' object has no attribute 'encode'

# def save_and_rewrite():