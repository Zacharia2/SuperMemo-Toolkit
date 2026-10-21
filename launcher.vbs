Option Explicit
Dim fso, sh, scriptDir, scriptPath, pythonExe, envRoot, folder, latestVer
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh  = CreateObject("WScript.Shell")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
scriptPath = scriptDir & "\launcher.pyw"

If Not fso.FileExists(scriptPath) Then
    MsgBox "Script not found: " & scriptPath, 16, "Error"
    WScript.Quit 1
End If

pythonExe = ""
latestVer = ""

' 策略：通过 UV_PYTHON_INSTALL_DIR 遍历寻找最高版本的 cpython
envRoot = sh.ExpandEnvironmentStrings("%UV_PYTHON_INSTALL_DIR%")
If envRoot <> "%UV_PYTHON_INSTALL_DIR%" And fso.FolderExists(envRoot) Then
    For Each folder In fso.GetFolder(envRoot).SubFolders
        If LCase(Left(folder.Name, 7)) = "cpython" Then
            If fso.FileExists(folder.Path & "\pythonw.exe") Then
                ' 字典序比较，确保拿到 3.14 而不是 3.10
                If folder.Name > latestVer Then
                    latestVer = folder.Name
                    pythonExe = folder.Path & "\pythonw.exe"
                End If
            End If
        End If
    Next
End If

If pythonExe = "" Then
    MsgBox "Could not find pythonw.exe in " & envRoot, 16, "Error"
    WScript.Quit 1
End If

' 核心：0 代表隐藏窗口，False 代表不阻塞
sh.Run """" & pythonExe & """ """ & scriptPath & """", 0, False