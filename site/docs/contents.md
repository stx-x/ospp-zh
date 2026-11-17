---
title: 完整目录
---

# 完整目录

<div class="toc-vol">

<h2>第一卷　内核与进程</h2>
<div class="toc-vol-en">Volume 1: Kernels and Processes</div>
<a class="toc-ch" href="/ospp-zh/vol1/ch1">
<span class="toc-ch-no">第 1 章</span>
<span class="toc-ch-title">引论</span>
<span class="toc-ch-en">Introduction</span>
</a>
<div class="toc-secs">
1.1　什么是操作系统？<br>
1.2　操作系统的评价<br>
1.3　操作系统：过去、现在与未来<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol1/ch2">
<span class="toc-ch-no">第 2 章</span>
<span class="toc-ch-title">内核抽象</span>
<span class="toc-ch-en">The Kernel Abstraction</span>
</a>
<div class="toc-secs">
2.1　进程抽象<br>
2.2　双模式操作<br>
2.3　模式切换的类型<br>
2.4　实现安全的模式切换<br>
2.5　综合实例：x86 上的模式切换<br>
2.6　实现安全的系统调用<br>
2.7　启动一个新进程<br>
2.8　实现上调<br>
2.9　案例研究：引导操作系统内核<br>
2.10　案例研究：虚拟机<br>
2.11　总结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol1/ch3">
<span class="toc-ch-no">第 3 章</span>
<span class="toc-ch-title">编程接口</span>
<span class="toc-ch-en">The Programming Interface</span>
</a>
<div class="toc-secs">
3.1　进程管理<br>
3.2　输入/输出<br>
3.3　案例研究：实现一个外壳<br>
3.4　案例研究：进程间通信<br>
3.5　操作系统结构<br>
3.6　小结与未来方向<br>
</div>
</div>

<div class="toc-vol">
<h2>第二卷　并发</h2>
<div class="toc-vol-en">Volume 2: Concurrency</div>
<a class="toc-ch" href="/ospp-zh/vol2/ch4">
<span class="toc-ch-no">第 4 章</span>
<span class="toc-ch-title">并发与线程</span>
<span class="toc-ch-en">Concurrency and Threads</span>
</a>
<div class="toc-secs">
4.1　线程的使用场景<br>
4.2　线程抽象<br>
4.3　简单的线程 API<br>
4.4　线程的数据结构与生命周期<br>
4.5　线程的生命周期<br>
4.6　实现内核线程<br>
4.7　把内核线程与单线程用户进程结合起来<br>
4.8　实现多线程进程<br>
4.9　其他抽象<br>
4.10　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol2/ch5">
<span class="toc-ch-no">第 5 章</span>
<span class="toc-ch-title">共享对象的同步访问</span>
<span class="toc-ch-en">Synchronizing Access to Shared Objects</span>
</a>
<div class="toc-secs">
5.1　挑战<br>
5.2　组织共享对象<br>
5.3　锁：互斥<br>
5.4　条件变量：等待变化<br>
5.5　共享对象的设计与实现<br>
5.6　三个案例研究<br>
5.7　同步对象的实现<br>
5.8　信号量：弊大于利<br>
5.9　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol2/ch6">
<span class="toc-ch-no">第 6 章</span>
<span class="toc-ch-title">多对象同步</span>
<span class="toc-ch-en">Multi-Object Synchronization</span>
</a>
<div class="toc-secs">
6.1　多处理器锁性能<br>
6.2　锁的设计模式<br>
6.3　锁争用<br>
6.4　多对象原子性<br>
6.5　死锁<br>
6.6　非阻塞同步<br>
6.7　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol2/ch7">
<span class="toc-ch-no">第 7 章</span>
<span class="toc-ch-title">调度</span>
<span class="toc-ch-en">Scheduling</span>
</a>
<div class="toc-secs">
7.1　单处理器调度<br>
7.2　多处理器调度<br>
7.3　能耗感知调度<br>
7.4　实时调度<br>
7.5　排队论<br>
7.6　过载管理<br>
7.7　案例研究：数据中心里的服务器<br>
7.8　小结与未来方向<br>
</div>
</div>

<div class="toc-vol">
<h2>第三卷　内存管理</h2>
<div class="toc-vol-en">Volume 3: Memory Management</div>
<a class="toc-ch" href="/ospp-zh/vol3/ch8">
<span class="toc-ch-no">第 8 章</span>
<span class="toc-ch-title">地址转换</span>
<span class="toc-ch-en">Address Translation</span>
</a>
<div class="toc-secs">
8.1　地址转换的概念<br>
8.2　走向灵活的地址转换<br>
8.3　走向高效的地址转换<br>
8.4　软件保护<br>
8.5　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol3/ch9">
<span class="toc-ch-no">第 9 章</span>
<span class="toc-ch-title">缓存与虚拟内存</span>
<span class="toc-ch-en">Caching and Virtual Memory</span>
</a>
<div class="toc-secs">
9.1　缓存的概念<br>
9.2　存储层次<br>
9.3　缓存何时有效、何时无效<br>
9.4　内存缓存查找<br>
9.5　置换策略<br>
9.6　案例研究：内存映射文件<br>
9.7　案例研究：虚拟内存<br>
9.8　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol3/ch10">
<span class="toc-ch-no">第 10 章</span>
<span class="toc-ch-title">高级内存管理</span>
<span class="toc-ch-en">Advanced Memory Management</span>
</a>
<div class="toc-secs">
10.1　零拷贝 I/O<br>
10.2　虚拟机<br>
10.3　容错<br>
10.4　安全<br>
10.5　用户级内存管理<br>
10.6　小结与未来方向<br>
</div>
</div>

<div class="toc-vol">
<h2>第四卷　持久存储</h2>
<div class="toc-vol-en">Volume 4: Persistent Storage</div>
<a class="toc-ch" href="/ospp-zh/vol4/ch11">
<span class="toc-ch-no">第 11 章</span>
<span class="toc-ch-title">文件系统：导论与概述</span>
<span class="toc-ch-en">File Systems: Introduction and Overview</span>
</a>
<div class="toc-secs">
11.1　文件系统抽象<br>
11.2　应用程序接口<br>
11.3　软件层次<br>
11.4　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol4/ch12">
<span class="toc-ch-no">第 12 章</span>
<span class="toc-ch-title">存储设备</span>
<span class="toc-ch-en">Storage Devices</span>
</a>
<div class="toc-secs">
12.1　磁盘<br>
12.2　闪存<br>
12.3　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol4/ch13">
<span class="toc-ch-no">第 13 章</span>
<span class="toc-ch-title">文件与目录</span>
<span class="toc-ch-en">Files and Directories</span>
</a>
<div class="toc-secs">
13.1　实现概述<br>
13.2　目录：为数据命名<br>
13.3　文件：查找数据<br>
13.4　综合运用：文件与目录访问<br>
13.5　小结与未来方向<br>
</div>
<a class="toc-ch" href="/ospp-zh/vol4/ch14">
<span class="toc-ch-no">第 14 章</span>
<span class="toc-ch-title">可靠存储</span>
<span class="toc-ch-en">Reliable Storage</span>
</a>
<div class="toc-secs">
14.1　事务：原子更新<br>
14.2　错误检测与纠正<br>
14.3　小结与未来方向<br>
</div>
</div>

<div class="toc-vol">
<h2>附录</h2>
<a class="toc-ch" href="/ospp-zh/appendix/glossary"><span class="toc-ch-no">附录</span><span class="toc-ch-title">术语表</span></a>
<a class="toc-ch" href="/ospp-zh/appendix/references"><span class="toc-ch-no">附录</span><span class="toc-ch-title">参考文献</span></a>
<a class="toc-ch" href="/ospp-zh/appendix/authors"><span class="toc-ch-no">附录</span><span class="toc-ch-title">关于作者</span></a>
</div>
