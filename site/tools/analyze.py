import re, glob, os

os.chdir('/Users/kk/WorkBuddy/os翻译/site/docs')

def analyze(files):
    dq = 0
    nospace = 0
    samples = []
    for f in files:
        s = open(f).read()
        # 去掉代码块
        s = re.sub(r'```[\s\S]*?```', '', s)
        s = re.sub(r'<[^>]+>', '', s)
        cn = len(re.findall(r'[\u4e00-\u9fff]', s))
        if cn < 50:
            continue
        # ASCII 双引号出现在中文语境
        for m in re.finditer(r'"[^"\n]{1,40}"', s):
            seg = m.group(0)
            if re.search(r'[\u4e00-\u9fff]', seg):
                dq += 1
                if len(samples) < 5:
                    samples.append(seg)
        # 中英紧邻无空格
        for m in re.finditer(r'[\u4e00-\u9fff][A-Za-z]{2,}|[A-Za-z]{2,}[\u4e00-\u9fff]', s):
            nospace += 1
            if len(samples) < 10:
                samples.append('NOSPACE: ' + m.group(0))
    return dq, nospace, samples

files = sorted(glob.glob('vol*/ch*.md'))
dq, ns, samples = analyze(files)
print('中文语境 ASCII 引号:', dq)
print('中英紧邻无空格:', ns)
for s in samples[:8]:
    print('  ', s)
