#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os,sys,re,glob
# sys.path.insert(0,os.path.realpath(os.path.dirname(__file__)+'/../test/tmp/'))
# import settings
# sys.path.insert(0,os.path.realpath(os.path.dirname(__file__)+'/../list/'))
# print(os.listdir(sys.path[0]))

def select_translated(translate_filename=None):
    file=os.path.dirname(__file__)+'/../test/tmp/translate_choose.txt'
    with open(file=file,mode='r',encoding='utf-8') as fds:
        try:
            tips=input("Make Your Choose: ")
            if re.findall(r'^%d$' % (int(tips)), tips):
                # 必须-1，文件最后一行有空行 或者 计算机由 0 开始。
                translate_filename=fds.readlines()[int(tips)-1].strip() # 列出用户选择
                location = os.path.realpath(os.path.dirname(__file__)+'/../list/TranslateProject/sources/')
                # 使用 glob 方法更好
                for translate_filenamepath in glob.glob(location+'/*/*.md'):
                    # 如果查询被找到
                    find_transalte_filename=(str(translate_filenamepath.split('\\')[-1]).find(str(translate_filename)))
                    if find_transalte_filename == int(0):
                        with open(str(translate_filenamepath),mode='r+',encoding='utf-8') as fd:
                            # 使用 .seek 进行定位，或使用'contect'+fd.read()
                            fd.seek(0,0)
                            fd.writelines('something'+'\n')
                            fd.close()
                        print(translate_filenamepath+'\n\n'+'Finished.')
        # 排除输入中文、超过边界
        except:
            print('Error INPUT:(')
            exit(1)
        # 最后一点清理工作
        finally:
            fds.close()
