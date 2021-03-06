#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $tRect, $sRect, $idTab

	; Create GUI
	GUICreate("Tab Control Get Item RectEx", 400, 300)
	$idTab = GUICtrlCreateTab(2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add tabs
	_GUICtrlTab_InsertItem($idTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($idTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($idTab, 2, "Tab 3")

	; Get item 0 rectangle
	$tRect = _GUICtrlTab_GetItemRectEx($idTab, 0)
	$sRect = StringFormat("[%d, %d, %d, %d]", DllStructGetData($tRect, "Left"), _
			DllStructGetData($tRect, "Top"), _
			DllStructGetData($tRect, "Right"), _
			DllStructGetData($tRect, "Bottom"))
	MsgBox($MB_SYSTEMMODAL, "Information", "Display rectangle: " & $sRect)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
