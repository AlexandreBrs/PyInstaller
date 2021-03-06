#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

_Example()

Func _Example()
	If Not _GDIPlus_Startup() Then
		MsgBox($MB_SYSTEMMODAL, "ERROR", "GDIPlus.dll v1.1 not available")
		Return
	EndIf

	Local $sFile = FileOpenDialog("Select an image", "", "Images (*.bmp;*.png;*.jpg;*.gif;*.tif)")
	If @error Or Not FileExists($sFile) Then Return

	Local $hImage = _GDIPlus_ImageLoadFromFile($sFile)

	Local $iWidth = 600
	Local $iHeight = _GDIPlus_ImageGetHeight($hImage) * 600 / _GDIPlus_ImageGetWidth($hImage)

	Local $hGui = GUICreate("GDI+ v1.1", $iWidth, $iHeight)
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	GUISetState(@SW_SHOW)

	;Convert to a 16-color bitmap (4 bits per pixel) using diffusion dithering
	Local $tPalette = _GDIPlus_PaletteInitialize(16, $GDIP_PaletteTypeOptimal, 16, False, $hImage)
	_GDIPlus_BitmapConvertFormat($hImage, $GDIP_PXF04INDEXED, $GDIP_DitherTypeErrorDiffusion, $GDIP_PaletteTypeOptimal, $tPalette)

	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, 0, 0, $iWidth, $iHeight)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>_Example
