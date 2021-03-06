#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oAppl = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open Workbook 2
Local $oWorkbook2 = _Excel_BookOpen($oAppl, @ScriptDir & "\Extras\_Excel3.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel3.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oAppl)
	Exit
EndIf
; Open Workbook 1
Local $oWorkbook1 = _Excel_BookOpen($oAppl, @ScriptDir & "\Extras\_Excel1.xls")
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oAppl)
	Exit
EndIf

; *****************************************************************************
; Copy sheet 1 after sheet 3. Set the name of the new sheet
; *****************************************************************************
Local $oCopiedSheet = _Excel_SheetCopyMove($oWorkbook1, 1, Default, 3, False)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example 1", "Error copying sheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Set the name of the new sheet
#forceref $oCopiedSheet
$oCopiedSheet.Name = "Copied sheet"
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetCopyMove Example 1", "Sheet 1 copied after sheet 3 and renamed")
