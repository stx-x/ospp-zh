import os, shutil

root = '/Users/kk/WorkBuddy/os翻译'
tmp = os.path.join(root, 'dist-pdf')
os.makedirs(tmp, exist_ok=True)

MAP = [
    ('book1/OSPP-卷1-内核与进程-中文讲义.pdf', 'OSPP-Vol1-Kernels-and-Processes.pdf'),
    ('book1/OSPP-卷1-内核与进程-中文讲义-iPad版.pdf', 'OSPP-Vol1-Kernels-and-Processes-iPad.pdf'),
    ('book/OSPP-卷2-并发-中文讲义.pdf', 'OSPP-Vol2-Concurrency.pdf'),
    ('book/OSPP-卷2-并发-中文讲义-iPad版.pdf', 'OSPP-Vol2-Concurrency-iPad.pdf'),
    ('book3/OSPP-卷3-内存管理-中文讲义.pdf', 'OSPP-Vol3-Memory-Management.pdf'),
    ('book3/OSPP-卷3-内存管理-中文讲义-iPad版.pdf', 'OSPP-Vol3-Memory-Management-iPad.pdf'),
    ('book4/OSPP-卷4-持久存储-中文讲义.pdf', 'OSPP-Vol4-Persistent-Storage.pdf'),
    ('book4/OSPP-卷4-持久存储-中文讲义-iPad版.pdf', 'OSPP-Vol4-Persistent-Storage-iPad.pdf'),
]

for src, dst in MAP:
    s = os.path.join(root, src)
    d = os.path.join(tmp, dst)
    if not os.path.exists(s):
        print('MISSING', s)
        continue
    shutil.copy2(s, d)
    print('%-46s %.1f MB' % (dst, os.path.getsize(d) / 1048576))
