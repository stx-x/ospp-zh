import re, glob, os

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs')

hits = {}
for f in sorted(glob.glob('vol*/ch*.md')):
    s = open(f).read()
    s = re.sub(r'```[\s\S]*?```', '', s)
    s = re.sub(r'<[^>]+>', '', s)
    for m in re.finditer(r'[\u4e00-\u9fff][A-Za-z]{2,}|[A-Za-z]{2,}[\u4e00-\u9fff]', s):
        hits.setdefault(m.group(0), 0)
        hits[m.group(0)] += 1

print('unique:', len(hits), 'total:', sum(hits.values()))
for k, v in sorted(hits.items(), key=lambda x: -x[1])[:20]:
    print(' ', repr(k), v)
