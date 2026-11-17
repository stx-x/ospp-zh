import { defineConfig } from 'vitepress'

export default defineConfig({
  lang: 'zh-CN',
  title: '操作系统：原理与实践',
  description: '《Operating Systems: Principles and Practice》中文讲义 · 四卷本',
  base: '/ospp-zh/',
  cleanUrls: true,
  lastUpdated: false,
  head: [
    ['link', { rel: 'preconnect', href: 'https://fonts.googleapis.com' }],
    ['meta', { name: 'theme-color', content: '#2f5d8a' }],
  ],
  markdown: {
    math: true,
    lineNumbers: false,
  },
  themeConfig: {
    logo: false,
    outline: { level: [2, 3], label: '本页目录' },
    docFooter: { prev: '上一页', next: '下一页' },
    darkModeSwitchLabel: '外观',
    sidebarMenuLabel: '目录',
    returnToTopLabel: '回到顶部',
    lastUpdatedText: '最后更新',
    nav: [
      { text: '首页', link: '/' },
      { text: '第一卷 内核与进程', link: '/vol1/ch1' },
      { text: '第二卷 并发', link: '/vol2/ch4' },
      { text: '第三卷 内存管理', link: '/vol3/ch8' },
      { text: '第四卷 持久存储', link: '/vol4/ch11' },
      { text: '附录', link: '/appendix/glossary' },
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
          ],
        },
      ],
      '/vol2/': [
        {
          text: '第二卷　并发',
          items: [
            { text: '第 4 章　并发与线程', link: '/vol2/ch4' },
            { text: '第 5 章　共享对象的同步访问', link: '/vol2/ch5' },
            { text: '第 6 章　多对象同步', link: '/vol2/ch6' },
            { text: '第 7 章　调度', link: '/vol2/ch7' },
          ],
        },
      ],
      '/vol3/': [
        {
          text: '第三卷　内存管理',
          items: [
            { text: '第 8 章　地址转换', link: '/vol3/ch8' },
            { text: '第 9 章　缓存与虚拟内存', link: '/vol3/ch9' },
            { text: '第 10 章　高级内存管理', link: '/vol3/ch10' },
          ],
        },
      ],
      '/vol4/': [
        {
          text: '第四卷　持久存储',
          items: [
            { text: '第 11 章　文件系统：导论与概述', link: '/vol4/ch11' },
            { text: '第 12 章　存储设备', link: '/vol4/ch12' },
            { text: '第 13 章　文件与目录', link: '/vol4/ch13' },
            { text: '第 14 章　可靠存储', link: '/vol4/ch14' },
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
    },
  },
})
