# 操作系统：原理与实践（中文讲义）

《Operating Systems: Principles and Practice》(2nd ed., Anderson & Dahlin) 四卷本中文全译。

**在线阅读：https://stx-x.github.io/ospp-zh/**\
**PDF 下载：[Releases](https://github.com/stx-x/ospp-zh/releases)**

## 网站功能

- 全文搜索（中文二元分词，可命中任意位置）
- 完整目录页，节标题可直达锚点
- 点击插图放大；代码块一键复制
- 右下角三档字号调节（记忆偏好）
- 深色模式、阅读进度条、跨卷翻页
- 每章标注字数、阅读时长、图表数

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

site/                     在线站点（VitePress）
  docs/                   页面（由 tools/convert.py 从 typst 生成）
  docs/.vitepress/        配置与主题
  tools/convert.py        Typst → Markdown 转换器
  tools/linkcheck.py      内部链接/锚点校验
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
python3 tools/convert.py      # 从 typst 源重新生成 markdown、目录页
npm run dev                   # 本地预览
npm run build                 # 产物在 docs/.vitepress/dist
```

`main` 分支推送后由 GitHub Actions 自动部署到 GitHub Pages。

> 注意：图片不纳入版本库（`site/docs/public/figures/` 被忽略），CI 构建时从 `book*/figures` 复制。
> 本地开发首次需手动执行同样的复制，或直接运行 `npm run dev` 前跑一次：
> `mkdir -p site/docs/public/figures && for v in 1 2 3 4; do :; done`（详见 workflows/deploy.yml 的 Assemble 步骤）。

## 说明

- 译自 Recursive Books 2015 年版，仅供学习使用。
- 图表编号、习题编号沿用原书；代码清单保留原文，题注译为中文。
- 术语以各卷 `glossary.md` 为准。
