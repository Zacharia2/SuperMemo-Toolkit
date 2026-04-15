```
emptyslots.dat 4字节、drill.dat 4字节（可能是元素id）、.sub 4字节（可能是元素id）、.lst 8字节、.mem 30字节、.ptr 4字节（可能是元素id）

SuperMemo 20 Text Registry 三文件联动架构

1. Text.ptr (指针映射表)
   - 文件: Text.ptr
   - 结构: 纯指针数组，每个元素4字节 (uint32)
   - 索引: 文本ID (1-based)
   - 内容: ptr[ID] = mem_index (mem中的排序下标)
   - 示例: ptr[5] = 2 表示ID为5的文本在mem中的下标是2

1. Text.mem (有序成员目录)
   - 文件: Text.mem
   - 结构: 每条30字节，按文本内容字母序排列
   - 结构体: TRegistryMember (Packed Record)
     struct TRegistryMember {
         use_count: uint32;  // 被引用次数
         unk1: uint32;       // 未知(通常=3)
         flags: uint16;      // 标志位
         rtx_offset: uint32; // RTX文件中的偏移量
         rtx_length: uint32; // RTX数据长度
         orig_id: uint32;    // 原始ID(创建时的ID)
         unk2: uint32;       // 未知
         unk3: uint32;       // 未知
     }
   - 示例: mem[2] 包含 Banana 的信息
   - 这里估计包含了对有htm文件的引用信息。

1. Text.rtx (原始文本存储)
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

```c
// information about all registry members stored in the given registry, e.g.:
// - number of using elements,
// - pointer to the *.rtx file storing the name of the text registry member,
// - pointer to the *.lst file storing the list of elements using a given member,
// - etc.
// 
// 对应 C# 中的 RegMemElem17，大小固定为 30 字节
struct RegMemElem17 {
    u32 useCount;               // number of elements using this registry member
    u8  linkType;               // type of link (registry type?)
    u8  unknown1;               // unknown byte
    u32 unknown2;               // unknown
    u32 rtxOffset;              // offset in *.rtx file for the name of the text registry member
    u32 rtxLength;              // length of the name in *.rtx file
    u32 lstRelated;             // physical position? (pointer to *.lst file listing elements using this member)
    u32 slotIdOrOffset;         // Id: File ; Position: Rtf, Template (component), ...
    u32 slotLengthOrConceptGroup; // Rtf, Template (component), ...
};

// SuperMemo 17 ElementInfo.dat 记录结构
// 文件大小应为 118 的整数倍，每条记录对应一个元素
// 基于 C# 结构体 InfElementsElem17 转换，保留原始注释

struct InfElementsElem17 {
    u8 elementType;     // (00: Topic/Deleted, 01: Item, 02: ?, 03: ?, 04: Concept)
    u8 unknownbyte1;
    u32 titleTextId;    // id / -1 if deleted
    u32 componPos;      // FF FF FF FF if none
    u32 unknownId;
    u32 unknown3;
    u32 unknown4;
    u32 unknown5;
    u8 unknownbyte14;
    u8 unknownbyte15;
    // 0x1C - Real48 (6-byte Delphi floating point)
    u8 AF[6];           // Real48, possibly A-Factor
    u32 unknown8;
    u32 unknown9;
    u32 unknown10;
    u32 unknown11;
    u32 unknown12;
    u32 unknown13;
    u8 unknownbyte16;
    u8 unknownbyte17;
    u8 unknownbyte18;
    u32 templateId;
    u32 conceptId;
    u8 unknownbyte19;
    u32 unknown17;
    u32 unknown18;
    u32 unknown19;
    u32 unknown20;
    u32 unknown21;
    u32 unknown22;
    u32 unknown23;
    u32 unknown24;
    u8 unknownbyte20;

    // 0x67 - 5-byte ordinal field
    u8 ordinal[5];
    u8 unknownbyte21;
    u8 unknownbyte22;
    u32 unknown27;
    u32 unknown28;      // ends at offset 0x72 (114) to 0x75 (117)
};

struct ElementInfo {
	1字节（elementType）(00: Topic/Deleted, 01: Item, 02: ?, 03: ?, 04: Concept)
	1字节（未知）
	4字节（id）
	4字节（组件位置）
	10 字节（未知）
	8字节（时间戳）
	8字节（时间戳） 
	4字节（未知） 
	4字节（id）
	74字节（未知）
}; 

04 02 01000000 ffffffff 00000000000000000000 9c8e637d5185e640 819a999999190000 00000000 00000000 000000000a000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000

00 01 02000000 d5080000 51000100000001000100 7f0ffb935185e640 819a999999198100 00000000 02000000 000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000810000000000080000000001000000

00 01 03000000 2a090000 51000100000001000100 108ecfd85185e640 819a999999198100 00000000 03000000 000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000820000000000080000000001000000

00 01 04000000 7f090000 51000100000001000100 60050c4a5285e640 819a999999198100 00000000 04000000 000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000820000000040080000000001000000
```

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

```c
// SuperMemo 17 组件磁盘存储结构 (compon.dat)
// 所有结构体均为 Pack=1，无对齐填充

// HTML 组件 - 29 字节
struct InfComponentsHtml17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[5];
    u8  isFullHtml;
    u8  unknown3[2];
    u32 registryId;
    u8  unknown4[7];
};

// 文本组件 - 35 字节
struct InfComponentsText17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[8];
    u32 registryId;
    u8  textAlignment;  // 0: Left, 1: Center, 2: Right
    u8  colorRed;
    u8  colorGreen;
    u8  colorBlue;
    u8  unknown4[9];
};

// RTF 组件 - 30 字节
struct InfComponentsRtf17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[8];
    u32 registryId;
    u8  unknown3;
    u8  colorRed;
    u8  colorGreen;
    u8  colorBlue;
    u8  unknown4[4];
};

// 拼写组件 - 35 字节
struct InfComponentsSpelling17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[8];
    u32 registryId;
    u8  unknown3[2];
    u8  colorRed;
    u8  colorGreen;
    u8  colorBlue;
    u8  unknown4[8];
};

// 图像组件 - 26 字节
struct InfComponentsImage17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[8];
    u32 registryId;
    u8  stretchType;
    u8  unknown3[3];
};

// 声音组件 - 49 字节
struct InfComponentsSound17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[8];
    u32 registryId;
    u8  unknown3[8];
    u8  textAlignment;
    u8  unknown4;
    u8  colorRed;
    u8  colorGreen;
    u8  colorBlue;
    u8  unknown5;
    u32 extractStart;
    u32 extractStop;
    bool isContinuous;
    u8  unknown6[2];
    u8  playAt;
    u8  panel;
};

// 视频组件 - 32 字节
struct InfComponentsVideo17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[4];
    bool isContinuous;
    bool isFullScreen;
    u8  unknown3[2];
    u32 registryId;
    u8  unknown4;
    u32 extractStart;
    u32 extractStop;
    u8  panel;
};

// 形状组件 - 28 字节
struct InfComponentsShape17 {
    u8  unknown1;
    i16 left;
    i16 top;
    i16 width;
    i16 height;
    u8  displayAt;
    u8  unknown2[18];
};
```
