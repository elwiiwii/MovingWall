#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode, Input
CoordMode, Mouse, Screen
DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution)

Run, %A_Desktop%\MovingWall\StatCraft\statcraft18.p8
WinWaitActive, STATCRAFT18.P8 (PICO-8)
WinSetTitle, instance_18
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft17.p8
WinWaitActive, STATCRAFT17.P8 (PICO-8)
WinSetTitle, instance_17
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft16.p8
WinWaitActive, STATCRAFT16.P8 (PICO-8)
WinSetTitle, instance_16
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft15.p8
WinWaitActive, STATCRAFT15.P8 (PICO-8)
WinSetTitle, instance_15
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft14.p8
WinWaitActive, STATCRAFT14.P8 (PICO-8)
WinSetTitle, instance_14
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft13.p8
WinWaitActive, STATCRAFT13.P8 (PICO-8)
WinSetTitle, instance_13
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft12.p8
WinWaitActive, STATCRAFT12.P8 (PICO-8)
WinSetTitle, instance_12
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft11.p8
WinWaitActive, STATCRAFT11.P8 (PICO-8)
WinSetTitle, instance_11
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft10.p8
WinWaitActive, STATCRAFT10.P8 (PICO-8)
WinSetTitle, instance_10
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft9.p8
WinWaitActive, STATCRAFT9.P8 (PICO-8)
WinSetTitle, instance_9
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft8.p8
WinWaitActive, STATCRAFT8.P8 (PICO-8)
WinSetTitle, instance_8
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft7.p8
WinWaitActive, STATCRAFT7.P8 (PICO-8)
WinSetTitle, instance_7
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft6.p8
WinWaitActive, STATCRAFT6.P8 (PICO-8)
WinSetTitle, instance_6
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft5.p8
WinWaitActive, STATCRAFT5.P8 (PICO-8)
WinSetTitle, instance_5
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft4.p8
WinWaitActive, STATCRAFT4.P8 (PICO-8)
WinSetTitle, instance_4
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft3.p8
WinWaitActive, STATCRAFT3.P8 (PICO-8)
WinSetTitle, instance_3
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft2.p8
WinWaitActive, STATCRAFT2.P8 (PICO-8)
WinSetTitle, instance_2
;Sleep 1000
;Send {Esc}run{Enter}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft1.p8
WinWaitActive, STATCRAFT1.P8 (PICO-8)
WinSetTitle, instance__1
Sleep 1000
;Send {Esc}run{Enter}
ControlSend, ahk_parent, {Esc}, instance__1
ControlSend, ahk_parent, {Esc}, instance_2
ControlSend, ahk_parent, {Esc}, instance_3
ControlSend, ahk_parent, {Esc}, instance_4
ControlSend, ahk_parent, {Esc}, instance_5
ControlSend, ahk_parent, {Esc}, instance_6
ControlSend, ahk_parent, {Esc}, instance_7
ControlSend, ahk_parent, {Esc}, instance_8
ControlSend, ahk_parent, {Esc}, instance_9
ControlSend, ahk_parent, {Esc}, instance_10
ControlSend, ahk_parent, {Esc}, instance_11
ControlSend, ahk_parent, {Esc}, instance_12
ControlSend, ahk_parent, {Esc}, instance_13
ControlSend, ahk_parent, {Esc}, instance_14
ControlSend, ahk_parent, {Esc}, instance_15
ControlSend, ahk_parent, {Esc}, instance_16
ControlSend, ahk_parent, {Esc}, instance_17
ControlSend, ahk_parent, {Esc}, instance_18
ControlSend, ahk_parent, run, instance__1
ControlSend, ahk_parent, run, instance_2
ControlSend, ahk_parent, run, instance_3
ControlSend, ahk_parent, run, instance_4
ControlSend, ahk_parent, run, instance_5
ControlSend, ahk_parent, run, instance_6
ControlSend, ahk_parent, run, instance_7
ControlSend, ahk_parent, run, instance_8
ControlSend, ahk_parent, run, instance_9
ControlSend, ahk_parent, run, instance_10
ControlSend, ahk_parent, run, instance_11
ControlSend, ahk_parent, run, instance_12
ControlSend, ahk_parent, run, instance_13
ControlSend, ahk_parent, run, instance_14
ControlSend, ahk_parent, run, instance_15
ControlSend, ahk_parent, run, instance_16
ControlSend, ahk_parent, run, instance_17
ControlSend, ahk_parent, run, instance_18
ControlSend, ahk_parent, {Enter}, instance__1
ControlSend, ahk_parent, {Enter}, instance_2
ControlSend, ahk_parent, {Enter}, instance_3
ControlSend, ahk_parent, {Enter}, instance_4
ControlSend, ahk_parent, {Enter}, instance_5
ControlSend, ahk_parent, {Enter}, instance_6
ControlSend, ahk_parent, {Enter}, instance_7
ControlSend, ahk_parent, {Enter}, instance_8
ControlSend, ahk_parent, {Enter}, instance_9
ControlSend, ahk_parent, {Enter}, instance_10
ControlSend, ahk_parent, {Enter}, instance_11
ControlSend, ahk_parent, {Enter}, instance_12
ControlSend, ahk_parent, {Enter}, instance_13
ControlSend, ahk_parent, {Enter}, instance_14
ControlSend, ahk_parent, {Enter}, instance_15
ControlSend, ahk_parent, {Enter}, instance_16
ControlSend, ahk_parent, {Enter}, instance_17
ControlSend, ahk_parent, {Enter}, instance_18
return
