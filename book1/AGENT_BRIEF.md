# 翻译任务简报（第一卷：内核与进程）

把源文件（英文 Markdown）**完整、准确、通顺**地翻译为 Typst 文件。

## 1. 输入与输出

- 源文件：`/Users/kk/WorkBuddy/os翻译/work/vol1/src/units/uXXX.md`
- 输出：`/Users/kk/WorkBuddy/os翻译/book1/chapters/uXXX.typ`（文件名由任务指定，不加前缀/后缀）
- 输出第一行固定为：`#import "../template.typ": *`

## 2. 可用组件（template.typ 提供，勿自行造轮子）

| 组件 | 用法 | 说明 |
|---|---|---|
| 章首 | `#chapter(num, "中文章名", en: "English Title", epi: [...])` | 仅章首用；num 为数字 |
| 一级节 | `#sect("2.1", "中文节名")` | 编号用原文编号 |
| 二级节 | `#subsect("2.1.1", "中文节名")` | |
| 三级节 | `#subsubsect("中文标题")` | 无编号时用 |
| 无号标题 | `#plainhead("中文标题")` | 前言等 |
| 图 | `#fig("1.3", "image00182.png", [中文题注])` | 图片在 `book1/figures/`，**扩展名一律用 `.png`** |
| 代码 | `#code(num: "1.5", cap: [中文题注], lang: "c")[ ... ]` | 无题注时 `#code[ ... ]` |
| 表 | `#tbl("1.1", [中文题注], ( (单元格...), (...) ), header: (表头...), columns: (1fr, 1fr))` | |
| 边栏 | `#aside("标题")[内容]` | |
| 例题 | `#example[题干]` / `#answer[解答]` | 源中 `[[EXAMPLE]]` `[[ANSWER]]` |
| 习题 | `#exercises[ + 第一题 + 第二题 ]` | 每题用 `+ ` 编号 |

源文件里的标记：`[[FIG:编号:文件名:题注]]` → `#fig`；`[[TAB:编号:题注]]` → `#tbl`；`[[CODE:编号:题注]]` → `#code`；`::: aside 标题 ... :::` → `#aside`。

## 3. 排版规则

- **不用 `#` 标题**，一律用上表组件（`#` 会破坏目录）。
- 每段单独成行，段落之间空一行。
- 列表：`- ` 无序；`+ ` 有序（编号）。
- 强调：中文用 `*加粗*`；术语首次出现可用 `_斜体_`。
- 代码、命令、文件名、函数名用反引号 `` `foo` ``。
- 公式用 Typst 数学：`$x = 1$`；下标 `$T_"q"$`。
- **特殊字符必须转义**：`#` → `\#`，`$` → `\$`，`@` → `\@`，`~` → `\~`，URL 里的 `_` → `\_`。
- 图注、表注、代码注都要**译成中文**，编号保留原书编号。
- 代码块内的**代码与注释保持英文原样，不要翻译**。

## 4. 翻译要求（最重要）

- **逐段翻译，不省略、不合并、不改写结构**。源里每一段（含列表项、边栏、习题）都要出现在译文里。
- 语言通顺自然，符合中文技术书表达习惯；不要翻译腔、不要机翻味（避免"被…"滥用、长句堆砌）。
- 术语统一，参考 `/Users/kk/WorkBuddy/os翻译/book1/glossary.md`：
  kernel 内核、process 进程、thread 线程、system call 系统调用、mode bit 模式位、
  dual-mode operation 双模式操作、kernel mode 内核模式、user mode 用户模式、
  exception 异常、interrupt 中断、trap 陷阱、virtual machine 虚拟机、
  address space 地址空间、shell 外壳、pipeline 管道、interprocess communication 进程间通信、
  microkernel 微内核、monolithic kernel 宏内核、boot 引导、privileged instruction 特权指令。
- 专业术语首次出现可括注英文，如：*陷阱*（trap）。
- 人称与语气保持原书风格（常有"我们""你"）。

## 5. 自检（必须执行）

写完文件后，在 `/Users/kk/WorkBuddy/os翻译/book1/` 目录执行：

```bash
cp main.typ main_check.typ   # 若 main_check.typ 不存在则新建
# 把 chapters/uXXX.typ 加入 main_check.typ 的 include 列表（或新建只含本单元的文件）
typst compile main_check.typ /tmp/selfcheck.pdf
```

更简单：新建 `/Users/kk/WorkBuddy/os翻译/book1/self_uXXX.typ`：

```typst
#import "template.typ": *
#show: book
#include "chapters/uXXX.typ"
```

然后 `cd /Users/kk/WorkBuddy/os翻译/book1 && typst compile self_uXXX.typ /tmp/self_uXXX.pdf`。
**必须编译零报错才算完成**；报错就修到通过。完成后删除临时自检文件（`self_uXXX.typ`），只保留 `chapters/uXXX.typ`。

## 6. 完成后

回复：输出文件路径 + 编译结果（页数）+ 任何需要我注意的地方（如源文中缺失/异常之处）。**不要贴出译文全文。**
