#include <MsgBoxConstants.au3>
#include <Sound.au3>

Local $aSound = _SoundOpen(@WindowsDir & "\media\tada.wav")
If @error = 2 Then
	MsgBox($MB_SYSTEMMODAL, "Error", "The file does not exist")
	Exit
ElseIf @extended <> 0 Then
	Local $iExtended = @extended ; Assign because @extended will be set after DllCall.
	Local $tText = DllStructCreate("char[128]")
	DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $iExtended, "ptr", DllStructGetPtr($tText), "int", 128)
	MsgBox($MB_SYSTEMMODAL, "Error", "The open failed." & @CRLF & "Error Number: " & $iExtended & @CRLF & "Error Description: " & DllStructGetData($tText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
	MsgBox($MB_SYSTEMMODAL, "Success", "The file opened successfully")
EndIf

_SoundPlay($aSound, 0)
SplashTextOn("Current Position", _SoundPos($aSound, 1), 300, 90, Default, Default, 18, Default, 55)

While 1
	Sleep(100)
	ControlSetText("Current Position", "", "Static1", _SoundPos($aSound, 1))
	If _SoundPos($aSound, 2) >= _SoundLength($aSound, 2) Then ExitLoop
WEnd

_SoundClose($aSound)
