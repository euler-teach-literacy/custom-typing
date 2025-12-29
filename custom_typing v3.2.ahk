#Requires AutoHotkey v2.0
#Hotstring C
;msgbox "running"

; admin:  press ctrl shift r to reload
^+r:: {
    MsgBox("Script is reloading...")
    Reload()
}

:*:\help::
{
    MsgBox "
    (
        You've typed help, 
        Please go to https://github.com/euler-teach-literacy/custom-typing/blob/main/README.md
    )"
}
; by fish -----------------------------------------------

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


; hotkeys for typing ---------------------------------------------------
; hotstring in hotstring
:*:\tup::👍
:*:\yes::✅
:*:\lol::🤣
:*:\:)::🙃
:*:\skull::💀
:*:\insane::🤪

; maths
:*:\pi::π
:*:\aleph::ℵ
:*:\infin::∞
:*:\int::∫
:*:\sigma::∑
:*:\cdot::·
:*:\div::÷
:*:\pm::±
:*:\mp::∓
:*:\sqrt::√
:*:\neq::≠
:*:\subset::⊆
:*:\belongto::∈
:*:\therefore::∴
:*:\because::∵
:*:\log::㏒
:*:\in::㏑
:*:\angle::∠
:*:\deg::°
:*:\^0::⁰
:*:\^1::¹
:*:\^2::²
:*:\^3::³
:*:\^4::⁴
:*:\^5::⁵
:*:\^6::⁶
:*:\^7::⁷
:*:\^8::⁸
:*:\^9::⁹
:*:\^^0::₀
:*:\^^1::₁
:*:\^^2::₂
:*:\^^3::₃
:*:\^^4::₄
:*:\^^5::₅
:*:\^^6::₆
:*:\^^7::₇
:*:\^^8::₈
:*:\^^9::₉
; notes
:*:\num1::①
:*:\num2::②
:*:\num3::③
:*:\num4::④
:*:\num5::⑤
:*:\num6::⑥
:*:\num7::⑦
:*:\num8::⑧
:*:\num9::⑨
:*:\num10::⑩

::\important::※

; Greek Alphabet============================================-
:*:\Alpha::Α
:*:\Beta::Β
:*:\Gamma::Γ
:*:\Delta::Δ
:*:\Epsilon::Ε
:*:\Zeta::Ζ
:*:\Eta::Η
:*:\Theta::Θ
:*:\Iota::Ι
:*:\Kappa::Κ
:*:\Lambda::Λ
:*:\Mu::Μ
:*:\Nu::Ν
:*:\Xi::Ξ
:*:\Omicron::Ο
:*:\Pi::Π
:*:\Rho::Ρ
:*:\Sigma::Σ
:*:\Tau::Τ
:*:\Upsilon::Υ
:*:\Phi::Φ
:*:\Chi::Χ
:*:\Psi::Ψ
:*:\Omega::Ω
; Greek Alphabet lowercases============================================-
:*:\alpha::α
:*:\beta::β
:*:\gamma::γ
:*:\delta::δ
:*:\epsilon::ε
:*:\zeta::ζ
:*:\eta::η
:*:\theta::θ
:*:\iota::ι
:*:\kappa::κ
:*:\lambda::λ
:*:\mu::μ
:*:\nu::ν
:*:\xi::ξ
:*:\omicron::ο
:*:\pi::π
:*:\rho::ρ
:*:\sigma::σ
:*:\tau::τ
:*:\upsilon::υ
:*:\phi::φ
:*:\chi::χ
:*:\psi::ψ
:*:\omega::ω

; literal=======================================================
:*:\mdash::—
:*:\ndash::–
:*:\hyphen::-
:*:\<<::《
:*:\>>::》
:*:\book[::《
:*:\book]::》

; arrows------------------------------
:*:\Upa2::⇑
:*:\upa::↑
:*:\Downa2::⇓
:*:\downa::↓
:*:\lefta::←
:*:\Lefta2::⇐
:*:\righta::→
:*:\Righta2::⇒
:*:\lra::↔
:*:\Lra2::⇔
:*:\uda::↕
:*:\Uda2::⇕
;......

; boxdrawing------------------------------
:*:\llcorner::└
:*:\lrcorner::┘
:*:\ulcorner::┌
:*:\urcorner::┐

; music------------------------------
:*:\sharp::♯
:*:\flat::♭
:*:\nat::♮
:*:\4note::♩
:*:\8note::♪
:*:\28note::♫
:*:\216note::♬
:*:\2note::𝅗𝅥
:*:\1note::𝅝
:*:\1rest::𝄻
:*:\2rest::𝄼
:*:\4rest::𝄽
:*:\8rest::𝄾
:*:\treble::𝄞
:*:\bass::𝄢
:*:\forte::𝆑
:*:\piano symbol::𝆏

; faces / emojis
#Hotstring C0
:*:\think::🤔
;  ::\:)::🙂
:*:\smile::🙂
:*:\angry::😡
:*:\skull::💀
:*:\cry::😭
:*:\lol::🤣
:*:\laugh::😄
:*:\:D::😄
:*:\sweat smile::😅
:*:\XD::😆
:*:\hmm::🤨
:*:\shock::😮
:*:\irony::🙃
:*:\worry::😧
:*:\crazy::🤪
:*:\vomit::🤮
:*:\nerd::🤓
:*:\whocares::🙄💅
:*:\poop::💩
:*:\fire::🔥
:*:\boom::💥
:*:\bomb::💣
:*:\sad::☹️
:*:\:(::☹️
:*:\scared::😱
:*:\lightning::⚡
:*:\painful::😣
:*:\sleepy::🥱
:*:\exploding head::🤯
:*:\swear::🤬
:*:\hot::🥵
:*:\cold::🥶
:*:\sunglass::😎
:*:\money::🤑
:*:\sick::😷
:*:\fever::🤒
:*:\injured::🤕
:*:\nausea::🤢
:*:\joker::🤡
:*:\lie::🤥
:*:\shh::🤫
:*:\alien::👽
:*:\skeleton::☠
:*:\monkey::🐵
:*:\tup::👍
:*:\tdown::👎
:*:\flex::💪
:*:\hehe::😁
:*:\wink::😉
:*:\shy::😊
;warmth?
:*:\exciting::🤩
:*:\shutup::🤐
:*:\relief::😌
:*:\toughout::😛
:*:\cowboy::🤠
:*:angel::😇
:*:\shy::🤭
:*:\Demon::👿
:*:\demon::😈
:*:\ghost::👻
:*:\partyface::🥳

; Animal heads ---------------------------
:*:\cathead::🐱
:*:\catlaugh::😺
:*:\catsmile::😸
:*:\catlol::😹
:*:\catlove::😻
:*:\catevillaugh::😼
:*:\catkiss::😽
:*:\catscared::🙀
:*:\catcry::😿
:*:\catangry::😾
:*:\monkeyeyes::🙈
:*:\monkeyears::🙉
:*:\monkeymouth::🙊
:*:\doghead::🐶
:*:\wolfhead::🐺
:*:\lionhead::🦁
:*:\tigerhead::🐯
:*:\deerhead::🦒
:*:\foxhead::🦊
:*:\raccoonhead::🦝
:*:\cowhead::🐮
:*:\pighead::🐷
:*:\wildboarhead::🐗
:*:\rathead::🐭
:*:\mousehead::🐭
:*:\hamsterhead::🐹
:*:\rabithead::🐰
:*:\bearhead::🐻
:*:\koalahead::🐨
:*:\pandahead::🐼
:*:\froghead::🐸
:*:\zebrahead::🦓
:*:\horsehead::🐴
:*:\unicornhead::🦄
:*:\chickenhead::🐔
:*:\dragenhead::🐲
:*:\pignose::🐽
; animals
:*:\petfootprint::🐾
:*:\monkeysit::🐒
:*:\chimpanzee::🦍
:*:\orangutan::🦧
:*:\dogyellow::🦮
:*:\dogorange::🐕‍🦺
:*:\poodle::🐩
:*:\dog::🐕
:*:\cat::🐈
:*:\tiger::🐅
:*:\bobcat::🐆
:*:\horse::🐎
:*:\deer::🦌
:*:\rhino::🦏
; other emojis
:*:\soccer::⚽
:*:\volleball::🏐
:*:\basketball::🏀
:*:\diamond::💎
:*:\football::🏈
:*:\dice::🎲
:*:\saxophone::🎷
:*:\trumpet::🎺
:*:\guitar::🎸
:*:\violin::🎻
:*:piano::🎹
:*:\drum::🥁
:*:\postal horn::📯
:*:\postalhorn::📯

;*weather, transportation
:*:\water::💧
:*:\snow::❄

#Hotstring C
; other ----------------------------
:*:\cel::℃
:*:\fah::℉
:*:\m^2::㎡
:*:\pound::£
:*:\islam::☪
:*:\communism::☭
:*:\radioactive::☢
:*:\biohazard::☣
:*:\warn::⚠

; space
:*:\earth::♁
:*:\mercury::☿
:*:\moon::🌚

; chess
:*:\Wking::♚
:*:\Bking::♔
:*:\Wqueen::♛
:*:\Bqueen::♕
:*:\Wrook::♜
:*:\Brook::♖
:*:\Wpawn::♟
:*:\Bpawn::♙
:*:\Wknight::♞
:*:\Bknight::♘
:*:\Wbishop::♝
:*:\Bbishop::♗

; wtf r these genders
:*:\male::♂
:*:\female::♀
:*:\heterosexual::⚤
:*:\trans::⚧
:*:\lesbian::⚢
:*:\gay::⚣
:*:\bigender::⚥
:*:\trans1::⚨
:*:\trans2::⚦
:*:\trans3::⚩

; shapes
:*:\star::★
:*:\4star::✦
:*:\heart::❤

; symbols
:*:\Upsidedownqmark::¿
:*:\checkmark::✔
:*:\crossmark::✗
:*:\Checkmark::✅
:*:\Crossmark::❌
:*:\flag::⚑
:*:\qmark::❔
:*:\Qmark::❓
:*:\!!::‼

; emoticons
:*:\E fliptable::(╯‵□′)╯︵┻━┻
:*:\E shocked::(っ °Д °;)っ
:*:\E greeting::（￣︶￣）↗
:*:\E slaphead::(ノへ￣、)
:*:\E angry::(╬▔皿▔)╯
:*:\nonsense::~%?…,# *'☆&℃$︿★?
:*:\E wow::(★ ω ★)
:*:\E nervous::(っ °Д °;)っ
:*:\E idk::¯\(°_o)/¯
:*:\E catconfuse::(´･ω･`)?
:*:\E sleeping::(￣o￣) . z Z
:*:\E joyful::\(@^0^@)/
:*:\E glad::O(∩_∩)O
:*:\E money::( $ _ $ )

; 彩蛋
:*:\author::Made by - Salty Fish; Edited by - Euler
:*:\i wanna learn css::
{
    Run "https://euler-teach-literacy.github.io/My-first-web/"
}

; websites
::\ahk::
{
    Run "https://www.autohotkey.com/download/"
}
::\vscode::
{
    Run "https://code.visualstudio.com/download"
}
::\python::
{
    Run "https://www.python.org/downloads/"
}
::\kali::
{
    Run "https://www.kali.org/get-kali/#kali-platforms/"
}
::\oracle::
{
    Run "https://www.virtualbox.org/wiki/Downloads/"
}
::\Wiki ::   
{
    Run "https://en.wikipedia.org/wiki/"
}
::\chess::
{
    Run "https://chess.com/"
}
; remember to click "space" twice
::\bloxd::
{
    Run "https://www.bloxd.io/"
}
::\mc1.8::
{
    Run "https://eaglercraft.com/play/?version=1.8.8-wasm"
}
:b0:\github::
:b0:\git::
{
    Run "https://github.com/"
}
::\pornhub::
{
    Run "https://www.pornhub.com"
}
::\youtube::
{
    Run "https://youtube.com"
}
::\bilibili::
{
    Run "https://bilibili.com"
}
::\amazon::
{
    Run "https://amazon.com"
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


; -------------------------------
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

; click to scroll ---------------------------------
toggle := false
db_toggle := false  ; multi click
lastAltTime := 0

~LAlt::{
    global lastAltTime, db_toggle
    currentTime := A_TickCount

    if (currentTime - lastAltTime < 300) {
        db_toggle := !db_toggle
        ToolTip("Toggle is now " . (db_toggle ? "ON" : "OFF"))
        SetTimer(RemoveToolTip, -1000)
        lastAltTime := 0
    } else {
        lastAltTime := currentTime
    }
}

+!F2::{  ; Shift + Alt + F2 toggles on/off
    global toggle
    toggle := !toggle
    ToolTip("Toggle: " . toggle )
    SetTimer(RemoveToolTip, -1000)
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
        click ("Right")
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

RemoveToolTip() {
    ToolTip()
}
