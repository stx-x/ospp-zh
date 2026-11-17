import re, glob, os, json

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs')
tot = {'cn': 0, 'fig': 0, 'tbl': 0, 'sec': 0, 'ch': 0}
per = []
for f in sorted(glob.glob('vol*/ch*.md')):
    s = open(f).read()
    body = re.sub(r'```[\s\S]*?```', '', s)
    body = re.sub(r'<[^>]+>', '', body)
    cn = len(re.findall(r'[\u4e00-\u9fff]', body))
    fig = len(re.findall(r'book-figure', s))
    tbl = len(re.findall(r'book-table', s))
    sec = len(re.findall(r'^##\s+\d+\.\d+', s, re.M))
    tot['cn'] += cn
    tot['fig'] += fig
    tot['tbl'] += tbl
    tot['sec'] += sec
    tot['ch'] += 1
    per.append((f, cn, fig, tbl, sec))

print(json.dumps(tot, ensure_ascii=False))
print('万字:', round(tot['cn']/10000, 1))
for p in per:
    print(p)
