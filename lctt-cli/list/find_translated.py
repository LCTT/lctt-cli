#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os,re

def del_translated_file():
    if not os.path.isdir("./tmp"):
        os.makedirs("./tmp")
    elif os.path.exists('./tmp/translate_choose.txt'):
        os.remove('./tmp/translate_choose.txt')
del_translated_file()

def create_and_putfiles(write=None):
    with open('./tmp/translate_choose.txt','ab') as fd:
        fd.write(str(write).encode('utf-8'))
        fd.close()

def list_and_find():
    list_num=0
    rootdir=os.path.dirname(__file__)+'/TranslateProject/sources/'
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
                        write=str(list_num)+' '+filename
                        for write in list(write.split(',')):
                            create_and_putfiles(write+'\n')
                            print(write)
                        files.close()
list_and_find()