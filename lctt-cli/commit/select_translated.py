#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os,re

def select_translated():
    file=os.path.dirname(__file__)+'/../test/tmp/translate_choose.txt'
    with open(file=file,mode='r',encoding='utf-8') as fds:
        try:
            tips=input("Make Your Choose: ")
            if re.findall(r'^%d$' % (int(tips)), tips):
                # 必须-1，文件最后一行有空行 或者 计算机由 0 开始。
                print(fds.readlines()[int(tips)-1])
                exit(0)
        # 排除输入中文
        except ValueError:
            print('Error INPUT:(')
            exit(1)
        finally:
            fds.close()
