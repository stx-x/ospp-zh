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

## 第四卷 持久存储：补充术语

| 英文 | 中文 | 备注 |
|---|---|---|
| persistent storage / non-volatile storage / stable storage | 持久存储 / 非易失存储 / 稳定存储 | 三者同义，行文统一用“持久存储” |
| volatile | 易失的 | |
| file system | 文件系统 | |
| file | 文件 | |
| directory | 目录 | |
| path / pathname | 路径 / 路径名 | |
| volume | 卷 | |
| partition | 分区 | |
| mount / unmount | 挂载 / 卸载 | |
| mount point | 挂载点 | |
| hard link | 硬链接 | |
| soft link / symbolic link | 软链接 / 符号链接 | |
| directed acyclic graph (DAG) | 有向无环图（DAG） | |
| file number | 文件号 | |
| file offset | 文件偏移量 | |
| block | 块 | 存储分配单位 |
| sector | 扇区 | 磁盘最小读写单位 |
| track | 磁道 | |
| cylinder | 柱面 | |
| platter | 盘片 | |
| surface | 盘面 | |
| spindle | 主轴 | |
| disk head | 磁头 | |
| arm / arm assembly | 磁臂 / 磁臂组件 | |
| head crash | 磁头碰撞 | |
| track skewing | 磁道偏斜 | |
| sector sparing / slip sparing | 扇区备用 / 滑动备用 | |
| buffer memory | 缓冲存储器 | 磁盘控制器上的缓存 |
| track buffering | 磁道缓冲 | |
| write acceleration | 写加速 | |
| tagged command queueing (TCQ) / native command queueing (NCQ) | 标记命令排队（TCQ）/ 原生命令排队（NCQ） | |
| logical block address (LBA) | 逻辑块地址（LBA） | |
| seek / seek time | 寻道 / 寻道时间 | |
| head switch time | 磁头切换时间 | |
| rotational latency | 旋转延迟 | |
| transfer time | 传输时间 | |
| surface transfer time / host transfer time | 盘面传输时间 / 主机传输时间 | |
| disk scheduling | 磁盘调度 | |
| elevator algorithm / SCAN / CSCAN | 电梯算法 / SCAN / CSCAN | 算法名保留英文 |
| shortest seek time first (SSTF) / shortest positioning time first (SPTF) | 最短寻道时间优先（SSTF）/ 最短定位时间优先（SPTF） | |
| flash memory | 闪存 | |
| solid state drive (SSD) | 固态硬盘（SSD） | |
| floating gate transistor | 浮栅晶体管 | |
| page | 页 | 闪存的读写单位；与虚拟内存的“页”同译，靠上下文区分 |
| erase block | 擦除块 | |
| wear leveling | 磨损均衡 | |
| flash translation layer (FTL) | 闪存转换层（FTL） | |
| write amplification | 写放大 | |
| phase change memory (PCM) | 相变存储器（PCM） | |
| memristor | 忆阻器 | |
| device driver | 设备驱动程序 | |
| interrupt handler | 中断处理程序 | |
| direct memory access (DMA) | 直接内存访问（DMA） | |
| memory-mapped I/O | 内存映射 I/O | |
| port-mapped I/O | 端口映射 I/O | |
| programmed I/O | 程序控制 I/O | |
| I/O bus / memory bus | I/O 总线 / 存储总线 | |
| poll / polling | 轮询 | |
| superblock | 超级块 | |
| inode | 索引节点（inode） | |
| indirect pointer / double indirect / triple indirect | 间接指针 / 双重间接指针 / 三重间接指针 | |
| block group | 块组 | |
| free space bitmap | 空闲空间位图 | |
| extent | 区段 | NTFS 用语 |
| master file table (MFT) | 主文件表（MFT） | |
| B+tree | B+ 树 | |
| copy-on-write (COW) | 写时复制（COW） | |
| update-in-place | 原地更新 | |
| uberblock | uberblock | 保留英文（ZFS 顶级块） |
| dnode | dnode | 保留英文 |
| space map | 空间映射表 | |
| checksum | 校验和 | |
| Merkle tree | 默克尔树 | |
| snapshot | 快照 | |
| transaction | 事务 | |
| atomic / atomicity | 原子的 / 原子性 | |
| redo log | 重做日志 | |
| undo log | 撤销日志 | |
| write-ahead logging | 预写日志 | |
| log record | 日志记录 | |
| checkpoint | 检查点 | |
| idempotent | 幂等的 | |
| replay | 重放 | |
| crash recovery | 崩溃恢复 | |
| intent log | 意图日志 | |
| journaling file system | 日志文件系统 | |
| RAID (redundant array of inexpensive disks) | 独立磁盘冗余阵列（RAID） | |
| mirroring | 镜像 | |
| striping | 条带化 | |
| parity | 奇偶校验 | |
| stripe | 条带 | |
| reconstruction | 重构 | |
| scrubbing | 巡检 | disk scrubbing 磁盘巡检 |
| MTTF (mean time to failure) | 平均无故障时间（MTTF） | |
| MTTR (mean time to repair) | 平均修复时间（MTTR） | |
| MTTDL (mean time to data loss) | 平均数据丢失时间（MTTDL） | |
| bit error rate | 误码率 | |
| non-recoverable read error | 不可恢复读错误 | |
| latent sector error | 潜伏扇区错误 | |
| bad block | 坏块 | |
| remap | 重映射 | |
| error correcting code (ECC) | 纠错码（ECC） | |
| Reed-Solomon | 里德-所罗门码 | |
| SMART (Self-Monitoring, Analysis, and Reporting Technology) | 自我监测、分析与报告技术（SMART） | |
| bathtub model | 浴盆模型 | |
| infant mortality | 早期失效 | |
| wear out | 磨损失效 | |
| failure mode | 失效模式 | |
| reliability / availability / durability | 可靠性 / 可用性 / 持久性 | |
| access control | 访问控制 | |
| permission bits | 权限位 | |
| user id / group id | 用户标识 / 组标识 | |
| setuid / setgid | setuid / setgid | 保留英文 |
| buffer cache / page cache | 缓冲区高速缓存 / 页高速缓存 | |
| read-ahead / prefetch | 预读 / 预取 | |
| write-back / write-through | 回写 / 直写 | |
| fragmentation | 碎片 | |
| locality | 局部性 | |
| IOPS | 每秒 I/O 次数（IOPS） | |
| throughput / bandwidth | 吞吐量 / 带宽 | |
| latency | 延迟 | |
| random access / sequential access | 随机访问 / 顺序访问 | |
| file descriptor | 文件描述符 | |
| open / close / read / write / seek | 打开 / 关闭 / 读 / 写 / 定位 | 系统调用名保留英文原形 |
| rename | 重命名 | |
| truncate | 截断 | |
| memory map (mmap) | 内存映射（mmap） | |
| offset | 偏移量 | |
| append | 追加 | |
| cache | 高速缓存 | |

