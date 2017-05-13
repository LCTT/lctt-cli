#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import re
from list.find_translated import *

select_translate_math = input("Please input The arctive You like: ")
try:
    if re.findall(r'^[0-9]{1,3}?$',select_translate_math)[0]:
        print(select_translate_math)
except:
    print('Input Error.Retry')
