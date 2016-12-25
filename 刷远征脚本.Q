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
MacroID=dadf3332-77be-4371-b913-13e2759de49f
Description=Ë¢Ô¶Õ÷½Å±¾
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]

Function find_click_wait(img, delta_x, delta_y, wait_time)
	FindPic 0, 0, 1920, 1080, img, 1.0, intX, intY
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

Function auto_far_attack(desc_img, desc_x, desc_y, number_image, chapter_image)
	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 5000)
	Call find_click_wait("E:\wg\go.bmp", 0, 0, 5000)
	Call find_click_wait("E:\wg\long_go_button.bmp", 0, 0, 5000)
	Call find_click_wait(chapter_image, 0, 0, 5000)
	FindPic 0, 0, 1920, 1080, desc_img, 1.0, intX, intY
	//TracePrint intX
	//TracePrint intY
	If intX > 0 And intY > 0 Then 
		FindPic intX, intY, intX + desc_x, intY + desc_y, "E:\wg\paiqianbutton.bmp", 1.0, bx, by
		If bx > 0 Then 
			MoveTo bx + 5,by + 5
			LeftClick 1
			Delay 5000
			Call find_click_wait(number_image, 0, 0, 5000)
			result = find_click_wait("E:\wg\start.bmp", 0, 0, 5000)
			If not result then
				Call find_click_wait("E:\wg\return.bmp", 0, 0, 5000)
			End if
		End If
	End If
End Function

Function check_bonus()
	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 5000)
	Call find_click_wait("E:\wg\go.bmp", 0, 0, 5000)
	Call find_click_wait("E:\wg\long_go_button.bmp", 0, 0, 5000)
	result = find_click_wait("E:\wg\get_bonus_button.bmp", 0, 0, 5000)
	If result Then 
		check_bonus = true
		Delay 5000
		LeftClick 1
		Delay 5000
	Else 
		check_bonus = false
	End if
End Function

Function auto_fix()
	Call find_click_wait("E:\wg\harbor.bmp", 0, 0, 5000)
	Call find_click_wait("E:\wg\ship_factory.bmp", 0, 0, 5000)
	Call find_click_wait("E:\wg\fix_button.bmp", 0, 0, 5000)
	result = find_click_wait("E:\wg\choose_button.bmp", 0, 0, 5000)
	auto_fix = false
	If result Then 
		result = find_click_wait("E:\wg\fix_cost.bmp", 0, -300, 5000)
		If result Then 
			auto_fix = true
		Else 
		End If
	End If
End Function

While true
	While check_bonus()
		
	Wend
	For 4
		If not auto_fix() Then
			Exit For
		End If
	Next
	Call auto_far_attack("E:\wg\bianduiyanxi.bmp", 1051, 127, "E:\wg\4.bmp", "E:\wg\second_chapter.bmp")
	Call auto_far_attack("E:\wg\huhangrenwu.bmp", 1051, 122, "E:\wg\2.bmp", "E:\wg\second_chapter.bmp")
	Call auto_far_attack("E:\wg\jinhaixunluo.bmp", 1064, 129, "E:\wg\3.bmp", "E:\wg\first_chapter.bmp")
	Call auto_far_attack("E:\wg\zuozhanyanlian.bmp", 1034, 113, "E:\wg\1.bmp", "E:\wg\first_chapter.bmp")
Wend
