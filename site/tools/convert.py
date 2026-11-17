#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Typst (自定义讲义模板) -> VitePress Markdown 转换器
处理组件: chapter / sect / subsect / subsubsect / plainhead /
         fig / code / tbl / aside / example / answer / exercises /
         bib / gitem / align(center) / columns(2) / text / sub / super
"""
import os, re, sys, glob, json, shutil, unicodedata

BASE = "/"
LINKBASE = "/ospp-zh"

TOC_INDEX = []

VOLUMES = [
    dict(key="vol1", dir="book1", num="1", title="内核与进程",
         en="Kernels and Processes", chapters="1-3"),
    dict(key="vol2", dir="book", num="2", title="并发",
         en="Concurrency", chapters="4-7"),
    dict(key="vol3", dir="book3", num="3", title="内存管理",
         en="Memory Management", chapters="8-10"),
    dict(key="vol4", dir="book4", num="4", title="持久存储",
         en="Persistent Storage", chapters="11-14"),
]

# ---------------------------------------------------------------- 基础扫描

def skip_fence(s, i):
    """s[i:] 以 ``` 开头时返回该围栏结束后的位置"""
    m = re.match(r"```[^\n]*\n", s[i:])
    if not m:
        return None
    fence = s[i:i + 3]
    j = i + m.end()
    while True:
        k = s.find(fence, j)
        if k < 0:
            return len(s)
        return k + 3

def match(s, i, op, cl):
    """s[i] == op，返回匹配的 cl 的下标；跳过字符串与代码围栏"""
    depth = 0
    j = i
    n = len(s)
    while j < n:
        if s.startswith("```", j):
            j = skip_fence(s, j) or n
            continue
        c = s[j]
        if c == '"':
            j += 1
            while j < n:
                if s[j] == "\\":
                    j += 2
                    continue
                if s[j] == '"':
                    j += 1
                    break
                j += 1
            continue
        if c == "\\" and j + 1 < n:
            j += 2
            continue
        if c == op:
            depth += 1
        elif c == cl:
            depth -= 1
            if depth == 0:
                return j
        j += 1
    return -1

def split_top(s, sep=","):
    """按顶层分隔符切分（忽略 () [] {} "" 与代码围栏内部）"""
    parts, buf = [], []
    depth = 0
    i, n = 0, len(s)
    while i < n:
        if s.startswith("```", i):
            k = skip_fence(s, i) or n
            buf.append(s[i:k])
            i = k
            continue
        c = s[i]
        if c == '"':
            j = i + 1
            while j < n:
                if s[j] == "\\":
                    j += 2
                    continue
                if s[j] == '"':
                    j += 1
                    break
                j += 1
            buf.append(s[i:j])
            i = j
            continue
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
        elif c == sep and depth == 0:
            parts.append("".join(buf))
            buf = []
            i += 1
            continue
        buf.append(c)
        i += 1
    if buf:
        parts.append("".join(buf))
    return parts

def parse_args(argtext):
    """-> (positional list, kwargs dict)。文本型参数保留原始字符串（含引号或内容块）"""
    pos, kw = [], {}
    if not argtext.strip():
        return pos, kw
    for p in split_top(argtext):
        p = p.strip()
        if not p:
            continue
        m = re.match(r'^([A-Za-z_][A-Za-z0-9_-]*)\s*:\s*(.*)$', p, re.S)
        if m and not p.startswith("["):
            kw[m.group(1)] = m.group(2).strip()
        else:
            pos.append(p)
    return pos, kw

def unquote(x):
    if x is None:
        return None
    x = x.strip()
    if x == "none":
        return None
    if len(x) >= 2 and x[0] == '"' and x[-1] == '"':
        return x[1:-1]
    if x.startswith("[") and x.endswith("]"):
        return x[1:-1]
    return x

# ---------------------------------------------------------------- 行内转换

def protect(s):
    """把 `code` 与 $math$ 替换为占位符"""
    store = []
    def rep(m):
        store.append(m.group(0))
        return "\x00%d\x00" % (len(store) - 1)
    s = re.sub(r"`[^`\n]+`", rep, s)
    s = re.sub(r"\$[^$\n]+\$", rep, s)
    return s, store

def restore(s, store):
    def rep(m):
        return store[int(m.group(1))]
    return re.sub(r"\x00(\d+)\x00", rep, s)

MATH_SYMBOLS = [
    (r"\btimes\b", r"\times"), (r"\bprop\b", r"\propto"),
    (r"\bapprox\b", r"\approx"), (r"\balpha\b", r"\alpha"),
    (r"\bbeta\b", r"\beta"), (r"\bgamma\b", r"\gamma"),
    (r"\blambda\b", r"\lambda"), (r"\bmu\b", r"\mu"),
    (r"\bsigma\b", r"\sigma"), (r"\btau\b", r"\tau"),
    (r"\btheta\b", r"\theta"), (r"\bpi\b", r"\pi"),
    (r"\bDelta\b", r"\Delta"), (r"\bepsilon\b", r"\epsilon"),
    (r"\bdot\b", r"\cdot"), (r"\binfinity\b", r"\infty"),
    (r"\bsum\b", r"\sum"), (r"\bintegral\b", r"\int"),
    (r"\bproduct\b", r"\prod"), (r"\bsqrt\b", r"\sqrt"),
    (r"\bceil\b", r"\lceil"), (r"\bfloor\b", r"\lfloor"),
    (r"\bexists\b", r"\exists"), (r"\bforall\b", r"\forall"),
    (r"\bmod\b", r"\bmod"), (r"<=>", r"\Leftrightarrow"),
    (r"=>", r"\Rightarrow"), (r"->", r"\to"),
    (r"<=", r"\le"), (r">=", r"\ge"), (r"!=", r"\ne"),
    (r"\bquad\b", r"\quad"),
]

def typst_math(src):
    """Typst 数学 -> LaTeX（顺序敏感：先处理上下标，再处理字符串，最后符号）"""
    s = src

    # 1. 上下标：_"文" / _{..} / _x ，^"文" / ^{..} / ^x
    def _script(mark, arg):
        a = arg.strip()
        if len(a) >= 2 and a[0] == '"' and a[-1] == '"':
            return "%s{\\text{%s}}" % (mark, a[1:-1])
        if a.startswith("{") and a.endswith("}"):
            return "%s{%s}" % (mark, a[1:-1])
        return "%s{%s}" % (mark, a)

    def sub_repl(m):
        return _script("_", m.group(1))

    def sup_repl(m):
        return _script("^", m.group(1))

    s = re.sub(r'_("([^"]*)"|\{[^{}]*\}|[A-Za-z0-9]+)', sub_repl, s)
    s = re.sub(r'\^("([^"]*)"|\{[^{}]*\}|[A-Za-z0-9]+)', sup_repl, s)

    # 2. 剩余字符串 -> \text{...}
    s = re.sub(r'"([^"]*)"', lambda m: "\\text{%s}" % m.group(1), s)

    # 3. 符号名
    for a, b in MATH_SYMBOLS:
        s = re.sub(a, lambda m, _b=b: _b, s)

    # 4. 清理多余空格
    s = re.sub(r"\s{2,}", " ", s).strip()
    return s

CN = r"\u4e00-\u9fff"

def normalize_cn(s):
    """中文排版规范化：全角引号、中英间距。仅在中文占主导时执行。"""
    if len(re.findall(r"[" + CN + "]", s)) < 3:
        return s
    # 成对 ASCII 双引号 -> 中文引号
    s = re.sub(r'"([^"\n]{1,120})"', lambda m: "\u201c" + m.group(1) + "\u201d", s)
    # 中英（含数字）之间补空格
    s = re.sub(r"([" + CN + r"])([A-Za-z0-9])", r"\1 \2", s)
    s = re.sub(r"([A-Za-z0-9])([" + CN + r"])", r"\1 \2", s)
    # 收拢多余空格
    s = re.sub(r" {2,}", " ", s)
    return s

def inline_html(s):
    """Typst 行内 -> HTML 片段（用于 HTML 块内部：题注、表格单元格）"""
    s, store = protect(s)
    # #sub[x] / #super[x]
    s = re.sub(r"#sub\[([^\]]*)\]", lambda m: "<sub>" + m.group(1) + "</sub>", s)
    s = re.sub(r"#super\[([^\]]*)\]", lambda m: "<sup>" + m.group(1) + "</sup>", s)
    # #text(...)[x] -> 按 weight 决定是否加粗
    def _text(m):
        args, body = m.group(1), m.group(2)
        if 'weight: "bold"' in args:
            return "<strong>" + body + "</strong>"
        return body
    s = re.sub(r"#text\(([^()]*)\)\[([^\]]*)\]", _text, s)
    # 转义还原
    for a, b in [(r"\#", "#"), (r"\$", "$"), (r"\_", "_"), (r"\@", "@"),
                 (r"\~", "~"), (r"\*", "*"), (r"\%", "%"), (r"\&", "&")]:
        s = s.replace(a, b)
    # 强调：Typst *粗* / _斜_
    s = re.sub(r"\*([^*\n]+)\*", r"<strong>\1</strong>", s)
    s = re.sub(r"_([^_\n]+)_", r"<em>\1</em>", s)
    # 占位符还原（code / math）
    def rep(m):
        t = store[int(m.group(1))]
        if t.startswith("`"):
            return "<code>" + t[1:-1].replace("<", "&lt;") + "</code>"
        inner = typst_math(t[1:-1])
        return r"\(" + inner + r"\)"
    s = normalize_cn(s)
    s = re.sub(r"\x00(\d+)\x00", rep, s)
    return s

def inline_md(s):
    """Typst 行内 -> Markdown"""
    s, store = protect(s)
    s = re.sub(r"#sub\[([^\]]*)\]", lambda m: "<sub>" + m.group(1) + "</sub>", s)
    s = re.sub(r"#super\[([^\]]*)\]", lambda m: "<sup>" + m.group(1) + "</sup>", s)
    def _text(m):
        args, body = m.group(1), m.group(2)
        if 'weight: "bold"' in args:
            return "**" + body + "**"
        return body
    s = re.sub(r"#text\(([^()]*)\)\[([^\]]*)\]", _text, s)
    for a, b in [(r"\#", "#"), (r"\$", "$"), (r"\_", "_"), (r"\@", "@"),
                 (r"\~", "~"), (r"\*", "*"), (r"\%", "%"), (r"\&", "&")]:
        s = s.replace(a, b)
    # 先斜体 _x_ -> 占位，再粗体，避免冲突
    ital = []
    def _it(m):
        ital.append(m.group(1))
        return "\x01%d\x01" % (len(ital) - 1)
    s = re.sub(r"(?<![A-Za-z0-9_])_([^_\n]{1,300}?)_(?![A-Za-z0-9_])", _it, s)
    s = re.sub(r"\*([^*\n]{1,300}?)\*", r"**\1**", s)
    s = re.sub(r"\x01(\d+)\x01", lambda m: "*" + ital[int(m.group(1))] + "*", s)
    def rep(m):
        t = store[int(m.group(1))]
        if t.startswith("`"):
            return t
        inner = typst_math(t[1:-1])
        return "$" + inner + "$"
    s = normalize_cn(s)
    s = re.sub(r"\x00(\d+)\x00", rep, s)
    return s

# ---------------------------------------------------------------- 块级渲染

def render_fig(num, path, cap, volkey):
    ext = os.path.splitext(path)[1].lower()
    img = BASE + "figures/%s/%s" % (volkey, path)
    caph = inline_html(cap)
    return (
        '<figure class="book-figure">\n'
        '<img src="%s" alt="图 %s" loading="lazy" decoding="async">\n'
        '<figcaption><span class="fig-label">图 %s</span>%s</figcaption>\n'
        "</figure>\n" % (img, num, num, caph)
    )

def render_code(num, cap, lang, body):
    body = body.strip()
    body = re.sub(r"^\s*```[a-zA-Z0-9]*[ \t]*\n", "", body)
    body = re.sub(r"\n[ \t]*```[ \t]*$", "", body)
    body = body.replace("\x00", "")
    # 防止正文里残留未闭合围栏
    body = body.replace("```", "'''") if body.count("```") % 2 else body
    langmap = {"c": "c", "asm": "asm", "none": "text", "": "text"}
    lang = langmap.get(lang or "", lang or "text")
    out = []
    if num or cap:
        label = ('<span class="code-label">图 %s</span>' % num) if num else ""
        out.append('<div class="code-cap">%s%s</div>\n' % (label, inline_html(cap) if cap else ""))
    out.append("```%s\n%s\n```\n" % (lang, body))
    return "\n".join(out)

def parse_rows(text):
    """解析 ((...),(...)) 结构 -> [ [cell, ...], ... ]，cell = (html, colspan)"""
    text = text.strip()
    if text.startswith("(") and text.endswith(")"):
        text = text[1:-1]
    rows = []
    for rowtxt in split_top(text):
        rowtxt = rowtxt.strip()
        if not rowtxt:
            continue
        if not rowtxt.startswith("("):
            continue
        inner = rowtxt[1:-1]
        cells = []
        for c in split_top(inner):
            c = c.strip()
            cs = 1
            m = re.match(r"table\.cell\(([^)]*)\)\[(.*)\]$", c, re.S)
            if m:
                cm = re.search(r"colspan:\s*(\d+)", m.group(1))
                if cm:
                    cs = int(cm.group(1))
                content = m.group(2)
            elif c.startswith("[") and c.endswith("]"):
                content = c[1:-1]
            elif len(c) >= 2 and c[0] == '"' and c[-1] == '"':
                content = c[1:-1]
            else:
                content = c
            cells.append((inline_html(content), cs))
        rows.append(cells)
    return rows

def render_tbl(num, caption, rowstext, headertext, volkey):
    rows = parse_rows(rowstext)
    header = parse_rows(headertext) if headertext else None
    out = ['<div class="table-wrap">']
    if num or caption:
        label = ('<span class="tbl-label">表 %s</span>' % num) if num else ""
        out.append('<div class="table-cap">%s%s</div>' % (label, inline_html(caption) if caption else ""))
    out.append('<table class="book-table">')
    if header:
        out.append("<thead>")
        for r in header:
            out.append("<tr>" + "".join(
                '<th%s>%s</th>' % ((' colspan="%d"' % cs) if cs > 1 else "", c) for c, cs in r) + "</tr>")
        out.append("</thead>")
    out.append("<tbody>")
    for r in rows:
        out.append("<tr>" + "".join(
            '<td%s>%s</td>' % ((' colspan="%d"' % cs) if cs > 1 else "", c) for c, cs in r) + "</tr>")
    out.append("</tbody>")
    out.append("</table>")
    out.append("</div>")
    return "\n".join(out) + "\n"

# ---------------------------------------------------------------- 主转换

KNOWN = ["chapter", "sect", "subsect", "subsubsect", "plainhead", "fig", "code",
         "tbl", "aside", "example", "answer", "exercises", "bib", "gitem",
         "align", "columns", "index", "outline"]

def convert(text, volkey, imgdir):
    parts = []          # (is_html, content)
    i, n = 0, len(text)
    buf = []

    def flush():
        if buf:
            parts.append((False, "".join(buf)))
            buf.clear()

    while i < n:
        if text.startswith("```", i):
            k = skip_fence(text, i) or n
            buf.append(text[i:k])
            i = k
            continue
        if text[i] == "#":
            m = re.match(r"#([A-Za-z][A-Za-z0-9_-]*)", text[i:])
            if m and m.group(1) in KNOWN:
                name = m.group(1)
                j = i + 1 + len(name)
                args = None
                body = None
                if j < n and text[j] == "(":
                    k = match(text, j, "(", ")")
                    if k > 0:
                        args = text[j + 1:k]
                        j = k + 1
                if j < n and text[j] == "[":
                    k = match(text, j, "[", "]")
                    if k > 0:
                        body = text[j + 1:k]
                        j = k + 1
                pos, kw = parse_args(args or "")
                html = render_block(name, pos, kw, body, volkey, imgdir)
                flush()
                parts.append((True, html))
                i = j
                continue
        buf.append(text[i])
        i += 1
    flush()

    out = []
    for is_html, c in parts:
        out.append(c if is_html else inline_md(c))
    return "".join(out)

def render_block(name, pos, kw, body, volkey, imgdir):
    if name == "sect":
        num = unquote(pos[0]) if pos else ""
        title = unquote(pos[1]) if len(pos) > 1 else ""
        return "\n\n## %s　%s\n\n" % (num, inline_md(title))
    if name == "subsect":
        num = unquote(pos[0]) if pos else ""
        title = unquote(pos[1]) if len(pos) > 1 else ""
        return "\n\n### %s　%s\n\n" % (num, inline_md(title))
    if name == "subsubsect":
        title = unquote(pos[0]) if pos else (unquote(kw.get("zh")) if kw.get("zh") else "")
        return "\n\n#### %s\n\n" % inline_md(title)
    if name == "plainhead":
        title = unquote(pos[0]) if pos else ""
        return "\n\n## %s\n\n" % inline_md(title)
    if name == "fig":
        num = unquote(pos[0]) if pos else ""
        path = unquote(pos[1]) if len(pos) > 1 else ""
        cap = unquote(pos[2]) if len(pos) > 2 else ""
        if path:
            src = os.path.join(imgdir, path)
            if not os.path.exists(src):
                alt = path.replace(".png", ".gif")
                if os.path.exists(os.path.join(imgdir, alt)):
                    path = alt.replace(".gif", ".png")
        return "\n" + render_fig(num, path, cap, volkey) + "\n"
    if name == "code":
        num = unquote(kw.get("num")) or (unquote(pos[0]) if pos else None)
        cap = unquote(kw.get("cap")) or (unquote(pos[1]) if len(pos) > 1 else None)
        lang = unquote(kw.get("lang")) or "c"
        return "\n" + render_code(num, cap, lang, body or "") + "\n"
    if name == "tbl":
        num = unquote(pos[0]) if pos else None
        cap = unquote(pos[1]) if len(pos) > 1 else None
        rows = pos[2] if len(pos) > 2 else ""
        header = kw.get("header")
        return "\n" + render_tbl(num, cap, rows, header, volkey) + "\n"
    if name == "aside":
        title = unquote(pos[0]) if pos else ""
        inner = convert(body or "", volkey, imgdir)
        return "\n\n::: tip %s\n%s\n:::\n\n" % (inline_md(title), inner.strip())
    if name == "example":
        inner = convert(body or "", volkey, imgdir)
        return "\n\n::: info 例\n%s\n:::\n\n" % inner.strip()
    if name == "answer":
        inner = convert(body or "", volkey, imgdir)
        return "\n\n::: warning 答\n%s\n:::\n\n" % inner.strip()
    if name == "exercises":
        inner = convert(body or "", volkey, imgdir)
        return "\n\n## 习题\n\n%s\n\n" % inner.strip()
    if name == "bib":
        num = pos[0] if pos else ""
        txt = unquote(pos[1]) if len(pos) > 1 else ""
        return '\n<div class="bib-item"><span class="bib-num">[%s]</span>%s</div>\n' % (num, inline_html(txt))
    if name == "gitem":
        zh = unquote(pos[0]) if pos else ""
        en = unquote(pos[1]) if len(pos) > 1 else ""
        body_ = unquote(pos[2]) if len(pos) > 2 else ""
        return ('\n<div class="gloss-item"><div class="g-head"><span class="g-zh">%s</span>'
                '<span class="g-en">%s</span></div><div class="g-body">%s</div></div>\n'
                % (inline_html(zh), inline_html(en), inline_html(body_)))
    if name == "align":
        inner = (body or "").strip()
        if inner.startswith("$") and inner.endswith("$"):
            return "\n\n$$\n%s\n$$\n\n" % typst_math(inner[1:-1])
        if "#image(" in inner:
            m = re.search(r'#image\("([^"]+)"', inner)
            if m:
                p = os.path.basename(m.group(1))
                return "\n" + render_fig("", p, "", volkey).replace("图 ", "").replace('alt="图 "', '') + "\n"
        return "\n\n%s\n\n" % convert(inner, volkey, imgdir)
    if name == "columns":
        inner = body or ""
        return "\n\n<div class=\"glossary-grid\">\n%s\n</div>\n\n" % convert(inner, volkey, imgdir)
    if name == "index":
        return "\n"
    if name == "outline":
        return "\n"
    return ""

# ---------------------------------------------------------------- 文档切分

def split_chapters(text):
    """返回 (前置部分, [(章号, 章标题, 英文, 题词, 正文)])"""
    marks = []
    for m in re.finditer(r"#chapter\(", text):
        k = match(text, m.end() - 1, "(", ")")
        if k < 0:
            continue
        pos, kw = parse_args(text[m.end():k])
        num = unquote(pos[0]) if pos else ""
        zh = unquote(pos[1]) if len(pos) > 1 else ""
        en = unquote(kw.get("en"))
        epi = unquote(kw.get("epi"))
        marks.append((m.start(), k + 1, num, zh, en, epi))
    if not marks:
        return text, []
    front = text[:marks[0][0]]
    chaps = []
    for idx, (start, body_start, num, zh, en, epi) in enumerate(marks):
        end = marks[idx + 1][0] if idx + 1 < len(marks) else len(text)
        chaps.append((num, zh, en, epi, text[body_start:end]))
    return front, chaps

def clean_md(s):
    s = re.sub(r"[ \t]+\n", "\n", s)
    s = re.sub(r"\n{3,}", "\n\n", s)
    return s.strip() + "\n"

def chapter_stats(md):
    """返回 (汉字数, 图数, 表数)"""
    body = re.sub(r"```[\s\S]*?```", "", md)
    body = re.sub(r"<[^>]+>", "", body)
    cn = len(re.findall(r"[\u4e00-\u9fff]", body))
    figs = len(re.findall(r"book-figure", md))
    tbls = len(re.findall(r"book-table", md))
    return cn, figs, tbls

def meta_line(md):
    cn, figs, tbls = chapter_stats(md)
    minutes = max(1, round(cn / 420))
    parts = ["约 %.1f 万字" % (cn / 10000), "阅读约 %d 分钟" % minutes]
    extra = []
    if figs:
        extra.append("图 %d" % figs)
    if tbls:
        extra.append("表 %d" % tbls)
    if extra:
        parts.append(" · ".join(extra))
    return '<div class="chap-meta">%s</div>\n' % "".join(
        "<span>%s</span>" % p for p in parts)

R_SPECIAL = r'[\s~`!@#$%^&*()\-_+=\[\]{}|\\;:"\'“”‘’<>,.?/]+'

def slugify(s):
    """复刻 VitePress 的锚点规则（已验证 253 个标题零误差）"""
    s = unicodedata.normalize("NFKD", s)
    s = re.sub(r"[\u0300-\u036F]", "", s)
    s = re.sub(r"[\u0000-\u001f]", "", s)
    s = re.sub(R_SPECIAL, "-", s)
    s = re.sub(r"-{2,}", "-", s)
    s = re.sub(r"^-+|-+$", "", s)
    s = re.sub(r"^(\d)", r"_\1", s)
    return s.lower()

def extract_sections(md):
    """提取 (编号, 标题, 锚点)：只取 ## 级、带数字编号的节"""
    out = []
    for m in re.finditer(r"^##\s+(\d+(?:\.\d+)+)[　\s]+(.+)$", md, re.M):
        num, title = m.group(1), m.group(2).strip()
        title = re.sub(r"\*\*|\*|`", "", title)
        out.append((num, title, slugify("%s　%s" % (num, title))))
    return out

def extract_appendix(body):
    """从末章正文里切出 参考文献 / 术语表 / 关于作者，返回 (正文, {kind: text})"""
    pats = [("references", '#plainhead("参考文献")'),
            ("glossary", '#plainhead("术语表")'),
            ("authors", '#plainhead("关于作者")')]
    found = []
    for kind, pat in pats:
        k = body.find(pat)
        if k >= 0:
            found.append((k, kind, len(pat)))
    if not found:
        return body, {}
    found.sort()
    main = body[:found[0][0]]
    apx = {}
    for idx, (k, kind, plen) in enumerate(found):
        end = found[idx + 1][0] if idx + 1 < len(found) else len(body)
        apx[kind] = body[k + plen:end]
    return main, apx

def main():
    root = "/Users/kk/WorkBuddy/os翻译"
    docs = os.path.join(root, "site/docs")
    appendix_seen = {}
    for v in VOLUMES:
        vdir = os.path.join(root, v["dir"], "chapters")
        files = sorted(glob.glob(os.path.join(vdir, "*.typ")))
        text = ""
        for f in files:
            t = open(f).read()
            t = re.sub(r'^#import[^\n]*\n', "", t, flags=re.M)
            text += "\n" + t
        front, chaps = split_chapters(text)
        # 图片
        src_img = os.path.join(root, v["dir"], "figures")
        dst_img = os.path.join(docs, "public/figures", v["key"])
        os.makedirs(dst_img, exist_ok=True)
        for p in glob.glob(os.path.join(src_img, "*.png")):
            shutil.copy2(p, dst_img)
        vd = os.path.join(docs, v["key"])
        os.makedirs(vd, exist_ok=True)
        stats = {"vol": v["key"], "chapters": [], "front": 0}

        # 前言：只取第一卷（四卷内容相同）
        if front.strip() and v["key"] == "vol1":
            body = clean_md(convert(front, v["key"], src_img))
            if len(body) > 60:
                open(os.path.join(docs, "preface.md"), "w").write(
                    "---\ntitle: 前言\n---\n\n# 前言\n\n" + body)
                stats["front"] = len(body)

        for ci, (num, zh, en, epi, body_raw) in enumerate(chaps):
            last = (ci == len(chaps) - 1)
            main_raw, apx = (extract_appendix(body_raw) if last else (body_raw, {}))
            for kind, t in apx.items():
                if kind not in appendix_seen:
                    appendix_seen[kind] = t
            body = clean_md(convert(main_raw, v["key"], src_img))
            head = ["# 第 %s 章　%s" % (num, zh)]
            if en:
                head.append('<div class="chap-en">%s</div>' % en)
            if epi:
                head.append('<blockquote class="epigraph">%s</blockquote>' % inline_html(epi))
            head.append(meta_line(body).strip())
            content = "\n\n".join(head) + "\n\n" + body
            fn = "ch%s.md" % num
            open(os.path.join(vd, fn), "w").write(
                '---\ntitle: "第 %s 章　%s"\n---\n\n%s' % (num, zh, content))
            stats["chapters"].append([num, zh, fn, len(content)])
            TOC_INDEX.append(dict(vol=v, num=num, zh=zh, en=en or "",
                                  sections=extract_sections(content)))
        print(json.dumps(stats, ensure_ascii=False))

    # 附录（全站一份）
    ad = os.path.join(docs, "appendix")
    os.makedirs(ad, exist_ok=True)
    titles = {"references": ("参考文献", "references.md"),
              "glossary": ("术语表", "glossary.md"),
              "authors": ("关于作者", "authors.md")}
    for kind, txt in appendix_seen.items():
        t, fn = titles[kind]
        body = clean_md(convert(txt, "vol1", os.path.join(root, "book1/figures")))
        open(os.path.join(ad, fn), "w").write(
            "---\ntitle: %s\n---\n\n# %s\n\n" % (t, t) + body)
        print("appendix", kind, len(body))

    write_contents(docs)


def write_contents(docs):
    """生成完整目录页 /contents"""
    out = [
        "---",
        "title: 完整目录",
        "---",
        "",
        "# 完整目录",
        "",
        '<div class="toc-vol">',
        "",
    ]
    cur_vol = None
    for item in TOC_INDEX:
        v = item["vol"]
        if v["key"] != cur_vol:
            if cur_vol is not None:
                out.append("</div>\n")
                out.append('<div class="toc-vol">')
            cur_vol = v["key"]
            out.append('<h2>第%s卷　%s</h2>' % ("一二三四"[int(v["num"]) - 1], v["title"]))
            out.append('<div class="toc-vol-en">Volume %s: %s</div>' % (v["num"], v["en"]))
        num, zh, en = item["num"], item["zh"], item["en"]
        out.append('<a class="toc-ch" href="%s/vol%s/ch%s">' % (LINKBASE, v["key"][-1], num))
        out.append('<span class="toc-ch-no">第 %s 章</span>' % num)
        out.append('<span class="toc-ch-title">%s</span>' % zh)
        if en:
            out.append('<span class="toc-ch-en">%s</span>' % en)
        out.append("</a>")
        secs = item["sections"]
        if secs:
            out.append('<div class="toc-secs">')
            for snum, stitle, slug in secs:
                out.append('<a href="%s/vol%s/ch%s#%s">%s　%s</a>'
                           % (LINKBASE, v["key"][-1], num, slug, snum, stitle))
            out.append("</div>")
    out.append("</div>")
    out.append("")
    out.append('<div class="toc-vol">')
    out.append("<h2>附录</h2>")
    for t, link in [("术语表", "/appendix/glossary"),
                    ("参考文献", "/appendix/references"),
                    ("关于作者", "/appendix/authors")]:
        out.append('<a class="toc-ch" href="%s%s"><span class="toc-ch-no">附录</span>'
                   '<span class="toc-ch-title">%s</span></a>' % (LINKBASE, link, t))
    out.append("</div>")
    open(os.path.join(docs, "contents.md"), "w").write("\n".join(out) + "\n")
    print("contents written, chapters:", len(TOC_INDEX))

if __name__ == "__main__":
    main()
