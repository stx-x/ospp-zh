# 操作系统：原理与实践（中文讲义）

《Operating Systems: Principles and Practice》(2nd ed., Anderson & Dahlin) 四卷本中文全译，含 Typst 排版源与在线站点。

## 目录结构

```
book1/          第一卷 内核与进程（第 1–3 章）
book/           第二卷 并发（第 4–7 章）
book3/          第三卷 内存管理（第 8–10 章）
book4/          第四卷 持久存储（第 11–14 章）

  每卷包含：
    main.typ              A4 版入口
    main-ipad.typ         iPad 大字版入口
    template.typ          排版模板
    template-ipad.typ     iPad 版模板
    chapters/uNNN.typ     译文（按节切分）
    figures/              原书插图
    glossary.md           术语对照
    AGENT_BRIEF.md        翻译规范

site/           在线站点（VitePress）
  docs/                 页面（由 tools/convert.py 从 typst 生成）
  tools/convert.py      Typst → Markdown 转换器
```

## 生成 PDF

```bash
cd book1
typst compile main.typ "第一卷.pdf"
typst compile main-ipad.typ "第一卷-iPad.pdf"
```

四卷同理（`book`、`book3`、`book4`）。需要 [Typst](https://typst.app)。

## 生成站点

```bash
cd site
npm install
# 从 typst 源重新生成 markdown 与图片
python3 tools/convert.py
npm run dev      # 本地预览
npm run build    # 产物在 docs/.vitepress/dist
```

站点推送到 `main` 分支后由 GitHub Actions 自动部署到 GitHub Pages。

## 说明

- 译自 Recursive Books 2015 年版，仅供学习使用。
- 图表编号、习题编号沿用原书；代码清单保留原文，题注译为中文。
- 术语以各卷 `glossary.md` 为准。
