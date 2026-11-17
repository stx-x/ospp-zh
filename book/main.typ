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
  #text(font: hei, size: 22pt, weight: "bold", fill: accent)[第二卷　并发]
  #v(3mm)
  #text(font: song, size: 12pt, style: "italic", fill: faint)[Volume II: Concurrency]
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
#include "chapters/u01.typ"
#include "chapters/u03.typ"
#include "chapters/u04.typ"
#include "chapters/u05.typ"
#include "chapters/u06.typ"
#include "chapters/u07.typ"
#include "chapters/u08.typ"
#include "chapters/u09.typ"
#include "chapters/u10.typ"
#include "chapters/u11.typ"
#include "chapters/u12.typ"
#include "chapters/u13a.typ"
#include "chapters/u14.typ"
#include "chapters/u15.typ"
#include "chapters/u16.typ"
#include "chapters/u17.typ"
#include "chapters/u18a.typ"
#include "chapters/u18b.typ"
#include "chapters/u19a.typ"
#include "chapters/u19b.typ"
#include "chapters/u20.typ"
#include "chapters/u21a.typ"
#include "chapters/u21b.typ"
#include "chapters/u22.typ"
#include "chapters/u23a.typ"
#include "chapters/u23b.typ"
#include "chapters/u24.typ"
#include "chapters/u25.typ"
#include "chapters/u26.typ"
#include "chapters/u27.typ"
