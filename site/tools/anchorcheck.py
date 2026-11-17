import re, glob, os

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs/.vitepress/dist')

# 收集每页的 id 集合
ids = {}
for f in glob.glob('**/*.html', recursive=True):
    s = open(f).read()
    page = f[:-5]
    if page.endswith('index'):
        page = os.path.dirname(page)
    ids['/' + page.rstrip('/')] = set(re.findall(r'id="([^"]+)"', s))

bad = []
total = 0
for f in glob.glob('**/*.html', recursive=True):
    s = open(f).read()
    for m in re.finditer(r'href="(/ospp-zh[^"#]*)#([^"]+)"', s):
        url, frag = m.group(1), m.group(2)
        path = url.replace('/ospp-zh', '', 1).rstrip('/') or '/'
        total += 1
        target_ids = ids.get(path)
        if target_ids is None:
            bad.append((f, url + '#' + frag, 'page missing'))
        elif frag not in target_ids:
            bad.append((f, url + '#' + frag, 'anchor missing'))

print('锚点链接总数:', total, ' 失效:', len(bad))
for b in bad[:10]:
    print('  ', b[0], '->', b[1], b[2])
