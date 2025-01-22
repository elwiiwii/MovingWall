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

WinGet, active_id, ID, A

Send, {LControl down}
Send, {m down}
Sleep 67
Send, {m up}
Send, {LControl up}

Sleep 67

WinMove, ahk_id %active_id%, , 888, 505, 144, 167
WinGet, pid, PID, ahk_id %active_id%
Process, Priority, %pid%, A

Sleep 67

Loop, 17
{
    i := 19 - A_Index
    ControlSend, ahk_parent, {Tab down}, instance_&i%
}
ControlSend, ahk_parent, {Tab down}, instance__1

Sleep 67

Loop, 17
{
    i := 19 - A_Index
    ControlSend, ahk_parent, {Tab up}, instance_&i%
}
ControlSend, ahk_parent, {Tab up}, instance__1

Sleep 67

WinActivate, instance__1
WinActivate, Full-screen Projector (Preview)