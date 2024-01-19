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

WinMaximize, instance_10

ControlSend, ahk_parent, {Ctrl down}, instance_10
ControlSend, ahk_parent, {m down}, instance_10
Sleep 20
ControlSend, ahk_parent, {m up}, instance_10
ControlSend, ahk_parent, {Ctrl up}, instance_10

WinActivate, instance_10
return