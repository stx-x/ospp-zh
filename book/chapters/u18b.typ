#import "../template.typ": *

#sect("6.3", "锁争用")

有时，即便已经用上了上一节介绍的各种方法，在多处理器上，加锁仍可能成为取得良好性能的瓶颈。例如，对哈希表采用细粒度加锁时，如果某个桶里存放着一个特别热门的条目——比如 Justin Bieber 的缓存页面——那么这个桶上的锁就可能成为争用的来源。

本节讨论锁抽象的另外两种实现，它们对已经成为瓶颈的锁表现更好：

- *MCS 锁。* MCS 是一种自旋锁实现，针对存在大量等待线程的情形做了优化。

- *RCU 锁。* RCU 是一种读写锁实现，针对读操作远多于写操作的情形做了优化。RCU 降低了读者的开销，代价是提高了写者的开销。更重要的是，RCU 的语义与普通读写锁有所不同，这就要求锁的使用者自己理解它的危险之处。

这两种方法虽然都在现代操作系统内核中使用，但我们要提醒：它们都不是万能药。只有当性能剖析（profiling）表明某把锁确实是争用的来源、而且没有其他可选方案时，才应当使用它们。

#subsect("6.3.1", "MCS 锁")

回顾一下，第 5 章介绍的锁实现是针对“锁通常处于 FREE 状态”这一常见情形调优的。那么，当锁通常处于 BUSY 状态时，有没有高效的锁实现呢？

遗憾的是，获取和释放锁的开销会随争用该锁的线程数急剧*增加*。对一把被争用的锁而言，这又会进一步增加等待该锁的线程数。再回顾一下前面用过的那个例子：一把自旋锁保护一个共享计数器。

#code(lang: "c")[
```c
    void Counter::Increment() {
        while (test_and_set(&lock)) // while BUSY
            ; // spin
        value++;
        lock = FREE;
        memory_barrier();
    }
```
]

即使有许多线程试图递增同一个计数器，同一时刻也只有一个线程能执行临界区，其余线程必须排队等候。正如前面观察到的，由于计数器的值必须从一个持锁者传递给下一个持锁者，同一个临界区在多处理器上执行所需的时间会明显长于在单处理器上。

#fig("6.4", "image00405.png", [三种锁替代实现的额外开销随争用该锁的处理器数量的变化：（a）测试并设置，（b）测试并测试并设置，（c）MCS。测量在 64 核 AMD Opteron 6262 上进行。曲线不平滑是真实系统测量的典型特征。])

然而，存在多个等待线程时，情况还要更糟。受自旋锁保护的临界区的执行时间，会随自旋处理器数量的增加而线性增长。图 6.4 展示了这一效应。问题在于，处理器在执行一条原子的读-改-写指令之前，硬件必须先取得对该内存位置的独占访问权；其他任何读-改-写指令都只能发生在它之前或之后。

因此，如果若干处理器同时执行自旋循环，它们都会试图取得对锁所在内存位置的独占访问权。清除锁的存储指令同样需要独占访问，而硬件无法知道应当让释放锁的操作优先于那些“查看锁是否空闲”的竞争请求。

人们可能会想：在试图用测试并设置获取锁之前，先检查一下锁是否空闲，应该会有所帮助。这种做法称为*测试并测试并设置*（test and test-and-set）：

#code(lang: "c")[
```c
 void Counter::Increment() {
     while (lock == BUSY || test_and_set(&lock)) // while BUSY
         ; // spin
     value++;
     lock = FREE;
     memory_barrier();
 }
```
]

然而事实证明，这并没有用。锁被释放时，锁的新值 FREE 必须传递给其他正在等待的处理器。在现代系统上，每个处理器都要各自把该数据取入自己的缓存。最终会有一个处理器取到新值并获取到锁。如果临界区不太长，其他处理器此时仍然忙于取新值、试图获取锁，这反而妨碍释放锁的操作完成。

一种做法是根据线程已经等待的时间长短来调整轮询的频率。更具可扩展性的方案，是为每个等待线程分配一个独立的内存位置，让它在那个位置上自旋。释放锁时，只把*一个*线程对应的标志置位，告诉它就是下一个获得锁的线程。

这一思想最广为人知的实现称为 MCS 锁，名称取自其作者 Mellor-Crummey 与 Scott 的姓氏首字母。MCS 锁利用了大多数现代多处理器体系结构都支持的原子读-改-写指令——*比较并交换*（compare-and-swap）。比较并交换检查某个内存位置的值，若旧值未发生变化，就换入一个新值。

#code(num: "6.5", cap: [MCS 队列锁的伪代码。每个等待线程都在自己的线程控制块（TCB，即 myTCB）中的独立内存位置上自旋。compare-and-swap 操作原子地把该 TCB 插入队列尾部。], lang: "c")[
```c
 class MCSLock {
   private:
     Queue *tail = NULL;
 }

 MCSLock::release() {

     if (compare_and_swap(&tail,
                     myTCB, NULL)) {

         // If tail == myTCB, no one is
         // waiting. MCSLock is now free.

     } else {
         // Someone is waiting.
         while (myTCB->next == NULL)
             ; // spin until next is set

         // Tell next thread to proceed.
         myTCB->next->needToWait = FALSE;
     }
 }

 MCSLock::acquire() {
     Queue *oldTail = tail;

     myTCB->next = NULL;
     while (!compare_and_swap(&tail,
                   oldTail, &myTCB)) {

         // Try again if someone else
         // changed tail in the meantime.

         oldTail = tail;
     }

     // If oldTail == NULL, lock acquired.
     if (oldTail != NULL) {
         // Need to wait.
         myTCB->needToWait = TRUE;
         memory_barrier();
         oldTail->next = myTCB;
         while (myTCB->needToWait)
             ; //spin
     }
 }
```
]

#fig("6.6", "image00406.png", [MCS 队列锁的行为。初始时（a），tail 为 NULL，表示锁处于 FREE 状态。为获取锁（b），线程 A 原子地把 tail 设为指向 A 的 TCB。随后线程 B 与 C 通过（原子地）把自己加入队尾来排队（c）和（d），然后各自在自己的 TCB 的 needToWait 标志上自旋。线程 A 清除 B 的 needToWait 标志，把锁交给 B（e）；B 清除 C 的 needToWait 标志，把锁交给 C（f）。若没有其他线程在等待——即 tail 仍指向 C 的 TCB——C 就把 tail 设回 NULL，释放锁（a）。])

用比较并交换可以构建一个等待线程队列，而不需要另外的自旋锁。等待线程原子地把自己加到队列的*尾部*，然后在自己的队列项中的一个标志上自旋。线程释放锁时，把下一个队列项中的标志置位，通知那个线程轮到它了。图 6.5 给出了实现，图 6.6 演示了算法实际运行的情形。

由于队列中的每个线程都在自己的队列项上自旋，锁可以沿队列高效地从一处传到另一处。当然，建立队列本身有开销，因此除非有大量等待线程，MCS 锁的效率不如普通自旋锁。

#subsect("6.3.2", "读-复制-更新（RCU）")

*读-复制-更新*（RCU）为“频繁读取、偶尔更新”的数据结构提供高性能的同步。特别地，RCU 优化了读路径，即便有大量并发读者，同步开销也极低。不过，写操作可能被延迟很长时间——在某些实现中长达数十毫秒。

#subsubsect("为什么不使用读写锁？")

标准的读写锁不适合某些以读为主的工作负载。回顾一下：这类锁允许任意数量的读者并发地处于活动状态，但一旦有写者在活动，其他任何写者或读者都不能活动。

问题出在存在大量并发读、而每个临界区又很短的时候。每次读取之前，读者必须以读模式获取读写锁，读完再释放。无论进入还是退出，读者都必须更新读写锁同步对象中的某些状态。即便只有读者，这个同步对象也可能成为瓶颈。这就限制了读者进入临界区的速率，因为它们只能一个一个地获取锁。对于长度不足几千个周期的临界区，对于有几十个线程同时读取同一个共享对象的程序，标准读写锁会限制性能。

虽然可以用 MCS 锁来实现这个读写锁同步对象，从而减轻锁争用的一些影响，但这改变不了读写锁控制结构固有的串行访问。

#subsubsect("RCU 的方法")

并发读如何访问一个同时可能被写入的数据结构，而又不必在每次读取时更新某个同步变量的状态？

为应对这一挑战，RCU 锁保留了读写锁的基本结构：读者（以及写者）在临界区前后分别调用 RCU 锁的获取与释放，以读模式（或写模式）进入和退出。RCU 锁对标准接口做了三处重要改动：

+ *受限的更新。* 使用 RCU 时，写线程必须以一次原子的内存写入，把它的修改*发布*到共享数据结构上。通常的做法是更新单个指针，下面我们用 RCU 更新一个共享链表来说明这一点。受限的更新乍看之下似乎会严重限制 RCU 所能支持的数据结构操作类型，其实不然。一种常见的模式是：写线程先复制出一份复杂数据结构（或其中一部分）的*副本*，修改副本，然后把指向副本的指针发布到一个共享位置，供新的读者访问。

+ *多个并发版本。* RCU 允许任意数量的只读临界区与这次更新同时进行。这些只读临界区看到的可能是数据结构的旧版本，也可能是新版本。

+ *与线程调度器集成。* 更新发生时，可能仍有读者在进行中，因此共享对象必须保留其状态的多个版本，以保证旧版本在所有读者访问完毕之前不被释放。从更新被发布，到最后一名读者用完旧版本，这段时间称为*宽限期*（grace period）。RCU 锁利用线程调度器提供的信息来判断宽限期何时结束。

#fig("6.7", "image00407.png", [使用读-复制-更新（RCU）同步访问某一数据结构时，一次更新与若干次读取并发进行的时间线。])

图 6.7 给出了 RCU 下一个写者和若干读者线程的临界区时间线。如果读取该数据结构的函数在写操作发布之前就已完成，它看到的是旧版本；如果读者在写操作发布之后才开始，它看到的是新版本。但如果读者在写操作发布*之前*开始、在发布*之后*结束，那么它看到的可能是旧版本，也可能是新版本。如果它不止一次地读取那个被更新的指针，它可能先看到旧值、再看到新值。它究竟看到哪个版本，取决于它观察到的是那个被原子更新的单一内存位置的哪个版本。不过，系统保证旧版本在宽限期结束之前不会被删除。旧版本的删除必须推迟到所有可能观察到旧版本的读操作都完成为止。

#subsubsect("RCU 的 API 与用法")

RCU 是一种同步抽象，它允许多个读者并发访问某个数据结构，同时一次只允许一个写者访问。图 6.8 给出了一个典型的 API。

#tbl("6.8", [读-复制-更新（RCU）同步的示例编程接口。在 Java 的 RCU 锁实现中，不需要 synchronize 和 quiescentState，因为语言级的垃圾回收器会自动检测旧版本何时不再被访问。在 Linux 内核的 RCU 实现中，synchronize 被拆成两次调用：一次启动宽限期，一次等待宽限期结束。], (
  ([#text(font: hei, weight: "bold")[Reader API]], []),
  ([readLock()], [进入只读临界区。]),
  ([readUnlock()], [退出只读临界区。]),
  ([#text(font: hei, weight: "bold")[Writer API]], []),
  ([writeLock()], [进入读写临界区。]),
  ([publish()], [原子地更新共享数据结构。]),
  ([writeUnlock()], [退出读写临界区。]),
  ([synchronize()], [等待当前所有活动读者退出临界区，以便回收对象的旧版本。]),
  ([#text(font: hei, weight: "bold")[Scheduler API]], []),
  ([quiescentState()], [本处理器上在最近一次 RCU::publish 期间处于活动状态的只读线程，均已退出临界区。]),
), columns: (auto, 1fr))

读者在访问共享数据结构之前调用 RCU::readLock，之后调用 RCU::readUnlock。写者则调用：RCU::writeLock，以排斥其他写者；RCU::publish，发出对数据结构的原子更新，使读操作能看到这些修改；RCU::writeUnlock，让其他写者继续；以及 RCU::synchronize，等待宽限期结束，以便释放对象的旧版本。

如图 6.9 所示，写操作是串行的——同一时刻只能有一个写操作进行。不过，一个写操作可以与任意数量的读操作并发。一个写操作也可以与另一个写操作的宽限期并发：在多个相互重叠的宽限期结束之前，对象可能存在任意多个版本。

#fig("6.9", "image00408.png", [RCU 允许同一时刻只有一次写，并允许读与读、读与写相互重叠。初始版本为 v0，相互重叠的写操作先后把版本更新为 v1、v2，然后 v3。], width: 74%)

#example[
图 6.9 中的每一次读，分别可能观察到共享状态的哪个（些）版本？
]

#answer[
如果某次读与一次发布重叠，它可能返回发布后的值，也可能返回先前的值：

#tbl(none, none, (
  ([read#sub[1]], [v0 或 v1], [与 publish v1 重叠。]),
  ([read#sub[2]], [v2], [在 publish v2 之后、publish v3 之前。]),
  ([read#sub[3]], [v3], [在 publish v3 之后。]),
  ([read#sub[4]], [v0 或 v1], [与 publish v1 重叠。]),
  ([read#sub[5]], [v1 或 v2], [与 publish v2 重叠。]),
  ([read#sub[6]], [v0、v1 或 v2], [与 publish v1 和 v2 都重叠。]),
  ([read#sub[7]], [v3], [在 publish v2 之后。]),
), header: ([读], [返回值], [原因]), columns: (auto, auto, 1fr), size: 8.8pt)

□
]

#code(num: "6.10", cap: [用 RCU 同步的链表的数据结构与 API 声明，以及用 RCU 搜索该链表的只读方法的实现。], lang: "c")[
```c
 typedef struct ElementS{
   int key;
   int value;
   struct ElementS *next;
 } Element;

 class RCUList {
   private:
     RCULock rcuLock;
     Element *head;
   public:
     bool search(int key, int *value);
     void insert(Element *item, value);
     bool remove(int key);
 };

 bool
 RCUList::search(int key, int *valuep) {
     bool result = FALSE;
     Element *current;

     rcuLock.readLock();
     current = head;
     for (current = head; current != NULL;
                 current = current->next) {
         if (current->key == key) {
             *valuep = current->value;
             result = TRUE;
             break;
         }
     }
     rcuLock.readUnlock();
     return result;
 }
```
]

#example(tag: "例：RCU 链表")[
图 6.10 与图 6.11 展示了如何用 RCU 锁实现一个链表，使它可以被许多读者并发访问，同时由一个写者更新。

链表数据结构由一个 RCU 锁和一个指向表头的指针组成。链表中的每个表项有两个数据字段——key 与 value——以及一个指向链表中下一条记录的指针。

search 方法是只读的：在用 readLock 注册之后，它沿链表向下扫描，直到找到 key 匹配的元素。如果找到了该元素，方法通过参数返回其 value 字段，然后返回 TRUE；否则方法返回 FALSE，表示没有找到匹配的记录。

更新链表的方法则要微妙一些。它们都被安排成：只需更新一个指针，就足以把链表的新版本发布给读者。特别重要的是，insert 必须*先*初始化数据结构，*再*更新表头指针，从而让新元素对读者可见。
]

#code(num: "6.11", cap: [用 RCU 实现链表同步。], lang: "c")[
```c
 void
 RCUList::insert(int key,
                    int value) {
     Element *item;

     // One write at a time.
     rcuLock.writeLock();

     // Initialize item.
     item = (Element*)
          malloc(sizeof(Element));
     item->key = key;
     item->value = value;
     item->next = head;

     // Atomically update list.
     rcuLock.publish(&head, item);

     // Allow other writes
     // to proceed.
     rcuLock.writeUnlock();

     // Wait until no reader
     // has old version.
     rcuLock.synchronize();
 }

 bool
 RCUList::remove(int key) {
     bool found = FALSE;
     Element *prev, *current;

     // One write at a time.
     rcuLock.WriteLock();
     for (prev = NULL, current = head;
             current != NULL; prev = current,
             current = current->next) {
         if (current->key == key) {
             found = TRUE;

             // Publish update to readers
             if (prev == NULL) {
                 rcuLock.publish(&head,
                           current->next);
             } else {
                 rcuLock.publish(&(prev->next),
                           current->next);
             }
             break;
         }
     }

     // Allow other writes to proceed.
     rcuLock.writeUnlock();

     // Wait until no reader has old version.
     if (found) {
         rcuLock.synchronize();
         free(current);
     }
     return found;
 }
```
]

#subsubsect("实现 RCU")

实现 RCU 时的核心目标，是尽量降低读临界区的代价：系统必须允许任意数量的并发读者。反过来说，写操作可以具有很高的*延迟*。具体而言，宽限期可能很长：从更新被发布，到系统能够保证没有读者仍在使用旧版本，其间可能长达数十毫秒。即便如此，写的*开销*——每次写所需的 CPU 时间——也应当保持在适度水平。

达成这些目标的一种常用技术，是把 RCU 的实现与线程调度器的实现结合起来。这与上一章介绍的读写锁形成对照：读写锁对线程调度器不作任何假设，但必须精确跟踪任一时刻有多少读者处于活动状态。

具体说来，我们要介绍的这个实现向调度器提出两点要求：(1) 只读临界区在完成之前不被打断；(2) 每当某个处理器上的线程被打断时，调度器就更新该处理器对应的 RCU 状态。这样一来，一次写完成之后，RCULock::Synchronize 只需等待所有处理器至少被打断一次。到那时，就可以确定对象的旧版本处于*静止*（quiescent）状态——没有线程还能访问旧版本（改变它的那个写者除外）。

#code(num: "6.12", cap: [一个基于静止状态的 RCU 实现。代码假定自旋锁的获取/释放与中断的开启/关闭都会触发内存屏障。致谢：这段伪代码基于 Paul McKenney 在 “Is Parallel Programming Hard, And, If So, What Can be Done About It?” 中的实现。], lang: "c")[
```c
 class RCULock{
   private:
   // Global state
     Spinlock globalSpin;
     long globalCounter;
   // One per processor
     DEFINE_PER_PROCESSOR(
        static long, quiescentCount);

   // Per-lock state
     Spinlock writerSpin;

   // Public API omitted
 }

 void RCULock::ReadLock() {
     disableInterrupts();
 }

 void RCULock::ReadUnlock() {
     enableInterrupts();
 }

 // Called by scheduler
 void RCULock::QuiescentState(){
     memory_barrier();
     PER_PROC_VAR(quiescentCount) =
                     globalCounter;
     memory_barrier();
 }

 void RCULock::writeLock() {
     writerSpin.acquire();
 }

 void RCULock::writeUnlock() {
     writerSpin.release();
 }

 void RCULock::publish (void **pp1,
                          void *p2){
     memory_barrier();
     *pp1 = p2;
     memory_barrier();
 }

 void
 RCULock::synchronize() {
     int p, c;

     globalSpin.acquire();
     c = ++globalCounter;
     globalSpin.release();

     FOREACH_PROCESSOR(p) {
         while((PER_PROC_VAR(
           quiescentCount, p) - c) < 0) {
             // release CPU for 10ms
             sleep(10);
         }
     }
 }
```
]

图 6.12 给出了一个基于静止状态的 RCU 实现。首先注意，readLock 与 readUnlock 的开销很小：它们不更新任何状态，只是确保读操作不被打断。RCU::writeLock 与 writeUnlock 的开销也很小：它们获取并释放一把自旋锁，以保证每个 RCULock 上同一时刻至多有一个写操作可以进行。

RCU::publish 同样简单。它先执行一次内存屏障，使对共享对象的所有修改都在指针更新之前完成；接着更新指针，然后再执行一次内存屏障，让其他处理器能看到这次更新。

RCU::synchronize 与 quiescentState 协同工作，确保 synchronize 返回时，所有线程都必定已经用完了对象的旧版本。RCU::synchronize 递增一个全局计数器，然后等待所有处理器的 quiescentCount 追上该计数器的新值。每当某个处理器被打断时，调度器就调用 RCU::quiescentState，把该处理器的 quiescentCount 更新为当前的 globalCounter。因此，一旦每个处理器上的 quiescentCount 都不小于 c，synchronize 就知道不可能再有读者观察到旧版本了。
