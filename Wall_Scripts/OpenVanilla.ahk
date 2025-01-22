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

Loop, 17
{
    i := 19 - A_Index
    Run, %A_Desktop%\MovingWall\StatCraft\statcraft%i%.p8
    WinWaitActive, STATCRAFT%i%.P8 (PICO-8)
    WinSetTitle, instance_%i%
    WinGet, pid, PID, instance_%i%
    Process, Priority, %pid%, A
}
Run, %A_Desktop%\MovingWall\StatCraft\statcraft1.p8
WinWaitActive, STATCRAFT1.P8 (PICO-8)
WinSetTitle, instance__1
WinGet, pid, PID, instance__1
Process, Priority, %pid%, A

Sleep 1000

ControlSend, ahk_parent, {Esc}, instance__1
Loop, 17
{
    i := A_Index + 1
    ControlSend, ahk_parent, {Esc}, instance_%i%
}

ControlSend, ahk_parent, run, instance__1
Loop, 17
{
    i := A_Index + 1
    ControlSend, ahk_parent, run, instance_%i%
}

ControlSend, ahk_parent, {Enter}, instance__1
Loop, 17
{
    i := A_Index + 1
    ControlSend, ahk_parent, {Enter}, instance_%i%
}

return
