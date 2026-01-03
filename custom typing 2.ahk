#Requires AutoHotkey v2.0 

^+r:: {
    MsgBox("Script is reloading...")
    Reload()
}
HideToolTip() {
    ToolTip()
}

+!F1::{
    Run "custom typing spamming.ahk"
}
; click to scroll --------------------------------- alt shift F2
toggle := false
db_toggle := false  ; multi click
lastAltTime := 0

~LAlt::{
    if !toggle{
        return
    }
    global lastAltTime, db_toggle
    currentTime := A_TickCount

    if (currentTime - lastAltTime < 300) {
        db_toggle := !db_toggle
        ToolTip("Toggle is now " . (db_toggle ? "ON" : "OFF"))
        SetTimer(HideToolTip, -1000)
        lastAltTime := 0
    } else {
        lastAltTime := currentTime
    }
}

+!F2::{  ; Shift + Alt + F2 toggles on/off
    global toggle
    toggle := !toggle
    ToolTip("Toggle: " . toggle )
    SetTimer(HideToolTip, -1000)
    
    if !toggle {
        toggle := false
        db_toggle := false
    }
return
}
WheelUp::{
    global toggle
    if (toggle) {
        Click ("Right")
    }
    else {
        Send "{WheelUp}"
    }
return
}

WheelDown::{
    global toggle
    if (toggle) {
        click()
        if (db_toggle) {
            loop 22
                Click()
        }
    }
    else {
        Send "{WheelDown}"
    }
return
}

LButton::{
    global toggle
    if (toggle){
        ; MsgBox, You left-clicked!
        Send "{WheelUp}"
    }
    else{
        ; Pass through the down event so dragging works
        Send "{LButton down}"
        KeyWait("LButton")  ; Wait for button release
        Send "{LButton up}"
    }
return
}

RButton::{
    global toggle
    if (toggle){
        ; MsgBox, You right-clicked!
        Send "{WheelDown}"
        }
    else {
        Send "{RButton down}"
        KeyWait("RButton")  ; Wait for button release
        Send "{RButton up}"
    }
return
}

MButton::{
    global toggle
    if (toggle){
        Send "{LButton down}"
        KeyWait("MButton")  ; Wait for button release
        Send "{LButton up}"   
    }
    else{
        ; Pass through the down event so dragging works
        Send "{MButton down}"
        KeyWait("MButton")  ; Wait for button release
        Send "{MButton up}"
    }
}
; dc detective mode                         alt shift F3
detective_mode := false
+!F3:: {  ; Shift + Alt + F3
    global detective_mode
    detective_mode := !detective_mode

    ToolTip("Spammode: " . detective_mode)  ; 显示状态
    SetTimer HideToolTip, -1000           ; 1秒后清除 ToolTip

    if !detective_mode {
        return
    }

    ;Run("dc_detector.exe")  ; 运行程序
}

F12::{
    ToolTip('testing')
    SetTimer HideToolTip, -1000
}

