# supermemo_toolkit/cli/shell.py
"""smtk 交互式终端（基于 prompt_toolkit）。"""

from __future__ import annotations

import io
import os
import re
import shlex
import sys
import traceback
from pathlib import Path

from prompt_toolkit import PromptSession, print_formatted_text
from prompt_toolkit.auto_suggest import AutoSuggestFromHistory
from prompt_toolkit.completion import (
    CompleteEvent,
    Completer,
    Completion,
    PathCompleter,
    WordCompleter,
    merge_completers,
)
from prompt_toolkit.document import Document
from prompt_toolkit.formatted_text import ANSI, to_formatted_text
from prompt_toolkit.history import FileHistory
from prompt_toolkit.patch_stdout import patch_stdout

# ── 模块级状态（启动时填充）─────────────────────────────────────

_VERSION: str = "unknown"
_CLI_COMMANDS: list[str] = []
_COMMAND_META: dict[str, str] = {}


# ── 入口 ───────────────────────────────────────────────────────


def run_shell() -> None:
    """启动 smtk 交互终端。阻塞直到用户退出。"""
    global _VERSION, _CLI_COMMANDS, _COMMAND_META

    _VERSION = _get_version()
    _CLI_COMMANDS = _get_cli_commands()
    _COMMAND_META = _get_cli_command_meta()

    _safe_chdir_exe_dir()  # 先切目录，再打印 intro，保证 toolbar 与 intro 一致

    hist_path = _get_history_path()
    if hist_path:
        try:
            hist_path.parent.mkdir(parents=True, exist_ok=True)
        except OSError:
            hist_path = None

    session = PromptSession(
        history=FileHistory(str(hist_path)) if hist_path else None,
        auto_suggest=AutoSuggestFromHistory(),
        completer=_build_completer(),
        complete_while_typing=True,
        enable_history_search=True,
        bottom_toolbar=_bottom_toolbar,
    )

    print(_intro())

    while True:
        try:
            line = session.prompt("smtk> ").strip()
        except EOFError:
            print()
            return
        except KeyboardInterrupt:
            print("^C")  # Ctrl+C 只清行，不退出（bash / cmd 语义）
            continue

        if not line:
            continue

        lowered = line.lower()

        if lowered in ("exit", "quit", "q"):
            return
        if lowered in ("help", "?"):
            _print_help()
            continue
        if lowered in ("clear", "cls"):
            session.app.renderer.clear()  # 用渲染器清屏，避免与 os.system 冲突
            continue

        parts = line.split(None, 1)
        if parts[0] == "pwd":
            print(os.getcwd())
            continue
        if parts[0] == "cd":
            # 统一复用 _split_args 进行解析，剥离引号并支持带空格的路径
            try:
                args = _split_args(line)
                raw_arg = args[1] if len(args) > 1 else ""
            except Exception:
                raw_arg = ""
            _do_cd(raw_arg)
            continue

        try:
            args = _parse_smtk_line(line)
        except ValueError as e:
            print(f"参数解析错误: {e}")
            continue
        if args is None:
            print(f"未知命令: {line!r}。输入 help 查看可用命令。")
            continue

        with patch_stdout():
            _run_smtk(args)


# ── 交互辅助 ───────────────────────────────────────────────────


def _intro() -> str:
    return "\n".join(
        [
            "",
            f"SuperMemo 增强工具(交互模式), Ver:{_VERSION}。",
            "输入 smtk <子命令> 执行；Tab 补全；Ctrl+R 搜历史；Ctrl+L 清屏；exit 或 Ctrl+D 退出。",
            "内置命令: help, clear, pwd, cd <dir>, exit（当前目录见底部状态栏）",
            "",
        ]
    )


def _bottom_toolbar() -> str:
    try:
        cwd = os.getcwd()
    except OSError:
        cwd = "<cwd unavailable>"
    if len(cwd) > 60:
        cwd = "..." + cwd[-57:]
    return f" smtk {_VERSION} | {cwd} "


def _do_cd(arg: str) -> None:
    # _split_args 已经剥离了外层引号，此处无需再 strip 引号
    try:
        target = Path(arg).expanduser() if arg else Path.home()
        os.chdir(target)
        print(os.getcwd())
    except OSError as e:
        print(f"cd 失败: {e}")


def _safe_chdir_exe_dir() -> None:
    exe = sys.executable
    if not exe:
        return
    try:
        os.chdir(os.path.dirname(os.path.abspath(exe)))
    except OSError:
        pass


def _parse_smtk_line(line: str) -> list[str] | None:
    """用 split(None, 1) 兼容 Tab / 多空格分隔。"""
    parts = line.split(None, 1)
    if not parts:
        return None
    head = parts[0]
    if head == "smtk":
        return _split_args(parts[1]) if len(parts) > 1 else []
    if head in _CLI_COMMANDS:
        return _split_args(line)
    return None


def _split_args(line: str) -> list[str]:
    """Windows 下用 posix=False 保留反斜杠，再手动剥引号。"""
    if sys.platform == "win32":
        # 匹配 "..." 或 '...' 或 非空白字符
        pattern = r'"([^"]*)"|\'([^\']*)\'|(\S+)'
        args = []
        for match in re.finditer(pattern, line):
            # 避免 `or` 运算吞掉空字符串 ""
            arg = match.group(1)
            if arg is None:
                arg = match.group(2)
            if arg is None:
                arg = match.group(3)
            if arg is not None:
                args.append(arg)
        return args
    return shlex.split(line)


def _display_args(args: list[str]) -> str:
    """回显命令：安全处理包含引号的参数。"""
    out: list[str] = []
    for a in args:
        if not a or any(c in a for c in " \t"):
            if '"' in a and "'" not in a:
                out.append(f"'{a}'")
            else:
                out.append(f'"{a}"')
        else:
            out.append(a)
    return " ".join(out)


# ── 补全器 ─────────────────────────────────────────────────────


def _needs_quote(s: str) -> bool:
    return any(c in s for c in " \t")


def _find_word_start(text: str) -> int:
    """返回光标前当前 token 的起始位置，引号内的空白不视为分隔符。

    从前往后扫，遇到开引号记录 token 起点；引号外的空白更新起点。
    """
    in_quote: str | None = None
    start = 0
    for i, c in enumerate(text):
        if in_quote:
            if c == in_quote:
                in_quote = None
        elif c in "\"'":
            in_quote = c
            start = i  # 开引号 = token 起点
        elif c.isspace():
            start = i + 1  # 引号外空白 = 分隔
    return start


class QuotedPathCompleter(Completer):
    """路径补全：剥引号 → PathCompleter → 按原引号风格加回。"""

    def __init__(self) -> None:
        self._inner = PathCompleter(expanduser=True)

    def get_completions(self, document: Document, complete_event: CompleteEvent):
        text = document.text_before_cursor
        start = _find_word_start(text)
        word = text[start:]
        if not word:
            return

        quote_char = '"'
        had_quote = False
        stripped = word
        if len(stripped) >= 2 and stripped[0] == stripped[-1] and stripped[0] in "\"'":
            had_quote = True
            quote_char = stripped[0]
            stripped = stripped[1:-1]
        elif stripped and stripped[0] in "\"'":
            had_quote = True
            quote_char = stripped[0]
            stripped = stripped[1:]

        if not stripped:
            return

        sub = Document(stripped, len(stripped))
        for c in self._inner.get_completions(sub, complete_event):
            path_text = c.text
            if had_quote or _needs_quote(path_text):
                path_text = f"{quote_char}{path_text}{quote_char}"
            yield Completion(path_text, start_position=-len(word))


def _build_completer() -> Completer:
    # 注意：不含二级子命令（set/unset/list/...）。那些会污染 smtk <Tab> 的候选列表。
    # 二级子命令需要位置感知补全才能正确呈现，属于后续迭代。
    words = ["smtk", "help", "clear", "pwd", "cd", "exit", "quit"]
    words.extend(_CLI_COMMANDS)

    meta = dict(_COMMAND_META)
    meta.setdefault("help", "显示帮助")
    meta.setdefault("clear", "清屏")
    meta.setdefault("pwd", "显示当前目录")
    meta.setdefault("cd", "切换目录")
    meta.setdefault("exit", "退出交互模式")

    word_completer = WordCompleter(
        words,
        ignore_case=True,
        sentence=False,
        meta_dict=meta,
    )
    return merge_completers([word_completer, QuotedPathCompleter()])


# ── 执行 smtk CLI ──────────────────────────────────────────────


class PromptToolkitStdout(io.TextIOBase):
    """代理 Stdout，将普通 print 和 ANSI 颜色码交给 prompt_toolkit 安全渲染。"""

    def __init__(self, original_stream):
        self.original = original_stream

    def write(self, string):
        if not string:
            return 0

        # 处理 bytes 字节流
        if isinstance(string, bytes):
            string = string.decode("utf-8", errors="replace")
        elif not isinstance(string, str):
            string = str(string)

        try:
            fragments = to_formatted_text(ANSI(string))
            print_formatted_text(fragments, end="")
        except Exception:
            # 降级回退
            self.original.write(string)

        return len(string)

    def flush(self):
        if hasattr(self.original, "flush"):
            self.original.flush()

    def isatty(self):
        return True  # 欺骗 click 等库，强制输出色彩

    @property
    def encoding(self):
        # 显式暴露 encoding，兼容某些第三方库的检查
        return getattr(self.original, "encoding", "utf-8")

    def __getattr__(self, name):
        return getattr(self.original, name)


def _run_smtk(args: list[str]) -> None:
    import click
    from supermemo_toolkit.smtk import main

    # 记录原始状态
    old_argv = list(sys.argv)
    old_stdout = sys.stdout
    old_stderr = sys.stderr
    old_env_force = os.environ.get("FORCE_COLOR")
    old_env_depth = os.environ.get("PROMPT_TOOLKIT_COLOR_DEPTH")

    sys.argv = ["smtk", *args]

    # 注入颜色环境
    os.environ["FORCE_COLOR"] = "1"
    os.environ["PROMPT_TOOLKIT_COLOR_DEPTH"] = "DEPTH_8_BIT"

    # 同时劫持 stdout 和 stderr，防止错误信息刷屏打断输入
    sys.stdout = PromptToolkitStdout(old_stdout)
    sys.stderr = PromptToolkitStdout(old_stderr)

    # 打印提示信息（此时已经被劫持，不会刷屏）
    cmd_line = ("smtk " + _display_args(args)) if args else "smtk"
    print(f"» {cmd_line}", file=sys.stderr)

    try:
        main(standalone_mode=False)
    except click.exceptions.NoArgsIsHelpError as e:
        # 无参数显示帮助 —— 不是错误，不加"错误:"前缀
        print(e.format_message())
    except click.exceptions.Exit:
        pass  # --help / --version 正常退出
    except click.Abort:
        print("已取消")
    except click.ClickException as e:
        print(f"错误: {e.format_message()}", file=sys.stderr)
    except SystemExit:
        pass  # 兜底：少数 click 路径仍会 raise
    except KeyboardInterrupt:
        print("\n已中断 (Ctrl+C)")
    except Exception:
        print("命令执行失败：\n" + traceback.format_exc(), file=sys.stderr)
    finally:
        # 恢复标准流
        sys.stdout = old_stdout
        sys.stderr = old_stderr
        sys.argv = old_argv

        # 恢复环境变量
        if old_env_force is None:
            os.environ.pop("FORCE_COLOR", None)
        else:
            os.environ["FORCE_COLOR"] = old_env_force

        if old_env_depth is None:
            os.environ.pop("PROMPT_TOOLKIT_COLOR_DEPTH", None)
        else:
            os.environ["PROMPT_TOOLKIT_COLOR_DEPTH"] = old_env_depth


# ── 启动时收集 ─────────────────────────────────────────────────


def _get_cli_commands() -> list[str]:
    try:
        import click
        from supermemo_toolkit.smtk import main

        ctx = click.Context(main)
        return sorted(main.list_commands(ctx))
    except Exception:
        return []


def _get_cli_command_meta() -> dict[str, str]:
    """从 click 取每个子命令的第一行 docstring 作为补全提示。"""
    try:
        import click
        from supermemo_toolkit.smtk import main

        ctx = click.Context(main)
        meta: dict[str, str] = {}
        for name in main.list_commands(ctx):
            cmd = main.get_command(ctx, name)
            doc = (cmd.help or cmd.short_help or "").strip()
            first = doc.split("\n", 1)[0].strip()
            if first:
                meta[name] = first[:60]
        return meta
    except Exception:
        return {}


def _get_history_path() -> Path | None:
    try:
        from supermemo_toolkit.utilscripts import config as smtk_config

        return Path(smtk_config.config_dir()) / "shell_history"
    except Exception:
        try:
            base = Path(os.environ.get("APPDATA", str(Path.home()))) / "smtk"
            return base / "shell_history"
        except Exception:
            return None


def _get_version() -> str:
    for mod in ("supermemo_toolkit", "supermemo_toolkit.smtk"):
        try:
            m = __import__(mod, fromlist=["__version__"])
            return m.__version__
        except Exception:
            continue
    return "unknown"


def _print_help() -> None:
    print("内置命令：")
    print("  help / ?        显示本帮助")
    print("  clear / cls     清屏（等同于 Ctrl+L）")
    print("  pwd             显示当前目录")
    print("  cd <dir>        切换目录（无参数回 HOME）")
    print("  exit / quit / q 退出（或按 Ctrl+D）")
    print()
    print("smtk 子命令：")
    if not _CLI_COMMANDS:
        print("  (无法加载，请检查安装)")
        return
    cols = 3
    width = max(len(c) for c in _CLI_COMMANDS) + 4
    for i in range(0, len(_CLI_COMMANDS), cols):
        row = _CLI_COMMANDS[i : i + cols]
        print("  " + "".join(c.ljust(width) for c in row).rstrip())
    print()
    print("提示：smtk <子命令> --help 查看详细用法；Tab 补全子命令名和路径。")


def _close_splash() -> None:
    if "_PYI_SPLASH_IPC" not in os.environ:
        return
    try:
        import pyi_splash  # type: ignore

        if pyi_splash.is_alive():
            pyi_splash.close()
    except Exception:
        pass


if __name__ == "__main__":
    _close_splash()
    try:
        run_shell()
    except KeyboardInterrupt:
        print("\nBye.")
