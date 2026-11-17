---
title: 术语表
---

# 术语表

<div class="glossary-grid">

<div class="gloss-item"><div class="g-head"><span class="g-zh">绝对路径</span><span class="g-en">absolute path</span></div><div class="g-body">相对于根目录解释的文件路径名。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">抽象虚拟机</span><span class="g-en">abstract virtual machine</span></div><div class="g-body">操作系统向其应用程序提供的接口，包括系统调用接口、内存抽象、异常和信号。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">ACID 特性</span><span class="g-en">ACID properties</span></div><div class="g-body">事务属性的助记词：原子性（atomicity）、一致性（consistency）、隔离性（isolation）和持久性（durability）。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">全部获取/全部释放</span><span class="g-en">acquire-all/release-all</span></div><div class="g-body">一种为包含多个操作的请求提供原子性的设计模式。线程在开始处理请求之前获取它可能需要的所有锁，请求完成后再释放这些锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">地址转换</span><span class="g-en">address translation</span></div><div class="g-body">把程序认为自己引用的内存地址转换为内存的物理位置。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">亲和调度</span><span class="g-en">affinity scheduling</span></div><div class="g-body">一种调度策略，优先把任务调度到它此前被分配到的同一个处理器上，以提高缓存复用。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">年磁盘故障率</span><span class="g-en">annual disk failure rate</span></div><div class="g-body">预计每年发生故障的磁盘所占的比例。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">API</span><span class="g-en">API</span></div><div class="g-body">参见：<em>应用程序接口</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">应用程序接口</span><span class="g-en">application programming interface</span></div><div class="g-body">操作系统向应用程序提供的系统调用接口。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁臂</span><span class="g-en">arm</span></div><div class="g-body">使磁盘磁头在盘面上移动的机械装置。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁臂组件</span><span class="g-en">arm assembly</span></div><div class="g-body">一个电机加上一组磁盘臂，用于把磁头定位到盘片的各个表面以读或写。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">到达率</span><span class="g-en">arrival rate</span></div><div class="g-body">任务到达并请求服务的速率。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">异步 I/O</span><span class="g-en">asynchronous I/O</span></div><div class="g-body">一种系统调用的设计模式，使单线程进程可以发起多个并发的 I/O 请求。进程发出 I/O 请求后系统调用立即返回，稍后在 I/O 完成时收到通知。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">异步过程调用</span><span class="g-en">asynchronous procedure call</span></div><div class="g-body">一种过程调用，调用方启动函数后与被调函数并发执行，稍后再等待该函数完成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">原子提交</span><span class="g-en">atomic commit</span></div><div class="g-body">事务提交、把其全部更新付诸实施的那一刻。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">原子内存</span><span class="g-en">atomic memory</span></div><div class="g-body">内存中保存的值是某个处理器最后写入的值，而不是不同处理器更新的混合。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">原子操作</span><span class="g-en">atomic operations</span></div><div class="g-body">不可分割、不能被其他操作交错或拆分的操作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">原子读-改-写指令</span><span class="g-en">atomic read-modify-write instruction</span></div><div class="g-body">处理器特有的一类指令，让一个线程在指令执行期间独占且原子地访问某个内存位置。典型情况下，指令（原子地）读出内存位置的值，对它做某种简单的算术运算，再把结果写回。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">属性记录</span><span class="g-en">attribute record</span></div><div class="g-body">在 NTFS 中，一种可变长的数据结构，其中存放文件数据或文件元数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">可用性</span><span class="g-en">availability</span></div><div class="g-body">系统可用的时间所占的百分比。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">平均寻道时间</span><span class="g-en">average seek time</span></div><div class="g-body">在磁盘上任意一对磁道之间寻道的平均时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">AVM</span><span class="g-en">AVM</span></div><div class="g-body">参见：<em>抽象虚拟机</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">备份</span><span class="g-en">backup</span></div><div class="g-body">系统主存储的、在逻辑上或物理上独立的副本。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">基址-界限内存保护</span><span class="g-en">base and bound memory protection</span></div><div class="g-body">一种早期的内存保护方案，每个进程被限制在特定的物理内存范围内。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">批处理操作系统</span><span class="g-en">batch operating system</span></div><div class="g-body">一种早期操作系统，高效地运行任务队列：一个程序运行时，另一个程序正被装入内存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">浴盆模型</span><span class="g-en">bathtub model</span></div><div class="g-body">一种结合设备初期失效与磨损的磁盘设备故障模型。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">贝拉迪异常</span><span class="g-en">Belady's anomaly</span></div><div class="g-body">对某些缓存替换策略和某些访问模式，增大缓存反而会降低缓存命中率。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最佳适配</span><span class="g-en">best fit</span></div><div class="g-body">一种存储分配策略，把新分配的文件放入足以容纳它的最小空闲区域。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">BIOS</span><span class="g-en">BIOS</span></div><div class="g-body">启动 Intel x86 计算机时最先运行的代码；Basic Input/Output System 的缩写。另见：<em>Boot ROM</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">误码率</span><span class="g-en">bit error rate</span></div><div class="g-body">不可恢复的读错误率。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">位图</span><span class="g-en">bitmap</span></div><div class="g-body">一种用于块分配的数据结构，每个块用一位表示。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">块设备</span><span class="g-en">block device</span></div><div class="g-body">以固定大小的块为单位读写数据的 I/O 设备。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">块组</span><span class="g-en">block group</span></div><div class="g-body">一组相邻的磁盘磁道。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">块完整性元数据</span><span class="g-en">block integrity metadata</span></div><div class="g-body">与块一同存储的附加数据，使软件能够验证该块未被损坏。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">阻塞式有界队列</span><span class="g-en">blocking bounded queue</span></div><div class="g-body">一种有界队列：试图从空队列取出元素的线程会等到有元素可用，试图向满队列放入元素的线程会等到有空位。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">玻尔缺陷</span><span class="g-en">Bohrbugs</span></div><div class="g-body">在给定相同程序输入时确定且可复现的程序缺陷。另见：<em>Heisenbugs</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">引导 ROM</span><span class="g-en">Boot ROM</span></div><div class="g-body">包含启动计算机的初始指令的专用只读存储器。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">引导装载程序</span><span class="g-en">bootloader</span></div><div class="g-body">存放在磁盘（或闪存）固定位置上的程序，用于把操作系统装入内存并开始执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">有界队列</span><span class="g-en">bounded queue</span></div><div class="g-body">队列中存放的元素数量有固定上限的队列。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">资源有限</span><span class="g-en">bounded resources</span></div><div class="g-body">死锁的一个必要条件：线程可以同时使用的资源数量是有限的。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">缓冲区溢出攻击</span><span class="g-en">buffer overflow attack</span></div><div class="g-body">利用如下缺陷的攻击：输入可能溢出为存放它而分配的缓冲区，从而用攻击者提供的数据覆盖程序中其他重要的数据结构。一种常见的变体是溢出分配在栈上的缓冲区（如局部的自动变量），并把函数的返回地址替换为攻击者指定的返回地址，可能指向随溢出输入“推入”栈中的代码。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">整体同步</span><span class="g-en">bulk synchronous</span></div><div class="g-body">一类并行应用，其工作被划分为相互独立的任务，且每个任务完成后才能使用任何任务的结果。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">整体同步并行编程</span><span class="g-en">bulk synchronous parallel programming</span></div><div class="g-body">参见：<em>数据并行编程</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">突发分布</span><span class="g-en">bursty distribution</span></div><div class="g-body">一种在均值附近比指数分布更不均匀的概率分布。参见：<em>指数分布</em>。比较：<em>重尾分布</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">忙等待</span><span class="g-en">busy-waiting</span></div><div class="g-body">线程在循环中空转，等待某个并发事件发生，等待期间一直消耗 CPU 周期。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">缓存</span><span class="g-en">cache</span></div><div class="g-body">比原始数据访问更快的数据副本。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">缓存命中</span><span class="g-en">cache hit</span></div><div class="g-body">缓存中包含所请求的项。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">缓存缺失</span><span class="g-en">cache miss</span></div><div class="g-body">缓存中不包含所请求的项。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">检查点</span><span class="g-en">checkpoint</span></div><div class="g-body">进程整个状态的一致快照，包括内存内容和处理器寄存器的内容。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">子进程</span><span class="g-en">child process</span></div><div class="g-body">由另一个进程创建的进程。另见：<em>父进程</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">循环扫描</span><span class="g-en">Circular SCAN</span></div><div class="g-body">参见：<em>CSCAN</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">循环等待</span><span class="g-en">circular waiting</span></div><div class="g-body">发生死锁的一个必要条件：存在一组线程，其中每个线程都在等待另一个线程持有的资源。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">客户端-服务器通信</span><span class="g-en">client-server communication</span></div><div class="g-body">进程之间的双向通信：客户端向服务器发出请求以完成某项任务，操作完成后服务器回复客户端。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">时钟算法</span><span class="g-en">clock algorithm</span></div><div class="g-body">一种找出最近未使用页面予以淘汰的方法。算法遍历每个页框：若页面使用位已置位则清除，若未置位则回收该页面。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">云计算</span><span class="g-en">cloud computing</span></div><div class="g-body">一种计算模式，大规模应用运行在数据中心的共享计算与存储基础设施上，而不是用户自己的计算机上。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">提交</span><span class="g-en">commit</span></div><div class="g-body">事务的一种结局，即其全部更新都发生。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">比较并交换</span><span class="g-en">compare-and-swap</span></div><div class="g-body">一种原子读-改-写指令，先检测某个内存位置的值，若该值未被改动，则把它设为新值。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">计算密集型任务</span><span class="g-en">compute-bound task</span></div><div class="g-body">主要使用处理器、几乎不做 I/O 的任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">计算机病毒</span><span class="g-en">computer virus</span></div><div class="g-body">一种计算机程序，它在计算机所有者不知情或未许可的情况下修改操作系统或应用程序，从而把自己从一台计算机复制到另一台。一旦装入计算机，病毒往往让攻击者得以控制系统资源或数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">并发</span><span class="g-en">concurrency</span></div><div class="g-body">可以同时发生的多个活动。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">条件变量</span><span class="g-en">condition variable</span></div><div class="g-body">一种同步变量，使线程能够高效地等待受锁保护的共享状态发生变化。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">续延</span><span class="g-en">continuation</span></div><div class="g-body">事件驱动编程中使用的一种数据结构，记录任务的当前状态及其下一步。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">协作线程</span><span class="g-en">cooperating threads</span></div><div class="g-body">会读写共享状态的线程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">协作缓存</span><span class="g-en">cooperative caching</span></div><div class="g-body">利用网络上邻近节点的内存作为缓存，以避免访问磁盘的延迟。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">协作式多线程</span><span class="g-en">cooperative multi-threading</span></div><div class="g-body">每个线程不被打断地运行，直到它显式放弃对处理器的控制，例如退出或调用 <code>thread_yield</code>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">写时复制</span><span class="g-en">copy-on-write</span></div><div class="g-body">在两个逻辑上不同的副本（例如不同进程中的副本）之间共享物理内存的一种方法。每个共享页面被标记为只读，因此任一进程试图写入时就会调入操作系统内核，由内核复制该页面；进程随后可以修改副本并继续正常执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">写时复制文件系统</span><span class="g-en">copy-on-write file system</span></div><div class="g-body">一种文件系统，其更新方式是：把被修改的数据块和元数据块的新版本写入空闲磁盘块。新块可以指向文件系统前一版本中未改动的块。另见：<em>COW 文件系统</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">页框映射表</span><span class="g-en">core map</span></div><div class="g-body">内存管理系统用来跟踪物理页框状态（如哪些进程引用该页框）的数据结构。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">COW 文件系统</span><span class="g-en">COW file system</span></div><div class="g-body">参见：<em>写时复制文件系统</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">关键路径</span><span class="g-en">critical path</span></div><div class="g-body">并行应用计算出结果所需的最少步骤序列，即使资源无限也是如此。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">临界区</span><span class="g-en">critical section</span></div><div class="g-body">对共享状态进行操作的一段代码。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">跨站脚本</span><span class="g-en">cross-site scripting</span></div><div class="g-body">针对客户端计算机的一种攻击：先攻陷客户端访问的服务器，再由被攻陷的服务器向客户端提供脚本代码，从而访问并下载客户端的敏感数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">密码学签名</span><span class="g-en">cryptographic signature</span></div><div class="g-body">由数据块和私钥经过专门设计的函数产生的值，持有相应公钥的人可据此验证该数据块是由某个被授权方产生的。没有私钥的攻击者在计算上无法构造出另一个带有有效签名的不同数据块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">CSCAN</span><span class="g-en">CSCAN</span></div><div class="g-body">SCAN 磁盘调度策略的一种变体，磁盘只在磁头沿一个方向移动时服务请求。另见：<em>循环扫描</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">当前工作目录</span><span class="g-en">current working directory</span></div><div class="g-body">进程的当前目录，用于解释相对路径名。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">数据断点</span><span class="g-en">data breakpoint</span></div><div class="g-body">要求程序在引用或修改某个特定内存位置时停止执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">数据并行编程</span><span class="g-en">data parallel programming</span></div><div class="g-body">一种编程模型，计算在数据集中所有元素上并行进行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">死锁</span><span class="g-en">deadlock</span></div><div class="g-body">一组线程之间相互等待的循环，其中每个线程都在等待循环中另一个线程采取某种动作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">死锁状态</span><span class="g-en">deadlocked state</span></div><div class="g-body">系统至少存在一处死锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分散布局</span><span class="g-en">declustering</span></div><div class="g-body">RAID 系统中通过在多个磁盘上分散冗余块来缩短磁盘故障后恢复时间的技术。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">纵深防御</span><span class="g-en">defense in depth</span></div><div class="g-body">通过多层防护来提高安全性。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">碎片整理</span><span class="g-en">defragment</span></div><div class="g-body">把分散的磁盘块合并起来以改善空间局部性：读出数据当前存储位置的内容，再把它写到新的、更紧凑的位置。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">按需分页</span><span class="g-en">demand paging</span></div><div class="g-body">利用地址转换硬件，在进程的内存并未全部实际驻留的情况下运行它。当进程引用缺失的页面时，硬件陷入内核，由内核把该页面从磁盘调入内存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">确定性调试</span><span class="g-en">deterministic debugging</span></div><div class="g-body">能够以相同的调度以及相同的内部和外部事件序列重新执行一个并发进程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">设备驱动程序</span><span class="g-en">device driver</span></div><div class="g-body">用于初始化和管理特定 I/O 设备的操作系统代码。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">直接映射缓存</span><span class="g-en">direct mapped cache</span></div><div class="g-body">缓存中只有一个表项能存放某个特定内存位置，因此查找时只需把地址与该表项比较，即可判断是否缓存命中。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">直接内存访问</span><span class="g-en">direct memory access</span></div><div class="g-body">硬件 I/O 设备直接在操作系统指定的位置与主存之间传送数据。另见：<em>DMA</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">脏位</span><span class="g-en">dirty bit</span></div><div class="g-body">页表项中的一个状态位，记录页面内容相对于磁盘上存储的内容是否已被修改。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁盘缓冲存储器</span><span class="g-en">disk buffer memory</span></div><div class="g-body">磁盘控制器中的存储器，用于缓冲正在读写的磁盘数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁盘初期失效</span><span class="g-en">disk infant mortality</span></div><div class="g-body">设备在使用的头几周内故障率高于正常水平。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁盘磨损</span><span class="g-en">disk wear out</span></div><div class="g-body">设备运行若干年后故障率上升。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">DMA</span><span class="g-en">DMA</span></div><div class="g-body">参见：<em>直接内存访问</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">dnode</span><span class="g-en">dnode</span></div><div class="g-body">在 ZFS 中，文件由一棵深度可变的树表示，其根是一个 dnode，叶是其数据块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">双重间接块</span><span class="g-en">double indirect block</span></div><div class="g-body">存放指向间接块的指针的存储块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">双重检查加锁</span><span class="g-en">double-checked locking</span></div><div class="g-body">并发代码中的一个陷阱：数据结构的延迟初始化先在不加锁的情况下检查它是否已设置，若未设置则加锁再检查一次，然后调用初始化函数。在存在指令重排序时，双重检查加锁可能意外失败。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">双冗余阵列</span><span class="g-en">dual redundancy array</span></div><div class="g-body">一种 RAID 存储算法，每个阵列使用两个冗余磁盘块，以容忍两块磁盘同时故障。另见：<em>RAID 6</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">双重模式运行</span><span class="g-en">dual-mode operation</span></div><div class="g-body">具有（至少）两个特权级的硬件处理器：一个用于执行内核、可完全访问硬件能力，另一个用于执行权限受限的用户代码。另见：<em>内核模式运行</em>。另见：<em>用户模式运行</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">动态可加载设备驱动程序</span><span class="g-en">dynamically loadable device driver</span></div><div class="g-body">用于管理特定设备、接口或芯片组的软件，在内核开始运行之后才加入操作系统内核。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最早截止期优先</span><span class="g-en">earliest deadline first</span></div><div class="g-body">一种调度策略，执行最需要先完成的任务，但仅当它能按时完成时才这样做。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">EDF</span><span class="g-en">EDF</span></div><div class="g-body">参见：<em>最早截止期优先</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">效率</span><span class="g-en">efficiency</span></div><div class="g-body">实现某种抽象时没有多余的开销。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">擦除块</span><span class="g-en">erasure block</span></div><div class="g-body">闪存设备中擦除的单位。擦除块中任何一部分被重写之前，整个擦除块的每个单元都必须置为逻辑“1”。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">纠错码</span><span class="g-en">error correcting code</span></div><div class="g-body">一种冗余存储数据的技术，使得即使磁盘扇区或闪存页面中的某些位已损坏，原始数据仍可恢复。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">事件驱动编程</span><span class="g-en">event-driven programming</span></div><div class="g-body">一种编码设计模式：线程在循环中空转，每次迭代获取并处理下一个 I/O 事件。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">异常</span><span class="g-en">exception</span></div><div class="g-body">参见：<em>处理器异常</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">可执行映像</span><span class="g-en">executable image</span></div><div class="g-body">包含一段机器指令及程序初始数据值的文件。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">执行栈</span><span class="g-en">execution stack</span></div><div class="g-body">在过程调用期间存放局部变量状态的空间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">指数分布</span><span class="g-en">exponential distribution</span></div><div class="g-body">排队论中常用的一种便利概率分布，因为它具有无记忆性。对于均值为 \(1 \/ \lambda\) 的连续随机变量，概率密度函数为 \(f(x) = \lambda e^(-\lambda x)\)。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">区段</span><span class="g-en">extent</span></div><div class="g-body">文件中存储在存储设备上连续区域内的可变长区域。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">外部碎片</span><span class="g-en">external fragmentation</span></div><div class="g-body">在以连续区域分配内存的系统中，有效连续分配之间无法使用的内存。新的内存请求可能找不到既连续又足够大的空闲区域，尽管空闲内存总量足够。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">公平性</span><span class="g-en">fairness</span></div><div class="g-body">按均等或按某种期望的优先级，在用户或应用之间分配共享资源。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">伪共享</span><span class="g-en">false sharing</span></div><div class="g-body">由于一个缓存项同时包含两个共享模式不同的数据结构的片段，而额外产生的处理器间通信。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">命运共享</span><span class="g-en">fate sharing</span></div><div class="g-body">一个模块崩溃意味着另一个模块也崩溃。例如，库与链接它的应用共享命运：两者中任一个崩溃，进程就会退出。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">故障隔离</span><span class="g-en">fault isolation</span></div><div class="g-body">一个应用中的错误不应干扰其他应用，甚至不应干扰操作系统本身。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件</span><span class="g-en">file</span></div><div class="g-body">文件系统中一个有名字的数据集合。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件分配表</span><span class="g-en">file allocation table</span></div><div class="g-body">FAT 文件系统中存放于卷保留区的一个表项数组，每个表项对应一个文件数据块，并指向文件中的下一个块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件数据</span><span class="g-en">file data</span></div><div class="g-body">文件的内容。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件描述符</span><span class="g-en">file descriptor</span></div><div class="g-body">指向已打开的文件、设备或通道的句柄。另见：<em>文件句柄</em>。另见：<em>文件流</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件目录</span><span class="g-en">file directory</span></div><div class="g-body">一组人类可读的名字，以及从每个名字到特定文件或子目录的映射。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件句柄</span><span class="g-en">file handle</span></div><div class="g-body">参见：<em>文件描述符</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件索引结构</span><span class="g-en">file index structure</span></div><div class="g-body">一种持久存储的数据结构，用于定位文件的各个块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件元数据</span><span class="g-en">file metadata</span></div><div class="g-body">由操作系统管理的、有关文件的信息，但不包括文件内容。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件流</span><span class="g-en">file stream</span></div><div class="g-body">参见：<em>文件描述符</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件系统</span><span class="g-en">file system</span></div><div class="g-body">一种操作系统抽象，提供持久的、有名字的数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">文件系统指纹</span><span class="g-en">file system fingerprint</span></div><div class="g-body">对整个文件系统计算的校验和。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">按需填充</span><span class="g-en">fill-on-demand</span></div><div class="g-body">在进程的全部内存尚未从磁盘调入之前就启动它的一种方法。若对缺失内存的首次访问触发陷入内核，内核可以填入内存然后恢复执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">细粒度加锁</span><span class="g-en">fine-grained locking</span></div><div class="g-body">把对象的状态划分为若干子集、每个子集由不同的锁保护，以此提高并发度的方法。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">已完成链表</span><span class="g-en">finished list</span></div><div class="g-body">已执行完毕但尚未释放的线程集合，例如因为 join 可能要从线程控制块中读取返回值。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">先进先出</span><span class="g-en">first-in-first-out</span></div><div class="g-body">按任务到达的顺序逐个执行任务的调度策略。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">闪存页失效</span><span class="g-en">flash page failure</span></div><div class="g-body">一种闪存设备故障：闪存中一个或多个单独页面上存储的数据丢失，但其余部分仍正常工作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">闪存转换层</span><span class="g-en">flash translation layer</span></div><div class="g-body">把逻辑闪存页映射到闪存设备上不同物理页的层。另见：<em>FTL</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">闪存磨损</span><span class="g-en">flash wear out</span></div><div class="g-body">经过若干次编程-擦除循环后，某个闪存存储单元可能不再能可靠地存储信息。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分叉-汇合并行</span><span class="g-en">fork-join parallelism</span></div><div class="g-body">一种并行编程方式：可以创建（分叉）线程与父线程并行工作；父线程可以异步等待子线程结束（汇合）。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">空闲空间映射图</span><span class="g-en">free space map</span></div><div class="g-body">文件系统用来跟踪哪些存储块空闲、哪些正在使用中的数据结构。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">FTL</span><span class="g-en">FTL</span></div><div class="g-body">参见：<em>闪存转换层</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">整盘失效</span><span class="g-en">full disk failure</span></div><div class="g-body">磁盘设备不再能对所有扇区提供读写服务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">整个闪存盘失效</span><span class="g-en">full flash drive failure</span></div><div class="g-body">闪存设备不再能对所有存储页提供读写服务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">全相联缓存</span><span class="g-en">fully associative cache</span></div><div class="g-body">缓存中任何表项都能存放任何内存位置，因此查找时必须把地址与缓存中所有表项比较，才能判断是否命中。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">成组调度</span><span class="g-en">gang scheduling</span></div><div class="g-body">一种多处理器调度策略，同时运行某个进程的所有可运行任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">全局描述符表</span><span class="g-en">Global Descriptor Table</span></div><div class="g-body">x86 中对共享段的段表所用的术语。局部描述符表则用于进程私有的段。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">宽限期</span><span class="g-en">grace period</span></div><div class="g-body">对于受读-复制-更新锁保护的共享对象，从共享对象的新版本发布，到旧版本的最后一个读者确定已读完的这段时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">绿色线程</span><span class="g-en">green threads</span></div><div class="g-body">完全在用户级实现、不依赖操作系统内核服务的线程系统，只使用为单线程进程设计的那些服务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">组提交</span><span class="g-en">group commit</span></div><div class="g-body">把多个事务提交合并为一次磁盘操作的技术。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">客户操作系统</span><span class="g-en">guest operating system</span></div><div class="g-body">运行在虚拟机中的操作系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">硬链接</span><span class="g-en">hard link</span></div><div class="g-body">文件名与底层文件之间的映射，通常出现在同一个底层文件有多个路径名时。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">硬件抽象层</span><span class="g-en">hardware abstraction layer</span></div><div class="g-body">操作系统中隐藏不同硬件实现细节的模块。在这一层之上，操作系统是可移植的。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">硬件定时器</span><span class="g-en">hardware timer</span></div><div class="g-body">能在一定延迟之后（按时间或按执行的指令数）引发处理器中断的硬件设备。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁头</span><span class="g-en">head</span></div><div class="g-body">向旋转的盘面写入数据或从盘面读出数据的部件。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁头碰撞</span><span class="g-en">head crash</span></div><div class="g-body">磁头物理刮擦旋转盘面磁性表面的错误。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁头切换时间</span><span class="g-en">head switch time</span></div><div class="g-body">在另一个表面上把磁盘臂重新定位到相应磁道、以便开始读写所需的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">堆</span><span class="g-en">heap</span></div><div class="g-body">存放动态分配的数据结构的空间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">重尾分布</span><span class="g-en">heavy-tailed distribution</span></div><div class="g-body">一种概率分布，远离均值的事件（总体上）以相当大的概率发生。当用于描述事件间隔的分布时，距离下一事件剩余的时间与已经等待的时间正相关——已经等得越久，预期还要等得越久。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">海森缺陷</span><span class="g-en">Heisenbugs</span></div><div class="g-body">并发程序中的缺陷，当你试图观察它们时会消失或改变行为。另见：<em>Bohrbugs</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">提示值</span><span class="g-en">hint</span></div><div class="g-body">某种计算的结果，该结果可能已经不再有效，但使用无效的提示值会触发异常。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">主目录</span><span class="g-en">home directory</span></div><div class="g-body">存放用户文件的子目录。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">宿主操作系统</span><span class="g-en">host operating system</span></div><div class="g-body">提供虚拟机抽象、以便把另一个操作系统作为应用运行的操作系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">主机传送时间</span><span class="g-en">host transfer time</span></div><div class="g-body">在主机的内存与磁盘缓冲区之间传送数据的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">超线程</span><span class="g-en">hyperthreading</span></div><div class="g-body">参见：<em>同时多线程</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">I/O 密集型任务</span><span class="g-en">I/O-bound task</span></div><div class="g-body">主要做 I/O、很少做处理的任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">幂等</span><span class="g-en">idempotent</span></div><div class="g-body">执行一次与执行多次效果相同的操作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">增量检查点</span><span class="g-en">incremental checkpoint</span></div><div class="g-body">对上次检查点以来被修改的那部分进程内存所做的一致快照。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">独立线程</span><span class="g-en">independent threads</span></div><div class="g-body">在进程内存完全不相交的子集上操作的线程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">间接块</span><span class="g-en">indirect block</span></div><div class="g-body">存放指向文件数据块的指针的存储块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">索引节点</span><span class="g-en">inode</span></div><div class="g-body">在 Unix 快速文件系统（FFS）及类似文件系统中，索引节点存放文件的元数据，其中包括一个指针数组，可用来找到文件的所有块。inode 一词有时被更宽泛地用来指任何文件系统的每文件元数据结构。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">索引节点数组</span><span class="g-en">inode array</span></div><div class="g-body">磁盘上存放文件系统全部索引节点的固定位置。另见：<em>inumber</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">意图集</span><span class="g-en">intentions</span></div><div class="g-body">事务若提交将要执行的一组写操作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内部碎片</span><span class="g-en">internal fragmentation</span></div><div class="g-body">在分页式内存分配中，页面末尾无法使用的内存，因为进程只能按页大小的块获得内存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">中断</span><span class="g-en">interrupt</span></div><div class="g-body">发送给处理器的异步信号，表示发生了某个可能需要它处理的外部事件。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">关中断</span><span class="g-en">interrupt disable</span></div><div class="g-body">一条特权硬件指令，用于暂时推迟所有硬件中断，使内核得以完成某项关键任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">开中断</span><span class="g-en">interrupt enable</span></div><div class="g-body">一条特权硬件指令，在不可中断的任务完成后恢复硬件中断。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">中断处理程序</span><span class="g-en">interrupt handler</span></div><div class="g-body">发生中断时被调用的内核过程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">中断栈</span><span class="g-en">interrupt stack</span></div><div class="g-body">用于存放内核中断处理程序栈的一块内存区域。当中断、处理器异常或系统调用陷入导致上下文切换到内核时，硬件把栈指针改为指向内核中断栈的基址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">中断向量表</span><span class="g-en">interrupt vector table</span></div><div class="g-body">操作系统内核中的一张指针表，以中断类型为索引，每个表项指向该中断的处理程序的第一条指令。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">索引节点号</span><span class="g-en">inumber</span></div><div class="g-body">某个文件在索引节点数组中的下标。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">反向页表</span><span class="g-en">inverted page table</span></div><div class="g-body">用于在虚拟页号与物理页框之间转换的散列表。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内核线程</span><span class="g-en">kernel thread</span></div><div class="g-body">在操作系统内核内部实现的线程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内核模式运行</span><span class="g-en">kernel-mode operation</span></div><div class="g-body">处理器以不受限制的模式执行，使操作系统完全控制硬件。比较：<em>用户模式运行</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">LBA</span><span class="g-en">LBA</span></div><div class="g-body">参见：<em>逻辑块地址</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最不经常使用</span><span class="g-en">least frequently used</span></div><div class="g-body">一种缓存替换策略，淘汰在一段时间内使用次数最少的块。另见：<em>LFU</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最近最少使用</span><span class="g-en">least recently used</span></div><div class="g-body">一种缓存替换策略，淘汰最长时间未被使用的块。另见：<em>LRU</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">LFU</span><span class="g-en">LFU</span></div><div class="g-body">参见：<em>最不经常使用</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">利特尔定律</span><span class="g-en">Little's Law</span></div><div class="g-body">在到达率等于离开率的稳定系统中，系统中的任务数等于系统吞吐量乘以任务在系统中的平均时间：\(N = X R\)。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">活性</span><span class="g-en">liveness property</span></div><div class="g-body">对程序行为的一种约束：程序总能产生结果。比较：<em>安全性</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">局部性启发式</span><span class="g-en">locality heuristic</span></div><div class="g-body">一种文件系统块分配策略：如果某些文件很可能被同时读写，就把它们放在邻近的磁盘扇区上。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">锁</span><span class="g-en">lock</span></div><div class="g-body">一种同步变量，用于强制对共享数据的原子、互斥访问。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">锁顺序</span><span class="g-en">lock ordering</span></div><div class="g-body">一种广泛使用的防止死锁的方法：按预先确定的顺序获取锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">无锁数据结构</span><span class="g-en">lock-free data structures</span></div><div class="g-body">保证某个线程能取得进展的并发数据结构：无论数据结构中其他线程处于什么状态，总会有某个方法在有限步内完成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">日志</span><span class="g-en">log</span></div><div class="g-body">保存到持久存储中的有序操作序列。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">逻辑块地址</span><span class="g-en">logical block address</span></div><div class="g-body">每个磁盘扇区或闪存块的唯一标识，通常从 1 编号到磁盘或闪存设备的容量。磁盘接口把该标识转换为扇区或块的物理位置。另见：<em>LBA</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">逻辑隔离</span><span class="g-en">logical separation</span></div><div class="g-body">一种备份存储策略：备份与主存储放在同一位置，但访问受限，例如禁止更新。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">LRU</span><span class="g-en">LRU</span></div><div class="g-body">参见：<em>最近最少使用</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">主文件表</span><span class="g-en">master file table</span></div><div class="g-body">在 NTFS 中，一个存放每个文件元数据记录的数组。另见：<em>MFT</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最大寻道时间</span><span class="g-en">maximum seek time</span></div><div class="g-body">磁盘臂从最内侧磁道移到最外侧磁道（或反向）所需的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最大最小公平</span><span class="g-en">max-min fairness</span></div><div class="g-body">一种调度目标：使每个任务所获资源分配的最小值最大化。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MCS 锁</span><span class="g-en">MCS lock</span></div><div class="g-body">一种高效的自旋锁实现，每个等待线程在各自独立的内存位置上自旋。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">平均数据丢失时间</span><span class="g-en">mean time to data loss</span></div><div class="g-body">RAID 系统发生不可恢复错误的期望时间。另见：<em>MTTDL</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">平均无故障时间</span><span class="g-en">mean time to failure</span></div><div class="g-body">系统无故障运行的平均时间。另见：<em>MTTF</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">平均修复时间</span><span class="g-en">mean time to repair</span></div><div class="g-body">系统发生故障后修复所需的平均时间。另见：<em>MTTR</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内存地址别名</span><span class="g-en">memory address alias</span></div><div class="g-body">指向同一物理内存位置的两个或多个虚拟地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内存屏障</span><span class="g-en">memory barrier</span></div><div class="g-body">一条阻止编译器和硬件跨越屏障重排内存访问的指令——屏障之前的访问不会被移到屏障之后，屏障之后的访问也不会被移到屏障之前。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内存保护</span><span class="g-en">memory protection</span></div><div class="g-body">硬件或软件强制的界限，使每个应用进程只能读写自己的内存，不能读写操作系统或其他进程的内存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">无记忆性</span><span class="g-en">memoryless property</span></div><div class="g-body">对于描述事件间隔时间的概率分布，距离下一事件的剩余时间不依赖于已经等待了多久。另见：<em>指数分布</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内存映射文件</span><span class="g-en">memory-mapped file</span></div><div class="g-body">其内容表现为进程虚拟地址空间中一个内存段的文件。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">内存映射 I/O</span><span class="g-en">memory-mapped I/O</span></div><div class="g-body">每个 I/O 设备的控制寄存器被映射到内存总线上的一段物理地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">忆阻器</span><span class="g-en">memristor</span></div><div class="g-body">一种固态持久存储器件，所用电路元件的电阻取决于过去流过它的电流大小和方向。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MFQ</span><span class="g-en">MFQ</span></div><div class="g-body">参见：<em>多级反馈队列</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MFT</span><span class="g-en">MFT</span></div><div class="g-body">参见：<em>主文件表</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">微内核</span><span class="g-en">microkernel</span></div><div class="g-body">一种操作系统设计，内核本身保持很小，传统操作系统内核的大部分功能改为一组用户级进程（或服务器），用户应用通过进程间通信访问它们。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MIN 缓存替换</span><span class="g-en">MIN cache replacement</span></div><div class="g-body">参见：<em>最优缓存替换</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最小寻道时间</span><span class="g-en">minimum seek time</span></div><div class="g-body">把磁盘臂移到相邻下一条磁道所需的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MIPS</span><span class="g-en">MIPS</span></div><div class="g-body">一种早期的处理器性能度量：每秒百万条指令。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">镜像</span><span class="g-en">mirroring</span></div><div class="g-body">一种在磁盘上冗余存储数据的方案：每个数据块存放在两块磁盘上，可从任一块读取。另见：<em>RAID 1</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">模型</span><span class="g-en">model</span></div><div class="g-body">一种简化，力图抓住更复杂系统行为中最重要的方面。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">宏内核</span><span class="g-en">monolithic kernel</span></div><div class="g-body">一种操作系统设计，操作系统的大部分功能链接在一起放在内核内部。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">摩尔定律</span><span class="g-en">Moore's Law</span></div><div class="g-body">晶体管密度随时间指数增长。许多其他部件技术也出现过类似的指数式进步；在大众媒体中，这些现象常被冠以同一名称。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">挂载</span><span class="g-en">mount</span></div><div class="g-body">把现有文件系统中的某条路径映射到另一个文件系统卷的根目录。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MTTDL</span><span class="g-en">MTTDL</span></div><div class="g-body">参见：<em>平均数据丢失时间</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MTTF</span><span class="g-en">MTTF</span></div><div class="g-body">参见：<em>平均无故障时间</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">MTTR</span><span class="g-en">MTTR</span></div><div class="g-body">参见：<em>平均修复时间</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多级反馈队列</span><span class="g-en">multi-level feedback queue</span></div><div class="g-body">一种调度算法，具有多个优先级，用轮转队列管理，任务根据已使用的处理时间在优先级之间移动。另见：<em>MFQ</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多级索引</span><span class="g-en">multi-level index</span></div><div class="g-body">一种树形数据结构，用于记录文件中每个数据块的磁盘位置。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多级分页式分段</span><span class="g-en">multi-level paged segmentation</span></div><div class="g-body">一种虚拟内存机制：物理内存按页框分配，虚拟地址按段划分，每个段通过多级页表转换为物理地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多级分页</span><span class="g-en">multi-level paging</span></div><div class="g-body">一种虚拟内存机制：物理内存按页框分配，虚拟地址通过多级页表转换为物理地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多个独立请求</span><span class="g-en">multiple independent requests</span></div><div class="g-body">发生死锁的一个必要条件：线程先获取一个资源，然后试图获取另一个。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多处理器调度策略</span><span class="g-en">multiprocessor scheduling policy</span></div><div class="g-body">决定给每个进程分配多少个处理器的策略。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多道程序设计</span><span class="g-en">multiprogramming</span></div><div class="g-body">参见：<em>多任务处理</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多任务处理</span><span class="g-en">multitasking</span></div><div class="g-body">操作系统同时运行多个应用的能力，也称多道程序设计。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多线程进程</span><span class="g-en">multi-threaded process</span></div><div class="g-body">拥有多个线程的进程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">多线程程序</span><span class="g-en">multi-threaded program</span></div><div class="g-body">单线程程序的推广。程序不再只有一条逻辑步骤序列，而是有多条序列（即线程）同时执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">互斥</span><span class="g-en">mutual exclusion</span></div><div class="g-body">一个线程使用锁来阻止对共享数据结构的并发访问。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">相互递归加锁</span><span class="g-en">mutually recursive locking</span></div><div class="g-body">一种死锁情形：两个共享对象在仍持有各自锁的情况下相互调用。如果一个线程持有第一个对象的锁并调用第二个对象，而另一个线程持有第二个对象的锁并调用第一个对象，就会发生死锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">具名数据</span><span class="g-en">named data</span></div><div class="g-body">可以通过人类可读的标识符（如文件名）访问的数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">原生命令排队</span><span class="g-en">native command queueing</span></div><div class="g-body">参见：<em>标记命令排队</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">NCQ</span><span class="g-en">NCQ</span></div><div class="g-body">参见：<em>标记命令排队</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">嵌套等待</span><span class="g-en">nested waiting</span></div><div class="g-body">一种死锁情形：一个共享对象在持有第一个对象的锁时调用另一个共享对象，随后在某个条件变量上等待。如果能够发出该条件变量信号的线程需要第一把锁才能继续，就会导致死锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">网络效应</span><span class="g-en">network effect</span></div><div class="g-body">产品或服务的价值随采用该技术的人数（而不仅是其固有功能）而增加。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">不可抢占</span><span class="g-en">no preemption</span></div><div class="g-body">发生死锁的一个必要条件：线程一旦获取资源，其所有权在该线程主动释放之前不能被剥夺。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">非阻塞数据结构</span><span class="g-en">non-blocking data structure</span></div><div class="g-body">一种并发数据结构，其中线程从不需要等待另一个线程完成其操作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">不可恢复的读错误</span><span class="g-en">non-recoverable read error</span></div><div class="g-body">磁盘扇区或闪存页面中发生足够多的位错误，以致即使经过纠错，原始数据也无法恢复。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">非常驻属性</span><span class="g-en">non-resident attribute</span></div><div class="g-body">在 NTFS 中，内容通过间接方式寻址的属性记录：主文件表中的区段指针指向各区段中的内容。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">非易失性存储</span><span class="g-en">non-volatile storage</span></div><div class="g-body">与 DRAM 不同，这种存储器是持久的，在崩溃和断电后仍保留其状态。另见：<em>持久存储</em>。另见：<em>稳定存储</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最近未使用</span><span class="g-en">not recently used</span></div><div class="g-body">一种缓存替换策略，淘汰某个最近未被引用的块，而不是最近最少使用的块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">无感知调度</span><span class="g-en">oblivious scheduling</span></div><div class="g-body">一种调度策略，操作系统在把线程分配给处理器时并不了解并行应用的意图。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">开放系统</span><span class="g-en">open system</span></div><div class="g-body">源代码公开可供修改和复用的系统，或接口由公开标准过程定义的系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">操作系统</span><span class="g-en">operating system</span></div><div class="g-body">一层软件，为用户及其应用管理计算机的资源。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">操作系统内核</span><span class="g-en">operating system kernel</span></div><div class="g-body">内核是系统中运行的最低层软件，可完全访问硬件的所有能力。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最优缓存替换</span><span class="g-en">optimal cache replacement</span></div><div class="g-body">替换将来最晚才会被使用的块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">开销</span><span class="g-en">overhead</span></div><div class="g-body">与直接使用底层硬件资源相比，实现某种抽象所增加的资源成本。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">所有权设计模式</span><span class="g-en">ownership design pattern</span></div><div class="g-body">一种管理共享对象并发访问的技术：任一时刻至多有一个线程拥有某个对象，因此该线程无需加锁即可访问共享数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">页着色</span><span class="g-en">page coloring</span></div><div class="g-body">根据页框将使用缓存的哪些部分，对页框进行划分，从而把物理页框分配给虚拟地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">缺页</span><span class="g-en">page fault</span></div><div class="g-body">当进程引用页表项无效的虚拟地址时，硬件陷入操作系统内核。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">页框</span><span class="g-en">page frame</span></div><div class="g-body">一块对齐的、固定大小的物理内存，可容纳一个虚拟页。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分页内存</span><span class="g-en">paged memory</span></div><div class="g-body">一种硬件地址转换机制：内存按对齐的固定大小块（称为页）分配，任何虚拟页都可以分配到任何物理页框。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分页式分段</span><span class="g-en">paged segmentation</span></div><div class="g-body">一种硬件机制：物理内存按页框分配，但虚拟地址按段划分。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">桩对</span><span class="g-en">pair of stubs</span></div><div class="g-body">一对短过程，在两个执行上下文之间起中介作用。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">半虚拟化</span><span class="g-en">paravirtualization</span></div><div class="g-body">一种虚拟机抽象，允许客户操作系统向宿主操作系统发起系统调用，以执行特定于硬件的操作，例如修改页表项。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">父进程</span><span class="g-en">parent process</span></div><div class="g-body">创建另一个进程的进程。另见：<em>子进程</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">路径</span><span class="g-en">path</span></div><div class="g-body">标识文件或目录的字符串。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">PCB</span><span class="g-en">PCB</span></div><div class="g-body">参见：<em>进程控制块</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">PCM</span><span class="g-en">PCM</span></div><div class="g-body">参见：<em>相变存储器</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">性能可预测性</span><span class="g-en">performance predictability</span></div><div class="g-body">系统的响应时间或其他性能指标是否随时间保持一致。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">持久数据</span><span class="g-en">persistent data</span></div><div class="g-body">一直保存到被显式删除的数据，即使存储它的计算机崩溃或断电。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">持久存储</span><span class="g-en">persistent storage</span></div><div class="g-body">参见：<em>非易失性存储</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">相位变化行为</span><span class="g-en">phase change behavior</span></div><div class="g-body">程序工作集的突变，导致突发式的缓存缺失率：低缺失期与高缺失期交替出现。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">相变存储器</span><span class="g-en">phase change memory</span></div><div class="g-body">一种非易失性存储器，利用材料的相态表示数据位。另见：<em>PCM</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">物理地址</span><span class="g-en">physical address</span></div><div class="g-body">物理内存中的地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">物理隔离</span><span class="g-en">physical separation</span></div><div class="g-body">一种备份存储策略：备份与主存储放在不同位置。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">物理地址缓存</span><span class="g-en">physically addressed cache</span></div><div class="g-body">使用物理内存地址访问的处理器缓存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">钉住</span><span class="g-en">pin</span></div><div class="g-body">把虚拟资源绑定到物理资源，例如把线程绑定到处理器，或把虚拟页绑定到物理页。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">盘片</span><span class="g-en">platter</span></div><div class="g-body">磁性磁盘中存储信息的单个薄圆盘，通常两面都存储信息。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">策略与机制分离</span><span class="g-en">policy-mechanism separation</span></div><div class="g-body">一条系统设计原则：抽象的实现与该抽象如何使用的资源分配策略相互独立。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">轮询</span><span class="g-en">polling</span></div><div class="g-body">硬件中断的一种替代方式：处理器通过循环（即忙等待）等待异步事件发生，直到事件出现。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">可移植性</span><span class="g-en">portability</span></div><div class="g-body">软件在多种硬件平台上工作的能力。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">精确中断</span><span class="g-en">precise interrupts</span></div><div class="g-body">在调用中断处理程序之前，硬件已完成（按程序执行顺序）发生在中断或异常之前的所有指令。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">抢占</span><span class="g-en">preemption</span></div><div class="g-body">调度器把一个任务手中的处理器拿走交给另一个任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">抢占式多线程</span><span class="g-en">preemptive multi-threading</span></div><div class="g-body">操作系统调度器可以切换掉正在运行的线程，例如在定时器中断时，无需该线程在该时刻显式放弃控制。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">预取</span><span class="g-en">prefetch</span></div><div class="g-body">在需要之前把数据调入缓存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最小权限原则</span><span class="g-en">principle of least privilege</span></div><div class="g-body">如果系统的每一部分都恰好拥有完成其工作所需的权限而不多，系统的安全性和可靠性就会提高。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">优先级捐赠</span><span class="g-en">priority donation</span></div><div class="g-body">优先级反转的一种解决方案：当某个线程等待较低优先级线程持有的锁时，持锁线程的优先级被临时提升到等待者的优先级，直到锁被释放。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">优先级反转</span><span class="g-en">priority inversion</span></div><div class="g-body">一种调度异常：高优先级任务无限期等待低优先级任务持有的资源（如锁），因为低优先级任务又在等待中优先级任务持有的资源（如处理器）。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">隐私</span><span class="g-en">privacy</span></div><div class="g-body">计算机上存储的数据只有被授权的用户才能访问。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">特权指令</span><span class="g-en">privileged instruction</span></div><div class="g-body">可在内核模式执行、但不能在用户模式执行的指令。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">进程</span><span class="g-en">process</span></div><div class="g-body">权限受限地执行一个应用程序——操作系统内核提供的保护抽象。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">进程控制块</span><span class="g-en">process control block</span></div><div class="g-body">一种数据结构，存放操作系统关于某个进程所需的全部信息：例如它在内存中的位置、它的可执行映像在磁盘上的位置、是哪个用户要求它开始执行，以及该进程拥有哪些权限。另见：<em>PCB</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">进程迁移</span><span class="g-en">process migration</span></div><div class="g-body">把在一个系统上运行的程序停下，并在另一台机器上恢复执行的能力。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">处理器异常</span><span class="g-en">processor exception</span></div><div class="g-body">由用户程序行为引起的硬件事件，导致控制权转移到内核处理程序。例如，许多体系结构中试图除以零会引起处理器异常。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">处理器调度策略</span><span class="g-en">processor scheduling policy</span></div><div class="g-body">当可运行的线程多于处理器时，决定先运行哪些线程的策略。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">处理器状态寄存器</span><span class="g-en">processor status register</span></div><div class="g-body">一种硬件寄存器，其中的标志控制处理器的运行，包括特权级。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">生产者-消费者通信</span><span class="g-en">producer-consumer communication</span></div><div class="g-body">一种进程间通信：一个进程的输出是另一个进程的输入。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">专有系统</span><span class="g-en">proprietary system</span></div><div class="g-body">由单一公司控制的系统；提供方可以随时修改它以满足客户需要。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">保护</span><span class="g-en">protection</span></div><div class="g-body">把可能出错的应用和用户隔离开来，使他们不破坏其他应用或操作系统本身。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">发布</span><span class="g-en">publish</span></div><div class="g-body">对于读-复制-更新锁，指一次原子的内存写，更新受该锁保护的共享对象。这次写使新的读者线程能够观察到对象的新版本。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">排队延迟</span><span class="g-en">queueing delay</span></div><div class="g-body">任务在队列中等待而得不到服务的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">静止</span><span class="g-en">quiescent</span></div><div class="g-body">对于读-复制-更新锁，指上次修改时活跃的读者线程已不再活跃。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">竞态条件</span><span class="g-en">race condition</span></div><div class="g-body">程序的行为依赖于不同线程操作的交替执行顺序。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RAID</span><span class="g-en">RAID</span></div><div class="g-body">廉价磁盘冗余阵列（Redundant Array of Inexpensive Disks，RAID）是一种把数据冗余地分布到多块磁盘上、以容忍单块磁盘故障的系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RAID 1</span><span class="g-en">RAID 1</span></div><div class="g-body">参见：<em>镜像</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RAID 5</span><span class="g-en">RAID 5</span></div><div class="g-body">参见：<em>旋转奇偶校验</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RAID 6</span><span class="g-en">RAID 6</span></div><div class="g-body">参见：<em>双冗余阵列</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RAID 条块</span><span class="g-en">RAID strip</span></div><div class="g-body">由 RAID 块布局算法放置在一块磁盘上的一组连续块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RAID 条带</span><span class="g-en">RAID stripe</span></div><div class="g-body">一组 RAID 条块及其奇偶校验条块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">R-CSCAN</span><span class="g-en">R-CSCAN</span></div><div class="g-body">CSCAN 磁盘调度策略的一种变体，磁盘会把旋转时间考虑在内。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">RCU</span><span class="g-en">RCU</span></div><div class="g-body">参见：<em>读-复制-更新</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">读干扰错误</span><span class="g-en">read disturb error</span></div><div class="g-body">对某个闪存单元进行大量读取，会使周围单元中的数据损坏。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">读-复制-更新</span><span class="g-en">read-copy-update</span></div><div class="g-body">一种同步抽象，允许多个读者与单个写者同时访问某个数据结构。另见：<em>RCU</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">读写锁</span><span class="g-en">readers/writers lock</span></div><div class="g-body">一种锁：只要“读者”线程不修改共享数据，就允许多个读者线程并发访问；而当“写者”线程读取或修改共享数据时，仍提供互斥。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">就绪链表</span><span class="g-en">ready list</span></div><div class="g-body">已就绪、可以运行但当前未运行的线程集合。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">实时约束</span><span class="g-en">real-time constraint</span></div><div class="g-body">计算必须在某个截止期之前完成才有价值。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">可恢复虚拟内存</span><span class="g-en">recoverable virtual memory</span></div><div class="g-body">持久内存的抽象，使内存段的内容在故障后可以恢复。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">重做日志</span><span class="g-en">redo logging</span></div><div class="g-body">一种实现事务的方式：在日志中记录事务提交时要执行的一组写操作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">相对路径</span><span class="g-en">relative path</span></div><div class="g-body">以进程的当前工作目录为起点解释的文件路径名。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">可靠性</span><span class="g-en">reliability</span></div><div class="g-body">系统恰如设计所期望的那样工作的属性。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">请求并行</span><span class="g-en">request parallelism</span></div><div class="g-body">服务器上因多个并发请求而产生的并行执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">常驻属性</span><span class="g-en">resident attribute</span></div><div class="g-body">在 NTFS 中，内容直接存放在主文件表中的属性记录。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">响应时间</span><span class="g-en">response time</span></div><div class="g-body">任务从开始到完成所用的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">重启</span><span class="g-en">restart</span></div><div class="g-body">从检查点恢复进程的执行，例如在故障之后或为了调试。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">回滚</span><span class="g-en">roll back</span></div><div class="g-body">事务的一种结局，即其任何更新都不发生。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">根目录</span><span class="g-en">root directory</span></div><div class="g-body">文件系统中的顶层目录。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">根索引节点</span><span class="g-en">root inode</span></div><div class="g-body">在写时复制文件系统中，指索引节点表的索引节点：即包含查找索引节点表所需元数据的磁盘块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">旋转奇偶校验</span><span class="g-en">rotating parity</span></div><div class="g-body">一种在磁盘上冗余存储数据的方案：系统把若干数据块写到多块磁盘上，并用存放在另一块磁盘上的一个冗余块来保护这些块。另见：<em>RAID 5</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">旋转延迟</span><span class="g-en">rotational latency</span></div><div class="g-body">磁头落到正确磁道后，还必须等待目标扇区旋转到磁头下方。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">轮转</span><span class="g-en">round robin</span></div><div class="g-body">一种调度策略，轮流让每个就绪任务运行一段有限时间，然后切换到下一个任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">R-SCAN</span><span class="g-en">R-SCAN</span></div><div class="g-body">SCAN 磁盘调度策略的一种变体，磁盘会把旋转时间考虑在内。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">安全状态</span><span class="g-en">safe state</span></div><div class="g-body">在死锁语境下，指执行的一种状态：无论将来的资源请求序列如何，至少存在一种安全的决策序列（决定何时满足请求），使所有待处理的和将来的请求都能得到满足。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">安全性</span><span class="g-en">safety property</span></div><div class="g-body">对程序行为的一种约束：程序永远不会算出错误的结果。比较：<em>活性</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">抽样偏差</span><span class="g-en">sample bias</span></div><div class="g-body">一种测量误差：群体中某些成员被纳入的可能性低于其他成员，而这些成员在被测量的属性上又有所不同。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">沙箱</span><span class="g-en">sandbox</span></div><div class="g-body">执行不可信代码的环境，对系统其余部分的保护由软件提供。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">SCAN</span><span class="g-en">SCAN</span></div><div class="g-body">一种磁盘调度策略：磁盘臂反复从内圈扫到外圈再扫回，每当磁头经过某条磁道时就服务该磁道上待处理的请求。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">调度器激活</span><span class="g-en">scheduler activations</span></div><div class="g-body">一种多处理器调度策略：每个应用都被告知它被分配了多少个处理器，以及分配何时发生变化。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">清洗</span><span class="g-en">scrubbing</span></div><div class="g-body">一种减少 RAID 不可恢复错误的技术：定期扫描损坏的磁盘块，并利用奇偶校验块重建它们。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">次要瓶颈</span><span class="g-en">secondary bottleneck</span></div><div class="g-body">争用相对较轻的资源，因为主要瓶颈处已积压大量排队。如果主要瓶颈得到改善，次要瓶颈的排队延迟就会大幅上升。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">扇区</span><span class="g-en">sector</span></div><div class="g-body">磁盘上可以独立读写的最小单位。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">扇区失效</span><span class="g-en">sector failure</span></div><div class="g-body">一种磁盘错误：磁盘上一个或多个单独扇区上的数据丢失，但磁盘其余部分仍正常工作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">扇区备用</span><span class="g-en">sector sparing</span></div><div class="g-body">通过把故障扇区重新映射到附近的备用扇区，透明地隐藏该故障扇区。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">安全</span><span class="g-en">security</span></div><div class="g-body">计算机的运行不能被恶意攻击者破坏。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">安全强制实施</span><span class="g-en">security enforcement</span></div><div class="g-body">操作系统用来确保只允许被许可操作的机制。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">安全策略</span><span class="g-en">security policy</span></div><div class="g-body">允许哪些操作——谁可以访问哪些数据，谁可以执行哪些操作。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">寻道</span><span class="g-en">seek</span></div><div class="g-body">磁盘臂移动到某条特定磁道上方，为读写做准备。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分段</span><span class="g-en">segmentation</span></div><div class="g-body">一种虚拟内存机制：地址通过查表转换，表中的每个表项指向一个可变长的内存区域。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">段错误</span><span class="g-en">segmentation fault</span></div><div class="g-body">进程试图访问其某个有效内存区域之外的内存时引起的错误。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">段内地址</span><span class="g-en">segment-local address</span></div><div class="g-body">相对于当前内存段的地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">自行调页</span><span class="g-en">self-paging</span></div><div class="g-body">一种在进程之间分配页框的资源分配策略：每次页面替换时，都从引发缺页的进程已分到的页框中选取。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">信号量</span><span class="g-en">semaphore</span></div><div class="g-body">一种只有两个原子操作 <code>P()</code> 和 <code>V()</code> 的同步变量。<code>P</code> 等待信号量的值变为正，然后原子地将其减一。<code>V</code> 原子地将值加一，若有线程正在 <code>P</code> 中等待，则触发该 <code>P</code> 操作完成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">可串行化</span><span class="g-en">serializability</span></div><div class="g-body">任何程序执行的结果，都等价于把请求按某种顺序逐个处理的执行结果。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">服务时间</span><span class="g-en">service time</span></div><div class="g-body">在资源上完成一个任务所需的时间，假定没有等待。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">组相联缓存</span><span class="g-en">set associative cache</span></div><div class="g-body">缓存被划分为若干组表项。每个内存位置只能存放在分配给它的组中，但可以存放在该组的任何表项里。查找时需要把地址与该组所有表项比较，才能判断是否命中。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">稳定</span><span class="g-en">settle</span></div><div class="g-body">磁头移到新磁道后、准备好读写该磁道扇区之前的精细再定位。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">影子页表</span><span class="g-en">shadow page table</span></div><div class="g-body">虚拟机中进程的页表，由客户操作系统维护的页表与宿主操作系统维护的页表复合而成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">共享对象</span><span class="g-en">shared object</span></div><div class="g-body">可以被多个并发线程安全访问的对象，即一个数据结构及其相关代码。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">shell</span><span class="g-en">shell</span></div><div class="g-body">作为用户级进程实现的任务控制系统。当用户在 shell 中输入命令时，它创建一个进程来运行该命令。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最短作业优先</span><span class="g-en">shortest job first</span></div><div class="g-body">执行剩余完成时间最少的任务的调度策略。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最短定位时间优先</span><span class="g-en">shortest positioning time first</span></div><div class="g-body">一种磁盘调度策略，服务能最快处理完的那个待处理请求。另见：<em>SPTF</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">最短寻道时间优先</span><span class="g-en">shortest seek time first</span></div><div class="g-body">一种磁盘调度策略，服务距离最近磁道上的那个待处理请求。若不考虑旋转定位，则等同于最短定位时间优先。另见：<em>SSTF</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">SIMD（单指令多数据）编程</span><span class="g-en">SIMD (single instruction multiple data) programming</span></div><div class="g-body">参见数据并行编程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">同时多线程</span><span class="g-en">simultaneous multi-threading</span></div><div class="g-body">一种硬件技术，每个处理器模拟两个（或更多）虚拟处理器，逐周期在它们之间交替。另见：<em>超线程</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">单线程程序</span><span class="g-en">single-threaded program</span></div><div class="g-body">以传统方式编写的程序，只有一条逻辑步骤序列，每条指令紧随前一条。比较：<em>多线程程序</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">滑动备用</span><span class="g-en">slip sparing</span></div><div class="g-body">重新映射故障磁盘扇区时，把故障扇区与备用扇区之间的整个扇区序列依次挪动一个位置，以保持顺序访问性能。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">软链接</span><span class="g-en">soft link</span></div><div class="g-body">把一个文件或目录名映射到另一个名字的目录项。另见：<em>符号链接</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">软件事务内存（STM）</span><span class="g-en">software transactional memory (STM)</span></div><div class="g-body">一种为内存中的数据结构提供通用事务的系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">软件装入式 TLB</span><span class="g-en">software-loaded TLB</span></div><div class="g-body">一种硬件 TLB，其表项在 TLB 缺失时由软件而非硬件装入。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">固态存储</span><span class="g-en">solid state storage</span></div><div class="g-body">没有活动部件的持久存储设备，它使用电路存储数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">空间共享</span><span class="g-en">space sharing</span></div><div class="g-body">一种多处理器分配策略，把不同的处理器分配给不同的任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">空间局部性</span><span class="g-en">spatial locality</span></div><div class="g-body">程序倾向于引用与最近访问过的指令和数据相邻的指令和数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">主轴</span><span class="g-en">spindle</span></div><div class="g-body">组成磁盘的旋转盘片绕之旋转的轴。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">自旋锁</span><span class="g-en">spinlock</span></div><div class="g-body">一种锁：等待 BUSY 锁的线程在紧凑的循环中“自旋”，直到其他线程把它变为 FREE。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">SPTF</span><span class="g-en">SPTF</span></div><div class="g-body">参见：<em>最短定位时间优先</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">SSTF</span><span class="g-en">SSTF</span></div><div class="g-body">参见：<em>最短寻道时间优先</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">稳定性质</span><span class="g-en">stable property</span></div><div class="g-body">程序的一种性质：一旦它在某次执行中变为真，就会在该次执行的剩余过程中一直为真。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">稳定存储</span><span class="g-en">stable storage</span></div><div class="g-body">参见：<em>非易失性存储</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">稳定系统</span><span class="g-en">stable system</span></div><div class="g-body">到达率等于离开率的排队系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">栈帧</span><span class="g-en">stack frame</span></div><div class="g-body">存放在栈上、为一次过程调用提供存储的数据结构：过程使用的局部变量、调用时传入的参数，以及过程结束时跳回的返回地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分阶段体系结构</span><span class="g-en">staged architecture</span></div><div class="g-body">分阶段体系结构把系统划分为多个子系统或阶段，每个阶段包含该阶段私有的一些状态，以及一组在该状态上工作的一个或多个工作线程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">饥饿</span><span class="g-en">starvation</span></div><div class="g-body">某个任务因资源被让给更高优先级的任务而得不到进展。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">状态变量</span><span class="g-en">state variable</span></div><div class="g-body">共享对象的成员变量。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">STM</span><span class="g-en">STM</span></div><div class="g-body">参见：<em>软件事务内存（STM）</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">结构化同步</span><span class="g-en">structured synchronization</span></div><div class="g-body">一种编写正确并发程序的设计模式：并发代码使用一组标准的同步原语来控制对共享状态的访问，而访问同一共享状态的所有例程都集中到同一个逻辑模块中。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">超级页</span><span class="g-en">superpage</span></div><div class="g-body">物理内存中一组连续的页，映射虚拟内存的一个连续区域，这些页经过对齐，使它们共享相同的高阶（超级页）地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">盘面</span><span class="g-en">surface</span></div><div class="g-body">磁盘盘片的一面。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">盘面传送时间</span><span class="g-en">surface transfer time</span></div><div class="g-body">一旦磁头开始读（或写）第一个扇区，从盘面传送一个或多个连续扇区所需的时间。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">换出</span><span class="g-en">swapping</span></div><div class="g-body">把整个进程从物理内存中逐出。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">符号链接</span><span class="g-en">symbolic link</span></div><div class="g-body">参见：<em>软链接</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">同步屏障</span><span class="g-en">synchronization barrier</span></div><div class="g-body">一种同步原语：并行工作的 n 个线程在完成各自工作后到屏障处报到；在所有 n 个线程报到之前，任何线程都不会从屏障返回。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">同步变量</span><span class="g-en">synchronization variable</span></div><div class="g-body">用于协调对共享状态的并发访问的数据结构。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">系统可用性</span><span class="g-en">system availability</span></div><div class="g-body">系统在任意给定时刻可用的概率。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">系统调用</span><span class="g-en">system call</span></div><div class="g-body">内核提供的、可从用户级调用的过程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">系统可靠性</span><span class="g-en">system reliability</span></div><div class="g-body">系统在某个指定时间段内持续可靠的几率。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">标记命令排队</span><span class="g-en">tagged command queueing</span></div><div class="g-body">一种磁盘接口，允许操作系统向磁盘发出多个并发请求。请求的处理和确认可以乱序进行。另见：<em>原生命令排队</em>。另见：<em>NCQ</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">带标记的 TLB</span><span class="g-en">tagged TLB</span></div><div class="g-body">一种转换后备缓冲器，其表项包含进程 ID，地址转换时只使用当前运行进程的表项。这使得进程被换出时，它的 TLB 表项仍可留在 TLB 中。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">任务</span><span class="g-en">task</span></div><div class="g-body">一个用户请求。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TCB</span><span class="g-en">TCB</span></div><div class="g-body">参见：<em>线程控制块</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TCQ</span><span class="g-en">TCQ</span></div><div class="g-body">参见：<em>标记命令排队</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">时间局部性</span><span class="g-en">temporal locality</span></div><div class="g-body">程序倾向于引用它最近访问过的相同指令和数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">测试并测试-设置</span><span class="g-en">test and test-and-set</span></div><div class="g-body">一种自旋锁实现：等待的处理器先等到锁变为 FREE，再尝试获取它。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">抖动</span><span class="g-en">thrashing</span></div><div class="g-body">缓存太小、容纳不下工作集的情形。此时大多数引用都是缓存缺失，而这些缺失又会逐出不久的将来要用的数据。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">线程</span><span class="g-en">thread</span></div><div class="g-body">一条单独的执行序列，代表一个可以独立调度的任务。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">线程上下文切换</span><span class="g-en">thread context switch</span></div><div class="g-body">挂起当前正在运行的线程，恢复另一个线程的执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">线程控制块</span><span class="g-en">thread control block</span></div><div class="g-body">操作系统用来存放线程当前状态的数据结构。另见：<em>TCB</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">线程调度器</span><span class="g-en">thread scheduler</span></div><div class="g-body">通过在正在运行的线程与已就绪但未运行的线程之间切换，把线程映射到处理器的软件。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">线程安全有界队列</span><span class="g-en">thread-safe bounded queue</span></div><div class="g-body">可以从多个并发线程安全调用的有界队列。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">吞吐量</span><span class="g-en">throughput</span></div><div class="g-body">一组任务完成的速率。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">检查时刻与使用时刻攻击</span><span class="g-en">time of check vs. time of use attack</span></div><div class="g-body">一种安全漏洞：应用可以在内核检查系统调用参数（如文件名）的有效性<em>之后</em>、但在该参数于例程的实际实现中被使用<em>之前</em>，修改存放该参数的用户内存。常缩写为 TOCTOU。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">时间配额</span><span class="g-en">time quantum</span></div><div class="g-body">任务在被抢占之前所获得的调度时间长度。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">定时器中断</span><span class="g-en">timer interrupt</span></div><div class="g-body">表示一段实际时间已流逝的硬件处理器中断。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">分时操作系统</span><span class="g-en">time-sharing operating system</span></div><div class="g-body">为支持交互式使用计算机而设计的操作系统。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TLB</span><span class="g-en">TLB</span></div><div class="g-body">参见：<em>转换后备缓冲器</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TLB 刷新</span><span class="g-en">TLB flush</span></div><div class="g-body">从 TLB 中删除无效表项的操作，例如在进程上下文切换之后。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TLB 命中</span><span class="g-en">TLB hit</span></div><div class="g-body">成功找到有效地址转换的 TLB 查找。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TLB 缺失</span><span class="g-en">TLB miss</span></div><div class="g-body">因 TLB 中不含该虚拟地址的有效转换而失败的 TLB 查找。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TLB 击落</span><span class="g-en">TLB shootdown</span></div><div class="g-body">请求另一个处理器删除刚变为无效的 TLB 表项。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">TOCTOU</span><span class="g-en">TOCTOU</span></div><div class="g-body">参见：<em>检查时刻与使用时刻攻击</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁道</span><span class="g-en">track</span></div><div class="g-body">盘面上的一圈扇区。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁道缓冲</span><span class="g-en">track buffer</span></div><div class="g-body">磁盘控制器中的存储器，用于缓冲当前磁道的内容，即使这些扇区尚未被操作系统请求。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磁道错位</span><span class="g-en">track skewing</span></div><div class="g-body">磁盘扇区的交错排列，以便顺序读取相邻磁道上的扇区。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">事务</span><span class="g-en">transaction</span></div><div class="g-body">一组操作，它们被持久地应用，作为一个整体原子地生效或完全不生效，并且与其他事务相互独立。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">转换后备缓冲器</span><span class="g-en">translation lookaside buffer</span></div><div class="g-body">一张小型硬件表，存放最近的地址转换结果。另见：<em>TLB</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">陷入</span><span class="g-en">trap</span></div><div class="g-body">从用户级进程到内核模式处理程序的同步控制转移。陷入可由处理器异常、内存保护错误或系统调用引起。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">三重间接块</span><span class="g-en">triple indirect block</span></div><div class="g-body">存放指向双重间接块的指针的存储块。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">两阶段加锁</span><span class="g-en">two-phase locking</span></div><div class="g-body">一种为需要多步操作的请求获取锁的策略：在所有需要的锁都获取之前，不能释放任何锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">尤伯块</span><span class="g-en">uberblock</span></div><div class="g-body">在 ZFS 中，指 ZFS 存储系统的根。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX exec</span><span class="g-en">UNIX exec</span></div><div class="g-body">UNIX 上的一个系统调用，使当前进程把一个新的可执行映像调入内存并开始运行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX fork</span><span class="g-en">UNIX fork</span></div><div class="g-body">UNIX 上的一个系统调用，创建一个新进程，作为父进程的完整副本。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX 管道</span><span class="g-en">UNIX pipe</span></div><div class="g-body">UNIX 进程之间的双向字节流通信通道。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX 信号</span><span class="g-en">UNIX signal</span></div><div class="g-body">发送给正在运行的进程的异步通知。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX 标准输入</span><span class="g-en">UNIX stdin</span></div><div class="g-body">为新进程自动建立、用作其输入的文件描述符。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX 标准输出</span><span class="g-en">UNIX stdout</span></div><div class="g-body">为新进程自动建立、用作其输出的文件描述符。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">UNIX wait</span><span class="g-en">UNIX wait</span></div><div class="g-body">一个系统调用，暂停执行直到某个子进程结束。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">不安全状态</span><span class="g-en">unsafe state</span></div><div class="g-body">在死锁语境下，指执行的一种状态：至少存在一种将来的资源请求序列，无论尝试何种处理顺序都会导致死锁。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">上调</span><span class="g-en">upcall</span></div><div class="g-body">内核递送给用户级进程的事件、中断或异常。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">使用位</span><span class="g-en">use bit</span></div><div class="g-body">页表项中的一个状态位，记录该页面最近是否被引用过。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">用户级内存管理</span><span class="g-en">user-level memory management</span></div><div class="g-body">内核给每个进程分配一组页框，但进程如何使用分配给它的内存由应用自行决定。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">用户级缺页处理程序</span><span class="g-en">user-level page handler</span></div><div class="g-body">缺页时由内核调用的、应用特定的上调例程。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">用户级线程</span><span class="g-en">user-level thread</span></div><div class="g-body">一种应用线程，其创建、运行和结束都不调用操作系统内核。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">用户模式运行</span><span class="g-en">user-mode operation</span></div><div class="g-body">处理器以受限模式运行，限制正在执行的进程的能力。比较：<em>内核模式运行</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">利用率</span><span class="g-en">utilization</span></div><div class="g-body">资源处于忙碌状态的时间所占的比例。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟地址</span><span class="g-en">virtual address</span></div><div class="g-body">必须经过转换才能产生物理内存地址的地址。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟机</span><span class="g-en">virtual machine</span></div><div class="g-body">操作系统提供的一种执行环境，它模仿一台物理机器，例如用于在一个操作系统之上把另一个操作系统作为应用运行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟机蜜罐</span><span class="g-en">virtual machine honeypot</span></div><div class="g-body">为在安全环境中执行可疑代码而构造的虚拟机。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟机监视器</span><span class="g-en">virtual machine monitor</span></div><div class="g-body">参见：<em>宿主操作系统</em>。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟内存</span><span class="g-en">virtual memory</span></div><div class="g-body">通过虚拟地址的按需分页，提供几乎无限物理内存的假象。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟化</span><span class="g-en">virtualization</span></div><div class="g-body">为应用提供并不实际存在的资源的假象。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">虚拟地址缓存</span><span class="g-en">virtually addressed cache</span></div><div class="g-body">使用虚拟内存地址而非物理地址访问的处理器缓存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">卷</span><span class="g-en">volume</span></div><div class="g-body">一组物理存储块，构成一个逻辑存储设备（例如逻辑磁盘）。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">持有并等待</span><span class="g-en">wait while holding</span></div><div class="g-body">发生死锁的一个必要条件：线程持有某个资源的同时等待另一个资源。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">无等待数据结构</span><span class="g-en">wait-free data structures</span></div><div class="g-body">一种并发数据结构，保证每个线程都能取得进展：无论数据结构中其他线程处于什么状态，每个方法都在有限步内完成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">等待链表</span><span class="g-en">waiting list</span></div><div class="g-body">正在等待某个同步事件或定时器到期、之后才有资格被运行的线程集合。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">磨损均衡</span><span class="g-en">wear leveling</span></div><div class="g-body">一种闪存管理策略：在设备上移动逻辑页，以确保每个物理页被写入和擦除的次数大致相同。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">Web 代理缓存</span><span class="g-en">web proxy cache</span></div><div class="g-body">对经常访问的网页所做的缓存，用于加快 Web 访问并减少网络流量。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">工作保持型调度策略</span><span class="g-en">work-conserving scheduling policy</span></div><div class="g-body">只要还有工作要做，就绝不让处理器空闲的策略。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">工作集</span><span class="g-en">working set</span></div><div class="g-body">程序在最近一段时间内引用过的内存位置集合。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">工作负载</span><span class="g-en">workload</span></div><div class="g-body">某个系统需要执行的一组任务，以及每个任务何时到达、各需多长时间完成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">创伤等待</span><span class="g-en">wound wait</span></div><div class="g-body">一种死锁恢复方法：通过中止任何死锁中最近的事务来确保进展。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">写加速</span><span class="g-en">write acceleration</span></div><div class="g-body">要存到磁盘的数据先写入磁盘的缓冲存储器，随后写操作即被确认，并在后台完成。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">写回缓存</span><span class="g-en">write-back cache</span></div><div class="g-body">一种缓存，更新可以只保存在缓存中，直到缓存空间用尽才送回内存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">写直达缓存</span><span class="g-en">write-through cache</span></div><div class="g-body">更新立即送回内存的缓存。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">零拷贝 I/O</span><span class="g-en">zero-copy I/O</span></div><div class="g-body">一种跨越内核与用户边界传送数据而无需内存到内存拷贝的技术，例如通过改写页表项来实现。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">引用时清零</span><span class="g-en">zero-on-reference</span></div><div class="g-body">只在内存被使用时才清零、而不是预先清零的方法。若对内存的首次访问触发陷入内核，内核可以将该内存清零然后恢复执行。</div></div>

<div class="gloss-item"><div class="g-head"><span class="g-zh">齐夫分布</span><span class="g-en">Zipf distribution</span></div><div class="g-body">事件出现的相对频率与其在流行度排名中的位次成反比。</div></div>

</div>
