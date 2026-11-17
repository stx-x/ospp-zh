#import "template.typ": *
#show: book

// ===== 封面 =====
#block(width: 100%, height: 100%)[
  #set align(center)
  #v(58mm)
  #text(font: hei, size: 13pt, fill: muted, tracking: 0.6em)[内 部 讲 义]
  #v(14mm)
  #text(font: hei, size: 27pt, weight: "bold", fill: ink)[操作系统：原理与实践]
  #v(5mm)
  #text(font: song, size: 14pt, style: "italic", fill: muted)[Operating Systems: Principles and Practice]
  #v(10mm)
  #text(font: hei, size: 22pt, weight: "bold", fill: accent)[第一卷　内核与进程]
  #v(3mm)
  #text(font: song, size: 12pt, style: "italic", fill: faint)[Volume I: Kernels and Processes]
  #v(26mm)
  #line(length: 42mm, stroke: 0.7pt + rule-c)
  #v(7mm)
  #text(font: song, size: 11pt, fill: ink)[托马斯·安德森（Thomas Anderson）　迈克·达林（Michael Dahlin）　著]
  #v(3mm)
  #text(font: song, size: 10pt, fill: faint)[第二版（Second Edition）　2015]
  #v(28mm)
  #text(font: song, size: 9pt, fill: faint)[根据 Recursive Books 2015 年版译出 · 仅供内部学习使用]
]

#pagebreak()

// ===== 目录 =====
#block(width: 100%)[
  #text(font: hei, size: 20pt, weight: "bold", fill: ink)[目录]
  #v(6mm)
  #outline(
    title: none,
    indent: 0.5em,
    depth: 2,
  )
]

#pagebreak()

// ===== 正文 =====
#include "chapters/u101.typ"
#include "chapters/u102.typ"
#include "chapters/u103.typ"
#include "chapters/u104.typ"
#include "chapters/u105.typ"
#include "chapters/u106.typ"
#include "chapters/u107.typ"
#include "chapters/u108.typ"
#include "chapters/u109.typ"
#include "chapters/u110.typ"
#include "chapters/u111.typ"
#include "chapters/u112.typ"
#include "chapters/u113.typ"
#include "chapters/u114.typ"
#include "chapters/u115.typ"
#include "chapters/u116.typ"
