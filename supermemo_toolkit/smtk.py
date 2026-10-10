import asyncio
import cmd
import ctypes
import os
from pathlib import Path
import re
import shlex
import shutil
import sys

import click
from edge_tts.voices import list_voices
from tabulate import tabulate

from supermemo_toolkit.ansm_conv.sm2anki import qa_to_anki
from supermemo_toolkit.autotts.autotts import run_auto_tts
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.database.trace import Trace, make_link
from supermemo_toolkit.epub2sm import epub_convert, format_ascii
from supermemo_toolkit.latex2img import formula_to_png
from supermemo_toolkit.pathpix import im_sort_out
from supermemo_toolkit.pathpix.gui import run_pathpix_ui
from supermemo_toolkit.title_xref import complete_title
from supermemo_toolkit.utilscripts import config as smtk_config
from supermemo_toolkit.utilscripts.ulils import makeNameSafe

sm_location: str = smtk_config.get_config().get(smtk_config.PROGRAM).lower()
smtk_config_file_path = os.path.join(smtk_config.get_config_dir(), "conf.json")
__version__ = "0.2.3"


@click.group(
    no_args_is_help=True,
    context_settings={"help_option_names": []},
    help=f"SuperMemo 增强工具(CLI命令行)。 Ver:{__version__}\n包含图链整理、EPUB图书转换导入、Latex公式转图片、sm2anki、修补导出标题乱码、AutoTTS 卡片朗读等。",
)
@click.version_option(version=__version__)
def main():
    pass


@click.group()
def config():
    """设置 smtk 配置文件"""


main.add_command(config)


@config.command(name="set")
@click.argument("key")
@click.argument("value")
def config_set(key: str, value: str):
    """设置配置文件, 例如: Key Value"""
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
    """取消某个配置"""
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
    """列出当前所有配置"""
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


@click.group()
def kno():
    """管理 SuperMemo KNO 知识集合"""


main.add_command(kno)


@kno.command(name="list")
def kno_list():
    """列出所有集合"""
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
    """添加集合"""
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
    """删除集合"""
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


@main.command()
@click.argument("epub_path")
@click.argument("target_folder")
@click.option("--toc", is_flag=True, help="根据目录结构转换")
@click.option("--seq", is_flag=True, help="根据线性阅读顺序转换")
@click.option("--topic", is_flag=True, help="转换为一篇Topic文章")
@click.option("--limit", type=int, help="topic分片长度")
@click.option("--prep", is_flag=True, help="预处理epub，转换为纯ASCII字符集（可选）")
@click.option(
    "--kno-name", type=str, default=None, help="将转换好后的图片文件夹放到目标KNO集合中"
)
@click.option("--kno", is_flag=True, help="离散的 KNO 集合 (非系统集合)")
def e2sm(epub_path, target_folder, toc, seq, topic, limit, prep, kno_name, kno):
    """转换 EPUB 格式图书为 XML 格式图书、预处理 EPUB 为纯 ASCII 字符集"""
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


@main.command()
@click.argument("formula_text")
@click.argument("outpath")
def imtex(formula_text, outpath):
    """转换 LaTeX 公式到 png 图片."""
    formula_to_png.latex2img(
        text=formula_text,
        size=48,
        color=(0.1, 0.8, 0.8),
        out=outpath,
    )


@main.command()
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
@click.option("--least-col", is_flag=True, help="整理最后使用的集合 (最后关闭的集合) ")
@click.option("--kno", is_flag=True, help="离散的 KNO 集合 (非系统集合)")
def pathpix(col_name, clean, fullpath, least_col, gui, kno):
    """整理集合图片: 本地图片->相对路径化、网络图片->本地化"""
    if sm_location == "null":
        click.secho("Please set program location! config::program is null!", fg="red")
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
        # 如果没有提供任何选项，打印帮助信息
        ctx = click.get_current_context()
        click.echo(ctx.get_help())
        return


@main.command()
@click.argument("src_kno")
@click.argument("dst_kno")
@click.option("--kno", is_flag=True, help="离散的 KNO 集合 (非系统集合)")
def transfer(src_kno, dst_kno, kno):
    """转移知识树分支或合并集合后, 在两个集合之间, 转移 pathpix 管理的图片"""
    click.echo(f"转移集合中web和local文件夹图片: 从 {src_kno} 到 {dst_kno}")
    im_sort_out.transfer_images(
        get_elements_path(src_kno, kno), get_elements_path(dst_kno, kno)
    )
    click.echo("图片转移完成")


@main.command()
@click.argument("qafile")
@click.option(
    "--deckname",
    type=str,
    help="设置目标牌组名, SuperMemo Cards (默认)",
)
def sm2anki(qafile, deckname):
    """发送问答卡 (Item) 到 Anki"""
    # print(deckname)
    if deckname:
        ms2a = qa_to_anki(qafile)
        ms2a.setDeckName(deckname)
        ms2a.sent_cards()
    else:
        ms2a = qa_to_anki(qafile)
        ms2a.sent_cards()


@main.command()
@click.argument("htmtoc")
@click.option("--node", type=str, help="设置NodeAsText文件路径")
@click.option("--xml", type=str, help="设置XMl文件路径")
def comptitle(htmtoc: str, node: str, xml: str):
    """修补导出的 NodeAsText 、XMl 中的标题"""
    if not node and not xml:
        print("需要输入待修复的文件路径(NodeAsText OR XMl)")
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
def trace(mem):
    """追踪当前元素，并输出当前元素信息"""
    if mem:
        Trace().print_info(mode="m")
    else:
        Trace().print_info(mode="o")


def parse_ids(ctx, param, value):
    ids = []
    for item in value:
        for part in item.split(","):
            part = part.strip()
            if part:
                ids.append(int(part))
    return tuple(ids)


@main.command()
@click.option("--re", "re_pattern", type=str, help="根据正则条件插入水平分割线")
@click.option(
    "--num",
    type=int,
    default=1000,
    show_default=True,
    help="根据字数条件插入水平分割线，支持 --id <id1>,<id2>",
)
@click.option(
    "--id",
    "eid",
    multiple=True,
    callback=parse_ids,
    help="根据元素id条件插入水平分割线",
)
def splitline(re_pattern, num, eid):
    """在当前元素中根据条件插入水平分割线"""
    # 字数默认推荐1000字，按段落分。
    trace = Trace()

    def work(text_reg: TextRegistry):
        if text_reg is None or text_reg.eId == None:
            return
        path = text_reg.eComponents[1].mPath if len(text_reg.eComponents) > 0 else ""
        if path == "":
            return
        try:
            url = Path(path).resolve().as_uri()
        except Exception:
            url = path  # 如果本来就是 URL，就直接用
        click.echo(f"[No. {text_reg.eId}] [Title: {text_reg.eTitle[:12].strip()}]")

        root, namedpath = path.split("elements")
        filename = makeNameSafe(f"Element#{text_reg.eId}-Path{namedpath}")
        temp = os.path.join(root, "temp", filename)
        shutil.copyfile(path, temp)
        click.echo(f"[Backups: {temp}]")
        with open(path, "r", encoding="utf-8") as fs:
            htm = fs.read()

        if re_pattern:
            try:
                regex = re.compile(re_pattern)
                count = sum(1 for _ in regex.finditer(htm))
                click.echo(f"找到 {count} 个匹配项")
                inserted = regex.sub(lambda m: "<hr/>" + m.group(0), htm)
            except re.error as e:
                click.echo(f"正则表达式无效: {e}", err=True)
                return
            with open(path, "w", encoding="utf-8") as fs:
                fs.write(inserted)
        elif num:
            try:
                inserted = epub_convert.split_html_with_lenght(htm, num)
            except Exception as e:  # noqa: BLE001
                click.echo(f"{e}", err=True)
                return
            with open(path, "w", encoding="utf-8") as fs:
                fs.write(inserted)
        click.echo("分割线插入完成")
        click.echo(f"[Path: {make_link(path, url)}]")
        # 终止
        return True

    if not eid:
        trace.trace_with_mem(work)
    else:
        for element_id in eid:
            work(trace.trace_with_id(element_id))


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
        except Exception as e:  # noqa: BLE001
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

    kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
    # 创建一个长度为1的数组，API会返回实际连接的总进程数
    process_array = (ctypes.c_uint * 1)()
    num_processes = kernel32.GetConsoleProcessList(process_array, 1)

    # 如果返回的进程数 <= 2，大概率是从GUI启动的
    return num_processes <= 2


if __name__ == "__main__":
    if is_launched_from_gui():
        try:
            import pyi_splash

            pyi_splash.close()  # 关闭闪屏
        except ImportError:
            pass  # 在开发环境中，没有 pyi_splash 模块，直接跳过
        Shell().cmdloop()
    else:
        try:
            main()
        except click.exceptions.NoArgsIsHelpError:
            pass
        except SystemExit:
            pass
