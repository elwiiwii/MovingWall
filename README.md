**First Time Setup:**

- Download and install AutoHotkey v1.1.34.03

- Download MovingWall and unzip it

- Put the unzipped folder on your desktop and rename it to MovingWall

- Manually open 1 instance of stranded isle

- Set the settings to your liking

- Mute and unfullscreen the instance and close it

- Go to %appdata% in your file system and open the pico-8 folder

- Open config.txt

- Under // :: Video Settings, set window_size to 128 128

- (Optional) Under // :: Window Settings, set frameless to 1 if you dont want to see the title bar when you are playing (you wont be able to manually move the window)

- Save and close config.txt

- In the MovingWall folder edit your hotkeys in Wall.ahk and Reset.ahk (some keys dont work properly for reset idk why)

- Tip: for the playing hotkeys i recommend doing numbers 1 to 9 for instances 1 to 9 and Ctrl+1 to Ctrl+9 for instances 10 to 18

- Open OBS (cannot confim that the scenes will work on OBS version 30 or higher)

- Import scene collection MovingWall.json

- Go to tools > scripts and remove and re-add SceneSwitcher.lua (idk why but you have to do this but every time you open OBS sorry)

- Go to hotkeys in OBS settings

- Set "Swtich Scenes" hotkeys to your reset hotkey

- For every instance set "Switch to scene" and "Hide 'Display Capture'" to your playing hotkey for that instance and set "Show 'Display Capture'" to your return hotkey

- For "Wall 1" set "Switch to scene" to your return hotkey, set "Show 'Display Capture'" to all your playing hotkeys and set "Hide 'Display Capture'" to your return hotkey

- Do the same for "Wall 2" apart from the "Switch to scene" hotkey which should be left blank

- Apply and exit

- Run Wall.ahk and Reset.ahk

- Open OBS Full-screen Projector

- Everything should hopefully work!

- If the big square starts getting reset instead of the second one then reload the reset script and reset once until it fixes
