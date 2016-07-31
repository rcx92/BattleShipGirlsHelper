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
MacroID=697167ae-c5de-4e52-839d-a8560db5b871
Description=自动刷5-5大破暂停报警
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

Function auto_train()

	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\go.bmp", 0, 0, 3000)
	Call find_click_wait("E:\wg\half-auto\go-war.bmp", 0, 0, 3000)
	do While find_click_wait("E:\wg\half-auto\right-arrow.bmp", 0, 0, 1000)
		If find_click_wait("E:\wg\half-auto\5th-chapter.bmp", 0, 0, 1000) Then 
			Exit do
		End If
	loop
	
	
	While find_click_wait("E:\wg\half-auto\right-arrow2.bmp", 0, 0, 1000)
	Wend
	Delay 5000
	failed = failed or not find_click_wait("E:\wg\half-auto\55title.bmp", 0, 0, 3000)
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
		If find_click_wait("E:\wg\half-auto\start-battle.bmp", 0, 0, 5000) Then 
			Exit for
		End If
	Next
	failed = failed or not find_click_wait("E:\wg\half-auto\fuzong.bmp", 150, 0, 5000)
	For 50
		Delay 4000 
		Call find_click_wait("E:\wg\half-auto\zhuiji.bmp", 0, 0, 3000)
		If find_click_wait("E:\wg\half-auto\click-to-continue.bmp", 0, 0, 3000) Then
			Exit For
		End If
	Next
	failed = failed or not find_click_wait("E:\wg\half-auto\continue.bmp", 0, 0, 2000)
	LeftClick 1
	Delay 5000
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


Delay 10000

Sub OnScriptExit()
    Call Plugin.Media.Stop() 
End Sub
