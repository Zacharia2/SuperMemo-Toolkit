; ============================================================
;  smtk 安装器 (Inno Setup 6.3+)
; ============================================================


; ============================================================
; 1. 自动提取 Python 版本号
; ============================================================
#define VersionFilePath AddBackslash(SourcePath) + "supermemo_toolkit\__init__.py"
#define public CleanVersion ""
#define public FileLine ""
#define i 0

#sub ProcessLine
  ; 先读取一行
  #define FileLine FileRead(FileHandle)
  
  ; 如果不是空行，且包含 __version__
  #if (FileLine != "") && (Pos("__version__", FileLine) > 0)
    #define EqPos Pos("=", FileLine)
    #if EqPos > 0
      #define RawValue Trim(Copy(FileLine, EqPos + 1))
      #define QuoteChar Copy(RawValue, 1, 1)
      
      ; 剥离单双引号
      #if (QuoteChar == """") || (QuoteChar == "'")
        #define EndPos Pos(QuoteChar, Copy(RawValue, 2))
        #if EndPos > 0
          ; ★ 核心修复：加上 public，强制修改外部变量
          #define public CleanVersion Copy(RawValue, 2, EndPos - 1)
        #endif
      #else
        ; ★ 核心修复：加上 public
        #define public CleanVersion RawValue
      #endif
    #endif
  #endif
#endsub

#define FileHandle FileOpen(VersionFilePath)

#if FileHandle == 0
  #pragma message "【致命错误】找不到文件：" + VersionFilePath
#else
  #for { i = 1 ; i <= 15 ; i++ } ProcessLine
  #expr FileClose(FileHandle)
#endif

; 最终赋值
#if CleanVersion != ""
  #define MyAppVersion CleanVersion
  #pragma message "【成功】提取到版本号: " + MyAppVersion
#else
  #define MyAppVersion "0.0.0-dev"
  #pragma message "【警告】未提取到版本号，使用默认值"
#endif

; ============================================================
; 容错：Inno Setup 的 VersionInfoVersion 不允许带后缀 (-beta)
; 自动提取小数点前的纯数字部分，例如 0.2.10-beta -> 0.2.10.0
; ============================================================
#define MyAppVersionNumeric Copy(MyAppVersion, 1, Pos("-", MyAppVersion + "-") - 1) + ".0"


; ============================================================
; 2. 调用宏
; ============================================================
#define MyAppName       "SuperMemo Toolkit"
#define MyAppPublisher  "smtk"
#define MyAppURL        "https://github.com/Zacharia2/SuperMemo-Toolkit"
#define MyAppExeName    "launcher.exe"

; ★ 唯一标识，升级时必须保持一致
#define MyAppId         "{{B8E1C3F2-9A4D-4E5B-A1F6-2C7D8E9F0A1B}"

[Setup]
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes

PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

OutputDir=dist
OutputBaseFilename=smtk-setup-{#MyAppVersion}
UninstallDisplayIcon={app}\{#MyAppExeName}

Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

; 安装/卸载后通知系统环境变量已变更
ChangesEnvironment=yes

CloseApplications=yes
RestartApplications=no

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english";    MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "addtopath";   Description: "将 smtk CLI 加入 PATH（可在任意目录运行 smtk 命令）"; GroupDescription: "环境变量:"; Flags: checkedonce

[Files]
Source: "dist\smtk\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; 开始菜单 —— 只给 GUI 和交互终端建快捷方式
Name: "{group}\{#MyAppName} (GUI)";   Filename: "{app}\launcher.exe";   WorkingDir: "{app}"
Name: "{group}\smtk 交互终端";        Filename: "{app}\smtk-shell.exe"; WorkingDir: "{app}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
; 桌面
Name: "{autodesktop}\{#MyAppName}";   Filename: "{app}\launcher.exe";   WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; \
  WorkingDir: "{app}"; \
  Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; \
  Flags: nowait postinstall skipifsilent runasoriginaluser

[UninstallDelete]
Type: filesandordirs; Name: "{app}\_internal"

[Code]
const
  EnvKeyUser    = 'Environment';
  EnvKeyMachine = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
  AppRegKey     = 'Software\smtk';

{ ============================================================
  路径规范化
  ============================================================ }
function NormalizePath(const Path: string): string;
begin
  Result := Trim(Path);
  if (Length(Result) >= 2) and (Result[1] = '"') and (Result[Length(Result)] = '"') then
    Result := Trim(Copy(Result, 2, Length(Result) - 2));
  while (Length(Result) > 3) and (Result[Length(Result)] = '\') do
    Delete(Result, Length(Result), 1);
  Result := Trim(Result);
end;

{ ============================================================
  PathListContains：按段比较（大小写不敏感）
  ============================================================ }
function PathListContains(const Paths, Path: string): Boolean;
var
  Seg, Rest, Norm: string;
  P: Integer;
begin
  Result := False;
  Norm := NormalizePath(Path);
  if Norm = '' then
    Exit;
  Rest := Paths;
  while Rest <> '' do
  begin
    P := Pos(';', Rest);
    if P > 0 then
    begin
      Seg := Copy(Rest, 1, P - 1);
      Rest := Copy(Rest, P + 1, Length(Rest));
    end
    else
    begin
      Seg := Rest;
      Rest := '';
    end;
    if CompareText(NormalizePath(Seg), Norm) = 0 then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

{ ============================================================
  PathListRemove：移除与目标匹配的非空段；
  同时丢弃所有空段，避免残留前导/连续分号
  （Windows 中空段会被解释为"当前目录"）
  调用方需先通过 PathListContains 确认目标存在
  ============================================================ }
function PathListRemove(const Paths, Path: string): string;
var
  Seg, Rest, Norm: string;
  P: Integer;
  First: Boolean;
begin
  Result := '';
  First := True;
  Norm := NormalizePath(Path);
  if Norm = '' then
  begin
    Result := Paths;
    Exit;
  end;
  Rest := Paths;
  while True do
  begin
    P := Pos(';', Rest);
    if P > 0 then
    begin
      Seg := Copy(Rest, 1, P - 1);
      Rest := Copy(Rest, P + 1, Length(Rest));
    end
    else
    begin
      Seg := Rest;
      Rest := '';
    end;

    { 跳过空段；跳过与目标匹配的段；其余原样保留 }
    if (Seg <> '') and (CompareText(NormalizePath(Seg), Norm) <> 0) then
    begin
      if not First then
        Result := Result + ';';
      Result := Result + Seg;
      First := False;
    end;

    if P = 0 then
      Break;
  end;
end;

{ ============================================================
  安装模式持久化
  - 管理员：HKLM\Software\smtk\PathRoot = 1
  - 普通：  HKCU\Software\smtk\PathRoot = 0
  ============================================================ }
procedure SavePathRootFlag;
begin
  if IsAdminInstallMode then
  begin
    if not RegWriteDWordValue(HKEY_LOCAL_MACHINE, AppRegKey, 'PathRoot', 1) then
      Log('Warning: failed to write HKLM\Software\smtk\PathRoot');
  end
  else
  begin
    if not RegWriteDWordValue(HKEY_CURRENT_USER, AppRegKey, 'PathRoot', 0) then
      Log('Warning: failed to write HKCU\Software\smtk\PathRoot');
  end;
end;

procedure ClearPathRootFlag;
begin
  if not RegDeleteValue(HKEY_LOCAL_MACHINE, AppRegKey, 'PathRoot') then
    Log('Note: HKLM PathRoot not present or delete failed');
  RegDeleteKeyIfEmpty(HKEY_LOCAL_MACHINE, AppRegKey);

  if not RegDeleteValue(HKEY_CURRENT_USER, AppRegKey, 'PathRoot') then
    Log('Note: HKCU PathRoot not present or delete failed');
  RegDeleteKeyIfEmpty(HKEY_CURRENT_USER, AppRegKey);
end;

{ ============================================================
  添加 PATH
  返回 True 表示本次确实写入了 PATH（用于决定是否保存卸载标记）
  ============================================================ }
function EnvAddPath(Path: string): Boolean;
var
  Paths, NormPath, SubKey: string;
  Root: Integer;
begin
  Result := False;
  NormPath := NormalizePath(Path);
  if NormPath = '' then
    Exit;

  if IsAdminInstallMode then
  begin
    Root := HKEY_LOCAL_MACHINE;
    SubKey := EnvKeyMachine;
  end
  else
  begin
    Root := HKEY_CURRENT_USER;
    SubKey := EnvKeyUser;
  end;

  if not RegQueryStringValue(Root, SubKey, 'Path', Paths) then
  begin
    { 值存在但读取失败 → 放弃，绝不把 PATH 当成空来覆盖 }
    if RegValueExists(Root, SubKey, 'Path') then
    begin
      Log('Warning: Path exists but read failed; abort to protect user PATH');
      Exit;
    end;
    Paths := '';
  end;

  { 已存在（用户手动加过，或上次安装加过）→ 不写入、不标记 }
  if PathListContains(Paths, NormPath) then
    Exit;

  if (Paths <> '') and (Paths[Length(Paths)] <> ';') then
    Paths := Paths + ';';

  if RegWriteExpandStringValue(Root, SubKey, 'Path', Paths + NormPath) then
    Result := True
  else
    Log('Warning: failed to write Path in EnvAddPath');
end;

{ ============================================================
  在指定根键上清理 PATH
  只有"标记存在 + 路径确实在 PATH 中"两个条件同时满足才动
  ============================================================ }
procedure EnvRemovePathAt(Root: Integer; const SubKey, Path: string);
var
  Paths, NewPaths: string;
begin
  if not RegQueryStringValue(Root, SubKey, 'Path', Paths) then
    Exit; { 读不到就不动 }

  if not PathListContains(Paths, Path) then
    Exit; { 路径本来就不在，一个字节都不改 }

  NewPaths := PathListRemove(Paths, Path);

  if NewPaths = '' then
  begin
    { 原 PATH 只剩目标路径：写空字符串而不是删值，
      避免系统 PATH 值整体缺失带来的额外风险 }
    if not RegWriteExpandStringValue(Root, SubKey, 'Path', '') then
      Log('Warning: failed to clear Path value in EnvRemovePathAt');
  end
  else
  begin
    if NewPaths = Paths then
      Exit; { 理论上不会发生；保险起见不动 }
    if not RegWriteExpandStringValue(Root, SubKey, 'Path', NewPaths) then
      Log('Warning: failed to write Path value in EnvRemovePathAt');
  end;
end;

{ ============================================================
  安装 / 卸载钩子
  ============================================================ }
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep = ssPostInstall) and WizardIsTaskSelected('addtopath') then
  begin
    { 只有 EnvAddPath 真正写入成功，才记录标记；
      如果路径本来就存在，不写标记，卸载时也就绝不会去碰它 }
    if EnvAddPath(ExpandConstant('{app}')) then
      SavePathRootFlag;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Flag: Cardinal;
  AppPath: string;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    AppPath := ExpandConstant('{app}');

    { 有 HKCU 标记 → 清 HKCU PATH（用户模式装过） }
    if RegQueryDWordValue(HKEY_CURRENT_USER, AppRegKey, 'PathRoot', Flag) then
      EnvRemovePathAt(HKEY_CURRENT_USER, EnvKeyUser, AppPath);

    { 有 HKLM 标记 → 清 HKLM PATH（管理员模式装过） }
    if RegQueryDWordValue(HKEY_LOCAL_MACHINE, AppRegKey, 'PathRoot', Flag) then
      EnvRemovePathAt(HKEY_LOCAL_MACHINE, EnvKeyMachine, AppPath);

    ClearPathRootFlag;
  end;
end;