#import "../template.typ": *

#sect("4.6", "实现内核线程")

到目前为止，我们已经描述了线程的基本数据结构与操作。现在我们来描述如何实现它们。实现的具体方式因上下文而异：

- *内核线程。* 最简单的情形是在操作系统内核内部实现线程，让它们共享一个或多个物理处理器。_内核线程_（kernel thread）执行内核代码、修改内核数据结构。今天几乎所有商用操作系统都支持内核线程。

- *内核线程与单线程进程。* 一个支持内核线程的操作系统可能同时运行一些单线程的用户进程。如图 4.11 所示，这些进程可以发起系统调用，并在内核中与内核线程并发执行。

- *用内核线程实现多线程进程。* 大多数操作系统提供一组库例程和系统调用，让应用程序可以在单个用户级进程内使用多个线程。图 4.12 说明了这种情形。这些线程执行用户代码、访问用户级数据结构；它们也会向操作系统内核发起系统调用，为此需要一个内核中断栈，就像普通的单线程进程一样。

- *用户级线程。* 为了避免每次线程操作都发起系统调用，有些系统支持这样一种模型：用户级的线程操作——创建、让出、汇合、退出，以及第 5 章描述的同步例程——完全在用户级库中实现，不调用内核。

#fig("4.11", "image00394.png", [一个多线程内核，其中有三个内核线程和两个单线程用户级进程。每个内核线程都有自己的线程控制块（TCB）和自己的栈；每个用户进程在用户级有一个用于执行用户代码的栈，在内核中有一个用于执行中断和系统调用的内核中断栈。])

#fig("4.12", "image00395.png", [一个多线程内核，其中有三个内核线程和两个用户级进程，每个进程含两个线程。每个用户级线程都有一个用户级栈，并在内核中有一个用于执行中断和系统调用的中断栈。])

我们先描述最基本情况——内核线程——的实现。4.8 节再说明如何扩展这一模型，以支持用内核线程或用户级库实现的应用程序多线程。

#subsect("4.6.1", "创建线程")

#code(num: "4.13", cap: [创建线程的伪代码。初始化栈的具体做法，以及向初始函数传递参数的约定，都与机器相关。在 Intel x86 体系结构上，栈从高地址开始向下增长，参数通过栈传递；在其他系统上，栈可能向上增长，参数也可能通过寄存器传递。图 4.14 给出了 `thread_dummySwitchFrame` 的伪代码。], lang: "c")[
```c
 // func is a pointer to a procedure the thread will run.
 // arg is the argument to be passed to that procedure.
 void
 thread_create(thread_t *thread, void (*func)(int), int arg) {
     // Allocate TCB and stack
     TCB *tcb = new TCB();

     thread->tcb = tcb;
     tcb->stack_size = INITIAL_STACK_SIZE;
     tcb->stack = new Stack(INITIAL_STACK_SIZE);

     // Initialize registers so that when thread is resumed, it will start running at
     // stub.  The stack starts at the top of the allocated region and grows down.
     tcb->sp = tcb->stack + INITIAL_STACK_SIZE;
     tcb->pc = stub;

     // Create a stack frame by pushing stub’s arguments and start address
     // onto the stack: func, arg
     *(tcb->sp) = arg;
     tcb->sp--;
     *(tcb->sp) = func;
     tcb->sp--;

     // Create another stack frame so that thread_switch works correctly.
     // This routine is explained later in the chapter.
     thread_dummySwitchFrame(tcb);

     tcb->state = READY;
     readyList.add(tcb);    // Put tcb on ready list
 }

 void
 stub(void (*func)(int), int arg) {
     (*func)(arg);           // Execute the function func()
     thread_exit(0);         // If func() does not call exit,  call it here.
 }
```
]

图 4.13 给出了分配新线程的伪代码。`thread_create` 的目标是发起一次异步过程调用：以 `arg` 为实参调用 `func`。当该线程运行时，它将与调用线程并发地执行 `func(arg)`。

创建一个线程分三步：

+ *分配每线程状态。* 线程构造函数的第一步，是为该线程的每线程状态分配空间，即 TCB 和栈。前面已经提到，TCB 是线程系统用来管理线程的数据结构；栈是一块内存区域，用来存放与正在执行的过程有关的数据，它像其他数据结构一样在内存中分配。

+ *初始化每线程状态。* 为了初始化 TCB，线程构造函数把新线程的寄存器设置为线程开始 RUNNING 时所需的值。当我们为该线程分配处理器时，希望它开始运行 `func(arg)`。不过，构造函数并不让线程从 `func` 开始，而是让它从一个哑函数 `stub` 开始，再由 `stub` 调用 `func`。之所以要多这一层，是因为 `func` 过程可能直接返回而不调用 `thread_exit`。没有 `stub` 的话，`func` 就会返回到栈顶存放的那个随机位置去！有了 `stub`，`func` 返回到 `stub`，再由 `stub` 调用 `thread_exit` 结束该线程。为了让线程从 `stub` 的开头开始运行，线程构造函数把栈布置成“`stub` 刚刚被普通代码调用”的样子；具体做法取决于机器的调用约定。在伪代码中，我们把 `stub` 的两个参数 `func` 和 `arg` 压入栈。线程开始运行时，`stub` 中的代码就会像普通过程那样访问自己的参数。此外，我们还在栈上压入一个供 `thread_switch` 使用的哑栈帧；这一细节留到讨论线程切换的实现时再解释。

+ *把 TCB 放入就绪队列。* 创建线程的最后一步，是把线程状态置为 READY，并把新的 TCB 放入就绪队列，使该线程可以被调度。

#subsect("4.6.2", "删除线程")

当线程调用 `thread_exit` 时，删除线程分两步进行：

- 把线程从就绪队列中移除，使它再也不会运行。

- 释放为该线程分配的每线程状态。

这看起来很简单，却有一个重要的微妙之处：如果线程把自己从就绪队列中移除，并释放自己的每线程状态，程序就可能出错。举例来说，如果线程把自己从就绪队列中移除，但在它完成状态释放之前发生了一次中断，就会造成内存泄漏：该线程再也不会被恢复运行，它的状态也就永远不会被释放。

更糟的是，假设线程释放的是自己的状态，会怎样？如果没有栈，该线程还能把 `thread_exit` 中的代码执行完吗？如果正在运行的线程的栈刚被释放就发生中断，又会怎样？如果上下文切换代码试图保存当前线程的状态，它就会写入已被释放的内存，甚至可能写入另一个处理器重新分配给其他数据结构的存储区。结果可能是内存被破坏，而具体表现取决于事件的确切顺序。不用说，这样的缺陷极难定位。

幸运的是，有一个简单的解决办法：线程永远不删除自己的状态，而由别的线程来删除。退出时，线程转入 FINISHED 状态，把它的 TCB 从就绪队列移到_已完成_（finished）线程的链表上，调度器永远不会运行这个链表上的线程。随后该线程可以安全地切换到就绪队列中的下一个线程。一旦已完成的线程不再运行，再由_另一个_线程释放它的状态就是安全的。

#subsect("4.6.3", "线程上下文切换")

为了支持多个线程，我们还需要一种机制，来切换哪些线程处于 RUNNING、哪些处于 READY。

_线程上下文切换_（thread context switch）挂起当前正在运行的线程，恢复另一个线程的执行。切换时，它把当前线程的寄存器保存到该线程的 TCB 和栈中，再把新线程的寄存器从它的 TCB 和栈恢复到处理器中。

我们需要回答几个问题：

- 什么会触发上下文切换？

- 自愿的上下文切换（例如调用 `thread_yield`）是如何工作的？

- 非自愿的上下文切换与自愿的切换有何不同？

- 调度器接下来应当选择哪个线程运行？

我们依次讨论这些问题，但把最后一个留到第 7 章。本章讨论的_机制_（mechanism），无论调度器在选择线程时采用何种_策略_（policy），都能工作。

#aside("机制与策略分离")[
把机制与策略分离，是操作系统设计中一条有用且被广泛采用的原则。当机制与策略被干净地分开时，就更容易引入新的策略，使系统针对新的负载或新的技术得到优化。

例如，线程上下文切换这一抽象就把机制（如何在线程之间切换）与策略（运行哪个线程）干净地分开了，因此无论采用什么策略，机制都能工作。有的系统可以选择简单的做法（例如先进先出调度）；另一些系统则可以针对自己的目标优化调度（例如用周期性的调度器为媒体设备平滑地运行实时多媒体流，用轮转调度器为服务器兼顾响应时间与吞吐量，或者用优先级调度器把大部分资源都投入到智能手机上那个可见的应用）。

我们将在本书中多次看到这一原则。例如，线程同步机制无论采用何种调度策略都能工作；用于定位文件块的文件元数据机制，无论采用何种策略决定文件块在磁盘上的放置位置都能工作；用于把虚拟地址映射为物理地址的页转换机制，无论操作系统为各个进程分配哪些物理页都能工作。
]

*什么会触发内核线程的上下文切换？* 线程上下文切换可以由自愿的线程库调用触发，也可以由非自愿的中断或处理器异常触发。

- *自愿的。* 线程可以调用某个会触发上下文切换的线程库函数。例如，大多数线程库提供 `thread_yield` 调用，让当前运行的线程自愿把处理器让给就绪队列中的下一个线程。同样，`thread_join` 和 `thread_exit` 调用会挂起当前线程的执行，转而运行另一个线程。

- *非自愿的。* _中断_或_处理器异常_可能调用中断处理程序。中断硬件保存正在运行的线程的状态，并执行处理程序的代码。处理程序可以判定应当运行另一个线程，然后切换到它；反之，如果当前线程应当继续运行，处理程序就恢复被中断线程的状态并继续执行。例如，许多线程系统被设计成保证任何线程都无法独占处理器。为此，它们设置一个硬件定时器，周期性地中断处理器（例如每隔几毫秒）。定时器中断处理程序保存正在运行的线程的状态，选择另一个线程，并把它的状态恢复到处理器中运行。其他 I/O 硬件事件（例如按下键盘按键、网络报文到达、磁盘操作完成）也会调用中断处理程序。在这些情形下，处理程序同样会保存当前运行线程的状态以便稍后恢复，然后执行处理程序的代码；处理完毕后，它要么恢复当前线程的状态，要么切换到新线程。如果该 I/O 事件把一个优先级高于先前运行线程的线程放到了就绪队列上，就会运行这个新线程。

无论哪种情况，线程系统都必须保存当前的处理器状态，使当前线程恢复执行时，_从该线程自己的角度看_，除了时间流逝之外，那个事件仿佛从未发生过。这就提供了“线程在一个速度不可预测且不断变化的虚拟处理器上执行”这一抽象。

为简单起见，我们不希望在执行一次自愿切换的过程中再发生一次非自愿的切换。在两个线程之间切换时，需要暂时推迟中断，直到切换完成，以免造成混乱。处理器提供了用于推迟和重新允许中断的特权指令，下面的实现就利用了它们。

#aside("线程切换时为什么必须关中断？")[
我们对 `thread_yield` 的实现，会把该过程执行期间可能发生的任何中断都推迟到让出操作完成之后。这看起来似乎没有必要：毕竟，即使线程上下文切换被打断，切换的状态也会保存在栈上。最终内核会重新调度该线程、恢复它的状态，并完成这次线程切换。

然而，可能出现一种微妙的不一致。假设一个低优先级线程（例如空闲线程）正要自愿切换到某个高优先级线程。它把高优先级线程从就绪队列中取出，而恰在这一刻发生了一次中断。假设该中断把一个中优先级线程从 WAITING 移到 READY。由于从表面上看处理器仍在运行低优先级线程，中断处理程序就立即切换到新线程。于是高优先级线程陷入了悬置状态！它已经就绪，却要等到低优先级线程被重新调度之后才能运行；而那可能很久之后才会发生。

当然，这种事件顺序不会经常出现，但一旦出现，就很难定位和调试。
]

*自愿的内核线程上下文切换。* 自愿切换比较容易理解，所以我们从这里开始。图 4.14 给出了 Intel x86 硬件体系结构上一个简单的 `thread_yield` 实现的伪代码。线程调用 `thread_yield`，自愿把处理器让给另一个线程。调用线程的寄存器被复制到它的 TCB 和栈中，稍后当调度器选中它时再恢复运行。

#code(num: "4.14", cap: [Intel x86 体系结构上 `thread_switch` 与 `thread_yield` 的伪代码。注意，如果没有其他线程可运行，`thread_yield` 就是一个空操作；否则它保存旧线程的状态并恢复新线程的状态。当旧线程被重新调度时，它从 `thread_switch` 返回，作为运行线程继续执行。], lang: "c")[
```c
 // We enter as oldThread, but we return as newThread.
 // Returns with newThread’s registers and stack.
 void thread_switch(oldThreadTCB, newThreadTCB) {
     pushad;                  // Push general register values onto the old stack.
     oldThreadTCB->sp = %esp; // Save the old thread’s stack pointer.
     %esp = newThreadTCB->sp; // Switch to the new stack.
     popad;            // Pop register values from the new stack.
     return;
 }

 void thread_yield() {
     TCB *chosenTCB, *finishedTCB;

     // Prevent an interrupt from stopping us in the middle of a switch.
     disableInterrupts();

     // Choose another TCB from the ready list.
     chosenTCB = readyList.getNextThread();
     if (chosenTCB == NULL) {
         // Nothing else to run, so go back to running the original thread.
     } else {
         // Move running thread onto the ready list.
         runningThread->state = ready;
         readyList.add(runningThread);
         thread_switch(runningThread, chosenTCB); // Switch to the new thread.
         runningThread->state = running;
     }

     // Delete any threads on the finished list.
     while ((finishedTCB = finishedList->getNextThread()) != NULL) {
         delete finishedTCB->stack;
         delete finishedTCB;
     }
     enableInterrupts();
 }

 // thread_create must put a dummy frame at the top of its stack:
 // the return PC and space for pushad to have stored a copy of the registers.
 // This way, when someone switches to a newly created thread,
 // the last two lines of thread_switch work correctly.
 void thread_dummySwitchFrame(newThread) {
     *(tcb->sp) = stub;      // Return to the beginning of stub.
     tcb->sp--;
     tcb->sp -= SizeOfPopad;
 }
```
]

`thread_yield` 的伪代码首先关中断，以防线程系统同时尝试进行两次上下文切换。接着，伪代码从就绪队列中取出下一个要运行的线程（如果有），并切换到这个线程。

`thread_switch` 的代码看起来可能有点绕，因为它是在旧线程的上下文中被调用，却在新线程的上下文中结束。为了做到这一点，`thread_switch` 把寄存器的状态保存到栈上，并把栈指针保存到 TCB；然后它切换到新线程的栈，从新栈恢复新线程的状态，并返回到新栈上保存的程序计数器所指的地方。

一个蹊跷之处在于，返回位置可能并不是 `thread_yield`！返回的是新线程先前正在做的事情。例如，新线程可能一直在 `thread_join` 中处于 WAITING，现在变成 READY 可以运行了；它可能调用过 `thread_yield`；也可能是一个刚刚开始运行的新创建线程。

关键的一点是：任何导致线程让出或阻塞的例程，都必须以同样的方式调用 `thread_switch`。同样，为了创建新线程，`thread_create` 必须把新线程的栈布置成仿佛它刚好在执行第一条指令之前被挂起。这样，如果新创建的线程是下一个要运行的线程，那么线程就可以调用 `thread_yield`、切换到新创建的线程、切换到它的栈指针、从栈上弹出寄存器值，并“返回”到新线程——尽管新线程从头到尾都没有调用过 `switch`。

#example[
假设两个线程各自循环，每次迭代都调用 `thread_yield`。

#code(lang: "c")[
```c
    go() {
        while(1) {
            thread_yield();
        }
    }
```
]

从物理处理器以及从每个线程的角度看，这一过程的步骤序列是怎样的？
]

#answer[
从处理器的角度看，一条指令接着一条指令，只不过现在来自不同线程的指令交错在一起（既然它们被多路复用，就必然如此）。

*图 4.15 给出了这种交错：* `thread_yield` 由一个线程调用，却在另一个线程中返回。`thread_yield` 通过操纵栈和程序计数器来在线程之间切换，有意违背了编译器通常遵循的过程调用约定。

然而，线程本身可以忽略这种复杂性。从它们的角度看，每个线程都在自己的（速度可变的）虚拟处理器上运行这个循环。□
]

#tbl("4.15", [两个线程循环调用 `thread_yield()` 时指令的交错], (
  (table.cell(colspan: 3)[#text(weight: "bold", fill: accent)[逻辑视图]],),
  ([*线程 1*], [*线程 2*], []),
  ([`go(){`], [`go(){`], []),
  ([`while(1){`], [`while(1){`], []),
  ([`thread_yield();`], [`thread_yield();`], []),
  ([`}`], [`}`], []),
  ([`}`], [`}`], []),
  (table.cell(colspan: 3)[#text(weight: "bold", fill: accent)[物理现实]],),
  ([*线程 1 的指令*], [*线程 2 的指令*], [*处理器的指令*]),
  ([从 `thread_switch` “返回”], [], [从 `thread_switch` “返回”]),
  ([进入 `stub`], [], [进入 `stub`]),
  ([调用 `go`], [], [调用 `go`]),
  ([调用 `thread_yield`], [], [调用 `thread_yield`]),
  ([选择另一个线程], [], [选择另一个线程]),
  ([调用 `thread_switch`], [], [调用 `thread_switch`]),
  ([把线程 1 的状态保存到 TCB], [], [把线程 1 的状态保存到 TCB]),
  ([装入线程 2 的状态], [], [装入线程 2 的状态]),
  ([], [从 `thread_switch` “返回”], [从 `thread_switch` “返回”]),
  ([], [进入 `stub`], [进入 `stub`]),
  ([], [调用 `go`], [调用 `go`]),
  ([], [调用 `thread_yield`], [调用 `thread_yield`]),
  ([], [选择另一个线程], [选择另一个线程]),
  ([], [调用 `thread_switch`], [调用 `thread_switch`]),
  ([], [把线程 2 的状态保存到 TCB], [把线程 2 的状态保存到 TCB]),
  ([], [装入线程 1 的状态], [装入线程 1 的状态]),
  ([从 `thread_switch` 返回], [], [从 `thread_switch` 返回]),
  ([从 `thread_yield` 返回], [], [从 `thread_yield` 返回]),
  ([调用 `thread_yield`], [], [调用 `thread_yield`]),
  ([选择另一个线程], [], [选择另一个线程]),
  ([调用 `thread_switch`], [], [调用 `thread_switch`]),
  ([把线程 1 的状态保存到 TCB], [], [把线程 1 的状态保存到 TCB]),
  ([装入线程 2 的状态], [], [装入线程 2 的状态]),
  ([], [从 `thread_switch` 返回], [从 `thread_switch` 返回]),
  ([], [从 `thread_yield` 返回], [从 `thread_yield` 返回]),
  ([], [调用 `thread_yield`], [调用 `thread_yield`]),
  ([], [选择另一个线程], [选择另一个线程]),
  ([], [调用 `thread_switch`], [调用 `thread_switch`]),
  ([], [把线程 2 的状态保存到 TCB], [把线程 2 的状态保存到 TCB]),
  ([], [装入线程 1 的状态], [装入线程 1 的状态]),
  ([从 `thread_switch` 返回], [], [从 `thread_switch` 返回]),
  ([从 `thread_yield` 返回], [], [从 `thread_yield` 返回]),
  ([……], [……], [……]),
), columns: (1fr, 1fr, 1.15fr))

#aside("零线程内核")[
内核既可以是单线程的，也可以是多线程的；实际上，内核还可以完全没有自己的线程——也就是零线程内核！事实上，这种设计曾经相当常见 [107]。

回想第 2 章描述的那种简单的操作系统图景。一旦系统完成引导、初始化了设备驱动程序，并启动了若干用户级进程（例如登录 shell），内核所做的其他一切就都是事件驱动的，即都是为响应中断、处理器异常或系统调用而做的。

在这样一个简单的操作系统中，不需要用“内核线程”或“内核线程控制块”来跟踪正在进行中的计算。相反，当发生中断、陷入或异常时，栈指针被置为中断栈的基址，指令指针被置为处理程序的地址。接着处理程序开始执行，并要么立即返回到被中断的用户级进程，要么挂起该用户级进程并“返回”到另一个用户级进程。无论哪种情况，下一个事件（中断、处理器异常或系统调用）都会让这一过程重新开始。
]

*非自愿的内核线程上下文切换。* 第 2 章解释了当中断、异常或陷入打断正在运行的用户级进程时会发生什么：硬件与软件协同工作，保存被中断进程的状态、运行内核的处理程序，然后恢复被中断进程的状态。

当中断或陷入引发内核中两个线程之间的切换时，机制几乎完全相同。第 2 章描述的三个步骤略有修改（_改动之处以斜体标出_）：

+ *保存状态。* 保存当前正在运行的_线程_的寄存器，使处理程序能够运行代码而不干扰被中断的_线程_。中断或异常发生时，硬件保存一部分状态；处理程序运行时，软件保存其余状态。

+ *运行内核的处理程序。* 运行内核的处理程序代码，处理中断或异常。_由于我们已经处于内核态，这一步不需要从用户态切换到内核态。我们也不需要把栈指针改为内核中断栈的基址，而只需从当前栈指针开始，把保存的状态或处理程序的变量压入当前栈。_

+ *恢复状态。* 恢复_下一个就绪线程_的寄存器，使该线程能够从上次离开的地方继续运行。

简而言之，把内核线程之间的切换与用户态下发生的一次转移相比：(1) 不需要切换模式（因而也不需要切换栈）；(2) 处理程序可以恢复就绪队列上的任意线程，而不必总是恢复刚刚被挂起的那个线程或进程。

*实现细节。* 在大多数处理器体系结构上，从中断处理程序内部切换到下一个线程，有一种简单（但低效）的办法：在处理程序返回之前调用 `thread_switch`。正如我们已经看到的，`thread_switch` 保存当前线程（也就是中断处理程序）的状态，并切换到新的内核线程。当原来的线程恢复运行时，它会从 `thread_switch` 返回，随即从栈上弹出中断上下文，在被中断的位置继续执行。

大多数系统（例如 Linux）会做一点小优化，以提高中断处理的性能。被中断线程的状态其实已经保存在栈上，只不过采用的是中断硬件规定的格式。如果我们修改 `thread_switch`，让它完全按照中断硬件的方式保存和恢复寄存器，那么从中断返回与恢复一个线程就成了同一个动作：两者都是从栈上弹出中断帧，以恢复下一个要运行的线程。

例如，为了与 x86 的中断硬件兼容，`thread_switch` 的软件实现会模拟硬件的情形：在调用 `pushad` 保存通用寄存器之前，先保存返回的指令指针和 eflags 寄存器。切换到新栈之后，它调用 `iret` 来恢复新线程——无论新线程是被硬件事件挂起的，还是被软件调用挂起的。
