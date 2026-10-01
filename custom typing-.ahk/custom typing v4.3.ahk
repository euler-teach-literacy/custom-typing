#Requires AutoHotkey v2.0
#Hotstring C
#SingleInstance Force
global version := "4.3"
menutoggle := 0
global first_copy_prompt := 0
global started := A_TickCount
global toggle := false

; admin
^+r:: {
    MsgBox("Script is reloading...")
    Reload()
}
^+e::{
    MsgBox("Thank you for using CUSTOMTYPING" . version . " by RandomEuler and SaltyFish")
    ExitApp()
}
escholdtime := 0

eschold() {
    global escholdtime
    escholdtime += 1
    if escholdtime == 300
        ToolTip "script off in 2 sec"
    if escholdtime == 450
        ToolTip()
    if escholdtime == 500
        MsgBox("Thank you for using CUSTOMTYPING" . version . "by RandomEuler and SaltyFish")
        ExitApp
}

~Esc:: SetTimer eschold, 10, 2147483647
~Esc up:: {
    global escholdtime
    SetTimer eschold, 0
    escholdtime := 0
    ToolTip()
}
; music


#Requires AutoHotkey v2.0

global player := ComObject("WMPlayer.OCX")
global musicStage := 1

; =========================  music

PlayFile(file, volume := 100) {
    global player

    player.URL := A_ScriptDir "\" file
    player.settings.volume := volume
    player.controls.play()
}

; 随机音乐
; =========================

play_music() {
    music_num := Random(1, 7)

    switch music_num {
        case 1:
            PlayFile("attached_files\resources\1.mp3")
        default:
            PlayFile("attached_files\resources\1.mp3")
    }
}

; 10min 音乐
; =========================

play_999() {
    global player

    player.URL := A_ScriptDir "\attached_files\resources\999.mp3"

    player.settings.volume := 0
    player.controls.play()

    ; 5 秒淡入
    Loop 50 {
        player.settings.volume := A_Index * 2
        Sleep 100
    }
}

; 5:00
; =========================

Start999() {
    global player, musicStage

    musicStage := 2

    ; 当前音乐淡出
    Loop 50 {
        player.settings.volume := 100 - (A_Index * 2)
        Sleep 100
    }

    ; 停止当前音乐
    player.controls.stop()

    ; 播放 999
    play_999()
}

; 10:00
; =========================

TenMinutes() {
    global player, musicStage

    musicStage := 3

    ; 停止 999
    

    ; 提示
    ToolTip("You've been using Custom Typing for 10 mins!!") 
    sleep 1000
    HideToolTip()

    Sleep 200000
    player.controls.stop()
    ; 开始随机音乐
    play_music()

    ; 检查歌曲是否结束
    SetTimer(CheckMusic, 1000)
}

; 检查随机歌曲是否结束
; =========================

CheckMusic() {
    global player, musicStage

    if player.playState = 1 {

        if musicStage = 1 {
            ; 5分钟前
            play_music()
        }

        else if musicStage = 3 {
            ; 10分钟以后
            play_music()
        }
    }
}


; 开始
; =========================

SoundSetVolume(12)

; 0:00
play_music()
SetTimer(CheckMusic, 1000)
; 4:55 开始执行
SetTimer(Start999, -295000)

; 10:00
SetTimer(TenMinutes, -600000)


; ctrl C

bloxd := 1
ships := 0
copy_prompt := 0

#HotIf A_TickCount - started >= 100

HideToolTip() {
    ; global copy_prompt
    global first_copy_prompt
    ToolTip()
    first_copy_prompt := 0
    ; copy_prompt := 0
}
~^c:: {
    ; global copy_prompt
    global first_copy_prompt

    Sleep 100
    clip := SubStr(A_Clipboard, 1, 200)
    if StrLen(A_Clipboard) > 200
        clip .= "..."
    ToolTip(clip)
    ; copy_prompt := 1
    first_copy_prompt := 1

    SetTimer(HideToolTip, -1000)
}

~^Alt:: {
    global first_copy_prompt
    ; global copy_prompt
    ; if copy_prompt {
    if not first_copy_prompt {
        ToolTip(A_Clipboard)
    }
    ; }
}
~Control Up:: {
    global first_copy_prompt

    if not first_copy_prompt {
        ToolTip()
    }
}

; faster coding
::\css::
{
   SendText "
(
color:
background-color:
text-align: center
font-size:
border: solid black 2px
border-radius: 13px
transition: 0.3s
padding: 10px
)"
}

::\html setup::
{
    SendText "
(
<!DOCTYPE html>
<html>
    <head>
    <title></title>
<link rel="stylesheet" href=""/>
)"
    Send "{Enter}"
    Send "{BackSpace}"
    SendText "
(
</head>
<body>
    <div>
</div>
<script src=""></script>
)"
    Send "{Enter}"
    Send "{BackSpace}"
    SendText "</body>"
    Send "{Enter}"
    Send "{BackSpace}"
    SendText "</html>"
}

::\py import::
{
    SendText "
(
import turtle as t
import tkinter as tk
import pygame
import math
import cmath
import numpy as np
import sys
import random
import json
import os
import re
import Flask
import Canva
)"
} 
:*:\version::{
    ;loop 6{
    ;    Send "{BackSpace}"
    ;}
    MsgBox ("current version: " . version)
}
; wheel --------------------------------------------------------------------
items := ["bloxd", "Two", "Three", "Four", "Five", "version"]
itemCount := items.Length
radius := 90
size := radius * 2 + 40

normalColor := "ffffff"
hoverColor  := "ff0000"

currentIndex := 0
controls := []
animations := { list: [], running: false }

;================ 热键 ================
!w::
{
    global menutoggle
    menutoggle := !menutoggle
    ; prevent menu spammingw
    KeyWait "w"

    MouseGetPos &mx, &my
    ShowMenu(mx, my)
}
#HotIf menutoggle = 1
~Alt Up::
{
    global currentIndex
    HideMenu()
    if currentIndex = 1{
        Run "https://bloxd.io"
    }
    else if currentIndex = 2{
        ;Run "attached_files\a.bat"
        MsgBox ("You chose 2")
    }
    else if currentIndex = 3{
        MsgBox ("you chose 3")
    }
    else if currentIndex = 4{
        MsgBox ("you chose 4")
    }
    else if currentIndex = 5{
        MsgBox ("you chose 5")
    }
    else if currentIndex = 6{
        MsgBox ("current version: " . version)
    }
    
}

;================ GUI ================
ShowMenu(mx, my) {
    global mygui, size
    mygui := Gui("+AlwaysOnTop -Caption +ToolWindow")
    mygui.BackColor := "202020"
    mygui.Show("NA x" (mx - size//2) " y" (my - size//2) " w" size " h" size)
    BuildItems()
    SetTimer(UpdateSelection, 10)
}

HideMenu() {
    SetTimer(UpdateSelection, 0)
    try mygui.Destroy()
}

;================ 构建圆盘 ================
BuildItems() {
    global mygui, controls, items, radius, size, normalColor
    controls := []
    step := 360 / items.Length

    Loop items.Length {
        ang := (A_Index - 1) * step
        rad := ang * 0.0174533
        x := size/2 + Cos(rad)*radius - 20
        y := size/2 - Sin(rad)*radius - 10
        ctrl := mygui.AddText("x" x " y" y " w40 Center c" normalColor, items[A_Index])
        controls.Push(ctrl)
    }
}

;================ 鼠标检测 ================
UpdateSelection() {
    global mygui, size, itemCount, currentIndex

    MouseGetPos &mx, &my
    WinGetPos &gx, &gy,,, mygui.Hwnd

    cx := gx + size/2
    cy := gy + size/2

    dx := mx - cx
    dy := cy - my    ; 屏幕 → 数学坐标

    dist := Sqrt(dx*dx + dy*dy)
    if dist < 25 {
        SetHover(0)
        return
    }

    angle := Mod(
        DllCall("msvcrt\atan2", "double", dy, "double", dx, "double") * 57.2958 + 360,
        360
    )

    index := Floor(angle / (360 / itemCount)) + 1
    SetHover(index)
}

;================ 高亮控制 ================
SetHover(index) {
    global currentIndex, controls

    if index = currentIndex
        return

    if currentIndex > 0
        AnimateColor(controls[currentIndex], hoverColor, normalColor)

    currentIndex := index

    if currentIndex > 0
        AnimateColor(controls[currentIndex], normalColor, hoverColor)
}

;================ 动画系统 ================
AnimateColor(ctrl, from, to, duration := 150) {
    global animations
    animations.list.Push({
        ctrl: ctrl,
        from: from,
        to: to,
        start: A_TickCount,
        duration: duration
    })

    if !animations.running {
        animations.running := true
        SetTimer(UpdateAnimations, 16)
    }
}

UpdateAnimations() {
    global animations
    finished := []

    for i, anim in animations.list {
        t := (A_TickCount - anim.start) / anim.duration
        if t >= 1 {
            anim.ctrl.SetFont("c" anim.to)
            finished.Push(i)
        } else {
            anim.ctrl.SetFont("c" LerpColor(anim.from, anim.to, t))
        }
    }
    Loop finished.Length {
        idx := finished[finished.Length - A_Index + 1]
        animations.list.RemoveAt(idx)
    }
    ;for i := finished.Length; i >= 1; i-- {
    ;    animations.list.RemoveAt(finished[i])
    ;}

    if animations.list.Length = 0 {
        SetTimer(UpdateAnimations, 0)
        animations.running := false
    }
}
#HotIf
;================ 颜色插值 ================
LerpColor(c1, c2, t) {
    r1 := "0x" SubStr(c1,1,2)
    g1 := "0x" SubStr(c1,3,2)
    b1 := "0x" SubStr(c1,5,2)
    r2 := "0x" SubStr(c2,1,2)
    g2 := "0x" SubStr(c2,3,2)
    b2 := "0x" SubStr(c2,5,2)

    return Format("{:02X}{:02X}{:02X}"
        , Round(r1 + (r2-r1)*t)
        , Round(g1 + (g2-g1)*t)
        , Round(b1 + (b2-b1)*t))
}

#Hotstring C
; hotkstrings for typing ---------------------------------------------------
jsonText := FileRead("attached_files\resources\hotstrings.txt", "UTF-8")
emojiMap := LoadSimpleJsonObject(jsonText)

for trigger, output in emojiMap {
    Hotstring(":*:" trigger, output)
}

LoadSimpleJsonObject(text) {
    result := Map()
    for _, line in StrSplit(text, "`n") {
        if RegExMatch(line, '"(.+?)"\s*:\s*"(.+?)"', &m)
            result[m[1]] := m[2]
    }
    return result
}

filepath := "attached_files\resources\websites.txt"

for _, line in StrSplit(FileRead(filepath, "UTF-8"), "`n") {
    line := Trim(line)
    if (line = "" || SubStr(line, 1, 1) = ";")
        continue

    parts := StrSplit(line, "|")
    if (parts.Length < 2)
        continue

    trigger := Trim(parts[1])
    action  := Trim(parts[2])
    param   := (parts.Length >= 3) ? Trim(parts[3]) : ""

    ; 使用 CreateHotstring 闭包函数锁值
    CreateHotstring(trigger, action, param)
}

CreateHotstring(trigger, action, param) {
    Hotstring(":*O:" trigger, (*) => DoAction(action, param))
}

DoAction(action, param) {
    switch action {
        case "run":
            Run param
        case "msg":
            MsgBox param
        case "send":
            Send param
        default:
            MsgBox "未知动作：" action
    }
}

#Hotstring C0
; file converters
converter_list := ["https://www.freeconvert.com/", "https://cloudconvert.com/", "https://www.online-convert.com/", "https://convertio.co/"]
Converters(){
    global selected_converter
; 1. Create the GUI object     \convert  
    ConverterGui := Gui(, "Please choose one converter")
; 2. Add buttons (width, height, Text)
; 'g' is replaced by .OnEvent("Click", ...) in v2
    Btn1 := ConverterGui.Add("Button", "w150 h60", "Freeconvert")
    Btn2 := ConverterGui.Add("Button", "w150 h60", "Cloudconvert")
    Btn3 := ConverterGui.Add("Button", "w150 h60", "Onlineconvert")
    Btn4 := ConverterGui.Add("Button", "w150 h60", "Convertio")
    Btn5 := ConverterGui.Add("Button", "w200 h80", "IDK, Random? ")
; 3. Define what happens when clicked
    Btn1.OnEvent("Click", (*) => Run("https://www.freeconvert.com/"))
    Btn2.OnEvent("Click", (*) => Run("https://cloudconvert.com/"))
    Btn3.OnEvent("Click", (*) => Run("https://www.online-convert.com/"))
    Btn4.OnEvent("Click", (*) => Run("https://convertio.co/"))
    Btn5.OnEvent("Click", (*) => (
        index := Random(1, converter_list.Length),
        Run(converter_list[index])
    ))
; 4. Show the window    
    ConverterGui.Show()

; 5. Handle closing the window
    ConverterGui.OnEvent("Close", (*) => Exit())

}
:b0:\fileconvert::
:b0:\fileconverter::
:b0:\convert::
:b0:\converter::
{
    Converters()
}
;::\bongo::
;{
;    Run "bongocat.exe"
;}
::\wiki::
{
    result := InputBox("Enter search text:", "Wikipedia Search")

    ; 如果点了 Cancel
    if (result.Result = "Cancel")
        return

    text := result.Value
    if (text = "")
        return

    text := StrReplace(text, " ", "_")
    Run "https://en.wikipedia.org/wiki/" text
}

::\google::
{
    result := InputBox("What do you want to search in google", "google search")

    if (result.Result = "Cancel")
        Return
    
    text := StrReplace(text, "", "_")
    Run "https://www.google.com/search?q=" text "&oq=" text
}
; games
#Hotstring C0
::\game::
{
    game_list := ["crazygames", "poki", "bloxd", "dino"]

    ib := InputBox(
        "Please choose the game by typing name or number"
        . "`n1. " game_list[1]
        . "`n2. " game_list[2]
        . "`n3. " game_list[3]
        . "`n4. " game_list[4],
        "Game Selector"
    )

    if (ib.Result != "OK")
        return

    choice := ib.Value

    if (choice = "1" || choice = game_list[1])
        Run "https://www.crazygames.com/"
    else if (choice = "2" || choice = game_list[2])
        Run "https://poki.com/"
    else if (choice = "3" || choice = game_list[3])
        Run "https://bloxd.io/"
    else if (choice = "4" || choice = game_list[4])
        Run "chrome://dino/"
}

; \gam
#Hotstring C

; part 2 --> due to too much code
;Run "custom typing 2 v3.6.ahk"
; click to scroll --------------------------------- alt shift F2

db_toggle := false  ; multi click
; script_name := A_ScriptName . " - Visual Studio Code"
+!F2::  ; Shift + Alt + F2 toggles on/off
{
    global toggle
    toggle := !toggle
    ToolTip("Toggle "  toggle)
    SetTimer(ToolTip, -1000)
}
+!^a::  ; shift alt ctrl a => toggles on/off
{
    global toggle
    toggle := !toggle
    ToolTip("Toggle "  toggle)
    SetTimer(ToolTip, -1000)
}

#HotIf toggle ;^ GetKeyState("F2")
~LAlt::  ; Single Alt key press hotkeys
{
    global db_toggle
    db_toggle := !db_toggle
    ToolTip("Toggle is now " . db_toggle )
    SetTimer(ToolTip, -1000)
    ; MsgBox, doubled
}

WheelUp:: click("Right")

WheelDown:: {
    click
    if (db_toggle) {
        Click(, , , 30)
    }
}
LButton:: Send "{WheelUp}"
RButton:: {
    Send("{WheelDown}")
    if (db_toggle) {
        loop 3{
            Send("{WheelDown}")
            Sleep 40
        }
    }
}
MButton:: {
    Send("{LButton down}")
    KeyWait("{MButton}",)  ; Wait for button release
    Send ("{LButton up}")
}
#HotIf
; dc detective mode                         alt shift F3
detective_mode := false
+!F3:: {  ; Shift + Alt + F3
    global detective_mode
    detective_mode := !detective_mode

    ToolTip("Detective mode: " . detective_mode)  ; 显示状态
    SetTimer HideToolTip, -1000           ; 1秒后清除 ToolTip
    ; not tested
    if !detective_mode {
        ProcessClose("attached_files\dc_detector.exe")
        ToolTip("dc detective mode off")
        SetTimer(ToolTip, 200)
        return
    }
    ; not tested
    Run("attached_files\dc_detector.exe")  ; 运行程序
}
+!F1:: {
    MsgBox("starting spamming mode, press again later to activate")
    Run "attached_files\custom typing spamming.ahk"
}
; fancy font
+!F4:: {
    MsgBox "fancy font mode is on, press ctrl shift f to exit; ctrl shift c to change font"
    SetTimer(() => ToolTip(), -1000)
    Run "attached_files\fancy_fonts.ahk"
}

hwnd := 0
!`:: {
    global hwnd
    if not hwnd {
        hwnd := WinExist("A")
    }
    WinSetExStyle("^0x80", "ahk_id " hwnd)
    ; WinSetStyle("^0x10000000", "ahk_id " hwnd)
    if (WinGetExStyle("ahk_id " hwnd) & 0x80) {
        WinMinimize("ahk_id " hwnd)
    } else {
        WinWait("ahk_id " hwnd)
        WinMaximize("ahk_id " hwnd)
        hwnd := 0
    }
}

Calculated_screen_wid := A_ScreenWidth-300
global color := "FF0000"

ShowTextInCorner(text, raw_xPos, yPos) {
    myGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")

    bgColor := "123456"
    myGui.BackColor := bgColor
    WinSetTransColor(bgColor, myGui.Hwnd)

    myGui.SetFont("s12 w600 c" color, "Arial")
    myGui.SetFont("q5 c" color, "Segoe UI")
    myGui.Add("Text", "+BackgroundTrans", text)

    xPos := A_ScreenWidth - 300 - raw_xPos
    myGui.Show("x" xPos " y" yPos " NoActivate")

    ; 500ms 后自动销毁窗口，防止无限创建
    SetTimer(() => myGui.Destroy(), -500)
}

Random_color() {
    chars := "0123456789ABCDEF"
    result := ""

    Loop 6
        result .= SubStr(chars, Random(1, 16), 1)

    return result
}
BlendColor(c1, c2, t)
{
    r1 := "0x" SubStr(c1,1,2)
    g1 := "0x" SubStr(c1,3,2)
    b1 := "0x" SubStr(c1,5,2)

    r2 := "0x" SubStr(c2,1,2)
    g2 := "0x" SubStr(c2,3,2)
    b2 := "0x" SubStr(c2,5,2)

    r := Round(r1 + (r2-r1)*t)
    g := Round(g1 + (g2-g1)*t)
    b := Round(b1 + (b2-b1)*t)

    return Format("{:02X}{:02X}{:02X}", r,g,b)
}
loop_switch_color(){
    global color
    old := color
        new := Random_color()

        Loop 10
        {
            color := BlendColor(old, new, A_Index / 20)
            Show_watermark()
        }
}

Show_watermark() {
    global version
    
    ShowTextInCorner("Custom Typing v" version, -30, -10)
    ShowTextInCorner("by RandomEuler and SaltyFish", 20, 20)
}
global time := 0
cornor_timer(){
    global time
    time += 1
    
    minutes := Floor(time / 60)
    seconds := Mod(time, 60)

    timerText := Format("{:02}:{:02}", minutes, seconds)

    ShowTextInCorner(timerText, 1600, 20)
}
SetTimer(cornor_timer,1000)
SetTimer(loop_switch_color, 150)

; 彩蛋
;FileAppend("a", "attached_files\resources\tmp.txt")
;Run("attached_files\functions.py")
