Option Explicit
' [deprecated] 过时，使用whl安装和smtk integrate代替

' ============================================================
' SuperMemo Toolkit 启动器
'
' 职责：在 Windows 上定位可用的 Python，用 pythonw.exe 启动同目录的
'       launcher.pyw（GUI 模式，不弹控制台）。
'
' 扫描顺序：注册表 → 标准安装目录 → pyenv-win → conda → uv → py launcher → %PATH%
' 每个候选都要探测版本号，选出最高版本；同版本时优先 pythonw.exe。
'
' 两个必须知道的坑：
'   1. pythonw.exe 是 GUI 子系统程序，stdout 不连接到重定向句柄，
'      `pythonw.exe --version > file` 得到的文件必然为空。
'      因此探测版本时优先用同目录的 python.exe（控制台子系统）。
'   2. VBS 的 On Error 是过程级而非块级，子过程末尾的 On Error GoTo 0
'      会清掉调用者的 Resume Next 保护。所有被调用的子过程末尾统一用
'      On Error Resume Next 收尾，把保护"还"给调用者。
' ============================================================

Dim fso, sh, scriptDir, scriptPath
Dim bestPython, bestVersion
Dim g_re
Dim g_probed
Dim g_fallbackPy, g_fallbackVer
Dim g_tmpFile

Set fso = CreateObject("Scripting.FileSystemObject")
Set sh  = CreateObject("WScript.Shell")

' 已探测过的路径 → 版本号缓存。文本比较，避免大小写不同造成重复探测。
Set g_probed = CreateObject("Scripting.Dictionary")
g_probed.CompareMode = 1  ' vbTextCompare

' 全局复用的正则对象，各处临时改 Pattern 使用。
Set g_re = CreateObject("VBScript.RegExp")
g_re.IgnoreCase = True
g_re.Global = False

scriptDir  = fso.GetParentFolderName(WScript.ScriptFullName)
scriptPath = scriptDir & "\launcher.py"

If Not fso.FileExists(scriptPath) Then
    MsgBox "Script not found: " & scriptPath, 16, "Error"
    WScript.Quit 1
End If

bestPython     = ""
bestVersion    = ""
g_fallbackPy   = ""
g_fallbackVer  = ""

' 临时文件用于捕获子进程输出。
' 文件名加随机后缀，防止多个实例并发时互相覆盖。
' Timer 的小数点符号随区域设置可能是 . 或 ,，两种都替换掉。
g_tmpFile = sh.ExpandEnvironmentStrings("%TEMP%") & "\qvbs_probe_" & _
            Replace(Replace(CStr(Timer), ".", ""), ",", "") & ".tmp"

' ---- 扫描所有来源 ----
ScanRegistry &H80000002, "SOFTWARE\Python\PythonCore"
ScanRegistry &H80000001, "SOFTWARE\Python\PythonCore"
ScanRegistry &H80000002, "SOFTWARE\Wow6432Node\Python\PythonCore"
ScanRegistry &H80000001, "SOFTWARE\Wow6432Node\Python\PythonCore"

ScanStandardDirs
ScanPyenvWin
ScanConda
ScanUv
ScanPyLauncher
ScanPath

' ---- 最终选择 ----
' 如果没找到任何能确定版本的 Python，退而使用第一个探测失败的候选
' （例如只在 PYTHONPATH 里出现、版本号取不到的 pythonw.exe）。
If bestPython = "" And g_fallbackPy <> "" Then
    bestPython  = g_fallbackPy
    bestVersion = g_fallbackVer
End If

If bestPython = "" Then
    MsgBox "Could not find any pythonw.exe or python.exe on this system.", 16, "Error"
    WScript.Quit 1
End If

On Error Resume Next
Err.Clear
sh.Run """" & bestPython & """ """ & scriptPath & """", 0, False
If Err.Number <> 0 Then
    Err.Clear
    On Error GoTo 0
    MsgBox "Failed to launch Python:" & vbCrLf & bestPython & vbCrLf & _
           "The file may have been moved or is inaccessible.", 16, "Error"
    WScript.Quit 1
End If
On Error GoTo 0

' ============================================================
' 工具函数
' ============================================================

' 枚举 folderPath 的直接子目录，返回 Array("路径|目录名", ...)。
' 无子目录或读取失败时返回 Array("")，调用方需判空字符串。
Function CollectSubFolders(folderPath)
    Dim arr(), cnt, f, subFld, tmp(), i
    cnt = 0
    On Error Resume Next
    Err.Clear
    Set subFld = fso.GetFolder(folderPath).SubFolders
    If Err.Number <> 0 Then
        Err.Clear
        On Error GoTo 0
        CollectSubFolders = Array("")
        Exit Function
    End If
    ReDim tmp(63)
    For Each f In subFld
        If cnt > UBound(tmp) Then ReDim Preserve tmp(UBound(tmp) * 2 + 1)
        tmp(cnt) = f.Path & "|" & f.Name
        cnt = cnt + 1
        If Err.Number <> 0 Then
            Err.Clear
            Exit For
        End If
    Next
    Err.Clear
    On Error GoTo 0
    If cnt = 0 Then
        CollectSubFolders = Array("")
        Exit Function
    End If
    ReDim arr(cnt - 1)
    For i = 0 To cnt - 1
        arr(i) = tmp(i)
    Next
    CollectSubFolders = arr
End Function

Function NameContainsPython(name)
    NameContainsPython = (InStr(LCase(name), "python") > 0)
End Function

' ------------------------------------------------------------------
' ExtractVersionFromName
'   从目录名/注册表键名中猜测 Python 版本，返回内部版本串，
'   失败返回 ""，调用方会转而用 --version 或 FILEVERSION 探测。
'
'   内部版本串格式：major.minor.patch.rank[.preNum]
'     rank: 9999=正式版, 1=dev, 2=a, 3=b, 4=rc
'     这样正式的 3.11.5 会排在 3.11.5rc1 之前，符合语义。
'
'   为什么不直接用原始字符串跑正则：
'     "python3.11.5" 里位置 7 的 "." 会被 ^|[_\.\-] 当成版本分隔符，
'     结果误匹配出 "11.5.0.9999"。所以先剥离 "python" 前缀，
'     用剥离后的 sMain 跑主正则；原始 s 只留给 "python312" 这种回退。
' ------------------------------------------------------------------
Function ExtractVersionFromName(name)
    Dim s, sMain, rest, matches, digits
    ExtractVersionFromName = ""
    If name = "" Then Exit Function
    s = LCase(name)

    sMain = s
    If Left(sMain, 6) = "python" Then
        rest = Mid(sMain, 7)
        If rest <> "" Then sMain = rest
    End If

    On Error Resume Next

    ' 主正则：匹配 "3.11"、"3.11.5"、"3.11.5rc1"、"3.11.5+20240101" 等形式。
    ' lookahead 加入 + 是为了兼容 uv 的 "3.11.5+20240101" 目录名。
    Err.Clear
    g_re.Pattern = "(?:^|[_\.\-])(\d+)\.(\d+)(?:\.(\d+))?(?:\.?(a|b|rc|dev)(\d+))?(?=[_\.\-\+]|$)"
    Set matches = g_re.Execute(sMain)
    If Err.Number = 0 And IsObject(matches) Then
        If matches.Count > 0 Then
            ExtractVersionFromName = BuildVersionFromMatch(matches(0))
            Err.Clear : On Error GoTo 0 : Exit Function
        End If
    End If
    Err.Clear

    ' 回退：处理 "python312" 这种没有点号的目录名。
    ' 用原始 s（含 python 前缀）来匹配。
    g_re.Pattern = "python(\d+)"
    Set matches = g_re.Execute(s)
    If Err.Number = 0 And IsObject(matches) Then
        If matches.Count > 0 Then
            digits = matches(0).SubMatches(0)
            Select Case Len(digits)
                Case 1
                    ExtractVersionFromName = SafeLong(digits) & ".0.0.9999"
                Case 2
                    ExtractVersionFromName = SafeLong(Left(digits, 1)) & "." & SafeLong(Right(digits, 1)) & ".0.9999"
                Case 3
                    ExtractVersionFromName = SafeLong(Left(digits, 1)) & "." & SafeLong(Mid(digits, 2, 2)) & ".0.9999"
                Case Else
                    ExtractVersionFromName = ""
            End Select
        End If
    End If
    Err.Clear
    On Error GoTo 0
End Function

' 把正则 Match 对象构造成内部版本串，规则见 ExtractVersionFromName 头部。
Function BuildVersionFromMatch(m)
    Dim major, minor, patch, prerelease, prereleaseNum, rank
    major         = m.SubMatches(0)
    minor         = m.SubMatches(1)
    patch         = m.SubMatches(2)
    prerelease    = m.SubMatches(3)
    prereleaseNum = m.SubMatches(4)
    rank = "9999"
    If prerelease <> "" Then
        Select Case LCase(prerelease)
            Case "dev": rank = "1"
            Case "a":   rank = "2"
            Case "b":   rank = "3"
            Case "rc":  rank = "4"
        End Select
    End If
    If patch = "" Then patch = "0"
    If prerelease <> "" And prereleaseNum <> "" Then
        BuildVersionFromMatch = SafeLong(major) & "." & SafeLong(minor) & "." & SafeLong(patch) & "." & rank & "." & SafeLong(prereleaseNum)
    Else
        BuildVersionFromMatch = SafeLong(major) & "." & SafeLong(minor) & "." & SafeLong(patch) & "." & rank
    End If
End Function

' ------------------------------------------------------------------
' Consider: 评估一个候选可执行文件
'
' version 参数是调用方从目录名/注册表键名猜到的版本，可为 ""。
' 处理流程：
'   1. 查缓存，命中直接用。
'   2. 版本为 "" 时进入探测。pythonw.exe 和 python.exe 会互相查缓存，
'      因为同目录两者必然同版本——先被扫描的一方负责探测，
'      后被扫描的一方直接命中缓存，每个目录最多一次进程启动。
'   3. pythonw.exe 探测失败时（gui 子系统拿不到 --version 输出），
'      主动去探测同目录 python.exe，而不是直接标 fallback。
'   4. 探测结果为空则记为 fallback（0.0.0.9999），
'      只有完全没有可用候选时才会被启用。
'
' 注意回填 python.exe 缓存时必须先 Exists 判断：
' python.exe 可能先被扫描且探测失败，缓存里已有它的 "0.0.0.9999"，
' 此时直接用 Add 会抛运行时错误 457。
' ------------------------------------------------------------------
Sub Consider(ByVal path, ByVal version)
    Dim probePath, altPath, altPathFs, cacheKey, isFallback, cmp, altVer
    On Error Resume Next
    Err.Clear

    cacheKey   = LCase(path)
    isFallback = False

    If g_probed.Exists(cacheKey) Then
        version = g_probed.Item(cacheKey)
        If version = "0.0.0.9999" Then
            isFallback = True
        End If

    ElseIf version = "" Then
        probePath = path

        If LCase(Right(probePath, 11)) = "pythonw.exe" Then
            ' pythonw.exe：优先借同目录 python.exe 的版本（-11 保留末尾反斜杠）。
            altPathFs = Left(probePath, Len(probePath) - 11) & "python.exe"
            altPath   = LCase(altPathFs)
            altVer    = ""
            If g_probed.Exists(altPath) Then
                altVer = g_probed.Item(altPath)
                If altVer = "0.0.0.9999" Then altVer = ""
            End If
            ' 缓存没有就主动探测 python.exe（可靠），而不是等 pythonw 自己吐版本。
            If altVer = "" And fso.FileExists(altPathFs) Then
                altVer = ProbePythonVersion(altPathFs)
                If altVer <> "" Then
                    If g_probed.Exists(altPath) Then
                        g_probed.Item(altPath) = altVer
                    Else
                        g_probed.Add altPath, altVer
                    End If
                End If
            End If
            If altVer <> "" Then
                version = altVer
            Else
                version = ProbePythonVersion(probePath)
            End If
            If version = "" Then
                isFallback = True
                version = "0.0.0.9999"
            End If
        Else
            ' python.exe：优先借同目录 pythonw.exe 的缓存（-10 保留末尾反斜杠）。
            ' python.exe 自己能正常输出 --version，不需要主动探测 pythonw。
            altPath = LCase(Left(probePath, Len(probePath) - 10) & "pythonw.exe")
            altVer  = ""
            If g_probed.Exists(altPath) Then
                altVer = g_probed.Item(altPath)
                If altVer = "0.0.0.9999" Then altVer = ""
            End If
            If altVer <> "" Then
                version = altVer
            Else
                version = ProbePythonVersion(probePath)
            End If
            If version = "" Then
                isFallback = True
                version = "0.0.0.9999"
            End If
        End If

        g_probed.Add cacheKey, version
    Else
        g_probed.Add cacheKey, version
    End If

    If isFallback Then
        If g_fallbackPy = "" Then
            g_fallbackPy  = path
            g_fallbackVer = version
        End If
        Err.Clear
        On Error Resume Next
        Exit Sub
    End If

    If bestPython = "" Then
        bestPython     = path
        bestVersion    = version
    Else
        cmp = CompareVersions(version, bestVersion)
        If cmp > 0 Then
            bestPython  = path
            bestVersion = version
        ElseIf cmp = 0 Then
            ' 同版本时优先 pythonw.exe（不弹控制台）。
            If LCase(Right(path, 11)) = "pythonw.exe" And _
               LCase(Right(bestPython, 11)) <> "pythonw.exe" Then
                bestPython  = path
                bestVersion = version
            End If
        End If
    End If

    Err.Clear
    On Error Resume Next
End Sub

' ------------------------------------------------------------------
' ProbePythonVersion
'   通过 `--version` 或文件资源获取 Python 版本，返回内部版本串或 ""。
'
'   关键点：pythonw.exe 是 GUI 子系统程序，stdout 不连接到重定向句柄，
'   所以 "pythonw.exe --version > file" 拿到的文件是空的。
'   传入 pythonw.exe 时自动切换到同目录 python.exe 探测。
'
'   文本探测失败时回退到读 PE 资源里的 FILEVERSION，
'   只取前两段（Python 的 FILEVERSION 第三段是 build 号而非 patch 号）。
' ------------------------------------------------------------------
Function ProbePythonVersion(exePath)
    Dim cmdStr, output, ts, ver, fv, m2, probeTarget, siblingPy
    ProbePythonVersion = ""
    output = ""

    On Error Resume Next
    Err.Clear

    probeTarget = exePath
    If LCase(Right(exePath, 11)) = "pythonw.exe" Then
        siblingPy = Left(exePath, Len(exePath) - 11) & "python.exe"
        If fso.FileExists(siblingPy) Then
            probeTarget = siblingPy
        End If
    End If

    cmdStr = "cmd /c """ & """" & probeTarget & """ --version >""" & g_tmpFile & """ 2>&1"""
    sh.Run cmdStr, 0, True

    If fso.FileExists(g_tmpFile) Then
        Err.Clear
        Set ts = fso.OpenTextFile(g_tmpFile, 1, False, 0)
        If Err.Number = 0 Then
            output = ts.ReadAll
            ts.Close
        End If
        Err.Clear
        fso.DeleteFile g_tmpFile, True
    End If

    On Error Resume Next
    Err.Clear
    ver = ParseVersionFromText(output)

    ' ParseVersionFromText 末尾的 On Error GoTo 0 会清掉本过程的保护，
    ' 这里重新武装，确保下面 GetFileVersion 回退路径安全。
    On Error Resume Next
    Err.Clear
    If ver = "" And fso.FileExists(exePath) Then
        Err.Clear
        fv = fso.GetFileVersion(exePath)
        If Err.Number = 0 And fv <> "" Then
            g_re.Pattern = "^(\d+)\.(\d+)"
            Set m2 = g_re.Execute(fv)
            If IsObject(m2) Then
                If m2.Count > 0 Then
                    ver = SafeLong(m2(0).SubMatches(0)) & "." & _
                          SafeLong(m2(0).SubMatches(1)) & ".0.9999"
                End If
            End If
        End If
    End If

    Err.Clear
    On Error Resume Next
    ProbePythonVersion = ver
End Function

' 从 `Python 3.11.5` / `Python 3.13.0rc1` 等文本中提取版本号。
Function ParseVersionFromText(text)
    Dim matches, major, minor, patch, pre, preNum, rank
    ParseVersionFromText = ""
    If text = "" Then Exit Function

    On Error Resume Next
    Err.Clear
    g_re.Pattern = "Python\s+(\d+)\.(\d+)\.(\d+)(?:(a|b|rc|dev)(\d+))?"
    Set matches = g_re.Execute(text)
    If Err.Number <> 0 Or Not IsObject(matches) Then
        Err.Clear
        On Error GoTo 0
        Exit Function
    End If
    If matches.Count > 0 Then
        major  = matches(0).SubMatches(0)
        minor  = matches(0).SubMatches(1)
        patch  = matches(0).SubMatches(2)
        pre    = matches(0).SubMatches(3)
        preNum = matches(0).SubMatches(4)
        rank   = "9999"
        If pre <> "" Then
            Select Case LCase(pre)
                Case "dev": rank = "1"
                Case "a":   rank = "2"
                Case "b":   rank = "3"
                Case "rc":  rank = "4"
            End Select
        End If
        If pre <> "" And preNum <> "" Then
            ParseVersionFromText = SafeLong(major) & "." & SafeLong(minor) & "." & SafeLong(patch) & "." & rank & "." & SafeLong(preNum)
        Else
            ParseVersionFromText = SafeLong(major) & "." & SafeLong(minor) & "." & SafeLong(patch) & "." & rank
        End If
    End If
    Err.Clear
    On Error GoTo 0
End Function

' 把字符串安全地转为 Long，失败返回 0（避免 VBS 抛错中断）。
Function SafeLong(s)
    Dim v
    On Error Resume Next
    Err.Clear
    v = CLng(s)
    If Err.Number <> 0 Then v = 0 : Err.Clear
    On Error GoTo 0
    SafeLong = v
End Function

Function IsPureDigits(s)
    Dim i, ch
    If s = "" Then IsPureDigits = False : Exit Function
    For i = 1 To Len(s)
        ch = Mid(s, i, 1)
        If ch < "0" Or ch > "9" Then IsPureDigits = False : Exit Function
    Next
    IsPureDigits = True
End Function

' 按内部版本串逐段比较。非数字段按 0 处理，缺少的段补齐为 0。
Function CompareVersions(v1, v2)
    Dim a, b, i, maxLen, n1, n2
    a = Split(v1, ".")
    b = Split(v2, ".")
    maxLen = UBound(a)
    If UBound(b) > maxLen Then maxLen = UBound(b)
    For i = 0 To maxLen
        n1 = 0 : n2 = 0
        If i <= UBound(a) Then If IsPureDigits(a(i)) Then n1 = SafeLong(a(i))
        If i <= UBound(b) Then If IsPureDigits(b(i)) Then n2 = SafeLong(b(i))
        If n1 > n2 Then CompareVersions = 1 : Exit Function
        If n1 < n2 Then CompareVersions = -1 : Exit Function
    Next
    CompareVersions = 0
End Function

' 在 dirPath 下检查 pythonw.exe / python.exe 并交给 Consider。
' 优先 pythonw.exe（GUI 启动不弹控制台）。
Sub AddIfPythonExe(dirPath, dirName)
    Dim candidate, ver
    On Error Resume Next
    Err.Clear

    candidate = dirPath & "\pythonw.exe"
    If fso.FileExists(candidate) Then
        If NameContainsPython(dirName) Then
            ver = ExtractVersionFromName(dirName)
        Else
            ver = ""
        End If
        Consider candidate, ver
    Else
        candidate = dirPath & "\python.exe"
        If fso.FileExists(candidate) Then
            If NameContainsPython(dirName) Then
                ver = ExtractVersionFromName(dirName)
            Else
                ver = ""
            End If
            Consider candidate, ver
        End If
    End If

    Err.Clear
    On Error Resume Next
End Sub

' ============================================================
' 扫描入口
' ============================================================

' 扫描注册表 SOFTWARE\Python\PythonCore 下的所有版本。
' 官方安装器会在这里写 InstallPath；部分版本还提供 ExecutablePath。
Sub ScanRegistry(hive, keyPath)
    Dim regProv, subKeys, ret
    Dim versionKey, ver, installPath, exePath, candidate

    On Error Resume Next
    Err.Clear
    Set regProv = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
    If Err.Number <> 0 Then
        Err.Clear : On Error GoTo 0 : Exit Sub
    End If

    ret = regProv.EnumKey(hive, keyPath, subKeys)
    If ret <> 0 Or Not IsArray(subKeys) Then
        Err.Clear : On Error GoTo 0 : Exit Sub
    End If

    For Each versionKey In subKeys
        ver = ExtractVersionFromName(versionKey)

        Err.Clear
        installPath = ""
        ret = regProv.GetStringValue(hive, keyPath & "\" & versionKey & "\InstallPath", "", installPath)
        If ret = 0 And installPath <> "" Then
            installPath = Trim(installPath)
            If Right(installPath, 1) = "\" Then installPath = Left(installPath, Len(installPath) - 1)
            candidate = installPath & "\pythonw.exe"
            If fso.FileExists(candidate) Then
                Consider candidate, ver
            Else
                candidate = installPath & "\python.exe"
                If fso.FileExists(candidate) Then Consider candidate, ver
            End If
        End If

        Err.Clear
        exePath = ""
        ret = regProv.GetStringValue(hive, keyPath & "\" & versionKey & "\InstallPath", "ExecutablePath", exePath)
        If ret = 0 And exePath <> "" Then
            exePath = Trim(exePath)
            If fso.FileExists(exePath) Then Consider exePath, ver
        End If
        Err.Clear
    Next
    Err.Clear : On Error GoTo 0
End Sub

' 扫描常见的 Python 安装根目录。两层深度：
'   第一层是 Python 安装根（如 ...\Programs\Python\Python311）
'   第二层是根下再套一层的结构（如 C:\Python\3.11.5\）
' %ProgramFiles% 只扫名字里含 "python" 的子目录，避免全盘遍历。
Sub ScanStandardDirs()
    Dim roots, root, entries, parts, dirPath, dirName, i, j
    Dim innerEntries, pfDirs, pf

    roots = Array( _
        sh.ExpandEnvironmentStrings("%LOCALAPPDATA%\Programs\Python"), _
        sh.ExpandEnvironmentStrings("%ProgramFiles%\Python"), _
        sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%\Python"), _
        "C:\Python" _
    )
    For Each root In roots
        If fso.FolderExists(root) Then
            entries = CollectSubFolders(root)
            For i = 0 To UBound(entries)
                If entries(i) <> "" Then
                    parts   = Split(entries(i), "|")
                    dirPath = parts(0)
                    dirName = parts(1)
                    AddIfPythonExe dirPath, dirName
                    If NameContainsPython(dirName) Then
                        innerEntries = CollectSubFolders(dirPath)
                        For j = 0 To UBound(innerEntries)
                            If innerEntries(j) <> "" Then
                                parts   = Split(innerEntries(j), "|")
                                dirPath = parts(0)
                                dirName = parts(1)
                                AddIfPythonExe dirPath, dirName
                            End If
                        Next
                    End If
                End If
            Next
        End If
    Next

    pfDirs = Array( _
        sh.ExpandEnvironmentStrings("%ProgramFiles%"), _
        sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%") _
    )
    For Each pf In pfDirs
        If fso.FolderExists(pf) Then
            entries = CollectSubFolders(pf)
            For i = 0 To UBound(entries)
                If entries(i) <> "" Then
                    parts   = Split(entries(i), "|")
                    dirPath = parts(0)
                    dirName = parts(1)
                    If NameContainsPython(dirName) Then AddIfPythonExe dirPath, dirName
                End If
            Next
        End If
    Next
End Sub

' pyenv-win：版本目录位于 %USERPROFILE%\.pyenv\pyenv-win\versions 下。
Sub ScanPyenvWin()
    Dim root, entries, parts, i
    root = sh.ExpandEnvironmentStrings("%USERPROFILE%\.pyenv\pyenv-win\versions")
    If Not fso.FolderExists(root) Then Exit Sub
    entries = CollectSubFolders(root)
    For i = 0 To UBound(entries)
        If entries(i) <> "" Then
            parts = Split(entries(i), "|")
            AddIfPythonExe parts(0), parts(1)
        End If
    Next
End Sub

' 扫描 Anaconda/Miniconda 的安装根和 envs 目录。
Sub ScanConda()
    Dim roots, root, envsRoot, entries, parts, i
    roots = Array( _
        sh.ExpandEnvironmentStrings("%USERPROFILE%\Anaconda3"), _
        sh.ExpandEnvironmentStrings("%USERPROFILE%\Anaconda2"), _
        sh.ExpandEnvironmentStrings("%USERPROFILE%\Miniconda3"), _
        sh.ExpandEnvironmentStrings("%USERPROFILE%\Miniconda2"), _
        sh.ExpandEnvironmentStrings("%ProgramData%\Anaconda3"), _
        sh.ExpandEnvironmentStrings("%ProgramData%\Anaconda2"), _
        sh.ExpandEnvironmentStrings("%ProgramData%\Miniconda3"), _
        sh.ExpandEnvironmentStrings("%ProgramData%\Miniconda2") _
    )
    For Each root In roots
        If fso.FolderExists(root) Then
            AddIfPythonExe root, fso.GetFileName(root)
            envsRoot = root & "\envs"
            If fso.FolderExists(envsRoot) Then
                entries = CollectSubFolders(envsRoot)
                For i = 0 To UBound(entries)
                    If entries(i) <> "" Then
                        parts = Split(entries(i), "|")
                        AddIfPythonExe parts(0), parts(1)
                    End If
                Next
            End If
        End If
    Next
    envsRoot = sh.ExpandEnvironmentStrings("%LOCALAPPDATA%\conda\conda\envs")
    If fso.FolderExists(envsRoot) Then
        entries = CollectSubFolders(envsRoot)
        For i = 0 To UBound(entries)
            If entries(i) <> "" Then
                parts = Split(entries(i), "|")
                AddIfPythonExe parts(0), parts(1)
            End If
        Next
    End If
End Sub

' uv 管理的 Python 安装。%UV_PYTHON_INSTALL_DIR% 是用户自定义覆盖路径。
Sub ScanUv()
    Dim root
    root = sh.ExpandEnvironmentStrings("%UV_PYTHON_INSTALL_DIR%")
    If root <> "%UV_PYTHON_INSTALL_DIR%" And fso.FolderExists(root) Then ScanUvRoot root
    ScanUvRoot sh.ExpandEnvironmentStrings("%APPDATA%\uv\python")
    ScanUvRoot sh.ExpandEnvironmentStrings("%APPDATA%\uv\data\python")
    ScanUvRoot sh.ExpandEnvironmentStrings("%LOCALAPPDATA%\uv\python")
    ScanUvRoot sh.ExpandEnvironmentStrings("%USERPROFILE%\.local\share\uv\python")
End Sub

Sub ScanUvRoot(root)
    Dim entries, parts, i
    If Not fso.FolderExists(root) Then Exit Sub
    entries = CollectSubFolders(root)
    For i = 0 To UBound(entries)
        If entries(i) <> "" Then
            parts = Split(entries(i), "|")
            AddIfPythonExe parts(0), parts(1)
        End If
    Next
End Sub

' 调用 py.exe -0p 列出所有已注册的解释器及其路径。
' 输出形如 " -V:3.11 *        C:\Users\...\python.exe"，用正则解析。
Sub ScanPyLauncher()
    Dim pyExe, tryPaths, tp, cmdStr
    Dim output, ts, re2, ms, mm, pyPath

    On Error Resume Next
    Err.Clear
    pyExe = ""
    tryPaths = Array( _
        sh.ExpandEnvironmentStrings("%LOCALAPPDATA%\Programs\Python\Launcher\py.exe"), _
        sh.ExpandEnvironmentStrings("%ProgramFiles%\Python\Launcher\py.exe"), _
        "C:\Windows\py.exe" _
    )
    For Each tp In tryPaths
        If fso.FileExists(CStr(tp)) Then pyExe = CStr(tp) : Exit For
    Next

    If pyExe = "" Then
        cmdStr = "cmd /c ""py.exe -0p >""" & g_tmpFile & """ 2>&1"""
    Else
        cmdStr = "cmd /c """ & """" & pyExe & """ -0p >""" & g_tmpFile & """ 2>&1"""
    End If

    sh.Run cmdStr, 0, True

    output = ""
    If fso.FileExists(g_tmpFile) Then
        Err.Clear
        Set ts = fso.OpenTextFile(g_tmpFile, 1, False, 0)
        If Err.Number = 0 Then
            output = ts.ReadAll
            ts.Close
        End If
        Err.Clear
        fso.DeleteFile g_tmpFile, True
    End If
    Err.Clear
    On Error GoTo 0

    If output = "" Then Exit Sub

    On Error Resume Next
    Err.Clear
    Set re2 = CreateObject("VBScript.RegExp")
    re2.IgnoreCase = True
    re2.Global = True
    ' 匹配 "版本号 ... 空白 ... 盘符路径" 格式。
    re2.Pattern = "(\d+\.\d+)[^\r\n]*?[ \t]+([A-Za-z]:\\[^\r\n]+)"
    Set ms = re2.Execute(output)
    If Err.Number = 0 And IsObject(ms) Then
        For Each mm In ms
            pyPath = Trim(mm.SubMatches(1))
            If fso.FileExists(pyPath) Then
                Consider pyPath, ExtractVersionFromName(mm.SubMatches(0))
            End If
        Next
    End If
    Err.Clear
    On Error GoTo 0
End Sub

' ------------------------------------------------------------------
' ScanPath: 遍历 %PATH%，查找其中的 pythonw.exe / python.exe。
'
' 边界处理：
'   - 跳过空项、"."、".."
'   - 剥离成对的首尾引号（%PATH% 里某些项带引号）
'   - 保留 pFull 给 FolderExists（C:\ 这种根目录不能去尾反斜杠）
'   - 去掉尾反斜杠的 p 用于 GetFileName / 路径拼接
'   - 跳过 WindowsApps：里面是 Microsoft Store 的 App Execution Alias
'     存根，调用会弹出商店。用 GetFileName 精确比对，避免误杀
'     D:\MyWindowsApps 这种名字相似的普通目录。
'
' 每轮循环开头重新 On Error Resume Next：
' Consider 内部可能重置错误处理，这里需要在每次访问 fso 前重新武装。
' ------------------------------------------------------------------
Sub ScanPath()
    Dim pathStr, parts, i, p, pFull, dirName
    On Error Resume Next
    Err.Clear

    pathStr = sh.ExpandEnvironmentStrings("%PATH%")
    If Err.Number <> 0 Or pathStr = "" Or pathStr = "%PATH%" Then
        Err.Clear : On Error GoTo 0 : Exit Sub
    End If

    parts = Split(pathStr, ";")
    For i = 0 To UBound(parts)

        On Error Resume Next

        p = Trim(parts(i))

        If Len(p) >= 2 Then
            If Left(p, 1) = """" And Right(p, 1) = """" Then
                p = Mid(p, 2, Len(p) - 2)
            End If
        End If

        pFull = p
        If Len(p) > 1 And Right(p, 1) = "\" Then
            p = Left(p, Len(p) - 1)
        End If

        If p <> "" And p <> "." And p <> ".." Then

            If LCase(fso.GetFileName(p)) = "windowsapps" Then
                ' 跳过 Microsoft Store 的 App Execution Alias 存根
            ElseIf fso.FolderExists(pFull) Then
                dirName = fso.GetFileName(p)
                If dirName = "" Then dirName = p     ' 盘符根：C:\ → "C:"
                AddIfPythonExe p, dirName
            End If

        End If
    Next

    Err.Clear
    On Error GoTo 0
End Sub