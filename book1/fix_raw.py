import glob, re, os

os.chdir('/Users/kk/WorkBuddy/os翻译/book1/chapters')
targets = ['u108.typ', 'u109.typ', 'u112.typ']
pat = re.compile(r'^#show raw: set (text|par)\(.*\)\s*$')
total = 0
for f in targets:
    lines = open(f).read().split('\n')
    keep = [l for l in lines if not pat.match(l.strip())]
    removed = len(lines) - len(keep)
    open(f, 'w').write('\n'.join(keep))
    print(f, 'removed', removed)
    total += removed
print('total removed', total)
