import re, glob, os, unicodedata, html

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs/.vitepress/dist')

R_SPECIAL = r'[\s~`!@#$%^&*()\-_+=\[\]{}|\\;:"\'“”‘’<>,.?/]+'

def slugify(s):
    s = unicodedata.normalize('NFKD', s)
    s = re.sub(r'[\u0300-\u036F]', '', s)
    s = re.sub(r'[\u0000-\u001f]', '', s)
    s = re.sub(R_SPECIAL, '-', s)
    s = re.sub(r'-{2,}', '-', s)
    s = re.sub(r'^-+|-+$', '', s)
    s = re.sub(r'^(\d)', r'_\1', s)
    return s.lower()

ok = bad = 0
samples = []
for f in sorted(glob.glob('vol*/ch*.html')):
    s = open(f).read()
    for m in re.finditer(r'<h[23] id="([^"]*)"[^>]*>(.*?)</h[23]>', s):
        real_id, inner = m.group(1), m.group(2)
        text = re.sub(r'<[^>]+>', '', inner)
        text = html.unescape(text).replace('\u200b', '').strip()
        mine = slugify(text)
        if mine == real_id:
            ok += 1
        else:
            bad += 1
            if len(samples) < 6:
                samples.append((text, real_id, mine))

print('匹配:', ok, ' 不匹配:', bad)
for t, r, m in samples:
    print('  标题:', t[:40])
    print('    实际:', r)
    print('    计算:', m)
