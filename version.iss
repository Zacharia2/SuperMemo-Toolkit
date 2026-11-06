; ============================================================
; version.iss —— 自动提取 Python 版本号
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