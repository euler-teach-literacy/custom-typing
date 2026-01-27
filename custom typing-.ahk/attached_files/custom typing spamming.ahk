#Requires AutoHotkey v2.0 
global speed
speed := 31
+^F1::{
    ExitApp()
}
HideToolTip() {
    ToolTip()
}
spam_mode := true
; spam mode                 Alt Shift F1
F1_toggle := false
F2_toggle := false
F3_toggle := false
SpamClick() {
    Click()
}
SpamPaste(){
    Send "^v"
}
+!F1:: {
    global spam_mode
    spam_mode := !spam_mode
    ToolTip("Spammode: " . spam_mode)
    SetTimer(HideToolTip, -1000)

}
#HotIf spam_mode
`:: {                 ; 按下 `
    global speed
    SetTimer(SpamClick, speed)   ; 开始连点
}
` up:: {              ; 松开 `
    SetTimer(SpamClick, 0)       ; 停止连点
}
F1:: {          ;spam click
    global F1_toggle, spam_mode, speed
    if !spam_mode
        return
    F1_toggle := !F1_toggle
    ToolTip("Spam Click: " . F1_toggle)
    SetTimer(HideToolTip, -1000)
    
    if F1_toggle{
        result := InputBox("Please enter a number: `n0 = by hand`n1 = 64.2cps`n10 = 62.8cps`n20 = 31.6cps`n30 = 32.3cps`n40 = 21.6cps`n50 = 16.2cps", "Custom speed")
        speed := result.Value
        ;if speed.Value = "" ^ speed.Value = 0
        ;    MsgBox "error! "
        ;    F1_toggle := false
        ;    return
        if result.Result = "OK"{
            SetTimer(SpamClick, speed) 
            ; 01 = 64.2 cps
            ; 10 = 62.8 cps
            ; 20 = 31.6 cps
            ; 25 = 32.0 cps
            ; 30 = 32.3 cps
            ; 31 = 32.0 cps
            ; 31.5 = 32 cps
            ; 31.9 = 32.2
            ; 32 = 23.4 cps
            ; 33 = 21.4 cps
            ; 35 = 21.6 cps
            ; 40 = 21.6 cps
            ; 50 = 16.2 cps
        } else{
            SetTimer(SpamClick, 0)
            F1_toggle := false
        }
    }else
        SetTimer(SpamClick, 0)
}
F2::{
    global F2_toggle, spam_mode

    F2_toggle := !F2_toggle
    ToolTip("Spam paste: " . F2_toggle)
    SetTimer(HideToolTip, -1000)

    if F2_toggle
        SetTimer(SpamPaste, 50)
    else
        SetTimer(SpamPaste, 0)
}

F3:: {
    global F3_toggle, spam_mode, spam_text

    F3_toggle := !F3_toggle
    ToolTip("Custom Spam: " . F3_toggle)
    SetTimer(HideToolTip, -1000)

    if F3_toggle {
        ib := InputBox("please input what you want to spam", "Input your text")
        if ib.Result != "OK"
            return
        spam_text := ib.Value
        SetTimer(CustomSpam, 50)
    } else {
        SetTimer(CustomSpam, 0)
    }
}

CustomSpam() {
    global spam_text
    Send spam_text
}
+^r::{
    MsgBox "reloading"
    Reload()
}
global F1_toggle, spam_mode
F4_toggle := false
F4::{
    global F4_toggle, spam_mode
    F4_toggle := !F4_toggle
    ToolTip("Spam Click: " . F4_toggle)
    SetTimer(HideToolTip, -1000)
    speed := InputBox("Enter the speed: `n20 = 31.6 cps`n25 = 32.0 cps`n30 = 32.3 cps`n35 = 21.6 cps`n40 = 21.6 cps`n50 = 16.2 cps", "Custom spamclick")
    if F4_toggle
        SetTimer(SpamClick, speed) 
        ; 20 = 31.6 cps
        ; 25 = 32.0 cps
        ; 30 = 32.3 cps
        ; 31 = 32.0 cps
        ; 31.5 = 32 cps
        ; 31.9 = 32.2
        ; 32 = 23.4 cps
        ; 33 = 21.4 cps
        ; 35 = 21.6 cps
        ; 40 = 21.6 cps
        ; 50 = 16.2 cps
    else
        SetTimer(SpamClick, 0)
}
