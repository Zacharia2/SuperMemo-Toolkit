#!/usr/bin/env python3
"""
Delphi 菜单字体大小补丁脚本
功能：在二进制文件中定位固定模式并修改常量值
模式：mov rcx, [rax+110h] + mov edx, imm32
机器码：48 8B 88 10 01 00 00 BA ?? ?? ?? ??
"""

import struct

def patch_delphi_menu_font(file_path, old_value=15, new_value=9, backup=True):
    """
    修改 Delphi 程序中的菜单字体大小常量

    :param file_path: 目标 exe 文件路径
    :param old_value: 原始常量值（默认 15）
    :param new_value: 新常量值（默认 9）
    :param backup: 是否自动备份原文件
    :return: 是否成功修改
    """
    # 准备要搜索的模式：固定头部 + BA + old_value 小端字节
    # 固定头部: 48 8B 88 10 01 00 00
    fixed_head = bytes([0x48, 0x8B, 0x88, 0x10, 0x01, 0x00, 0x00])
    # mov edx, imm32 的操作码
    mov_edx_op = 0xBA
    # old_value 的小端表示（4字节）
    old_imm_bytes = struct.pack("<I", old_value)
    # 完整搜索模式
    search_pattern = fixed_head + bytes([mov_edx_op]) + old_imm_bytes

    # 读取整个文件
    try:
        with open(file_path, "rb") as f:
            data = f.read()
    except FileNotFoundError:
        print(f"错误：文件 {file_path} 不存在")
        return False
    except PermissionError:
        print(f"错误：没有权限读取文件 {file_path}")
        return False

    # 查找所有匹配位置
    positions = []
    start = 0
    while True:
        pos = data.find(search_pattern, start)
        if pos == -1:
            break
        positions.append(pos)
        start = pos + 1

    if len(positions) == 0:
        print(f"未找到模式（old_value={old_value}）")
        print("请检查 old_value 是否正确，或模式是否已变化")
        return False
    elif len(positions) > 1:
        print(f"警告：找到 {len(positions)} 处匹配，不唯一！")
        print("位置：")
        for p in positions:
            print(f"  0x{p:X}")
        print("将只修改第一处，建议人工确认。")
    else:
        print(f"找到唯一匹配，偏移 0x{positions[0]:X}")

    target_offset = (
        positions[0] + len(fixed_head) + 1
    )  # 跳过 BA 操作码，指向立即数的起始
    # 校验该位置的旧值
    actual_old = data[target_offset : target_offset + 4]
    if actual_old != old_imm_bytes:
        print(f"校验失败：预期旧值 {old_imm_bytes.hex()}，实际 {actual_old.hex()}")
        return False

    # 执行修改
    try:
        with open(file_path, "r+b") as f:
            f.seek(target_offset)
            f.write(struct.pack("<I", new_value))
        print(
            f"成功将 {hex(old_value)} 修改为 {hex(new_value)} (偏移 0x{target_offset:X})"
        )
        return True
    except Exception as e:
        print(f"写入失败：{e}")
        return False
