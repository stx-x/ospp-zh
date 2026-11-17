import re, glob, os

os.chdir('/Users/kk/WorkBuddy/os翻译')

src_code = 0
for f in glob.glob('book*/chapters/*.typ'):
    src_code += len(re.findall(r'#code\(', open(f).read()))

out_code = 0
for f in glob.glob('site/docs/vol*/ch*.md'):
    out_code += len(re.findall(r'^```[a-z]', open(f).read(), re.M))

src_fig = set()
for f in glob.glob('book*/chapters/*.typ'):
    for m in re.finditer(r'#fig\("([0-9.]+)"', open(f).read()):
        src_fig.add(m.group(1))

out_fig = set()
for f in glob.glob('site/docs/vol*/ch*.md'):
    for m in re.finditer(r'图 ([0-9.]+)</span>', open(f).read()):
        out_fig.add(m.group(1))

print('代码块: 源', src_code, '产物', out_code)
print('图: 源', len(src_fig), '产物', len(out_fig))
missing = sorted(src_fig - out_fig, key=lambda x: [int(p) for p in x.split('.')])
print('缺失图:', missing)
