@ECHO off
REM =================================
SET ROOT_DIR=%~dp0
SET ROOT_DIR=%ROOT_DIR:~0,-1%
SET AUTOIT3=%ROOT_DIR%\AutoIt3
REM =================================
@ECHO ----------------
@ECHO Installation des DLLs Python en cours. Please Wait ...
"%AUTOIT3%\AutoIt3_x64.exe" %CD%\DLLs_install.au3
@ECHO Update successfully completed.
REM PAUSE
EXIT
REM =================================