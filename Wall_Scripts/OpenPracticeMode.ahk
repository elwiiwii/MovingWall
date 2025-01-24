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

Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_18
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_17
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_16
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_15
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_14
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_13
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_12
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_11
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_10
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_9
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_8
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_7
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_6
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_5
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_4
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_3
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance_2
Run, %A_Desktop%\MovingWall\PracticeMode\practicemode
WinWaitActive, practicemode
WinSetTitle, instance__1
return
