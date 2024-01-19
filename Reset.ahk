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

#::Reload

reset = 1

NumpadDot::
if (reset == 1) {
	ControlSend, ahk_parent, {Tab down}, instance__1
	ControlSend, ahk_parent, {Tab down}, instance_2
	ControlSend, ahk_parent, {Tab down}, instance_3
	ControlSend, ahk_parent, {Tab down}, instance_4
	ControlSend, ahk_parent, {Tab down}, instance_5
	ControlSend, ahk_parent, {Tab down}, instance_6
	ControlSend, ahk_parent, {Tab down}, instance_7
	ControlSend, ahk_parent, {Tab down}, instance_8
	ControlSend, ahk_parent, {Tab down}, instance_9
	Sleep 34
	ControlSend, ahk_parent, {Tab up}, instance__1
	ControlSend, ahk_parent, {Tab up}, instance_2
	ControlSend, ahk_parent, {Tab up}, instance_3
	ControlSend, ahk_parent, {Tab up}, instance_4
	ControlSend, ahk_parent, {Tab up}, instance_5
	ControlSend, ahk_parent, {Tab up}, instance_6
	ControlSend, ahk_parent, {Tab up}, instance_7
	ControlSend, ahk_parent, {Tab up}, instance_8
	ControlSend, ahk_parent, {Tab up}, instance_9
	reset = 2
	return
} else {
	ControlSend, ahk_parent, {Tab down}, instance_10
	ControlSend, ahk_parent, {Tab down}, instance_11
	ControlSend, ahk_parent, {Tab down}, instance_12
	ControlSend, ahk_parent, {Tab down}, instance_13
	ControlSend, ahk_parent, {Tab down}, instance_14
	ControlSend, ahk_parent, {Tab down}, instance_15
	ControlSend, ahk_parent, {Tab down}, instance_16
	ControlSend, ahk_parent, {Tab down}, instance_17
	ControlSend, ahk_parent, {Tab down}, instance_18
	Sleep 34
	ControlSend, ahk_parent, {Tab up}, instance_10
	ControlSend, ahk_parent, {Tab up}, instance_11
	ControlSend, ahk_parent, {Tab up}, instance_12
	ControlSend, ahk_parent, {Tab up}, instance_13
	ControlSend, ahk_parent, {Tab up}, instance_14
	ControlSend, ahk_parent, {Tab up}, instance_15
	ControlSend, ahk_parent, {Tab up}, instance_16
	ControlSend, ahk_parent, {Tab up}, instance_17
	ControlSend, ahk_parent, {Tab up}, instance_18
	reset = 1
	return
}