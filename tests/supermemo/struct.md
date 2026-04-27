```
emptyslots.dat 4字节、drill.dat 4字节（可能是元素id）、.sub 4字节（可能是元素id）、.lst 8字节、.mem 30字节、.ptr 4字节（可能是元素id）

SuperMemo 20 Text Registry 三文件联动架构

1. Text.ptr (指针映射表)
   - 文件: Text.ptr
   - 结构: 纯指针数组，每个元素4字节 (uint32)
   - 索引: 文本ID (1-based)
   - 内容: ptr[ID] = mem_index (mem中的排序下标)
   - 示例: ptr[5] = 2 表示ID为5的文本在mem中的下标是2

2. Text.mem (有序成员目录)
   - 文件: Text.mem
   - 结构: 每条30字节，按文本内容字母序排列

3. Text.rtx (原始文本存储)
   - 文件: Text.rtx
   - 结构: 变长记录，只增不删
   - 格式: [UTF-8文本] + [null终止符] + [4B自身ID] + [1B类型标记]
   - 示例: 知识树标题文本 + 00（\0） + 03 00 00 00 + 01
   - 这样知道元素id就知道了知识树的文本标题了。
   - CTRL+N粘贴就会产生53字节的02放在两条数据中间。

查找流程:
1. 通过文本ID查Text.ptr -> 得到mem_index
2. 通过mem_index读Text.mem -> 得到rtx_offset和rtx_length
3. 通过offset+length去Text.rtx截取 -> 得到原始文本
```

ElementInfo.dat — 118 bytes/record, Little-Endian

Offset  Size  Type       Field
──────  ────  ─────────  ──────────────────────────────────
0x00    1B    u8         elementType    (0=Topic, 1=Item, 4=Concept)
0x01    1B    u8         level          (0=root, 1=child, 2=concept)
0x02    4B    u32        titleTextId
0x06    4B    u32        componPos      (0xFFFFFFFF=无内容)
0x0A    2B    u16        componentId_lo
0x0C    2B    u16        componentId_hi
0x0E    2B    u16        childIndex[0]
0x10    2B    u16        childIndex[1]
0x12    2B    u16        childIndex[2]
0x14    8B    double     creationDate   (TDateTime, base 1899-12-30)
0x1C    6B    Real48     A-Factor       (1.3~10.0, bias=128)
0x22    6B    Real48     stageFactor    (2^n + Reps, bias=128)
0x28    4B    compound   reps+date      (u8 Reps @0x27, u16 lastRepDate @0x28 unix days)
0x2C    4B    u32        (date ext)
0x30    1B    u8         L              (10=reviewed, 0=unreviewed)
0x31    1B    u8         Lapses
0x32    1B    u8         (学习类别1: 0/7/19)
0x3D    4B    u32        (学习类别2: 7/19)
0x4D    8B    double     parentDate     (TDateTime, 父元素日期)
0x55    4B    u32        (unused, =0)
0x59    4B    u32        (unused, =0)
0x61    6B    Real48     interval       (0~3.0+, 非ForgettingIndex)
0x67    6B    Real48     priorityScore  (0~42477, 与AF+Reps相关)
0x6D    1B    u8         const8         (=8)
0x6E    4B    u32        ordinal
0x72    2B    u16        (padding/trailer)
──────  ────
Total   118B

Real48: 1B exp + 5B mantissa LE, value = (1 + mant/2^40) × 2^(exp-128), exp=0 → 0.0

```go
// ContentNode 对应 content.dat 中的一条记录（37 字节）uint32是4字节、Type是1字节
type ContentNode struct {
	Deleted      uint8  // 类型标记（通常为 0）
	ParentId       uint32 // 父节点 ID
	FirstChild   uint32 // 第一个子节点 ID
	LastChild    uint32 // 最后一个子节点 ID
	PrevSibling  uint32 // 前一个兄弟节点 ID
	NextSibling  uint32 // 后一个兄弟节点 ID
	DescendantCount  uint32 // 后代总数（不含自身）
	ChildrenCount uint32 // 直接子节点数
	Reserved1    uint32 // 保留字段
	Reserved2    uint32 // 保留字段
}
// 固定记录大小
const ContentNodeSize = 1 + 9*4 // 37 字节

type ElementType int
const (
    Topic       ElementType = iota // 0 - 主题/文章
    Item                            // 1 - 项目（问答/填空）
    Task                            // 2 - 任务
    Template                        // 3 - 模板
    ConceptGroup                    // 4 - 概念组
)

type ElementStatus int
const (
	Pending   ElementStatus = iota // 0 - 不在学习队列，等待处理
	Memorized                      // 1 - 在学习队列，会按时复习
	Dismissed                      // 2 - 遗忘：既不在学习队列也不在待处理队列
	Deleted                        // 3 - 已删除（仅占位）
)

// RegistryLinkType 表示链接类型
type RegistryLinkType int32
const (
	LinkTypeDeleted    RegistryLinkType = 0 // 已删除
	LinkTypeRtf        RegistryLinkType = 1 // RTF 格式
	LinkTypeFileAndRtx RegistryLinkType = 2 // 文件和RTX
	LinkTypeRtx        RegistryLinkType = 3 // 仅RTX（字符串数据）
	LinkTypeFile       RegistryLinkType = 5 // 仅外部文件
)
// RegistryMember 对应 SuperMemo 注册表成员的内存数据结构
// 二进制布局与 .mem / .rtx 文件中的记录严格对应（小端序）
type RegistryMember struct {
	// ----- .mem 文件中的固定长度字段 -----
	ID                       int32            // 成员唯一ID
	UseCount                 int32            // 引用计数
	LinkType                 RegistryLinkType // 链接类型
	RtxID                    int32            // RTX记录ID
	RtxOffset                int32            // 在.rtx文件中的偏移量（字节）
	RtxLength                int32            // 字符串数据长度（字节）
	SlotIDOrOffset           int32            // 槽位ID或偏移量
	SlotLengthOrConceptGroupID int32          // 槽位长度或概念组ID
	Empty                    byte             // 0=false, 1=true (bool)
	// ----- 动态长度字段（不存储在.mem中，由RtxLength决定）-----
	// RtxValue 在解析时单独从 .rtx 读取，不嵌入此结构体
}
```
