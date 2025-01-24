#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
;Process, Priority, , A
;SetBatchLines, -1
;SetKeyDelay, -1, -1
;SetMouseDelay, -1
;SetDefaultMouseSpeed, 0
;SetWinDelay, -1
;SetControlDelay, -1
SendMode, Input
CoordMode, Mouse, Screen
;DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution)

WinGet, active_id, ID, A
WinMove, ahk_id %active_id%, , 440, 0, 1039, 1159
;WinGet, pid, PID, ahk_id %active_id%
;Process, Priority, %pid%, H

ControlSend, ahk_parent, {q down}, ahk_id %active_id%
Sleep 67
ControlSend, ahk_parent, {q up}, ahk_id %active_id%

Sleep 67

ControlSend, ahk_parent, {Ctrl down}, ahk_id %active_id%
ControlSend, ahk_parent, {m down}, ahk_id %active_id%
Sleep 67
ControlSend, ahk_parent, {m up}, ahk_id %active_id%
ControlSend, ahk_parent, {Ctrl up}, ahk_id %active_id%

return