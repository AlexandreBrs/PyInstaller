#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg, $g_hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg, $idBtnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_SetText($g_hRichEdit, "First paragraph")
	_GUICtrlRichEdit_SetSel($g_hRichEdit, 0, 1)
	Report("Para with default indent settings")

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($g_hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
			Case $iMsg = $idBtnNext
				$iStep += 1
				Switch $iStep
					Case 1
						_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "Second paragraph")
						_GUICtrlRichEdit_SetParaNumbering($g_hRichEdit, ".")
						Report("Added second paragraph")
					Case 2
						_GUICtrlRichEdit_SetSel($g_hRichEdit, 0, 2)
						Report("Style of first paragraph in the selection")
					Case 3
						_GUICtrlRichEdit_SetSel($g_hRichEdit, 10, 26)
						_GUICtrlRichEdit_SetParaNumbering($g_hRichEdit, "v)  ", Default, True)
						Report("Change settings of both paragraphs")
					Case 4
						_GUICtrlRichEdit_SetSel($g_hRichEdit, 10, 26)
						_GUICtrlRichEdit_SetParaNumbering($g_hRichEdit, "2.  ", Default, True)
						Report("Changed settings for both paragraphs")
					Case 5
						; Stream all text to the Desktop so you can look at settings in Word
						_GUICtrlRichEdit_Deselect($g_hRichEdit)
						_GUICtrlRichEdit_StreamToFile($g_hRichEdit, @DesktopDir & "\gcre.rtf")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	$sMsg = $sMsg & @CRLF & @CRLF & "Get function returns " & @CRLF & _GUICtrlRichEdit_GetParaNumbering($g_hRichEdit)
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report
