import asyncio
import cmd
import ctypes
import os
import shlex
import shutil
import sys
import tempfile
import time
from pathlib import Path

import click
import regex
import win32gui
from edge_tts.voices import list_voices
from tabulate import tabulate

from supermemo_toolkit.ansm_conv.sm2anki import qa_to_anki
from supermemo_toolkit.autotts.autotts import run_auto_tts
from supermemo_toolkit.database.force_reload import ForceReload
from supermemo_toolkit.database.origin_window import find_origin_window
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.database.trace import Trace, make_link
from supermemo_toolkit.database.window_focus import activate_window, send_vk
from supermemo_toolkit.epub2sm import epub_convert, format_ascii
from supermemo_toolkit.latex2img import formula_to_png
from supermemo_toolkit.latex2img.bridge import Bridge
from supermemo_toolkit.latex2img.renderer import FormulaRenderer
from supermemo_toolkit.pathpix import im_sort_out
from supermemo_toolkit.pathpix.epub_imgfit import EpubImageFit
from supermemo_toolkit.pathpix.gui import run_pathpix_ui
from supermemo_toolkit.title_xref import complete_title
from supermemo_toolkit.utilscripts import config as smtk_config
from supermemo_toolkit.utilscripts.ulils import makeNameSafe

sm_location: str = smtk_config.read_smtk_conf().get(smtk_config.PROGRAM).lower()
smtk_config_file_path = os.path.join(smtk_config.config_dir(), "conf.json")
__version__ = "0.2.8"


@click.group(
    no_args_is_help=True,
    help=f"SuperMemo 增强工具(CLI命令行)。 Ver:{__version__}\n包含集合管理、内容处理、复习导出、公式渲染、冷备份等模块。",
)
@click.version_option(version=__version__)
def main():
    pass


# ==========================================
# config
# ==========================================
@click.group()
def config():
    """管理 smtk 配置文件"""
    pass


main.add_command(config)


@config.command(name="set")
@click.argument("key")
@click.argument("value")
def config_set(key: str, value: str):
    """设置配置文件 (例如: smtk config set program D:/SuperMemo)"""
    conf_dict = smtk_config.read_config(smtk_config_file_path)
    conf_list = [
        smtk_config.PROGRAM,
        smtk_config.SYSTEMS,
        smtk_config.KNOS,
        smtk_config.VOICE,
        smtk_config.RATE,
        smtk_config.VOLUME,
    ]
    for name in conf_list:
        if key == name:
            conf_dict[key] = value
            smtk_config.dump_config(smtk_config_file_path, conf_dict)
            headers = ["Key", "Value"]
            table_data = [[key, value] for key, value in conf_dict.items()]
            click.echo(tabulate(table_data, headers))


@config.command(name="unset")
@click.argument("key")
def config_unset(key: str):
    """取消某个配置项"""
    conf_dict = smtk_config.read_config(smtk_config_file_path)
    if key in conf_dict:
        del conf_dict[key]
        smtk_config.dump_config(smtk_config_file_path, conf_dict)


async def _print_voices() -> None:
    """Print all available voices."""
    voices = await list_voices()
    voices = sorted(voices, key=lambda voice: voice["ShortName"])
    headers = ["Name", "Gender", "ContentCategories", "VoicePersonalities"]
    table = [
        [
            voice["ShortName"],
            voice["Gender"],
            ", ".join(voice["VoiceTag"]["ContentCategories"]),
            ", ".join(voice["VoiceTag"]["VoicePersonalities"]),
        ]
        for voice in voices
    ]
    click.echo(tabulate(table, headers))


@config.command(name="list")
@click.option("--voices", is_flag=True, help="打印所有可用语音模型")
@click.option("--recommend", is_flag=True, help="打印推荐可用语音模型")
def config_list(voices, recommend):
    """列出当前所有配置项"""
    if recommend:
        headers = ["Name", "Gender", "ContentCategories", "VoicePersonalities"]
        table_data = [
            [
                voice_model["Name"],
                voice_model["Gender"],
                voice_model["ContentCategories"],
                voice_model["VoicePersonalities"],
            ]
            for voice_model in smtk_config.VOICE_MODEL_LIST
        ]
        click.echo(tabulate(table_data, headers))
        return
    elif voices:
        asyncio.run(_print_voices())
        return
    else:
        conf_dict = smtk_config.read_config(smtk_config_file_path)
        for key, value in conf_dict.items():
            click.echo(f"{key}\t:\t{value}")
        return


# ==========================================
# kno
# ==========================================
@click.group()
def kno():
    """管理 SuperMemo KNO 知识集合"""
    pass


main.add_command(kno)


@kno.command(name="list")
def kno_list():
    """列出所有系统集合与离散集合"""
    if sm_location == "null":
        click.secho("Please set program location! config::program is null!", fg="red")
        return
    click.secho(f"smtk is working on: {sm_location}", fg="green")

    # 打印系统集合
    col_list = smtk_config.get_collections_primaryStorage(sm_location)
    for col_name in col_list:
        click.echo(f"集合名称: [{col_name}](program)")

    # 打印离散集合
    conf_dict = smtk_config.read_config(smtk_config_file_path)
    if smtk_config.KNOS in conf_dict and len(conf_dict[smtk_config.KNOS]) > 0:
        for item in conf_dict[smtk_config.KNOS]:
            for kno_name in item:
                click.echo(f"集合名称: [{kno_name}](kno)")


@kno.command(name="add")
@click.argument("kno_path")
def kno_add(kno_path):
    """添加离散集合"""
    conf_dict = smtk_config.read_config(smtk_config_file_path)
    if not os.path.basename(kno_path).lower().endswith(".kno"):
        click.echo("无效的集合文件路径，请提供有效的集合路径：'path/file.kno'。")
        return
    kno_name = os.path.splitext(os.path.basename(kno_path))[0]
    kno_path = os.path.join(os.path.dirname(os.path.normpath(kno_path)), kno_name)

    if smtk_config.KNOS in conf_dict and len(conf_dict[smtk_config.KNOS]) > 0:
        for item in conf_dict[smtk_config.KNOS]:
            if kno_name in item:
                item[kno_name] = kno_path

                click.echo("集合 KNO:")
                for item in conf_dict[smtk_config.KNOS]:
                    for kno_name in item:
                        click.echo(f"集合名称: [{kno_name}](kno)")

                smtk_config.dump_config(smtk_config_file_path, conf_dict)
                return
        conf_dict[smtk_config.KNOS].append({kno_name: kno_path})
    else:
        conf_dict[smtk_config.KNOS] = [{kno_name: kno_path}]

    click.echo("集合 KNO:")
    for item in conf_dict[smtk_config.KNOS]:
        for kno_name in item:
            click.echo(f"集合名称: [{kno_name}](kno)")

    smtk_config.dump_config(smtk_config_file_path, conf_dict)


@kno.command(name="remove")
@click.argument("kno_name")
def kno_remove(kno_name):
    """移除离散集合"""
    conf_dict = smtk_config.read_config(smtk_config_file_path)
    if smtk_config.KNOS in conf_dict and any(
        kno_name in x for x in conf_dict[smtk_config.KNOS]
    ):
        conf_dict[smtk_config.KNOS] = [
            x for x in conf_dict[smtk_config.KNOS] if kno_name not in x
        ]
    else:
        click.echo(f"集合 {kno_name} 不存在于配置文件中。")
        return

    click.echo("集合 KNO:")
    for item in conf_dict[smtk_config.KNOS]:
        for name in item:
            click.echo(f"集合名称: [{name}](kno)")

    smtk_config.dump_config(smtk_config_file_path, conf_dict)


def get_elements_path(col_name: str, kno=False):
    if kno:
        conf_dict = smtk_config.read_config(smtk_config_file_path)
        if smtk_config.KNOS in conf_dict and len(conf_dict[smtk_config.KNOS]) > 0:
            col_path = next(
                (x[col_name] for x in conf_dict[smtk_config.KNOS] if col_name in x),
                None,
            )
            print(f"离散集合 {col_name} 的路径: {col_path}")
            if col_path:
                elements_path = os.path.join(col_path, "elements")
            else:
                click.echo(f"离散集合 {col_name} 不存在于配置文件中。")
                return
        else:
            click.echo(f"离散集合 {col_name} 不存在于配置文件中。")
            return
    elif not kno:
        elements_path = smtk_config.get_collection_primaryStorage(sm_location, col_name)
    return os.path.normpath(elements_path)


# ==========================================
# e2sm
# ==========================================
@main.command()
@click.argument("epub_path")
@click.argument("target_folder")
@click.option("--toc", is_flag=True, help="根据目录结构转换")
@click.option("--seq", is_flag=True, help="根据线性阅读顺序转换")
@click.option("--topic", is_flag=True, help="转换为一篇 Topic 文章")
@click.option("--limit", type=int, help="Topic 分片长度限制")
@click.option("--prep", is_flag=True, help="预处理 epub，转换为纯 ASCII 字符集")
@click.option(
    "--kno-name", type=str, default=None, help="将转换后的图片放入目标 KNO 集合"
)
@click.option("--kno", is_flag=True, help="目标为离散 KNO 集合 (非系统集合)")
def e2sm(epub_path, target_folder, toc, seq, topic, limit, prep, kno_name, kno):
    """转换 EPUB 格式图书或预处理为纯 ASCII"""
    if toc:
        if kno_name:
            epub_convert.start_with_toc(
                epub_path,
                target_folder,
                os.path.join(get_elements_path(kno_name, kno), "local_pic"),
            )
            click.echo(
                f"已将转换好的图片文件夹放到目标 {kno_name} 集合 local_pic 文件夹下。"
            )
        else:
            epub_convert.start_with_toc(epub_path, target_folder)
        return
    elif seq:
        if kno_name:
            epub_convert.start_with_seq(
                epub_path,
                target_folder,
                os.path.join(get_elements_path(kno_name, kno), "local_pic"),
            )
            click.echo(
                f"已将转换好的图片文件夹放到目标 {kno_name} 集合 local_pic 文件夹下。"
            )
        else:
            epub_convert.start_with_seq(epub_path, target_folder)
        return
    elif topic:
        if not limit:
            if kno_name:
                epub_convert.start_with_topic(
                    epub_path,
                    target_folder,
                    None,
                    os.path.join(
                        get_elements_path(kno_name, kno), "elements", "local_pic"
                    ),
                )
                click.echo(
                    f"已将转换好的图片文件夹放到目标 {kno_name} 集合 local_pic 文件夹下。"
                )
            else:
                epub_convert.start_with_topic(epub_path, target_folder, None)
        else:
            if kno_name:
                epub_convert.start_with_topic(
                    epub_path,
                    target_folder,
                    limit,
                    os.path.join(get_elements_path(kno_name, kno), "local_pic"),
                )
                click.echo(
                    f"已将转换好的图片文件夹放到目标集合: {kno_name} 指定文件夹下。"
                )
            else:
                epub_convert.start_with_topic(epub_path, target_folder, limit)
        return
    elif prep:
        format_ascii.epub_format_to_ascii(epub_path, target_folder)
        return


# ==========================================
# pathpix
# ==========================================
@main.group(invoke_without_command=True)
@click.argument("col_name", required=False)
@click.option("--clean", is_flag=True, help="清理集合中未使用图片")
@click.option(
    "--fullpath",
    type=click.Path(
        exists=True, file_okay=True, dir_okay=False, readable=True, path_type=str
    ),
    help="整理单个HTML文件(component menu(Alt+F12) >> FIle >> Copy path)",
)
@click.option("--gui", is_flag=True, help="运行图形窗口")
@click.option("--least-col", is_flag=True, help="整理最后使用的集合 (最后关闭的集合)")
@click.option("--kno", is_flag=True, help="离散 KNO 集合 (非系统集合)")
@click.pass_context
def pathpix(ctx, col_name, clean, fullpath, least_col, gui, kno):
    """整理集合图片: 本地图片->相对路径化、网络图片->本地化"""
    if ctx.invoked_subcommand is None:
        if sm_location == "null":
            click.secho(
                "Please set program location! config::program is null!", fg="red"
            )
            return
        click.secho("smtk is working on: " + sm_location, fg="green")
        if least_col:
            sm_system1 = smtk_config.read_sm_system1(sm_location)
            least_used_col = smtk_config.get_collection_primaryStorage(
                sm_location, sm_system1
            )
            im_sort_out.start(least_used_col)
            return
        elif col_name:
            elements_path = get_elements_path(col_name, kno)
            if clean:
                im_sort_out.organize_unused_im(elements_path)
            else:
                im_sort_out.start(elements_path)
            return
        elif fullpath:
            im_sort_out.single_file(fullpath)
            return
        elif gui:
            run_pathpix_ui()
            return
        else:
            click.echo(ctx.get_help())
            return


@pathpix.command(name="transfer")
@click.argument("src_kno")
@click.argument("dst_kno")
@click.option("--kno", is_flag=True, help="离散 KNO 集合 (非系统集合)")
def pathpix_transfer(src_kno, dst_kno, kno):
    """在两个集合之间转移由 PathPix 管理的图片"""
    click.echo(f"转移集合中 web 和 local 文件夹图片: 从 {src_kno} 到 {dst_kno}")
    im_sort_out.transfer_images(
        get_elements_path(src_kno, kno), get_elements_path(dst_kno, kno)
    )
    click.echo("图片转移完成")


# ==========================================
# imgfit
# ==========================================
@main.command()
@click.option(
    "--trace",
    "tracing",
    is_flag=True,
    default=False,
    help="追踪当前元素进行处理并标记",
)
@click.option("--ignore", "ignore", is_flag=True, help="忽略已处理标记, 重新处理一次")
@click.option(
    "--max-width",
    "max_width",
    type=int,
    default=1200,
    help="设置图片最大宽度 (px)",
)
def imgfit(tracing, ignore, max_width):
    """调整当前元素中图片的尺寸，使其排版更合适"""
    CONTINUE = not tracing

    def work(text_reg: TextRegistry) -> bool:
        if text_reg is None or text_reg.eId == None:
            return CONTINUE
        path = (
            text_reg.eComponents[1].mPath
            if text_reg.eComponents is not None and len(text_reg.eComponents) > 0
            else ""
        )
        if path == "" or not os.path.exists(path):
            return CONTINUE
        try:
            url = Path(path).resolve().as_uri()
        except Exception:
            url = path  # 如果本来就是 URL，就直接用

        IMG_RE = regex.compile(
            r"""(?isx)
            <!--.*?-->                                         (*SKIP)(*F)
            | <(?:script|style)\b[^>]*>.*?</(?:script|style)>  (*SKIP)(*F)
            | <(?:img|image)(?=[\s/>])(?:"[^"]*"|'[^']*'|[^>"'])*>
            """
        )
        IMG_RE_CLASS = regex.compile(
            rf"\b(?:{'|'.join([f'smtk-{x}' for x in img_fitter.style])})\b"
        )

        with open(path, "r", encoding="utf-8") as fs:
            htm = fs.read()

        progress_count = len(IMG_RE_CLASS.findall(htm))
        has_progress = progress_count > 0
        if has_progress and not ignore:
            click.echo(
                f"[No. {text_reg.eId}] [跳过] 已存在 {progress_count} 个标记，无需重复处理。"
            )
            return CONTINUE

        count = len(IMG_RE.findall(htm))
        if count > 0:
            click.echo(f"[No. {text_reg.eId}] [Title: {text_reg.eTitle[:12].strip()}]")
            if tracing:
                hwnd = find_origin_window()
                if hwnd is None:
                    print(f"[No. {id}] 命令行程序未找到可聚焦的顶层窗口")
                    return CONTINUE
                activate_window(hwnd)
                with force_reload:
                    if not os.path.exists(path):
                        click.echo(
                            f"[No. {text_reg.eId}] [跳过] FileNotFoundError [Path: {make_link(path, url)}]"
                        )
                        return CONTINUE
                    img_fitter.process_file(path)
            else:
                with force_reload:
                    if not os.path.exists(path):
                        click.echo(
                            f"[No. {text_reg.eId}] [跳过] FileNotFoundError [Path: {make_link(path, url)}]"
                        )
                        return CONTINUE
                    img_fitter.process_file(path)
            click.echo(
                f"[No. {text_reg.eId}] [图片尺寸适配完成] [Path: {make_link(path, url)}]"
            )

        return CONTINUE

    force_reload = ForceReload()
    trace = Trace()
    img_fitter = EpubImageFit(page_width=max_width)
    if force_reload.online_and_has_force_addr is not None:
        trace.trace_with_mem(work)
        force_reload.detach()


# ==========================================
# Other single commands
# ==========================================
@main.command()
@click.argument("qafile")
@click.option("--deckname", type=str, help="设置目标牌组名 (默认 SuperMemo Cards)")
def sm2anki(qafile, deckname):
    """发送问答卡 (Item) 到 Anki"""
    if deckname:
        ms2a = qa_to_anki(qafile)
        ms2a.setDeckName(deckname)
        ms2a.sent_cards()
    else:
        ms2a = qa_to_anki(qafile)
        ms2a.sent_cards()


@main.command()
@click.argument("htmtoc")
@click.option("--node", type=str, help="设置 NodeAsText 文件路径")
@click.option("--xml", type=str, help="设置 XML 文件路径")
def comptitle(htmtoc: str, node: str, xml: str):
    """修补导出的 NodeAsText / XML 中的标题乱码"""
    if not node and not xml:
        print("需要输入待修复的文件路径 (NodeAsText OR XML)")
        return
    elif node and not xml:
        complete_title.comp_node_title(nodefile=node, tocfile=htmtoc)
        return
    elif xml and not node:
        complete_title.comp_xml_title(xmlfile=xml, tocfile=htmtoc)
        return


@main.command()
@click.option("--onlyat", is_flag=True, help="仅使用拷贝发音功能")
def autotts(onlyat):
    """运行 AutoTTS 卡片朗读 文本转语音"""
    run_auto_tts(onlyat)


@main.command()
@click.option("--mem", is_flag=True, help="通过扫描内存追踪当前元素")
@click.option("--his", is_flag=True, help="打印浏览过的历史 ID")
def trace(mem, his):
    """追踪当前元素，并输出当前元素信息"""
    trace = Trace()
    if mem:
        trace.print_info(mode="m")
    else:
        trace.print_info(mode="o")


@main.command()
@click.option("--re", "pattern", type=str, help="根据正则条件插入水平分割线")
@click.option(
    "--n", "limit", type=int, help="根据字数条件插入水平分割线 (推荐 1000 字)"
)
@click.option("--id", "eid", type=int, help="根据元素 ID 条件插入水平分割线")
@click.option(
    "--trace",
    "tracing",
    is_flag=True,
    default=False,
    help="追踪模式：持续处理切走的元素",
)
@click.option("--recover", is_flag=True, help="清除文档分割符标记")
def splitline(pattern, limit, eid, tracing, recover):
    """在当前元素中根据条件插入水平分割线"""
    CONTINUE = not tracing

    # 字数默认推荐1000字，按段落分。
    def _atomic_write(
        path: str, content: str, force_reload: ForceReload, id: int, times: bool
    ):
        CONTINUE = not times
        dir_name = os.path.dirname(os.path.abspath(path))
        fd, tmp = tempfile.mkstemp(prefix=".smtk_", suffix=".tmp", dir=dir_name)
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as f:
                f.write(content)
                f.flush()
                os.fsync(f.fileno())
            if times:
                hwnd = find_origin_window()
                if hwnd is None:
                    print(f"[No. {id}] 命令行程序未找到可聚焦的顶层窗口")
                    return CONTINUE
                activate_window(hwnd)
                with force_reload:
                    os.replace(tmp, path)
            else:
                with force_reload:
                    os.replace(tmp, path)
        except BaseException as e:
            if os.path.exists(tmp):
                os.remove(tmp)
            print(f"[No. {id}] {e}")

    def work(text_reg: TextRegistry):
        # terminate == True 终止
        if text_reg is None or text_reg.eId == None:
            return CONTINUE
        path = (
            text_reg.eComponents[1].mPath
            if text_reg.eComponents is not None and len(text_reg.eComponents) > 0
            else ""
        )
        if path == "" or not os.path.exists(path):
            return CONTINUE
        try:
            url = Path(path).resolve().as_uri()
        except Exception:
            url = path
        click.echo(f"[No. {text_reg.eId}] [Title: {text_reg.eTitle[:12].strip()}]")

        with open(path, "r", encoding="utf-8") as fs:
            htm = fs.read()

        # 清除标记
        # <hr id="smtk-regex"> <hr id="smtk-number">
        exist_mark = regex.compile(r'(?i)<hr\s+id="?smtk-(?:regex|number)"?>')
        if recover is True:
            recovered_htm = exist_mark.sub("", htm)
            _atomic_write(path, recovered_htm, force_reload, text_reg.eId, times=False)
            cleared_count = sum(1 for _ in exist_mark.finditer(recovered_htm))
            if cleared_count != 0:
                click.echo(f"[No. {text_reg.eId}] [分割符标记清除失败]")
                return True  # 终止
            click.echo(f"[No. {text_reg.eId}] [分割符标记清除完成]")
            return True  # 终止

        # 备份未标记文件，如果已经分割，就不用备份了。
        exist_mark_count = sum(1 for _ in exist_mark.finditer(htm))
        if exist_mark_count == 0:
            root, namedpath = path.split("elements")
            filename = makeNameSafe(f"El#{text_reg.eId}-Path{namedpath}")
            temp = os.path.join(root, "temp", filename)
            shutil.copyfile(path, temp)
            click.echo(f"[No. {text_reg.eId}] [Backups: {temp}]")

        if pattern:
            try:
                regex_pattern = regex.compile(pattern)
                count = sum(1 for _ in regex_pattern.finditer(htm))
                if count == 0:
                    click.echo(f"[No. {text_reg.eId}] 没有找到匹配项")
                    return not tracing
                # 仅一次分割，多次分割可以清除标记再次分割
                if count == exist_mark_count or exist_mark_count > 0:
                    click.echo(
                        f"[No. {text_reg.eId}] [跳过] 已存在 {exist_mark_count} 个标记分隔符，无需重复处理。"
                    )
                    return CONTINUE

                click.echo(f"[No. {text_reg.eId}] [找到 {count} 个匹配项]")
                inserted = regex_pattern.sub(
                    lambda m: '<hr id="smtk-regex">' + m.group(0), htm
                )
            except regex.error as e:
                click.echo(f"[No. {text_reg.eId}] 正则表达式无效: {e}", err=True)
                return CONTINUE
            stop = (
                _atomic_write(path, inserted, force_reload, text_reg.eId, tracing)
                is None
            )
            if not stop:
                return CONTINUE
        elif limit is not None:
            try:
                if exist_mark_count != 0:
                    click.echo(
                        f"[No. {text_reg.eId}] [跳过] 已存在 {exist_mark_count} 个标记分隔符，无需重复处理。"
                    )
                    return CONTINUE

                # 没有分割过，才执行分割
                inserted = epub_convert.split_html_with_lenght(htm, limit)
                exist_inserted_mark_count = sum(
                    1 for _ in exist_mark.finditer(inserted)
                )
                if exist_inserted_mark_count == 0:
                    click.echo(f"[No. {text_reg.eId}] 长度小于1000字符, 不需要分割")
                    return CONTINUE
                click.echo(
                    f"[No. {text_reg.eId}] [找到 {exist_inserted_mark_count} 个匹配项]"
                )
            except Exception as e:  # noqa: BLE001
                click.echo(f"{e}", err=True)
                return CONTINUE
            stop = (
                _atomic_write(path, inserted, force_reload, text_reg.eId, tracing)
                is None
            )
            if not stop:
                return CONTINUE

        click.echo(
            f"[No. {text_reg.eId}] [分割线插入完成] [Path: {make_link(path, url)}]"
        )
        return CONTINUE

    force_reload = ForceReload()
    trace = Trace()
    if force_reload.online_and_has_force_addr is not None:
        if not eid:
            trace.trace_with_mem(work)
        else:
            work(trace.trace_with_id(eid))
        force_reload.detach()


# ==========================================
# time
# ==========================================
@click.group(name="time")
def time_cmd():
    """SuperMemo 集合冷备份 (实验期)"""
    pass


main.add_command(time_cmd)


def _load_time_backup():
    try:
        from supermemo_toolkit.time_rewind.time_rewind import (
            GitError,
            SuperMemoBackup,
            setup_logging,
        )
    except ImportError as e:
        raise click.ClickException(
            f"无法导入 time_backup 模块：{e}\n"
            "请确认 time_backup.py 位于 PYTHONPATH 中，并已安装 pystray、Pillow。"
        )
    return SuperMemoBackup, GitError, setup_logging


def _make_backup_manager():
    SuperMemoBackup, GitError, setup_logging = _load_time_backup()
    setup_logging()
    try:
        sm = SuperMemoBackup.from_config()
    except SystemExit as e:
        raise click.ClickException(str(e))
    return sm, GitError


@time_cmd.command(name="backup")
@click.option("--collection", "-c", default=None, help="集合名，默认全部集合")
@click.option(
    "--trigger",
    default="manual",
    show_default=True,
    type=click.Choice(["manual", "shutdown", "tray", "debug"], case_sensitive=False),
    help="触发来源",
)
def time_backup(collection, trigger):
    """冷备份集合 (集合必须已关闭)

    注意: 如果集合处于激活状态 (.kno 被锁定)，备份将直接失败。
    """
    sm, GitError = _make_backup_manager()
    names = [collection] if collection else [c.name for c in sm.config.collections]
    if not names:
        raise click.ClickException(
            "没有发现任何集合，请检查 smtk config 的 program / knos 设置。"
        )
    failed = 0
    for name in names:
        try:
            r = sm.backup(name, trigger=trigger)
        except KeyError:
            click.echo(f"{name}: 集合不存在", err=True)
            failed += 1
            continue
        except GitError as e:
            click.echo(f"{name}: git 错误: {e}", err=True)
            failed += 1
            continue
        except RuntimeError as e:
            click.echo(f"{name}: 跳过（{e}）", err=True)
            failed += 1
            continue

        if r.skipped:
            click.echo(f"{name}: 无变更，跳过 ({r.commit[:8] if r.commit else 'N/A'})")
        else:
            click.echo(f"{name}: 已备份 {r.commit[:8]}")

    if failed:
        raise click.ClickException(f"{failed} 个集合备份失败")


@time_cmd.command(name="restore")
@click.argument("collection")
@click.argument("target")
def time_restore(collection, target):
    """冷恢复集合到指定 commit / ref

    TARGET 可以是完整 hash、短 hash 或 ref (如 refs/smtk/archive)。
    恢复前会自动校验工作区干净及 .kno 一致性；失败时自动回滚。
    """
    sm, GitError = _make_backup_manager()
    try:
        r = sm.restore(collection, target)
    except KeyError:
        raise click.ClickException(f"集合不存在: {collection}")
    except (GitError, RuntimeError) as e:
        raise click.ClickException(str(e))

    click.echo(f"已恢复 {collection} -> {r.target[:8] if r.target else r.target}")
    if r.old_head:
        click.echo(f"恢复前 HEAD: {r.old_head[:8]}")


@time_cmd.command(name="compact")
@click.option("--collection", "-c", default=None, help="集合名，默认全部")
def time_compact(collection):
    """压缩历史：将 hot tip 折叠为 archive snapshot

    此操作由用户手动触发，不会自动执行。
    折叠后旧 hot commit 变为 dangling，2 周内可通过 git fsck --lost-found 找回。
    """
    sm, GitError = _make_backup_manager()
    names = [collection] if collection else [c.name for c in sm.config.collections]
    if not names:
        raise click.ClickException("没有发现任何集合。")

    failed = 0
    for name in names:
        try:
            r = sm.compact(name)
        except KeyError:
            click.echo(f"{name}: 集合不存在", err=True)
            failed += 1
            continue
        except (GitError, RuntimeError) as e:
            click.echo(f"{name}: 错误: {e}", err=True)
            failed += 1
            continue

        status = "✓" if r.folded else "·"
        click.echo(f"{status} {name}: {r.message}")

    if failed:
        raise click.ClickException(f"{failed} 个集合压缩失败")


@time_cmd.command(name="list")
@click.argument("collection", required=False)
def time_list(collection):
    """列出集合的快照历史 (archive + hot 链)"""
    sm, _ = _make_backup_manager()
    if collection:
        try:
            sm.list_snapshots(collection)
        except KeyError:
            raise click.ClickException(f"集合不存在: {collection}")
        return

    initialized = sm.initialized_collections()
    if not initialized:
        click.echo("没有已初始化的集合。")
        return
    for c in initialized:
        sm.list_snapshots(c.name)
        click.echo()


@time_cmd.command(name="watch")
def time_watch():
    """启动托盘监控 (阻塞，轮询 .kno 锁定状态)

    检测到集合关闭后自动触发 backup(trigger='shutdown')。
    """
    sm, _ = _make_backup_manager()
    sm.watch()


@time_cmd.command(name="forget")
@click.argument("collection")
@click.option("--yes", "-y", is_flag=True, help="跳过确认")
def time_forget(collection, yes):
    """让指定集合遗忘 Git 历史：删除 .git 目录，保留工作区数据

    卸载前会检查：集合未激活、无未提交改动、外部 .kno 与 HEAD 一致。
    """
    sm, GitError = _make_backup_manager()

    try:
        _ = sm.get_collection(collection)
    except KeyError:
        raise click.ClickException(f"集合不存在: {collection}")

    if not sm.collection(collection).is_initialized():
        click.echo(f"{collection}: 无 .git，跳过")
        return

    if not yes:
        click.confirm(
            f"将卸载 {collection} 的 git 仓库，删除 .git 后历史将无法恢复。继续？",
            abort=True,
        )

    try:
        ok = sm.forget(collection)
    except GitError as e:
        raise click.ClickException(f"{collection}: git 错误: {e}")
    except RuntimeError as e:
        raise click.ClickException(f"{collection}: 拒绝卸载（{e}）")

    if ok:
        click.echo(f"{collection}: 已卸载")
    else:
        click.echo(f"{collection}: 无 .git，跳过")


# ==========================================
# math
# ==========================================
@click.group()
def math():
    """数学公式处理: 渲染当前卡片公式、单次生成公式图片"""
    pass


main.add_command(math)


@math.command(name="card")
@click.option(
    "--trace",
    "tracing",
    is_flag=True,
    default=False,
    help="追踪模式：持续处理切走的元素",
)
@click.option("--ignore", "ignore", is_flag=True, help="忽略无变化检查，强制重跑")
def math_card(tracing, ignore):
    """对当前元素中的 $$公式$$ 进行渲染，并支持就地编辑"""
    CONTINUE = not tracing
    bridge = Bridge() if tracing else None
    trace = Trace()  # ← 提到 on_save 之前

    def on_save(cid: str) -> bool:
        hwnd = trace.telwind_hwnd
        if hwnd is None:
            return False
        if not activate_window(hwnd):
            return False
        if win32gui.GetForegroundWindow() != hwnd:
            return False  # 激活被抢回，别发键
        time.sleep(0.05)
        ok1 = send_vk(ord("E"), ctrl=True)  # Ctrl+E
        time.sleep(0.12)
        ok2 = send_vk(0x1B)  # Esc
        ok2 = send_vk(0x1B)  # Esc
        return ok1 and ok2

    if bridge is not None:
        bridge.on_save = on_save

    def work(text_reg: TextRegistry) -> bool:
        if text_reg is None or text_reg.eId == None:
            return CONTINUE
        path = (
            text_reg.eComponents[1].mPath
            if text_reg.eComponents is not None and len(text_reg.eComponents) > 0
            else ""
        )
        if path == "" or not os.path.exists(path):
            return CONTINUE

        base_dir = Path(path).parent

        elements_root = base_dir
        while (
            elements_root.name.lower() != "elements"
            and elements_root.parent != elements_root
        ):
            elements_root = elements_root.parent

        if elements_root.name.lower() != "elements":
            click.echo(f"[No. {text_reg.eId}] [错误] 无法定位 elements 目录，跳过")
            return CONTINUE

        try:
            url = Path(path).resolve().as_uri()
        except Exception:
            url = path

        click.echo(f"[No. {text_reg.eId}] [Title: {text_reg.eTitle[:12].strip()}]")

        renderer = FormulaRenderer(elements_root, bridge=bridge)

        with open(path, "r", encoding="utf-8") as fs:
            htm = fs.read()

        new_html = renderer.process_html(htm)
        if new_html == htm and not ignore:
            click.echo(f"[No. {text_reg.eId}] [跳过] 公式无变化")
            return CONTINUE

        if tracing:
            hwnd = find_origin_window()
            if hwnd is None:
                print(f"[No. {text_reg.eId}] 命令行程序未找到可聚焦的顶层窗口")
                return CONTINUE
            activate_window(hwnd)
            with force_reload:
                if not os.path.exists(path):
                    return CONTINUE
                renderer.process_file(Path(path), new_html)
        else:
            with force_reload:
                if not os.path.exists(path):
                    return CONTINUE
                renderer.process_file(Path(path), new_html)

        click.echo(
            f"[No. {text_reg.eId}] [公式渲染完成] [Path: {make_link(path, url)}]"
        )
        return CONTINUE

    force_reload = ForceReload()
    if force_reload.online_and_has_force_addr is not None:
        trace.trace_with_mem(work)
        force_reload.detach()


@math.command(name="imtex")
@click.argument("formula_text")
@click.argument("outpath")
def math_imtex(formula_text, outpath):
    """单次转换 LaTeX 公式到 png 图片"""
    formula_to_png.latex2img_md(
        text=formula_text,
        size=48,
        color=(0.1, 0.8, 0.8),
        out=outpath,
    )


class Shell(cmd.Cmd):
    prompt = ">"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 只在交互模式下 chdir，避免污染 CLI 的 CWD
        os.chdir(os.path.dirname(sys.executable))
        self.intro = (
            f"\nSuperMemo 增强工具(交互模式), Ver:{__version__}。输入 smtk 查看帮助。\n"
            f"cwd: {os.path.dirname(sys.executable).lower()}\n"
        )

    def do_smtk(self, arg: str):
        if arg.strip() != "":
            try:
                args_list = shlex.split(arg)
            except ValueError as e:
                print(f"参数解析错误: {e}")
                return
            sys.argv = ["smtk"] + args_list
        else:
            sys.argv = ["smtk"]
        try:
            main(standalone_mode=False)
        except click.exceptions.NoArgsIsHelpError as info:
            print(info)
        except SystemExit:
            pass
        except Exception as e:
            print(f"执行出错: {e}")

    def default(self, arg: str):
        print(f"未知命令: {arg}. 请输入 'smtk' 查看可用命令.")

    def do_exit(self, arg):
        """退出程序"""
        return True

    def emptyline(self):
        """直接按回车时，什么都不做"""


def is_launched_from_gui():
    """检查是否从 GUI (如双击) 启动"""
    if os.name != "nt":
        return False

    # 有命令行参数 → 命令行调用，不是 GUI 双击
    if len(sys.argv) > 1:
        return False
    kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
    # 创建一个长度为1的数组，API会返回实际连接的总进程数
    process_array = (ctypes.c_uint * 1)()
    num_processes = kernel32.GetConsoleProcessList(process_array, 1)

    # 如果返回的进程数 <= 2，大概率是从GUI启动的
    return num_processes <= 2


if __name__ == "__main__":
    # (?i)忽略大小写, 注意属性引号可能是零个或者一个
    # r"(?i)(?s)<p>(?!<b>)\s*.*?</p>"
    # r'(?i)(?s)<p class="block">.*?</p>\s*\K<p>'
    # r'(?i)(?s)<p class="?block"?>.*?</p>\s*\K<p>(?!<b>)'
    # 全部都是文本参数
    # main.commands["splitline"](
    #     ["--re", r'(?i)(?s)<p class="block">.*?</p>\s*\K<p>'], standalone_mode=False
    # )
    # main.commands["imgfit"](["--trace", "--ignore"], standalone_mode=False)
    # main.commands["math"](["card", "--trace"], standalone_mode=False)
    # main.commands["pathpix"](["Reading-And-Review", "--clean"], standalone_mode=False)
    if is_launched_from_gui():
        try:
            import pyi_splash  # type: ignore

            pyi_splash.close()
        except ImportError:
            pass
        Shell().cmdloop()
    else:
        try:
            main()
        except click.exceptions.NoArgsIsHelpError:
            pass
        except SystemExit:
            pass
