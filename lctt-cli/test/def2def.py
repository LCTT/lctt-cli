# def aa(**kwargs):
#     print(locals())
# aa(aaa=123,bbb=456)

def aa():
    global a,c
    b='bbb'
    a='aaa'+b
    c='ccc'
    print(a)
aa()

def bb():
    print(a,c)
bb()