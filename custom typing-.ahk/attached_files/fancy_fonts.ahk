#Requires AutoHotkey v2.0
#Hotstring C
;f
global choice := "original"
global fontMap := Map()
global font_file := ""

LoadSimpleJsonObject_font(text) {
    result := Map()
    for _, line in StrSplit(text, "`n", "`r") {
        if RegExMatch(line, '"(.+?)"\s*:\s*"(.+?)"', &m)
            result[m[1]] := m[2]
    }
    return result
}

read_file() {
    global fontMap
    Hotstring("Reset") ; 清空旧的 hotstring

    for trigger, output in fontMap {
        Hotstring(":*:" trigger, output)
    }
}

+^c:: {
    global choice, font_file, fontMap

    ib := InputBox(
        "Choose font:`n1 = original -- abcde`n2 = playwrite -- 𝓪𝓫𝓬𝓭𝓮`n3 = fraktur -- 𝔞𝔟𝔠𝔡𝔢",
        "Font Selector"
    )
    if ib.Result != "OK"
        return

    choice := ib.Value

    switch choice {
        case "1", "original":
            font_file := "resources\original.txt"
        case "2", "playwrite":
            font_file := "resources\playwrite.txt"
        case "3", "fraktur":
            font_file := "resources\fraktur.txt"
        default:
            MsgBox "Invalid choice!"
            return
    }

    try {
        font_Text := FileRead(font_file, "UTF-8")
    } catch {
        MsgBox "Failed to read " font_file
        return
    }

    fontMap := LoadSimpleJsonObject_font(font_Text)
    read_file()

    MsgBox "Font changed to: " font_file
}

+^f:: {
    ExitApp()
}
+^r::{
    Reload()
}
; abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ