import { defineConfig } from 'vitepress'

export default defineConfig({
  lang: 'zh-CN',
  title: '操作系统：原理与实践',
  description: '《Operating Systems: Principles and Practice》中文全译 · 四卷本 · 内核与进程 / 并发 / 内存管理 / 持久存储',
  base: '/ospp-zh/',
  cleanUrls: true,
  lastUpdated: false,

  head: [
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/ospp-zh/favicon.svg' }],
    ['meta', { name: 'theme-color', content: '#2f5d8a' }],
    ['meta', { name: 'author', content: 'Thomas Anderson, Michael Dahlin（中译）' }],
    ['meta', { property: 'og:type', content: 'book' }],
    ['meta', { property: 'og:title', content: '操作系统：原理与实践（中文全译）' }],
    ['meta', { property: 'og:description', content: '四卷本中文讲义：内核与进程、并发、内存管理、持久存储' }],
    ['meta', { property: 'og:site_name', content: 'OSPP 中文讲义' }],
    ['meta', { name: 'twitter:card', content: 'summary' }],
  ],

  sitemap: {
    hostname: 'https://stx-x.github.io/ospp-zh/',
  },

  markdown: {
    math: true,
    lineNumbers: false,
    image: { lazyLoading: true },
  },

  themeConfig: {
    logo: false,
    outline: { level: [2, 3], label: '本页目录' },
    docFooter: { prev: '上一页', next: '下一页' },
    darkModeSwitchLabel: '外观',
    sidebarMenuLabel: '目录',
    returnToTopLabel: '回到顶部',
    lastUpdatedText: '最后更新',
    langMenuLabel: '语言',

    search: {
      provider: 'local',
      options: {
        miniSearch: {
          options: {
            // 中文按二元组切分（bigram），否则整句会成为一个 token，搜索命中率极低
            tokenize: (text: string) => {
              const out: string[] = []
              const parts = text.split(/[\s\-_/.,;:!?()[\]{}"'“”‘’、，。；：！？（）《》]+/)
              for (const p of parts) {
                if (!p) continue
                if (/[\u4e00-\u9fa5]/.test(p)) {
                  for (let i = 0; i < p.length - 1; i++) out.push(p.slice(i, i + 2))
                  if (p.length === 1) out.push(p)
                } else {
                  out.push(p.toLowerCase())
                }
              }
              return out
            },
          },
          searchOptions: {
            prefix: true,
            fuzzy: 0.15,
            boost: { title: 4, text: 2, titles: 2 },
          },
        },
        translations: {
          button: {
            buttonText: '搜索',
            buttonAriaLabel: '搜索全书',
          },
          modal: {
            displayDetails: '展开详情',
            resetButtonTitle: '清除条件',
            backButtonTitle: '返回',
            noResultsText: '没有找到结果',
            footer: {
              selectText: '选择',
              selectKeyAriaLabel: '回车',
              navigateText: '切换',
              navigateUpKeyAriaLabel: '上箭头',
              navigateDownKeyAriaLabel: '下箭头',
              closeText: '关闭',
              closeKeyAriaLabel: 'Esc',
            },
          },
        },
      },
    },

    nav: [
      { text: '首页', link: '/' },
      { text: '目录', link: '/contents' },
      {
        text: '四卷',
        items: [
          { text: '第一卷　内核与进程', link: '/vol1/ch1' },
          { text: '第二卷　并发', link: '/vol2/ch4' },
          { text: '第三卷　内存管理', link: '/vol3/ch8' },
          { text: '第四卷　持久存储', link: '/vol4/ch11' },
        ],
      },
      {
        text: '附录',
        items: [
          { text: '术语表', link: '/appendix/glossary' },
          { text: '参考文献', link: '/appendix/references' },
          { text: '关于作者', link: '/appendix/authors' },
        ],
      },
      { text: 'PDF', link: 'https://github.com/stx-x/ospp-zh/releases/latest' },
    ],

    sidebar: {
      '/vol1/': [
        {
          text: '第一卷　内核与进程',
          items: [
            { text: '前言', link: '/preface' },
            { text: '第 1 章　引论', link: '/vol1/ch1' },
            { text: '第 2 章　内核抽象', link: '/vol1/ch2' },
            { text: '第 3 章　编程接口', link: '/vol1/ch3' },
            { text: '第二卷　并发 →', link: '/vol2/ch4' },
          ],
        },
      ],
      '/vol2/': [
        {
          text: '第二卷　并发',
          items: [
            { text: '← 第一卷　内核与进程', link: '/vol1/ch3' },
            { text: '第 4 章　并发与线程', link: '/vol2/ch4' },
            { text: '第 5 章　共享对象的同步访问', link: '/vol2/ch5' },
            { text: '第 6 章　多对象同步', link: '/vol2/ch6' },
            { text: '第 7 章　调度', link: '/vol2/ch7' },
            { text: '第三卷　内存管理 →', link: '/vol3/ch8' },
          ],
        },
      ],
      '/vol3/': [
        {
          text: '第三卷　内存管理',
          items: [
            { text: '← 第二卷　并发', link: '/vol2/ch7' },
            { text: '第 8 章　地址转换', link: '/vol3/ch8' },
            { text: '第 9 章　缓存与虚拟内存', link: '/vol3/ch9' },
            { text: '第 10 章　高级内存管理', link: '/vol3/ch10' },
            { text: '第四卷　持久存储 →', link: '/vol4/ch11' },
          ],
        },
      ],
      '/vol4/': [
        {
          text: '第四卷　持久存储',
          items: [
            { text: '← 第三卷　内存管理', link: '/vol3/ch10' },
            { text: '第 11 章　文件系统：导论与概述', link: '/vol4/ch11' },
            { text: '第 12 章　存储设备', link: '/vol4/ch12' },
            { text: '第 13 章　文件与目录', link: '/vol4/ch13' },
            { text: '第 14 章　可靠存储', link: '/vol4/ch14' },
            { text: '附录　术语表', link: '/appendix/glossary' },
          ],
        },
      ],
      '/appendix/': [
        {
          text: '附录',
          items: [
            { text: '术语表', link: '/appendix/glossary' },
            { text: '参考文献', link: '/appendix/references' },
            { text: '关于作者', link: '/appendix/authors' },
          ],
        },
      ],
      '/preface': [
        {
          text: '第一卷　内核与进程',
          items: [
            { text: '前言', link: '/preface' },
            { text: '第 1 章　引论', link: '/vol1/ch1' },
            { text: '第 2 章　内核抽象', link: '/vol1/ch2' },
            { text: '第 3 章　编程接口', link: '/vol1/ch3' },
          ],
        },
      ],
      '/contents': [
        {
          text: '全书',
          items: [
            { text: '完整目录', link: '/contents' },
            { text: '前言', link: '/preface' },
            { text: '术语表', link: '/appendix/glossary' },
          ],
        },
      ],
    },
  },
})
