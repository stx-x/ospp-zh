#import "template-ipad.typ": *
#show: book

// ===== 封面 =====
#block(width: 100%, height: 100%)[
  #set align(center)
  #v(52mm)
  #text(font: hei, size: 14pt, fill: muted, tracking: 0.6em)[内 部 讲 义]
  #v(13mm)
  #text(font: hei, size: 29pt, weight: "bold", fill: ink)[操作系统：原理与实践]
  #v(5mm)
  #text(font: song, size: 15pt, style: "italic", fill: muted)[Operating Systems: Principles and Practice]
  #v(10mm)
  #text(font: hei, size: 24pt, weight: "bold", fill: accent)[第三卷　内存管理]
  #v(3mm)
  #text(font: song, size: 13pt, style: "italic", fill: faint)[Volume III: Memory Management]
  #v(24mm)
  #line(length: 44mm, stroke: 0.7pt + rule-c)
  #v(7mm)
  #text(font: song, size: 12pt, fill: ink)[托马斯·安德森（Thomas Anderson）　迈克·达林（Michael Dahlin）　著]
  #v(3mm)
  #text(font: song, size: 11pt, fill: faint)[第二版（Second Edition）　2015]
  #v(26mm)
  #text(font: song, size: 10pt, fill: faint)[根据 Recursive Books 2015 年版译出 · 仅供内部学习使用]
]

#pagebreak()

// ===== 目录 =====
#block(width: 100%)[
  #text(font: hei, size: 22pt, weight: "bold", fill: ink)[目录]
  #v(6mm)
  #outline(
    title: none,
    indent: 0.5em,
    depth: 2,
  )
]

#pagebreak()

// ===== 正文 =====
#include "chapters/u301.typ"
#include "chapters/u302.typ"
#include "chapters/u303.typ"
#include "chapters/u304.typ"
#include "chapters/u305.typ"
#include "chapters/u306.typ"
#include "chapters/u307.typ"
#include "chapters/u308.typ"
#include "chapters/u309.typ"
#include "chapters/u310.typ"
#include "chapters/u311.typ"
#include "chapters/u312.typ"
#include "chapters/u313.typ"
#include "chapters/u314.typ"
#include "chapters/u315.typ"
#include "chapters/u316.typ"
#include "chapters/u317.typ"
#include "chapters/u318.typ"
#include "chapters/u319.typ"
#include "chapters/u320.typ"
#include "chapters/u321.typ"
