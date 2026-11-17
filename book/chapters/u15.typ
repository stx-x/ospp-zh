#import "../template.typ": *

#sect("5.7", "同步对象的实现")

我们已经描述了锁与条件变量，并说明了如何在共享对象中使用它们；接下来讨论如何实现这些重要的构件（building block）。

回顾第 4 章：线程既可以在内核中实现，也可以在用户级实现。我们先说明如何为内核线程实现同步；本节末尾再讨论为了让这些抽象也支持用户级线程，需要做哪些改动。

锁与条件变量都有状态。对锁而言，状态就是锁本身的状态（FREE 或 BUSY），再加上一个队列，其中存放零个或多个等待锁变为 FREE 的线程。对条件变量而言，状态就是等待被发信号的线程队列。无论哪种情况，难点都在于原子地修改这些数据结构。

“牛奶买多了”的讨论表明，只用内存读、写来实现原子动作既复杂又昂贵。因此，现代实现使用更强大的硬件原语（hardware primitive），让我们能够原子地读取、修改和写入一部分状态。我们用到两种硬件原语：

- *关闭中断。* 在单处理器上，只要关闭这颗处理器上的中断，就能让一段指令序列成为原子的。

- *原子的读-修改-写指令。* 在多处理器上，关闭中断不足以提供原子性。于是体系结构提供专门的指令，原子地读取并更新内存中的一个字。相对于每颗处理器上的指令，这些指令都是全局原子的。

这两种原语同时也都充当内存屏障（memory barrier）：它们告诉编译器与硬件，所有先前的指令都必须在原子指令执行之前完成。

#subsect("5.7.1", "用关中断实现单处理器锁")

在单处理器上，只要一个线程的某条指令序列中间不发生上下文切换，这个序列对其他线程而言就是原子的。因此，在单处理器上，线程只要在该序列执行期间关闭中断（并避免调用可能触发上下文切换的线程库函数），就能让一串动作成为原子动作。

由此可以得到一种在单处理器上实现锁的方法——做法很简单，限制却很严重：

#code(lang: "c")[
```c
Lock::acquire() { disableInterrupts(); }

Lock::release() { enableInterrupts(); }
```
]

这种实现确实提供了锁所必需的互斥性质。有些单处理器内核就采用这种简单的做法，但它不足以作为锁的一般实现。如果锁所保护的代码序列运行很久，中断就会关闭那么久。这会阻止其他线程运行，也会让系统无法及时响应用户输入或其他实时任务。此外，这种做法可以用于内核，因为内核里的代码（大概）都经过仔细编写、可信地快速释放锁；但我们不能让不可信的用户级代码在关闭中断的情况下运行，否则一个恶意或有缺陷的程序就能独占处理器。

#subsect("5.7.2", "实现单处理器队列锁")

更通用的方案基于这样一个观察：如果锁处于 BUSY，那么在锁变为空闲之前，让正在获取锁的线程继续运行毫无意义。此时应当切换到下一个就绪线程。

这种实现会短暂关闭中断以保护锁的数据结构，但一旦线程取得了锁、或者判定锁处于 BUSY，就立即重新打开中断。图 5.15 所示的 Lock 实现说明了这种做法。如果线程尝试获取锁时锁处于 BUSY，该线程就把自己的 TCB 移入这把锁的等待列表。随后线程挂起自己，并切换到下一个可运行的线程。suspend 调用不会返回，直到该线程被放回就绪列表，例如直到某个线程调用 Lock::release。

#code(num: "5.15", cap: [单处理器队列锁的伪代码。临时关闭中断，使对实现该锁的数据结构的访问具有原子性。suspend(oldTCB, newTCB) 把当前线程切换到下一个将要运行的线程；只有等其他线程调用 release 并把它移回就绪列表之后，它才会返回。], lang: "c")[
```c
 class Lock {
   private:
     int value = FREE;
     Queue waiting;
   public:
     void acquire();
     void release();
 }

 Lock::acquire() {
     TCB *chosenTCB;

     disableInterrupts();
     if (value == BUSY) {
         waiting.add(runningThread);
         runningThread->state = WAITING;
         chosenTCB = readyList.remove();
         thread_switch(runningThread,
                       chosenTCB);
         runningThread->state = RUNNING;
     } else {
         value = BUSY;
     }
     enableInterrupts();
 }

 Lock::release() {
 // next thread to hold lock
     TCB *next;

     disableInterrupts();
     if (waiting.notEmpty()) {
     // move one TCB from waiting
     // to ready
         next = waiting.remove();
         next->state = READY;
         readyList.add(next);
     } else {
         value = FREE;
     }
     enableInterrupts();
 }
```
]

在我们的实现里，如果有线程正在等待这把锁，release 调用就不会把 value 置为 FREE，而是让 value 保持 BUSY。被唤醒的线程保证就是下一个执行临界区的线程。这样的安排确保了免于饥饿。

*警告*：这一优化只适用于本实现。锁的使用者不应对等待线程获取锁的次序作任何假设。

#example[
在 Lock::acquire 中，调用 thread_switch 时中断是关闭的。那么由谁来重新打开中断？
]

#answer[
*由下一个运行的线程重新打开中断。* 具体来说，大多数线程系统的实现都维持这样一条不变式：线程在执行上下文切换之前总是先关闭中断。因此，一个线程在经历上下文切换后再次运行时，中断总是处于关闭状态。所以，线程从上下文切换返回时，必须重新打开中断。例如，图 5.15 中的 Lock::acquire 代码在返回之前重新打开中断；第 4 章中的 yield 实现在上下文切换之前关闭中断，切换之后再重新打开。□
]

#subsect("5.7.3", "实现多处理器自旋锁")

然而在多处理器上，关闭中断是不够的。即使在一颗处理器上关闭了中断，其他线程仍在并发运行。一颗处理器上线程的操作，会与其他处理器上线程的操作交错进行。

既然关闭中断不够，大多数处理器体系结构就提供_原子的读-修改-写指令_来支持同步。这类指令能把一个值从内存位置读入寄存器、修改该值，并把修改后的值写回内存，而相对于其他处理器上的所有指令，整个过程是原子的。

#aside("读-修改-写指令是如何实现的")[
讲到这里，学生常常会问：处理器硬件是如何实现 test-and-set 这类原子指令的？如果每颗处理器都有自己的缓存，那么是什么阻止两颗处理器同时读取并更新同一个位置？完整的解释超出了本书的范围，不过硬件所用的机制与缓存一致性（cache coherence）所用的机制是同一套。

处理器缓存中的每个条目都有一个状态：_独占_（exclusive）或_只读_（read-only）。只要还有其他处理器缓存了该数据，它在所有缓存中就都必须是_只读_的。要修改一个共享内存位置，处理器必须持有该数据的_独占_副本；其他任何缓存都不得持有副本。否则，一颗处理器可能读到某个位置已经过期的值，而另一颗处理器早已更新了它。要读写某个正以_独占_状态存放在其他缓存中的位置，处理器需要从那个缓存取回最新的值。

读-修改-写指令正是借助这一机制实现的。执行这类指令时，硬件先取得该内存的_独占_副本，并使其他所有缓存中的副本失效。然后指令在本地副本上执行；指令完成后，其他处理器才可以取回最新的值来读取结果。
]

举例来说，有些体系结构提供_测试并设置_（test-and-set）指令，它原子地把一个值从内存读入寄存器，并把 1 写入该内存位置。

#code(num: "5.16", cap: [用 test-and-set 实现的多处理器自旋锁。], lang: "c")[
```c
 class SpinLock {
   private:
     int value = 0; // 0 = FREE; 1 = BUSY

   public:
     void acquire() {
         while (test_and_set(&value)) // while BUSY
             ; // spin
     }

     void release() {
         value = 0;
         memory_barrier();
     }
 }
```
]

图 5.16 用 test_and_set 实现了一把锁。这把锁之所以称为_自旋锁_（spinlock），是因为等待一把 BUSY 锁的线程会在一个紧凑的循环里“自旋”（忙等），直到其他线程释放该锁。如果锁被长时间持有，这种做法的效率不高。不过，对于那些只被短期持有（即持有时间比一次上下文切换还短）的锁，自旋锁是合适的。

#aside("中断处理程序与自旋锁")[
只要中断处理程序要访问共享数据，这份数据就必须用自旋锁而不是队列锁来保护。正如第 2 章和第 4 章所解释的，中断处理程序不是线程：它必须不阻塞地运行到结束，这样硬件才能递交下一个中断。若使用队列锁，中断处理程序开始运行时锁可能正被持有，这会使中断处理程序无法正确工作。

任何线程只要要获取中断处理程序中使用的自旋锁，就_必须_先关闭中断。否则，如果中断恰好在不巧的时刻到达，就可能导致死锁。处理程序可能永远自旋，等待一把被它所中断的那个线程持有的锁。此时多半只能重启系统才能解决问题。

为了避免这类错误，大多数操作系统都让中断处理程序保持极其简单。例如，许多中断处理程序只是唤醒一个线程，由该线程去做管理 I/O 设备的繁重工作。唤醒线程需要互斥地访问就绪列表，而就绪列表由一把自旋锁保护，凡是使用这把锁，都必须先关闭中断。
]

#subsect("5.7.4", "实现多处理器队列锁")

我们常常需要支持长度不一的临界区。例如，我们可能想要一个通用解法，它不对持有锁的方法的运行时间作任何假设。

#code(num: "5.17", cap: [多处理器队列锁的伪代码。调度器和锁都用自旋锁保护各自的内建数据结构。任何线程在锁处于 BUSY 时尝试获取锁，都会被放入队列，留待以后唤醒。这里需要格外小心，防止等待线程在完成 thread_switch 之前就被放回就绪列表。], lang: "c")[
```c
 class Lock {
    private:
      int value = FREE;
      SpinLock spinLock;
      Queue waiting;
    public:
      void acquire();
      void release();
 }

 Lock::acquire() {
     spinLock.acquire();
     if (value != FREE) {
         waiting.add(runningThread);
         scheduler.suspend(&spinLock);
        // scheduler releases spinLock
     } else {
         value = BUSY;
         spinLock.release();
     }
 }

 void Lock::release() {
     TCB *next;

     spinLock.acquire();
     if (waiting.notEmpty()) {
         next = waiting.remove();
         scheduler.makeReady(next);
     } else {
         value = FREE;
     }
     spinLock.release();
 }

 class Scheduler {
   private:
     Queue readyList;
     SpinLock schedulerSpinLock;
   public:
     void suspend(SpinLock *lock);
     void makeReady(Thread *thread);
 }

 void
 Scheduler::suspend(SpinLock *lock) {
     TCB *chosenTCB;

     disableInterrupts();
     schedulerSpinLock.acquire();
     lock->release();
     runningThread->state = WAITING;
     chosenTCB = readyList.getNextThread();
     thread_switch(runningThread,
                   chosenTCB);
     runningThread->state = RUNNING;
     schedulerSpinLock.release();
     enableInterrupts();
 }

 void
 Scheduler::makeReady(TCB *thread) {
     disableInterrupts();
     schedulerSpinLock.acquire();
     readyList.add(thread);
     thread->state = READY;
     schedulerSpinLock.release();
     enableInterrupts();
 }
```
]

在多处理器上，我们无法完全消除忙等，但可以把它降到最低。如前所述，调度器的就绪列表需要一把自旋锁。调度器持有这把自旋锁只持续几条指令；而且，如果就绪列表的自旋锁处于 BUSY，那么尝试切换到另一个线程也没有意义，因为那同样需要访问就绪列表。

为了减少就绪列表自旋锁上的争用，我们用_另一把_自旋锁来保护每把锁的内部状态。线程一旦持有某把锁的自旋锁，就可以检查和更新这把锁的状态。如果锁是 FREE，线程就设置其值并释放自旋锁。如果锁是 BUSY，则需要做更多工作：把当前线程放入该锁的等待列表，挂起当前线程，并切换到新线程。

不过，如图 5.17 所示，这里的顺序必须非常小心。在多处理器上挂起一个线程，需要先关闭中断，以确保线程在持有就绪列表自旋锁期间不会被抢占。然后获取就绪列表自旋锁，_只有到这时_，才可以安全地释放该锁的自旋锁并切换到新线程。就绪列表自旋锁由下一个运行的线程释放。否则，另一颗处理器上的某个线程可能在等待线程完成上下文切换之前，就把它放回就绪列表（并让它开始运行）。

之后，当锁被释放时，如果有线程正在等待这把锁，就把其中一个从锁的等待列表移到调度器的就绪列表。

#example[
如果我们在调用 suspend 之前就释放了锁的自旋锁，可能会发生什么？
]

#answer[
问题的关键在于：我们要确保正在获取锁的线程先完成自我挂起，之后释放锁的线程才会尝试重新调度它。如果让 makeReady 在 suspend 之前运行，makeReady 会把正在获取锁的线程标记为 READY，但随后 suspend 又把这个线程的状态改成 WAITING。于是该线程就永远卡在 WAITING 状态。由于这种执行顺序极少出现，问题会极难定位。□
]

*注意*：在图 5.17 的实现中，随着处理器数量增加，这唯一一把调度器自旋锁可能成为瓶颈。因此，正如第 6 章将要解释的，大多数系统为每颗处理器各设一个就绪列表，每个列表由不同的自旋锁保护。这样，不同处理器就可以同时向不同的列表加入线程或从中取出线程。通常，处于 WAITING 的线程会被放到它此前处于 RUNNING 状态的那颗处理器的就绪列表上；这能改善缓存性能，因为该处理器的缓存中可能还留有该线程上次运行时用到的代码和数据。把线程放回同一个就绪列表，还能防止其他处理器在线程完成上下文切换之前就运行它。一旦线程变为 READY，任何空闲处理器都可以运行它：获取它所在就绪列表的自旋锁，把它取出，再释放自旋锁。

#subsect("5.7.5", "案例研究：Linux 2.6 内核互斥锁")

我们以 Linux 2.6 内核为例，说明锁在实践中是如何实现的。Linux 的代码与我们上面描述的做法十分接近，只是它_针对常见情形做了优化_。

在 Linux 中，大多数锁在大多数时候都是 FREE 的。而且，即使某把锁处于 BUSY，也很可能没有其他线程在等它。反之，如果锁经常处于 BUSY、或者有长长的线程队列在等它，那就意味着任何需要这把锁的线程通常都得等待，从而拖慢系统。

Linux 的锁实现正是利用了这一点：在线程获取锁时无需等待、以及释放锁时无需唤醒线程的情形下，提供一条极快的快路径。其他所有情形则走一条慢路径，与图 5.17 类似。

此外，为获取一把 FREE 的锁、以及释放一把没有等待者的锁提供快路径，对下面将要讨论的用户级线程库同样重要。

为了优化常见情形的路径，Linux 利用了 x86 的硬件特性。x86 支持许多种不同的读-修改-写指令，包括原子减一（从内存位置减 1，并返回先前的值）、原子加一、原子交换（把内存位置的值与寄存器中的值互换）以及原子 test-and-set。

关键思路是：设计锁的数据结构，使得在快路径上获取和释放锁时，_不必_先获取自旋锁，也不必关闭中断。慢路径则确实需要获取自旋锁。锁的值不是二值的，而是一个整数计数，共有三种状态：

#code(lang: "c")[
```c
    struct mutex {
        /* 1: unlocked, 0: locked, negative: locked, possible waiters */
        atomic_t          count;
        spinlock_t        wait_lock;
        struct list_head  wait_list;
    };
```
]

Linux 的锁获取代码是一个宏（以避免在快路径上发生过程调用），展开后是一小段指令。decl 指令前面的 x86 lock 前缀告诉处理器：这条指令应当原子地执行。

#code(lang: "c")[
```c
        lock decl (%eax)  // atomic decrement of a memory location
                          // address in %eax is pointer to lock->count
        jns 1f            // jump if not signed (if value is now 0)
        call slowpath_acquire
    1:
```
]

如果锁原本是 FREE，那么只用两条指令就取得了锁；如果锁原本是 BUSY，代码会让 count 保持小于 0，并调用另一个例程处理慢路径。慢路径关闭抢占、获取自旋锁、把线程放入锁的等待队列，然后重新检查在此期间锁是否已被释放。为此，它使用了原子交换指令：

#code(lang: "c")[
```c
    for (;;) {
        /*
         * Lets try to take the lock again - this is needed even if
         * we get here for the first time (shortly after failing to
         * acquire the lock), to make sure that we get a wakeup once
         * it’s unlocked. Later on, if we sleep, this is the
         * operation that gives us the lock. We xchg it to -1, so
         * that when we release the lock, we properly wake up the
         * other waiters:
         */
        if (atomic_xchg(&lock->count, -1) == 1)
            break;

        /* didn’t get the lock, go to sleep: */
        ...
    }
```
]

如果成功，就取得了锁。如果失败，线程释放自旋锁并切换到下一个就绪线程。当线程从 suspend 返回时，与图 5.17 的情形不同，锁可能已经不是 FREE，因此线程必须再试一次。

最终，线程跳出循环，这意味着它找到了一个锁处于 FREE 的时刻（`lock->count = 1`），并在这个时刻把锁置为“已加锁、可能有等待者”的状态（即令 `count = -1`）。此时线程已持有锁，随后它做清理：若没有其他等待者，就把 `count` 重置为 0。

#code(lang: "c")[
```c
    /* set it to 0 if there are no waiters left: */
    if (list_empty(&lock->wait_list))
        atomic_set(&lock->count, 0);
```
]

然后它释放自旋锁并重新允许抢占。

释放时，如果锁的值为 0（即锁没有等待者），快路径就是两条内联指令。

#code(lang: "c")[
```c
        lock incl (%eax)     // atomic increment
        jg 1f        // jump if new value is 1
        call slowpath_release
    1:
```
]

在慢路径上，count 原本为负。加一指令执行后，锁仍保持 BUSY。接着，线程获取自旋锁，把 count 置为 FREE，并唤醒一个等待线程。

#code(lang: "c")[
```c
    spin_lock_mutex(&lock->wait_lock, flags);
        /*
         * Unlock lock here
         */
    atomic_set(&lock->count, 1);
    if (!list_empty(&lock->wait_list)) {
        struct mutex_waiter *waiter =
            list_entry(lock->wait_list.next,
                struct mutex_waiter, list);
        wake_up_process(waiter->task);
    }
    spin_unlock_mutex(&lock->wait_lock, flags);
```
]

注意，这个函数总是把 count 置为 1，即使还有等待线程也是如此。因此，可能有新线程插进来，在快路径上取得这把锁，并把 count 置为 0。在这种情况下，等待线程仍然会被唤醒；等它最终运行时，上面那个主循环会把 count 置为 -1。

这个例子说明，获取和释放一把锁可以很便宜。程序员有时会费尽心思，试图在特定情形下避免获取锁。然而，这类情形下的推理可能很微妙，而省掉本该有的锁是危险的。在争用很少的情况下，避免用锁不太可能显著提升性能，因此通常更好的做法是保持简单，依靠锁来保证访问共享状态时的互斥。

#subsect("5.7.6", "实现条件变量")

我们可以用与实现锁类似的办法来实现条件变量，只有一处简化：由于调用 `wait`、`signal` 或 `broadcast` 时总是持有锁，我们已经互斥地访问了条件等待队列。与锁的情形一样，这里需要小心，防止等待线程在完成上下文切换之前就被放回就绪列表；做法是在释放管程锁_之前_先获取调度器自旋锁。另一个线程可能获取了管程锁并开始向等待线程发信号，但它在上下文切换之后调度器锁被释放之前，无法完成这次信号。

#code(num: "5.18", cap: [条件变量实现的伪代码。suspend 与 makeReady 的定义见图 5.17。], lang: "c")[
```c
 class CV {
   private:
     Queue waiting;
   public:
     void wait(Lock *lock);
     void signal();
     void broadcast();
 }

 // Monitor lock is held by current thread.
 void CV::wait(Lock *lock) {
     assert(lock.isHeld());
     waiting.add(myTCB);
     // Switch to new thread and release lock.
     scheduler.suspend(&lock);
     lock->acquire();
 }

 // Monitor lock is held by current thread.
 void CV::signal() {
     if (waiting.notEmpty()) {
         thread = waiting.remove();
         scheduler.makeReady(thread);
     }
 }

 void CV::broadcast() {
     while (waiting.notEmpty()) {
         thread = waiting.remove();
         scheduler.makeReady(thread);
     }
 }
```
]

图 5.18 给出了一个采用 Mesa 语义的实现——当我们向一个等待线程发信号时，该线程变为 READY，但它可能不会立即运行，而且必须重新获取管程锁。很可能有另一个线程先取得管程锁，并在等待线程从 CV::wait 返回之前，改变由该锁保护的状态。

#subsect("5.7.7", "实现应用级同步")

前面的讨论集中在为内核线程实现锁与条件变量。在那种情况下，一切（代码、共享状态、锁的数据结构、线程控制块以及就绪列表）都在内核内存中，所有线程都在内核态运行。幸运的是，虽然有些细节会变，但当我们为运行在用户级的线程实现锁与条件变量时，同样的基本做法依然可行。

回顾第 4 章：支持应用级并发有两种方式——通过系统调用访问内核的线程操作，或者使用用户级线程调度器。

*内核管理的线程。* 在内核管理的线程中，内核向进程提供线程，并管理线程就绪列表。内核调度器需要知道线程何时在等待某把锁或某个条件变量，以便挂起该线程并切换到下一个就绪线程。

最简单的情形是：把锁与条件变量的数据结构（包括等待列表）放在内核地址空间中。对同步对象的每次方法调用都转换为一次系统调用。这样，前面描述的内核级锁与条件变量的实现就可以基本不加改动地使用。

更精巧的做法是把锁的状态与实现拆成快路径和慢路径，类似于上面介绍的 Linux 锁。例如，每把锁有两个数据结构：(i) 进程的地址空间里存放类似 count 字段的东西；(ii) 内核中存放自旋锁和 `wait_list` 队列。

于是，获取一把 FREE 的锁、或释放一把没有等待线程的锁，在用户级只需几条指令，不涉及系统调用。慢路径仍然需要系统调用（例如等待线程需要挂起执行时）。实现的细节我们留给读者作为练习。

*用户管理的线程。* 在完全运行于用户级的线程库中，库会创建多个内核线程充当虚拟处理器，再把用户级线程多路复用到这些虚拟处理器上。这种情况与内核线程类似，只不过是在进程的地址空间内运行，而不是在内核的地址空间内。具体来说，代码、共享状态、锁与条件变量的数据结构、线程控制块以及就绪列表，都位于进程的地址空间。

唯一重要的改动与关闭中断有关。显然，用户级线程包无法关闭系统级的中断；内核不可能允许一个不可信的进程关闭中断从而可能永远运行下去。

幸运的是，线程库只需要屏蔽来自操作系统的上调（upcall）；上调用于触发线程抢占以及用户级调度器中的其他操作，如果它们在线程库修改调度器数据结构时发生，就可能造成不一致。大多数现代操作系统都提供了一种办法，可以暂时屏蔽上调，然后在安全的时候再递交这些上调。只要确保用户级调度器与上调处理程序不会同时运行，上面介绍的快路径互斥锁实现在这里同样可用。
