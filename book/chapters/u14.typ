#import "../template.typ": *

#sect("5.6", "三个案例研究")

学习如何编写并发程序，最好的办法就是动手实践。多线程编程是一项重要技能，我们预计，几乎每一位读这本书的人迟早都要编写许多多线程程序。为了帮助你起步，本节将逐一讲解几个例子。

#subsect("5.6.1", "读写锁")

首先，我们实现一个_读写锁_（readers/writers lock）。与普通的互斥锁一样，读写锁（RWLock）保护共享数据。不过，它做了如下优化：为了获得最高的性能，RWLock 允许多个“读者”线程同时访问共享数据。只要没有线程在修改数据，任意多个线程都可以安全地同时读取共享数据。然而，在任一时刻只允许一个“写者”线程持有 RWLock。（“读者”线程只能读取，而“写者”线程既可以读_也可以_写数据结构。）当写者线程持有 RWLock 时，它可以安全地修改数据，因为该锁保证没有其他线程（无论读者还是写者）能同时持有这把锁。因此，互斥存在于任意写者与任意其他写者之间，也存在于任意写者与_读者集合_之间。

#aside("为常见情形做优化")[
读写锁是计算机系统设计中的一条重要原则的实例：为常见情形做优化。性能优化常常有一个副作用，就是让代码变得更难理解和推理。更复杂的代码更容易出现缺陷，也更容易在添加新功能时引入新的缺陷。那么我们如何判断一项优化是否值得付出这些代价？

一种做法是对代码做性能剖析。然后，_并且只有在那之后_，再去优化那些频繁使用的代码路径。

就锁而言，使用普通的互斥锁显然更简单。只有在下面两个条件同时成立时，才适合把互斥锁换成读写锁：(i) 对互斥锁存在大量争用；(ii) 绝大多数访问都是只读的。换句话说，只有当这种替换能带来显著差别时，才适合使用它。
]

读写锁在数据库中被广泛使用，用来支持更快的数据库搜索查询，同时支持不那么频繁的数据库更新。另一个常见用途是在操作系统内核内部：内核中的核心数据结构常常被许多线程读取，而更新很少发生。

为了把互斥锁推广为读写锁，我们实现一种新的共享对象 RWLock，由它守护对共享数据的访问并强制执行上述规则。RWLock 是用我们标准的同步构件——互斥锁与条件变量——实现的。

想要（原子地）读取共享数据的线程按如下方式执行：

#code(lang: "c")[
```c
rwLock->startRead();
// Read shared data
rwLock->doneRead();
```
]

类似地，想要（原子地）写共享数据的线程执行如下代码：

#code(lang: "c")[
```c
rwLock->startWrite();
// Read and write shared data
rwLock->doneWrite();
```
]

设计 RWLock 类时，我们首先定义它的接口（本例中接口已经定义好了）和它的共享状态。就状态而言，保留足够的数据以便精确刻画对象是有好处的；尤其在调试时，状态多比状态少要好。在这里，对象的行为完全由正在读或写的线程数、以及正在等待读或写的线程数刻画，因此我们选择用四个整数来记录这些值。图 5.9 给出了 RWLock 类的成员与接口。

#code(num: "5.9", cap: [读写锁的接口与成员变量。], lang: "c")[
```c
class RWLock{
  private:
    // Synchronization variables
    Lock lock;
    CV readGo;
    CV writeGo;

    // State variables
    int activeReaders;
    int activeWriters;
    int waitingReaders;
    int waitingWriters;

  public:
    RWLock();
    ~RWLock() {};
    void startRead();
    void doneRead();
    void startWrite();
    void doneWrite();

  private:
    bool readShouldWait();
    bool writeShouldWait();
};
```
]

接着，我们通过追问“方法在什么时候必须等待？”来添加同步变量。首先，我们添加一把互斥锁：只要另一个线程正在访问 RWLock 的状态变量，RWLock 的方法就必须等待。其次，我们注意到 startRead 或 startWrite 可能需要等待，于是为这两种情形各添加一个条件变量：readGo 与 writeGo。

RWLock::doneRead 与 doneWrite 不会等待（获取互斥锁除外）。因此，这两个方法不需要任何额外的条件变量。

现在我们可以实现 RWLock 了。图 5.10 给出完整的解法，我们将分几个简单的步骤把它展开。需要做的许多事情几乎是自动的。

- 由于我们总是在方法的开头与结尾获取/释放互斥锁（从不在中间获取或释放），因此可以在仔细考虑这些方法究竟做什么之前，就先在每个公有方法的开头和结尾写上获取与释放互斥锁的调用。此时，startRead 和 doneRead 是这样的：`void RWLock::startRead() { lock.acquire(); lock.release(); }` `void RWLock::doneRead() { lock.acquire(); lock.release(); }` RWLock::startWrite 与 RWLock::doneWrite 与此类似。

- 由于我们知道 startRead 和 startWrite 可能需要等待，可以在每个方法中间写一个 `while(...){wait(...);}` 循环。事实上，我们可以先插入一个稍后再定义的私有方法作为 while 循环的谓词（例如 readShouldWait 和 writeShouldWait），从而把细节推迟到以后再考虑。此时，startRead 是这样的：`void RWLock::startRead() { lock.acquire(); while (readShouldWait()) { readGo.Wait(&lock); } lock.release(); }` RWLock::StartWrite() 与此类似。

现在事情变得稍微复杂一些。我们可以添加代码来跟踪 activeReaders、activeWriters、waitingReaders 和 waitingWriters。由于我们在所有公有方法中都持有互斥锁，这件事很容易做。例如，一次 startRead 调用最初递增等待读者数；当线程越过 while 循环之后，等待读者数减一，而活动读者数加一。

当读或写结束时，等待中的线程可能变得可以继续。因此我们需要在 doneRead 和 doneWrite 中加入 `signal` 或 `broadcast` 调用。最简单的做法是在每个方法里对 readGo 和 writeGo 都做 `broadcast`，但这既低效，（以我们的口味而言）也不够清楚地表明这个类究竟如何工作。

相反，我们观察到：在 doneRead 中，一次读完成时有两种值得关注的情形：(a) 没有等待中的写，此时无需做任何事，因为这次读不会妨碍其他读继续进行；(b) 有等待中的写，并且这是最后一个活动读者，因此可以让一个写继续进行。在情形 (b) 中，我们使用 `signal`，因为至多只有一个写可以继续，而任何在条件变量上等待的写都可以继续。

startRead 和 doneRead 的代码现在完成了：

#code(lang: "c")[
```c
// Wait until no active or waiting
// writes, then proceed.
void RWLock::startRead() {
    lock.acquire();
    waitingReaders++;
    while (readShouldWait()) {
        readGo.Wait(&lock);
    }
    waitingReaders--;
    activeReaders++;
    lock.release();
}

// Done reading. If no other active
// reads, a write may proceed.
void RWLock::doneRead() {
    lock.acquire();
    activeReaders--;
    if (activeReaders == 0
         && waitingWriters > 0) {
        writeGo.signal();
    }
    lock.release();
}
```
]

startWrite 和 doneWrite 的代码与此类似。对于 doneWrite，如果存在等待中的写，我们就在 writeGo 上 `signal`；否则，我们在 readGo 上 `broadcast`。

最后，我们需要定义 readShouldWait 和 writeShouldWait 这两个谓词。这里我们实现的是一个_写者优先_（writers preferred）的解法：只要有活动的或等待中的写者，读就应当等待；而写只在存在活动读者或活动写者时才等待。否则，源源不断的新读者可能使某个写请求饥饿，使它永远得不到服务。

#code(lang: "c")[
```c
bool
RWLock::readShouldWait() {
  return (activeWriters > 0 || waitingWriters > 0);
}
```
]

writeShouldWait 的代码与此类似。

由于 readShouldWait 和 writeShouldWait 是私有方法，且总是从持有互斥锁的公有方法中调用，它们不需要获取该锁。

图 5.10 给出了完整代码。这个解法也许不合你的口味。你可能会决定使用更多或更少的条件变量，用不同的状态变量实现不同的不变式，或者改变调用 `signal` 或 `broadcast` 的时机。共享对象的做法正是在这些方面给了设计者自由。

#code(num: "5.10", cap: [读写锁的一种实现。], lang: "c")[
```c
// Wait until no active or waiting
// writes, then proceed.
void RWLock::startRead() {
    lock.acquire();
    waitingReaders++;
    while (readShouldWait()) {
        readGo.Wait(&lock);
    }
    waitingReaders--;
    activeReaders++;
    lock.release();
}

// Done reading. If no other active
// reads, a write may proceed.
void RWLock::doneRead() {
    lock.acquire();
    activeReaders--;
    if (activeReaders == 0
         && waitingWriters > 0) {
        writeGo.signal();
    }
    lock.release();
}

// Read waits if any active or waiting
// write ("writers preferred").
bool
RWLock::readShouldWait() {
    return (activeWriters > 0
             || waitingWriters > 0);
}

// Wait until no active read or
// write then proceed.
void RWLock::startWrite() {
    lock.acquire();
    waitingWriters++;
    while (writeShouldWait()) {
        writeGo.Wait(&lock);
    }
    waitingWriters--;
    activeWriters++;
    lock.release();
}

// Done writing. A waiting write or
// read may proceed.
void
RWLock::doneWrite() {
    lock.acquire();
    activeWriters--;
    assert(activeWriters == 0);
    if (waitingWriters > 0) {
        writeGo.signal();
    }
    else {
        readGo.broadcast();
    }
    lock.release();
}

// Write waits for active read or write.
bool
RWLock::writeShouldWait() {
    return (activeWriters > 0
             || activeReaders > 0);
}
```
]

#aside("单步调试与模型检验你的代码")[
假设你写了一些并发代码，想验证这个解法是否如你所愿地工作。有一件事你应当_始终_去做——无论代码是顺序的还是并发的——就是用调试器在各种输入下单步执行代码，验证程序逻辑确实在做你期望它做的事，以及变量确实取了你期望的值。

这对并发程序尤其有用。既然程序必须对任何可能的线程调度都正确，你就可以借助调试器考察线程以不同方式交错时会发生什么。你的程序逻辑是否仍然如你所愿地工作？

例如，对 RWLock 类，你可以：

- 启动一个读者。它会一路走到底吗？显然，它不应当等待，因为没有人持有锁，也没有写者。当它执行完 readDone 之后，状态变量是否回到了初始状态？

- 启动一个写者，并在它获取互斥锁之后启动一个读者。读者会等待这把锁吗？当写者执行完 startWrite 之后，读者会继续，然后等待写者调用 doneWrite 吗？此后读者会继续吗？

- 启动一个读者，接着一个写者，再接着另一个读者。如此等等。

我们鼓励你在本节的例子中都这样做。这些例子足够短，你可以手工执行，不过我们也提供了代码，供你在调试器中尝试。

一种更系统的方法叫作模型检验（model checking）。为了完整验证一个并发程序是否做到了它被设计要做的事，模型检验器会枚举所有可能的操作序列，并逐一尝试。由于即使对一个相当简单的程序，这也会产生几乎无穷多的可能测试，因此为了实用，模型检验必须缩减搜索空间。对于遵循我们准则的代码——用锁保护共享数据——指令的确切顺序不再重要。例如，抢占一个持有锁的线程对程序的行为没有影响。

相反，程序的行为取决于同步指令的序列：哪个线程先获取锁、哪个线程在条件变量上等待，如此等等。因此，模型检验器可以分两步进行：先验证不存在对共享数据的未加锁访问，然后枚举各种同步操作序列。即使如此，可能的组合数目仍可能大到无法承受，所以模型检验器通常会在某个时间限制内尽可能多地验证不同的交错方式。
]

#subsect("5.6.2", "同步屏障")

在数据并行编程中，正如第 4 章所解释的，计算在一个数据集上并行执行，每个线程处理数据的不同分区。当所有线程都完成自己的工作后，它们就可以在算法的下一个（数据并行）步骤中安全地使用彼此的结果。MapReduce 是数据并行编程的一个例子，但还有许多其他结构相同的系统。

为此，我们需要一种高效的方法来检查全部 n 个线程是否都完成了工作。这叫作_同步屏障_（synchronization barrier）。它只有一个操作：`checkin`。线程完成工作后调用 `checkin`；在_所有_ n 个线程都调用过 `checkin` 之前，任何线程都不能从 `checkin` 返回。一旦所有线程都已调用过 `checkin`，就可以安全地使用上一步的结果。

请注意，同步屏障不同于本章前面定义的内存屏障。同步屏障由许多线程并发调用；屏障阻止任何线程继续，直到所有线程都到达屏障。内存屏障由单个线程调用，用来阻止该线程继续，直到屏障之前的所有内存操作都已完成并对其他线程可见。

用同步屏障实现 MapReduce 的代码可能如图 5.11 所示。

#code(num: "5.11", cap: [用同步屏障实现 MapReduce。], lang: "none")[
```
Create n threads.
Create barrier.

Each thread executes map operation in parallel.
barrier.checkin();

Each thread sends data in parallel to reducers.
barrier.checkin();

Each thread executes reduce operation in parallel.
barrier.checkin();
```
]

使用同步屏障的另一种替代方案是在每一步都创建 n 个线程；然后主线程可以对每个线程调用 thread_join 以确保其完成。这样做虽然正确，但可能低效。不仅每一步都要启动 n 个新线程，线程之间的工作划分每次也要重新做。数据并行计算中的每个线程常常可以在许多步骤中反复处理同一份数据，从而最大限度地利用硬件处理器缓存。

我们可以用前面描述读写锁时相同的方法，推导出同步屏障的实现。

- 我们创建一个 Barrier 类，其中有一把锁，用来保护它的内部状态变量：目前有多少线程已经调用过 `checkin`（count），以及我们预期有多少线程（numThreads）。

- 我们在 `checkin` 的开头 `acquire` 锁，在结尾 `release` 锁。

- 由于线程可能要在 `checkin` 中等待，我们需要一个条件变量 allCheckedIn。

- 我们把 `wait` 放在一个 while 循环中，检查是否全部 n 个线程都已调用过 `checkin`。

- 最后一个调用 `checkin` 的线程做一次 `broadcast`，唤醒所有等待者。

图 5.12 给出完整实现。注意，尽管信号意味着线程可以安全地退出 `checkin`，我们仍然使用 while 循环。使用 while 语句没有坏处，而且它能防范运行时库发出虚假唤醒（spurious wakeup）的可能。

#code(num: "5.12", cap: [同步屏障的一个候选实现。在这个实现中，每个屏障实例只能安全地使用一次。], lang: "c")[
```c
// A single use synch barrier.
class Barrier{
  private:
    // Synchronization variables
    Lock lock;
    CV allCheckedIn;

    // State variables
    int numEntered;
    int numThreads;

  public:
    Barrier(int n);
    ~Barrier();
    void checkin();
};

Barrier::Barrier(int n) {
    numEntered = 0;
    numThreads = n;
}

// No one returns until all threads
// have called checkin.
void
checkin() {
    lock.acquire();
    numEntered++;
    if (numEntered < numThreads) {
        while (numEntered < numThreads)
        allCheckedIn.wait(&lock);
    } else { // last thread to checkin
        allCheckedIn.broadcast();
    }
    lock.release();
}
```
]

设计很直接，但问题在于这个屏障只能使用一次。看出这一点的一种方式是：屏障的状态不会恢复到它被创建时所处的状态。实现可重用的屏障要微妙一些。

- _第一个_离开的线程（即唤醒其他线程的那个线程）不能重置状态，因为在其他线程醒来之前，它们还需要这个状态来判断应当退出 while 循环。

- _最后一个_离开屏障的线程也不能为下一轮重置状态，因为这里存在一种可能的竞态条件。假设某个线程在最后一个线程醒来并离开上一个屏障_之前_就完成了 `checkin`，并对下一个屏障调用了 `checkin`。此时，这个线程会发现已经有 n 个线程调用过 `checkin` 了（因为状态尚未被重置），于是它会以为自己“可以继续了！”

实现可重用屏障的一种简单办法是使用两个一次性屏障。第一个屏障确保所有线程都已调用过 `checkin`，第二个屏障确保所有线程都已从 allCheckedIn.wait 中醒来。第 n 个离开的线程可以安全地重置 numCheckedIn；第 n 个调用 `checkin` 的线程可以安全地重置 numLeaving。图 5.13 给出结果。

#code(num: "5.13", cap: [可重用的同步屏障的实现。], lang: "c")[
```c
// A re-usable synch barrier.
class Barrier{
  private:
    // Synchronization variables
    Lock lock;
    CV allCheckedIn;
    CV allLeaving;

    // State variables
    int numEntered;
    int numLeaving;
    int numThreads;

  public:
    Barrier(int n);
    ~Barrier();
    void checkin();
};

Barrier::Barrier(int n) {
    numEntered = 0;
    numLeaving = 0;
    numThreads = n;
}

// No one returns until all threads
// have called checkin.
void
checkin() {
    lock.acquire();
    numEntered++;
    if (numEntered < numThreads) {
        while (numEntered < numThreads)
        allCheckedIn.wait(&lock);
    } else {
    // no threads in allLeaving.wait
        numLeaving = 0;
        allCheckedIn.broadcast();
    }
    numLeaving++;
    if (numLeaving < numThreads) {
        while (numLeaving < numThreads)
        allLeaving.wait(&lock);
    } else {
    // no threads in allCheckedIn.wait
        numEntered = 0;
        allLeaving.broadcast();
    }
    lock.release();
}
```
]

#subsect("5.6.3", "FIFO 阻塞有界队列")

假定条件变量采用 Mesa 语义，我们在图 5.8 中给出的线程安全阻塞有界队列实现并不保证免于饥饿。例如，某个线程可能调用 remove，并因为队列为空而在 while 循环中等待。如果每当另一个线程向队列插入一项时，都有一个_不同的_线程调用 remove、获取锁、发现队列非空，并在等待线程恢复运行之前就把该项取走，那么饥饿就会发生。

通常，饥饿并不是问题。例如，如果我们有一个线程向队列中放入条目，而有 n 个等价的工作线程从队列中取出条目，那么哪个工作线程先执行可能无关紧要。即使饥饿确实是个问题，只要对 insert 和 remove 的调用不频繁，或者缓冲区很少为空或很少为满，每个线程都极有可能取得进展。

然而，假设我们确实需要一个能保证所有线程都有进展的线程安全有界缓冲区。我们可以把这一活性约束更形式化地定义为：

- *免于饥饿。* 如果一个线程在 insert 中等待，那么可以保证在有限次 remove 调用完成之后它能继续运行，反之亦然。

- *先进先出（FIFO）。* 一个更强的约束是队列先进先出，即 FIFO。第 n 个在 remove 中获取锁的线程，取到的是第 n 个在 insert 中获取锁的线程所插入的条目。

在 Hoare 语义下，只要 `signal` 唤醒的是等待最久的线程，图 5.8 中的实现就是 FIFO 的，因而也是免于饥饿的。

这里我们考虑一个相关的问题：能否用 Mesa 语义实现一个免于饥饿的、或者 FIFO 的有界缓冲区？我们需要确保当一个线程向某个等待者发出信号时，由那个正在等待的线程（而不是任何其他线程）来取走条目。

#code(num: "5.14", cap: [用 Mesa 语义实现的 FIFO 阻塞有界缓冲区。ConditionQueue 是由条件变量构成的链表。], lang: "c")[
```c
ConditionQueue insertQueue;
ConditionQueue removeQueue;
int numRemoveCalled = 0; // # of times remove has been called
int numInsertCalled = 0; // # of times insert has been called

int
FIFOBBQ::remove() {
    int item;
    int myPosition;
    CV *myCV, *nextWaiter;

    lock.acquire();

    myPosition = numRemoveCalled++;
    mycv = new CV;  // Create a new condition variable to wait on.
    removeQueue.append(myCV);

// Even if I am woken up, wait until it is my turn.
    while (front < myPosition || front == nextEmpty) {
        mycv->Wait(&lock);
    }

    delete self;    // The condition variable is no longer needed.
    item = items[front % size];
    front++;

// Wake up the next thread waiting in insert, if any.
    nextWaiter = insertQueue.removeFromFront();
    if (nextWaiter != NULL)
        nextWaiter->Signal(&lock);
    lock.release();
    return item;
}
```
]

做到这一点的最简单办法是为每个正在等待的线程创建一个条件变量。这样，你就能精确地决定该唤醒哪个线程！你也许会担心这样做浪费空间，但在现代计算机系统中，一个条件变量（或一把锁）只占 DRAM 的几个字；与每个线程所需的其他存储相比，它很小。

解法的要点如下：

- 为每个等待者创建一个条件变量。

- 按 FIFO 顺序把条件变量放入一个队列。

- 信号唤醒位于队列前端的线程。

- 小心虚假唤醒！

我们在图 5.14 中给出 FIFOBBQ::remove 的一种实现；insert 与此类似。

如果我们希望队列后进先出（LIFO）而不是先进先出，或者希望按某种优先级顺序唤醒线程，这个实现也很容易扩展。而在 Hoare 语义下，这就不那么容易了；我们需要为每种不同的排队规则提供不同的条件变量实现，而不能把这件事留给那少数几种确实在意具体顺序的应用自行处理。
