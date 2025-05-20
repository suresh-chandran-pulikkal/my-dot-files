#Requires AutoHotkey v2.0

*CapsLock:: {
    start_time := A_TickCount
    Send("{Ctrl Down}")
    KeyWait("CapsLock")
    if (A_TickCount - start_time < 200) {
        Send("{Ctrl Up}")
        SetCapsLockState(!GetKeyState("CapsLock", "T"))  ; Toggle CapsLock
    }
    else {
        Send("{Ctrl Up}")
    }
}
