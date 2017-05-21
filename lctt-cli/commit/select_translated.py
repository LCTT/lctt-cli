#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import os,sys,re,glob,webbrowser,time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
# sys.path.insert(0,os.path.realpath(os.path.dirname(__file__)+'/../test/tmp/'))
# import settings
# sys.path.insert(0,os.path.realpath(os.path.dirname(__file__)+'/../list/'))
# print(os.listdir(sys.path[0]))

def select_translated():
    global translate_filename
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
                    find_transaltefilename_sult=(str(translate_filenamepath.split('\\')[-1]).find(str(translate_filename)))
                    if find_transaltefilename_sult == int(0):
                        # with open(str(translate_filenamepath),mode='r+',encoding='utf-8') as fd:
                            # 使用 .seek 进行定位，或使用'contect'+fd.read()
                            # fd.seek(0,0)
                            # with open( os.path.realpath(os.path.dirname(__file__)+'\\..\\account.ini'),mode='r',encoding='utf-8') as information_fd:
                                # username=str(information_fd.read().split('\n')[0].split(':')[1])
                                # fd.writelines(username+'[https://github.com/'+username+'/] is translating'+'\n')
                                # information_fd.close()
                                # fd.writelines('%s'+'[https://github.com/%s/] is translating'+'\n') % (username,username)
                                # fd.writelines('{0}'+'[https://github.com/{1}/] is translating'+'\n'.format(str(username),str(username)))
                            # fd.close()
                        print('\n'+translate_filenamepath)
        # 排除输入中文、超过边界
        except ValueError:
            print('Error INPUT:( ')
            exit(1)
        # 最后一点清理工作
        finally:
            fds.close()

def send_to_github():
    with open( os.path.realpath(os.path.dirname(__file__)+'\\..\\account.ini'),mode='r',encoding='utf-8') as information_fd:
        username=str(information_fd.read().split('\n')[0].split(':')[1])
    with open( os.path.realpath(os.path.dirname(__file__)+'\\..\\account.ini'),mode='r',encoding='utf-8') as information_fd:
        password=str(information_fd.read().split('\n')[1].split(':')[1])
    def login_github(username=username,password=password):
        global driver
        driver = webdriver.Chrome()  # Optional argument, if not specified will search path.
        driver.get('https://github.com/lctt/translateproject')
        driver.find_element_by_xpath('/html/body/div[1]/header/div/div/div/a[1]').click()
        # Inu means InputUsername
        InU=driver.find_element_by_xpath('//*[@id="login_field"]')
        InU.send_keys(username)
        # Inp means InputPassword
        InP=driver.find_element_by_xpath('//*[@id="password"]')
        InP.send_keys(password)
        driver.find_element_by_xpath('//*[@id="login"]/form/div[4]/input[3]').send_keys(Keys.ENTER)
        driver.find_element_by_xpath('//*[@id="user-links"]/li[3]/a').click()
        global loginuser
        loginuser=driver.find_element_by_xpath('//*[@id="user-links"]/li[3]/div/div/div[1]/strong').text
    login_github()
    print('\n'+'Next Realy...')
    def find_file():
        try:
            driver.get('https://github.com/'+loginuser+'/translateproject/')
            driver.find_element_by_xpath('//*[@id="js-repo-pjax-container"]/div[2]/div[1]/div[4]/div[2]/a[2]').click()
            # Fn means Filename
            driver.find_element_by_xpath('//*[@id="tree-finder-field"]').send_keys(translate_filename)
            # https://www.cnblogs.com/itxdm/p/6883815.html
            time.sleep(0.7)
            driver.find_element_by_xpath('//*[@id="tree-finder-field"]').send_keys('\n\r','\r\n')
            time.sleep(1.7)
            # 进入编辑模式
            driver.find_element_by_xpath('//*[@id="js-repo-pjax-container"]/div[2]/div[1]/div[3]/div[1]/div[1]/form[1]').click()
            driver.find_element_by_xpath('//*[@id="new_blob"]/div[3]/div[1]/nav/button[2]').click()
            time.sleep(2)
            driver.find_element_by_xpath('//*[@id="new_blob"]/div[3]/div[1]/nav/button[1]').click()
            time.sleep(0.7)
            editFile=driver.find_element_by_xpath('//*[@id="new_blob"]/div[3]/div[2]/div/div[5]/div[1]/div/div/div/div[5]')
            editFile.send_keys(loginuser+'[https://github.com/'+loginuser+'/] is translating',Keys.ENTER)
        except:
            pass
        finally:
            time.sleep(5)
            driver.quit()
    find_file()
