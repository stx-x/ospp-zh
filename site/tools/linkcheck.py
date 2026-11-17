import re, glob, os, html

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs/.vitepress/dist')

pages = set()
for f in glob.glob('**/*.html', recursive=True):
    p = f[:-5]                       # 去掉 .html
    if p.endswith('index'):
        p = p[:-5]                   # vol1/index -> vol1/
        p = p.rstrip('/')
        pages.add('/' + p if p else '/')
    else:
        pages.add('/' + p)
pages.add('/')

bad = {}
for f in glob.glob('**/*.html', recursive=True):
    s = open(f).read()
    for m in re.finditer(r'href="(/ospp-zh[^"#]*)', s):
        url = m.group(1)
        path = url.replace('/ospp-zh', '', 1).rstrip('/') or '/'
        if path in ('/figures',):
            continue
        if path.startswith('/assets/'):
            continue
        if path not in pages and not os.path.exists('.' + path):
            bad.setdefault(url, 0)
            bad[url] += 1

print('内部链接目标缺失:', len(bad))
for u, c in sorted(bad.items(), key=lambda x: -x[1])[:15]:
    print('  %-60s %d' % (u, c))
