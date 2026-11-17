import re

files = [
    '/Users/kk/WorkBuddy/os翻译/book1/chapters/u115.typ',
    '/Users/kk/WorkBuddy/os翻译/book/chapters/u26.typ',
]
pairs = [
    ('内核态运行', '内核模式运行'),
    ('用户态运行', '用户模式运行'),
    ('内核态', '内核模式'),
    ('用户态', '用户模式'),
]
for f in files:
    s = open(f).read()
    n = 0
    for a, b in pairs:
        c = s.count(a)
        s = s.replace(a, b)
        n += c
    open(f, 'w').write(s)
    print(f.split('/')[-1], 'replaced', n)
