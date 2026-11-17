import glob, os

root = '/Users/kk/WorkBuddy/os翻译'
removed = 0
for d in ['book', 'book1', 'book3', 'book4', 'site', 'site/docs']:
    p = os.path.join(root, d)
    for f in glob.glob(os.path.join(p, '*.png')):
        try:
            os.remove(f)
            removed += 1
        except OSError as e:
            print('skip', f, e)
print('removed', removed)
