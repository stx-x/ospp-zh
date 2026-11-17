# 翻译与排版规范（务必逐条遵守）· 第三卷 内存管理

## 0. 任务
把一份英文 Markdown 源（原书《Operating Systems: Principles and Practice》第三卷：Memory Management，第 8–10 章）
逐段翻译为中文，并按下面的规则写成 Typst 片段文件。这是**全文翻译**，不是摘要：
源文件里的每一段、每一条列表、每一个例子、每一条边栏、每一道习题、每一张图表的题注都要译出，不得删减、合并或另加内容。

## 1. 语言与文风
- 译文是**教材/讲义体中文**：准确、平实、术语统一，句子可读性优先，不要逐词硬译，也不要口语化。
- 长英文复句可拆成两三个中文短句；英文的 "we" 译作“我们”，泛指读者时可省略主语。
- 术语首次出现时用「中文（English）」形式，例如“转换后备缓冲区（TLB）”“页框（page frame）”；同一术语后文不再重复英文。
  术语译法**必须**与 `book3/glossary.md` 一致。
- 不译：代码、函数名、变量名、系统与产品名（UNIX、Linux、Windows、x86、MIPS、SPARC）、缩写（TLB、PTE、MMU、SFI、ASID、LRU、FIFO）。
- 书名、论文名保留英文原文，可加中文说明。
- 数字与单位：`10 毫秒`、`4 KB`、`99%`（数字用半角，数字与汉字之间不留空格）。
- 标点：中文全角（，。；：？！、）；破折号用 `——`，省略号用 `……`；
  引号用 “ ” 和 ‘ ’；括号用（）；英文缩写或代码紧邻时可用半角括号，但整段保持统一。
- 原文的举例、幽默、比喻保留语气，不要删。

## 2. Markdown → Typst 的固定映射

| 源（Markdown） | 目标（Typst） |
|---|---|
| `# *8. Address Translation*` | `#chapter(8, "地址转换", en: "Address Translation")`，紧随其后的一行斜体引语用 `epi: [...]` 传入 |
| `## 8.1 Address Translation Concept` | `#sect("8.1", "地址转换的概念")` |
| `### 8.2.1 Segmented Memory` | `#subsect("8.2.1", "分段内存")` |
| `#### Paged Segmentation`（无编号小标题） | `#subsubsect("分页分段")` |
| `## Exercises` | `#exercises[ + 第一题 + 第二题 ]`（题目用 `+ ` 编号） |
| `- 项目` | `- 项目`（保持不变） |
| `1. 项目` | `+ 项目` |
| `*斜体*` | `_斜体_`（Typst 的强调；模板会把中文强调渲染成楷体） |
| `**粗体**` | `*粗体*` |
| `` `code` `` | `` `code` ``（不变） |
| `[[FIG:8.6:image00288.png:caption]]` | `#fig("8.6", "image00288.png", [译文题注])` |
| `[[FIG::image00xxx.png:]]`（无编号插图） | `#figimg("image00xxx.png")` |
| `[[CODE:9.22:caption]]` + 代码围栏 | `#code(num: "9.22", cap: [译文题注], lang: "c")[ ```c … ``` ]` |
| `[[TAB:9.13:caption]]` + 竖线表 | `#tbl("9.13", [译文题注], ((…),(…)), header: ([…],[…]))` |
| `::: aside 标题` … `:::` | `#aside("译文标题")[ … ]` |

要点：
- `#chapter` 只在**每个源文件出现 `# *N. 章名*` 时**使用；其余文件从 `#sect` 开始。
- 图号、表号、代码图号**沿用原书编号**，不要重排。
- `#tbl` 的第三个参数是“行数组”，每个单元格是 `[…]` 内容块：
  ```typst
  #tbl("9.3", [从片上处理器缓存到远端数据中心的磁盘，存储层次逐级降低], (
    ([寄存器], [1 个周期], [500 B]),
  ), header: ([层次], [延迟], [容量]))
  ```
  若原表首行只是跨栏的粗体表名（与题注重复），删去该行。若原表没有表头，省略 `header:`。
  列数多时可用 `columns: (auto,) * N`，单元格内容短时也可加 `columns: (auto, 1fr, 1fr)`。
- **无编号的 `[[TAB::]]`** 有三类，按内容分别处理：
  1. **公式表**（如 `延迟 = 命中概率 × 命中延迟 + 未命中概率 × 未命中延迟`）→ 写成居中数学：
     ```typst
     #align(center)[$"延迟"(「读请求」) = P_"命中" times "命中延迟" + P_"未命中" times "未命中延迟"$]
     ```
     多行算式用 `$ … \ … $`，等号会自动对齐。
  2. **位域示意表**（如 `| 4 bit segment number | 12 bit page number | 16 bit offset |`）→ 写成单行表：
     ```typst
     #align(center)[$underbrace("段号 4 位", bracket.l) underbrace("页号 12 位", bracket.c) underbrace("偏移 16 位", bracket.r)$]
     ```
     或直接用 `#tbl(none, none, ((…),(…)))` 排成一行三格的表，两者皆可，取更清楚的一种。
  3. **对照表 / 清单表**（如“项目—规格—价格”、寄存器组的并排子表）→ 照常写成 `#tbl(none, none, (...))`，
     并排的子表用多个空列隔开即可。
- 表格单元格里出现 `|` 时，源文件里写作 `\|`，译文里直接写 `|`。
- **列表项里夹图**：源中形如
  ```
  12. 题干……
     [[TAB::]]
     | … |
     后续正文……
  ```
  表示图表夹在该条目的两段文字之间。译文照此顺序写：条目正文、图表、后续正文，
  且图表与后续正文都要**相对条目正文缩进两个空格**（Typst 据此判定它们仍属于该条目；
  完全不缩进会让列表中断、后续条目重新从 1 编号）。块前后各留空行。
- **习题的子问题**：源中以 `- （a）…` 形式出现，译文写成缩进的 `- （a）…` 子列表，保留字母标记。
- 代码块**原样保留**（缩进、注释、字符串都不改）。**不译代码中的任何内容**。

## 3. Typst 书写注意
- 正文中若出现 `#`、`$`、`@`、`~`、`<`、`>`、`\`、`_`、`*` 等特殊字符，必须转义（前加 `\`）或放进反引号。
  中文里常见的是 `#`（如 “C#”）、`$`（如 “$5”），务必检查。
- 空行分段；一段一行写完即可（不必手动折行）。列表项之间不要空行。
- 数学：`$O(n^2)$`、`$2^32$`、`$"0x3F"$` 用 Typst 数学。源文件中的 `~{下标}` 与 `^{上标}` 是上下标标记：
  `T~{1}` → `$T_1$`；`2^{32}` → `$2^32$`。
- 十六进制、二进制常量写成 ` $"0x3F"$ ` 或反引号 `` `0x3F` ``，全文统一。
- 不要使用 `#import`（首行除外）、`#set`、`#show` 等全局设置；模板已提供样式。
- 不要写 `#pagebreak()`，章节会自动换页。

## 4. 交叉引用
- `Figure 8.6` → `图 8.6`；`Table 9.13` → `表 9.13`；`Chapter 9` → `第 9 章`；
  `Section 8.2` → `8.2 节`；`Exercises 8.7` → `习题 8.7`。
- 图/表编号后不加标点，直接接说明文字。
- 注意：原书正文常把**表**（如 9.3、9.13、9.14、9.15、9.16、9.23、9.24）和**代码图**（9.22）都称作 Figure。
  译文按实际对象称呼：表就写“表 X.Y”，代码图写“图 X.Y”。

## 5. 交付
- 只写指定的 `.typ` 文件，不要改动模板、不要创建其它文件（自检用的临时文件用完请删除）。
- 文件第一行固定为 `#import "../template.typ": *`，随后空一行再写正文。
- 写完后自查：
  `cd /Users/kk/WorkBuddy/os翻译/book3 && printf '#import "template.typ": *\n#show: book\n#include "chapters/UNIT.typ"\n' > _check_UNIT.typ && typst compile _check_UNIT.typ /tmp/check_UNIT.pdf && rm _check_UNIT.typ`
  必须编译通过；报错要改到通过为止。
- 不要输出解释性文字，不要在文件里写“以下是译文”之类的话。

## 6. 示例（源 → 译文）

源：
```
### 8.2.2 Paged Memory

With paging, memory is allocated in fixed-sized chunks called *page frames*.
Figure 8.6 illustrates address translation with paged memory.

::: aside Page size choices
Small pages reduce internal fragmentation but increase page table size.
:::

[[FIG:8.6:image00288.gif:Address translation with paged memory.]]
```

译文：
```typst
#subsect("8.2.2", "分页内存")

采用分页时，内存被划分为固定大小的块，称为_页框_（page frame）。图 8.6 展示了分页内存的地址转换过程。

#aside("页大小的选择")[
小页能减少内部碎片，但会使页表变大。
]

#fig("8.6", "image00288.png", [分页内存的地址转换。])
```
