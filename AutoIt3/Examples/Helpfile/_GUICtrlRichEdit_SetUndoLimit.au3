#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGui, $iMsg, $idBtnNext, $iStep = 0, $idLblMsg, $hRichEdit
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_SetText($hRichEdit, "First paragraph")
	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
			Case $iMsg = $idBtnNext
				$iStep += 1
				Switch $iStep
					Case 1
						_GUICtrlRichEdit_SetUndoLimit($hRichEdit, 200)
						GUICtrlSetData($idLblMsg, "Increased the number of actions that can stored in the undo queue from 100 to 200")
					Case 2
						_GUICtrlRichEdit_SetUndoLimit($hRichEdit, 0)
						GUICtrlSetData($idLblMsg, "Undo is disabled")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example
