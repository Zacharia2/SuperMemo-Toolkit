#!/usr/bin/env python3
# 极简演示：解析 content.dat 二进制数据，展示节点关系和树形图
import struct

# 您提供的五行数据（每行 37 字节）
hex_lines = """
00 00000000 02000000 04000000 00000000 00000000 04000000 02000000 00000000 00000000
00 01000000 03000000 05000000 00000000 04000000 02000000 02000000 00000000 00000000
00 02000000 00000000 00000000 00000000 05000000 00000000 00000000 00000000 00000000
00 01000000 00000000 00000000 02000000 00000000 00000000 00000000 00000000 00000000
00 02000000 00000000 00000000 03000000 00000000 00000000 00000000 00000000 00000000
"""

# 解析所有字节，过滤空字符串
data = bytes.fromhex("".join(hex_lines.split()))

REC_SIZE = 37
if len(data) % REC_SIZE != 0:
    print(f"警告：数据长度 {len(data)} 不是 {REC_SIZE} 的倍数，可能不完整。")

nodes = []
for i in range(0, len(data), REC_SIZE):
    rec = data[i : i + REC_SIZE]
    if len(rec) != REC_SIZE:
        print(f"跳过不完整的最后一条记录，长度 {len(rec)}")
        break
    fmt = "<BIIIIIIIII"
    vals = struct.unpack(fmt, rec)
    nodes.append(
        {
            "id": i // REC_SIZE + 1,
            "type": vals[0],
            "parent": vals[1],
            "first_child": vals[2],
            "last_child": vals[3],
            "prev_sibling": vals[4],
            "next_sibling": vals[5],
            "descendants": vals[6],
            "children_cnt": vals[7],
            "reserved1": vals[8],
            "reserved2": vals[9],
        }
    )

# 打印表格
print("节点表 (ID, 父, 首子, 末子, 前兄, 后兄, 后代数, 子数)")
print("-" * 70)
for n in nodes:
    print(
        f"{n['id']:2} | parent={n['parent']:2} | first={n['first_child']:2} | last={n['last_child']:2} | "
        f"prev={n['prev_sibling']:2} | next={n['next_sibling']:2} | desc={n['descendants']:2} | childcnt={n['children_cnt']:2}"
    )


# 构建树形图 (从根节点 ID=1 开始)
def print_tree(node_id, prefix="", is_last=True):
    node = nodes[node_id - 1]  # id 从1开始，列表索引从0
    label = f"{node_id}"
    connector = "└── " if is_last else "├── "
    print(prefix + connector + label)
    new_prefix = prefix + ("    " if is_last else "│   ")
    # 遍历子节点：从 first_child 开始沿 next_sibling 链
    child_id = node["first_child"]
    children = []
    while child_id != 0:
        children.append(child_id)
        child_node = nodes[child_id - 1]
        child_id = child_node["next_sibling"]
    for i, ch in enumerate(children):
        print_tree(ch, new_prefix, i == len(children) - 1)


print("\n树形结构:")
print_tree(1)
