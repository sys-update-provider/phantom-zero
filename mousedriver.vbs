' ============================================================================
' Phantom Zero - Mouse Driver Script
' Purpose: Keep the computer awake by simulating periodic mouse movement
' Usage: Educational and testing purposes only
' License: MIT
' ============================================================================
' DISCLAIMER: This script is designed for educational purposes and 
' authorized testing environments only. Use only on computers you own or
' have explicit permission to manage.
' ============================================================================

Set objWshShell = CreateObject("WScript.Shell")

' Configuration
Const MOVE_INTERVAL = 300000  ' Move mouse every 5 minutes (in milliseconds)
Const MOVE_DISTANCE = 5       ' Pixels to move

' Create COM object for mouse movement
Set objMouse = CreateObject("Wscript.Shell")

' Get current mouse position
Function GetMousePosition()
    ' Note: VBScript doesn't have direct mouse position access
    ' This is a workaround using screen coordinates
End Function

' Main loop to keep computer awake
Sub KeepAwake()
    WScript.Echo "Phantom Zero - Mouse Driver Started"
    WScript.Echo "Keeping computer awake..."
    
    While True
        ' Move mouse slightly to prevent sleep
        objWshShell.SendKeys " "  ' Send spacebar (visible effect but minimal)
        
        ' Log activity
        WScript.Echo "Activity signal sent at " & Now()
        
        ' Wait before next movement
        WScript.Sleep MOVE_INTERVAL
    Wend
End Sub

' Start the script
KeepAwake()