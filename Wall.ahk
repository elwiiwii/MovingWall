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
WinActivate, 000000.png
WinActivate, instance__1
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 2
Numpad2::
WinActivate, 000000.png
WinActivate, instance_2
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 3
Numpad3::
WinActivate, 000000.png
WinActivate, instance_3
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 4
Numpad4::
WinActivate, 000000.png
WinActivate, instance_4
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 5
Numpad5::
WinActivate, 000000.png
WinActivate, instance_5
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 6
Numpad6::
WinActivate, 000000.png
WinActivate, instance_6
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 7
Numpad7::
WinActivate, 000000.png
WinActivate, instance_7
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 8
Numpad8::
WinActivate, 000000.png
WinActivate, instance_8
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 9
Numpad9::
WinActivate, 000000.png
WinActivate, instance_9
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 10
^Numpad1::
WinActivate, 000000.png
WinActivate, instance_10
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 11
^Numpad2::
WinActivate, 000000.png
WinActivate, instance_11
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 12
^Numpad3::
WinActivate, 000000.png
WinActivate, instance_12
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 13
^Numpad4::
WinActivate, 000000.png
WinActivate, instance_13
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 14
^Numpad5::
WinActivate, 000000.png
WinActivate, instance_14
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 15
^Numpad6::
WinActivate, 000000.png
WinActivate, instance_15
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 16
^Numpad7::
WinActivate, 000000.png
WinActivate, instance_16
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 17
^Numpad8::
WinActivate, 000000.png
WinActivate, instance_17
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return

; PLAY INSTANCE 18
^Numpad9::
WinActivate, 000000.png
WinActivate, instance_18
Run, %A_Desktop%\MovingWall\Wall_Scripts\Play.ahk
return
