#include <WinAPI.au3>

Local $sFile, $hFile, $sText, $nBytes, $tBuffer, $iSize

; 1) create file and write data to it
$sFile = @ScriptDir & '\test.txt'
$sText = 'abcdefghijklmnopqrstuvwxyz'
$tBuffer = DllStructCreate("byte[" & StringLen($sText) & "]")
DllStructSetData($tBuffer, 1, $sText)
$hFile = _WinAPI_CreateFile($sFile, 1)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), StringLen($sText), $nBytes)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('1):' & $iSize & ' ' & FileRead($sFile) & @CRLF)

; 2) read 6 bytes from position 3
$tBuffer = DllStructCreate("byte[6]")
$hFile = _WinAPI_CreateFile($sFile, 2, 2)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_ReadFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$sText = BinaryToString(DllStructGetData($tBuffer, 1))
ConsoleWrite('2):' & $iSize & ' ' & $sText & @CRLF)

; 3) write previously read 6 bytes from position 3 to the same position but in UpperCase
DllStructSetData($tBuffer, 1, StringUpper($sText))
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$tBuffer = 0
ConsoleWrite('3):' & $iSize & ' ' & FileRead($sFile) & @CRLF)

; 4) truncate file size to 12 bytes
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 12)
_WinAPI_SetEndOfFile($hFile)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('4):' & $iSize & ' ' & FileRead($sFile) & @CRLF)

FileDelete($sFile)
