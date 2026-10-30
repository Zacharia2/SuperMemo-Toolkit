#!/usr/bin/env python3
"""time - SuperMemo 集合冷备份工具（类 API + 轮询监控 + safety）

单 hot 分支模型：
    - refs/heads/hot      当前工作链，每次 backup append 一个 commit
    - refs/heads/archive  历史快照链，compact 手动把 hot tip 折叠为 snapshot commit，
                         hot 重置到该 snapshot

ref 名不含时间。时间只出现在 commit message 里，仅供人阅读，
不参与任何结构、折叠决策、恢复行为。

一致性原则（任何前提不满足直接 raise，禁止降级）：
    - .kno 不是文件、被锁定、复制后 SHA-256 不一致
    - 目标 commit 缺 kno_rel、hot tip 缺 kno_rel
    - 工作区不干净、HEAD 不存在
    - 以上任一情况均 raise，不警告后继续

不自动 compact；崩溃不自动备份；不主动 gc。
.kno 锁定即拒绝一切写操作。
所有写方法内部强制 FileLock(<repo>.smtk.lock, timeout=360)。
setup_logging 是破坏性的，仅供 CLI 入口调用。

backup 的 trigger 合法值：manual / shutdown / tray / debug。
非法值只影响 commit message，不 raise。

backup 执行 git add -A，集合目录下所有未忽略文件都会被提交。
用户应把临时文件放入 .gitignore 或 temp/、reports/、html/。

restore 不删除 untracked 文件；如果 untracked 文件与目标 commit 的
tracked 文件冲突，restore 失败并回滚，用户需手动处理冲突文件。

reset_workspace 的语义（用户需求）：
    成功 = 工作区完全等于目标 commit。所有不在目标 commit 中的文件被删除：
           - tracked 文件被覆盖
           - untracked 文件被删除
           - ignored 文件（如 temp/、reports/、html/）也被删除
           外部 .kno 写回目标 commit 的版本。
    不成功 = 完全恢复操作前状态（refs、tracked、untracked、ignored、
             外部 .kno 全部恢复原样）。index 状态丢失 staged/unstaged
             区分（回滚后所有改动都变为 unstaged），但文件内容完全一致。
            **例外**：若阶段 C0（git add -A --force）已经部分写入 index
            后才失败，index 会被强制 reset 到 old_head（原先 staged 的
            改动变为 unstaged，文件内容不变）。

reset_workspace 的实现机制（snapshot commit，复用 backup 思路）：
    - 阶段 A：前置检查（含残留 snapshot ref 检测）
    - 阶段 B：写 kno tmp + SHA 校验（不 replace）
    - 阶段 C0'：二次 is_kno_locked 检查
    - 阶段 C0：git add -A --force（包含 ignored 文件）
              + write-tree + commit-tree（parent = old_head）
              → git update-ref refs/smtk-reset-snapshot <commit>
              始终创建 snapshot，确保包含工作区所有文件（含 ignored）。
              snapshot commit 的 parent 指向 old_head，方便残留 ref 恢复
              时用 SNAPSHOT_REF^ 找回操作前 HEAD。
    - 阶段 C1-C4：read-tree -u --reset + update-ref + symbolic-ref
                 + _write_kno_atomic(kno_src, target_kno)
              read-tree -u --reset 会删除所有"add 时在 index 里、
              目标 commit 里没有"的文件（包括 ignored 和 untracked）。
    - 成功：git update-ref -d refs/smtk-reset-snapshot
    - 失败（回滚成功）：
          1. read-tree -u --reset <snapshot>    恢复工作区
          2. read-tree --reset <old_head>       重置 index（防 ignored 污染）
          3. update-ref HOT_REF <old_head> + symbolic-ref
          4. 恢复外部 .kno 原始字节
          5. 删除 snapshot ref
    - 失败（回滚不完整）：同 1-4 步尽力执行，**保留** snapshot ref，
      并在错误消息里给出完整恢复命令（含 kno 恢复）。

已知限制：
    - 崩溃 / 强杀 / 断电时，本次会话不自动备份；下次打开后关闭会正常备份，
      但崩溃前的数据不在仓库中。
    - 自动 compact 已移除；折叠是用户通过托盘菜单手动触发的操作。
    - hot 分支被 compact 重置后，旧 commit 变 dangling，默认由 git 的
      2 周 unreachable 保留期管理。compact 日志记录旧 hot tip 的短 hash，
      2 周内可 git fsck --lost-found 找回。
    - 轮询线程在 backup 期间暂停；多集合同时关闭时第二个集合的备份延迟到
      第一个完成之后。
    - CLI 与 Watcher 同时运行时，FileLock(<repo>.smtk.lock) 保证跨进程互斥。
    - 系统时钟只影响 commit message 的时间戳，不影响任何结构、折叠决策、
      恢复行为。时钟错了，git log 显示的时间不准，仅此而已。
    - reset_workspace 失败回滚后，原 staged/unstaged 区分丢失（所有改动
      变成 unstaged），但文件内容完全一致。
    - reset_workspace 阶段 C0'（二次激活检查）到 C0（add -A --force）
      之间有一个微小窗口（通常 < 1 秒），期间用户可能重新打开 SuperMemo。
      add -A --force 会读取工作区所有文件，若 SM 正在写，snapshot 内容
      可能包含半写入的文件。这不影响 C1-C4 的原子性（失败时仍按 snapshot
      回滚），但 snapshot 里可能有部分不完整的文件。极低概率，日志可追溯。
    - reset_workspace 在阶段 C0 之后、C4 之前被强杀时，snapshot ref
      （refs/smtk-reset-snapshot）会残留。下次 reset 前置检测发现即拒绝，
      并给出完整恢复命令（含恢复工作区、index、refs、外部 kno）。
    - reset_workspace 在阶段 C4 成功之后、删除 snapshot ref 之前被强杀时，
      工作区/refs/kno 均已重置到目标（状态正确），只残留 snapshot ref。
      下次 reset 前置检测即拒绝，用户按提示 update-ref -d 清理即可。
    - 重置子菜单在 Watcher.start() 时静态生成，运行期间新初始化的集合
      需要重启 watcher 才会出现。
"""

from __future__ import annotations

import hashlib
import logging
import os
import shutil
import subprocess
import sys
import threading
import time as _time
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import NamedTuple

import pystray
from PIL import Image, ImageDraw
from typing_extensions import Self

from supermemo_toolkit.utilscripts.config import config_dir, read_smtk_conf
from supermemo_toolkit.utilscripts.ulils import is_kno_locked

log = logging.getLogger("time")

# 日志路径延迟到首次使用时初始化：模块导入阶段不碰磁盘，
# 避免 config_dir 不可写 / 权限不足导致 import 直接崩溃。
_LOG_FILE: str | None = None


def _get_log_file() -> str:
    """惰性返回日志文件路径，必要时创建配置目录。"""
    global _LOG_FILE
    if _LOG_FILE is None:
        cfg = config_dir()
        os.makedirs(cfg, exist_ok=True)
        _LOG_FILE = os.path.join(cfg, "time.log")
    return _LOG_FILE


GIT_LOCK = threading.RLock()

ARCHIVE_REF = "refs/heads/archive"
HOT_REF = "refs/heads/hot"
# reset_workspace 的临时快照 ref（进程被强杀时可能残留，下次 reset 会检测）
SNAPSHOT_REF = "refs/smtk-reset-snapshot"


# ============================================================================
# 类型定义（公共 API 类型，调用方可直接引用）
# ============================================================================


@dataclass(frozen=True)
class Collection:
    """SuperMemo 集合描述。

    Attributes:
        name:     集合名称（用于展示，不直接参与 ref 名）
        path:     集合目录的绝对路径（即 Git 工作区根）
        kno:      可选。覆盖默认的 .kno 文件路径；不设置时自动计算为 <path.parent>/<name>.kno

    I5 不变式：kno 为 None 时，name 必须等于目录名；否则需显式提供 kno。
    """

    name: str
    path: str
    kno: str | None = None

    def __post_init__(self) -> None:
        path = str(Path(self.path).resolve())
        object.__setattr__(self, "path", path)
        if self.kno is not None:
            object.__setattr__(self, "kno", str(Path(self.kno).resolve()))
        if self.kno is None and self.name != Path(path).name:
            raise ValueError(
                f"collection name {self.name!r} != directory name {Path(path).name!r}; "
                f"set kno explicitly to allow different names"
            )

    def repo_path(self) -> Path:
        """Git 仓库工作区路径。"""
        return Path(self.path)

    def dir_name(self) -> str:
        """目录名。"""
        return Path(self.path).name

    def kno_path(self) -> Path:
        """SuperMemo 实际使用的 .kno 文件路径（在仓库外部）。"""
        if self.kno:
            return Path(self.kno)
        p = Path(self.path)
        return p.parent / f"{p.name}.kno"

    def kno_store_path(self) -> Path:
        """仓库内备份副本路径：<repo_root>/<dir_name>.kno"""
        return Path(self.path) / f"{self.dir_name()}.kno"

    def kno_rel(self) -> str:
        """仓库内 .kno 的相对路径（仓库根下）。"""
        return f"{self.dir_name()}.kno"

    def smtk_lock_path(self) -> Path:
        """写锁路径：仓库目录下的 .<name>.smtk.lock。"""
        p = Path(self.path)
        return p / f".{p.name}.smtk.lock"

    def init_lock_path(self) -> Path:
        """init 锁路径：仓库目录下的 .<name>.init.lock。"""
        p = Path(self.path)
        return p / f".{p.name}.init.lock"


@dataclass(frozen=True)
class BackupConfig:
    """冷备份工具配置。

    Attributes:
        sm_location:        SuperMemo 安装根目录
        collections:        发现的集合列表

    配置里存在 backup_min_active 时忽略，不报错。
    """

    sm_location: str
    collections: list[Collection]

    def get_collection(self, name: str) -> Collection:
        """按名称查找集合。"""
        for c in self.collections:
            if c.name == name:
                return c
        raise KeyError(f"collection not found: {name}")


class BackupResult(NamedTuple):
    """backup 的返回值。

    Attributes:
        commit:  成功时为完整 commit hash（40 字符）；skipped 时为当前 tip；
                 失败时为 None。
        skipped: True 表示无变更已跳过
    """

    commit: str | None
    skipped: bool = False


@dataclass
class SnapshotData:
    """get_snapshots 的返回值。

    Attributes:
        name:    集合名称
        kno:     外部 .kno 路径
        store:   仓库内 .kno 副本路径
        archive: archive 链上每行 "%h %s"，按 git log 顺序（新→旧）
        hot:     hot 链上每行 "%h %s"，按 git log 顺序（新→旧）；无 hot 时为空列表
    """

    name: str
    kno: str
    store: str
    archive: list[str]
    hot: list[str]


@dataclass(frozen=True)
class CompactResult:
    """compact 的返回值。

    Attributes:
        folded:           True 表示 hot 被重置（无论是否创建新 snapshot）
        created_snapshot: True 表示创建了新 snapshot commit
        message:          "folded" / "nothing to fold" / "no repo" / "empty tree" /
                          "failed: <原因>"（批量模式下失败集合）
    """

    folded: bool
    created_snapshot: bool = False
    message: str = ""


@dataclass(frozen=True)
class RestoreResult:
    """restore 的返回值。

    Attributes:
        target:   恢复目标
        restored: 当前实现总是 True
        old_head: restore 前的 HEAD，供用户回滚或审计
    """

    target: str
    restored: bool
    old_head: str | None = None


# ============================================================================
# 异常类型
# ============================================================================


class GitError(RuntimeError):
    """Git 命令执行失败。"""


class NoTargetCommit(RuntimeError):
    """目标 commit 无法解析（如 HEAD^ 但只有 1 个 commit）。调用方应视为跳过。"""


class ResetFailed(RuntimeError):
    """重置失败，但文件内容已完全回滚（refs、tracked、untracked、ignored、
    外部 .kno 均恢复原样）。index 状态丢失 staged/unstaged 区分
    （所有改动变为 unstaged）。用户可以放心重试。"""


class ResetRollbackFailed(RuntimeError):
    """重置失败且回滚不完整，仓库/文件可能不一致。snapshot ref 保留
    （含操作前完整工作区，parent 指向操作前 HEAD），用户可按错误消息中
    的完整命令手动恢复。"""


# ============================================================================
# 跨进程文件锁
# ============================================================================


class FileLock:
    """跨进程文件锁（上下文管理器）。

    Windows 使用 msvcrt.locking(LK_NBLCK)，POSIX 使用 fcntl.flock(LOCK_EX|LOCK_NB)。
    默认超时 60 秒，拿不到锁抛 TimeoutError。

    使用示例：
        >>> with FileLock(Path("/tmp/mylock")):
        ...     # 安全地执行临界区代码
        ...     pass
    """

    def __init__(self, lock_path: Path, timeout: float = 60.0) -> None:
        """用锁文件路径创建 FileLock。"""
        self._lock_path = Path(lock_path)
        self._timeout = timeout
        self._fd = None

    def __enter__(self) -> Self:
        self.acquire()
        return self

    def __exit__(self, *exc_info: object) -> None:
        self.release()

    def acquire(self) -> None:
        """获取锁，阻塞直到拿到或超时。

        每次重试前重新 seek(0)，修复 Windows 重试锁错位置的问题。
        """
        deadline = _time.time() + self._timeout
        self._lock_path.parent.mkdir(parents=True, exist_ok=True)
        fd = open(self._lock_path, "a+b")  # noqa: SIM115
        try:
            if sys.platform == "win32":
                fd.seek(0, os.SEEK_END)
                if fd.tell() == 0:
                    fd.write(b"\0")
                    fd.flush()

            while True:
                fd.seek(0)
                try:
                    if sys.platform == "win32":
                        import msvcrt

                        msvcrt.locking(fd.fileno(), msvcrt.LK_NBLCK, 1)
                    else:
                        import fcntl

                        fcntl.flock(fd.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
                except OSError:
                    if _time.time() >= deadline:
                        raise TimeoutError(
                            f"无法获取锁 {self._lock_path}（超时 {self._timeout}s），"
                            f"可能有其他进程正在操作同一仓库"
                        )
                    _time.sleep(0.5)
                else:
                    self._fd = fd
                    return
        except Exception:
            try:
                fd.close()
            except OSError:
                pass
            raise

    def release(self) -> None:
        """释放锁。"""
        fd = self._fd
        self._fd = None
        if fd is None:
            return
        try:
            if sys.platform == "win32":
                import msvcrt

                fd.seek(0)
                msvcrt.locking(fd.fileno(), msvcrt.LK_UNLCK, 1)
            else:
                import fcntl

                fcntl.flock(fd.fileno(), fcntl.LOCK_UN)
        except OSError:
            pass
        finally:
            try:
                fd.close()
            except OSError:
                pass


# ============================================================================
# logging
# ============================================================================


def setup_logging(verbose: bool = False) -> None:
    """初始化日志。破坏性，仅供 CLI 入口调用。

    模式（由环境变量 SMTK_LOG_UI_ONLY 控制）：
      - 设置 SMTK_LOG_UI_ONLY=1/true/yes：仅写 stderr，不写文件。
        供 GUI 包装器（launcher）通过管道读取并显示到日志窗口。
      - 未设置：写文件；stderr 是 tty 时额外写 stderr（原行为不变）。
    """
    ui_only = os.environ.get("SMTK_LOG_UI_ONLY", "").lower() in ("1", "true", "yes")
    if ui_only:
        # GUI 模式：只走 stderr。sys.stderr 为 None（pythonw）时退化为 NullHandler，
        # 避免 StreamHandler(None) 在 logging 内部报错。
        handlers: list[logging.Handler] = (
            [logging.StreamHandler(sys.stderr)]
            if sys.stderr is not None
            else [logging.NullHandler()]
        )
    else:
        handlers = [logging.FileHandler(_get_log_file(), encoding="utf-8")]
        if (
            sys.stderr is not None
            and hasattr(sys.stderr, "isatty")
            and sys.stderr.isatty()
        ):
            handlers.append(logging.StreamHandler(sys.stderr))
    logging.basicConfig(
        level=logging.DEBUG if verbose else logging.INFO,
        format="%(asctime)s %(levelname)s %(message)s",
        handlers=handlers,
        force=True,
    )


# ============================================================================
# smtk 配置
# ============================================================================


def load_config() -> BackupConfig:
    """加载配置并自动发现集合。"""
    smtk = read_smtk_conf()
    sm_location = (smtk.get("program") or "").strip()
    if not sm_location or sm_location.lower() == "null":
        raise SystemExit(
            "请先设置 smtk 配置：smtk config set program <SuperMemo 根目录>"
        )
    return BackupConfig(
        sm_location=sm_location,
        collections=discover_collections(sm_location, smtk),
    )


def _looks_like_collection(p: Path) -> bool:
    """检查目录是否含 SuperMemo 集合特征文件。"""
    return (
        (p / "info.dat").exists() or (p / "elements").is_dir() or (p / "stats").is_dir()
    )


def discover_collections(sm_location: str, smtk: dict) -> list[Collection]:
    """从 smtk 配置和 SM 文件系统自动发现集合。

    systems/ 下只发现含 info.dat、elements/、stats/ 之一的目录，
    避免把 systems/backup/ 等非集合目录当作集合。
    knos 配置项不做特征检查（用户显式配置，信任用户）。
    """
    by_name: dict[str, Collection] = {}
    systems = Path(sm_location) / "systems"
    if systems.is_dir():
        for p in sorted(systems.iterdir()):
            if p.is_dir() and p.name != ".git":
                if not _looks_like_collection(p):
                    log.debug(
                        f"跳过 {p}: 无集合特征文件 (info.dat / elements/ / stats/)"
                    )
                    continue
                try:
                    by_name[p.name] = Collection(name=p.name, path=str(p.resolve()))
                except ValueError as e:
                    log.warning(f"跳过 {p}: {e}")

    for item in smtk.get("knos") or []:
        if not isinstance(item, dict):
            log.warning(f"knos 配置项非 dict，跳过: {item!r}")
            continue
        for name, val in item.items():
            try:
                if isinstance(val, dict):
                    raw_path = val.get("path")
                    if not raw_path:
                        log.warning(f"knos[{name}] 缺 path，跳过")
                        continue
                    by_name[name] = Collection(
                        name=name,
                        path=str(Path(raw_path).resolve()),
                        kno=val.get("kno"),
                    )
                elif isinstance(val, str):
                    by_name[name] = Collection(name=name, path=str(Path(val).resolve()))
                else:
                    log.warning(f"knos[{name}] 类型不支持: {type(val).__name__}，跳过")
            except ValueError as e:
                log.warning(f"knos[{name}] 配置错误，跳过: {e}")
    return list(by_name.values())


# ============================================================================
# git helper
# ============================================================================


def _git_env(repo: Path) -> dict:
    """构建 git 命令所需的环境变量。

    - 清除外部 GIT_* 变量，避免误操作其他仓库
    - 作者/提交者信息
    - GIT_CEILING_DIRECTORIES 阻止 git 在 repo 没有 .git 时向上查找祖先仓库
    """
    env = os.environ.copy()
    for var in (
        "GIT_DIR",
        "GIT_WORK_TREE",
        "GIT_INDEX_FILE",
        "GIT_OBJECT_DIRECTORY",
        "GIT_ALTERNATE_OBJECT_DIRECTORIES",
        "GIT_COMMON_DIR",
        "GIT_NAMESPACE",
    ):
        env.pop(var, None)

    env.setdefault("GIT_AUTHOR_NAME", "time-rewind")
    env.setdefault("GIT_AUTHOR_EMAIL", "time-rewind@local")
    env.setdefault("GIT_COMMITTER_NAME", "time-rewind")
    env.setdefault("GIT_COMMITTER_EMAIL", "time-rewind@local")

    ceiling = os.path.normcase(str(repo.parent.resolve()))
    sep = ";" if sys.platform == "win32" else ":"
    existing = env.get("GIT_CEILING_DIRECTORIES")
    if existing:
        env["GIT_CEILING_DIRECTORIES"] = f"{ceiling}{sep}{existing}"
    else:
        env["GIT_CEILING_DIRECTORIES"] = ceiling
    return env


def git(
    repo: Path,
    *args,
    check: bool = True,
    text: bool = True,
    input: str | None = None,
):
    """执行 git 命令。

    input 参数用于 git update-ref --stdin。
    TimeoutExpired 不捕获，向上抛。
    """
    cmd = ["git", "-C", str(repo)] + list(args)
    r = subprocess.run(
        cmd,
        check=False,
        capture_output=True,
        text=text,
        input=input,
        encoding="utf-8" if text else None,
        errors="replace" if text else None,
        env=_git_env(repo),
        timeout=300,
    )
    if check and r.returncode != 0:
        err = r.stderr if text else r.stderr.decode(errors="replace")
        raise GitError(f"git {' '.join(args)} failed: {err}")
    return r


def git_out(repo: Path, *args) -> str:
    """执行 git 命令并返回 stdout（去首尾空白）。"""
    return git(repo, *args).stdout.strip()


def ref_exists(repo: Path, ref: str) -> bool:
    """检查 git 引用是否存在。"""
    return (
        git(repo, "rev-parse", "--verify", "--quiet", ref, check=False).returncode == 0
    )


def rev_parse(repo: Path, expr: str) -> str:
    """解析 rev 表达式为 commit hash。失败时抛 GitError。"""
    try:
        return git_out(repo, "rev-parse", "--verify", expr)
    except GitError as e:
        raise GitError(f"无法解析 rev {expr!r}: {e}") from e


def rev_parse_commit(repo: Path, ref: str) -> str:
    """解析 ref 为 commit hash（解除 tag 引用）。"""
    return rev_parse(repo, f"{ref}^{{commit}}")


def commit_tree(repo: Path, tree: str, parent: str | None, msg: str) -> str:
    """创建一个新的 tree commit。"""
    if parent:
        return git_out(repo, "commit-tree", tree, "-p", parent, "-m", msg)
    return git_out(repo, "commit-tree", tree, "-m", msg)


# ============================================================================
# 哈希辅助
# ============================================================================


def _sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _sha256_file(path: Path) -> str:
    """分块读取文件计算 SHA-256，不整体加载。"""
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(65536), b""):
            h.update(chunk)
    return h.hexdigest()


# ============================================================================
# .kno 读取 / 写回
# ============================================================================


def _commit_kno_bytes(repo: Path, commit: str, kno_rel: str) -> bytes | None:
    """从指定 commit 中读取 .kno 文件的 blob 数据。"""
    r = git(repo, "cat-file", "-p", f"{commit}:{kno_rel}", check=False, text=False)
    if r.returncode != 0:
        return None
    return r.stdout


def _restore_kno_store_to_head(repo: Path, kno_store: Path, kno_rel: str) -> None:
    """把 kno_store 恢复到 HEAD 版本（tracked）或删除（untracked），保持工作区干净。"""
    r = git(repo, "cat-file", "-e", f"HEAD:{kno_rel}", check=False)
    if r.returncode == 0:
        git(repo, "checkout", "HEAD", "--", kno_rel, check=False)
    else:
        kno_store.unlink(missing_ok=True)


def _write_kno_atomic(kno_src: Path, data: bytes) -> None:
    """原子写回 .kno，写后 SHA-256 校验。"""
    tmp = kno_src.with_suffix(kno_src.suffix + ".smtk-tmp")
    tmp.write_bytes(data)
    try:
        os.replace(tmp, kno_src)
    except OSError as e:
        tmp.unlink(missing_ok=True)
        raise RuntimeError(f"写回 {kno_src} 失败: {e}") from e
    if _sha256_file(kno_src) != _sha256_bytes(data):
        raise RuntimeError(f"{kno_src} 写回后 SHA-256 不一致")


def _try_rollback(
    repo: Path,
    old_head: str,
    old_kno: bytes,
    kno_src: Path,
    name: str,
    primary_error: Exception,
) -> None:
    """回滚到 restore 前状态。成功则返回；失败则 raise 汇总异常。"""
    failed: list[str] = []
    try:
        git(repo, "read-tree", "-u", "--reset", old_head)
    except (GitError, subprocess.TimeoutExpired) as e:
        failed.append(f"read-tree: {e}")
    try:
        git(repo, "update-ref", HOT_REF, old_head)
        git(repo, "symbolic-ref", "HEAD", HOT_REF)
    except (GitError, subprocess.TimeoutExpired) as e:
        failed.append(f"ref: {e}")
    try:
        _write_kno_atomic(kno_src, old_kno)
    except Exception as e:
        failed.append(f".kno: {e}")
    if failed:
        raise RuntimeError(
            f"{name}: 操作失败且回滚失败，仓库/文件可能处于不一致状态。\n"
            f"原始错误: {primary_error}\n"
            f"回滚失败项:\n" + "\n".join(f"  - {f}" for f in failed)
        ) from primary_error


# ============================================================================
# gitignore / gitattributes
# ============================================================================


def _ensure_gitignore(repo: Path) -> None:
    """确保 .gitignore 含全部必需行；存在时仅追加缺失行，不覆盖用户自定义行。"""
    required = [
        "temp/unused_im/*",
        "temp/*",
        "reports/*",
        "html/*",
        "*.tmp",
        "*.restore-tmp",
        "*.uninit-tmp",
        "*.kno.tmp",
        "*.smtk-tmp",
        "*.lock",
    ]
    gi = repo / ".gitignore"
    if not gi.exists():
        gi.write_text("\n".join(required) + "\n", encoding="utf-8")
        return
    content = gi.read_text(encoding="utf-8")
    existing = {line.strip() for line in content.splitlines()}
    missing = [line for line in required if line not in existing]
    if not missing:
        return
    if content and not content.endswith("\n"):
        content += "\n"
    content += "\n".join(missing) + "\n"
    gi.write_text(content, encoding="utf-8")


def _ensure_gitattributes(repo: Path) -> None:
    """确保 .gitattributes 存在；存在则不修改。"""
    ga = repo / ".gitattributes"
    if not ga.exists():
        ga.write_text("* -text\n", encoding="utf-8")


# ============================================================================
# CollectionRepo - 单个集合的仓库操作封装
# ============================================================================


class CollectionRepo:
    """封装单个 SuperMemo 集合的 Git 仓库操作。

    使用示例：
        >>> from time_backup import CollectionRepo, Collection
        >>> coll = Collection(name="Maths", path="D:/SuperMemo/systems/Maths")
        >>> repo = CollectionRepo(coll)
        >>> repo.init()
        >>> result = repo.backup()
        >>> repo.compact()
        >>> repo.restore("refs/heads/archive")
        >>> repo.reset_workspace("HEAD")
    """

    def __init__(self, coll: Collection) -> None:
        self._coll = coll

    @property
    def collection(self) -> Collection:
        return self._coll

    @property
    def name(self) -> str:
        return self._coll.name

    @property
    def repo_path(self) -> Path:
        return self._coll.repo_path()

    @property
    def kno_path(self) -> Path:
        return self._coll.kno_path()

    @property
    def kno_store_path(self) -> Path:
        return self._coll.kno_store_path()

    def kno_rel(self) -> str:
        return self._coll.kno_rel()

    def is_initialized(self) -> bool:
        """集合的 Git 仓库是否已初始化。"""
        return (
            git(self.repo_path, "rev-parse", "--git-dir", check=False).returncode == 0
        )

    def is_active(self) -> bool:
        """集合是否正在激活（.kno 存在且被锁定）。"""
        return self.kno_path.is_file() and is_kno_locked(self.kno_path)

    def init(self) -> Path:
        """初始化集合的 Git 仓库（如果尚未初始化）。

        锁：GIT_LOCK + FileLock(init_lock_path)（默认 timeout=60）。
        """
        with GIT_LOCK:
            with FileLock(self._coll.init_lock_path()):
                repo = self.repo_path
                repo.mkdir(parents=True, exist_ok=True)
                if not self.is_initialized():
                    git(repo, "init", "-q")
                _ensure_gitignore(repo)
                _ensure_gitattributes(repo)
                return repo

    def backup(self, trigger: str = "manual") -> BackupResult:
        """冷备份：集合必须已关闭。外部 .kno 复制进工作区根，然后提交。

        锁：GIT_LOCK + FileLock(smtk_lock_path, timeout=360)。

        Raises:
            RuntimeError: 集合目录不存在、.kno 不是文件、.kno 被锁定、
                复制后 SHA-256 不一致、复制期间集合被重新激活、
                提交前集合被重新激活、提交前 SHA-256 不一致。
            GitError: git 操作失败。
        """
        with GIT_LOCK:
            with FileLock(self._coll.smtk_lock_path(), timeout=360):
                # 1. 集合目录必须已存在
                if not self.repo_path.exists():
                    raise RuntimeError(f"{self.name}: 集合目录不存在: {self.repo_path}")
                # 2. 确保仓库已初始化
                repo = self.init()
                kno_src = self.kno_path
                kno_store = self.kno_store_path
                kno_rel = self.kno_rel()

                # 4. .kno 是文件检查
                if not kno_src.is_file():
                    raise RuntimeError(
                        f"{self.name}: {kno_src} 不是文件或不存在，拒绝备份（集合数据不完整）"
                    )
                # 5. .kno 锁定检查
                if is_kno_locked(kno_src):
                    raise RuntimeError(f"{self.name}: 集合正在激活，拒绝备份")

                # 6. 复制到临时文件
                tmp = kno_store.with_suffix(kno_store.suffix + ".smtk-tmp")
                try:
                    shutil.copy2(kno_src, tmp)
                except OSError as e:
                    tmp.unlink(missing_ok=True)
                    raise GitError(f"{self.name}: 复制 .kno 失败: {e}") from e

                # 7. SHA-256 校验
                if _sha256_file(kno_src) != _sha256_file(tmp):
                    tmp.unlink(missing_ok=True)
                    raise GitError(f"{self.name}: .kno 复制后 SHA-256 不一致")

                # 8. 复制后二次锁定检查
                if is_kno_locked(kno_src):
                    tmp.unlink(missing_ok=True)
                    raise RuntimeError(
                        f"{self.name}: 复制期间集合被重新激活，放弃本次备份"
                    )

                # 9. 原子替换
                try:
                    os.replace(tmp, kno_store)
                except OSError as e:
                    tmp.unlink(missing_ok=True)
                    raise GitError(f"{self.name}: .kno 原子替换失败: {e}") from e

                # 10-17 整体包 try/except：任何一步失败都恢复 kno_store，
                # 保持工作区干净，否则后续 restore 的工作区干净检查会卡死用户。
                try:
                    # 10. 提交前最终校验
                    if is_kno_locked(kno_src):
                        raise RuntimeError(
                            f"{self.name}: 提交前集合被重新激活，放弃本次备份"
                        )
                    if _sha256_file(kno_src) != _sha256_file(kno_store):
                        raise GitError(
                            f"{self.name}: 提交前 .kno 与 kno_store SHA-256 不一致"
                        )

                    # 11-12. 暂存并写 tree
                    git(repo, "add", "-A")
                    tree = git_out(repo, "write-tree")

                    # 13. parent 选择（三行），同时记录 backup 前 HOT_REF 是否存在
                    had_hot = ref_exists(repo, HOT_REF)
                    if had_hot:
                        parent = rev_parse_commit(repo, HOT_REF)
                    elif ref_exists(repo, ARCHIVE_REF):
                        parent = rev_parse_commit(repo, ARCHIVE_REF)
                    else:
                        parent = None

                    # 14. 无变更跳过
                    if (
                        parent is not None
                        and rev_parse(repo, f"{parent}^{{tree}}") == tree
                    ):
                        created = not had_hot
                        if created:
                            git(repo, "update-ref", HOT_REF, parent)
                        try:
                            git(repo, "symbolic-ref", "HEAD", HOT_REF)
                        except GitError:
                            if created:
                                git(repo, "update-ref", "-d", HOT_REF, check=False)
                            raise
                        return BackupResult(commit=parent, skipped=True)

                    # 15-16. 创建提交
                    msg = f"hot: {datetime.now().isoformat(timespec='seconds')} [{trigger}]"
                    commit = commit_tree(repo, tree, parent, msg)

                    # 17. 更新 hot 引用，symbolic-ref 失败时回滚到 backup 前的状态
                    git(repo, "update-ref", HOT_REF, commit)
                    try:
                        git(repo, "symbolic-ref", "HEAD", HOT_REF)
                    except GitError:
                        # 修复：had_hot 为 True 时恢复旧 hot tip（parent），
                        # 不删除 HOT_REF。删除会把 backup 前的整个 hot 链
                        # 变成 dangling，下次 backup 可能 fallback 到 archive
                        # 重新起链，导致 hot 分叉、用户看到历史"消失"。
                        # had_hot 为 False 时本次刚创建 HOT_REF，删除即回滚。
                        if had_hot and parent is not None:
                            git(repo, "update-ref", HOT_REF, parent, check=False)
                        else:
                            git(repo, "update-ref", "-d", HOT_REF, check=False)
                        raise

                    log.info(f"{self.name}: backup {commit[:8]} (trigger={trigger})")
                    return BackupResult(commit=commit, skipped=False)
                except Exception as primary:
                    # 回滚 kno_store 到 HEAD，保持工作区干净。
                    # 回滚本身失败不覆盖原始异常：backup 的回滚只是清理工作区，
                    # 不涉及数据恢复（kno_store 最坏是新内容，下次 backup 会重试），
                    # 所以 log.error 记录回滚失败即可，原始异常继续向上抛。
                    try:
                        _restore_kno_store_to_head(repo, kno_store, kno_rel)
                    except Exception as rb_err:
                        log.error(
                            f"{self.name}: 回滚 kno_store 失败: {rb_err}"
                            f"（原始错误: {primary}）"
                        )
                    raise

    def compact(self) -> CompactResult:
        """压缩仓库历史：把 hot tip 的 tree 折叠为 archive 的一条 snapshot commit。

        由用户通过托盘菜单显式触发，Watcher 不调用。
        锁：GIT_LOCK + FileLock(smtk_lock_path, timeout=360)。
        """
        with GIT_LOCK:
            with FileLock(self._coll.smtk_lock_path(), timeout=360):
                repo = self.repo_path

                if not self.is_initialized():
                    return CompactResult(folded=False, message="no repo")

                # 集合激活时拒绝压缩
                kno_src = self.kno_path
                if kno_src.is_file() and is_kno_locked(kno_src):
                    raise RuntimeError(f"{self.name}: 集合正在激活，拒绝压缩")

                if not ref_exists(repo, HOT_REF):
                    return CompactResult(folded=False, message="nothing to fold")

                # 校验 archive tip 的 subject（不变式 I2）
                if ref_exists(repo, ARCHIVE_REF):
                    archive_tip = rev_parse_commit(repo, ARCHIVE_REF)
                    msg = git_out(repo, "log", "-1", "--format=%s", archive_tip)
                    if not msg.startswith("snapshot: "):
                        raise GitError(
                            f"{self.name}: archive tip 不是 snapshot 条目: {msg!r}"
                        )
                else:
                    archive_tip = None

                hot_tip = rev_parse_commit(repo, HOT_REF)

                # 校验 hot tip 含 kno_rel（不变式 I11）
                kno_rel = self.kno_rel()
                if _commit_kno_bytes(repo, hot_tip, kno_rel) is None:
                    raise RuntimeError(
                        f"{self.name}: hot tip {hot_tip[:8]} 中无 {kno_rel}，拒绝折叠（集合数据不完整）"
                    )

                # 修复：hot 已指向 archive tip（上次 compact 后无新 backup），
                # 此时既没有新内容可折叠，也没有旧 commit 会变 dangling，
                # 直接返回 nothing to fold，不再落入 empty tree 分支误报 folded=True。
                if archive_tip is not None and hot_tip == archive_tip:
                    log.info(f"{self.name}: hot == archive tip，无需折叠")
                    return CompactResult(folded=False, message="nothing to fold")

                tree = rev_parse(repo, f"{hot_tip}^{{tree}}")

                # 空 tree：不创建空 snapshot，hot 重置到 archive tip
                # （此时 hot_tip != archive_tip，即 hot 链上确实有
                #  tree 与 archive 相同的冗余 commit，折叠是真实操作）
                if (
                    archive_tip is not None
                    and rev_parse(repo, f"{archive_tip}^{{tree}}") == tree
                ):
                    # 修复：先 symbolic-ref 再 update-ref，symbolic-ref 失败时
                    # refs 未动，干净退出；update-ref 失败时 HEAD 已指向 hot
                    # （hot 仍是旧值，良性），异常同样干净抛出。
                    git(repo, "symbolic-ref", "HEAD", HOT_REF)
                    git(repo, "update-ref", HOT_REF, archive_tip)
                    log.info(
                        f"{self.name}: compacted {hot_tip[:8]} -> {archive_tip[:8]} "
                        f"(empty tree, 旧 hot tip 变 dangling)"
                    )
                    return CompactResult(
                        folded=True, created_snapshot=False, message="empty tree"
                    )

                # 创建 snapshot commit
                msg = f"snapshot: {datetime.now().isoformat(timespec='seconds')}"
                new = commit_tree(repo, tree, archive_tip, msg)

                # 修复：先 symbolic-ref 再 update-ref。
                # 原顺序（先 update-ref 后 symbolic-ref）在 symbolic-ref 失败时
                # archive/hot 已折叠但 HEAD 未指向 hot，调用方收到"失败"实际
                # 已成功，日志里 dangling 提示也没打出来。交换后两行都满足
                # "失败即 refs 未动或只动 benign 的 HEAD"。
                git(repo, "symbolic-ref", "HEAD", HOT_REF)

                # 原子更新 archive 和 hot（不变式 I12）
                # 必须传 bytes：subprocess 在 Windows 文本模式下会把 \n 转成 \r\n，
                # git update-ref --stdin 的行协议不容忍 CRLF，会报 "expected SP but got: ?"。
                git(
                    repo,
                    "update-ref",
                    "--stdin",
                    text=False,
                    input=(  # noqa: UP012
                        f"update {ARCHIVE_REF} {new}\nupdate {HOT_REF} {new}\n"
                    ).encode("utf-8"),
                )

                log.info(
                    f"{self.name}: compacted {hot_tip[:8]} -> {new[:8]} "
                    f"(旧 hot tip 变 dangling，2 周内可 git fsck --lost-found 找回)"
                )
                return CompactResult(
                    folded=True, created_snapshot=True, message="folded"
                )

    def restore(self, target: str) -> RestoreResult:
        """冷恢复：集合必须已关闭。全有或全无语义。

        锁：GIT_LOCK + FileLock(smtk_lock_path, timeout=360)。
        """
        with GIT_LOCK:
            with FileLock(self._coll.smtk_lock_path(), timeout=360):
                repo = self.repo_path
                kno_src = self.kno_path
                kno_rel = self.kno_rel()

                if not self.is_initialized():
                    raise RuntimeError(f"{self.name}: 仓库未初始化")

                # .kno 路径类型检查（存在但不是普通文件 → 配置错误）
                if kno_src.exists() and not kno_src.is_file():
                    raise RuntimeError(
                        f"{self.name}: {kno_src} 不是普通文件，拒绝恢复（配置错误）"
                    )

                # .kno 锁定检查（.kno 可不存在，restore 会从 commit 重建）
                if kno_src.is_file() and is_kno_locked(kno_src):
                    raise RuntimeError(f"{self.name}: 集合正在激活")

                # 工作区干净检查
                status = git_out(repo, "status", "--porcelain", "--untracked-files=no")
                if status:
                    raise RuntimeError(
                        f"{self.name}: 工作区有未提交改动，请先 backup():\n{status}"
                    )

                commit = rev_parse_commit(repo, target)

                # 目标 commit 含 kno_rel 检查
                target_kno = _commit_kno_bytes(repo, commit, kno_rel)
                if target_kno is None:
                    raise RuntimeError(
                        f"{self.name}: 目标 commit {commit[:8]} 中无 {kno_rel}，拒绝恢复（数据不完整）"
                    )

                # 旧 HEAD 存在性检查（空仓库无 HEAD）
                head_r = git(
                    repo, "rev-parse", "--verify", "--quiet", "HEAD", check=False
                )
                if head_r.returncode != 0:
                    raise RuntimeError(
                        f"{self.name}: 仓库无 HEAD（从未 backup），拒绝恢复"
                    )
                old_head = head_r.stdout.strip()

                # 旧 HEAD 含 kno_rel 检查
                old_kno = _commit_kno_bytes(repo, old_head, kno_rel)
                if old_kno is None:
                    raise RuntimeError(
                        f"{self.name}: 旧 HEAD {old_head[:8]} 中无 {kno_rel}，拒绝恢复（无法回滚）"
                    )

                log.info(f"{self.name}: restoring {old_head[:8]} -> {commit[:8]}")

                try:
                    git(repo, "read-tree", "-u", "--reset", commit)
                    git(repo, "update-ref", HOT_REF, commit)
                    git(repo, "symbolic-ref", "HEAD", HOT_REF)
                except (GitError, subprocess.TimeoutExpired) as e:
                    _try_rollback(repo, old_head, old_kno, kno_src, self.name, e)
                    raise RuntimeError(
                        f"{self.name}: 恢复失败（git 操作），已回滚，请检查 {repo}"
                    ) from e

                try:
                    _write_kno_atomic(kno_src, target_kno)
                except Exception as e:
                    _try_rollback(repo, old_head, old_kno, kno_src, self.name, e)
                    raise RuntimeError(
                        f"{self.name}: 恢复失败（.kno 写回），已回滚，请检查 {repo} 和 {kno_src}"
                    ) from e

                return RestoreResult(target=target, restored=True, old_head=old_head)

    def list_untracked(self) -> list[str]:
        """返回工作区中所有 untracked 路径（相对仓库根），不含 .gitignore 忽略的。

        失败时抛 GitError，禁止降级。
        """
        r = git(
            self.repo_path,
            "ls-files",
            "--others",
            "--exclude-standard",
            "-z",
            check=False,
            text=False,
        )
        if r.returncode != 0:
            err = (r.stderr or b"").decode("utf-8", errors="replace")[:200]
            raise GitError(f"{self.name}: list_untracked failed: {err}")
        raw = r.stdout or b""
        return [p.decode("utf-8", errors="replace") for p in raw.split(b"\0") if p]

    def reset_workspace(self, target: str = "HEAD") -> str:
        """把工作区完全重置到指定 commit，并把 .kno 写回外部。

        一致性承诺：
        - 成功：工作区完全等于目标 commit。所有不在目标 commit 中的文件
          被删除：tracked 被覆盖、untracked 被删除、ignored 文件（如
          temp/、reports/、html/）也被删除。外部 .kno = 目标 commit 的
          .kno 版本。
        - 不成功（阶段 A / B / C0'）：**工作区文件内容完全没动**。
        - 不成功（阶段 C0 `add -A --force` 部分写入后才失败）：代码执行
          `read-tree --reset old_head` 把 index 强制重置为 old_head 版本。
          此时工作区文件内容不变，但 **原先 staged 的改动会变为 unstaged**。
        - 不成功（阶段 C1-C4）：文件内容完全恢复操作前状态（refs、tracked、
          untracked、ignored、外部 .kno 全部恢复）。index 状态丢失
          staged/unstaged 区分（回滚后所有改动都变为 unstaged）。
        - 极端情况（C0 之后进程被 kill）：snapshot ref
          （refs/smtk-reset-snapshot）残留，下次 reset 前置检测即拒绝，
          并给出完整恢复命令（含恢复工作区、index、refs、外部 kno）。

        实现机制（snapshot commit，复用 backup 思路）：
        - 阶段 C0 用 `git add -A --force` 把工作区所有文件（含 ignored）
          加入 index，然后 write-tree + commit-tree（parent = old_head）
          得到完整快照。
        - `git read-tree -u --reset commit` 会把所有"index 里有、目标
          commit 里没有"的文件从工作区删除（包括 ignored 和 untracked）。
          这是实现"成功 = 工作区完全等于 commit"的关键。
        - 失败回滚分两段：
          1. `read-tree -u --reset snapshot` 恢复工作区到快照（含 ignored）
          2. `read-tree --reset old_head` 重置 index 到 HEAD（防 ignored 污染）
          第二段是必需的：snapshot 的 index 含所有 ignored 文件，若不清空，
          下次 backup() 的 `add -A` 会保留它们，`write-tree` 会把 ignored
          文件提交进 hot 链，用户以为永远被忽略的临时文件会永久进入历史。

        锁：GIT_LOCK + FileLock(smtk_lock_path, timeout=360)。

        Args:
            target: rev 表达式，如 "HEAD" 或 "HEAD^"

        Returns:
            目标 commit 的完整 hash

        Raises:
            NoTargetCommit: target 无法解析
            RuntimeError: 阶段 A / B / C0' / C0 失败（工作区文件内容未动；
                C0 失败时 index 可能被 reset）
            ResetFailed: 阶段 C1-C4 失败，文件内容已完全恢复
            ResetRollbackFailed: 阶段 C1-C4 失败且回滚不完整，
                snapshot ref 保留供手动恢复
        """
        with GIT_LOCK:
            with FileLock(self._coll.smtk_lock_path(), timeout=360):
                repo = self.repo_path
                kno_src = self.kno_path
                kno_rel = self.kno_rel()

                # ============ 阶段 A：前置检查 ============
                if not self.is_initialized():
                    raise RuntimeError(f"{self.name}: 仓库未初始化")
                if kno_src.exists() and not kno_src.is_file():
                    raise RuntimeError(f"{self.name}: {kno_src} 不是普通文件，拒绝重置")
                if kno_src.is_file() and is_kno_locked(kno_src):
                    raise RuntimeError(f"{self.name}: 集合正在激活，拒绝重置")

                # 提前定义 kno_tmp，阶段 B 复用；残留 ref 清理和阶段 B 都用到
                kno_tmp = kno_src.with_suffix(kno_src.suffix + ".smtk-tmp")

                # 残留 snapshot ref 检测（进程被 kill 的迹象）
                if ref_exists(repo, SNAPSHOT_REF):
                    # 顺带清理上次 kill 残留的 tmp（阶段 B 尚未执行，此处只能
                    # 是上次的残留）
                    kno_tmp.unlink(missing_ok=True)
                    old_snap = rev_parse(repo, SNAPSHOT_REF)
                    raise RuntimeError(
                        f"{self.name}: 发现上次 reset 残留的快照 "
                        f"{SNAPSHOT_REF} -> {old_snap[:8]}，可能是进程被强杀。\n"
                        f"\n"
                        f"【第一步：确认当前状态】\n"
                        f"请先运行以下命令，对比当前 HEAD 与快照 parent：\n"
                        f"  git -C {repo} status\n"
                        f"  git -C {repo} log --oneline -3 HEAD\n"
                        f"  git -C {repo} log --oneline -3 {SNAPSHOT_REF}\n"
                        f"\n"
                        f"判断：\n"
                        f"  - 若 HEAD 的 hash == {SNAPSHOT_REF}^（快照 parent），\n"
                        f"    说明 refs 未被移动，只需恢复工作区和 index（方案 A）。\n"
                        f"  - 若 HEAD 的 hash 不同，说明 refs 已被移动，需完整恢复（方案 B）。\n"
                        f"  - 若工作区实际已经等于目标 commit（重置其实成功了），\n"
                        f"    只需清理快照（方案 C）。\n"
                        f"\n"
                        f"【方案 A：完整恢复（工作区 + index + refs + 外部 kno）】\n"
                        f"  git -C {repo} read-tree -u --reset {SNAPSHOT_REF}\n"
                        f"  git -C {repo} read-tree --reset {SNAPSHOT_REF}^\n"
                        f"  git -C {repo} update-ref {HOT_REF} {SNAPSHOT_REF}^\n"
                        f"  git -C {repo} symbolic-ref HEAD {HOT_REF}\n"
                        f"  git -C {repo} cat-file -p {SNAPSHOT_REF}:{kno_rel} > {kno_src}\n"
                        f"  git -C {repo} update-ref -d {SNAPSHOT_REF}\n"
                        f"\n"
                        f"【方案 B：只清理快照】\n"
                        f"  git -C {repo} update-ref -d {SNAPSHOT_REF}"
                    )

                # 未合并冲突会导致 add -A 失败。
                # check=True：命令本身失败（仓库损坏）时抛异常，不降级为
                # "无 unmerged"（那样会在 C0 阶段以误导性错误失败）。
                unmerged = git(repo, "ls-files", "--unmerged").stdout.strip()
                if unmerged:
                    raise RuntimeError(
                        f"{self.name}: 存在未合并的冲突文件，请先解决再重置"
                    )

                head_r = git(
                    repo, "rev-parse", "--verify", "--quiet", "HEAD", check=False
                )
                if head_r.returncode != 0:
                    raise RuntimeError(
                        f"{self.name}: 仓库无 HEAD（从未 backup），拒绝重置"
                    )
                old_head = head_r.stdout.strip()

                try:
                    commit = rev_parse_commit(repo, target)
                except (GitError, subprocess.TimeoutExpired) as e:
                    raise NoTargetCommit(
                        f"{self.name}: 无法解析目标 {target!r}（可能无父提交）"
                    ) from e

                target_kno = _commit_kno_bytes(repo, commit, kno_rel)
                if target_kno is None:
                    raise RuntimeError(
                        f"{self.name}: 目标 commit {commit[:8]} 中无 {kno_rel}，"
                        f"拒绝重置（数据不完整）"
                    )

                if _commit_kno_bytes(repo, old_head, kno_rel) is None:
                    raise RuntimeError(
                        f"{self.name}: 旧 HEAD {old_head[:8]} 中无 {kno_rel}，"
                        f"拒绝重置（仓库状态异常）"
                    )

                try:
                    old_kno_actual: bytes | None = (
                        kno_src.read_bytes() if kno_src.is_file() else None
                    )
                except OSError as e:
                    raise RuntimeError(
                        f"{self.name}: 读取 {kno_src} 失败，未做任何改动: {e}"
                    ) from e

                # ============ 阶段 B：写 kno tmp ============
                try:
                    kno_tmp.write_bytes(target_kno)
                    if _sha256_file(kno_tmp) != _sha256_bytes(target_kno):
                        raise OSError("tmp 内容 SHA-256 校验失败")
                except OSError as e:
                    kno_tmp.unlink(missing_ok=True)
                    raise RuntimeError(
                        f"{self.name}: 写 .kno 临时文件失败，未做任何改动: {e}"
                    ) from e

                # ============ 阶段 C0'：二次激活检查 ============
                if kno_src.is_file() and is_kno_locked(kno_src):
                    kno_tmp.unlink(missing_ok=True)
                    raise RuntimeError(
                        f"{self.name}: 集合在重置执行前被激活，拒绝重置（数据未变）"
                    )

                # ============ 阶段 C0：创建 snapshot commit ============
                # add -A --force：把工作区所有文件（含 .gitignore 忽略的）
                # 加入 index。这样 read-tree -u --reset commit 时，所有不在
                # 目标 commit 里的文件（无论之前是 tracked、untracked 还是
                # ignored）都会被识别为"被移除的 index entry"并删除。
                try:
                    git(
                        repo,
                        "add",
                        "-A",
                        "--force",
                        "--",
                        ".",
                        ":(exclude,glob)**/*.lock",
                        ":(exclude,glob)*.lock",
                    )
                    snapshot_tree = git_out(repo, "write-tree")
                except (GitError, subprocess.TimeoutExpired) as e:
                    # 恢复 index 到 old_head（不改工作区）。
                    # check=False 时不抛异常，必须显式检查 returncode，
                    # 否则 index 恢复失败被静默吞掉，用户看到的是
                    # "创建快照失败"但不知道 index 也坏了。
                    reset_r = git(repo, "read-tree", "--reset", old_head, check=False)
                    if reset_r.returncode != 0:
                        reset_err = (
                            reset_r.stderr
                            if isinstance(reset_r.stderr, str)
                            else reset_r.stderr.decode(errors="replace")
                        )
                        log.error(
                            f"{self.name}: C0 失败后重置 index 也失败: {reset_err}。"
                            f"index 可能停留在部分 staged 状态，可用 "
                            f"git -C {repo} read-tree --reset {old_head} 手动清理。"
                            f"（原始错误: {e}）"
                        )
                    kno_tmp.unlink(missing_ok=True)
                    raise RuntimeError(
                        f"{self.name}: 创建快照时暂存工作区失败"
                        f"（工作区文件内容未变；index 已尝试重置到 HEAD 版本，"
                        f"原 staged 状态可能丢失）: {e}"
                    ) from e

                # 始终创建 snapshot（包含工作区所有文件，含 ignored）。
                # parent = old_head：让残留 ref 恢复时可以用 SNAPSHOT_REF^
                # 找回操作前 HEAD。
                try:
                    snap_msg = (
                        f"smtk-reset-snapshot "
                        f"{datetime.now().isoformat(timespec='seconds')}"
                    )
                    snapshot_commit = commit_tree(
                        repo, snapshot_tree, old_head, snap_msg
                    )
                    git(repo, "update-ref", SNAPSHOT_REF, snapshot_commit)
                except (GitError, subprocess.TimeoutExpired) as e:
                    # 创建 commit 或 ref 失败。index 已 modified，恢复它。
                    reset_r = git(repo, "read-tree", "--reset", old_head, check=False)
                    if reset_r.returncode != 0:
                        reset_err = (
                            reset_r.stderr
                            if isinstance(reset_r.stderr, str)
                            else reset_r.stderr.decode(errors="replace")
                        )
                        log.error(
                            f"{self.name}: 快照 commit 创建失败后重置 index 也失败: "
                            f"{reset_err}。index 可能停留在部分 staged 状态，可用 "
                            f"git -C {repo} read-tree --reset {old_head} 手动清理。"
                            f"（原始错误: {e}）"
                        )
                    kno_tmp.unlink(missing_ok=True)
                    raise RuntimeError(
                        f"{self.name}: 创建快照 commit 失败"
                        f"（工作区文件内容未变；index 已尝试重置到 HEAD 版本，"
                        f"原 staged 状态可能丢失）: {e}"
                    ) from e

                # log.info 移出 try：logging 极端失败时也不留未清理的 ref
                log.info(f"{self.name}: created snapshot {snapshot_commit[:8]}")

                log.info(
                    f"{self.name}: resetting workspace {old_head} -> "
                    f"{commit[:8]} ({target})"
                )

                # ============ 阶段 C1-C4：执行写操作 ============
                # C4 使用 _write_kno_atomic（与 restore 一致）：内部写 tmp +
                # os.replace + SHA-256 校验，失败时清理 tmp 并 raise。
                # 阶段 B 写的 kno_tmp 会被 _write_kno_atomic 内部同名 tmp 覆盖，
                # 等价且更安全；若 git 命令失败（还没到 C4），阶段 B 的 kno_tmp
                # 仍在，由下面 except 里的 unlink 清理。
                try:
                    git(repo, "read-tree", "-u", "--reset", commit)
                    git(repo, "update-ref", HOT_REF, commit)
                    git(repo, "symbolic-ref", "HEAD", HOT_REF)
                    _write_kno_atomic(kno_src, target_kno)
                except Exception as e:
                    kno_tmp.unlink(missing_ok=True)

                    # ---- 回滚 ----
                    # 需要恢复：
                    #   1. 工作区到 snapshot（含 ignored 原内容）
                    #   2. index 到 old_head（避免 ignored 污染下一次 backup）
                    #   3. HOT_REF/HEAD 到 old_head
                    #   4. 外部 .kno 到操作前字节
                    rb_ok = True

                    # 1. 恢复工作区到 snapshot（-u 才会更新工作区）
                    try:
                        git(repo, "read-tree", "-u", "--reset", snapshot_commit)
                    except (GitError, subprocess.TimeoutExpired) as re:
                        rb_ok = False
                        log.error(f"{self.name}: 回滚工作区失败: {re}")

                    # 2. 重置 index 到 old_head（不带 -u，不动工作区）。
                    # 这一步至关重要：snapshot 是用 add -A --force 创建的，
                    # 包含所有 ignored 文件。若 index 停留在 snapshot，
                    # 下次 backup() 的 add -A 不会移除它们，write-tree 会把
                    # ignored 文件提交进 hot 链，用户以为永远被忽略的临时
                    # 文件会永久进入 Git 历史。
                    try:
                        git(repo, "read-tree", "--reset", old_head)
                    except (GitError, subprocess.TimeoutExpired) as re:
                        rb_ok = False
                        log.error(f"{self.name}: 回滚 index 失败: {re}")

                    # 3. 恢复 refs
                    try:
                        git(repo, "update-ref", HOT_REF, old_head)
                        git(repo, "symbolic-ref", "HEAD", HOT_REF)
                    except (GitError, subprocess.TimeoutExpired) as re:
                        rb_ok = False
                        log.error(f"{self.name}: 回滚 refs 失败: {re}")

                    # 4. 恢复外部 .kno
                    try:
                        if old_kno_actual is not None:
                            _write_kno_atomic(kno_src, old_kno_actual)
                        else:
                            kno_src.unlink(missing_ok=True)
                    except Exception as ke:
                        rb_ok = False
                        log.error(f"{self.name}: 回滚外部 .kno 失败: {ke}")

                    if rb_ok:
                        # 回滚完整成功 → 清理 snapshot ref。
                        # check=False 时不抛异常，必须显式检查 returncode，
                        # 否则清理失败被静默吞掉，下次 reset 会因残留 ref
                        # 拒绝，用户困惑："上次明明说完全回滚了"。
                        drop_r = git(
                            repo, "update-ref", "-d", SNAPSHOT_REF, check=False
                        )
                        if drop_r.returncode != 0:
                            drop_err = (
                                drop_r.stderr
                                if isinstance(drop_r.stderr, str)
                                else drop_r.stderr.decode(errors="replace")
                            )
                            log.warning(
                                f"{self.name}: 回滚成功后清理 snapshot ref 失败: "
                                f"{drop_err}。可手动 "
                                f"git -C {repo} update-ref -d {SNAPSHOT_REF}"
                            )
                        raise ResetFailed(
                            f"{self.name}: 重置失败，文件内容已完全回滚"
                            f"（refs、tracked、untracked、ignored、外部 .kno 均已恢复；"
                            f"原 staged/unstaged 区分丢失，所有改动现为 unstaged）。"
                            f"原始错误: {e}"
                        ) from e

                    # 回滚不完整 → **保留** snapshot ref，供用户手动恢复
                    log.error(
                        f"{self.name}: 回滚不完整，保留 snapshot "
                        f"{SNAPSHOT_REF} -> {snapshot_commit[:8]}，可手动恢复"
                    )
                    raise ResetRollbackFailed(
                        f"{self.name}: 重置失败且回滚不完整，仓库/文件可能不一致。\n"
                        f"快照 {SNAPSHOT_REF} -> {snapshot_commit[:8]} 保留"
                        f"（含操作前完整工作区，parent 指向操作前 HEAD）。\n"
                        f"\n"
                        f"【第一步：确认当前状态】\n"
                        f"  git -C {repo} status\n"
                        f"  git -C {repo} log --oneline -3 HEAD\n"
                        f"\n"
                        f"【恢复操作前状态（依次执行）】\n"
                        f"  1. 恢复工作区：\n"
                        f"     git -C {repo} read-tree -u --reset {SNAPSHOT_REF}\n"
                        f"  2. 重置 index 到操作前 HEAD（防 ignored 文件污染）：\n"
                        f"     git -C {repo} read-tree --reset {SNAPSHOT_REF}^\n"
                        f"  3. 恢复 hot 分支：\n"
                        f"     git -C {repo} update-ref {HOT_REF} {SNAPSHOT_REF}^\n"
                        f"  4. 恢复 HEAD：\n"
                        f"     git -C {repo} symbolic-ref HEAD {HOT_REF}\n"
                        f"  5. 恢复外部 .kno：\n"
                        f"     git -C {repo} cat-file -p {SNAPSHOT_REF}:{kno_rel} > {kno_src}\n"
                        f"  6. 清理快照：\n"
                        f"     git -C {repo} update-ref -d {SNAPSHOT_REF}\n"
                        f"\n"
                        f"如已确认工作区状态正确（例如重置其实已成功），\n"
                        f"只清理快照即可：\n"
                        f"  git -C {repo} update-ref -d {SNAPSHOT_REF}\n"
                        f"\n"
                        f"原始错误: {e}。请手动检查 {repo} 和 {kno_src}。"
                    ) from e

                # ============ 成功：删除 snapshot ref ============
                drop_r = git(repo, "update-ref", "-d", SNAPSHOT_REF, check=False)
                if drop_r.returncode != 0:
                    drop_err = (
                        drop_r.stderr
                        if isinstance(drop_r.stderr, str)
                        else drop_r.stderr.decode(errors="replace")
                    )
                    log.warning(
                        f"{self.name}: 删除 snapshot ref 失败: {drop_err}。"
                        f"可手动 git -C {repo} update-ref -d {SNAPSHOT_REF}"
                    )
                else:
                    log.info(f"{self.name}: cleaned up snapshot {snapshot_commit[:8]}")

                log.info(
                    f"{self.name}: workspace reset to {commit[:8]} ({target}), "
                    f"old_head={old_head}"
                )
                return commit

    def forget(self) -> bool:
        """让集合遗忘 Git 历史：删除 .git 目录。

        锁：GIT_LOCK + FileLock(smtk_lock_path, timeout=360)。

        Raises:
            RuntimeError: .kno 不是文件、被锁定、工作区有未提交改动、
                HEAD 不存在、HEAD 缺 kno_rel、.kno 与 HEAD 不一致、删除 .git 失败。
        """
        with GIT_LOCK:
            with FileLock(self._coll.smtk_lock_path(), timeout=360):
                kno_src = self.kno_path
                kno_rel = self.kno_rel()
                kno_store = self.kno_store_path
                repo = self.repo_path
                name = self.name

                # 1. .kno 是文件检查
                if not kno_src.is_file():
                    raise RuntimeError(
                        f"{name}: {kno_src} 不是文件或不存在，拒绝卸载（集合数据不完整）"
                    )

                # 2. .kno 锁定检查
                if is_kno_locked(kno_src):
                    raise RuntimeError(f"{name}: 集合正在激活，请先关闭 SuperMemo")

                # 3. 未初始化 → 无需卸载
                if not self.is_initialized():
                    log.debug(f"{name}: 无 .git 目录，跳过卸载")
                    return False

                # 4. 工作区干净检查（tracked 无改动）
                status = git_out(repo, "status", "--porcelain", "--untracked-files=no")
                if status:
                    raise RuntimeError(
                        f"{name}: tracked 文件有未提交改动，拒绝卸载。"
                        f"请先 backup() 后再试。\n{status}"
                    )

                # 5. HEAD 存在性检查
                head = git(
                    repo, "rev-parse", "--verify", "--quiet", "HEAD", check=False
                )
                if head.returncode != 0:
                    raise RuntimeError(
                        f"{name}: 仓库无 HEAD，拒绝卸载（无法校验 .kno 一致性）"
                    )
                head_commit = head.stdout.strip()

                # 6. HEAD 含 kno_rel 检查
                data = _commit_kno_bytes(repo, head_commit, kno_rel)
                if data is None:
                    raise RuntimeError(
                        f"{name}: HEAD 中无 {kno_rel}，拒绝卸载（无法校验 .kno 一致性）"
                    )

                # 7. 外部 .kno 与 HEAD 字节一致检查
                if _sha256_file(kno_src) != _sha256_bytes(data):
                    raise RuntimeError(
                        f"{name}: 外部 .kno 与 HEAD 不一致，"
                        f"SuperMemo 关闭后可能还没备份。请先 backup() 后再试。"
                    )

                # 8. 原子写回外部 .kno（幂等，防御不完整写入）
                _write_kno_atomic(kno_src, data)
                log.info(f"{name}: .kno 已从 HEAD {head_commit[:8]} 写回外部")

                # 9. 删除 .git（核心操作，失败 raise，.git 还在可重试）
                git_dir = repo / ".git"

                def _on_error(func, path, exc_info):
                    try:
                        os.chmod(path, 0o700)
                        func(path)
                    except OSError:
                        raise

                try:
                    if sys.version_info >= (3, 12):
                        shutil.rmtree(git_dir, onexc=_on_error)
                    else:
                        shutil.rmtree(git_dir, onerror=_on_error)
                except OSError as e:
                    raise RuntimeError(f"{name}: 删除 .git 失败: {e}") from e

                # 10. 删除 .gitignore / .gitattributes（次要清理，失败 log.warning）
                for fname in (".gitignore", ".gitattributes"):
                    p = repo / fname
                    if p.exists():
                        try:
                            p.unlink()
                        except OSError as e:
                            log.warning(f"{name}: 删除 {fname} 失败: {e}")

                # 11. 删除工作区 kno_store（恢复初始化前结构）
                #     失败时 .git 已删，无法回滚；错误消息说明手动删除
                if kno_store.exists():
                    try:
                        kno_store.unlink()
                    except OSError as e:
                        raise RuntimeError(
                            f"{name}: .git 已删除，但工作区 {kno_store} 删除失败: {e}。"
                            f"请手动删除 {kno_store} 以完成 forget。"
                        ) from e

                log.info(f"{name}: 已卸载 git 仓库 ({repo})，工作区已恢复初始化前结构")
                return True

    def snapshots(self) -> SnapshotData | None:
        """返回集合快照数据；仓库不存在返回 None。"""
        repo = self.repo_path
        if not self.is_initialized():
            return None

        data = SnapshotData(
            name=self.name,
            kno=str(self.kno_path),
            store=self._coll.kno_store_path().name,
            archive=[],
            hot=[],
        )

        if ref_exists(repo, ARCHIVE_REF):
            out = git_out(repo, "log", "--format=%h %s", ARCHIVE_REF)
            data.archive = out.splitlines() if out else []

        if ref_exists(repo, HOT_REF):
            out = git_out(repo, "log", "--format=%h %s", HOT_REF)
            data.hot = out.splitlines() if out else []

        return data

    def list_snapshots(self) -> None:
        """打印集合快照信息。"""
        data = self.snapshots()
        if data is None:
            print("not a repo")
            return
        print(f"=== {data.name} ===")
        print(f"kno: {data.kno}  (store: {data.store})")
        if data.archive:
            print("\n[archive]")
            for line in data.archive:
                print(line)
        if data.hot:
            print("\n[hot]")
            for line in data.hot:
                parts = line.split(" ", 1)
                if len(parts) == 2 and parts[1].startswith("snapshot: "):
                    print(f"{line}  (compact 后 hot 指向的 snapshot)")
                else:
                    print(line)


# ============================================================================
# tray / watch - 图标管理
# ============================================================================


def _make_tray_image(color, outline=(0, 0, 0, 255)):
    img = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.ellipse([4, 4, 60, 60], fill=color, outline=outline, width=3)
    return img


COLORS = {
    "running": (76, 175, 80, 255),
    "active": (33, 150, 243, 255),
    "done": (158, 158, 158, 255),
    "waiting": (255, 193, 7, 255),
    "error": (244, 67, 54, 255),
    "paused": (129, 92, 148, 255),
}

TITLES = {
    "running": "SuperMemo 备份守护（处理中）",
    "active": "SuperMemo 备份守护（集合已激活）",
    "done": "SuperMemo 备份守护（空闲）",
    "waiting": "SuperMemo 备份守护（等待激活）",
    "error": "SuperMemo 备份守护（错误）",
    "paused": "SuperMemo 备份守护（监听已暂停）",
}


def _update_icon(holder: dict, state: str, detail: str = ""):
    icon = holder.get("icon")
    if icon is None:
        return
    try:
        icon.icon = _make_tray_image(COLORS.get(state, COLORS["done"]))
        title = TITLES.get(state, TITLES["done"])
        if detail:
            title = f"{title} - {detail}"
        icon.title = title
    except Exception as e:
        log.debug(f"update_icon: {e}")


# ============================================================================
# Watcher - 托盘监控生命周期封装（轮询 .kno 锁定状态）
# ============================================================================


class Watcher:
    """封装 SuperMemo 集合监控的完整生命周期。

    使用 0.5 秒轮询 is_kno_locked 检测集合的打开/关闭。
    只 backup，不 compact。折叠由用户通过托盘菜单手动触发。

    托盘菜单提供「暂停监听」开关：暂停期间轮询线程完全停止探测，
    不感知集合打开/关闭，因此不触发自动关闭备份；恢复监听时重新
    同步当前状态，不补做暂停期间错过的备份。手动 backup() /
    compact() / reset_workspace() 不受影响。每次 start() 默认开始监听。

    已知限制见模块文档字符串。
    """

    def __init__(self, config: BackupConfig) -> None:
        self._config = config
        self._stop_event: threading.Event | None = None
        self._thread: threading.Thread | None = None
        self._holder: dict = {}
        self._inflight = 0
        self._ops_lock = threading.Lock()
        self._idle_event = threading.Event()
        # 修复：未 start 时没有 inflight 操作，stop() 不应等 300 秒。
        # Event() 初始为 unset，wait() 会一直阻塞到超时。
        self._idle_event.set()
        # set() 表示「监听已暂停」。默认不暂停。
        self._pause_event = threading.Event()

    @property
    def config(self) -> BackupConfig:
        return self._config

    def _track(self, fn) -> None:
        """包装状态变更处理，维护 inflight 计数。"""
        with self._ops_lock:
            self._inflight += 1
            self._idle_event.clear()
        try:
            fn()
        finally:
            with self._ops_lock:
                self._inflight -= 1
                if self._inflight == 0:
                    self._idle_event.set()

    def _backup_only(self, c: Collection) -> None:
        """只 backup，不 compact。"""
        self._update_icon("running", f"{c.name} 备份中")
        try:
            r = CollectionRepo(c).backup("shutdown")
        except Exception as e:
            log.error(f"{c.name}: backup failed: {e}")
            self._update_icon("error", f"{c.name} 备份失败")
            return
        if r.skipped:
            log.info(f"{c.name}: backup skipped (no change)")
            self._update_icon("done", f"{c.name} 无变化")
        else:
            log.info(f"{c.name}: backup {r.commit[:8]}")
            self._update_icon("done", f"{c.name} 已备份")

    def _is_active_safe(self, c: Collection, err_state: dict[str, bool]) -> bool | None:
        """探测集合是否激活。

        返回 True/False 为确定状态；返回 None 表示探测失败，状态未知，
        调用方必须跳过本轮状态转换判定并保留原 was_active。

        同一集合连续失败只记录一次 error 日志和图标，恢复时记一条 info，
        避免每 0.5 秒刷爆 time.log。
        """
        try:
            result = c.kno_path().is_file() and is_kno_locked(c.kno_path())
        except Exception as e:
            if not err_state.get(c.name):
                err_state[c.name] = True
                log.error(f"{c.name}: 探测激活状态失败: {e}")
                self._update_icon("error", f"{c.name} 状态探测失败")
            return None
        if err_state.pop(c.name, False):
            log.info(f"{c.name}: 激活状态探测已恢复")
        return result

    def _probe_states(
        self, err_state: dict[str, bool], was_active: dict[str, bool]
    ) -> None:
        """探测所有集合的激活状态写入 was_active。

        只更新图标，不触发打开/关闭事件。供 _poll_loop 初始化与恢复监听时复用。
        """
        for c in self._config.collections:
            active = self._is_active_safe(c, err_state)
            if active is None:
                continue
            was_active[c.name] = active
            if active:
                self._update_icon("active", c.name)

    def _poll_loop(self) -> None:
        """定期轮询集合激活状态，检测打开/关闭转换。

        单集合探测失败只影响该集合本轮判定（状态未知则跳过、保留原状态），
        不会终止轮询线程，其他集合的监控和自动备份不受影响。

        监听暂停（_pause_event 被 set）时不做任何探测、不感知打开/关闭，
        也不触发自动备份；恢复时重新探测当前状态，只更新图标，
        不补做暂停期间错过的关闭备份。
        """
        err_state: dict[str, bool] = {}
        was_active: dict[str, bool] = {}

        self._probe_states(err_state, was_active)

        pending_close: dict[str, float] = {}

        while not self._stop_event.is_set():
            # ---- 暂停监听：不做任何探测，等待恢复 ----
            if self._pause_event.is_set():
                # 已排队未执行的关闭备份直接丢弃；was_active 清空后
                # 恢复时重新同步，避免暂停期间的关闭被当作新事件。
                pending_close.clear()
                was_active.clear()
                self._update_icon("paused", "监听已暂停")
                while not self._stop_event.is_set() and self._pause_event.is_set():
                    _time.sleep(0.5)
                if self._stop_event.is_set():
                    break
                # ---- 恢复监听：重新探测当前状态，只更新图标，不触发事件 ----
                self._update_icon("waiting", "监听已恢复")
                log.info("监听已恢复")
                self._probe_states(err_state, was_active)
                continue

            _time.sleep(0.5)
            now = _time.time()

            for c in self._config.collections:
                active = self._is_active_safe(c, err_state)
                if active is None:
                    # 状态未知：不改 was_active，不触发打开/关闭事件
                    continue
                prev = was_active.get(c.name, False)
                if active and not prev:
                    self._update_icon("active", c.name)
                    log.info(f"{c.name}: 检测到集合被打开")
                elif not active and prev:
                    pending_close[c.name] = now + 1.0
                    self._update_icon("waiting")
                    log.info(f"{c.name}: 检测到集合被关闭")
                was_active[c.name] = active

            for name in list(pending_close):
                if now < pending_close[name]:
                    continue
                del pending_close[name]
                c = next((x for x in self._config.collections if x.name == name), None)
                if c is None:
                    continue
                active = self._is_active_safe(c, err_state)
                if active is None:
                    # 探测失败：放弃本次关闭备份，was_active 仍为 True，
                    # 恢复探测后下一轮会重新检测到关闭转换并备份。
                    continue
                if active:
                    self._update_icon("active", name)
                    continue
                self._track(lambda c=c: self._backup_only(c))

    def _update_icon(self, state: str, detail: str = "") -> None:
        if self._holder.get("icon") is None:
            return
        key = (state, detail)
        if key == self._holder.get("_last_icon_key"):
            return
        self._holder["_last_icon_key"] = key
        _update_icon(self._holder, state, detail)

    def _on_compact(self, icon, item) -> None:
        """托盘菜单：压缩历史（后台执行，不阻塞托盘）。"""

        def _do():
            try:
                self._update_icon("running", "压缩中")
                failed: list[str] = []
                for c in self._config.collections:
                    try:
                        r = CollectionRepo(c).compact()
                        log.info(f"{c.name}: compact -> {r.message}")
                    except Exception as e:
                        failed.append(c.name)
                        log.error(f"{c.name}: compact failed: {e}")
                msg = f"压缩完成，失败: {', '.join(failed)}" if failed else "压缩完成"
                try:
                    icon.notify(msg, "time")
                except Exception:
                    pass
                if failed:
                    self._update_icon("error", f"压缩失败: {', '.join(failed)}")
                else:
                    self._update_icon("done", "压缩完成")
            except Exception as e:
                log.error(f"compact background thread failed: {e}")

        threading.Thread(target=lambda: self._track(_do), daemon=True).start()

    def _on_toggle_pause(self, icon, item) -> None:
        """托盘菜单：暂停 / 恢复监听。

        暂停时 _poll_loop 完全停止探测 .kno 锁定状态，不感知集合打开/关闭，
        因此也不会触发自动关闭备份。恢复时重新探测当前状态，不补做暂停期间
        错过的关闭备份。手动 backup / compact / reset_workspace 不受影响。
        """
        try:
            if self._pause_event.is_set():
                self._pause_event.clear()
                log.info("已恢复监听")
                try:
                    icon.notify("已恢复监听", "time")
                except Exception:
                    pass
                self._update_icon("waiting", "监听已恢复")
            else:
                self._pause_event.set()
                log.info("已暂停监听")
                try:
                    icon.notify("已暂停监听（手动备份不受影响）", "time")
                except Exception:
                    pass
                self._update_icon("paused", "监听已暂停")
        except Exception as e:
            log.error(f"toggle pause: {e}")
        finally:
            # 刷新菜单勾选状态（不同后端对 checked 的计算时机不同，
            # 显式 update_menu 最稳妥）
            try:
                icon.update_menu()
            except Exception as e:
                log.debug(f"update_menu: {e}")

    def _make_reset_menu(self, target: str) -> pystray.Menu:
        """为指定 target 生成「按集合选择」子菜单。

        只列出已经 git 初始化的集合。未初始化的集合没有 HEAD/commit，
        reset 无意义，隐藏它们避免用户误点后收到"未初始化"提示。

        用工厂函数创建签名严格为 (icon, item) 的 handler。
        pystray 的 _assert_action 要求 action 正好接受 2 个位置参数，
        带额外默认参数的 lambda 会被拒绝。

        注意：集合的初始化状态在 start() 时静态确定。若用户在 watcher
        运行期间新初始化仓库，需要重启 watcher 才会出现在菜单里。
        """

        def make_handler(cname: str):
            def handler(icon, item):
                self._on_reset(icon, item, target, cname)

            return handler

        items: list[pystray.MenuItem] = []
        for c in self._config.collections:
            try:
                if not CollectionRepo(c).is_initialized():
                    continue
            except Exception as e:
                log.warning(f"reset menu: 检查 {c.name} 初始化状态失败，跳过: {e}")
                continue
            items.append(pystray.MenuItem(c.name, make_handler(c.name)))

        if not items:
            items.append(pystray.MenuItem("(无已初始化集合)", None, enabled=False))
        return pystray.Menu(*items)

    def _on_reset(self, icon, item, target: str, name: str) -> None:
        """托盘菜单：重置指定集合的工作区到 target。后台执行，不阻塞托盘。"""
        label = "HEAD" if target == "HEAD" else "上一次提交"

        def _notify(msg: str) -> None:
            try:
                icon.notify(msg, "time")
            except Exception:
                pass

        def _do():
            try:
                c = next((x for x in self._config.collections if x.name == name), None)
                if c is None:
                    log.error(f"reset: collection not found: {name}")
                    return

                self._update_icon("running", f"{name} 重置中 ({label})")
                repo = CollectionRepo(c)

                if not repo.is_initialized():
                    log.info(f"{name}: 未初始化，跳过 reset")
                    _notify(f"{name} 未初始化，跳过")
                    self._update_icon("done", f"{name} 未初始化")
                    return

                try:
                    active = repo.is_active()
                except Exception as e:
                    log.error(f"{name}: 探测激活状态失败: {e}")
                    _notify(f"{name} 状态探测失败")
                    self._update_icon("error", f"{name} 状态探测失败")
                    return
                if active:
                    log.warning(f"{name}: 集合正在激活，拒绝重置")
                    _notify(f"{name} 正在激活，请先关闭 SuperMemo")
                    self._update_icon("active", name)
                    return

                try:
                    commit = repo.reset_workspace(target)
                except NoTargetCommit as e:
                    log.info(f"{name}: reset to {target} skipped: {e}")
                    _notify(f"{name} 无目标提交（{label}）")
                    self._update_icon("done", f"{name} 无目标提交")
                    return
                except ResetFailed as e:
                    log.warning(f"{name}: reset failed but rolled back: {e}")
                    _notify(f"{name} 重置失败，已完全回滚（文件内容未变）")
                    self._update_icon("error", f"{name} 重置失败（已回滚）")
                    return
                except ResetRollbackFailed as e:
                    log.error(f"{name}: reset rollback FAILED: {e}")
                    _notify(
                        f"{name} 重置失败且回滚不完整！"
                        f"快照 refs/smtk-reset-snapshot 保留，请打开日志查看恢复步骤"
                    )
                    self._update_icon("error", f"{name} 需人工检查！")
                    return
                except Exception as e:
                    log.error(f"{name}: reset failed pre-write: {e}")
                    # 针对常见前置检查失败给出更有指向性的通知，
                    # 避免用户看到笼统的"数据未变"却不知道下一步做什么。
                    msg = str(e)
                    if "发现上次 reset 残留的快照" in msg:
                        _notify(
                            f"{name} 检测到上次残留的快照！"
                            f"请打开日志查看恢复步骤（方案 A/B/C）"
                        )
                    elif "存在未合并的冲突文件" in msg:
                        _notify(f"{name} 有未解决的 git 冲突，请先在集合目录手动处理")
                    elif "不是普通文件" in msg:
                        _notify(f"{name} 的 .kno 路径配置异常，请检查配置")
                    else:
                        _notify(f"{name} 重置失败，数据未变（详见日志）")
                    self._update_icon("error", f"{name} 重置失败")
                    return

                log.info(f"{name}: reset to {commit[:8]} ({label})")

                # reset_workspace 成功路径里 update-ref -d SNAPSHOT_REF 失败
                # 只 log.warning 不 raise；上层再查一次 ref，若残留则通知用户
                # 手动清理，避免下次 reset 被"发现上次残留的快照"误导。
                try:
                    leftover = ref_exists(repo.repo_path, SNAPSHOT_REF)
                except Exception:
                    leftover = False
                if leftover:
                    log.warning(
                        f"{name}: reset 成功但 snapshot ref 残留 "
                        f"{SNAPSHOT_REF}，需手动清理"
                    )
                    _notify(
                        f"{name} 已重置，但快照清理失败，请手动 "
                        f"git -C {repo.repo_path} update-ref -d {SNAPSHOT_REF}"
                    )
                    self._update_icon("error", f"{name} 已重置（快照残留）")
                else:
                    _notify(f"{name} 已重置到 {label}（未备份改动已丢弃）")
                    self._update_icon("done", f"{name} 已重置 ({label})")
            except Exception as e:
                log.error(f"reset background thread failed: {e}")

        threading.Thread(target=lambda: self._track(_do), daemon=True).start()

    def _on_open_dir(self, icon, item) -> None:
        """托盘菜单：打开配置目录。"""
        try:
            if sys.platform == "win32":
                os.startfile(str(config_dir()))
            else:
                log.warning("打开配置目录仅支持 Windows 平台")
        except Exception as e:
            log.error(f"open dir: {e}")

    def _on_open_log(self, icon, item) -> None:
        """托盘菜单：打开日志文件。"""
        try:
            if sys.platform == "win32":
                os.startfile(_get_log_file())
            else:
                log.warning("打开日志文件仅支持 Windows 平台")
        except Exception as e:
            log.error(f"open log: {e}")

    def _on_quit(self, icon, item) -> None:
        """托盘菜单：退出。

        不在 pystray 回调线程里同步等待 inflight 备份，避免托盘假死：
        回调只更新图标、给出提示、启动后台停止线程后立即返回。
        真正的等待发生在 start() 的 finally（icon.run() 返回后），
        由主线程完成，保证不中断正在执行的 git 子进程。
        """
        self._update_icon("running", "正在退出…")
        try:
            icon.notify("正在完成当前备份后退出…", "time")
        except Exception:
            pass
        threading.Thread(target=self._shutdown, args=(icon,), daemon=True).start()

    def _shutdown(self, icon) -> None:
        """后台执行 stop + icon.stop，让 icon.run() 返回。

        stop() 内部仍按 300s 等 inflight 归零；start() 的 finally 会再调一次
        stop()（幂等）并 join 轮询线程，两处等待共享同一个 _idle_event，
        等价于只等一次，不会叠加 600s。
        """
        try:
            self.stop()
        finally:
            try:
                icon.stop()
            except Exception as e:
                log.debug(f"icon.stop: {e}")

    def start(self) -> None:
        """启动托盘监控（阻塞直到用户退出）。"""
        if self._thread is not None and self._thread.is_alive():
            log.warning("Watcher 已在运行，忽略重复 start()")
            return

        if not self._config.collections:
            log.error("未发现任何集合。请检查 smtk config 的 program / knos 设置。")
            return

        self._stop_event = threading.Event()
        self._idle_event = threading.Event()
        self._idle_event.set()
        self._inflight = 0
        self._holder = {}
        # 每次 start 都默认开始监听
        self._pause_event.clear()

        menu = pystray.Menu(
            pystray.MenuItem("压缩历史", self._on_compact),
            pystray.Menu.SEPARATOR,
            pystray.MenuItem("打开配置目录", self._on_open_dir),
            pystray.MenuItem("打开日志", self._on_open_log),
            pystray.Menu.SEPARATOR,
            pystray.MenuItem("重置工作区到 HEAD", self._make_reset_menu("HEAD")),
            pystray.MenuItem("重置工作区到上一次提交", self._make_reset_menu("HEAD^")),
            pystray.Menu.SEPARATOR,
            pystray.MenuItem(
                "暂停监听",
                self._on_toggle_pause,
                checked=lambda item: self._pause_event.is_set(),
            ),
            pystray.MenuItem("退出", self._on_quit),
        )
        icon = pystray.Icon(
            "smtime",
            _make_tray_image(COLORS["waiting"]),
            TITLES["waiting"],
            menu,
        )
        self._holder["icon"] = icon
        self._thread = threading.Thread(target=self._poll_loop, daemon=True)
        self._thread.start()
        try:
            icon.run()
        except KeyboardInterrupt:
            log.info("interrupted")
        finally:
            self.stop()
            if self._thread is not None:
                self._thread.join(timeout=10)

    def stop(self) -> None:
        """停止监控。

        等待 inflight 操作归零（最多 300 秒），避免在 Git 操作中途退出。
        从未 start() 时直接返回，不阻塞。
        """
        # 修复：_stop_event 为 None 说明从未 start()，无事可停。
        # 此时 _idle_event 已在 __init__ 中 set，wait() 会立即返回，
        # 但显式早退更清晰，也防御 _idle_event 意外被 clear 的情况。
        if self._stop_event is None:
            return
        self._stop_event.set()
        if not self._idle_event.wait(timeout=300):
            log.warning("stop: 等待 inflight 超时，可能有 git 操作未完成")


# ============================================================================
# SuperMemoBackup - 高级 API 入口（顶层编排器）
# ============================================================================


class SuperMemoBackup:
    """SuperMemo 集合冷备份管理器（顶层编排器）。

    使用示例：
        >>> from time_backup import SuperMemoBackup
        >>> sm = SuperMemoBackup.from_config()
        >>> sm.init_all()
        >>> result = sm.backup("Maths")
        >>> sm.restore("Maths", "refs/heads/archive")
        >>> sm.compact()
        >>> sm.watch()
    """

    def __init__(self, config: BackupConfig) -> None:
        self.config = config
        self._watcher: Watcher | None = None

    @classmethod
    def from_config(cls) -> SuperMemoBackup:
        """从配置文件加载并创建管理器实例。"""
        return cls(load_config())

    def get_collection(self, name: str) -> Collection:
        """按名称查找集合。"""
        return self.config.get_collection(name)

    def collection(self, name: str) -> CollectionRepo:
        """获取指定集合的仓库操作对象。"""
        return CollectionRepo(self.get_collection(name))

    def init(self, name: str | None = None) -> Path:
        """初始化集合的 Git 仓库。"""
        if name is not None:
            return self.collection(name).init()
        if self.config.collections:
            return self.collection(self.config.collections[0].name).init()
        raise ValueError("没有可初始化的集合")

    def init_all(self) -> list[Path]:
        """初始化所有集合的 Git 仓库。"""
        return [self.collection(c.name).init() for c in self.config.collections]

    def backup(self, name: str, trigger: str = "manual") -> BackupResult:
        """冷备份指定集合（集合必须已关闭）。"""
        return self.collection(name).backup(trigger)

    def backup_all(self, trigger: str = "manual") -> list[BackupResult]:
        """冷备份所有集合（集合必须已关闭）。

        任一集合备份失败不中断其他集合的备份。
        """
        results: list[BackupResult] = []
        for c in self.config.collections:
            try:
                results.append(self.collection(c.name).backup(trigger))
            except Exception as e:
                log.error(f"{c.name}: backup failed: {e}")
                results.append(BackupResult(commit=None, skipped=False))
        return results

    def restore(self, name: str, target: str) -> RestoreResult:
        """冷恢复指定集合（集合必须已关闭）。"""
        return self.collection(name).restore(target)

    def reset_workspace(self, name: str, target: str = "HEAD") -> str:
        """重置指定集合的工作区到 target（集合必须已关闭）。

        成功：工作区完全等于目标 commit。所有不在目标 commit 中的文件
        被删除：tracked 被覆盖、untracked 被删除、ignored 文件（如
        temp/、reports/、html/）也被删除。外部 .kno = 目标 commit 版本。
        不成功：完全恢复操作前状态（refs、tracked、untracked、ignored、
        外部 .kno 全部恢复）；原 staged/unstaged 区分丢失，文件内容一致。

        Raises:
            NoTargetCommit: target 无法解析
            RuntimeError: 前置检查失败（工作区文件内容未动；
                C0 失败时 index 可能被 reset 到 HEAD）
            ResetFailed: 阶段 C1-C4 失败，文件内容已完全恢复
            ResetRollbackFailed: 阶段 C1-C4 失败且回滚不完整，
                snapshot ref 保留供手动恢复
        """
        return self.collection(name).reset_workspace(target)

    def compact(self, name: str | None = None) -> CompactResult | list[CompactResult]:
        """压缩集合历史。

        name 不为 None 时返回 CompactResult；
        name 为 None（批量模式）时返回每个集合的 CompactResult 列表。
        批量模式下单个集合失败不中断其他集合，失败集合的
        CompactResult.folded=False，message 以 "failed:" 开头。
        """
        if name is not None:
            return self.collection(name).compact()
        results: list[CompactResult] = []
        for c in self.config.collections:
            try:
                result = self.collection(c.name).compact()
                log.info(f"{c.name}: compact -> {result.message}")
                results.append(result)
            except Exception as e:
                log.error(f"{c.name}: compact failed: {e}")
                results.append(CompactResult(folded=False, message=f"failed: {e}"))
        return results

    def snapshots(self, name: str) -> SnapshotData | None:
        """获取指定集合的快照信息。"""
        return self.collection(name).snapshots()

    def list_snapshots(self, name: str) -> None:
        """打印指定集合的快照信息。"""
        self.collection(name).list_snapshots()

    def initialized_collections(self) -> list[Collection]:
        """返回已初始化 Git 仓库的集合列表。"""
        return [
            c for c in self.config.collections if CollectionRepo(c).is_initialized()
        ]

    def forget(self, name: str) -> bool:
        """让集合遗忘 Git 历史：删除 .git 目录。"""
        return self.collection(name).forget()

    def watch(self) -> None:
        """启动托盘监控（阻塞直到用户退出）。"""
        if self._watcher is not None:
            log.warning("SuperMemoBackup.watch() 已在运行")
            return
        self._watcher = Watcher(self.config)
        try:
            self._watcher.start()
        finally:
            self._watcher = None


# ============================================================================
# 模块导出（__all__）
# ============================================================================

__all__ = [
    "BackupConfig",
    "BackupResult",
    # 类型
    "Collection",
    "CollectionRepo",
    "CompactResult",
    "FileLock",
    # 异常
    "GitError",
    "NoTargetCommit",
    "ResetFailed",
    "ResetRollbackFailed",
    "RestoreResult",
    "SnapshotData",
    # 高级 API
    "SuperMemoBackup",
    "Watcher",
    # 配置
    "setup_logging",
]
