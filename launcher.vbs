Option Explicit

Dim fso, sh, scriptDir, scriptPath
Dim bestPython, bestVersion
Dim g_re
Dim g_probed
Dim g_fallbackPy, g_fallbackVer
Dim g_tmpFile

Set fso = CreateObject("Scripting.FileSystemObject")
Set sh  = CreateObject("WScript.Shell")
Set g_probed = CreateObject("Scripting.Dictionary")
g_probed.CompareMode = 1  ' vbTextCompare

Set g_re = CreateObject("VBScript.RegExp")
g_re.IgnoreCase = True
g_re.Global = False

scriptDir  = fso.GetParentFolderName(WScript.ScriptFullName)
scriptPath = scriptDir & "\launcher.pyw"

If Not fso.FileExists(scriptPath) Then
    MsgBox "Script not found: " & scriptPath, 16, "Error"
    WScript.Quit 1
End If

bestPython     = ""
bestVersion    = ""
g_fallbackPy   = ""
g_fallbackVer  = ""

' [修复8] 临时文件加随机后缀，防止多实例并发冲突
' [区域设置] 同时替换 . 和 , 两种小数点符号
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
' [修复4-重做] 先剥离 python 前缀再跑主正则，防止 "python3.11.5"
'   在位置 7 的 "." 处错误匹配出 11.5.0.9999。
'   原始 s 只留给 pythonNNN 回退分支。
' [优化] 主正则 lookahead 加入 +，兼容 "3.11.5+20240101" 等目录名
' [清理] 移除已不再使用的局部变量
' ------------------------------------------------------------------
Function ExtractVersionFromName(name)
    Dim s, sMain, rest, matches, digits
    ExtractVersionFromName = ""
    If name = "" Then Exit Function
    s = LCase(name)

    ' 先剥离 "python" 前缀：用 sMain 跑主正则，原始 s 留给回退分支
    sMain = s
    If Left(sMain, 6) = "python" Then
        rest = Mid(sMain, 7)
        If rest <> "" Then sMain = rest
    End If

    On Error Resume Next

    ' ---- 主正则：用剥离后的 sMain ----
    ' 验证:
    '   "python3.11.5" → sMain="3.11.5"  → ^命中 → 3.11.5.9999
    '   "python-3.11.5" → sMain="-3.11.5" → -命中 → 3.11.5.9999
    '   "Python312"     → sMain="312"     → 主正则失败 → 回退 python312 → 3.12.0.9999
    '   "cuda12.6"      → sMain="cuda12.6"(无python前缀) → 主正则失败 → 回退也失败 → ""
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

    ' ---- 回退：pythonNNN 格式，用原始 s ----
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

' 从正则 Match 对象构造版本号字符串
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
' Consider: 候选评估
' ------------------------------------------------------------------
Sub Consider(ByVal path, ByVal version)
    Dim probePath, altPath, cacheKey, isFallback, cmp, altVer
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
            altPath = LCase(Left(probePath, Len(probePath) - 11) & "python.exe")
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
        Else
            ' python.exe 是 10 个字符，减 10 保留末尾反斜杠
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
        On Error GoTo 0
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
            If LCase(Right(path, 11)) = "pythonw.exe" And _
               LCase(Right(bestPython, 11)) <> "pythonw.exe" Then
                bestPython  = path
                bestVersion = version
            End If
        End If
    End If

    Err.Clear
    On Error GoTo 0
End Sub

Function ProbePythonVersion(exePath)
    Dim cmdStr, output, ts, ver, fv, m2
    ProbePythonVersion = ""
    output = ""

    On Error Resume Next
    Err.Clear

    cmdStr = "cmd /c """ & """" & exePath & """ --version >""" & g_tmpFile & """ 2>&1"""
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

    ver = ParseVersionFromText(output)

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
    On Error GoTo 0
    ProbePythonVersion = ver
End Function

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
    On Error GoTo 0
End Sub

' ============================================================
' 扫描入口
' ============================================================

Sub ScanRegistry(hive, keyPath)
    Dim regProv, subKeys, ret, i
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
    ' py -0p 输出以空格对齐；匹配 "版本号...空白...驱动器路径" 格式
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
' ScanPath: 遍历 %PATH%，收集其中的 pythonw.exe / python.exe
'   - 跳过空项、"."、".."、成对引号、尾部反斜杠
'   - 跳过 WindowsApps（App Execution Alias 存根，探测会拉起商店）
'     [修复] 用 GetFileName 精确比对，避免误杀 D:\MyWindowsApps
'   - 每次迭代重新武装 On Error Resume Next，
'     抵消 Consider 末尾 On Error GoTo 0 的影响
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

        ' [修复] 每次迭代重新武装，防止上轮 Consider 的 On Error GoTo 0 残留
        On Error Resume Next

        p = Trim(parts(i))

        ' 剥成对的首尾引号
        If Len(p) >= 2 Then
            If Left(p, 1) = """" And Right(p, 1) = """" Then
                p = Mid(p, 2, Len(p) - 2)
            End If
        End If

        ' pFull 保留尾斜杠（供 FolderExists，兼容 C:\ 这种根）
        ' p     剥掉尾斜杠（供 GetFileName / AddIfPythonExe 拼接）
        pFull = p
        If Len(p) > 1 And Right(p, 1) = "\" Then
            p = Left(p, Len(p) - 1)
        End If

        If p <> "" And p <> "." And p <> ".." Then

            ' [修复3] 用 GetFileName 精确比对，
            '         D:\MyWindowsApps 不再被误跳
            If LCase(fso.GetFileName(p)) = "windowsapps" Then
                ' 跳过 Microsoft Store 的 App Execution Alias 存根
            ElseIf fso.FolderExists(pFull) Then
                dirName = fso.GetFileName(p)
                If dirName = "" Then dirName = p     ' 盘符根 fallback：C:\ → "C:"
                AddIfPythonExe p, dirName
            End If

        End If
    Next

    Err.Clear
    On Error GoTo 0
End Sub