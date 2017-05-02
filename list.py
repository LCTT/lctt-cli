#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# @function list_function of gn2.sh

import os,re

def list_all_file(rootdir):
    for parent,dirnames,filenames in os.walk(rootdir):    # 三个参数：分别返回1.父目录 2.所有文件夹名字（不含路径） 3.所有文件名字
        for filename in filenames:
            if 'README.md' not in filename:               # 排除 "README.md" 后输出
                open_file=os.path.join(parent,filename).replace('\\','/')
                src_files=list(str(open_file.split('/')[-1]).split(','))    # 将文件名作为变量保存下来
                with open(open_file,'r',encoding='utf-8') as files:
                    for translating in files.readlines():        # 读取文件行
                        # 结果过少，检查中...
                        try:
                            if re.match(r'(?i)(translated|translating|fanyi|翻译中|申请翻译)',translating):
                                src_files.remove(filename)
                                # 结果过少，检查中...
                                # print(filename,translating)     # 审查文件数与翻译是否对应
                        except ValueError:
                            pass

                    unique = []
                    [unique.append(item) for item in src_files if item not in unique]
                    print(unique)

list_all_file(rootdir=os.path.dirname(__file__)+'./TranslateProject/sources/')
