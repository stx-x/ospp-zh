#import "../template.typ": *

#sect("5.3", "锁：互斥")

*锁*（lock）是一种同步变量，它提供*互斥*（mutual exclusion）——当一个线程持有某把锁时，其他任何线程都不能持有它（也就是说，其他线程被*排斥*在外）。程序把每把锁与共享状态中的某个子集关联起来，并要求线程在访问这部分状态时必须持有这把锁。于是，同一时刻只有一个线程能够访问该共享状态。

互斥极大地简化了对程序的推理，因为一个线程可以在持有锁的期间执行任意一组操作，而在其他线程看来，这些操作*是原子的*。特别地，由于锁强制实施互斥、线程必须持有锁才能访问共享状态，其他线程不可能观察到中间状态；它们只能观察到锁被释放之后留下的状态。

#example[
*加锁以把多个操作归为一组。* 例如，考虑一个银行账户对象，它包含一个交易列表和一个总余额。要添加一笔新交易，我们先获取该账户的锁，把新交易追加到列表，读取旧余额，修改它，写回新余额，然后释放锁。要查询余额和最近的交易列表，我们先获取该账户的锁，从列表中读取最近的交易，读取余额，然后释放锁。这样使用锁，可以保证一次更新或查询在下一项开始之前完成；每次查询看到的始终是完整的最近交易集合。

归组的另一个例子是打印输出。如果没有锁，两个线程同时调用 `printf` 时，两条消息中的单个字符可能彼此交错，把意思弄得含混不清。因此，在现代多线程操作系统上，`printf` 会使用一把锁，确保每条消息中的那组字符作为一个整体打印出来。
]

推理原子操作组之间的交错，比推理单个操作之间的交错要容易得多，原因有两点。第一，（显然）需要考虑的交错更少——在更粗的粒度上推理交错，可以减少需要考虑的情况数量本身。第二点，也是更重要的一点：我们可以让每个原子操作组对应程序的逻辑结构，从而针对*不变式*（invariant）而不是具体的*交错*进行推理。

具体来说，共享对象通常只用一把锁保护对象的全部状态：每个公有方法在入口处获取锁，在出口处释放锁。于是，推理共享类的代码与推理传统类的代码十分相似：我们假定在某个公有方法被调用时有一组不变式成立，并在该公有方法返回之前重新确立这些不变式。只要不变式定义得当，我们就可以独立地推理每个方法。

#subsect("5.3.1", "锁：API 与性质")

锁通过提供两个方法来实现互斥：`Lock::acquire()` 与 `Lock::release()`。这两个方法定义如下：

- 锁可以处于两种状态之一：BUSY 或 FREE。

- 锁最初处于 FREE 状态。

- `Lock::acquire` 会一直等到锁变为 FREE，然后原子地把锁置为 BUSY。检查状态是否为 FREE 与把状态置为 BUSY，合起来是一个*原子操作*。即使多个线程同时尝试获取这把锁，也至多只有一个线程会成功：一个线程观察到锁是 FREE 并把它置为 BUSY，其他线程只会看到锁是 BUSY，然后等待。

- `Lock::release` 把锁置为 FREE。如果有正在等待的 `acquire` 操作，这一状态变化会使其中之一得以继续。

我们将在 5.7 节描述如何实现具有这些性质的锁。有了锁，解决牛奶买多了问题就变得轻而易举：两个线程都运行下面的代码：

#code(lang: "c")[
```c
    lock.acquire();
    if (milk == 0) {     // if no milk
        milk++;          // buy milk
    }
    lock.release();
```
]

#example[
操作系统内核中的许多例程都需要分配和释放内存块。假设已经给出了单线程内核内存分配器的代码，请说明如何实现一个线程安全的内存分配器。
]

#answer[
以 C 的 `malloc` 和 `free` 为例，只要在访问堆之前获取一把锁，在内存块分配或释放完成之后释放该锁，就能把它们改造成线程安全的。由于 `malloc` 与 `free` 读写的是同一批数据结构，两个过程中必须使用*同一把*锁，即 `heaplock`。

#code(lang: "c")[
```c
 char *malloc (int n) {
     char *p;

     heaplock.acquire();
  // Code for single-threaded malloc()
  // p = allocate block of memory
  //     of size n.
     heaplock.release();
     return p;
 }

 void free (char *p) {

     heaplock.acquire();
  // Code for single-threaded free()
  // Put p back on free list.

     heaplock.release();

 }
```
]

□
]

*形式化性质。* 锁可以更精确地定义如下。如果某个线程从某把锁的 `acquire` 方法返回的次数，多于它从该锁的 `release` 方法返回的次数，我们就说该线程*持有这把锁*。如果某个线程已经调用了某把锁的 `acquire`，但尚未从这次调用返回，我们就说它*正在尝试获取*这把锁。

一把锁应当保证以下三条性质：

+ *互斥。* 至多只有一个线程持有该锁。

+ *进展性。* 如果没有线程持有该锁，而又有线程尝试获取它，那么最终会有某个线程成功获取到该锁。

+ *有界等待。* 如果线程 T 尝试获取某把锁，那么在其他线程成功获取该锁的次数上存在一个界，即在 T 成功之前，其他线程至多能成功获取该锁这么多次。

互斥是一条*安全性*（safety）性质，因为锁阻止一个以上的线程同时访问共享状态。

进展性与有界等待则是*活性*（liveness）性质。如果一把锁处于 FREE 状态，就必须有*某个*线程能够获取它；进一步说，任何*特定的*想要获取该锁的线程，最终都必须成功地获取到它。

这些定义听起来也许过于生硬，那是因为我们精心推敲过措辞，以避免引入微妙的边界情形。例如，如果持有锁的线程永不释放它，其他线程就无法取得进展，所以我们用成功的 `acquire` 操作来定义*有界等待*条件。

*警告：非性质——线程顺序。* 上面定义的*有界等待*性质保证一个线程最终会得到获取锁的机会，但它并不承诺等待中的线程按先进先出（FIFO）的顺序获取锁。你会遇到的大多数锁实现——例如 POSIX 线程中的锁——都不提供 FIFO 顺序。

#subsect("5.3.2", "案例研究：线程安全的有界队列")

与标准的面向对象编程一样，每个共享对象都是某个类的一个实例，该类定义了类的状态以及作用于这些状态的方法。

类的状态既包括状态变量（例如整数、浮点数、字符串、数组和指针），也包括同步变量（例如锁）。类的构造函数每产生一个共享对象的实例，都会分配一把新锁，以及由该锁保护的状态变量的新实例。

*有界队列*（bounded queue）是一种对所能存放的元素数量设定了固定上限的队列。操作系统内核用有界队列来管理进程间通信、TCP 与 UDP 套接字以及 I/O 请求。由于内核运行在有限的物理内存中，内核必须设计成在有限资源下也能正常工作。例如，内核不会在生产者和消费者线程之间使用一个简单的、无限的缓冲区，而是使用大小有限的缓冲区，也就是有界队列。

*线程安全的有界队列*是可以在多个并发线程中安全调用的一种有界队列。图 5.3 给出了一种实现，它允许任意多个线程安全地向队列插入元素或从队列删除元素。如图 5.4 所示，一个程序可以分配多个这样的队列（例如 `queue1`、`queue2` 和 `queue3`），每个队列都包含自己的锁和状态变量。

#code(num: "5.3", cap: [线程安全的有界队列。为便于实现，我们假定队列存放的是整数（而不是任意对象），并且存放的元素总数不大。], lang: "c")[
```c
 // Thread-safe queue interface

 const int MAX = 10;

 class TSQueue {
   // Synchronization variables
     Lock lock;

   // State variables
     int items[MAX];
     int front;
     int nextEmpty;

   public:
     TSQueue();
     ~TSQueue(){};
     bool tryInsert(int item);
     bool tryRemove(int *item);
 };

 // Initialize the queue to empty
 // and the lock to free.
 TSQueue::TSQueue() {
     front = nextEmpty = 0;
 }

 // Try to insert an item. If the queue is
 // full, return false; otherwise return true.
 bool
 TSQueue::tryInsert(int item) {
     bool success = false;

     lock.acquire();
     if ((nextEmpty - front) < MAX) {
         items[nextEmpty % MAX] = item;
         nextEmpty++;
         success = true;
     }
     lock.release();
     return success;
 }

 // Try to remove an item. If the queue is
 // empty, return false; otherwise return true.
 bool
 TSQueue::tryRemove(int *item) {
     bool success = false;

     lock.acquire();
     if (front < nextEmpty) {
         *item = items[front % MAX];
         front++;
         success = true;
     }
     lock.release();
     return success;
 }
```
]

#fig("5.4", "image00402.png", [三个共享对象，每个都是 TSQueue 类的一个实例。])

队列只存放固定数量 MAX 个元素。队列满时，插入请求返回错误；同样，队列空时，删除请求返回错误。5.4 节将说明*条件变量*如何让调用线程*等待*，而不是返回错误：插入时，线程一直等到队列中有空间存放该元素；删除时，线程一直等到队列中至少有一个元素可返回。

TSQueue 的实现定义了一个环形队列，数据存放在固定大小的数组 `items[MAX]` 中。状态变量 `front` 是队列中下一个将被删除的元素（如果有的话）；`nextEmpty` 是下一个新元素的位置（如果有的话）。为了让例子尽可能简单，队列中只能存放和取出 `int` 类型的元素，并且我们假定累计存放的元素总数可以用 64 位整数表示。

所有这些变量都与该对象的单线程版本完全一样。锁使得 `tryInsert` 与 `tryRemove` 能像单线程版本那样，原子地读写多个变量。

#example[
在刚获取锁的那一刻，TSQueue 满足哪些约束？在释放锁之前的那一刻，又有哪些约束成立？
]

#answer[
由于锁强制实施互斥，而且线程修改状态变量时总是持有锁，所以在获取锁的那一刻，对象的状态变量必然处于以下两种情形之一：(i) 初始状态，或 (ii) 前一个线程释放锁时留下的状态。这些约束与使用有界队列的单线程代码完全相同：

- 曾经插入队列的元素总数为 `nextEmpty`。

- 曾经从队列删除的元素总数为 `front`。

- `front <= nextEmpty`

- 队列中当前的元素个数为 `nextEmpty - front`。

- `nextEmpty - front <= MAX`

锁的持有者在释放锁之前，总会重新确立这些约束。□
]

#example[
如果不持有锁，这些约束还成立吗？
]

#answer[
*不成立。* 直觉上似乎可以认为：如果这些约束在释放锁之前的那一刻成立，那么它们在释放锁之后的那一刻也必定成立。然而事实并非如此。在这段时间里，别的某个线程可能已经获取了锁，并且正在修改状态变量。一般说来，如果不持有锁，关于对象的状态变量就*什么都*不能说。□
]

#subsubsect("临界区")

*临界区*（critical section）是一段原子地访问共享状态的代码。只要保证线程在执行任何临界区时持有该对象的锁，就能保证每个临界区看起来都是原子地作用于其共享状态。`tryInsert` 与 `tryRemove` 两个方法中各有一个临界区。

有两点值得注意：

- 每个类都可以定义多个作用于该类所定义共享状态的方法，因此*每个类可以有多个临界区*。不过，对于类的每个实例（也就是每个对象），同一时刻只有一个线程持有该对象的锁，所以*对每个共享对象实例，同一时刻只有一个线程真正执行其中的临界区。* 对 TSQueue 类而言，如果一个线程调用 `queue1.tryInsert`，另一个线程调用 `queue1.tryRemove`，那么插入要么发生在删除之前，要么反过来。

- 一个程序可以创建*类的多个实例*。每个实例都是一个共享对象，而每个共享对象都有自己的锁。因此，不同的线程可能同时活跃在不同共享对象实例的临界区中。对 TSQueue 类而言，如果一个线程调用 `queue1.tryInsert`，另一个线程调用 `queue2.tryRemove`，第三个线程调用 `queue3.tryInsert`，那么这三个线程可能同时执行着作用于 TSQueue 类*不同实例*的临界区代码。

#subsubsect("使用共享对象")

共享对象的分配方式与其他对象相同：可以用 `malloc` 和 `new` 从堆上动态分配，也可以在程序中声明静态变量，把它们静态地分配在全局内存中。

多个线程必须能够访问共享对象。如果共享对象是全局变量，那么线程代码可以用对象的全局名字来引用它，编译器会算出相应的地址。如果共享对象是动态分配的，那么每个使用该对象的线程都需要一个指向它的指针或引用。

把指向共享对象的指针交给线程，有两种常见做法：(1) 在创建线程时把指向该共享对象的指针传给线程；(2) 把共享对象的引用存放在其他共享对象（例如容器）中。例如，程序可以有一个全局的、共享的（而且是同步的！）哈希表，线程用它来存放和取回指向其他共享对象的引用。

图 5.5 展示了一个简单的程序：它创建三个队列，然后创建若干线程向这些队列插入元素；接着从每个队列删除 20 个元素，并打印删除得到的值。初始的主线程用 `new` 在堆上分配这些共享队列，并给每个工作线程一个指向其中一个共享队列的指针。

#code(num: "5.5", cap: [这段代码创建三个 TSQueue 对象，然后向这些队列添加和删除一些元素。我们使用 `thread_create_p` 而不是 `thread_create`，以便把指向应当使用的队列的指针传给新创建的线程。], lang: "c")[
```c
 // TSQueueMain.cc
 //   Test code for TSQueue.

 int main(int argc, char **argv) {
     TSQueue *queues[3];
     sthread_t workers[3];
     int i, j;

     // Start worker threads to insert.
     for (i = 0; i < 3; i++) {
         queues[i] = new TSQueue();
         thread_create_p(&workers[i],
                    putSome, queues[i]);
     }

     // Wait for some items to be put.
     thread_join(workers[0]);

     // Remove 20 items from each queue.
     for (i = 0; i < 3; i++) {
         printf("Queue %d:\n", i);
         testRemoval(&queues[i]);
     }
 }

 // Insert 50 items into a queue.
 void *putSome(void *p) {
     TSQueue *queue = (TSQueue *)p;
     int i;

     for (i = 0; i < 50; i++) {
         queue->tryInsert(i);
     }
     return NULL;
 }

 // Remove 20 items from a queue.
 void testRemoval(TSQueue *queue) {
     int i, item;

     for (i = 0; i < 20; j++) {
         if (queue->tryRemove(&item))
           printf("Removed %d\n", item);
         else
           printf("Nothing there.\n");
         }
     }
 }
```
]

*警告：把共享对象放在堆上，而不是栈上。* 虽然没有什么能阻止你把共享对象写成过程或方法中的自动变量，但你不应当写这样的程序。在过程调用期间，编译器把自动变量（有时被称为“局部变量”，这个叫法很有道理）分配在栈上。如果一个线程把指向自己某个自动变量的指针或引用传给另一个线程，随后又从分配该自动变量的过程返回，那么第二个线程手中的指针就指向第一个线程栈上的某块区域，而这块区域可能已被挪作他用。为了防止这种错误，少数带垃圾回收的语言（例如 Google 的 Go）会在自动数据可能被过程之外的代码引用时，自动把所有自动数据改为在堆上分配。

你也许想争辩说：对某个特定的程序而言，你知道在该过程与之共享某个对象的所有线程用完这个对象之前，该过程绝不会返回，因此共享该过程的某个局部变量是安全的。这种说法的问题在于，代码会随时间演变，从而引入一个危险而隐蔽的缺陷。在跨线程共享动态分配的变量时，最好养成这样的习惯：只共享来自堆的变量——绝不共享来自栈的变量。
