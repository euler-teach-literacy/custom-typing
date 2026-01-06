#Requires AutoHotkey v2.0
#Hotstring C
#SingleInstance Force
version := "3.9.0"
; admin
^+r:: {
    MsgBox("Script is reloading...")
    Reload()
}
^+e::{
    ExitApp()
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

; html / codings
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
:*:\version::{
    MsgBox ("current version: " . version)
}
; wheel --------------------------------------------------------------------
items := ["bloxd", "Two", "Three", "Four", "Five", "version"]
itemCount := items.Length
radius := 90
size := radius * 2 + 40

normalColor := "AAAAAA"
hoverColor  := "4FC3F7"

currentIndex := 0
controls := []
animations := { list: [], running: false }

;================ 热键 ================
!w::
{
    MouseGetPos &mx, &my
    ShowMenu(mx, my)
}

~Alt Up::
{
    global currentIndex
    if currentIndex = 1{
        Run "https://bloxd.io"
    }
    else if currentIndex = 2{
        MsgBox ("you chose 2")
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
    HideMenu()
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
    dy := cy - my    ; 屏幕 → 数学坐标（关键）

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
jsonText := FileRead("resources/hotstrings.txt", "UTF-8")
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

filepath := "resources/websites.txt"

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

    ToolTip("Detective mode: " . detective_mode)  ; 显示状态
    SetTimer HideToolTip, -1000           ; 1秒后清除 ToolTip
    ; bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug
    if !detective_mode {
        WinClose("Attached_files/dc_detector.exe")
        return
    }
    ; bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug bug

    Run("Attached_files/dc_detector.exe")  ; 运行程序
}
+!F1:: {
    MsgBox("starting spamming mode, press again later to activate")
    Run "Attached_files/custom typing spamming.ahk"
}
; fancy font

+!F4:: {

    ToolTip("fancy font mode: " )
    SetTimer(() => ToolTip(), -1000)
    if FileExist("Attached_files/fancy_fonts.ahk"){
        Run "Attached_files/fancy_fonts.ahk"
    }
    else if FileExist("Attached_files/fancy_fonts.exe"){
        Run "Attached_files/fancy_fonts.exe"
    }
    else{
        MsgBox "File not found! Fancy font will not be working! "
    }

}
