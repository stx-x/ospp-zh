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
  #text(font: hei, size: 24pt, weight: "bold", fill: accent)[第四卷　持久存储]
  #v(3mm)
  #text(font: song, size: 13pt, style: "italic", fill: faint)[Volume IV: Persistent Storage]
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
#include "chapters/u201.typ"
#include "chapters/u202.typ"
#include "chapters/u203.typ"
#include "chapters/u204.typ"
#include "chapters/u205.typ"
#include "chapters/u206.typ"
#include "chapters/u207.typ"
#include "chapters/u208.typ"
#include "chapters/u209.typ"
#include "chapters/u210.typ"
#include "chapters/u211.typ"
#include "chapters/u212.typ"
#include "chapters/u213.typ"
#include "chapters/u214.typ"
#include "chapters/u215.typ"
#include "chapters/u216.typ"
#include "chapters/u217.typ"
#include "chapters/u218.typ"
#include "chapters/u219.typ"
#include "chapters/u220.typ"
