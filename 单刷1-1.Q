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
MacroID=5ef40506-0c41-47de-9f18-7de8f5a55450
Description=单刷1-1
Enable=0
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
	FindPic 0, 0, 1920, 1080, img, 1.0, intX, intY
	If intX < 0 Then 
		FindPic 0, 0, 1920, 1080, img, 0.95, intX, intY
	End If
	TracePrint img
	TracePrint intX
	If intX > 0 And intY > 0 Then 
		find_click_wait = True
		MoveTo intX + delta_x, intY + delta_y
		Delay 100
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
	FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\app-name.bmp", 1.0, intX, intY
	MoveTo intX, intY - 300
	Delay 1000
	LeftDown 1
	Delay 100
	MoveR 0, - 300 
	Delay 100
	LeftUp 1
	Delay 2000
	Call find_click_wait("E:\wg\half-auto\app-logo.bmp", 0, 0, 1000)
	failed = failed or not try_click("E:\wg\half-auto\enter-game.bmp", 0, 0, 5000, 1000000000, 5000) 
	Call find_click_wait("E:\wg\half-auto\enter-game.bmp", 0, 0, 1000)
	For 20
		If find_click_wait("E:\wg\go.bmp", 0, 0, 3000) Then 
			Exit For
		End If
		Delay 1000
	Next
End function

Function auto_train()

	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\go.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\half-auto\go-war.bmp", 0, 0, 3000)
	Do While find_click_wait("E:\wg\half-auto\left-arrow.bmp", 0, 0, 1000)
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\big-1st-chapter.bmp", 1.0, intX, intY
		if intX > 0 Then 
			Exit do
		End If
	loop
	
	
	While find_click_wait("E:\wg\half-auto\left-arrow2.bmp", 0, 0, 1000)
	Wend
	failed = failed or not try_click("E:\wg\half-auto\11title.bmp", 0, 0, 0, 10, 1000) 
	
	failed = failed or not try_click("E:\wg\half-auto\quick-support.bmp", 0, 0, 0, 10, 1000)
	failed = failed or not try_click("E:\wg\half-auto\all-support.bmp", 0, 0, 5000, 10, 1000) 
	
	If find_click_wait("E:\wg\half-auto\cross.bmp", 0, 0, 3000) Then 
		failed = true
	End If
	If not find_click_wait("E:\wg\half-auto\start.bmp", 0, 0, 0) then
		failed = failed or not try_click("E:\wg\half-auto\quick-fix.bmp", 0, 0, 0, 10, 1000)
		failed = failed or not try_click("E:\wg\half-auto\all-fix.bmp", 0, 0, 5000, 10, 1000) 
		call find_click_wait("E:\wg\half-auto\start.bmp", 0, 0, 0)
	end if
	LeftClick 1
	continueX = -1
	For 30
		Delay 1000
		if find_click_wait("E:\wg\half-auto\start-battle.bmp", 0, 0, 0) then
			Exit for
		End If
		if find_click_wait("E:\wg\half-auto\zhuiji.bmp", 0, 0, 0) then
			Exit for
		End If
		if find_click_wait("E:\wg\half-auto\click-to-continue.bmp", 0, 0, 0) then
			continueX = intX
			continueY = intY
			Exit for
		End If
		LeftClick 1
	Next
	Delay 1000
	LeftClick 1
	If continueX < 0 then
		For 50
			Delay 4000 
			Call find_click_wait("E:\wg\half-auto\zhuiji.bmp", 0, 0, 3000)
			If find_click_wait("E:\wg\half-auto\click-to-continue.bmp", 0, 0, 0) Then 
				continueX = intX
				continueY = intY
				Exit For
			End If
		Next
	End If
	If continueX < 0 Then 
		LeftClick 1
	End If
	If not try_click("E:\wg\half-auto\continue.bmp", 0, 0, 5000, 10, 1000)  Then 
		MoveTo continueX + 100, continueY
		LeftClick 1
		Delay 5000
	End If
	For 5
		MoveR -100, -100
		LeftClick 1
		Delay 3000
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\qijiandapo-return-to-harbor.bmp", 0.95, intX, intY
		if intX > 0 Then 
			Exit for
		End If
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\return-to-harbor-simple.bmp", 0.95, intX, intY
		if intX > 0 Then 
			Exit for
		End If
	Next
	If try_click("E:\wg\half-auto\qijiandapo-return-to-harbor.bmp", 0, 0, 3000, 2, 2500) Then 
		failed = true
	Else 
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\dapo-sign.bmp", 1.0, intX, intY
		If intX > 0 Then 
			failed = true
		End If
		call find_click_wait("E:\wg\half-auto\return-to-harbor-simple.bmp", 0, 0, 3000) 
	End If
	
	If failed Then 
		//Call Plugin.Media.Play("E:\wg\half-auto\Kalimba.mp3")
		//Call Lib.API.运行程序("C:\Program Files (x86)\Tencent\QQ\QQProtect\Bin\QQProtect.exe")
		failed = false
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
