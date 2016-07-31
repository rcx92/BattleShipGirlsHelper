[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=bc80f24d-7bd6-4aec-a3ea-6f4d323b7e37
Description=ˢ6-1
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]

failed = False

Function find_click_wait(img, delta_x, delta_y, wait_time)
	FindPic 0, 0, 1920, 1080, img, 0.9, intX, intY
	TracePrint img
	TracePrint intX
	If intX > 0 And intY > 0 Then 
		find_click_wait = True
		MoveTo intX + delta_x,intY + delta_y
		LeftClick 1
		Delay wait_time
	Else 
		find_click_wait = false
	End If
End Function

Function try_click(img, delta_x, delta_y, wait_time, try_times, start_delay)
	try_click = false
	For try_times
		Delay start_delay
		If find_click_wait(img, delta_x, delta_y, wait_time) Then 
			try_click = true
			Exit For
		End If
	Next
End Function


Function reenter_game()
	Call find_click_wait("E:\wg\half-auto\list-app.bmp", 0, 0, 1000)
	FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\app-name.bmp", 0.9, intX, intY
	MoveTo intX, intY - 300
	Delay 1000
	LeftDown 1
	Delay 100
	MoveR 0, - 300 
	Delay 100
	LeftUp 1
	Delay 2000
	Call find_click_wait("E:\wg\half-auto\app-logo.bmp", 0, 0, 1000)
	failed = failed or not try_click("E:\wg\half-auto\enter-game.bmp", 0, 0, 5000, 10, 5000) 
End function

Function auto_train()

	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\go.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\half-auto\go-war.bmp", 0, 0, 3000)
	Do While find_click_wait("E:\wg\half-auto\right-arrow.bmp", 0, 0, 1000)
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\big-6th-chapter.bmp", 0.9, intX, intY
		if intX > 0 Then 
			Exit do
		End If
	loop
	
	
	While find_click_wait("E:\wg\half-auto\left-arrow2.bmp", 0, 0, 1000)
	Wend
	failed = failed or not find_click_wait("E:\wg\half-auto\61title.bmp", 0, 0, 3000)
	failed = failed or not find_click_wait("E:\wg\half-auto\quick-support.bmp", 0, 0, 3000)
	failed = failed or not find_click_wait("E:\wg\half-auto\all-support.bmp", 0, 0, 3000)
	If find_click_wait("E:\wg\half-auto\cross.bmp", 0, 0, 3000) Then 
		failed = true
	End If
	failed = failed or not find_click_wait("E:\wg\half-auto\start.bmp", 0, 0, 3000)
	LeftClick 1
	For 10
		Delay 3000
		LeftClick 1
		
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\start-battle.bmp", 0.9, intX, intY
		If intX > 0 Then 
			FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\all-ss.bmp", 0.9, intX, intY
			If intX > 0 Then 
				call find_click_wait("E:\wg\half-auto\start-battle.bmp", 0, 0, 5000)
			Else 
				Call reenter_game()
				Exit Function
			End If
			Exit for
		End If
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\danheng.bmp", 0.9, intX, intY
		If intX > 0 Then //no enemy
			Call reenter_game()
			Exit Function			
		End If
	Next
	failed = failed or not find_click_wait("E:\wg\half-auto\danheng.bmp", 0, 0, 5000)
	For 50
		Delay 4000 
		Call find_click_wait("E:\wg\half-auto\zhuiji.bmp", 0, 0, 3000)
		If find_click_wait("E:\wg\half-auto\click-to-continue.bmp", 0, 0, 3000) Then
			Exit For
		End If
	Next
	failed = failed or not find_click_wait("E:\wg\half-auto\continue.bmp", 0, 0, 2000)
	LeftClick 1
	Delay 2000
	If find_click_wait("E:\wg\half-auto\qijiandapo-return-to-harbor.bmp", 0, 0, 3000) Then 
		failed = true
	Else 
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\dapo-sign.bmp", 0.9, intX, intY
		If intX > 0 Then 
			failed = true
		End If
		call find_click_wait("E:\wg\half-auto\return-to-harbor-simple.bmp", 0, 0, 3000) 
	End If
	If failed Then 
		Call Plugin.Media.Play("E:\wg\half-auto\Kalimba.mp3")
	End If
End Function

While true
	If not failed  Then 
		Call auto_train()
		Delay 1000
	End If
Wend

Sub OnScriptExit()
    Call Plugin.Media.Stop() 
End Sub
