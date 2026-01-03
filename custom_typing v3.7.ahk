#Requires AutoHotkey v2.0
#Hotstring C
#SingleInstance Force
version := 3.7
Run "custom_typing_2.ahk"
; admin
^+r:: {
    MsgBox("Script is reloading...")
    Reload()
}
^+e::{
    ExitApp()
    RunWait('taskkill /IM ""AutoHotkey64.exe"" /FI ""WINDOWTITLE eq custom_typing_2.ahk"" /F')
    
}
; ctrl C

bloxd := 1
ships := 0
copy_prompt := 0
first_copy_prompt := 0
started := A_TickCount

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
    ;;; MsgBox(A_Clipboard)
    ;;; ToolTip(A_Clipboard)
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

;testing

;&gs_lcrp=EgZjaHJvbWUyDAgAEEUYORjJAxiABDIOCAEQRRgnGDsYgAQYigUyBggCECMYJzIGCAMQRRg7MgcIBBAAGIAEMgYIBRBFGDwyBggGEEUYPTIGCAcQRRg80gEHOTkwajBqN6gCALACAA&sourceid=chrome&ie=UTF-8
;&rlz=1C1CHBD_enCA1166CA1166&oq=what
;&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIMCAEQIxgnGIAEGIoFMgYIAhBFGDsyBggDEEUYOzIGCAQQIxgnMgYIBRBFGDwyBggGEEUYPDIGCAcQRRg80gEIMjUwM2owajeoAgCwAgA&sourceid=chrome&ie=UTF-8

; html / codings
::\div::<div class="">

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
</head>
<body>
    <div>
</div>
<script src=""></script>
</body>
</html>
)"
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

; wheel ----------------------------------------------------------------------


; 
; 全局配置
items := ["chess", "bloxd", "3", "4", "5", "6"]
itemCount := items.Length
radius := 120
deadZone := 15
currentIndex := 0
menuGui := ""
labels := []

; -------------------------------
!w::OpenRadialMenu()  ; Alt + W 打开

; -------------------------------
OpenRadialMenu() {
    global menuGui, centerX, centerY, labels

    MouseGetPos &centerX, &centerY

    menuGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    menuGui.BackColor := "1e1e1e"
    menuGui.SetFont("s10 cFFFFFF", "Segoe UI")

    labels := []
    DrawItems()

    menuGui.Show("x" centerX-radius " y" centerY-radius " w" radius*2 " h" radius*2)

    SetTimer(UpdateSelection, 5)

    Hotkey("Alt Up", Confirm, "On")  ; 松开 Alt 自动确认
    Hotkey("Esc", Cancel, "On")
}

; -------------------------------
DrawItems() {
    global items, itemCount, radius, menuGui, labels

    angleStep := 360 / itemCount
    Loop itemCount {
        angle := (A_Index-1)*angleStep - 90
        rad := angle * 0.0174533
        x := radius + Cos(rad)*(radius-30)
        y := radius + Sin(rad)*(radius-30)

        txt := menuGui.AddText(
            Format("x{} y{} Center w70 vItem{}", x-35, y-12, A_Index),
            items[A_Index]
        )
        labels.Push(txt)
    }
}

; -------------------------------
lastAngle := 0

UpdateSelection() {
    global centerX, centerY, currentIndex, itemCount, deadZone, labels, lastAngle

    MouseGetPos &mx, &my
    dx := mx - centerX
    dy := my - centerY

    dist := Sqrt(dx*dx + dy*dy)
    if dist < deadZone {
        Highlight(0)
        return
    }

    angle := Mod(DllCall("msvcrt\atan2", "double", dy, "double", dx, "double") * 57.2957795 + 450, 360)

    ; 如果鼠标角度变化太小，不切换
    if Abs(angle - lastAngle) < 5  ; 阈值可以调
        return

    lastAngle := angle
    index := Floor(angle / (360/itemCount)) + 1
    Highlight(index)
}

; -------------------------------
Highlight(index) {
    global currentIndex, labels

    if index = currentIndex
        return

    ; 恢复旧选中
    if currentIndex {
        AnimateColor(labels[currentIndex], 0x00FFAA, 0xFFFFFF)
        labels[currentIndex].SetFont("s10")
    }

    ; 新选中
    if index {
        AnimateColor(labels[index], 0xFFFFFF, 0x00FFAA)
        labels[index].SetFont("s13")
    }

    currentIndex := index
}

; -------------------------------
; 全局动画管理对象
animations := {list: [], running: false}

AnimateColor(ctrl, fromColor, toColor, duration := 120) {
    global animations
    start := A_TickCount
    animations.list.Push({ctrl: ctrl, from: fromColor, to: toColor, start: start, duration: duration})
    if !animations.running {
        animations.running := true
        SetTimer(UpdateAnimations, 16)
    }
}

UpdateAnimations(*) {
    global animations
    now := A_TickCount
    finished := []

    for i, anim in animations.list {
        t := (now - anim.start) / anim.duration
        if (t >= 1) {
            anim.ctrl.SetFont("c" anim.to)
            finished.Push(i)
        } else {
            anim.ctrl.SetFont("c" LerpColor(anim.from, anim.to, t))
        }
    }

    ; 删除完成的动画
    
    Loop finished.Length {
    idx := finished[finished.Length - A_Index + 1]
    animations.list.RemoveAt(idx)
    }
    ;easier understanding
    ;for i := finished.Length; i >= 1; i-- {
    ;animations.list.RemoveAt(finished[i])
    ;}


    ; 如果没有动画了，关闭定时器
    if animations.list.Length = 0 {
        SetTimer(UpdateAnimations, 0)
        animations.running := false
    }
}

LerpColor(c1, c2, t) {
    r1 := (c1 >> 16) & 0xFF
    g1 := (c1 >> 8) & 0xFF
    b1 := c1 & 0xFF

    r2 := (c2 >> 16) & 0xFF
    g2 := (c2 >> 8) & 0xFF
    b2 := c2 & 0xFF

    r := Round(r1 + (r2 - r1) * t)
    g := Round(g1 + (g2 - g1) * t)
    b := Round(b1 + (b2 - b1) * t)

    return Format("{:02X}{:02X}{:02X}", r, g, b)
}
; -------------------------------
Confirm(*) {
    global items, currentIndex
    CloseMenu()
    if currentIndex = 0
        return

    choice := items[currentIndex]

    switch choice {
        case "chess": Run "https://www.chess.com"
        case "bloxd": MsgBox "https://bloxd.io"
        case "3": MsgBox "3"
        case "4": MsgBox "4"
        case "5": MsgBox "5"
        case "6": MsgBox "6"
    }
}

; -------------------------------
Cancel(*) {
    CloseMenu()
}

; -------------------------------
CloseMenu() {
    global menuGui
    SetTimer(UpdateSelection, 0)
    Hotkey("Alt Up", "Off")
    menuGui.Destroy()
    menuGui := ""
}
#Hotstring C
; hotkstrings for typing ---------------------------------------------------
jsonText := FileRead("hotstrings.txt", "UTF-8")
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

filepath := "websites.txt"

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
    #Requires AutoHotkey v2.0

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
; gaming

;:*b0:\game::
;:*b0:\playgame::
;{
;    games_list := []
;
;; 1. Create the GUI object     \convert  
;    ConverterGui := Gui(, "Please choose a game")
;; 2. Add buttons (width, height, Text)
;; 'g' is replaced by .OnEvent("Click", ...) in v2
;    Btn1 := ConverterGui.Add("Button", "w150 h60", "Snakegame")
;    Btn2 := ConverterGui.Add("Button", "w150 h60", "Cloudconvert")
;    Btn3 := ConverterGui.Add("Button", "w150 h60", "Onlineconvert")
;    Btn4 := ConverterGui.Add("Button", "w150 h60", "Convertio")
;    Btn5 := ConverterGui.Add("Button", "w200 h80", "IDK, Random? ")
;; 3. Define what happens when clicked
;    Btn1.OnEvent("Click", (*) => Run("https://www.freeconvert.com/"))
;    Btn2.OnEvent("Click", (*) => Run("https://cloudconvert.com/"))
;    Btn3.OnEvent("Click", (*) => Run("https://www.online-convert.com/"))
;    Btn4.OnEvent("Click", (*) => Run("https://convertio.co/"))
;    Btn5.OnEvent("Click", (*) => (
;        index := Random(1, converter_list.Length),
;        Run(converter_list[index])
;    ))
;; 4. Show the window    
;    ConverterGui.Show()
;
;; 5. Handle closing the window
;    ConverterGui.OnEvent("Close", (*) => Exit())
;
;}

; simple version ---------
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

; typing helper
:: i ::I   ;i --> I 
; turns out it cant detect "enter" in hotstring :(

; part 2 --> due to too much code
;Run "custom typing 2 v3.6.ahk"
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
        WinClose("dc_detector.exe")
        return
    }

    Run("dc_detector.exe")  ; 运行程序
}
