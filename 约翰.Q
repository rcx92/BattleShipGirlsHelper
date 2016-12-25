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
MacroID=1fffedcd-d258-4b9a-a04e-2d6ad20fdca6
Description=约翰
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

Function try_click_fuzong()
	try_click_fuzong = false
	If find_click_wait("E:\wg\e5\first-fuzong.bmp", 0, 0, 0) Then 
		try_click_fuzong = true
		Exit Function			
	End If	
	If find_click_wait("E:\wg\e5\fuzong2.bmp", 0, 0, 0) Then 
		try_click_fuzong = true
		Exit Function			
	End If
	If find_click_wait("E:\wg\e5\fuzong.bmp", 0, 0, 0) Then 
		try_click_fuzong = true
		Exit Function			
	End If	
End Function

Function try_click_tixing()
	try_click_tixing = false
	If find_click_wait("E:\wg\e5\tixing.bmp", 0, 0, 0) Then 
		try_click_tixing = true
		Exit Function			
	End If	
	If find_click_wait("E:\wg\e5\tixing2.bmp", 0, 0, 0) Then 
		try_click_tixing = true
		Exit Function			
	End If
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

	Call find_click_wait("E:\wg\e5\e5symbol.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\e5\ready.bmp", 0, 0, 3000)
	
	failed = failed or not try_click("E:\wg\half-auto\quick-support.bmp", 0, 0, 0, 10, 1000)
	failed = failed or not try_click("E:\wg\half-auto\all-support.bmp", 0, 0, 5000, 10, 1000) 
	
	
	failed = failed or not try_click("E:\wg\half-auto\quick-fix.bmp", 0, 0, 0, 10, 1000)
	failed = failed or not try_click("E:\wg\half-auto\all-fix.bmp", 0, 0, 5000, 10, 1000) 
	
	If find_click_wait("E:\wg\half-auto\cross.bmp", 0, 0, 3000) Then 
		failed = true
	End If
	Call try_click("E:\wg\half-auto\start.bmp", 0, 0, 0, 10, 1000)
	Dim fuzong
	Dim times
	Dim giveup
	Dim fuzong2
	giveup = "E:\wg\half-auto\giveup.bmp"
	times = 0
	For 4
		times = times + 1
		LeftClick 1
		Dim fuzonged
		fuzonged = false
		For 30
			Delay 1000
			LeftClick 1
			
			FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\start-battle.bmp", 1.0, intX, intY
			TracePrint intX
			If intX > 0 Then 
				call find_click_wait("E:\wg\half-auto\start-battle.bmp", 0, 0, 0)
				Exit for
			End If
			If times = 4 Then 
				If try_click_tixing() Then 
					fuzonged = true
					Exit for
				End If
				
			Else
				If try_click_fuzong() Then 
					fuzonged = true
					Exit for			
				End If
			End If
		Next
	    If not fuzonged Then
	    	For 10 
	    		If times = 4 then
	    			If try_click_tixing() Then 
	    				Exit For
	    			End If
	    		else
	    			If try_click_fuzong() Then 
	    				Exit For
	    			End If
	    		end if	
	    	Next
	    End If  
		continueX = - 1 
		Dim i
		i = 0
		For 50
			Delay 4000
			If times = 4 Then 
				i = i + 1
				If i < 5 Then 
					LeftClick 1
				End If
				Call find_click_wait("E:\wg\half-auto\zhuiji.bmp", 0, 0, 3000)
			else
				Call find_click_wait(giveup, 0, 0, 3000)
			End If
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
		LeftClick 1
		If try_click("E:\wg\half-auto\qijiandapo-return-to-harbor.bmp", 0, 0, 3000, 2, 2500) Then 
			failed = true
			Exit For
		Else 
			FindPic 0, 0, 1920, 1080, "E:\wg\half-auto\dapo-sign.bmp", 1.0, intX, intY
			If intX > 0 Then 
				Call try_click("E:\wg\half-auto\return-to-harbor-simple.bmp", 0, 0, 3000, 3, 1000)
				Exit for
				failed = true
			Else 
				
				call try_click("E:\wg\half-auto\forward.bmp", 0, 0, 3000, 3, 1000)
			
			End If
		End If
		If times = 1 then
			For 10
				Delay 1000
				If find_click_wait("E:\wg\half-auto\confirm.bmp", 0, 0, 1000) Then 
					Exit For
				End If
			Next
		End If
	Next
	If failed Then 
		//Call Plugin.Media.Play("E:\wg\half-auto\Kalimba.mp3")
		//Call Lib.API.运行程序("C:\Program Files (x86)\Tencent\QQ\QQProtect\Bin\QQProtect.exe")
		failed = false
	End If
End Function


While true
		Call auto_train()
		Delay 1000
Wend


Sub OnScriptExit()
    Call Plugin.Media.Stop() 
End Sub
