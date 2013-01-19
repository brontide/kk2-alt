
ShowVersion:
	call LcdClear
	
	lrv PixelType, 1
	lrv FontSelector, f6x8

	lrv X1, 0
	lrv Y1, 10
	mPrintString sho1

	lrv X1, 0
	rvadd Y1, 9
	mPrintString sho2

	lrv X1, 0
	rvadd Y1, 9
	mPrintString sho3

	lrv X1, 0
	rvadd Y1, 9
	mPrintString sho4

	call LcdUpdate

	ldx 2000
	call WaitXms

	ret

	


sho1:	.db "Version 1.5+EXTRAS",0
sho2:	.db "By  Rolf Runar Bakke",0
sho3:	.db "    Eric Warnke",0
sho4:   .db "and Others",0
