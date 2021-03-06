#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oAppl = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open Workbook 2
Local $oWorkbook2 = _Excel_BookOpen($oAppl, @ScriptDir & "\Extras\_Excel3.xls", True)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel3.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oAppl)
	Exit
EndIf
; Open Workbook 1
Local $oWorkbook1 = _Excel_BookOpen($oAppl, @ScriptDir & "\Extras\_Excel1.xls", True)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oAppl)
	Exit
EndIf

; *****************************************************************************
; Move sheet 1 of Workbook1 before sheet 1 of workbook 2
; *****************************************************************************
_Excel_SheetCopyMove($oWorkbook1, 1, $oWorkbook2, 1, Default, False)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example 4", "Error moving sheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example 4", "Workbook 1 Sheet 1 moved to Workbook2 before sheet 1")
