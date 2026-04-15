import re
import zipfile
from io import BytesIO
from bs4 import BeautifulSoup


def convert_html_content(html_bytes: bytes) -> bytes:
    """
    将 HTML 内容（UTF-8 编码的 bytes）中的非 ASCII 字符转为数字字符实体，
    返回纯 ASCII 的 bytes 内容。
    """
    # 解码为字符串
    html_str = html_bytes.decode("utf-8")
    # 使用 BeautifulSoup 解析
    html_clean = re.sub(r"^<\?xml.*?\?>\s*", "", html_str, flags=re.MULTILINE)
    soup = BeautifulSoup(html_clean, "html.parser")
    entity_bytes = soup.encode(encoding="ascii", errors="xmlcharrefreplace")
    entity_bytes += b'<?xml version="1.0" encoding="utf-8-sig"?>\n'
    entity_bytes = str(entity_bytes, "ascii").encode("utf-8-sig")
    return entity_bytes  # 已经是纯 ASCII 的 bytes


def process_epub_in_memory(input_epub_path: str, output_epub_path: str):
    """
    在内存中处理 EPUB 文件：
    1. 读取原始 EPUB（ZIP）到内存
    2. 遍历 ZIP 内所有条目，识别 .htm/.html/.xhtml 文件并转换内容
    3. 重新打包为新的 EPUB（确保 mimetype 文件为第一个条目且不压缩）
    """
    # 读取原始 EPUB 到内存
    with open(input_epub_path, "rb") as f:
        input_zip_data = BytesIO(f.read())

    # 创建一个新的内存 ZIP 文件用于写入
    output_zip_buffer = BytesIO()

    with (
        zipfile.ZipFile(input_zip_data, "r") as zin,
        zipfile.ZipFile(
            output_zip_buffer, "w", compression=zipfile.ZIP_DEFLATED
        ) as zout,
    ):
        # 先处理 mimetype 文件（EPUB 规范要求它是 ZIP 中的第一个文件且不压缩）
        # 检查原始 ZIP 中是否存在 mimetype
        if "mimetype" in zin.namelist():
            mimetype_data = zin.read("mimetype")
            # 写入 mimetype，使用 ZIP_STORED 不压缩
            zout.writestr(
                zipfile.ZipInfo("mimetype"),
                mimetype_data,
                compress_type=zipfile.ZIP_STORED,
            )

        # 遍历所有文件条目（排除已处理的 mimetype）
        for item in zin.infolist():
            if item.filename == "mimetype":
                continue  # 已处理

            file_data = zin.read(item.filename)

            # 判断是否为 HTML/XHTML 文件
            if item.filename.lower().endswith((".htm", ".html", ".xhtml")):
                try:
                    # 转换内容
                    modified_data = convert_html_content(file_data)
                    # 写入转换后的数据
                    zout.writestr(item, modified_data)
                except Exception as e:
                    print(f"警告：处理文件 {item.filename} 时出错：{e}")
                    # 出错时保留原文件
                    zout.writestr(item, file_data)
            else:
                # 非 HTML 文件，原样写入
                zout.writestr(item, file_data)

    # 将内存中的新 ZIP 数据写入磁盘文件
    with open(output_epub_path, "wb") as f:
        f.write(output_zip_buffer.getvalue())

    print(f"处理完成，输出文件：{output_epub_path}")


if __name__ == "__main__":
    input_file = r"C:\Users\Snowy\Desktop\Early Retirement Extreme_ A phi - Fisker, Jacob Lund.epub"
    output_file = r"C:\Users\Snowy\Desktop\Early Retirement Extreme_ A phi - Fisker, Jacob Lund.epub_实体版.epub"

    process_epub_in_memory(input_file, output_file)
