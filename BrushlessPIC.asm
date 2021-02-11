
_Interrupt:

;BrushlessPIC.c,47 :: 		void Interrupt(){
;BrushlessPIC.c,49 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt0
;BrushlessPIC.c,50 :: 		if (TmrSclr<Interval){
	MOVF        _Interval+1, 0 
	SUBWF       _TmrSclr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Interrupt53
	MOVF        _Interval+0, 0 
	SUBWF       _TmrSclr+0, 0 
L__Interrupt53:
	BTFSC       STATUS+0, 0 
	GOTO        L_Interrupt1
;BrushlessPIC.c,51 :: 		TmrSclr++ ;
	INFSNZ      _TmrSclr+0, 1 
	INCF        _TmrSclr+1, 1 
;BrushlessPIC.c,52 :: 		}
	GOTO        L_Interrupt2
L_Interrupt1:
;BrushlessPIC.c,54 :: 		TmrSclr = 0;
	CLRF        _TmrSclr+0 
	CLRF        _TmrSclr+1 
;BrushlessPIC.c,55 :: 		PWM9_Stop();
	CALL        _PWM9_Stop+0, 0
;BrushlessPIC.c,56 :: 		TMR0IE_bit = 0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;BrushlessPIC.c,57 :: 		TimerOut = 1;
	BSF         _TimerOut+0, BitPos(_TimerOut+0) 
;BrushlessPIC.c,58 :: 		}
L_Interrupt2:
;BrushlessPIC.c,59 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;BrushlessPIC.c,60 :: 		}
L_Interrupt0:
;BrushlessPIC.c,62 :: 		if (USBIF_bit){
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_Interrupt3
;BrushlessPIC.c,63 :: 		USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;BrushlessPIC.c,64 :: 		}
L_Interrupt3:
;BrushlessPIC.c,66 :: 		if (INT0IF_bit){
	BTFSS       INT0IF_bit+0, BitPos(INT0IF_bit+0) 
	GOTO        L_Interrupt4
;BrushlessPIC.c,67 :: 		BtnRED = 1;
	BSF         _BtnRED+0, BitPos(_BtnRED+0) 
;BrushlessPIC.c,68 :: 		INT0IF_bit=0;
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;BrushlessPIC.c,69 :: 		TMR3IE_bit=0;                        //Stop Counting
	BCF         TMR3IE_bit+0, BitPos(TMR3IE_bit+0) 
;BrushlessPIC.c,70 :: 		TMR5IE_bit=0;
	BCF         TMR5IE_bit+0, BitPos(TMR5IE_bit+0) 
;BrushlessPIC.c,71 :: 		TMR0IE_bit=0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;BrushlessPIC.c,72 :: 		}
L_Interrupt4:
;BrushlessPIC.c,74 :: 		if (TMR5IF_bit){
	BTFSS       TMR5IF_bit+0, BitPos(TMR5IF_bit+0) 
	GOTO        L_Interrupt5
;BrushlessPIC.c,75 :: 		if (tm5sclr == 24){
	MOVLW       0
	XORWF       _tm5sclr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Interrupt54
	MOVLW       24
	XORWF       _tm5sclr+0, 0 
L__Interrupt54:
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt6
;BrushlessPIC.c,76 :: 		TMR3IE_bit=0;                        //Stop Counting
	BCF         TMR3IE_bit+0, BitPos(TMR3IE_bit+0) 
;BrushlessPIC.c,77 :: 		TMR5IE_bit=0;
	BCF         TMR5IE_bit+0, BitPos(TMR5IE_bit+0) 
;BrushlessPIC.c,78 :: 		TMR5H = 0x15;
	MOVLW       21
	MOVWF       TMR5H+0 
;BrushlessPIC.c,79 :: 		TMR5L = 0xA0;
	MOVLW       160
	MOVWF       TMR5L+0 
;BrushlessPIC.c,80 :: 		}
	GOTO        L_Interrupt7
L_Interrupt6:
;BrushlessPIC.c,82 :: 		tm5sclr ++;
	INFSNZ      _tm5sclr+0, 1 
	INCF        _tm5sclr+1, 1 
;BrushlessPIC.c,83 :: 		TMR5IF_bit = 0;
	BCF         TMR5IF_bit+0, BitPos(TMR5IF_bit+0) 
;BrushlessPIC.c,84 :: 		TMR5H = 0x15;
	MOVLW       21
	MOVWF       TMR5H+0 
;BrushlessPIC.c,85 :: 		TMR5L = 0xA0;
	MOVLW       160
	MOVWF       TMR5L+0 
;BrushlessPIC.c,86 :: 		}
L_Interrupt7:
;BrushlessPIC.c,87 :: 		}
L_Interrupt5:
;BrushlessPIC.c,88 :: 		}
L_end_Interrupt:
L__Interrupt52:
	RETFIE      1
; end of _Interrupt

_GetParameters:

;BrushlessPIC.c,90 :: 		int GetParameters(){
;BrushlessPIC.c,91 :: 		int cnt = 0 ;
;BrushlessPIC.c,92 :: 		while(1){
L_GetParameters8:
;BrushlessPIC.c,93 :: 		while(!HID_Read());
L_GetParameters10:
	CALL        _HID_Read+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetParameters11
	GOTO        L_GetParameters10
L_GetParameters11:
;BrushlessPIC.c,94 :: 		LD1=~LD1;
	BTG         LATA0_bit+0, BitPos(LATA0_bit+0) 
;BrushlessPIC.c,95 :: 		res = strncmp(readbuff, "Message", 7);
	MOVLW       _readbuff+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr1_BrushlessPIC+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr1_BrushlessPIC+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       7
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVF        R1, 0 
	MOVWF       _res+1 
;BrushlessPIC.c,96 :: 		if (res == 0 ){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters56
	MOVLW       0
	XORWF       R0, 0 
L__GetParameters56:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetParameters12
;BrushlessPIC.c,97 :: 		res = strstr(readbuff, "Mode");
	MOVLW       _readbuff+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr2_BrushlessPIC+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr2_BrushlessPIC+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVF        R1, 0 
	MOVWF       _res+1 
;BrushlessPIC.c,98 :: 		if (res != 0){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters57
	MOVLW       0
	XORWF       R0, 0 
L__GetParameters57:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetParameters13
;BrushlessPIC.c,99 :: 		mode = readbuff[11]-48;
	MOVLW       48
	SUBWF       _readbuff+11, 0 
	MOVWF       _mode+0 
	CLRF        _mode+1 
	MOVLW       0
	SUBWFB      _mode+1, 1 
;BrushlessPIC.c,100 :: 		}
L_GetParameters13:
;BrushlessPIC.c,101 :: 		res = strstr(readbuff, "Speed1");
	MOVLW       _readbuff+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr3_BrushlessPIC+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr3_BrushlessPIC+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVF        R1, 0 
	MOVWF       _res+1 
;BrushlessPIC.c,102 :: 		if (res != 0){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters58
	MOVLW       0
	XORWF       R0, 0 
L__GetParameters58:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetParameters14
;BrushlessPIC.c,103 :: 		x4=readbuff[18]-48;
	MOVLW       48
	SUBWF       _readbuff+18, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _x4+0 
;BrushlessPIC.c,104 :: 		x3=readbuff[19]-48;
	MOVLW       48
	SUBWF       _readbuff+19, 0 
	MOVWF       FLOC__GetParameters+2 
	MOVF        FLOC__GetParameters+2, 0 
	MOVWF       _x3+0 
;BrushlessPIC.c,105 :: 		x2=readbuff[20]-48;
	MOVLW       48
	SUBWF       _readbuff+20, 0 
	MOVWF       FLOC__GetParameters+1 
	MOVF        FLOC__GetParameters+1, 0 
	MOVWF       _x2+0 
;BrushlessPIC.c,106 :: 		x1=readbuff[21]-48;
	MOVLW       48
	SUBWF       _readbuff+21, 0 
	MOVWF       FLOC__GetParameters+0 
	MOVF        FLOC__GetParameters+0, 0 
	MOVWF       _x1+0 
;BrushlessPIC.c,107 :: 		speed1 = x4*1000 + x3*100 + x2*10 + x1;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       100
	MULWF       FLOC__GetParameters+2 
	MOVF        PRODL+0, 0 
	MOVWF       R2 
	MOVF        PRODH+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       _speed1+0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       _speed1+1 
	MOVLW       10
	MULWF       FLOC__GetParameters+1 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _speed1+0, 1 
	MOVF        R1, 0 
	ADDWFC      _speed1+1, 1 
	MOVF        FLOC__GetParameters+0, 0 
	ADDWF       _speed1+0, 1 
	MOVLW       0
	ADDWFC      _speed1+1, 1 
;BrushlessPIC.c,108 :: 		}
L_GetParameters14:
;BrushlessPIC.c,109 :: 		res = strstr(readbuff, "Speed2");
	MOVLW       _readbuff+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr4_BrushlessPIC+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr4_BrushlessPIC+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVF        R1, 0 
	MOVWF       _res+1 
;BrushlessPIC.c,110 :: 		if (res != 0){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters59
	MOVLW       0
	XORWF       R0, 0 
L__GetParameters59:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetParameters15
;BrushlessPIC.c,111 :: 		x4=readbuff[28]-48;
	MOVLW       48
	SUBWF       _readbuff+28, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _x4+0 
;BrushlessPIC.c,112 :: 		x3=readbuff[29]-48;
	MOVLW       48
	SUBWF       _readbuff+29, 0 
	MOVWF       FLOC__GetParameters+2 
	MOVF        FLOC__GetParameters+2, 0 
	MOVWF       _x3+0 
;BrushlessPIC.c,113 :: 		x2=readbuff[30]-48;
	MOVLW       48
	SUBWF       _readbuff+30, 0 
	MOVWF       FLOC__GetParameters+1 
	MOVF        FLOC__GetParameters+1, 0 
	MOVWF       _x2+0 
;BrushlessPIC.c,114 :: 		x1=readbuff[31]-48;
	MOVLW       48
	SUBWF       _readbuff+31, 0 
	MOVWF       FLOC__GetParameters+0 
	MOVF        FLOC__GetParameters+0, 0 
	MOVWF       _x1+0 
;BrushlessPIC.c,115 :: 		speed2 = x4*1000 + x3*100 + x2*10 + x1;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       100
	MULWF       FLOC__GetParameters+2 
	MOVF        PRODL+0, 0 
	MOVWF       R2 
	MOVF        PRODH+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       _speed2+0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       _speed2+1 
	MOVLW       10
	MULWF       FLOC__GetParameters+1 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _speed2+0, 1 
	MOVF        R1, 0 
	ADDWFC      _speed2+1, 1 
	MOVF        FLOC__GetParameters+0, 0 
	ADDWF       _speed2+0, 1 
	MOVLW       0
	ADDWFC      _speed2+1, 1 
;BrushlessPIC.c,116 :: 		}
L_GetParameters15:
;BrushlessPIC.c,117 :: 		res = strstr(readbuff, "Interval1");
	MOVLW       _readbuff+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr5_BrushlessPIC+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr5_BrushlessPIC+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVF        R1, 0 
	MOVWF       _res+1 
;BrushlessPIC.c,118 :: 		if (res != 0){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters60
	MOVLW       0
	XORWF       R0, 0 
L__GetParameters60:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetParameters16
;BrushlessPIC.c,119 :: 		x4=readbuff[41]-48;
	MOVLW       48
	SUBWF       _readbuff+41, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _x4+0 
;BrushlessPIC.c,120 :: 		x3=readbuff[42]-48;
	MOVLW       48
	SUBWF       _readbuff+42, 0 
	MOVWF       FLOC__GetParameters+2 
	MOVF        FLOC__GetParameters+2, 0 
	MOVWF       _x3+0 
;BrushlessPIC.c,121 :: 		x2=readbuff[43]-48;
	MOVLW       48
	SUBWF       _readbuff+43, 0 
	MOVWF       FLOC__GetParameters+1 
	MOVF        FLOC__GetParameters+1, 0 
	MOVWF       _x2+0 
;BrushlessPIC.c,122 :: 		x1=readbuff[44]-48;
	MOVLW       48
	SUBWF       _readbuff+44, 0 
	MOVWF       FLOC__GetParameters+0 
	MOVF        FLOC__GetParameters+0, 0 
	MOVWF       _x1+0 
;BrushlessPIC.c,123 :: 		interval1 = x4*1000 + x3*100 + x2*10 + x1;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       100
	MULWF       FLOC__GetParameters+2 
	MOVF        PRODL+0, 0 
	MOVWF       R2 
	MOVF        PRODH+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       _interval1+0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       _interval1+1 
	MOVLW       10
	MULWF       FLOC__GetParameters+1 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _interval1+0, 1 
	MOVF        R1, 0 
	ADDWFC      _interval1+1, 1 
	MOVF        FLOC__GetParameters+0, 0 
	ADDWF       _interval1+0, 1 
	MOVLW       0
	ADDWFC      _interval1+1, 1 
;BrushlessPIC.c,124 :: 		}
L_GetParameters16:
;BrushlessPIC.c,125 :: 		res = strstr(readbuff, "Interval2");
	MOVLW       _readbuff+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr6_BrushlessPIC+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr6_BrushlessPIC+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVF        R1, 0 
	MOVWF       _res+1 
;BrushlessPIC.c,126 :: 		if (res != 0){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters61
	MOVLW       0
	XORWF       R0, 0 
L__GetParameters61:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetParameters17
;BrushlessPIC.c,127 :: 		x4=readbuff[54]-48;
	MOVLW       48
	SUBWF       _readbuff+54, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _x4+0 
;BrushlessPIC.c,128 :: 		x3=readbuff[55]-48;
	MOVLW       48
	SUBWF       _readbuff+55, 0 
	MOVWF       FLOC__GetParameters+2 
	MOVF        FLOC__GetParameters+2, 0 
	MOVWF       _x3+0 
;BrushlessPIC.c,129 :: 		x2=readbuff[56]-48;
	MOVLW       48
	SUBWF       _readbuff+56, 0 
	MOVWF       FLOC__GetParameters+1 
	MOVF        FLOC__GetParameters+1, 0 
	MOVWF       _x2+0 
;BrushlessPIC.c,130 :: 		x1=readbuff[57]-48;
	MOVLW       48
	SUBWF       _readbuff+57, 0 
	MOVWF       FLOC__GetParameters+0 
	MOVF        FLOC__GetParameters+0, 0 
	MOVWF       _x1+0 
;BrushlessPIC.c,131 :: 		interval2 = x4*1000 + x3*100 + x2*10 + x1;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       100
	MULWF       FLOC__GetParameters+2 
	MOVF        PRODL+0, 0 
	MOVWF       R2 
	MOVF        PRODH+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       _interval2+0 
	MOVF        R3, 0 
	ADDWFC      R1, 0 
	MOVWF       _interval2+1 
	MOVLW       10
	MULWF       FLOC__GetParameters+1 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _interval2+0, 1 
	MOVF        R1, 0 
	ADDWFC      _interval2+1, 1 
	MOVF        FLOC__GetParameters+0, 0 
	ADDWF       _interval2+0, 1 
	MOVLW       0
	ADDWFC      _interval2+1, 1 
;BrushlessPIC.c,132 :: 		}
L_GetParameters17:
;BrushlessPIC.c,133 :: 		if (mode == 0 || speed1 == 0 || interval1 == 0){
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters62
	MOVLW       0
	XORWF       _mode+0, 0 
L__GetParameters62:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetParameters47
	MOVLW       0
	XORWF       _speed1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters63
	MOVLW       0
	XORWF       _speed1+0, 0 
L__GetParameters63:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetParameters47
	MOVLW       0
	XORWF       _interval1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetParameters64
	MOVLW       0
	XORWF       _interval1+0, 0 
L__GetParameters64:
	BTFSC       STATUS+0, 2 
	GOTO        L__GetParameters47
	GOTO        L_GetParameters20
L__GetParameters47:
;BrushlessPIC.c,134 :: 		memset(writebuff, 0, 64);
	MOVLW       _writebuff+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       64
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;BrushlessPIC.c,135 :: 		memcpy(writebuff, "No Parameters Or Stopped", 24);
	MOVLW       _writebuff+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr7_BrushlessPIC+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr7_BrushlessPIC+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       24
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;BrushlessPIC.c,136 :: 		strcat(writebuff,CR_LF);
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _CR_LF+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_CR_LF+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,137 :: 		while(!HID_Write(&writebuff,64));
L_GetParameters21:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetParameters22
	GOTO        L_GetParameters21
L_GetParameters22:
;BrushlessPIC.c,138 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_GetParameters
;BrushlessPIC.c,139 :: 		}
L_GetParameters20:
;BrushlessPIC.c,141 :: 		memset(writebuff, 0, 64);
	MOVLW       _writebuff+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       64
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;BrushlessPIC.c,142 :: 		BtnRED = 0;
	BCF         _BtnRED+0, BitPos(_BtnRED+0) 
;BrushlessPIC.c,143 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_GetParameters
;BrushlessPIC.c,145 :: 		}
L_GetParameters12:
;BrushlessPIC.c,146 :: 		}
	GOTO        L_GetParameters8
;BrushlessPIC.c,147 :: 		}
L_end_GetParameters:
	RETURN      0
; end of _GetParameters

_SetTimer:

;BrushlessPIC.c,149 :: 		void SetTimer(unsigned time){
;BrushlessPIC.c,150 :: 		Interval = time;
	MOVF        FARG_SetTimer_time+0, 0 
	MOVWF       _Interval+0 
	MOVF        FARG_SetTimer_time+1, 0 
	MOVWF       _Interval+1 
;BrushlessPIC.c,151 :: 		TimerOut = 0;
	BCF         _TimerOut+0, BitPos(_TimerOut+0) 
;BrushlessPIC.c,152 :: 		BtnRED = 0;
	BCF         _BtnRED+0, BitPos(_BtnRED+0) 
;BrushlessPIC.c,153 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;BrushlessPIC.c,154 :: 		}
L_end_SetTimer:
	RETURN      0
; end of _SetTimer

_SetSpeed:

;BrushlessPIC.c,156 :: 		void SetSpeed(unsigned speed){
;BrushlessPIC.c,157 :: 		current_speed = (speed);
	MOVF        FARG_SetSpeed_speed+0, 0 
	MOVWF       _current_speed+0 
	MOVF        FARG_SetSpeed_speed+1, 0 
	MOVWF       _current_speed+1 
;BrushlessPIC.c,158 :: 		PWM9_Set_Duty(current_speed);// set newly acquired duty ratio
	MOVF        FARG_SetSpeed_speed+0, 0 
	MOVWF       FARG_PWM9_Set_Duty_new_duty+0 
	CALL        _PWM9_Set_Duty+0, 0
;BrushlessPIC.c,159 :: 		PWM9_Start();
	CALL        _PWM9_Start+0, 0
;BrushlessPIC.c,160 :: 		}
L_end_SetSpeed:
	RETURN      0
; end of _SetSpeed

_GetSpeed:

;BrushlessPIC.c,162 :: 		void GetSpeed(){
;BrushlessPIC.c,163 :: 		TMR3L  = 0;
	CLRF        TMR3L+0 
;BrushlessPIC.c,164 :: 		TMR3H = 0;
	CLRF        TMR3H+0 
;BrushlessPIC.c,165 :: 		TMR5H = 0x15;
	MOVLW       21
	MOVWF       TMR5H+0 
;BrushlessPIC.c,166 :: 		TMR5L = 0xA0;                 // set TMR5 which define one second timer
	MOVLW       160
	MOVWF       TMR5L+0 
;BrushlessPIC.c,167 :: 		TMR3IE_bit = 1;                       //start Counting
	BSF         TMR3IE_bit+0, BitPos(TMR3IE_bit+0) 
;BrushlessPIC.c,168 :: 		TMR5IE_bit = 1;                       //start timering to 1s
	BSF         TMR5IE_bit+0, BitPos(TMR5IE_bit+0) 
;BrushlessPIC.c,169 :: 		}
L_end_GetSpeed:
	RETURN      0
; end of _GetSpeed

_CalcSpeed:

;BrushlessPIC.c,171 :: 		void CalcSpeed(){
;BrushlessPIC.c,172 :: 		while(BtnRED == 0 && TimerOut == 0){
L_CalcSpeed24:
	BTFSC       _BtnRED+0, BitPos(_BtnRED+0) 
	GOTO        L_CalcSpeed25
	BTFSC       _TimerOut+0, BitPos(_TimerOut+0) 
	GOTO        L_CalcSpeed25
L__CalcSpeed48:
;BrushlessPIC.c,173 :: 		GetSpeed();
	CALL        _GetSpeed+0, 0
;BrushlessPIC.c,174 :: 		if (TmrSclr > OldTmr){
	MOVF        _TmrSclr+1, 0 
	SUBWF       _OldTmr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CalcSpeed69
	MOVF        _TmrSclr+0, 0 
	SUBWF       _OldTmr+0, 0 
L__CalcSpeed69:
	BTFSC       STATUS+0, 0 
	GOTO        L_CalcSpeed28
;BrushlessPIC.c,175 :: 		memset(writebuff, 0, 64);
	MOVLW       _writebuff+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       64
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;BrushlessPIC.c,177 :: 		memcpy(writebuff, "Progress=", 9);      //send current time progress
	MOVLW       _writebuff+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr8_BrushlessPIC+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr8_BrushlessPIC+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       9
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;BrushlessPIC.c,178 :: 		OldTmr = TmrSclr;
	MOVF        _TmrSclr+0, 0 
	MOVWF       _OldTmr+0 
	MOVF        _TmrSclr+1, 0 
	MOVWF       _OldTmr+1 
;BrushlessPIC.c,179 :: 		ByteToStr(TmrSclr,txt);
	MOVF        _TmrSclr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _txt+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;BrushlessPIC.c,180 :: 		writebuff[9]=0;                         //starting null
	CLRF        _writebuff+9 
;BrushlessPIC.c,181 :: 		strcat(writebuff,Ltrim(Rtrim((txt))));  //this function append null charecter to the end
	MOVLW       _txt+0
	MOVWF       FARG_Rtrim_string+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Ltrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_strcat_from+0 
	MOVF        R1, 0 
	MOVWF       FARG_strcat_from+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,183 :: 		strcat(writebuff, "Speed=");            //send current speed
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr9_BrushlessPIC+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr9_BrushlessPIC+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,184 :: 		OldSpd = TMR3L;
	MOVF        TMR3L+0, 0 
	MOVWF       _OldSpd+0 
	MOVLW       0
	MOVWF       _OldSpd+1 
;BrushlessPIC.c,185 :: 		TMR3L = 0;
	CLRF        TMR3L+0 
;BrushlessPIC.c,186 :: 		TMR3H = 0;
	CLRF        TMR3H+0 
;BrushlessPIC.c,187 :: 		WordToStr(OldSpd,txt);               // OldSpd*60,txt
	MOVF        _OldSpd+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _OldSpd+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;BrushlessPIC.c,189 :: 		strcat(writebuff,Ltrim(Rtrim(txt)));
	MOVLW       _txt+0
	MOVWF       FARG_Rtrim_string+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Ltrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_strcat_from+0 
	MOVF        R1, 0 
	MOVWF       FARG_strcat_from+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,190 :: 		strcat(writebuff,CR_LF);
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _CR_LF+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_CR_LF+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,191 :: 		while(!HID_Write(&writebuff,64));
L_CalcSpeed29:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_CalcSpeed30
	GOTO        L_CalcSpeed29
L_CalcSpeed30:
;BrushlessPIC.c,192 :: 		}
L_CalcSpeed28:
;BrushlessPIC.c,193 :: 		}
	GOTO        L_CalcSpeed24
L_CalcSpeed25:
;BrushlessPIC.c,194 :: 		BtnRED = 0;
	BCF         _BtnRED+0, BitPos(_BtnRED+0) 
;BrushlessPIC.c,196 :: 		OldTmr = 0;
	CLRF        _OldTmr+0 
	CLRF        _OldTmr+1 
;BrushlessPIC.c,197 :: 		OldSpd = 0;
	CLRF        _OldSpd+0 
	CLRF        _OldSpd+1 
;BrushlessPIC.c,198 :: 		memset(writebuff, 0, 64);
	MOVLW       _writebuff+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       64
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;BrushlessPIC.c,199 :: 		memcpy(writebuff, "Stop", 4);
	MOVLW       _writebuff+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?lstr10_BrushlessPIC+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr10_BrushlessPIC+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;BrushlessPIC.c,200 :: 		strcat(writebuff,CR_LF);
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _CR_LF+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_CR_LF+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,201 :: 		while(!HID_Write(&writebuff,64));
L_CalcSpeed31:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_CalcSpeed32
	GOTO        L_CalcSpeed31
L_CalcSpeed32:
;BrushlessPIC.c,202 :: 		}
L_end_CalcSpeed:
	RETURN      0
; end of _CalcSpeed

_MCU_Init:

;BrushlessPIC.c,205 :: 		void MCU_Init(){
;BrushlessPIC.c,206 :: 		ADCON0 = 0;                             //disable ADC
	CLRF        ADCON0+0 
;BrushlessPIC.c,207 :: 		ADCON1 = 0;                             //disable ADC
	CLRF        ADCON1+0 
;BrushlessPIC.c,208 :: 		ANCON0 = 0xFF;                          //disable ADC
	MOVLW       255
	MOVWF       ANCON0+0 
;BrushlessPIC.c,209 :: 		ANCON1 = 0xFF;                          //disable ADC
	MOVLW       255
	MOVWF       ANCON1+0 
;BrushlessPIC.c,210 :: 		TRISB.F3 = 1;
	BSF         TRISB+0, 3 
;BrushlessPIC.c,212 :: 		res = PPS_Mapping(6, _INPUT, _T3CKI);
	MOVLW       6
	MOVWF       FARG_PPS_Mapping_rp_num+0 
	MOVLW       1
	MOVWF       FARG_PPS_Mapping_input_output+0 
	MOVLW       4
	MOVWF       FARG_PPS_Mapping_funct_name+0 
	CALL        _PPS_Mapping+0, 0
	MOVF        R0, 0 
	MOVWF       _res+0 
	MOVLW       0
	MOVWF       _res+1 
;BrushlessPIC.c,213 :: 		T3CON = 0b10000001;                     // set TOCKI as clock counter
	MOVLW       129
	MOVWF       T3CON+0 
;BrushlessPIC.c,214 :: 		T5CON = 0b00110001;                     // set TOCKI as clock counter
	MOVLW       49
	MOVWF       T5CON+0 
;BrushlessPIC.c,215 :: 		TMR3IF_bit         = 0;
	BCF         TMR3IF_bit+0, BitPos(TMR3IF_bit+0) 
;BrushlessPIC.c,216 :: 		TMR5IF_bit         = 0;
	BCF         TMR5IF_bit+0, BitPos(TMR5IF_bit+0) 
;BrushlessPIC.c,218 :: 		HID_Enable(&readbuff,&writebuff);       // Enable HID communication
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;BrushlessPIC.c,219 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;BrushlessPIC.c,220 :: 		T1_Direction = 1;                       // Set direction for buttons
	BSF         TRISD3_bit+0, BitPos(TRISD3_bit+0) 
;BrushlessPIC.c,221 :: 		T2_Direction = 1;
	BSF         TRISD2_bit+0, BitPos(TRISD2_bit+0) 
;BrushlessPIC.c,222 :: 		LD1_Direction = 0;                      // Set direction for LEDS
	BCF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;BrushlessPIC.c,223 :: 		LD2_Direction = 0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;BrushlessPIC.c,224 :: 		LD1 = 0;                                // turn off leds
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;BrushlessPIC.c,225 :: 		LD2 = 0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;BrushlessPIC.c,226 :: 		LD1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;BrushlessPIC.c,227 :: 		LD2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;BrushlessPIC.c,228 :: 		TRISB2_bit = 0;           // direction pin = RST
	BCF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;BrushlessPIC.c,229 :: 		TRISC6_bit = 0;           // pwm clicker
	BCF         TRISC6_bit+0, BitPos(TRISC6_bit+0) 
;BrushlessPIC.c,230 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_MCU_Init33:
	DECFSZ      R13, 1, 1
	BRA         L_MCU_Init33
	DECFSZ      R12, 1, 1
	BRA         L_MCU_Init33
	DECFSZ      R11, 1, 1
	BRA         L_MCU_Init33
	NOP
;BrushlessPIC.c,232 :: 		current_speed = 0;                  //initial value for current duty.
	CLRF        _current_speed+0 
	CLRF        _current_speed+1 
;BrushlessPIC.c,233 :: 		PWM9_Init(8000);                    // Initialize PWM2 module at 5kHz
	MOVLW       64
	MOVWF       FARG_PWM9_Init_PWM_Freq+0 
	MOVLW       31
	MOVWF       FARG_PWM9_Init_PWM_Freq+1 
	MOVLW       0
	MOVWF       FARG_PWM9_Init_PWM_Freq+2 
	MOVWF       FARG_PWM9_Init_PWM_Freq+3 
	CALL        _PWM9_Init+0, 0
;BrushlessPIC.c,234 :: 		PWM9_Set_Duty(0);            // Set current duty for PWM2
	CLRF        FARG_PWM9_Set_Duty_new_duty+0 
	CALL        _PWM9_Set_Duty+0, 0
;BrushlessPIC.c,235 :: 		MOTOR_DIR = CCW;             // Setting motor direction to counter-clock-wise
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;BrushlessPIC.c,237 :: 		T0CON         = 0x87;      //10000111 full prescaller 1:256
	MOVLW       135
	MOVWF       T0CON+0 
;BrushlessPIC.c,238 :: 		TMR0H         = 0x48;
	MOVLW       72
	MOVWF       TMR0H+0 
;BrushlessPIC.c,239 :: 		TMR0L         = 0xE5;
	MOVLW       229
	MOVWF       TMR0L+0 
;BrushlessPIC.c,241 :: 		INT0IE_bit = 1;
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;BrushlessPIC.c,242 :: 		INTEDG0_bit = 1; //on rising edge
	BSF         INTEDG0_bit+0, BitPos(INTEDG0_bit+0) 
;BrushlessPIC.c,244 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;BrushlessPIC.c,245 :: 		}
L_end_MCU_Init:
	RETURN      0
; end of _MCU_Init

_main:

;BrushlessPIC.c,247 :: 		void main(){
;BrushlessPIC.c,248 :: 		MCU_Init();
	CALL        _MCU_Init+0, 0
;BrushlessPIC.c,249 :: 		CR_LF[0] = 0x0D;
	MOVLW       13
	MOVWF       _CR_LF+0 
;BrushlessPIC.c,250 :: 		CR_LF[1] = 0x0A;
	MOVLW       10
	MOVWF       _CR_LF+1 
;BrushlessPIC.c,251 :: 		strcat(writebuff,CR_LF);
	MOVLW       _writebuff+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _CR_LF+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_CR_LF+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;BrushlessPIC.c,252 :: 		while(!HID_Write(&writebuff,64));
L_main34:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
	GOTO        L_main34
L_main35:
;BrushlessPIC.c,254 :: 		while(1){
L_main36:
;BrushlessPIC.c,255 :: 		while(GetParameters()){
L_main38:
	CALL        _GetParameters+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
;BrushlessPIC.c,256 :: 		if ( mode == 1 && BtnRED == 0){            //only one speed and Interval
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main72
	MOVLW       1
	XORWF       _mode+0, 0 
L__main72:
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
	BTFSC       _BtnRED+0, BitPos(_BtnRED+0) 
	GOTO        L_main42
L__main50:
;BrushlessPIC.c,257 :: 		SetTimer(interval1);     //set timer interval
	MOVF        _interval1+0, 0 
	MOVWF       FARG_SetTimer_time+0 
	MOVF        _interval1+1, 0 
	MOVWF       FARG_SetTimer_time+1 
	CALL        _SetTimer+0, 0
;BrushlessPIC.c,258 :: 		SetSpeed(speed1);        //set speed
	MOVF        _speed1+0, 0 
	MOVWF       FARG_SetSpeed_speed+0 
	MOVF        _speed1+1, 0 
	MOVWF       FARG_SetSpeed_speed+1 
	CALL        _SetSpeed+0, 0
;BrushlessPIC.c,259 :: 		CalcSpeed();             //start monitering speed
	CALL        _CalcSpeed+0, 0
;BrushlessPIC.c,260 :: 		}
	GOTO        L_main43
L_main42:
;BrushlessPIC.c,261 :: 		else if (mode == 2 && BtnRED == 0){        // two speed and interval
	MOVLW       0
	XORWF       _mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main73
	MOVLW       2
	XORWF       _mode+0, 0 
L__main73:
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
	BTFSC       _BtnRED+0, BitPos(_BtnRED+0) 
	GOTO        L_main46
L__main49:
;BrushlessPIC.c,262 :: 		SetTimer(interval1);     //set timer interval
	MOVF        _interval1+0, 0 
	MOVWF       FARG_SetTimer_time+0 
	MOVF        _interval1+1, 0 
	MOVWF       FARG_SetTimer_time+1 
	CALL        _SetTimer+0, 0
;BrushlessPIC.c,263 :: 		SetSpeed(speed1);        //set speed
	MOVF        _speed1+0, 0 
	MOVWF       FARG_SetSpeed_speed+0 
	MOVF        _speed1+1, 0 
	MOVWF       FARG_SetSpeed_speed+1 
	CALL        _SetSpeed+0, 0
;BrushlessPIC.c,264 :: 		CalcSpeed();             //start monitering speed
	CALL        _CalcSpeed+0, 0
;BrushlessPIC.c,265 :: 		SetTimer(interval2);     //set timer interval
	MOVF        _interval2+0, 0 
	MOVWF       FARG_SetTimer_time+0 
	MOVF        _interval2+1, 0 
	MOVWF       FARG_SetTimer_time+1 
	CALL        _SetTimer+0, 0
;BrushlessPIC.c,266 :: 		SetSpeed(speed2);        //set speed
	MOVF        _speed2+0, 0 
	MOVWF       FARG_SetSpeed_speed+0 
	MOVF        _speed2+1, 0 
	MOVWF       FARG_SetSpeed_speed+1 
	CALL        _SetSpeed+0, 0
;BrushlessPIC.c,267 :: 		CalcSpeed();             //start monitering speed
	CALL        _CalcSpeed+0, 0
;BrushlessPIC.c,268 :: 		}
L_main46:
L_main43:
;BrushlessPIC.c,270 :: 		mode=0;
	CLRF        _mode+0 
	CLRF        _mode+1 
;BrushlessPIC.c,271 :: 		speed1 = 0;
	CLRF        _speed1+0 
	CLRF        _speed1+1 
;BrushlessPIC.c,272 :: 		speed2 = 0;
	CLRF        _speed2+0 
	CLRF        _speed2+1 
;BrushlessPIC.c,273 :: 		Interval1 = 0;
	CLRF        _interval1+0 
	CLRF        _interval1+1 
;BrushlessPIC.c,274 :: 		Interval2 = 0;
	CLRF        _interval2+0 
	CLRF        _interval2+1 
;BrushlessPIC.c,275 :: 		}
	GOTO        L_main38
L_main39:
;BrushlessPIC.c,276 :: 		}
	GOTO        L_main36
;BrushlessPIC.c,277 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
