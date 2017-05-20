import os

with open('.\\rabbit','r+',encoding='utf-8') as f:
    f.writelines('1\n')
    f.seek(0,0)
    f.writelines('4asfsaf\n')
    print(f.read())
