# -*- mode: python ; coding: utf-8 -*-  # noqa: UP009
# type: ignore
TYPE_CHECKING = False
if TYPE_CHECKING:
    from implicit_import import *

# ==========================================
# 1. smtk.exe —— 纯 CLI
# ==========================================
a = Analysis(
    ["supermemo_toolkit/smtk.py"],
    pathex=[],
    binaries=[],
    datas=[],
    hiddenimports=["win32timezone"],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)
exe_smtk = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name="smtk",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon="Icon.png",
)

# ==========================================
# 2. smtk-shell.exe —— 交互终端
# ==========================================
a_shell = Analysis(
    ["supermemo_toolkit/smtk_shell.py"],
    pathex=[],
    binaries=[],
    datas=[],
    hiddenimports=[
        "supermemo_toolkit.smtk",  # shell.py 里延迟导入，静态分析抓不到
        "prompt_toolkit",  # 显式声明，避免 hook 遗漏
        "prompt_toolkit.output.win32",  # Windows 控制台后端
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz_shell = PYZ(a_shell.pure)
exe_shell = EXE(
    pyz_shell,
    a_shell.scripts,
    [],
    exclude_binaries=True,
    name="smtk-shell",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon="Icon.png",
)

# ==========================================
# 3. launcher.exe —— GUI 启动器
# ==========================================
a_launcher = Analysis(
    ["launcher.pyw"],
    pathex=[],
    binaries=[],
    datas=[],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz_launcher = PYZ(a_launcher.pure)
exe_launcher = EXE(
    pyz_launcher,
    a_launcher.scripts,
    [],
    exclude_binaries=True,
    name="launcher",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon="Icon.png",
)

# ==========================================
# 4. 合并到一个目录
# ==========================================
coll = COLLECT(
    exe_smtk,
    exe_shell,
    exe_launcher,
    a.binaries,
    a.datas,
    a_shell.binaries,
    a_shell.datas,
    a_launcher.binaries,
    a_launcher.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name="smtk",  # 产物：dist/smtk/
)
