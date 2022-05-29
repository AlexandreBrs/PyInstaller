#include <Constants.au3>
#include <File.au3>
#include <Array.au3>
#include <FileListToArray3.au3>
#include <Process.au3>

; =========================================================================
; AutoIt Version: 3.0
; Platform: Win9x/NT
; Author: Alexandre BROSSE
; Date: Sat, 11 Apr. 2015
; Script Function:
; 			Installation automatique des modules Python.
; =========================================================================

; --------------------------- /INPUTS/
Global $RootPath, $PythonPath, $LogPath
$RootPath = @ScriptDir & "\PyModules\"
$LogPath = @ScriptDir & "\DLLs_install.log"

; --------------------------- /DEFINITION DES FONCTIONS/
Func DefPythonPath() ; *** Définition du chemin Python
	; // Listing des modules à implémenter	
	$PythonPath = InputBox("Lien vers le Python","Indiquer l'exécutable Python cible :","D:\Appl\Python27\python.exe")
	Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
	; // Check de la pertinence du chemin
	If Not FileExists($PythonPath) Then
		MsgBox(0,"Link Error","Exécutable inexistant")
		Exit
	Else
		Local $aPathSplit = _PathSplit($PythonPath,$sDrive,$sDir,$sFileName,$sExtension)
		If Not StringInStr($PythonPath,".exe") = 1 Then	
			MsgBox(0,"Format Error","Le fichier sélectionné n'est pas un .exe")
			Exit	
		ElseIf Not StringInStr($sFileName,"python") = 1 Then	
			MsgBox(0,"File Error","Le fichier sélectionné est incompatible car différent d'un python.exe")	
			Exit			
		EndIf
	EndIf
EndFunc
; ~~~~~~~~~~~~
Func InstallModule() ; *** Installation des modules complémentaires Python
	DefPythonPath()
	; // Listing des modules à implémenter	
	$ar_Array = _FileListToArray3($RootPath,"*",0)
	Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
	; // Initialisation du fichier 'log' de suivi
	If Not FileExists($LogPath) Then
		$hFileOpen = FileOpen($LogPath, $FO_APPEND)
		FileWrite($hFileOpen,"======================================================================================" & @CRLF)
		FileWrite($hFileOpen,"Programme: Assistant d'installation de DLLs Python complémentaires" & @CRLF)		
		FileWrite($hFileOpen,"Executed by: " & @UserName & @CRLF)
		FileWrite($hFileOpen,"Access Time: " & @MDAY &"/"& @MON &"/"& @YEAR &" - "& @HOUR &":"& @MIN &":"& @SEC & @CRLF)
		FileWrite($hFileOpen,"--------------------------------" & @CRLF)		
		FileWrite($hFileOpen,"!/env AutoIt3 | Fichier log" & @CRLF)
		FileWrite($hFileOpen,"======================================================================================" & @CRLF & @CRLF)
	Else
		$hFileOpen = FileOpen($LogPath, $FO_APPEND)
	EndIf
	; // Installation des modules		
	For $i = 1 To $ar_Array[0] Step 1
		Local $aPathSplit = _PathSplit($ar_Array[$i],$sDrive,$sDir,$sFileName,$sExtension)		
		If Not StringInStr($sExtension,".exe") = 1 Then
			FileChangeDir($ar_Array[$i])
			_RunDos($PythonPath & " setup.py install")
			_FileWriteLog($hFileOpen,"Installation du module " & $sFileName & " successfully completed",1)
		EndIf
	Next
	FileClose($hFileOpen)
EndFunc	

; --------------------------- /MAIN PROGRAM/
InstallModule()
MsgBox(0,"Flag","Installation completed.")
Exit