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

; OPEN VANILLA INSTANCES
[::
Run, %A_Desktop%\MovingWall\Wall_Scripts\OpenVanilla.ahk
return

; OPEN DREAM% INSTANCES
^[::
Run, %A_Desktop%\MovingWall\Wall_Scripts\OpenDream.ahk
return

; OPEN DELUXE INSTANCES
+[::
Run, %A_Desktop%\MovingWall\Wall_Scripts\OpenDeluxe.ahk
return

; OPEN DELUXE DREAM% INSTANCES
^+[::
Run, %A_Desktop%\MovingWall\Wall_Scripts\OpenDeluxeDream.ahk
return

; OPEN PRACTICE MODE INSTANCES
^]::
Run, %A_Desktop%\MovingWall\Wall_Scripts\OpenPracticeMode.ahk
return

; CLOSE INSTANCES
]::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Close.ahk
return

; RETURN TO WALL
NumpadSub::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Return.ahk
return

; PLAY INSTANCE 1
Numpad1::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play1.ahk
return

; PLAY INSTANCE 2
Numpad2::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play2.ahk
return

; PLAY INSTANCE 3
Numpad3::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play3.ahk
return

; PLAY INSTANCE 4
Numpad4::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play4.ahk
return

; PLAY INSTANCE 5
Numpad5::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play5.ahk
return

; PLAY INSTANCE 6
Numpad6::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play6.ahk
return

; PLAY INSTANCE 7
Numpad7::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play7.ahk
return

; PLAY INSTANCE 8
Numpad8::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play8.ahk
return

; PLAY INSTANCE 9
Numpad9::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play9.ahk
return

; PLAY INSTANCE 10
^Numpad1::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play10.ahk
return

; PLAY INSTANCE 11
^Numpad2::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play11.ahk
return

; PLAY INSTANCE 12
^Numpad3::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play12.ahk
return

; PLAY INSTANCE 13
^Numpad4::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play13.ahk
return

; PLAY INSTANCE 14
^Numpad5::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play14.ahk
return

; PLAY INSTANCE 15
^Numpad6::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play15.ahk
return

; PLAY INSTANCE 16
^Numpad7::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play16.ahk
return

; PLAY INSTANCE 17
^Numpad8::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play17.ahk
return

; PLAY INSTANCE 18
^Numpad9::
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play\Play18.ahk
return
