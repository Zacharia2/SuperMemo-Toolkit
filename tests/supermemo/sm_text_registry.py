import struct
import os

class SMTextRegistry:
    def __init__(self, collection_registry_dir):
        """
        初始化需要传入 registry 文件夹路径，例如：
        'f:/sm20/systems/ABC of SuperMemo 20/registry/'
        """
        self.reg_dir = collection_registry_dir
        self.ptr_file = os.path.join(self.reg_dir, 'Text.ptr')
        self.mem_file = os.path.join(self.reg_dir, 'Text.mem')
        self.rtx_file = os.path.join(self.reg_dir, 'Text.rtx')
        
    def read_all(self):
        """
        读取并解析所有的文本内容和底层结构
        """
        if not os.path.exists(self.ptr_file):
            return []

        with open(self.ptr_file, 'rb') as f:
            ptr_data = f.read()
        with open(self.mem_file, 'rb') as f:
            mem_data = f.read()
            
        with open(self.rtx_file, 'rb') as f:
            rtx_data = f.read()
            
        num_members = len(ptr_data) // 4
        results = []
        
        # 遍历所有的 ID（ID 在 SM 中是从 1 开始的）
        for member_id in range(1, num_members + 1):
            # 获取对应的 mem_index，注意 mem_index 也是 1-based
            mem_index = struct.unpack('<I', ptr_data[(member_id-1)*4 : member_id*4])[0]
            
            if mem_index == 0:
                continue # 为 0 时说明记录已经删除或未被初始化
                
            mem_offset = (mem_index - 1) * 30
            mem_record = mem_data[mem_offset : mem_offset + 30]
            
            if len(mem_record) < 30:
                continue
                
            # 解析 Delphi 的 TRegistryMember (Packed Record) - 30 字节
            use_count, unk1, flags, rtx_offset, rtx_length, orig_id, unk2, unk3 = struct.unpack('<IIHIIIII', mem_record)
            
            # SuperMemo (Delphi) 采取 1-based offset (所以需要减 1 转换回 0-based)
            actual_offset = rtx_offset - 1 if rtx_offset > 0 else 0
            raw_text_data = rtx_data[actual_offset : actual_offset + rtx_length]
            
            # 以 null terminator 截断出核心文本
            null_idx = raw_text_data.find(b'\x00')
            if null_idx != -1:
                raw_text = raw_text_data[:null_idx]
            else:
                raw_text = raw_text_data
            
            # 由于早期SuperMemo或本地化版本可能混用 ANSI 和 UTF-8
            try:
                text_content = raw_text.decode('utf-8')
            except UnicodeDecodeError:
                try:
                    text_content = raw_text.decode('mbcs')  # 兼容 GBK/ANSI
                except:
                    text_content = raw_text.decode('utf-8', errors='replace')
                    
            results.append({
                'id': member_id,
                'mem_index': mem_index,
                'use_count': use_count,
                'text': text_content,
                'rtx_offset': rtx_offset,
                'rtx_length': rtx_length,
                'unk1': unk1,
                'flags': flags,
                'orig_id': orig_id,
                'unk2': unk2,
                'unk3': unk3
            })
            
        return results

    def add_text_record(self, new_text):
        """
        按照官方逻辑追加写入一段文本数据到 Text Registry
        包含完整的 RTX、MEM（排序重置）以及 PTR（指针修复）
        """
        # --- 1. 读取原表与所有元素供排序判断 ---
        items = self.read_all()
        # 将原有元素和即将写入的新元素整合再一块，方便排序
        if os.path.exists(self.ptr_file):
            with open(self.ptr_file, 'rb') as f:
                old_ptr = f.read()
            new_id = (len(old_ptr) // 4) + 1  # 分配下一个自增ID给新文本
        else:
            new_id = 1
        
        # --- 2. 准备新的 RTX 负荷 (Payload) ---
        text_bytes = new_text.encode('utf-8') 
        # Payload = 文本数据 + 0结尾 + 4字节的自身ID + 1字节纯文本(Plain)标记符
        rtx_payload = text_bytes + b'\x00' + struct.pack('<I', new_id) + b'\x01'
        
        # 先以追加的形式写入 .rtx 文件，记录下它的末端 offset
        new_rtx_offset = 0
        if os.path.exists(self.rtx_file):
            new_rtx_offset = os.path.getsize(self.rtx_file) + 1  # Delphi 采取 1-based
        else:
            new_rtx_offset = 1
                
        with open(self.rtx_file, 'ab') as f:
            f.write(rtx_payload)

        # 构建新的 Record dict 放入数组里以重新按字母序决定顺序
        # 排序是 Delphi 的核心机制，避免打字时搜索补全逻辑断层
        new_item = {
            'id': new_id,
            'use_count': 1,
            'text': new_text,
            'rtx_offset': new_rtx_offset,
            'rtx_length': len(rtx_payload),
            'unk1': 3, 'flags': 0, 'orig_id': new_id, 'unk2': 0, 'unk3': 0
        }
        items.append(new_item)
        
        # 以大小写不敏感方式重排，模拟 Delphi 的 AnsiCompareText
        items.sort(key=lambda x: x['text'].lower())
        
        # --- 3. 重写 Mem 和 Ptr ---
        # Mem 和 Ptr 需要被全量覆写以防引用错位
        new_mem_data = bytearray()
        new_ptr_array = [0] * new_id
        
        for new_mem_idx, item in enumerate(items, start=1):
            u1 = item.get('unk1', 3)
            fl = item.get('flags', 0)
            orig = item.get('orig_id', item['id'])
            u2 = item.get('unk2', 0)
            u3 = item.get('unk3', 0)
            
            # 打包新的 Mem 数据 (30 bytes)
            packed_mem = struct.pack('<IIHIIIII', 
                                     item['use_count'], u1, fl, 
                                     item['rtx_offset'], item['rtx_length'],
                                     orig, u2, u3)
            new_mem_data.extend(packed_mem)
            
            # 修补映射表的指向 - .ptr 数组[ 成员自身ID - 1 ] 要重新指回此时排在的 Mem 下标
            new_ptr_array[item['id'] - 1] = new_mem_idx

        # 写入物理硬盘
        with open(self.mem_file, 'wb') as f:
            f.write(new_mem_data)
            
        with open(self.ptr_file, 'wb') as f:
            for ptr_val in new_ptr_array:
                f.write(struct.pack('<I', ptr_val))
                
        print(f"[Done] 新文本 '{new_text}' 已添加。新 ID= {new_id}，物理写入位置= {new_rtx_offset}。")
        return new_id


if __name__ == "__main__":
    # 使用示例
    collection_path = r"D:\SuperMemo\systems\Reading-And-Review\registry"
    
    registry = SMTextRegistry(collection_path)
    
    # 读取全部并输出
    print("--- 当前注册表包含的词条 ---")
    data = registry.read_all()
    for row in data:
        print(f"ID: {row['id']:<4} Mem下标: {row['mem_index']:<4} 文本: {row['text']}")
        
    # 添加一个新实体（取消注释即可测试追加功能）
    # print("\n--- 进行追加写入测试 ---")
    # new_id = registry.add_text_record("Hello Python Scripts")
    # data = registry.read_all()
    # print(f"\n--- 追加后注册表总词条 (最新项 ID={new_id}) ---")
    # for row in data:
    #     print(f"ID: {row['id']:<4} Mem下标: {row['mem_index']:<4} 文本: {row['text']}")
