#!/usr/bin/env python3
"""time - SuperMemo 集合冷备份工具（类 API + watchdog + dry-run + safety）

主要 API（推荐）：
    from time_backup import SuperMemoBackup, CollectionRepo, Watcher, FileLock

    # 类式 API（推荐）
    sm = SuperMemoBackup.from_config()
    repo = sm.collection("Maths")
    repo.init()
    result = repo.backup()
    plan = repo.compact(dry_run=True)  # 预览压缩计划
    repo.restore("archive")
    sm.watch()

    # 直接类式调用
    from time_backup import CollectionRepo, Collection
    coll = Collection(name="Maths", path="D:/SuperMemo/systems/Maths")
    repo = CollectionRepo(coll)
    repo.backup()
    repo.compact(dry_run=True)

    # 跨进程锁
    with FileLock(repo.repo_path / ".git" / "backup.lock"):
        repo.backup()

    # Watcher（event-driven，基于 watchdog）
    from time_backup import Watcher, load_config
    cfg = load_config()
    watcher = Watcher(cfg)
    watcher.start()

配置复用 ~/.config/supermemo_toolkit/conf.json：
    program              SM 根目录
    knos                 离散集合列表
    backup_min_active    激活不足此秒数整体跳过（默认 180）

.kno 位置：集合目录的父目录下，与集合目录同名。
  systems/Maths/        ← 集合目录 = Git 仓库
  systems/Maths.kno     ← SuperMemo 实际锁文件（仓库外）
工作区内的 systems/Maths/Maths.kno 是 Git 跟踪的备份副本，SuperMemo 不读它。

策略：完全冷备份。集合激活期间不写 Git，退出后一次性快照。
"""

from __future__ import annotations

import ctypes
import hashlib
import json
import logging
import os
import shutil
import subprocess
import sys
import threading
import time as _time
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from pathlib import Path
from typing import NamedTuple

import pystray
from PIL import Image, ImageDraw
from typing_extensions import Self
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer

log = logging.getLogger("time")
BASE_DIR = Path(__file__).resolve().parent
LOG_FILE = BASE_DIR / "time.log"

GIT_LOCK = threading.RLock()
DEFAULT_MIN_ACTIVE = 180
QUIET_SECONDS = 2.0  # watchdog 防抖静默窗口


# ============================================================================
# 类型定义（公共 API 类型，调用方可直接引用）
# ============================================================================

# Snapshot = (tree_hash, kind, period)
#   kind  ∈ {"day", "month", "quarter", "year"}
#   period 格式取决于 kind：
#     "day"    → "2024-09-15"
#     "month"  → "2024-09"
#     "quarter"→ "2024-Q3"
#     "year"   → "2024"
Snapshot = tuple[str, str, str]


@dataclass(frozen=True)
class Collection:
    """SuperMemo 集合描述。

    Attributes:
        name:     集合名称（也是 Git 仓库名）
        path:     集合目录的绝对路径（即 Git 工作区根）
        kno:      可选。覆盖默认的 .kno 文件路径；不设置时自动计算为 <path.parent>/<name>.kno
    """

    name: str
    path: str
    kno: str | None = None

    def repo_path(self) -> Path:
        """Git 仓库工作区路径。"""
        return Path(self.path)

    def kno_path(self) -> Path:
        """SuperMemo 实际使用的 .kno 文件路径（在仓库外部）。"""
        if self.kno:
            return Path(self.kno)
        p = Path(self.path)
        return p.parent / f"{p.name}.kno"

    def kno_store_path(self) -> Path:
        """仓库内备份副本路径：<repo_root>/<name>.kno"""
        return Path(self.path) / f"{self.name}.kno"


@dataclass(frozen=True)
class BackupConfig:
    """冷备份工具配置。

    Attributes:
        sm_location:        SuperMemo 安装根目录
        collections:        发现的集合列表
        min_active_seconds: 激活必须持续超过此秒数才触发备份（默认 180）
    """

    sm_location: str
    collections: list[Collection]
    min_active_seconds: int

    def get_collection(self, name: str) -> Collection:
        """按名称查找集合。"""
        for c in self.collections:
            if c.name == name:
                return c
        raise KeyError(f"collection not found: {name}")


class BackupResult(NamedTuple):
    """backup_collection 的返回值。

    Attributes:
        commit:  提交 hash（8 字符短哈希）
        branch:  分支名（如 "hot-20240915"），跳过时为空
        locked:  True 表示 .kno 文件被锁定（备份可能使用旧数据）
        skipped: True 表示无变更已跳过
    """

    commit: str
    branch: str | None = None
    locked: bool = False
    skipped: bool = False


@dataclass
class SnapshotData:
    """get_snapshots 的返回值。"""

    name: str
    kno: str
    store: str
    archive: list[str]
    hot: dict[str, list[str]]
    safety_refs: list[str]


# ============================================================================
# 新增类型：CompactResult / RestoreResult
# ============================================================================


@dataclass(frozen=True)
class CompactResult:
    """compact 的返回值，方便 dry_run 后做二次判断。

    Attributes:
        dry_run:         True 表示仅打印计划未执行
        deleted_refs:    将被/已被删除的 ref 列表
        kept_refs:       将被/已被保留的 ref 列表
        day_folds:       将被/已被折叠的 hot 分支列表
        coarse_fold:     是否会发生/已发生月/季/年粗粒度折叠
        deleted_commits: 将被/已被折叠的 hot 分支数（非提交数，仅供参考）
        message:         人类可读的描述信息
    """

    dry_run: bool
    deleted_refs: list[str]
    kept_refs: list[str]
    day_folds: list[str]
    coarse_fold: bool
    deleted_commits: int
    message: str


@dataclass(frozen=True)
class RestoreResult:
    """restore 的返回值。

    Attributes:
        safety_ref:  恢复前创建的安全提交 ref（格式 refs/backup/safety/workdir-<ts>），失败时为空
        target:      恢复目标
        restored:    是否成功恢复
    """

    safety_ref: str | None
    target: str
    restored: bool


# ============================================================================
# 异常类型
# ============================================================================


class GitError(RuntimeError):
    """Git 命令执行失败。"""


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
        """用锁文件路径创建 FileLock。

        Args:
            lock_path: 锁文件路径（不要求文件已存在，会自动创建）
            timeout:   最大等待秒数，超时抛 TimeoutError
        """
        self._lock_path = Path(lock_path)
        self._timeout = timeout
        self._fd = None

    def __enter__(self) -> Self:
        self.acquire()
        return self

    def __exit__(self, *exc_info: object) -> None:
        self.release()

    def acquire(self) -> None:
        """获取锁，阻塞直到拿到或超时。"""
        deadline = _time.time() + self._timeout
        # 确保父目录存在
        self._lock_path.parent.mkdir(parents=True, exist_ok=True)
        # 只 open 一次并复用 fd，避免每次重试都泄漏旧句柄
        self._fd = open(self._lock_path, "a+b")  # noqa: SIM115
        self._fd.seek(0)  # P3#5: 确保锁的是 [0, 1)，不依赖文件长度
        try:
            while True:
                try:
                    if sys.platform == "win32":
                        import msvcrt

                        msvcrt.locking(self._fd.fileno(), msvcrt.LK_NBLCK, 1)
                    else:
                        import fcntl

                        fcntl.flock(self._fd.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
                    return
                except OSError:
                    if _time.time() >= deadline:
                        raise TimeoutError(
                            f"无法获取锁 {self._lock_path}（超时 {self._timeout}s），"
                            f"可能有其他进程正在操作同一仓库"
                        )
                    _time.sleep(0.5)
        except Exception:
            # 如果锁定失败（非超时），确保关闭 fd
            self._fd.close()
            self._fd = None
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

                fd.seek(0)  # P3#5: 与 acquire 的 seek(0) 对称
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
    handlers = [logging.FileHandler(LOG_FILE, encoding="utf-8")]
    if sys.stderr is not None and hasattr(sys.stderr, "isatty") and sys.stderr.isatty():
        handlers.append(logging.StreamHandler(sys.stderr))
    logging.basicConfig(
        level=logging.DEBUG if verbose else logging.INFO,
        format="%(asctime)s %(levelname)s %(message)s",
        handlers=handlers,
    )


# ============================================================================
# smtk 配置
# ============================================================================


def _config_dir() -> Path:
    return Path(os.path.expanduser("~")) / ".config" / "supermemo_toolkit"


def _read_smtk_conf() -> dict:
    p = _config_dir() / "conf.json"
    if not p.exists():
        return {}
    with open(p, encoding="utf-8") as f:
        return json.load(f)


def discover_collections(sm_location: str, smtk: dict) -> list[Collection]:
    """从 smtk 配置和 SM 文件系统自动发现集合。

    返回 Collection 列表，每个集合包含 name、path 和可选的 kno 覆盖路径。
    如果同一集合名出现多次，后出现的覆盖先出现的。
    """
    # 用 dict 按 name 去重，后出现的覆盖先出现的
    by_name: dict[str, Collection] = {}
    systems = Path(sm_location) / "systems"
    if systems.is_dir():
        for p in sorted(systems.iterdir()):
            if p.is_dir() and p.name != ".git":
                by_name[p.name] = Collection(name=p.name, path=str(p.resolve()))

    for item in smtk.get("knos") or []:
        for name, val in item.items():
            if isinstance(val, dict):
                by_name[name] = Collection(
                    name=name,
                    path=str(Path(val["path"]).resolve()),
                    kno=val.get("kno"),
                )
            else:
                by_name[name] = Collection(name=name, path=str(Path(val).resolve()))
    return list(by_name.values())


def load_config() -> BackupConfig:
    """加载配置并自动发现集合。

    返回 BackupConfig 对象，包含 sm_location、collections 列表和备份配置。
    """
    smtk = _read_smtk_conf()
    sm_location = (smtk.get("program") or "").strip()
    if not sm_location or sm_location.lower() == "null":
        raise SystemExit(
            "请先设置 smtk 配置：smtk config set program <SuperMemo 根目录>"
        )
    # P1 修复: 用 `is not None` 代替 `or`，避免 0 被吞掉（0 是有效值，表示禁用短激活跳过）
    min_active_raw = smtk.get("backup_min_active")
    try:
        min_active = (
            int(min_active_raw) if min_active_raw is not None else DEFAULT_MIN_ACTIVE
        )
    except (TypeError, ValueError):
        min_active = DEFAULT_MIN_ACTIVE

    return BackupConfig(
        sm_location=sm_location,
        collections=discover_collections(sm_location, smtk),
        min_active_seconds=max(min_active, 0),
    )


# ============================================================================
# file lock (进程内)
# ============================================================================

_K32 = None


def _kernel32():
    """懒初始化 kernel32 DLL 绑定。"""
    global _K32
    if _K32 is None:
        _K32 = ctypes.WinDLL("kernel32", use_last_error=True)
        _K32.CreateFileW.restype = ctypes.c_void_p
        _K32.CreateFileW.argtypes = [
            ctypes.c_wchar_p,
            ctypes.c_uint32,
            ctypes.c_uint32,
            ctypes.c_void_p,
            ctypes.c_uint32,
            ctypes.c_uint32,
            ctypes.c_void_p,
        ]
        _K32.CloseHandle.restype = ctypes.c_bool
        _K32.CloseHandle.argtypes = [ctypes.c_void_p]
    return _K32


def is_file_locked(path: Path) -> bool:
    """检测文件是否被独占锁定（SuperMemo 打开集合时会锁定 .kno）。"""
    path = Path(path)
    if not path.exists():
        return False
    if sys.platform == "win32":
        k32 = _kernel32()
        # Windows API 常量
        GENERIC_READ = 0x80000000
        FILE_SHARE_READ = 0x1
        FILE_SHARE_WRITE = 0x2
        OPEN_EXISTING = 3
        h = k32.CreateFileW(
            str(path),
            GENERIC_READ,
            FILE_SHARE_READ | FILE_SHARE_WRITE,
            None,
            OPEN_EXISTING,
            0,
            None,
        )
        INVALID_HANDLE_VALUE = ctypes.c_void_p(-1).value
        # c_void_p restype 返回 int，比较时用 .value 取整数值；
        # 某些 ctypes 版本可能返回 -1，所以同时判断
        if h in (None, 0, -1, INVALID_HANDLE_VALUE):
            return True
        k32.CloseHandle(ctypes.c_void_p(h))
        return False
    import fcntl

    try:
        with open(path, "rb") as f:
            fcntl.flock(f, fcntl.LOCK_EX | fcntl.LOCK_NB)
            fcntl.flock(f, fcntl.LOCK_UN)
        return False
    except OSError:
        return True


def is_collection_active(coll: Collection) -> bool:
    """集合是否正在激活（.kno 文件存在且被锁定）。"""
    return coll.kno_path().exists() and is_file_locked(coll.kno_path())


def activation_start_from_stats(coll: Collection) -> float | None:
    """读取 stats/time.dat 的最后修改时间。

    注意：此值表示 stats 文件的最后写入时间戳，并非集合的"激活起始时间"。
    如果 SuperMemo 在激活期间持续刷新该文件，mtime 仅反映最近一次写入时间。
    如果文件不存在则返回 None。
    """
    sf = Path(coll.path) / "stats" / "time.dat"
    if sf.exists():
        return sf.stat().st_mtime
    return None


# ============================================================================
# git helper
# ============================================================================


def _git_env() -> dict:
    """构建 git 命令所需的环境变量（作者/提交者信息）。"""
    env = os.environ.copy()
    env.setdefault("GIT_AUTHOR_NAME", "time-backup")
    env.setdefault("GIT_AUTHOR_EMAIL", "time-backup@local")
    env.setdefault("GIT_COMMITTER_NAME", "time-backup")
    env.setdefault("GIT_COMMITTER_EMAIL", "time-backup@local")
    return env


def git(repo: Path, *args, check: bool = True, text: bool = True):
    """执行 git 命令。"""
    cmd = ["git", "-C", str(repo)] + list(args)
    r = subprocess.run(
        cmd,
        check=False,
        capture_output=True,
        text=text,
        encoding="utf-8" if text else None,
        errors="replace" if text else None,
        env=_git_env(),
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


def rev_parse(repo: Path, ref: str) -> str:
    """解析 ref 为 commit hash。"""
    return git_out(repo, "rev-parse", ref)


def commit_tree(repo: Path, tree: str, parent: str | None, msg: str) -> str:
    """创建一个新的 tree commit。"""
    if parent:
        return git_out(repo, "commit-tree", tree, "-p", parent, "-m", msg)
    return git_out(repo, "commit-tree", tree, "-m", msg)


# ============================================================================
# .kno 校验与恢复
# ============================================================================


def _sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _commit_kno_bytes(repo: Path, commit: str, kno_rel: str) -> bytes | None:
    """从指定 commit 中读取 .kno 文件的 blob 数据。"""
    r = git(repo, "cat-file", "-p", f"{commit}:{kno_rel}", check=False, text=False)
    if r.returncode != 0:
        return None
    return r.stdout


def verify_kno_against_commit(
    repo: Path,
    commit: str,
    kno_src: Path,
    kno_rel: str,
    name: str,
    must_exist: bool = False,
):
    """验证磁盘上的 .kno 文件与 git commit 中的内容一致。"""
    data = _commit_kno_bytes(repo, commit, kno_rel)
    if data is None:
        if must_exist:
            raise RuntimeError(f"{name}: commit {commit[:8]} 中无 {kno_rel}")
        return
    if not kno_src.exists():
        raise RuntimeError(f"{name}: 磁盘 .kno 不存在，无法比对")
    actual = _sha256_bytes(kno_src.read_bytes())
    committed = _sha256_bytes(data)
    if actual != committed:
        raise RuntimeError(f"{name}: .kno 与 commit {commit[:8]} 不一致")


def _restore_kno_from_store(
    repo: Path, commit: str, kno_src: Path, kno_rel: str, name: str
) -> bool:
    """从 commit 里的 <name>.kno 原子写回外部 .kno 文件。"""
    data = _commit_kno_bytes(repo, commit, kno_rel)
    if data is None:
        log.warning(f"{name}: commit {commit[:8]} 无 {kno_rel}，跳过 .kno 恢复")
        return False

    tmp = kno_src.with_suffix(kno_src.suffix + ".restore-tmp")
    tmp.write_bytes(data)
    try:
        os.replace(tmp, kno_src)
    except OSError as e:
        log.error(f"{name}: .kno 写回失败 (os.replace): {e}")
        # 清理临时文件
        try:
            tmp.unlink(missing_ok=True)
        except OSError:
            pass
        raise RuntimeError(f"{name}: .kno 恢复失败，文件可能被 SuperMemo 占用") from e

    if _sha256_bytes(data) != _sha256_bytes(kno_src.read_bytes()):
        raise RuntimeError(f"{name}: .kno 恢复后哈希不一致")
    log.info(f"{name}: .kno 已写回 {kno_src}（{len(data)} 字节）")
    return True


# ============================================================================
# CollectionRepo - 单个集合的仓库操作封装
# ============================================================================


class CollectionRepo:
    """封装单个 SuperMemo 集合的 Git 仓库操作。

    这是工具的核心操作类。每个集合对应一个 CollectionRepo 实例，
    提供 init/backup/restore/compact/snapshots 等操作。

    使用示例：
        >>> from time_backup import CollectionRepo, Collection
        >>> coll = Collection(name="Maths", path="D:/SuperMemo/systems/Maths")
        >>> repo = CollectionRepo(coll)
        >>> repo.init()
        >>> result = repo.backup()
        >>> plan = repo.compact(dry_run=True)  # 预览压缩计划
        >>> repo.restore("archive")
        >>> repo.compact()
    """

    def __init__(self, coll: Collection) -> None:
        """用 Collection 对象创建仓库操作实例。

        Args:
            coll: Collection 对象，描述要操作的集合
        """
        self._coll = coll

    @property
    def collection(self) -> Collection:
        """底层 Collection 对象。"""
        return self._coll

    @property
    def name(self) -> str:
        """集合名称。"""
        return self._coll.name

    @property
    def repo_path(self) -> Path:
        """Git 仓库工作区路径。"""
        return self._coll.repo_path()

    @property
    def kno_path(self) -> Path:
        """SuperMemo 实际使用的 .kno 文件路径（在仓库外部）。"""
        return self._coll.kno_path()

    @property
    def kno_store_path(self) -> Path:
        """仓库内备份副本路径。"""
        return self._coll.kno_store_path()

    def init(self) -> Path:
        """初始化集合的 Git 仓库（如果尚未初始化）。

        Returns:
            仓库路径
        """
        repo = self.repo_path
        repo.mkdir(parents=True, exist_ok=True)
        if not (repo / ".git").exists():
            git(repo, "init", "-q")
            gi = repo / ".gitignore"
            if not gi.exists():
                gi.write_text("*.tmp\n~$*\n*.bak\n*.TMP\ntemp/\n", encoding="utf-8")
            log.info(f"initialized repo: {repo}")
        return repo

    def backup(
        self, trigger: str = "manual", require_inactive: bool = True
    ) -> BackupResult:
        """冷备份：集合必须已关闭。外部 .kno 复制进工作区根，然后提交。

        Args:
            trigger:           触发来源（"manual"/"tray"/"shutdown"/"debug"）
            require_inactive:  True 时如果集合正在激活则直接抛异常

        Returns:
            BackupResult 对象
        """
        with GIT_LOCK:
            repo = self.init()
            kno_src = self.kno_path
            kno_store = self.kno_store_path
            kno_rel = f"{self.name}.kno"

            # 检查集合是否正在激活（合并为一次调用，避免竞态）
            locked = is_file_locked(kno_src)
            if require_inactive and locked:
                raise RuntimeError(f"{self.name}: 集合正在激活，拒绝运行时备份")

            # 尝试复制 .kno（如果未被锁定）
            if not locked and kno_src.exists():
                try:
                    shutil.copy2(kno_src, kno_store)
                except OSError as e:
                    log.warning(f"{self.name}: 复制 .kno 失败，当作锁定处理: {e}")
                    locked = True

            # 检查 .kno 是否存在
            if not kno_src.exists():
                log.warning(f"{self.name}: .kno 文件不存在，备份将不包含集合数据")

            # 提交工作区快照
            git(repo, "add", "-A")
            tree = git_out(repo, "write-tree")
            today = datetime.now().strftime("%Y%m%d")
            hot = f"hot-{today}"

            # 确定父提交
            parent = None
            if ref_exists(repo, f"refs/heads/{hot}"):
                parent = rev_parse(repo, f"refs/heads/{hot}")
            elif ref_exists(repo, "refs/heads/archive"):
                parent = rev_parse(repo, "refs/heads/archive")

            # 检查是否有实际变更
            if parent:
                parent_tree = rev_parse(repo, f"{parent}^{{tree}}")
                if parent_tree == tree:
                    log.debug(f"{self.name}: no change, skip")
                    # 确保 hot 分支存在再设置 HEAD（parent 可能来自 archive 而非 hot）
                    if not ref_exists(repo, f"refs/heads/{hot}"):
                        git(repo, "update-ref", f"refs/heads/{hot}", parent)
                    git(repo, "symbolic-ref", "HEAD", f"refs/heads/{hot}")
                    return BackupResult(commit=parent, skipped=True)

            # 创建提交
            msg = f"hot: {datetime.now().isoformat(timespec='seconds')} [{trigger}]"
            commit = commit_tree(repo, tree, parent, msg)

            # 验证 .kno 一致性（仅在未锁定时）
            # P2 修复: 将 verify_kno_against_commit 的 RuntimeError 包装为 GitError，
            # 避免被 _do_backup 的 except RuntimeError 误捕获为"集合激活"
            # P3#2 修复: GitError 先 raise 保留原始错误，避免二次包装
            if not locked and kno_src.exists():
                try:
                    verify_kno_against_commit(repo, commit, kno_src, kno_rel, self.name)
                except GitError:
                    raise  # git 命令失败，保留原始错误
                except RuntimeError as e:
                    raise GitError(f"{self.name}: .kno 校验失败: {e}") from e

            # 更新分支引用
            git(repo, "update-ref", f"refs/heads/{hot}", commit)
            git(repo, "symbolic-ref", "HEAD", f"refs/heads/{hot}")

            log.info(
                f"{self.name}: backup {commit[:8]} (locked={locked}, trigger={trigger})"
            )
            return BackupResult(commit=commit, branch=hot, locked=locked)

    def restore(
        self, target: str, paths: list[str] | None = None, safety: bool = True
    ) -> RestoreResult:
        """冷恢复：集合必须已关闭。

        恢复前会自动在 refs/backup/safety/ 下创建一个安全提交，
        记录当前工作区状态，以便恢复出错时回退。

        Args:
            target: 恢复目标（分支名/tag/commit hash）
            paths:  可选。指定恢复的文件路径列表（git tree path）。
                    None 表示全量恢复；指定路径列表表示部分恢复。
            safety: 是否在恢复前创建安全快照（默认 True）

        Returns:
            RestoreResult 对象
        """
        with GIT_LOCK:
            repo = self.repo_path
            kno_src = self.kno_path
            kno_rel = f"{self.name}.kno"

            # 检查集合是否正在激活
            if kno_src.exists() and is_file_locked(kno_src):
                raise RuntimeError(f"{self.name}: 集合正在激活，请先关闭 SuperMemo")

            commit = rev_parse(repo, target)
            today = datetime.now().strftime("%Y%m%d")
            hot = f"hot-{today}"

            # 创建安全快照（备份当前 hot 分支状态）
            safety_ref: str | None = None
            if safety:
                safety_ref = self._create_safety_snapshot(repo, hot)

            if paths:
                self._restore_with_paths(
                    repo, commit, kno_src, kno_rel, self.name, paths, hot
                )
                return RestoreResult(
                    safety_ref=safety_ref, target=target, restored=True
                )

            # 全量恢复路径
            git(repo, "read-tree", "-u", "--reset", commit)
            git(repo, "symbolic-ref", "HEAD", f"refs/heads/{hot}")
            git(repo, "update-ref", f"refs/heads/{hot}", commit)

            _restore_kno_from_store(repo, commit, kno_src, kno_rel, self.name)

            log.info(f"{self.name}: restored to {commit[:8]}")
            return RestoreResult(safety_ref=safety_ref, target=target, restored=True)

    def _create_safety_snapshot(self, repo: Path, hot: str) -> str | None:
        """在 refs/backup/safety/ 下创建当前工作区的安全提交。

        如果创建失败只打 warning 不中断恢复。
        """
        try:
            # 先暂存当前工作区的所有文件
            git(repo, "add", "-A")
            tree = git_out(repo, "write-tree")
            # 获取当前 hot 分支的父提交作为新提交的父级
            parent = None
            if ref_exists(repo, f"refs/heads/{hot}"):
                parent = rev_parse(repo, f"refs/heads/{hot}")
            ts = datetime.now().strftime("%Y%m%d-%H%M%S")
            safety_ref = f"refs/backup/safety/workdir-{ts}"
            safety_commit = commit_tree(
                repo, tree, parent, f"safety: pre-restore snapshot {ts}"
            )
            git(repo, "update-ref", safety_ref, safety_commit)
            log.info(f"{self.name}: safety snapshot created -> {safety_ref}")
            return safety_ref
        except Exception as e:
            log.warning(f"{self.name}: 无法创建 safety snapshot: {e}")
            return None

    def compact(
        self, today: date | None = None, dry_run: bool = False
    ) -> CompactResult:
        """压缩仓库历史：天折叠 + 月/季/年粗粒度折叠 + gc。

        Args:
            today:   可选。用于测试的日期（默认 date.today()）
            dry_run: 如果为 True，只打印计划不执行实际操作。

        Returns:
            CompactResult 对象
        """
        with GIT_LOCK:
            repo = self.repo_path
            if not (repo / ".git").exists():
                return CompactResult(
                    dry_run=dry_run,
                    deleted_refs=[],
                    kept_refs=[],
                    day_folds=[],
                    coarse_fold=False,
                    deleted_commits=0,
                    message="no repo",
                )

            today = today or date.today()

            # 收集将被折叠的 hot 分支和将被删除的 ref
            hot_branches_to_fold: list[str] = []
            all_hot_refs: list[str] = []

            for b in git_out(repo, "branch", "--list", "hot-*").splitlines():
                b = b.strip().lstrip("* ").strip()
                if not b.startswith("hot-"):
                    continue
                all_hot_refs.append(b)
                try:
                    hd = datetime.strptime(b[4:], "%Y%m%d").date()
                except ValueError:
                    continue
                if hd < today:
                    hot_branches_to_fold.append(b)

            # 读取 archive 历史来估算粗粒度折叠
            coarse_fold = False
            if ref_exists(repo, "refs/heads/archive"):
                snaps = _read_archive_history(repo)
                if snaps:
                    days, months, quarters, years = _categorize_snaps(snaps)
                    cm = today.strftime("%Y-%m")
                    cq = _month_to_quarter(cm)
                    cy = str(today.year)
                    coarse_fold |= _fold_days_to_months(days, months, cm)
                    coarse_fold |= _fold_months_to_quarters(months, quarters, cq)
                    coarse_fold |= _fold_quarters_to_years(quarters, years, cy)

            # dry_run 模式：直接返回计划
            if dry_run:
                kept = [r for r in all_hot_refs if r not in hot_branches_to_fold]
                deleted = list(hot_branches_to_fold)
                msg_parts = []
                msg_parts.append(f"将删除 {len(deleted)} 个 hot 分支")
                if deleted:
                    msg_parts.append(f"待删: {', '.join(deleted)}")
                msg_parts.append(f"保留 {len(kept)} 个 hot 分支")
                if coarse_fold:
                    msg_parts.append("将执行月/季/年粗粒度折叠")
                msg_parts.append("（未实际执行）")
                return CompactResult(
                    dry_run=True,
                    deleted_refs=deleted,
                    kept_refs=kept,
                    day_folds=hot_branches_to_fold,
                    coarse_fold=coarse_fold,
                    deleted_commits=len(hot_branches_to_fold),
                    message="; ".join(msg_parts),
                )

            # 实际执行天折叠
            for b in hot_branches_to_fold:
                try:
                    hd = datetime.strptime(b[4:], "%Y%m%d").date()
                    fold_hot_to_day(repo, b, hd)
                except Exception as e:
                    log.warning(f"{self.name}: fold {b} failed: {e}")

            # 月/季/年粗粒度折叠
            coarse_done = False
            if ref_exists(repo, "refs/heads/archive"):
                coarse_done = normalize_archive(repo, today)

            # 清理安全标签
            _cleanup_safety_refs(repo)

            # 只有粗粒度折叠才 gc
            if coarse_done:
                git(repo, "reflog", "expire", "--expire=now", "--all", check=False)
                git(repo, "gc", "--prune=now", "--quiet", check=False)
                log.info(f"{self.name}: compacted (月/季/年折叠 + gc)")
            else:
                log.info(f"{self.name}: compacted (仅天折叠，跳过 gc)")

            # 构建返回结果
            remaining_hots = [
                b.strip().lstrip("* ").strip()
                for b in git_out(repo, "branch", "--list", "hot-*").splitlines()
                if b.strip().lstrip("* ").strip().startswith("hot-")
            ]
            return CompactResult(
                dry_run=False,
                deleted_refs=hot_branches_to_fold,
                kept_refs=remaining_hots,
                day_folds=hot_branches_to_fold,
                coarse_fold=coarse_done or coarse_fold,
                deleted_commits=len(hot_branches_to_fold),
                message=f"compacted: {len(hot_branches_to_fold)} hot folded, coarse={coarse_done}",
            )

    def snapshots(self) -> SnapshotData | None:
        """返回集合快照数据；仓库不存在返回 None。

        Returns:
            SnapshotData 对象
        """
        repo = self.repo_path
        if not (repo / ".git").exists():
            return None

        data = SnapshotData(
            name=self.name,
            kno=str(self.kno_path),
            store=f"{self.name}.kno",
            archive=[],
            hot={},
            safety_refs=[],
        )

        if ref_exists(repo, "refs/heads/archive"):
            out = git_out(repo, "log", "--format=%h %s", "refs/heads/archive")
            data.archive = out.splitlines() if out else []

        for b in git_out(repo, "branch", "--list", "hot-*").splitlines():
            b = b.strip().lstrip("* ").strip()
            if b.startswith("hot-"):
                out = git_out(repo, "log", "--format=%h %s", f"refs/heads/{b}")
                data.hot[b] = out.splitlines() if out else []

        # 列出 refs/backup/safety/ 下的安全快照 ref
        safety_out = git_out(
            repo, "for-each-ref", "--format=%(refname:short)", "refs/backup/safety/"
        )
        data.safety_refs = safety_out.splitlines() if safety_out else []
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
        for b, snap_lines in data.hot.items():
            print(f"\n[{b}]")
            for line in snap_lines:
                print(line)
        if data.safety_refs:
            print("\n[safety refs]")
            for t in data.safety_refs:
                print(t)

    def is_active(self) -> bool:
        """集合是否正在激活。"""
        return is_collection_active(self._coll)

    def activation_start(self) -> float | None:
        """读取 stats/time.dat 的修改时间作为集合激活起始时间。"""
        return activation_start_from_stats(self._coll)

    def _restore_with_paths(
        self,
        repo: Path,
        commit: str,
        kno_src: Path,
        kno_rel: str,
        name: str,
        paths: list[str],
        hot: str,
    ) -> None:
        """部分恢复：只恢复指定的文件路径。

        注意：部分恢复不移动 hot 分支指针，仅更新工作区文件。
        这是因为只恢复部分文件时，index 和工作区处于混合状态，
        移动分支指针会导致下一次 backup 把未恢复的旧文件重新写回。
        如需将部分恢复纳入版本历史，请手动创建 commit。
        """
        posix_paths = [Path(p).as_posix() for p in paths]

        # 逐个 checkout 指定文件（仅更新工作区和对应路径的 index 条目）
        for p in posix_paths:
            git(repo, "checkout", commit, "--", p)
        git(repo, "update-index", "--refresh", check=False)

        # 如果 .kno 在恢复路径中，需要从 store 原子写回
        if kno_rel in posix_paths:
            _restore_kno_from_store(repo, commit, kno_src, kno_rel, name)

        # 暂存恢复的文件（可选：如需纳入版本历史则取消注释下一行）
        # for p in posix_paths:
        #     git(repo, "add", "--", p)

        # 不移动 hot 分支指针，保持 HEAD 不变
        # 部分恢复后的混合状态不应被分支指针固化
        log.info(f"{name}: restored {paths} from {commit[:8]} (HEAD unchanged)")


# ============================================================================
# compact - 时间辅助函数
# ============================================================================


def _month_to_quarter(m: str) -> str:
    """将月份字符串 '2024-09' 转为季度字符串 '2024-Q3'。"""
    y, mo = map(int, m.split("-"))
    return f"{y}-Q{(mo - 1) // 3 + 1}"


def _last_day(y: int, m: int) -> int:
    """获取指定年月的最后一天日期。"""
    return (date(y + (m == 12), (m % 12) + 1, 1) - timedelta(days=1)).day


def _period_end(kind: str, p: str) -> date:
    """将 (kind, period) 解析为 date 对象，用于排序。"""
    if kind == "year":
        return date(int(p), 12, 31)
    if kind == "quarter":
        y, q = p.split("-Q")
        m = int(q) * 3
        return date(int(y), m, _last_day(int(y), m))
    if kind == "month":
        y, m = map(int, p.split("-"))
        return date(y, m, _last_day(y, m))
    if kind == "day":
        return datetime.strptime(p, "%Y-%m-%d").date()
    raise ValueError(kind)


def _pick_latest(items: list[tuple[str, str]]) -> tuple[str, str]:
    """从 (tree_hash, period) 列表中取 period 最大的那条。"""
    return max(items, key=lambda x: x[1])


# ============================================================================
# compact - 天级别折叠
# ============================================================================


def fold_hot_to_day(repo: Path, hot: str, d: date) -> str:
    """将 hot 分支的当天提交折叠为 archive 的一个 day 条目。"""
    tip = rev_parse(repo, f"refs/heads/{hot}")
    tree = rev_parse(repo, f"{tip}^{{tree}}")
    parent = (
        rev_parse(repo, "refs/heads/archive")
        if ref_exists(repo, "refs/heads/archive")
        else None
    )
    new = commit_tree(repo, tree, parent, f"day: {d.isoformat()}")
    git(repo, "update-ref", "refs/heads/archive", new)

    # 如果 HEAD 正好指向被删除的 hot 分支，切回 archive
    head_ref = git(repo, "symbolic-ref", "--quiet", "HEAD", check=False).stdout.strip()
    if head_ref == f"refs/heads/{hot}":
        git(repo, "symbolic-ref", "HEAD", "refs/heads/archive")
    git(repo, "branch", "-D", hot, check=False)
    log.info(f"fold {hot} -> archive@{new[:8]}")
    return new


# ============================================================================
# compact - 月/季/年粗粒度折叠
# ============================================================================


def _read_archive_history(repo: Path) -> list[Snapshot]:
    """从 archive 分支读取所有 commit，解析为 Snapshot 列表。"""
    snaps: list[Snapshot] = []
    cur = rev_parse(repo, "refs/heads/archive")
    while True:
        msg = git_out(repo, "log", "-1", "--format=%s", cur)
        tree = rev_parse(repo, f"{cur}^{{tree}}")
        kind, _, period = msg.partition(": ")
        if kind in ("day", "month", "quarter", "year"):
            snaps.append((tree, kind, period.strip()))
        else:
            log.warning(
                f"archive: 未知提交类型 '{kind}' (commit {cur[:8]}: {msg}), 跳过"
            )
        parent = git(repo, "rev-parse", f"{cur}^", check=False).stdout.strip()
        if not parent:
            break
        cur = parent
    snaps.reverse()
    return snaps


def _categorize_snaps(
    snaps: list[Snapshot],
) -> tuple[
    dict[str, list[tuple[str, str]]],  # days:    key=月份字符串 "2024-09"
    dict[str, list[tuple[str, str]]],  # months:  key=季度字符串 "2024-Q3"
    dict[str, list[tuple[str, str]]],  # quarters: key=年份字符串 "2024"
    dict[str, str],  # years:   key=年份字符串 "2024", value=tree
]:
    """将 Snapshot 列表按粒度分类到 days/months/quarters/years 四个字典中。

    返回值说明：
      days:    key=月份字符串 "2024-09",    value=[(tree, 完整日期 "2024-09-15"), ...]
      months:  key=季度字符串 "2024-Q3",    value=[(tree, 月份 "2024-09"), ...]
      quarters: key=年份字符串 "2024",      value=[(tree, 季度 "2024-Q3"), ...]
      years:   key=年份字符串 "2024",       value=tree
    """
    days: dict[str, list[tuple[str, str]]] = {}
    months: dict[str, list[tuple[str, str]]] = {}
    quarters: dict[str, list[tuple[str, str]]] = {}
    years: dict[str, str] = {}

    for t, k, p in snaps:
        if k == "day":
            days.setdefault(p[:7], []).append((t, p))
        elif k == "month":
            months.setdefault(_month_to_quarter(p), []).append((t, p))
        elif k == "quarter":
            quarters.setdefault(p[:4], []).append((t, p))
        elif k == "year":
            years[p] = t

    return days, months, quarters, years


def _fold_days_to_months(
    days: dict[str, list[tuple[str, str]]],
    months: dict[str, list[tuple[str, str]]],
    current_month: str,
) -> bool:
    """将已过月份的日级提交合并为月级条目，返回是否发生了折叠。"""
    coarse_fold = False
    for month_key, items in list(days.items()):
        if month_key < current_month:
            coarse_fold = True
            tree = _pick_latest(items)[0]
            months.setdefault(_month_to_quarter(month_key), []).append(
                (tree, month_key)
            )
    return coarse_fold


def _fold_months_to_quarters(
    months: dict[str, list[tuple[str, str]]],
    quarters: dict[str, list[tuple[str, str]]],
    current_quarter: str,
) -> bool:
    """将已过季度的月级条目合并为季度级条目，返回是否发生了折叠。"""
    coarse_fold = False
    for quarter_key, items in list(months.items()):
        if quarter_key < current_quarter:
            coarse_fold = True
            tree = _pick_latest(items)[0]
            year_from_quarter = quarter_key[:4]
            quarters.setdefault(year_from_quarter, []).append((tree, quarter_key))
    return coarse_fold


def _fold_quarters_to_years(
    quarters: dict[str, list[tuple[str, str]]],
    years: dict[str, str],
    current_year: str,
) -> bool:
    """将已过年份的季度条目合并为年度条目，返回是否发生了折叠。"""
    coarse_fold = False
    for year_key, items in list(quarters.items()):
        if year_key < current_year:
            coarse_fold = True
            years[year_key] = _pick_latest(items)[0]
    return coarse_fold


def _build_archive_entries(
    days: dict[str, list[tuple[str, str]]],
    months: dict[str, list[tuple[str, str]]],
    quarters: dict[str, list[tuple[str, str]]],
    years: dict[str, str],
    today: date,
) -> list[Snapshot]:
    """从分类后的数据构建最终的 archive 条目列表（按时间排序）。"""
    cm = today.strftime("%Y-%m")
    cq = _month_to_quarter(cm)
    cy = str(today.year)
    result: list[Snapshot] = []

    # 年度条目（所有年份）
    for y, t in years.items():
        result.append((t, "year", y))
    # 当前年度的季度条目（quarters 的 key 是年份字符串）
    for year_key, items in quarters.items():
        if year_key == cy:
            result.extend((t, "quarter", p) for t, p in items)
    # 当前季度的月度条目（months 的 key 是季度字符串）
    for quarter_key, items in months.items():
        if quarter_key == cq:
            result.extend((t, "month", p) for t, p in items)
    # 当月的日级条目
    for month_key, items in days.items():
        if month_key == cm:
            result.extend((t, "day", p) for t, p in items)

    result.sort(key=lambda x: _period_end(x[1], x[2]))
    return result


def _write_archive_refs(repo: Path, entries: list[Snapshot]) -> None:
    """将条目列表写为连续的 commit 并更新 archive 引用。"""
    parent = None
    for t, k, p in entries:
        parent = commit_tree(repo, t, parent, f"{k}: {p}")
    if parent:
        git(repo, "update-ref", "refs/heads/archive", parent)


def normalize_archive(repo: Path, today: date) -> bool:
    """执行月/季/年级别的粗粒度折叠，返回是否发生了折叠。

    折叠策略：
      day -> month（跨月）：把旧月份的日级提交合并为月级条目
      month -> quarter（跨季）：把旧季度的月级条目合并为季度级条目
      quarter -> year（跨年）：把旧年份的季度条目合并为年度条目
    """
    if not ref_exists(repo, "refs/heads/archive"):
        return False

    # 1. 读取 archive 历史
    snaps = _read_archive_history(repo)
    if not snaps:
        return False

    # 2. 按粒度分类
    days, months, quarters, years = _categorize_snaps(snaps)

    # 3. 自底向上折叠（日->月->季->年）
    cm = today.strftime("%Y-%m")
    cq = _month_to_quarter(cm)
    cy = str(today.year)
    coarse_fold = False
    coarse_fold |= _fold_days_to_months(days, months, cm)
    coarse_fold |= _fold_months_to_quarters(months, quarters, cq)
    coarse_fold |= _fold_quarters_to_years(quarters, years, cy)

    if not coarse_fold:
        return False

    # 4. 构建最终条目并写回
    entries = _build_archive_entries(days, months, quarters, years, today)
    _write_archive_refs(repo, entries)
    return True


# ============================================================================
# compact - 安全标签清理
# ============================================================================


def _cleanup_safety_refs(repo: Path, keep: int = 10) -> None:
    """清理 refs/backup/safety/ 下的安全提交 ref，只保留最近 N 个。"""
    # 使用 for-each-ref 列出 refs/backup/safety/ 下的所有 ref
    out = git_out(
        repo,
        "for-each-ref",
        "--sort=-creatordate",
        "--format=%(refname)",
        "refs/backup/safety/",
    ).splitlines()
    refs = [r.strip() for r in out if r.strip()]
    for r in refs[keep:]:
        git(repo, "update-ref", "-d", r, check=False)


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
    "done": (158, 158, 158, 255),
    "waiting": (255, 193, 7, 255),
    "error": (244, 67, 54, 255),
}

TITLES = {
    "running": "SuperMemo 备份守护（备份中）",
    "done": "SuperMemo 备份守护（空闲）",
    "waiting": "SuperMemo 备份守护（等待激活）",
    "error": "SuperMemo 备份守护（错误）",
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
# Watcher - 托盘监控生命周期封装（watchdog 事件驱动）
# ============================================================================


class Watcher:
    """封装 SuperMemo 集合监控的完整生命周期（watchdog 事件驱动）。

    使用 watchdog 监听集合目录的文件系统事件，替代原来的每秒轮询。
    事件进来只记时间戳（防抖），静默满 QUIET_SECONDS 才触发判定。

    使用示例：
        >>> from time_backup import Watcher, load_config
        >>> cfg = load_config()
        >>> watcher = Watcher(cfg)
        >>> watcher.start()  # 阻塞直到退出
    """

    def __init__(self, config: BackupConfig) -> None:
        """用配置对象创建监控器实例。

        Args:
            config: 由 load_config() 返回的 BackupConfig 对象
        """
        self._config = config
        self._stop_event: threading.Event | None = None
        self._thread: threading.Thread | None = None
        self._holder: dict = {}
        self._observer: Observer | None = None
        # 每个集合的最后触发时间（防抖）
        self._pending: dict[str, float] = {}
        self._pending_lock = threading.Lock()
        # 记录每个集合最近一次检测到 active=True 的时间戳，用于 min_active 语义
        self._activation_tracker: dict[str, float] = {}

    @property
    def config(self) -> BackupConfig:
        """底层配置对象。"""
        return self._config

    def _on_stats_change(self, coll: Collection) -> None:
        """stats 目录有写事件时，记录时间戳（不做 IO）。

        P1#4 修复: 同时记录首次 stats 活动时间作为集合激活起始时间，
        用于后续 min_active 语义判断（短激活跳过）。
        """
        now = _time.time()
        with self._pending_lock:
            self._pending[coll.name] = now
            # 记录首次检测到 stats 写入的时间（代表集合被打开）
            # 使用 setdefault 确保只记录第一次，后续 stats 写入不覆盖
            self._activation_tracker.setdefault(coll.name, now)

    def _debounce_checker(self) -> None:
        """定期扫描 pending 字典，静默满 QUIET_SECONDS 的集合触发备份。"""
        while not self._stop_event.is_set():
            _time.sleep(0.5)  # 每 0.5s 检查一次
            now = _time.time()
            to_process: list[str] = []
            with self._pending_lock:
                for name, last_time in list(self._pending.items()):
                    if now - last_time >= QUIET_SECONDS:
                        to_process.append(name)
                for name in to_process:
                    self._pending.pop(name, None)
            # 处理逻辑移到锁外，避免持锁执行 IO 阻塞 watchdog 线程
            # P2#7 修复: 在每个集合处理前刷新 now，避免长时间处理后时间戳过时
            for name in to_process:
                current_now = _time.time()  # 每次处理前重新获取时间
                coll = None
                for c in self._config.collections:
                    if c.name == name:
                        coll = c
                        break
                if coll is not None:
                    self._handle_collection_state_change(coll, current_now)

    def _handle_collection_state_change(self, c: Collection, now: float) -> None:
        """处理单个集合的状态变化（激活/退出），执行备份逻辑。"""
        name = c.name
        active_now = is_collection_active(c)
        min_active = self._config.min_active_seconds

        stats_file = Path(c.path) / "stats" / "time.dat"

        if active_now:
            # 集合仍在激活中，更新托盘图标状态
            # P2#6: 补充 tracker 记录，防止 _on_stats_change 漏事件导致 min_active 兜底失效
            with self._pending_lock:
                self._activation_tracker.setdefault(name, now)
            self._update_icon("waiting")
            return

        # 集合已退出。检查 stats 文件是否存在且不太旧
        # （排除首次启动时检测到的旧文件，避免误备份）
        if not stats_file.exists():
            log.debug(f"{name}: stats 文件不存在，跳过")
            return

        # TOCTOU 保护：exists() 后文件可能被删除，stat() 需捕获异常
        try:
            stats_mtime = stats_file.stat().st_mtime
        except OSError as e:
            log.debug(f"{name}: stats 文件 stat 失败: {e}")
            return
        time_since_last_write = now - stats_mtime

        # 如果 stats 很久没更新（超过 min_active 的 3 倍），可能是旧数据残留
        # min_active=0 时跳过此检查（0*3=0，time_since_last_write>0 几乎恒真）
        if min_active > 0 and time_since_last_write > min_active * 3:
            log.info(f"{name}: stats 文件较旧（{time_since_last_write:.0f}s），跳过")
            return

        # P1#4 修复: 检查激活时长 - 集合必须激活超过 min_active 秒才触发备份
        # （防止短激活（如误打开）也触发备份）
        # 激活起始时间由 _on_stats_change 在首次检测到 stats 写入时记录
        # P3: 加锁与 setdefault/pop 保持一致
        with self._pending_lock:
            activation_start = self._activation_tracker.get(name)
        if min_active > 0 and activation_start is not None:
            active_duration = now - activation_start
            if active_duration < min_active:
                log.info(
                    f"{name}: 激活时长仅 {active_duration:.0f}s（< {min_active}s），跳过备份"
                )
                # P0 v10: 清除 tracker，确保下次激活重新计时（防止两次短激活累积绕过）
                # P2#3: 加锁与成功路径保持一致
                with self._pending_lock:
                    self._activation_tracker.pop(name, None)
                return
        elif min_active > 0 and activation_start is None:
            # 从未检测到 stats 写入（启动时已运行或 stats 目录不存在）
            # 用 stats mtime 作为兜底近似
            if time_since_last_write > min_active:
                log.info(
                    f"{name}: 未检测到激活起始，stats 距今 {time_since_last_write:.0f}s，跳过"
                )
                return

        # 等待解锁瞬间的最终写入落盘
        _time.sleep(2)

        # 二次确认集合已退出（防止竞态条件：可能在等待期间重新激活）
        if is_collection_active(c):
            log.info(f"{name}: 二次检查发现仍在激活，跳过")
            return

        # P1#2: 用锁保护 pop，避免与 _on_stats_change 的 setdefault 竞态
        with self._pending_lock:
            self._activation_tracker.pop(name, None)

        log.info(f"{name}: 检测到退出，做冷备份")
        # P2 修复: 拆分 backup 和 compact 错误处理，避免 compact 失败时显示"备份失败"
        try:
            CollectionRepo(c).backup("shutdown", require_inactive=True)
        except Exception as e:
            log.error(f"{name}: backup failed: {e}")
            self._update_icon("error", f"{name} 备份失败")
            return
        try:
            CollectionRepo(c).compact()
        except Exception as e:
            log.error(f"{name}: compact failed: {e}")
            self._update_icon("error", f"{name} 压缩失败")
            return
        self._update_icon("done", f"{name} 已备份")

    def _update_icon(self, state: str, detail: str = "") -> None:
        """更新托盘图标。"""
        # P2: 比较 (state, detail) 元组而非仅 state，避免 detail 丢失
        # P3: icon 未设置时不写 _last_icon_key，防止首次真实更新被跳过
        if self._holder.get("icon") is None:
            return
        key = (state, detail)
        if key == self._holder.get("_last_icon_key"):
            return
        self._holder["_last_icon_key"] = key
        _update_icon(self._holder, state, detail)

    def _on_backup(self, icon, item) -> None:
        """托盘菜单：立即备份所有集合（后台执行，不阻塞托盘）。"""

        # 在后台线程执行耗时操作，避免阻塞 pystray 回调线程
        def _do_backup():
            self._update_icon("running", "备份中")
            skipped = []
            failed = []
            for c in self._config.collections:
                try:
                    CollectionRepo(c).backup("tray", require_inactive=True)
                except GitError as e:
                    failed.append(c.name)
                    log.error(f"{c.name}: git error: {e}")
                except RuntimeError as e:
                    skipped.append(c.name)
                    log.warning(str(e))
                except Exception as e:
                    failed.append(c.name)
                    log.error(f"{c.name}: {e}")
            parts = []
            if skipped:
                parts.append(f"跳过激活集合: {', '.join(skipped)}")
            if failed:
                parts.append(f"失败: {', '.join(failed)}")
            msg = "; ".join(parts) if parts else "备份完成"
            try:
                icon.notify(msg, "time")
            except Exception:
                pass
            if failed:
                self._update_icon("error", f"备份失败: {', '.join(failed)}")
            elif skipped:
                self._update_icon("done", "部分集合在激活，已跳过")
            else:
                self._update_icon("done", "备份完成")

        threading.Thread(target=_do_backup, daemon=True).start()

    def _on_compact(self, icon, item) -> None:
        """托盘菜单：压缩历史（后台执行，不阻塞托盘）。

        注意：不在托盘回调中使用 input()，因为 pystray 回调运行在独立线程，
        无控制台环境下 input() 会抛 EOFError 或永久阻塞。
        用户主动点击菜单即视为确认，直接执行压缩。
        """

        # 在后台线程执行耗时操作，避免阻塞 pystray 回调线程
        # 同时避免 dry_run + compact 两次读取 archive history（P2 #11）
        def _do_compact():
            self._update_icon("running", "压缩中")
            failed = []
            for c in self._config.collections:
                try:
                    repo = CollectionRepo(c)
                    # 先 dry_run 预览
                    plan = repo.compact(dry_run=True)
                    log.info(f"{c.name}: compact plan -> {plan.message}")
                    # P0#1 修复: 同时检查 deleted_refs（天折叠），
                    # 否则纯天折叠日永远不会执行
                    if plan.coarse_fold or plan.deleted_refs:
                        result = repo.compact()
                        log.info(f"{c.name}: compacted -> {result.message}")
                    else:
                        log.info(f"{c.name}: 无折叠需要，跳过")
                except Exception as e:
                    failed.append(c.name)
                    log.error(f"{c.name}: compact failed: {e}")
            msg = (
                f"压缩完成，以下集合失败: {', '.join(failed)}" if failed else "压缩完成"
            )
            try:
                icon.notify(msg, "time")
            except Exception:
                pass
            if failed:
                self._update_icon("error", f"压缩失败: {', '.join(failed)}")
            else:
                self._update_icon("done", "压缩完成")

        threading.Thread(target=_do_compact, daemon=True).start()

    def _on_open_dir(self, icon, item) -> None:
        """托盘菜单：打开配置目录。"""
        try:
            if sys.platform == "win32":
                os.startfile(str(_config_dir()))
            else:
                log.warning("打开配置目录仅支持 Windows 平台")
        except Exception as e:
            log.error(f"open dir: {e}")

    def _on_open_log(self, icon, item) -> None:
        """托盘菜单：打开日志文件。"""
        try:
            if sys.platform == "win32":
                os.startfile(str(LOG_FILE))
            else:
                log.warning("打开日志文件仅支持 Windows 平台")
        except Exception as e:
            log.error(f"open log: {e}")

    def _on_quit(self, icon, item) -> None:
        """托盘菜单：退出。"""
        self.stop()
        icon.stop()

    def start(self) -> None:
        """启动托盘监控（阻塞直到用户退出）。

        在托盘图标中提供以下菜单项：
          - 立即备份：触发所有集合的冷备份
          - 压缩历史：预览并执行所有集合的历史压缩（托盘点击即视为确认）
          - 打开配置目录：在文件管理器中打开配置文件夹
          - 打开日志：在默认编辑器中打开日志文件
          - 退出：停止监控并退出
        """
        # P3#3 修复: 防止重复 start() 启动多个 debounce 线程
        if self._thread is not None and self._thread.is_alive():
            log.warning("Watcher 已在运行，忽略重复 start()")
            return

        if not self._config.collections:
            log.error("未发现任何集合。请检查 smtk config 的 program / knos 设置。")
            return

        self._stop_event = threading.Event()
        self._holder = {}

        # 启动 watchdog 监听 + 防抖检查器
        self._start_watchdog()

        # 构建托盘菜单
        menu = pystray.Menu(
            pystray.MenuItem("立即备份", self._on_backup),
            pystray.MenuItem("压缩历史", self._on_compact),
            pystray.Menu.SEPARATOR,
            pystray.MenuItem("打开配置目录", self._on_open_dir),
            pystray.MenuItem("打开日志", self._on_open_log),
            pystray.Menu.SEPARATOR,
            pystray.MenuItem("退出", self._on_quit),
        )
        icon = pystray.Icon(
            "smtime",
            _make_tray_image(COLORS["waiting"]),
            TITLES["waiting"],
            menu,
        )
        self._holder["icon"] = icon
        self._thread = threading.Thread(target=self._debounce_checker, daemon=True)
        self._thread.start()
        try:
            icon.run()
        except KeyboardInterrupt:
            log.info("interrupted")
            self.stop()
        finally:
            self.stop()
            if self._thread is not None:
                self._thread.join(timeout=10)

    def _start_watchdog(self) -> None:
        """启动 watchdog 目录监听器。"""
        self._observer = Observer()
        handler = _StatsHandler(self)
        for c in self._config.collections:
            coll_dir = Path(c.path)
            if coll_dir.exists():
                self._observer.schedule(handler, str(coll_dir), recursive=True)
                log.info(f"watchdog: watching {coll_dir}")
            else:
                log.warning(f"watchdog: directory not found: {coll_dir}")
        self._observer.start()
        log.info("watchdog: observer started")
        # P2#4/P3: 启动时已运行的集合，用启动时间近似激活起始（加锁保护）
        with self._pending_lock:
            for c in self._config.collections:
                if is_collection_active(c):
                    self._activation_tracker.setdefault(c.name, _time.time())
                    log.info(f"watchdog: pre-active collection {c.name}, tracker set")

    def stop(self) -> None:
        """停止监控。"""
        if self._stop_event is not None:
            self._stop_event.set()
        if self._observer is not None:
            try:
                self._observer.stop()
                self._observer.join(timeout=5)
            except Exception:
                pass
        # P2#5: 清空 pending 和 tracker，防止重启 Watcher 时残留
        with self._pending_lock:
            self._pending.clear()
            self._activation_tracker.clear()


class _StatsHandler(FileSystemEventHandler):
    """watchdog 事件处理器：只关心 stats/ 目录下的文件变更。"""

    def __init__(self, watcher: Watcher) -> None:
        self._watcher = watcher

    def _get_coll_name(self, event: object) -> str | None:
        """从事件路径反推集合名（同时检查 src_path 和 dest_path，覆盖 moved-into-stats 场景）。"""
        try:
            # P0#2 修复: 同时检查 src_path 和 dest_path
            # 文件从外部移动进 stats/ 时，src_path 不在 stats 下，只有 dest_path 在
            for attr in ("src_path", "dest_path"):
                raw = getattr(event, attr, None)
                if not raw:
                    continue
                p = Path(raw)
                # 找 stats 目录的父目录即集合目录
                for parent in p.parents:
                    if parent.name == "stats":
                        return (
                            parent.parent.name
                        )  # stats 目录的父目录（集合目录）的名字
            return None
        except Exception:
            return None

    def on_any_event(self, event) -> None:
        """所有文件系统事件统一处理。"""
        # 忽略目录事件和 opened 事件（Linux inotify 下读取文件会触发 opened）
        if event.is_directory:
            return
        # 过滤 opened 事件，避免无谓唤醒 debounce 线程
        if getattr(event, "event_type", "") == "opened":
            return
        src = getattr(event, "src_path", "") or ""
        dest = getattr(event, "dest_path", "") or ""
        # 用 Path.parts 精确匹配目录名，避免路径中含 "stats" 子串误匹配
        # 同时检查 src_path 和 dest_path（文件移动进 stats/ 时 src 不在 stats 下）
        src_in_stats = src and "stats" in Path(src).parts
        dest_in_stats = dest and "stats" in Path(dest).parts
        if not src_in_stats and not dest_in_stats:
            return
        # P2#5 修复: 同时检查 src 和 dest 的 .tmp 扩展名
        # 文件从 foo.tmp 移动到 stats/foo.dat 时 src 是 .tmp 应跳过；
        # 从 foo.dat 移动到 stats/foo.tmp 时 dest 是 .tmp 也应跳过
        if src.endswith((".tmp", ".TMP")) or dest.endswith((".tmp", ".TMP")):
            return

        name = self._get_coll_name(event)
        if name is None:
            return

        # 找到对应的 Collection
        config = self._watcher.config

        coll = None
        for c in config.collections:
            if c.name == name:
                coll = c
                break
        if coll is None:
            return

        self._watcher._on_stats_change(coll)


# ============================================================================
# SuperMemoBackup - 高级 API 入口（顶层编排器）
# ============================================================================


class SuperMemoBackup:
    """SuperMemo 集合冷备份管理器（顶层编排器）。

    这是工具的主要 API 入口。内部使用 CollectionRepo 管理单个集合操作，
    使用 Watcher 管理托盘监控生命周期。

    使用示例：
        >>> from time_backup import SuperMemoBackup
        >>> sm = SuperMemoBackup.from_config()
        >>> sm.init_all()
        >>> result = sm.backup("Maths")
        >>> sm.restore("Maths", "archive")
        >>> sm.compact_all()
        >>> sm.watch()  # 阻塞直到退出
    """

    def __init__(self, config: BackupConfig) -> None:
        """用配置对象创建管理器实例。

        Args:
            config: 由 load_config() 返回的 BackupConfig 对象
        """
        self.config = config
        self._watcher: Watcher | None = None

    @classmethod
    def from_config(cls) -> SuperMemoBackup:
        """从配置文件加载并创建管理器实例。

        这是最常用的创建方式。等价于：
            sm = SuperMemoBackup(load_config())
        """
        return cls(load_config())

    def get_collection(self, name: str) -> Collection:
        """按名称查找集合。

        Args:
            name: 集合名称

        Returns:
            Collection 对象

        Raises:
            KeyError: 集合不存在
        """
        return self.config.get_collection(name)

    def collection(self, name: str) -> CollectionRepo:
        """获取指定集合的仓库操作对象。

        这是推荐的使用方式：通过 CollectionRepo 操作单个集合。

        Args:
            name: 集合名称

        Returns:
            CollectionRepo 实例
        """
        return CollectionRepo(self.get_collection(name))

    def init(self, name: str | None = None) -> Path:
        """初始化集合的 Git 仓库。

        Args:
            name: 集合名称。None 时初始化第一个集合。
                  使用 init_all() 可初始化所有集合。

        Returns:
            初始化的仓库路径

        Raises:
            ValueError: 没有可初始化的集合
        """
        if name is not None:
            return self.collection(name).init()
        if self.config.collections:
            return self.collection(self.config.collections[0].name).init()
        raise ValueError("没有可初始化的集合")

    def init_all(self) -> list[Path]:
        """初始化所有集合的 Git 仓库。

        Returns:
            初始化的仓库路径列表
        """
        return [self.collection(c.name).init() for c in self.config.collections]

    def backup(
        self, name: str, trigger: str = "manual", require_inactive: bool = True
    ) -> BackupResult:
        """冷备份指定集合（集合必须已关闭）。

        Args:
            name: 集合名称
            trigger: 触发来源 ("manual"/"tray"/"shutdown"/"debug")
            require_inactive: True 时如果集合正在激活则直接抛异常

        Returns:
            BackupResult 对象
        """
        return self.collection(name).backup(trigger, require_inactive)

    def backup_all(self, trigger: str = "manual") -> list[BackupResult]:
        """冷备份所有集合（集合必须已关闭）。

        任一集合备份失败不会中断其他集合的备份。

        Args:
            trigger: 触发来源

        Returns:
            BackupResult 列表（每个集合一个）
        """
        results: list[BackupResult] = []
        for c in self.config.collections:
            try:
                r = self.collection(c.name).backup(trigger, require_inactive=True)
                results.append(r)
            except GitError as e:
                log.error(f"{c.name}: git error: {e}")
                results.append(
                    BackupResult(commit="", branch=None, locked=False, skipped=False)
                )
            except RuntimeError as e:
                log.warning(f"{c.name}: {e}")
                results.append(
                    BackupResult(commit="", branch=None, locked=True, skipped=False)
                )
            except Exception as e:
                log.error(f"{c.name}: {e}")
                results.append(
                    BackupResult(commit="", branch=None, locked=False, skipped=False)
                )
        return results

    def restore(
        self,
        name: str,
        target: str,
        paths: list[str] | None = None,
        safety: bool = True,
    ) -> RestoreResult:
        """冷恢复指定集合（集合必须已关闭）。

        Args:
            name: 集合名称
            target: 恢复目标（分支名/tag/commit hash）
            paths: 可选。指定恢复的文件路径列表。None 表示全量恢复。
            safety: 是否在恢复前创建安全快照（默认 True）

        Returns:
            RestoreResult 对象
        """
        return self.collection(name).restore(target, paths, safety)

    def compact(
        self, name: str | None = None, today: date | None = None, dry_run: bool = False
    ) -> CompactResult | None:
        """压缩集合历史。

        Args:
            name: 集合名称。None 时压缩所有集合。
            today: 可选。用于测试的日期（默认 date.today()）
            dry_run: 如果为 True，只打印计划不执行实际操作。

        Returns:
            如果 name 不为 None，返回 CompactResult；
            如果 name 为 None（批量模式），返回最后一个集合的结果，其余打印日志。
        """
        if name is not None:
            return self.collection(name).compact(today, dry_run)
        else:
            last_result: CompactResult | None = None
            for c in self.config.collections:
                result = self.collection(c.name).compact(today, dry_run)
                log.info(f"{c.name}: compact -> {result.message}")
                last_result = result
            return last_result

    def compact_all(
        self, today: date | None = None, dry_run: bool = False
    ) -> list[CompactResult]:
        """压缩所有集合历史。

        Args:
            today: 可选。用于测试的日期（默认 date.today()）
            dry_run: 如果为 True，只打印计划不执行实际操作。

        Returns:
            每个集合的 CompactResult 列表
        """
        results: list[CompactResult] = []
        for c in self.config.collections:
            result = self.collection(c.name).compact(today, dry_run)
            results.append(result)
            log.info(f"{c.name}: compact -> {result.message}")
        return results

    def snapshots(self, name: str) -> SnapshotData | None:
        """获取指定集合的快照信息。

        Args:
            name: 集合名称

        Returns:
            SnapshotData 对象，仓库不存在时返回 None
        """
        return self.collection(name).snapshots()

    def list_snapshots(self, name: str) -> None:
        """打印指定集合的快照信息。

        Args:
            name: 集合名称
        """
        self.collection(name).list_snapshots()

    def watch(self) -> None:
        """启动托盘监控（阻塞直到用户退出）。"""
        if self._watcher is not None:
            log.warning("SuperMemoBackup.watch() 已调用过，忽略重复调用")
            return
        self._watcher = Watcher(self.config)
        self._watcher.start()


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
    "RestoreResult",
    "Snapshot",
    "SnapshotData",
    # 高级 API
    "SuperMemoBackup",
    "Watcher",
    "activation_start_from_stats",
    "discover_collections",
    "is_collection_active",
    # 工具
    "is_file_locked",
    # 配置
    "load_config",
    "setup_logging",
]

# ============================================================================
# 命令行入口（测试/日常使用）
# ============================================================================

if __name__ == "__main__":
    # 改这里切换测试动作
    MODE = "backup"
    # 可选：
    #   "init"      初始化所有集合仓库
    #   "backup"    冷备份所有集合（集合必须已关闭）
    #   "list"      打印所有集合快照
    #   "compact"   压缩所有集合历史
    #   "restore"   冷恢复指定集合
    #   "watch"     启动托盘监控（阻塞，放最后测）
    RESTORE_TARGET = "archive"  # 分支/tag/commit
    RESTORE_PATHS = None  # None=全量；["Reading-And-Review.kno"]=只恢复 .kno
    setup_logging(verbose=True)

    # 使用 SuperMemoBackup 类（推荐方式）
    sm = SuperMemoBackup.from_config()

    if MODE == "init":
        sm.init_all()
    elif MODE == "backup":
        # 备份所有集合
        results = sm.backup_all(trigger="debug")
        for r in results:
            log.info(f"backup: {r}")
    elif MODE == "list":
        # 打印所有集合快照
        for c in sm.config.collections:
            sm.list_snapshots(c.name)
    elif MODE == "compact":
        # 先 dry_run 预览
        plan = sm.compact(dry_run=True)
        if plan:
            log.info(f"compact plan: {plan.message}")
            confirm = input("确认执行压缩? [y/N] ").strip().lower()
            if confirm == "y":
                sm.compact_all()
                log.info("compact OK")
            else:
                log.info("用户取消")
        else:
            log.info("no collections to compact")
    elif MODE == "restore":
        # 恢复第一个集合
        coll = sm.config.collections[0]
        log.info(f"restore: {coll.name} <- {RESTORE_TARGET} paths={RESTORE_PATHS}")
        result = sm.restore(coll.name, RESTORE_TARGET, paths=RESTORE_PATHS)
        log.info(
            f"restore result: safety_ref={result.safety_ref}, restored={result.restored}"
        )
        log.info("restore OK")
    # elif MODE == "watch":
    #     sm.watch()
