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

WinWaitActive, statcraft1
WinSetTitle, instance__1
WinGet, pid, PID, instance__1
Process, Priority, %pid%, H

Loop, 17
{
    i := A_Index + 1
    WinWaitActive, statcraft%i%
    WinSetTitle, instance_%i%
    WinGet, pid, PID, instance_%i%
    Process, Priority, %pid%, H
}

return
