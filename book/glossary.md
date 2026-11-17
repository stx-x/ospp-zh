# 术语表（统一译法，必须遵守）

| 英文 | 中文 | 备注 |
|---|---|---|
| thread | 线程 | |
| multithreaded / multi-threaded | 多线程的 | |
| process | 进程 | |
| concurrency | 并发 | |
| concurrent | 并发的 | |
| parallelism | 并行 | |
| parallel | 并行的 | |
| kernel | 内核 | |
| user-level | 用户级 | |
| context switch | 上下文切换 | |
| thread control block (TCB) | 线程控制块（TCB） | |
| program counter | 程序计数器 | |
| stack pointer | 栈指针 | |
| register | 寄存器 | |
| program status word (PSW) | 程序状态字（PSW） | 若原书用 processor status word 同 |
| stack frame | 栈帧 | |
| activation record | 活动记录 | |
| scheduling | 调度 | |
| scheduler | 调度器 | 讲内核代码时可作“调度程序” |
| ready queue / run queue | 就绪队列 / 运行队列 | |
| dispatch | 分派 | |
| runnable | 可运行的 | |
| blocked | 阻塞的 | |
| suspend | 挂起 | |
| resume | 恢复 | |
| yield | 让出（处理器） | |
| preempt / preemptive | 抢占 / 抢占式 | |
| cooperative | 协作式 | |
| time slice / quantum | 时间片 / 时间配额 | |
| atomic / atomicity | 原子的 / 原子性 | |
| atomic operation | 原子操作 | |
| race condition | 竞态条件 | |
| critical section | 临界区 | |
| mutual exclusion | 互斥 | |
| lock | 锁 | |
| acquire / release | 获取 / 释放 | 讲锁时说“加锁/解锁”亦可 |
| spinlock / spin lock | 自旋锁 | |
| mutex | 互斥锁 | |
| semaphore | 信号量 | |
| condition variable | 条件变量 | |
| monitor | 管程 | |
| barrier / synchronization barrier | 屏障 / 同步屏障 | |
| readers/writers lock | 读写锁 | |
| deadlock | 死锁 | |
| livelock | 活锁 | |
| starvation | 饥饿 | |
| fairness | 公平性 | |
| priority inversion | 优先级反转 | |
| contention | 争用 | lock contention 锁争用 |
| cache coherence | 缓存一致性 | |
| memory consistency | 内存一致性 | |
| memory barrier | 内存屏障 | |
| read-copy-update (RCU) | 读-复制-更新（RCU） | |
| grace period | 宽限期 | |
| non-blocking synchronization | 非阻塞同步 | |
| lock-free | 无锁 | |
| wait-free | 无等待 | |
| compare-and-swap | 比较并交换 | |
| test-and-set | 测试并设置 | |
| load-linked / store-conditional | 链接加载 / 条件存储 | |
| fetch-and-increment | 取回并递增 | |
| two-phase locking | 两阶段加锁 | |
| acquire-all/release-all | 全部获取/全部释放 | |
| banker's algorithm | 银行家算法 | |
| safe state | 安全状态 | |
| shared object | 共享对象 | |
| monitor | 管程 | |
| bounded queue | 有界队列 | |
| FIFO | 先进先出（FIFO） | |
| SJF (shortest job first) | 最短作业优先（SJF） | |
| round robin | 轮转 | |
| max-min fairness | 最大最小公平 | |
| multi-level feedback | 多级反馈 | |
| gang scheduling | 成组调度 | |
| scheduler activations | 调度器激活 | |
| oblivious scheduling | 无感知调度 | |
| real-time scheduling | 实时调度 | |
| rate monotonic | 速率单调 | |
| earliest deadline first | 最早截止期优先 | |
| energy-aware | 能耗感知 | |
| queueing theory | 排队论 | |
| Little's Law | 利特尔定律 | |
| utilization | 利用率 | |
| response time | 响应时间 | |
| throughput | 吞吐量 | |
| latency | 延迟 | |
| overhead | 开销 | |
| arrival rate | 到达率 | |
| service time | 服务时间 | |
| overload | 过载 | |
| admission control | 准入控制 | |
| data center | 数据中心 | |
| tail latency | 尾延迟 | |
| thread pool | 线程池 | |
| event-driven | 事件驱动的 | |
| asynchronous I/O | 异步 I/O | |
| data parallel | 数据并行的 | |
| fork-join | 分叉-汇合 | |
| per-thread | 每线程的 | |
| shared state | 共享状态 | |
| thread-local | 线程局部的 | |
| interrupt | 中断 | |
| trap | 陷入 | |
| system call | 系统调用 | |
| kernel thread | 内核线程 | |
| user thread | 用户线程 | |
| lightweight process | 轻量级进程 | |
| green threads | 绿色线程 | |
| upcall | 上调 | |
| address space | 地址空间 | |
| page table | 页表 | |
| cache line | 缓存行 | |
| false sharing | 伪共享 | |
| cache miss | 缓存缺失 | |
| direct memory access (DMA) | 直接内存访问（DMA） | |
| device driver | 设备驱动程序 | |
| interrupt handler | 中断处理程序 | |
| idle thread | 空闲线程 | |
| trap handler | 陷入处理程序 | |
| system-call | 系统调用 | |
| library | 库 | |
| API | 应用程序接口（API） | 首次给出全称，后文用 API |
| stack overflow | 栈溢出 | |
| heap | 堆 | |
| code segment | 代码段 | |
| data segment | 数据段 | |
| speculative execution | 推测执行 | |
| reorder | 重排序 | |
| instruction set architecture | 指令集体系结构 | |
| compiler | 编译器 | |
| compiler reordering | 编译器重排序 | |
| workload | 负载 / 工作负载 | |
| microsecond / millisecond | 微秒 / 毫秒 | |
| instruction | 指令 | |
| throughput-oriented | 面向吞吐量的 | |
| batch | 批处理 | |
| interactive | 交互式 | |
| server | 服务器 | |
| client | 客户端 | |
| data structure | 数据结构 | |
| algorithm | 算法 | |
| invariant | 不变式 | |
| precondition / postcondition | 前置条件 / 后置条件 | |
| case study | 案例研究 | |
| rule of thumb | 经验法则 | |
| pitfall | 陷阱 | |
| summary | 小结 | |
| historical notes | 历史注记 | |
| exercises | 习题 | |
| roadmap | 本章导读 | |
| aside / sidebar | 边栏 | 模板用 `#aside` 呈现 |
| example | 例 | |
| answer | 答 | |
| hint | 提示 | |
| kernel-mode / user-mode | 内核态 / 用户态 | |
| privilege level | 特权级 | |
| trap into the kernel | 陷入内核 | |
