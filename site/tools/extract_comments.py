import re, glob, os

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs')

lead, trail = {}, {}
for f in sorted(glob.glob('vol*/ch*.md')):
    s = open(f).read()
    for m in re.finditer(r'```(\w+)\n([\s\S]*?)\n```', s):
        lang, body = m.group(1), m.group(2)
        if lang == 'text':
            continue
        for line in body.split('\n'):
            st = re.match(r'^\s*//\s*([A-Za-z].*?)\s*$', line)
            if st:
                t = st.group(1)
                if len(t) > 3 and not t.startswith('http'):
                    lead[t] = lead.get(t, 0) + 1
                continue
            tr = re.search(r'\S\s+//\s*([A-Za-z].*?)\s*$', line)
            if tr:
                t = tr.group(1)
                if len(t) > 3 and not t.startswith('http'):
                    trail[t] = trail.get(t, 0) + 1

print('=== 行首注释 %d 条 / 不同 %d' % (sum(lead.values()), len(lead)))
print('=== 行尾注释 %d 条 / 不同 %d' % (sum(trail.values()), len(trail)))
print()
for t in sorted(trail):
    print('T| %s' % t)
