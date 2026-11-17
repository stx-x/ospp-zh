// ============================================================
//  操作系统：原理与实践 · 第三卷 内存管理
//  内部讲义排版模板 —— iPad Air 4 专用版（大字版）
//  用法：main-ipad.typ 中 `#show: book`
//  与 template.typ 的区别：纸张更接近屏幕比例、字体整体放大
// ============================================================

#let ink     = rgb("#1b2430")   // 正文墨色
#let accent  = rgb("#2f5d8a")   // 主强调色（靛蓝）
#let accent2 = rgb("#8a5a2f")   // 次强调色（赭石）
#let muted   = rgb("#6b7280")
#let faint   = rgb("#98a1ad")
#let rule-c  = rgb("#c9d2dc")
#let bg-soft = rgb("#f6f6f3")

#let song = ("Songti SC", "New Computer Modern")
#let hei  = ("Heiti SC", "New Computer Modern")
#let kai  = ("Kaiti SC", "New Computer Modern")
#let mono = ("Menlo", "DejaVu Sans Mono")

#let body-size = 12.5pt
#let leading-v = 1.05em

#let curchap = state("curchap", "")
#let cursec  = state("cursec", "")

// ============================================================
//  版面
// ============================================================
#let book(body) = {
  set page(
    paper: "iso-b5",               // 176mm × 250mm，接近 iPad 竖屏比例
    margin: (x: 15mm, top: 22mm, bottom: 20mm),
    header: context {
      let ch = curchap.get()
      let se = cursec.get()
      if ch == "" { return }
      if counter(page).get().first() == 1 { return }
      set text(size: 8.4pt, fill: faint, font: hei)
      set par(justify: false)
      grid(
        columns: (1fr, auto),
        column-gutter: 10pt,
        align: (left + bottom, right + bottom),
        ch,
        se,
      )
      v(2mm)
      line(length: 100%, stroke: 0.4pt + rule-c)
    },
    footer: context {
      set text(size: 9pt, fill: muted, font: hei)
      if counter(page).get().first() == 1 { return }
      v(3mm)
      align(center)[
        #text(fill: faint, size: 7.4pt)[—] #counter(page).display("1") #text(fill: faint, size: 7.4pt)[—]
      ]
    },
  )

  set text(font: song, size: body-size, fill: ink, lang: "zh", region: "cn")
  set par(
    justify: true,
    leading: leading-v,
    spacing: 0.75em,
    first-line-indent: (amount: 2em, all: true),
  )

  // 强调：中文用楷体，西文斜体
  show emph: it => text(font: kai, style: "italic", fill: rgb("#243447"))[#it.body]
  show strong: it => text(weight: "bold", fill: ink)[#it.body]

  show quote.where(block: true): it => block(
    inset: (left: 14pt, right: 8pt, top: 2pt, bottom: 2pt),
    stroke: (left: 2pt + accent),
    text(fill: rgb("#3b4a5a"), size: 11.6pt, font: kai),
    it.body,
  )

  set list(indent: 1.3em, body-indent: 0.55em, spacing: 1.05em, tight: false, marker: text(fill: accent)[•])
  set enum(indent: 1.3em, body-indent: 0.55em, spacing: 1.05em, tight: false)

  body
}

// ============================================================
//  标题
// ============================================================
#let chapter(num, zh, en: none, epi: none) = {
  curchap.update([#num　#zh])
  cursec.update("")
  pagebreak(weak: true)
  v(6mm)
  block(above: 0pt, below: 0pt, width: 100%)[
    #grid(
      columns: (1fr, auto),
      column-gutter: 12pt,
      align: (left + bottom, right + bottom),
      [
        #text(font: hei, size: 9.4pt, fill: muted, tracking: 0.42em)[第 #num 章]
        #v(4pt)
        #text(font: hei, size: 25pt, weight: "bold", fill: ink)[#zh]
        #if en != none [
          #v(3pt)
          #text(font: song, size: 10.4pt, style: "italic", fill: faint)[#en]
        ]
      ],
      box(height: 1pt, align(bottom + right, pad(bottom: 9pt, text(font: hei, size: 50pt, weight: "bold", fill: accent.lighten(76%))[#num]))),
    )
    #v(6pt)
    #line(length: 100%, stroke: 1.1pt + ink)
    #v(1.6pt)
    #line(length: 100%, stroke: 0.4pt + ink)
  ]
  if epi != none {
    v(9pt)
    align(right)[
      #text(font: kai, size: 10.8pt, fill: rgb("#4a5568"))[#epi]
    ]
  }
  v(13pt)
  hide[#heading(level: 1, outlined: true, bookmarked: true, numbering: none)[第 #num 章　#zh]]
}

#let sect(num, zh) = {
  cursec.update([#num　#zh])
  block(above: 1.4em, below: 0.62em, width: 100%, breakable: false)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      align: (left + horizon, left + horizon),
      text(font: hei, size: 13.5pt, weight: "bold", fill: accent)[#num],
      text(font: hei, size: 14.5pt, weight: "bold", fill: ink)[#zh],
    )
    #v(3.5pt)
    #line(length: 100%, stroke: 0.5pt + rule-c)
  ]
  hide[#heading(level: 2, outlined: true, bookmarked: false, numbering: none)[#num　#zh]]
}

#let subsect(num, zh) = {
  block(above: 1.05em, below: 0.42em, width: 100%, breakable: false)[
    #text(font: hei, size: 12.2pt, weight: "bold", fill: rgb("#2b3a4a"))[#num　#zh]
  ]
  hide[#heading(level: 3, outlined: true, bookmarked: false, numbering: none)[#num　#zh]]
}

#let subsubsect(zh) = {
  block(above: 0.85em, below: 0.32em, width: 100%, breakable: false)[
    #text(font: hei, size: 11.4pt, weight: "bold", fill: rgb("#3b4a5a"))[#zh]
  ]
}

#let plainhead(zh) = block(above: 1.2em, below: 0.5em, width: 100%, breakable: false)[
  #text(font: hei, size: 13pt, weight: "bold", fill: ink)[#zh]
  #v(2.5pt)
  #line(length: 100%, stroke: 0.5pt + rule-c)
]

// ============================================================
//  图表
// ============================================================
#let cap-style(num, label, cap, size: 10.2pt) = block(width: 100%)[
  #set par(justify: false, first-line-indent: 0em, leading: 0.7em)
  #set align(left)
  #set text(size: size, fill: rgb("#3f4a57"))
  #text(font: hei, weight: "bold", fill: accent, size: size)[#label #num]
  #h(0.7em)
  #cap
]

#let fig(num, file, cap, width: 90%, label: "图") = {
  v(0.6em)
  block(width: 100%, breakable: false, above: 0em, below: 0em)[
    #align(center)[#image("figures/" + file, width: width)]
    #v(6pt)
    #align(center)[#block(width: 94%)[#cap-style(num, label, cap)]]
  ]
  v(0.8em)
}

#let figimg(file, width: 80%) = {
  v(0.6em)
  block(width: 100%, breakable: false, above: 0em, below: 0em)[
    #align(center)[#image("figures/" + file, width: width)]
  ]
  v(0.8em)
}

#let code(num: none, cap: none, lang: "c", body) = {
  v(0.45em)
  block(width: 100%, breakable: false, above: 0em, below: 0em)[
    #if cap != none [
      #block(width: 100%)[
        #set par(justify: false, first-line-indent: 0em, leading: 0.7em)
        #set text(size: 10.2pt)
        #if num != none [#text(font: hei, weight: "bold", fill: accent)[图 #num]#h(0.7em)]
        #text(fill: rgb("#3f4a57"))[#cap]
      ]
      #v(3.5pt)
    ]
    #block(
      width: 100%,
      fill: rgb("#f7f7f4"),
      stroke: (left: 2pt + rgb("#d9d3c5")),
      inset: (x: 10pt, y: 8pt),
    )[
      #set text(font: mono, size: 9.6pt, fill: rgb("#1f2933"))
      #set par(justify: false, leading: 0.62em, first-line-indent: 0em, spacing: 0em)
      #body
    ]
  ]
  v(0.75em)
}

#let tbl(num, caption, rows, header: none, columns: none, label: "表", size: 10.4pt, align-x: left, gutter: 8pt, repeat-header: true) = {
  let ncol = if header != none { header.len() } else if rows.len() > 0 { rows.at(0).len() } else { 1 }
  let cols = if columns != none { columns } else { (1fr,) * ncol }
  let hdr = if header != none {
    (
      table.header(
        repeat: repeat-header,
        ..header.map(c => text(font: hei, weight: "bold", size: size - 0.3pt, fill: ink)[#c]),
      ),
      table.hline(stroke: 0.55pt + ink),
    )
  } else { () }
  v(0.6em)
  block(width: 100%, breakable: false, above: 0em, below: 0em)[
    #if caption != none [
      #align(center)[#block(width: 94%)[#cap-style(num, label, caption)]]
      #v(5pt)
    ]
    #set text(size: size)
    #table(
      columns: cols,
      align: align-x,
      inset: (x: gutter, y: 5pt),
      stroke: none,
      table.hline(stroke: 0.9pt + ink),
      ..hdr,
      ..rows.flatten(),
      table.hline(stroke: 0.9pt + ink),
    )
  ]
  v(0.8em)
}

// ============================================================
//  边栏 / 例
// ============================================================
#let aside(title, body) = {
  v(0.55em)
  block(
    width: 100%,
    fill: bg-soft,
    stroke: (left: 2.2pt + rgb("#bcae94")),
    inset: (left: 11pt, right: 11pt, top: 8pt, bottom: 9pt),
    breakable: true,
  )[
    #block(above: 0em, below: 0.4em)[
      #text(font: hei, size: 9.8pt, weight: "bold", fill: rgb("#6b5b45"), tracking: 0.02em)[#title]
    ]
    #set text(size: 10.6pt, fill: rgb("#39434f"))
    #set par(leading: 0.86em, first-line-indent: (amount: 2em, all: true), spacing: 0.55em)
    #body
  ]
  v(0.65em)
}

#let example(body, tag: "例") = {
  v(0.4em)
  block(
    width: 100%,
    stroke: (left: 2.2pt + accent2.lighten(25%)),
    inset: (left: 10pt, right: 4pt, top: 4pt, bottom: 4pt),
  )[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      align: (left + top, left + top),
      text(font: hei, size: 9.4pt, weight: "bold", fill: accent2, tracking: 0.05em)[#tag],
      [
        #set text(size: 11.4pt, fill: rgb("#2f3a46"))
        #set par(leading: 0.9em, first-line-indent: 0em, spacing: 0.5em)
        #body
      ],
    )
  ]
  v(0.5em)
}

#let answer(body) = {
  v(0.15em)
  block(
    width: 100%,
    stroke: (left: 1.6pt + rgb("#c2cad4")),
    inset: (left: 10pt, right: 4pt, top: 3pt, bottom: 3pt),
  )[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      align: (left + top, left + top),
      text(font: hei, size: 9.4pt, weight: "bold", fill: muted, tracking: 0.05em)[答],
      [
        #set text(size: 11.1pt, fill: rgb("#46505c"))
        #set par(leading: 0.88em, first-line-indent: 0em, spacing: 0.45em)
        #body
      ],
    )
  ]
  v(0.35em)
}

// ============================================================
//  习题
// ============================================================
#let exercises(body) = {
  block(above: 1.5em, below: 0.6em, width: 100%, breakable: false)[
    #text(font: hei, size: 13pt, weight: "bold", fill: ink)[习题]
    #v(3pt)
    #line(length: 100%, stroke: 0.5pt + rule-c)
  ]
  set enum(
    numbering: n => text(font: hei, size: 10.4pt, fill: accent)[#n.],
    indent: 1.5em,
    body-indent: 0.6em,
    spacing: 0.7em,
  )
  body
}

// ============================================================
//  参考文献 / 术语表
// ============================================================
#let bib(n, body) = block(above: 0.3em, below: 0.3em, width: 100%)[
  #set par(justify: false, first-line-indent: 0em, leading: 0.68em)
  #grid(
    columns: (26pt, 1fr),
    column-gutter: 2pt,
    align: (right + top, left + top),
    text(font: hei, size: 9.4pt, fill: accent, weight: "bold")[#n],
    text(size: 10.2pt, fill: rgb("#2f3a46"))[#body],
  )
]

#let gitem(zh, en, body) = block(above: 0.45em, below: 0.1em, width: 100%)[
  #set par(justify: false, first-line-indent: 0em, leading: 0.7em)
  #text(font: hei, size: 10.8pt, weight: "bold", fill: ink)[#zh]
  #h(0.35em)
  #text(size: 9pt, fill: faint, style: "italic")[#en]
  #linebreak()
  #text(size: 10.2pt, fill: rgb("#3a4450"))[#body]
]
