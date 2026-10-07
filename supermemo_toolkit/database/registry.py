import os
import struct
from collections import namedtuple
from enum import IntEnum


# LinkType 表示链接类型
class LinkType(IntEnum):
    DELETED = 0
    RTF = 1
    FILE_AND_RTX = 2
    RTX = 3
    FILE = 5


class ElementType(IntEnum):
    TOPIC = 0  # 主题/文章
    ITEM = 1  # 项目（问答/填空）
    TASK = 2  # 任务
    TEMPLATE = 3  # 模板
    CONCEPT_GROUP = 4  # 概念组


class ElementStatus(IntEnum):
    PENDING = 0  # 不在学习队列，等待处理
    MEMORIZED = 1  # 在学习队列，会按时复习
    DISMISSED = 2  # 遗忘：既不在学习队列也不在待处理队列
    DELETED = 3  # 已删除（仅占位）


COMPONENT_TYPES = {
    "HTM": {"TYPE": 7181, "LEN": 29},
    "WebView": {"TYPE": 7184, "LEN": 29},
    "Text": {"TYPE": 8704, "LEN": 35},  # NoFile，直接存文本注册表
    "RTF": {"TYPE": 7436, "LEN": 30},
    "Spelling": {"TYPE": 8705, "LEN": 35},
    "Image": {"TYPE": 6402, "LEN": 26},
    "Sound": {"TYPE": 12291, "LEN": 49},
    "Video": {"TYPE": 7940, "LEN": 32},
    "ShapeEllipse": {"TYPE": 6917, "LEN": 28},
    "ShapeRect": {"TYPE": 6918, "LEN": 28},
    "ShapeRoundedRect": {"TYPE": 6919, "LEN": 28},
}


class TextRegistry:
    # 元素Id、文本注册表的Pos是动态的，在每次切换后就会动态更新到新值。而这个新值是可以在组件文件中访问到。
    # 设计为函数式的，实时读取文件并计算状态。暂时仅限正在显示的当前元素。
    # 一般情况下，若为topic就选第零个组件，若为item就选第零和第一个组件。

    eId = None
    eTitle = None
    eType = None
    eComponents = None

    def __init__(self, system_dir: str):
        self.__system_dir: str = system_dir

        self.__elinfo_path: str = os.path.join(system_dir, "info", "ElementInfo.dat")
        self.__compon_path: str = os.path.join(system_dir, "info", "compon.dat")
        self.__mem_file: str = os.path.join(system_dir, "registry", "Text.mem")
        self.__rtx_file: str = os.path.join(system_dir, "registry", "Text.rtx")

    def __parse_elinfo(self) -> list:
        """解析 ElementInfo.dat，返回记录列表（包含 element_type, title_text_id, compon_pos）"""
        # ElementInfo.dat，行号下标就是元素id，删除和添加元素不会行号下标都不会变。
        results = [None]  # 1-based 列表，index 0 占位

        RECORD_SIZE = 118
        RECORD_STRUC = struct.Struct("< B B I I 108x")

        with open(self.__elinfo_path, "rb") as f:
            while True:
                data = f.read(RECORD_SIZE)
                if len(data) < RECORD_SIZE:
                    break
                unpacked = RECORD_STRUC.unpack(data[: RECORD_STRUC.size])
                element_type = ElementType(unpacked[0])  # 0: Topic, 1: Item, 4: Concept
                title_text_id = unpacked[2]
                compon_pos = unpacked[3]
                # 转换为有符号整数（compon_pos 可为 -1）
                if compon_pos >= 2**31:
                    compon_pos -= 2**32
                results.append(
                    {
                        "element_type": element_type,
                        "title_text_id": title_text_id,
                        "compon_pos": compon_pos,
                    }
                )
        return results

    def __get_member_by_position(self, member_position: int):

        # 检查文件是否存在
        if not os.path.exists(self.__mem_file):
            return None
        with open(self.__mem_file, "rb") as f:
            mem_data = f.read()

        # 验证数据长度
        if len(mem_data) % 30 != 0:
            return None

        # 构建 members 列表（1-based 元组）
        # 字节序：小端，格式字符串对应字段顺序
        # https://github.com/supermemo/SuperMemoAssistant/blob/develop/src/Core/SuperMemoAssistant.Core/SuperMemo/SuperMemo17/Files/RegMemElem17.cs
        # lst（和一个mem成员关联的元素列表（一（member）对多（元素）列表））
        # lst 行号1522 (同时也是members index)，内容是元素id
        # prt 行号1522 (同时也是members index)，内容是 members的行号(Position)
        # members 行号6461 (Position)，内容是 member(UseCount=1, LinkType=2, RtxId=0, RtxOffset=6832362, RtxLength=10625, XX=2613, SlotId=1846, Empty=0, Reserved=0)
        # 01000000 0300 00000000 01000000 19000000 01000000 00000000 00000000
        # 01000000 03 00 00000000 01000000 19000000 01000000 00000000 00000000
        Member = namedtuple(
            "Member",
            [
                "UseCount",  # uint32, offset 0 没问题
                "LinkType",  # uint16, offset 4 没问题
                "unknown1",  # uint32, offset 6
                "RtxOffset",  # uint32, offset 10
                "RtxLength",  # uint32, offset 14
                "LstRelated",  # uint32, offset 18
                "SlotId",  # uint32, offset 22 没问题
                "unknown2",  # uint32, offset 26
            ],
        )
        member_fmt = struct.Struct("<IHIIIIII")
        members = (
            None,
            *[
                Member(
                    fields[0],
                    LinkType(fields[1]),
                    fields[2],
                    fields[3],
                    fields[4],
                    fields[5],
                    fields[6] if fields[6] != 0 else None,
                    fields[7],
                )
                for fields in member_fmt.iter_unpack(mem_data)
            ],
        )

        # 检查内存索引是否有效
        if not (1 <= member_position < len(members)):
            return None
        return members[member_position]

    def __compute_element_path(self, slot: int, extension: str = "HTM") -> str:
        base = [10, 300, 9000, 270000, 8100000]
        limit = [10, 310, 9310, 279310, 8379310]

        # 确定目录级数 i（满足 slot <= limit[i] 的最小 i）
        i = 0
        while i < len(limit) and slot > limit[i]:
            i += 1

        if i == 0:
            dirs = []  # 无子目录
        else:
            rem = slot - limit[i - 1]  # 减去上一级的累计上限
            dirs = []
            for j in range(i, 0, -1):  # 从高位到低位生成目录数字
                b = base[j - 1]
                digit = (rem - 1) // b + 1
                rem -= b * (digit - 1)
                dirs.append(str(digit))

        path_parts = [self.__system_dir, "elements"] + dirs + [f"{slot}.{extension}"]
        return "\\".join(path_parts)

    def __get_member_component_group_positions(self, compon_pos: int):
        """
        根据 compon_pos （组件组起始偏移）从 compon.dat 中解析组件组，
        找到类型为 HTM、WV、Text 的组件，并返回其 registryId。
        若失败或找不到，则返回 None。
        """

        if compon_pos == -1:
            return None

        try:
            with open(self.__compon_path, "rb") as f:
                # 1. 组件组
                # 组件组头（11字节），一个组件组 = 一个元素，一个组件组（元素）有多个组件
                # | 组头标记 | 组长度 | 未知数据 | 组件数量 | 跳过偏移 |
                # |   31D4   |  5700  | 00000000 |    01    |   2B00   |
                f.seek(compon_pos)
                header_data = f.read(11)
                if len(header_data) < 11:
                    return None

                # https://github.com/supermemo/SuperMemoAssistant/blob/develop/src/Core/SuperMemoAssistant.Core/SuperMemo/SuperMemo17/Files/InfComponentsElem17.cs
                # 已知 compon_pos 偏移，直接打开 compon.dat 文件，定位到 compon_pos 偏移。
                # 验证组件组头 31D4，读取 length、compCount 等字段。
                # 循环读取组件，对每个组件：
                # 读取 2 字节类型头。
                # 如果是目标类型（7181、8704 或 7184），则读取对应的固定结构体（例如 InfComponentsHtml17 或 InfComponentsText17），提取 registryId 及其他所需字段，然后立即返回。
                # 如果不是目标类型，则根据该类型的结构体大小跳过该组件（因为结构体长度固定，可直接 Seek 跳过）。
                # 如果循环结束仍未找到，返回空。

                # 2. 组件
                count = struct.unpack("<B", header_data[8:9])[0]
                # 在组件组中，定位到第一个组件，跳过偏移两字节，切片[9,~),从第10个元素下标为9开始切。
                skip_offset = struct.unpack("<H", header_data[9:])[0]
                first_comp_offset = compon_pos + 11 + skip_offset
                f.seek(first_comp_offset)

                components = {}
                for i in range(1, count + 1):
                    # 读取组件类型
                    comp_start_offset = f.tell()
                    TYPE_SIZE = 2  # 组件类型字段长度为 2 字节，所有组件都一样。
                    type_data = f.read(TYPE_SIZE)
                    if len(type_data) < TYPE_SIZE:
                        return None
                    comp_type = struct.unpack("<H", type_data)[0]

                    # HTM和WV一模一样
                    # 根据组件类型解析组件数据，提取 registryId
                    # 类型头 7181 原二进制 0x1C0D, 解包小端后：0x0D1C, 解包函数struct.unpack('<H', data)
                    # 组件类型0d1c, 跟上29个固定长度字节，其中 [19，23) 的四个字节是 Pos
                    # HTM：0d1c (00 6800 cf00 e225 5d24 ff 0000000000 01 0000 [5b070000] 00000000000000)
                    # WV： 101c (00 5700 7800 7b25 6c25 ff 0000000000 01 0000 [6f070000] 00000000000000)
                    if (
                        comp_type == COMPONENT_TYPES["HTM"]["TYPE"]
                        or comp_type == COMPONENT_TYPES["WebView"]["TYPE"]
                        or comp_type == COMPONENT_TYPES["Text"]["TYPE"]
                    ):
                        # registryId 在组件数据中的偏移量，所有组件都一样。
                        POS_OFFSET = 18
                        f.seek(comp_start_offset + len(type_data) + POS_OFFSET)
                        components[i] = struct.unpack("<I", f.read(4))[0]
                    f.seek(
                        comp_start_offset
                        + len(type_data)
                        + COMPONENT_TYPES.get(
                            next(
                                (
                                    k
                                    for k, v in COMPONENT_TYPES.items()
                                    if v["TYPE"] == comp_type
                                ),
                                None,
                            )
                        )["LEN"]
                    )

                return components
        except OSError:
            return None

    def __get_rtx_text(self, offset: int, length: int) -> str:
        # Text.rtx (原始文本存储) 根据元素id可推断出知识树的文本标题。
        # 格式: [UTF-8文本] + [null终止符] + [4B自身ID] + [1B类型标记] CTRL+N粘贴就会产生53字节的02放在两条数据中间。
        # 示例: 知识树标题文本 + 00（\0） + 03 00 00 00 + 01
        if not (os.path.exists(self.__rtx_file)):
            return ""
        with open(self.__rtx_file, "rb") as f:
            rtx_data = f.read()

        # 解析文本标题
        # SuperMemo (Delphi) 采取 1-based offset (所以需要减 1 转换回 0-based)
        actual_offset = offset - 1 if offset > 0 else 0
        raw_text_data = rtx_data[actual_offset : actual_offset + length]

        # 以 null terminator 截断出核心文本
        null_idx = raw_text_data.find(b"\x00")
        if null_idx != -1:
            raw_text = raw_text_data[:null_idx]
        else:
            raw_text = raw_text_data

        try:
            text_content = raw_text.decode("utf-8")
        except UnicodeDecodeError:
            try:
                text_content = raw_text.decode("mbcs")  # 兼容 GBK/ANSI
            except UnicodeDecodeError:
                text_content = raw_text.decode("utf-8", errors="replace")
        return text_content

    def refresh(self, element_id: int):
        self.eId = element_id
        records = self.__parse_elinfo()
        record = records[self.eId] if 0 < self.eId < len(records) else None
        if record is None:
            self.eId = None
            self.eType = None
            self.eTitle = None
            self.eComponents = None
            return

        # 解析元素类型和标题
        self.eType = record["element_type"]
        tMember = self.__get_member_by_position(record["title_text_id"])
        self.eTitle = self.__get_rtx_text(tMember.RtxOffset, tMember.RtxLength)

        # 解析组件组，获取组件信息
        self.eComponents = {}
        Component = namedtuple(
            "Component",
            ["mPosition", "mLinkType", "mPath", "eText"],
        )
        component_group_positions = self.__get_member_component_group_positions(
            record["compon_pos"]
        )
        for compon_id, position in component_group_positions.items():
            # mIndex = None  # members_current_index
            # mUse = None  # number_of_users_of_the_member
            # mPosition = None  # members_physical_position
            # mSlot = None  # filespace_slot_used_by_the_member
            # mPath = None  # members_filespace_path
            # mLinkType = None  # members_link_type
            # eText = None

            # 空值守卫
            if position is None:
                continue
            cMember = self.__get_member_by_position(position)
            if cMember is None:
                continue

            # 异常警报
            if cMember.SlotId is None and (
                cMember.LinkType is LinkType.FILE_AND_RTX
                or cMember.LinkType is LinkType.FILE
            ):
                print(f"[Registry] 元素={self.eId} slot=0, pos={position}")

            # 读成员数据
            mPath = (
                self.__compute_element_path(cMember.SlotId)
                if cMember.SlotId != None
                else ""
            )
            eText = self.__get_rtx_text(cMember.RtxOffset, cMember.RtxLength)
            self.eComponents[compon_id] = Component(
                mPosition=position,
                mLinkType=cMember.LinkType,
                mPath=mPath,
                eText=eText,
            )


if __name__ == "__main__":
    # 测试代码
    currEl = TextRegistry(r"D:\SuperMemo\systems\Reading-And-Review")
    currEl.refresh(element_id=1255)
    pass

    # \systems\Reading-And-Review\temp\文件夹下自动生成当前显示的元素：Element#2582-Component#1.htm，
    # 可以直接读取这个或者根据这个文件名读取源文件。至少可以维护一个当前显示元素表了
