
CameraStabSetup:

.def Item		= r17

cam11:	call LcdClear
	
	lrv PixelType, 1
	lrv FontSelector, f6x8

	lrv X1,0
	lrv Y1,1
	mPrintString cams2
	ldz eeCamRollGain
	call GetEeVariable16 
 	call Print16Signed 

	lrv X1,0
	lrv Y1,10
	mPrintString cams3
	call GetEeVariable16 
 	call Print16Signed 

	lrv X1,0
	lrv Y1,19
	mPrintString cams4
	call GetEeVariable16 
 	call Print16Signed 

	lrv X1,0
	lrv Y1,28
	mPrintString cams5
	call GetEeVariable16 
 	call Print16Signed 

	lrv X1,0
	lrv Y1,37
	mPrintString cams6
	ldz eeCamServoMixing
	call GetEeVariable8 
	brflagfalse xl, cam18
	mPrintString cams8
	rjmp cam19
cam18:	mPrintString cams7
cam19:

	;footer
	lrv X1, 0
	lrv Y1, 57
	mPrintString cams9

	;print selector
	ldzarray cam7*2, 4, Item
	lpm t, z+
	sts X1, t
	lpm t, z+
	sts Y1, t
	lpm t, z+
	sts X2, t
	lpm t, z
	sts Y2, t
	lrv PixelType, 0
	call HilightRectangle

	call LcdUpdate

	call GetButtonsBlocking

	cpi t, 0x08		;BACK?
	brne cam8
	ret	

cam8:	cpi t, 0x04		;PREV?
	brne cam9	
	dec Item
	brpl cam10
	ldi Item, 3
cam10:	rjmp cam11	

cam9:	cpi t, 0x02		;NEXT?
	brne cam12
	inc Item
	cpi item, 5
	brne cam13
	ldi Item, 0
cam13:	rjmp cam11	

cam12:	cpi t, 0x01		;CHANGE?
	brne cam14

	cpi item, 4
	brne cam30

	ldz eeCamServoMixing
	call GetEeVariable8
	ldi t, 0x80
	eor xl, t
	ldz eeCamServoMixing
	call StoreEeVariable8
	rjmp cam31

cam30:	ldzarray eeCamRollGain, 2, Item
	call GetEeVariable16
	ldy -32000		;lower limit
	ldz 32000		;upper limit
	call NumberEdit
	mov xl, r0
	mov xh, r1
	ldzarray eeCamRollGain, 2, Item
	call StoreEeVariable16

cam31:

cam14:	rjmp cam11




;cam1:	.db "Camera Stab Setup", 0
cams2:	.db "Roll gain    :", 0,0
cams3:	.db "Roll offset  :", 0,0
cams4:	.db "Pitch gain   :", 0,0
cams5:	.db "Pitch offset :", 0,0
cams6:	.db "Mixing       :", 0,0
cams7:	.db "None", 0,0
cams8:	.db "Diff", 0,0
cams9:	.db "BACK PREV NEXT CHANGE", 0



cam7:	.db 83, 0, 110, 9
	.db 83, 9, 110, 18
	.db 83, 18, 110, 27
	.db 83, 27, 110, 36
	.db 83, 36, 110, 45


.undef Item






CameraStab:

	b16mov CamRoll, CamRollOffset			;calculate camera angles
	b16mul Temp, EulerAngleRoll, CamRollGain
	b16add CamRoll, CamRoll, Temp

	b16mov CamPitch, CamPitchOffset
	b16mul Temp, EulerAnglePitch, CamPitchGain
	b16add CamPitch, CamPitch, Temp
	

	


	b16clr Temp				;only update Out7, Out8 if CamRollGain and CamPitchGain is non-zero.
	b16cmp CamRollGain, Temp
	brne cam22
	rjmp cam20
cam22:	b16cmp CamPitchGain, Temp
	brne cam23
	rjmp cam20
cam23:
	ldz eeCamServoMixing			
	call GetEeVariable8
	brflagfalse xl, cam24			; jump for regular output, otherwise differential mixing
	b16sub Out7, CamRoll, CamPitch	
	b16add Out8, CamRoll, CamPitch
	rjmp cam25
cam24:  
	b16mov Out7, CamRoll
	b16mov Out8, CamPitch
cam25:
	b16mov Offset7, CamRollOffset
	b16mov Offset8, CamPitchOffset

cam20:	ret
