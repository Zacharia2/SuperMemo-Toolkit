import os

import click

from supermemo_toolkit.epub2sm import epub_convert
from supermemo_toolkit.latex2img import formula_to_png
from supermemo_toolkit.pathpix import im_sort_out, gui as im_sort_out_gui
from supermemo_toolkit.sa_sync.sm2anki import s2a
from supermemo_toolkit.utilscripts import config as smtk_config

# 初始化操作
smtk_config_dir_path = smtk_config.get_config_dir()
smtk_config_file_path = os.path.join(smtk_config_dir_path, "conf.json")
curr_conf_dict = dict()
if not os.path.exists(smtk_config_dir_path):
    os.makedirs(smtk_config_dir_path)
elif not os.path.exists(smtk_config_file_path):
    print("smtk config program is undefined! please set!")
    exit()
else:
    curr_conf_dict = smtk_config.read_config(smtk_config_file_path)
    sm_location = curr_conf_dict["program"]
    print("smtk server on: " + sm_location)


@click.group()
@click.version_option()
def main():
    """SuperMemo 增强工具(CLI命令行)。包含图链整理、EPUB图书转换导入、Latex公式转图片、sm2anki等。"""


@click.group()
def config():
    """配置SMTK"""
    with click.Context(config) as ctx:
        # 没有子命令的时候才输出帮助
        if ctx.invoked_subcommand:
            click.echo(config.get_help(ctx))


# 将config命令添加到main命令组中
main.add_command(config)


@config.command()
@click.argument("key")
@click.argument("value")
def set(key: str, value: str):
    """Set configuration key and value."""
    global curr_conf_dict
    if key == "program":
        curr_conf_dict[key] = value
        smtk_config.update_config(smtk_config_file_path, curr_conf_dict)
        curr_conf_dict = smtk_config.read_config(smtk_config_file_path)
        click.echo(curr_conf_dict)
    elif key == "systems":
        curr_conf_dict[key] = value
        smtk_config.update_config(smtk_config_file_path, curr_conf_dict)
        curr_conf_dict = smtk_config.read_config(smtk_config_file_path)
        click.echo(curr_conf_dict)


@config.command()
def list():
    """列出当前所有配置"""
    click.echo(smtk_config.read_config(smtk_config_file_path))


@main.command()
def clist():
    """列出所有集合"""
    col_list = smtk_config.get_collections_primaryStorage(sm_location)
    for col_name in col_list:
        click.echo("集合名称：" + col_name)


@main.command()
@click.argument("epub_path")
@click.argument("target_folder")
@click.option("--toc", is_flag=True, help="根据目录结构转换")
@click.option("--linear", is_flag=True, help="根据线性阅读顺序转换")
@click.option("--topic", is_flag=True, help="转换为一篇Topic文章")
def e2sm(epub_path, target_folder, toc, linear, topic):
    """Convert ePub to SuperMemo format."""
    if toc:
        epub_convert.start_with_toc(epub_path, target_folder)
    elif linear:
        epub_convert.start_with_linear(epub_path, target_folder)
    elif topic:
        epub_convert.start_with_topic(epub_path, target_folder)


@main.command()
@click.argument("formula_text")
@click.argument("outpath")
def imtex(formula_text, outpath):
    """Convert LaTeX formula to image."""
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
    help="整理单个HTML文件（全路径，component menu(Alt+F12) >> FIle >> Copy path）",
)
@click.option("--gui", is_flag=True, help="运行图形窗口")
@click.option("--least-col", is_flag=True, help="整理最后使用的集合（最后关闭的集合）")
def pathpix(col_name, clean, fullpath, least_col, gui):
    """整理集合图片"""
    if least_col:
        sm_system1 = smtk_config.read_sm_system1(sm_location)
        least_used_col = smtk_config.get_collection_primaryStorage(
            sm_location, sm_system1
        )
        im_sort_out.start(least_used_col)
    elif col_name:
        elements_path = smtk_config.get_collection_primaryStorage(sm_location, col_name)
        if clean:
            im_sort_out.organize_unused_im(elements_path)
        else:
            im_sort_out.start(elements_path)
    elif fullpath:
        im_sort_out.single_file(fullpath)
    elif gui:
        im_sort_out_gui.run()
    else:
        # 如果没有提供任何选项，打印帮助信息
        with click.Context(pathpix) as ctx:
            click.echo(pathpix.get_help(ctx))


@main.command()
@click.argument("qafile")
@click.option(
    "--deckname",
    type=str,
    help="设置目标牌组名",
)
def sm2anki(qafile, deckname):
    """同步 SuperMemo QA 到 Anki"""
    # print(deckname)
    if deckname:
        ms2a = s2a(qafile)
        ms2a.setDeckName(deckname)
        ms2a.run()
    else:
        s2a(qafile).run()


if __name__ == "__main__":
    main()
