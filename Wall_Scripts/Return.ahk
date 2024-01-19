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

Send, {LControl down}
Send, {m down}
Sleep 20
Send, {m up}
Send, {LControl up}
Sleep 20
Send, {LWin down}
Send, {Down down}
Sleep 20
Send, {Down up}
Send, {LWin up}
Sleep 20
WinActivate, instance__1
WinActivate, Full-screen Projector (Preview)