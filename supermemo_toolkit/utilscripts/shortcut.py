"""创建指向 VBS 的桌面快捷方式，VBS 直接执行命令（comtypes 实现）。"""

from __future__ import annotations

import os
import sys
from pathlib import Path

import comtypes.client
from comtypes.persist import IPersistFile
from comtypes.shelllink import IShellLinkW, ShellLink
from PIL import Image

from supermemo_toolkit.utilscripts.config import config_dir

APP_NAME = "smtk launcher"
ICON_SIZES = [(16, 16), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)]
LAUNCH_COMMAND = "smtk integrate launcher"


# ---------------- 路径推导 ----------------


def _resolve_config_dir() -> Path:
    """生成物（vbs / ico）统一放在用户配置目录。"""
    d = config_dir()
    d.mkdir(parents=True, exist_ok=True)
    return d


def _first_existing(candidates: list[Path], what: str) -> Path:
    for p in candidates:
        if p.exists():
            return p
    raise FileNotFoundError(
        f"{what} not found, tried:\n  " + "\n  ".join(str(p) for p in candidates)
    )


def _icon_png() -> Path:
    return _first_existing(
        [
            Path(__file__).with_name("icon.png"),
            Path(__file__).parent.parent / "icon.png",
        ],
        "icon.png",
    )


# ---------------- 转换 & 写入 ----------------


def _png_to_ico(png: Path, ico: Path) -> None:
    # with 确保源文件句柄及时释放，避免 Windows 上的文件占用
    with Image.open(png) as im:
        im.convert("RGBA").save(ico, format="ICO", sizes=ICON_SIZES)


def _validate_command(command: str) -> None:
    """拒绝会破坏 VBS 语句结构的字符；其余特殊字符交由 cmd 解释。"""
    if not command.strip():
        raise ValueError("command is empty")
    if "\r" in command or "\n" in command:
        raise ValueError("command must not contain CR/LF (would break VBS syntax)")


def _write_vbs(vbs_path: Path, command: str) -> None:
    """VBS 直接通过 cmd /c 执行命令，窗口隐藏、不等待。

    - 编码用 UTF-16（含 BOM）：WSH 可靠支持的编码之一，中文路径不会乱码；
    - newline=""：禁止 write_text 在 Windows 上把已有的 \\r\\n 再翻译成 \\r\\r\\n。
    """
    vbs_command = command.replace('"', '""')
    content = (
        'Set sh = CreateObject("WScript.Shell")\r\n'
        f'sh.Run "cmd /c {vbs_command}", 0, False\r\n'
    )
    vbs_path.write_text(content, encoding="utf-16", newline="")


def _desktop_dir() -> Path:
    ws = comtypes.client.CreateObject("WScript.Shell")
    return Path(ws.SpecialFolders("Desktop"))


def _create_lnk(lnk_path: Path, vbs_path: Path, icon: Path) -> None:
    wscript = (
        Path(os.environ.get("SystemRoot", r"C:\Windows")) / "System32" / "wscript.exe"
    )
    if not wscript.exists():
        raise FileNotFoundError(f"wscript.exe not found: {wscript}")

    shortcut = comtypes.client.CreateObject(ShellLink)
    shortcut_w = shortcut.QueryInterface(IShellLinkW)

    shortcut_w.SetPath(str(wscript))
    shortcut_w.SetArguments(f'"{vbs_path}"')
    shortcut_w.SetWorkingDirectory(str(vbs_path.parent))
    shortcut_w.SetDescription(APP_NAME)
    shortcut_w.SetIconLocation(str(icon), 0)

    persist = shortcut_w.QueryInterface(IPersistFile)
    persist.Save(str(lnk_path), True)


# ---------------- 对外入口 ----------------


def install_shortcut(command: str = LAUNCH_COMMAND) -> None:
    """在桌面创建快捷方式；双击后由 VBS 静默执行 command。可重复执行，幂等覆盖。"""
    try:
        _validate_command(command)

        cfg = _resolve_config_dir()
        src_png = _icon_png()

        ico = cfg / "icon.ico"
        _png_to_ico(src_png, ico)

        vbs = cfg / "launch.vbs"
        _write_vbs(vbs, command)

        lnk = _desktop_dir() / f"{APP_NAME}.lnk"
        _create_lnk(lnk, vbs, ico)
    except Exception as e:
        print(f"[ERROR] 创建快捷方式失败: {e}", file=sys.stderr)
        raise
    else:
        print(f"快捷方式已创建: {lnk}")
        print(f"  command : {command}")
        print(f"  vbs     : {vbs}")
        print(f"  icon    : {ico}")


if __name__ == "__main__":
    install_shortcut()
