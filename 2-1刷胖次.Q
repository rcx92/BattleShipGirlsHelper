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
MacroID=c42c3030-764c-4c50-87f3-b78ba6191dcb
Description=2-1ˢ�ִ�
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
last_success = true

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
	Call find_click_wait("E:\wg\half-auto\tv-confirm.bmp", 0, 0, 1000)
	Call find_click_wait("E:\wg\half-auto\tv-confirm2.bmp", 0, 0, 1000)
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
	Call try_click("E:\wg\half-auto\app-logo.bmp", 0, 0, 1000, 5, 3000)
	failed = failed or not try_click("E:\wg\half-auto\enter-game.bmp", 0, 0, 5000, 20, 5000) 
	Call find_click_wait("E:\wg\half-auto\enter-game.bmp", 0, 0, 1000)
	For 20
		If find_click_wait("E:\wg\half-auto\no-show-today.bmp", 0, 0, 3000) Then 
			Call find_click_wait("E:\wg\half-auto\news-cross.bmp", 0, 0, 3000)
		End If
		FindPic 0, 0, 1920, 1080, "E:\wg\go.bmp", 0.95, intX, intY
		If intX > 0 Then 
			Exit For
		End If
	Next
End function

Function auto_train()

	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\go.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\half-auto\go-war.bmp", 0, 0, 3000)
	Do While find_click_wait("E:\wg\half-auto\left-arrow.bmp", 0, 0, 1000)
		Call find_click_wait("E:\wg\half-auto\small-2nd-chapter.bmp", 0, 0, 1000)
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\big-2nd-chapter.bmp", 1.0, intX, intY
		if intX > 0 Then 
			Exit do
		End If
	loop
	
	
	While find_click_wait("E:\wg\half-auto\left-arrow2.bmp", 0, 0, 1000)
	Wend
	failed = failed or not try_click("E:\wg\half-auto\21title.bmp", 0, 0, 0, 10, 1000) 
	Dim start_success
	If last_success Then
		failed = failed or not try_click("E:\wg\half-auto\quick-support.bmp", 0, 0, 0, 10, 1000)
		failed = failed or not try_click("E:\wg\half-auto\all-support.bmp", 0, 0, 5000, 10, 1000) 
		
		
		failed = failed or not try_click("E:\wg\half-auto\quick-fix.bmp", 0, 0, 0, 10, 1000)
		failed = failed or not try_click("E:\wg\half-auto\all-fix.bmp", 0, 0, 5000, 10, 1000) 
		last_success = false
		If find_click_wait("E:\wg\half-auto\cross.bmp", 0, 0, 3000) Then 
			failed = true
		End If
		start_success = try_click("E:\wg\half-auto\start.bmp", 0, 0, 0, 10, 1000)
	Else 
		start_success = try_click("E:\wg\half-auto\start.bmp", 0, 0, 0, 10, 1000) 
	End If
	If not start_success  Then 
		Call reenter_game()
		Exit Function
	End If
	LeftClick 1
	For 30
		Delay 1000
		LeftClick 1
		
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\start-battle.bmp", 1.0, intX, intY
		TracePrint intX
		If intX > 0 Then 
			FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\pangci.bmp", 1.0, intX, intY
			If intX > 0 Then 
				call find_click_wait("E:\wg\half-auto\start-battle.bmp", 0, 0, 0)
			Else 
				Call reenter_game()
				Exit Function
			End If
			Exit for
		End If
		FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\fuzong.bmp", 1.0, intX, intY
		If find_click_wait("E:\wg\half-auto\fuzong.bmp", 0, 0, 0) Then //no enemy
			Exit For			
		End If
	Next
	failed = failed or not try_click("E:\wg\half-auto\fuzong.bmp", 0, 0, 0, 10, 1000) 
	last_success = true
	continueX = -1
	For 50
		Delay 4000 
		Call find_click_wait("E:\wg\half-auto\zhuiji.bmp", 0, 0, 3000)
		If find_click_wait("E:\wg\half-auto\click-to-continue.bmp", 0, 0, 0) Then 
			continueX = intX
			continueY = intY
			Exit For
		End If
	Next
	If continueX < 0 Then 
		LeftClick 1
	End If
	If not try_click("E:\wg\half-auto\continue.bmp", 0, 0, 5000, 10, 1000)  Then 
		MoveTo continueX + 100, continueY
		LeftClick 1
		Delay 5000
	End If
	For 5
		LeftClick 1
		Delay 3000
		FindPic 0, 0, 1920, 1080, "E:\wg\go.bmp", 0.95, intX, intY
		if intX > 0 Then 
			Exit for
		End If
	Next
End Function


While true
	Call auto_train()
	Delay 1000
Wend


Sub OnScriptExit()
    Call Plugin.Media.Stop() 
End Sub
