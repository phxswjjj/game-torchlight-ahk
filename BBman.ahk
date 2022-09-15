AppTitle := "Torchlight: Infinite"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss

KeyQElcapedMSec := 9999
KeyWElcapedMSec := 9999
KeyEElcapedMSec := 9999
KeyRElcapedMSec := 9999
KeyAElcapedMSec := 9999

SetTimer, Counter, 100

SetTimer, LifeMonitor, 200

SetTimer, SendSkill, 100

Return

Counter:
    IfWinNotExist, ahk_id %UniqueID%
    {
        OutputDebug, [%CurrentDateTime%] Stopped
        ExitApp
    }
    KeyQElcapedMSec := Min(KeyQElcapedMSec + 100, 10000)
    KeyWElcapedMSec := Min(KeyWElcapedMSec + 100, 10000)
    KeyEElcapedMSec := Min(KeyEElcapedMSec + 100, 10000)
    KeyRElcapedMSec := Min(KeyRElcapedMSec + 100, 10000)
    KeyAElcapedMSec := Min(KeyAElcapedMSec + 100, 10000)
Return

LifeMonitor:
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }
    
    If Not GetKeyState("Capslock", "T")
    {
        Return
    }

    PixelSearch, Px, Py, 655, 880, 665, 900, 0x0729BF, 3, Fast
    if !ErrorLevel {
        Return
    }

    if KeyQElcapedMSec >= 5000
    {
        KeyQElcapedMSec := 0
        Send, q
        Sleep, 500
    }

Return

SendSkill:
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }
    
    If Not GetKeyState("Capslock", "T")
    {
        Return
    }

    If GetKeyState("VKC0", "P")
    {
        Send {LButton Down}
        Sleep, 100
        Send {LButton Up}
        Sleep, 200
    }

    if KeyEElcapedMSec >= 6000
    {
        KeyEElcapedMSec := 0
        Send, e
    }

    if KeyRElcapedMSec >= 6000
    {
        KeyRElcapedMSec := 0
        Send, r
    }

Return

~RButton up::
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }
    
    If Not GetKeyState("Capslock", "T")
    {
        Return
    }

    ; Send, e

Return

VKC0::LButton
Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp