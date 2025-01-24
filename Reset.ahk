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

^#::Reload

reset = 2

NumpadDot::
if (reset == 1) {
	ControlSend, ahk_parent, {Tab down}, instance__1
	Sleep 34
	Loop, 8
	{
		i := A_Index + 1
		ControlSend, ahk_parent, {Tab down}, instance_%i%
		Sleep 34
	}
	ControlSend, ahk_parent, {Tab up}, instance__1
	Loop, 8
	{
		i := A_Index + 1
		ControlSend, ahk_parent, {Tab up}, instance_%i%
		Sleep 34
	}
	reset = 2
	return
} else {
	Loop, 9
	{
		i := A_Index + 9
		ControlSend, ahk_parent, {Tab down}, instance_%i%
		Sleep 34
	}
	Loop, 9
	{
		i := A_Index + 9
		ControlSend, ahk_parent, {Tab up}, instance_%i%
		Sleep 34
	}
	reset = 1
	return
}