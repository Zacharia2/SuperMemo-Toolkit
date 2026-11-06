# -*- mode: python ; coding: utf-8 -*-  # noqa: UP009
# type: ignore
TYPE_CHECKING = False
if TYPE_CHECKING:
    from implicit_import import *

# ==========================================
# 1. 打包 smtk.py (命令行工具)
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

splash = Splash(
    "Icon.png",
    binaries=a.binaries,
    datas=a.datas,
    text_pos=(10, 35),
    text_size=12,
    text_color="white",
    max_img_size=(400, 400),
    minify_script=True,
    always_on_top=True,
)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    splash,
    splash.binaries,
    [],
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
# 2. 打包 launcher.pyw (GUI 启动器)
# ==========================================
a_launcher = Analysis(
    ["launcher.pyw"],  # 指定 launcher.pyw 为主入口
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
    a_launcher.binaries,
    a_launcher.datas,
    [],
    name="launcher",  # 最终生成 launcher.exe
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
