#Requires AutoHotkey v2.0 

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
F1:: {          ;spam click
    global F1_toggle, spam_mode
    if !spam_mode
        return

    F1_toggle := !F1_toggle
    ToolTip("Spam Click: " . F1_toggle)
    SetTimer(HideToolTip, -1000)

    if F1_toggle
        SetTimer(SpamClick, 33) ;21cps
    else
        SetTimer(SpamClick, 0)
}
F2::{
    global F2_toggle, spam_mode
    if !spam_mode
    return

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
    if !spam_mode
        return

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
