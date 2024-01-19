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

WinActivate, instance__1

WinClose, obama
WinClose, pcraft_timer_new
WinClose, instance__1
WinClose, instance_2
WinClose, instance_3
WinClose, instance_4
WinClose, instance_5
WinClose, instance_6
WinClose, instance_7
WinClose, instance_8
WinClose, instance_9
WinClose, instance_10
WinClose, instance_11
WinClose, instance_12
WinClose, instance_13
WinClose, instance_14
WinClose, instance_15
WinClose, instance_16
WinClose, instance_17
WinClose, instance_18
return