
_Gpio_Init:

;Solar_Auto_Switcher.c,140 :: 		void Gpio_Init()
;Solar_Auto_Switcher.c,142 :: 		DDRD.B6=1; // Relay_L_Solar set as output
	IN         R27, DDRD+0
	SBR        R27, 64
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,143 :: 		DDRD.B7=1; // Relay_L_Solar_2 set as output
	IN         R27, DDRD+0
	SBR        R27, 128
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,144 :: 		DDRD.B2=0; // Set as input
	IN         R27, DDRD+0
	CBR        R27, 4
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,145 :: 		DDRD.B1=0; // decrement set as input
	IN         R27, DDRD+0
	CBR        R27, 2
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,146 :: 		DDRD.B0=0; // increment set as input
	IN         R27, DDRD+0
	CBR        R27, 1
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,147 :: 		DDRD.B3=0; // set ac_available as input
	IN         R27, DDRD+0
	CBR        R27, 8
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,148 :: 		DDRC.B2=1; // set buzzer as output
	IN         R27, DDRC+0
	SBR        R27, 4
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,149 :: 		DDRC.B0=0;  //SET EXIT AS INPUT
	IN         R27, DDRC+0
	CBR        R27, 1
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,150 :: 		}
L_end_Gpio_Init:
	RET
; end of _Gpio_Init

_Write_Time:

;Solar_Auto_Switcher.c,153 :: 		void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
;Solar_Auto_Switcher.c,155 :: 		write_Ds1307(0x00,seconds);           //seconds
	PUSH       R2
	PUSH       R3
	MOVW       R16, R2
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	MOV        R3, R16
	CLR        R2
	CALL       _write_Ds1307+0
	POP        R4
	POP        R5
;Solar_Auto_Switcher.c,156 :: 		write_Ds1307(0x01,minutes);          // minutes
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,157 :: 		write_Ds1307(0x02,hours); // using the 24 hour system
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,158 :: 		}
L_end_Write_Time:
	POP        R3
	POP        R2
	RET
; end of _Write_Time

_Write_Date:

;Solar_Auto_Switcher.c,161 :: 		void Write_Date(unsigned int day, unsigned int month,unsigned int year)
;Solar_Auto_Switcher.c,163 :: 		write_Ds1307(0x04,day);          //01-31
	PUSH       R2
	PUSH       R3
	MOVW       R16, R2
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	MOV        R3, R16
	LDI        R27, 4
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R4
	POP        R5
;Solar_Auto_Switcher.c,164 :: 		Write_Ds1307(0x05,month);       //01-12
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,165 :: 		Write_Ds1307(0x06,year);       // 00-99
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,166 :: 		}
L_end_Write_Date:
	POP        R3
	POP        R2
	RET
; end of _Write_Date

_Config:

;Solar_Auto_Switcher.c,168 :: 		void Config()
;Solar_Auto_Switcher.c,170 :: 		GPIO_Init();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _Gpio_Init+0
;Solar_Auto_Switcher.c,171 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,172 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,173 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,174 :: 		LCD_OUT(1,1,"Starting ... ");
	LDI        R27, #lo_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,175 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_Config0:
	DEC        R16
	BRNE       L_Config0
	DEC        R17
	BRNE       L_Config0
	DEC        R18
	BRNE       L_Config0
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,176 :: 		}
L_end_Config:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Config

_LCD_Clear:

;Solar_Auto_Switcher.c,179 :: 		void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
;Solar_Auto_Switcher.c,182 :: 		for(Column=Start; Column<=End; Column++)
; Column start address is: 17 (R17)
	MOV        R17, R3
; Column end address is: 17 (R17)
L_LCD_Clear2:
; Column start address is: 17 (R17)
	CP         R4, R17
	BRSH       L__LCD_Clear869
	JMP        L_LCD_Clear3
L__LCD_Clear869:
;Solar_Auto_Switcher.c,184 :: 		Lcd_Chr(Row,Column,32);
	PUSH       R17
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 32
	MOV        R4, R27
	MOV        R3, R17
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
	POP        R4
	POP        R17
;Solar_Auto_Switcher.c,182 :: 		for(Column=Start; Column<=End; Column++)
	MOV        R16, R17
	SUBI       R16, 255
	MOV        R17, R16
;Solar_Auto_Switcher.c,185 :: 		}
; Column end address is: 17 (R17)
	JMP        L_LCD_Clear2
L_LCD_Clear3:
;Solar_Auto_Switcher.c,186 :: 		}
L_end_LCD_Clear:
	RET
; end of _LCD_Clear

_Config_Interrupts:

;Solar_Auto_Switcher.c,189 :: 		void Config_Interrupts()
;Solar_Auto_Switcher.c,191 :: 		ISC10_bit=1;   // Config The rising edge of INT0 generates an interrupt request.
	LDS        R27, ISC10_bit+0
	SBR        R27, BitMask(ISC10_bit+0)
	STS        ISC10_bit+0, R27
;Solar_Auto_Switcher.c,192 :: 		ISC11_bit=1;
	LDS        R27, ISC11_bit+0
	SBR        R27, BitMask(ISC11_bit+0)
	STS        ISC11_bit+0, R27
;Solar_Auto_Switcher.c,193 :: 		INT1_bit=1;
	IN         R27, INT1_bit+0
	SBR        R27, BitMask(INT1_bit+0)
	OUT        INT1_bit+0, R27
;Solar_Auto_Switcher.c,194 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,195 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_Interrupt_INT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,199 :: 		void Interrupt_INT1 () iv IVT_ADDR_INT1
;Solar_Auto_Switcher.c,201 :: 		AcBuzzerActiveTimes=0; // FOR ACTIVING BUZZER ONCE AGAIN
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,203 :: 		if(AC_Available==1 && Timer_isOn==0  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1631
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1872
	JMP        L__Interrupt_INT1630
L__Interrupt_INT1872:
L__Interrupt_INT1629:
;Solar_Auto_Switcher.c,207 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,208 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,209 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,203 :: 		if(AC_Available==1 && Timer_isOn==0  )
L__Interrupt_INT1631:
L__Interrupt_INT1630:
;Solar_Auto_Switcher.c,212 :: 		if (AC_Available==1 && Timer_2_isOn==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1633
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1873
	JMP        L__Interrupt_INT1632
L__Interrupt_INT1873:
L__Interrupt_INT1628:
;Solar_Auto_Switcher.c,216 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,217 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,218 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,212 :: 		if (AC_Available==1 && Timer_2_isOn==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__Interrupt_INT1633:
L__Interrupt_INT1632:
;Solar_Auto_Switcher.c,220 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,222 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,223 :: 		INTF1_bit=1;     //clear  flag
	IN         R27, INTF1_bit+0
	SBR        R27, BitMask(INTF1_bit+0)
	OUT        INTF1_bit+0, R27
;Solar_Auto_Switcher.c,224 :: 		}
L_end_Interrupt_INT1:
	POP        R4
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interrupt_INT1

_EEPROM_Load:

;Solar_Auto_Switcher.c,227 :: 		void EEPROM_Load()
;Solar_Auto_Switcher.c,230 :: 		hours_lcd_1=EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,231 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,232 :: 		hours_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,233 :: 		minutes_lcd_2=EEPROM_Read(0x04);
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,235 :: 		hours_lcd_timer2_start=EEPROM_Read(0x18);
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,236 :: 		minutes_lcd_timer2_start=EEPROM_Read(0x19);
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,237 :: 		hours_lcd_timer2_stop=EEPROM_Read(0x20);
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,238 :: 		minutes_lcd_timer2_stop=EEPROM_Read(0x21);
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,241 :: 		ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
	LDI        R27, 0
	STS        _ByPassState+0, R27
;Solar_Auto_Switcher.c,243 :: 		Timer_Enable=1;      // delete function to be programmed for rom space
	LDI        R27, 1
	STS        _Timer_Enable+0, R27
;Solar_Auto_Switcher.c,244 :: 		High_Voltage=EEPROM_Read(0x12); // load high voltage
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _High_Voltage+0, R16
	LDI        R27, 0
	STS        _High_Voltage+1, R27
;Solar_Auto_Switcher.c,245 :: 		Low_Voltage=EEPROM_Read(0x13); // load low voltage
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Low_Voltage+0, R16
	LDI        R27, 0
	STS        _Low_Voltage+1, R27
;Solar_Auto_Switcher.c,246 :: 		VoltageProtectionEnable=EEPROM_Read(0x15);
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _VoltageProtectionEnable+0, R16
;Solar_Auto_Switcher.c,250 :: 		}
L_end_EEPROM_Load:
	POP        R3
	POP        R2
	RET
; end of _EEPROM_Load

_StoreBytesIntoEEprom:

;Solar_Auto_Switcher.c,253 :: 		void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,256 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_StoreBytesIntoEEprom11:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__StoreBytesIntoEEprom876
	JMP        L_StoreBytesIntoEEprom12
L__StoreBytesIntoEEprom876:
;Solar_Auto_Switcher.c,258 :: 		EEprom_Write(address+j,*(ptr+j));
	MOV        R30, R19
	MOV        R31, R20
	ADD        R30, R4
	ADC        R31, R5
	LD         R18, Z
	MOV        R16, R19
	MOV        R17, R20
	ADD        R16, R2
	ADC        R17, R3
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	MOV        R4, R18
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;Solar_Auto_Switcher.c,259 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_StoreBytesIntoEEprom14:
	DEC        R16
	BRNE       L_StoreBytesIntoEEprom14
	DEC        R17
	BRNE       L_StoreBytesIntoEEprom14
	DEC        R18
	BRNE       L_StoreBytesIntoEEprom14
;Solar_Auto_Switcher.c,256 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,260 :: 		};
; j end address is: 19 (R19)
	JMP        L_StoreBytesIntoEEprom11
L_StoreBytesIntoEEprom12:
;Solar_Auto_Switcher.c,261 :: 		}
L_end_StoreBytesIntoEEprom:
	RET
; end of _StoreBytesIntoEEprom

_ReadBytesFromEEprom:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Auto_Switcher.c,264 :: 		void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,267 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_ReadBytesFromEEprom16:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__ReadBytesFromEEprom878
	JMP        L_ReadBytesFromEEprom17
L__ReadBytesFromEEprom878:
;Solar_Auto_Switcher.c,269 :: 		*(ptr+j)=EEPROM_Read(address+j);
	MOV        R16, R19
	MOV        R17, R20
	ADD        R16, R4
	ADC        R17, R5
	STD        Y+0, R16
	STD        Y+1, R17
	MOV        R16, R19
	MOV        R17, R20
	ADD        R16, R2
	ADC        R17, R3
	PUSH       R3
	PUSH       R2
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	POP        R2
	POP        R3
	LDD        R17, Y+0
	LDD        R18, Y+1
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;Solar_Auto_Switcher.c,270 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_ReadBytesFromEEprom19:
	DEC        R16
	BRNE       L_ReadBytesFromEEprom19
	DEC        R17
	BRNE       L_ReadBytesFromEEprom19
	DEC        R18
	BRNE       L_ReadBytesFromEEprom19
;Solar_Auto_Switcher.c,267 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,271 :: 		}
; j end address is: 19 (R19)
	JMP        L_ReadBytesFromEEprom16
L_ReadBytesFromEEprom17:
;Solar_Auto_Switcher.c,272 :: 		}
L_end_ReadBytesFromEEprom:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ReadBytesFromEEprom

_Check_Timers:

;Solar_Auto_Switcher.c,275 :: 		void Check_Timers()
;Solar_Auto_Switcher.c,278 :: 		matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R4, _hours_lcd_1+0
	LDS        R3, _minutes_lcd_1+0
	LDS        R2, _seconds_lcd_1+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_1_start+0, R16
;Solar_Auto_Switcher.c,279 :: 		matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
	LDS        R4, _hours_lcd_2+0
	LDS        R3, _minutes_lcd_2+0
	LDS        R2, _seconds_lcd_2+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_1_stop+0, R16
;Solar_Auto_Switcher.c,280 :: 		matched_timer_2_start=CheckTimeOccuredOn(seconds_lcd_timer2_start,minutes_lcd_timer2_start,hours_lcd_timer2_start);
	LDS        R4, _hours_lcd_timer2_start+0
	LDS        R3, _minutes_lcd_timer2_start+0
	LDS        R2, _seconds_lcd_timer2_start+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_2_start+0, R16
;Solar_Auto_Switcher.c,281 :: 		matched_timer_2_stop=CheckTimeOccuredOff(seconds_lcd_timer2_stop,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
	LDS        R4, _hours_lcd_timer2_stop+0
	LDS        R3, _minutes_lcd_timer2_stop+0
	LDS        R2, _seconds_lcd_timer2_stop+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_2_stop+0, R16
;Solar_Auto_Switcher.c,284 :: 		if (matched_timer_1_start==1)
	LDS        R16, _matched_timer_1_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers880
	JMP        L_Check_Timers21
L__Check_Timers880:
;Solar_Auto_Switcher.c,286 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,287 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,288 :: 		EEPROM_write(0x49,1);        //- save it to eeprom if power is cut
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,291 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers656
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers881
	JMP        L__Check_Timers655
L__Check_Timers881:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers882
	LDI        R16, 1
L__Check_Timers882:
	TST        R16
	BRNE       L__Check_Timers883
	JMP        L__Check_Timers654
L__Check_Timers883:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers884
	JMP        L__Check_Timers653
L__Check_Timers884:
L__Check_Timers652:
;Solar_Auto_Switcher.c,293 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,291 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
L__Check_Timers656:
L__Check_Timers655:
L__Check_Timers654:
L__Check_Timers653:
;Solar_Auto_Switcher.c,297 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers659
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers885
	JMP        L__Check_Timers658
L__Check_Timers885:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers886
	JMP        L__Check_Timers657
L__Check_Timers886:
L__Check_Timers651:
;Solar_Auto_Switcher.c,299 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,297 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers659:
L__Check_Timers658:
L__Check_Timers657:
;Solar_Auto_Switcher.c,301 :: 		} // end if ac_available
L_Check_Timers21:
;Solar_Auto_Switcher.c,304 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers887
	JMP        L_Check_Timers28
L__Check_Timers887:
;Solar_Auto_Switcher.c,306 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,307 :: 		EEPROM_write(0x49,0);        //- save it to eeprom if power is cut
	CLR        R4
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,309 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers662
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers888
	JMP        L__Check_Timers661
L__Check_Timers888:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers889
	JMP        L__Check_Timers660
L__Check_Timers889:
L__Check_Timers650:
;Solar_Auto_Switcher.c,312 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,313 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,309 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
L__Check_Timers662:
L__Check_Timers661:
L__Check_Timers660:
;Solar_Auto_Switcher.c,316 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers665
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers890
	JMP        L__Check_Timers664
L__Check_Timers890:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers891
	JMP        L__Check_Timers663
L__Check_Timers891:
L__Check_Timers649:
;Solar_Auto_Switcher.c,319 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,320 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,316 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
L__Check_Timers665:
L__Check_Timers664:
L__Check_Timers663:
;Solar_Auto_Switcher.c,322 :: 		}
L_Check_Timers28:
;Solar_Auto_Switcher.c,326 :: 		if (matched_timer_2_start==1)
	LDS        R16, _matched_timer_2_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers892
	JMP        L_Check_Timers35
L__Check_Timers892:
;Solar_Auto_Switcher.c,328 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,329 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,330 :: 		EEPROM_write(0x50,1);        //- save it to eeprom if power is cut
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,332 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers669
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers893
	JMP        L__Check_Timers668
L__Check_Timers893:
	LDS        R20, _StartLoadsVoltage_T2+0
	LDS        R21, _StartLoadsVoltage_T2+1
	LDS        R22, _StartLoadsVoltage_T2+2
	LDS        R23, _StartLoadsVoltage_T2+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers894
	LDI        R16, 1
L__Check_Timers894:
	TST        R16
	BRNE       L__Check_Timers895
	JMP        L__Check_Timers667
L__Check_Timers895:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers896
	JMP        L__Check_Timers666
L__Check_Timers896:
L__Check_Timers648:
;Solar_Auto_Switcher.c,334 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,332 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
L__Check_Timers669:
L__Check_Timers668:
L__Check_Timers667:
L__Check_Timers666:
;Solar_Auto_Switcher.c,338 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers672
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers897
	JMP        L__Check_Timers671
L__Check_Timers897:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers898
	JMP        L__Check_Timers670
L__Check_Timers898:
L__Check_Timers647:
;Solar_Auto_Switcher.c,340 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,338 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
L__Check_Timers672:
L__Check_Timers671:
L__Check_Timers670:
;Solar_Auto_Switcher.c,343 :: 		} // end if ac_available
L_Check_Timers35:
;Solar_Auto_Switcher.c,346 :: 		if (matched_timer_2_stop==1)
	LDS        R16, _matched_timer_2_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers899
	JMP        L_Check_Timers42
L__Check_Timers899:
;Solar_Auto_Switcher.c,348 :: 		Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,349 :: 		EEPROM_write(0x50,0);        //- save it to eeprom if power is cut
	CLR        R4
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,351 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers675
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers900
	JMP        L__Check_Timers674
L__Check_Timers900:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers901
	JMP        L__Check_Timers673
L__Check_Timers901:
L__Check_Timers646:
;Solar_Auto_Switcher.c,355 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,356 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,357 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,351 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
L__Check_Timers675:
L__Check_Timers674:
L__Check_Timers673:
;Solar_Auto_Switcher.c,360 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers678
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers902
	JMP        L__Check_Timers677
L__Check_Timers902:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers903
	JMP        L__Check_Timers676
L__Check_Timers903:
L__Check_Timers645:
;Solar_Auto_Switcher.c,362 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,363 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,360 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers678:
L__Check_Timers677:
L__Check_Timers676:
;Solar_Auto_Switcher.c,366 :: 		} // end match timer stop
L_Check_Timers42:
;Solar_Auto_Switcher.c,371 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 )       //bypass enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers685
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers904
	JMP        L__Check_Timers684
L__Check_Timers904:
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 1
	BREQ       L__Check_Timers905
	JMP        L__Check_Timers683
L__Check_Timers905:
L__Check_Timers644:
;Solar_Auto_Switcher.c,374 :: 		Delay_ms(500);       // for error to get one seconds approxmiallty
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Check_Timers52:
	DEC        R16
	BRNE       L_Check_Timers52
	DEC        R17
	BRNE       L_Check_Timers52
	DEC        R18
	BRNE       L_Check_Timers52
	NOP
;Solar_Auto_Switcher.c,375 :: 		SecondsRealTime++;
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTime+0, R16
	STS        _SecondsRealTime+1, R17
;Solar_Auto_Switcher.c,376 :: 		if (SecondsRealTime==10)
	CPI        R17, 0
	BRNE       L__Check_Timers906
	CPI        R16, 10
L__Check_Timers906:
	BREQ       L__Check_Timers907
	JMP        L_Check_Timers54
L__Check_Timers907:
;Solar_Auto_Switcher.c,378 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,379 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,380 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,381 :: 		}
L_Check_Timers54:
;Solar_Auto_Switcher.c,382 :: 		if (SecondsRealTime==100)
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	CPI        R17, 0
	BRNE       L__Check_Timers908
	CPI        R16, 100
L__Check_Timers908:
	BREQ       L__Check_Timers909
	JMP        L_Check_Timers55
L__Check_Timers909:
;Solar_Auto_Switcher.c,384 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,385 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,386 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,387 :: 		}
L_Check_Timers55:
;Solar_Auto_Switcher.c,389 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers910
	JMP        L__Check_Timers680
L__Check_Timers910:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers679
L__Check_Timers643:
;Solar_Auto_Switcher.c,392 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,389 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers680:
L__Check_Timers679:
;Solar_Auto_Switcher.c,395 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers911
	JMP        L__Check_Timers682
L__Check_Timers911:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers681
L__Check_Timers642:
;Solar_Auto_Switcher.c,397 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,395 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers682:
L__Check_Timers681:
;Solar_Auto_Switcher.c,400 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,371 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 )       //bypass enabled
L__Check_Timers685:
L__Check_Timers684:
L__Check_Timers683:
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 && VoltageProtectorGood==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers687
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Check_Timers912
	JMP        L__Check_Timers686
L__Check_Timers912:
L__Check_Timers641:
;Solar_Auto_Switcher.c,408 :: 		Start_Timer_0_A();         // give some time ac grid to stabilize
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 && VoltageProtectorGood==0)
L__Check_Timers687:
L__Check_Timers686:
;Solar_Auto_Switcher.c,430 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers690
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers913
	JMP        L__Check_Timers689
L__Check_Timers913:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers914
	JMP        L__Check_Timers688
L__Check_Timers914:
L__Check_Timers640:
;Solar_Auto_Switcher.c,432 :: 		LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,430 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
L__Check_Timers690:
L__Check_Timers689:
L__Check_Timers688:
;Solar_Auto_Switcher.c,442 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers695
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers915
	JMP        L__Check_Timers694
L__Check_Timers915:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers916
	LDI        R16, 1
L__Check_Timers916:
	TST        R16
	BRNE       L__Check_Timers917
	JMP        L__Check_Timers693
L__Check_Timers917:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers918
	JMP        L__Check_Timers692
L__Check_Timers918:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers919
	JMP        L__Check_Timers691
L__Check_Timers919:
L__Check_Timers639:
;Solar_Auto_Switcher.c,444 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,445 :: 		Delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_Check_Timers71:
	DEC        R16
	BRNE       L_Check_Timers71
	DEC        R17
	BRNE       L_Check_Timers71
	DEC        R18
	BRNE       L_Check_Timers71
;Solar_Auto_Switcher.c,446 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers920
	JMP        L_Check_Timers73
L__Check_Timers920:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers73:
;Solar_Auto_Switcher.c,442 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
L__Check_Timers695:
L__Check_Timers694:
L__Check_Timers693:
L__Check_Timers692:
L__Check_Timers691:
;Solar_Auto_Switcher.c,449 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers699
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers921
	JMP        L__Check_Timers698
L__Check_Timers921:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers922
	JMP        L__Check_Timers697
L__Check_Timers922:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers923
	JMP        L__Check_Timers696
L__Check_Timers923:
L__Check_Timers638:
;Solar_Auto_Switcher.c,451 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,452 :: 		Delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_Check_Timers77:
	DEC        R16
	BRNE       L_Check_Timers77
	DEC        R17
	BRNE       L_Check_Timers77
	DEC        R18
	BRNE       L_Check_Timers77
;Solar_Auto_Switcher.c,453 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers924
	JMP        L_Check_Timers79
L__Check_Timers924:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers79:
;Solar_Auto_Switcher.c,449 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
L__Check_Timers699:
L__Check_Timers698:
L__Check_Timers697:
L__Check_Timers696:
;Solar_Auto_Switcher.c,457 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers704
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers925
	JMP        L__Check_Timers703
L__Check_Timers925:
	LDS        R20, _StartLoadsVoltage_T2+0
	LDS        R21, _StartLoadsVoltage_T2+1
	LDS        R22, _StartLoadsVoltage_T2+2
	LDS        R23, _StartLoadsVoltage_T2+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers926
	LDI        R16, 1
L__Check_Timers926:
	TST        R16
	BRNE       L__Check_Timers927
	JMP        L__Check_Timers702
L__Check_Timers927:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers928
	JMP        L__Check_Timers701
L__Check_Timers928:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers929
	JMP        L__Check_Timers700
L__Check_Timers929:
L__Check_Timers637:
;Solar_Auto_Switcher.c,459 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,460 :: 		Delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_Check_Timers83:
	DEC        R16
	BRNE       L_Check_Timers83
	DEC        R17
	BRNE       L_Check_Timers83
	DEC        R18
	BRNE       L_Check_Timers83
;Solar_Auto_Switcher.c,461 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers930
	JMP        L_Check_Timers85
L__Check_Timers930:
;Solar_Auto_Switcher.c,462 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers85:
;Solar_Auto_Switcher.c,457 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
L__Check_Timers704:
L__Check_Timers703:
L__Check_Timers702:
L__Check_Timers701:
L__Check_Timers700:
;Solar_Auto_Switcher.c,465 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers708
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers931
	JMP        L__Check_Timers707
L__Check_Timers931:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers932
	JMP        L__Check_Timers706
L__Check_Timers932:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers933
	JMP        L__Check_Timers705
L__Check_Timers933:
L__Check_Timers636:
;Solar_Auto_Switcher.c,467 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,468 :: 		Delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_Check_Timers89:
	DEC        R16
	BRNE       L_Check_Timers89
	DEC        R17
	BRNE       L_Check_Timers89
	DEC        R18
	BRNE       L_Check_Timers89
;Solar_Auto_Switcher.c,469 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers934
	JMP        L_Check_Timers91
L__Check_Timers934:
;Solar_Auto_Switcher.c,470 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers91:
;Solar_Auto_Switcher.c,465 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
L__Check_Timers708:
L__Check_Timers707:
L__Check_Timers706:
L__Check_Timers705:
;Solar_Auto_Switcher.c,474 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
	LDS        R20, _Mini_Battery_Voltage+0
	LDS        R21, _Mini_Battery_Voltage+1
	LDS        R22, _Mini_Battery_Voltage+2
	LDS        R23, _Mini_Battery_Voltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers935
	LDI        R16, 1
L__Check_Timers935:
	TST        R16
	BRNE       L__Check_Timers936
	JMP        L__Check_Timers712
L__Check_Timers936:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers711
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers937
	JMP        L__Check_Timers710
L__Check_Timers937:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers938
	JMP        L__Check_Timers709
L__Check_Timers938:
L__Check_Timers635:
;Solar_Auto_Switcher.c,476 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,477 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,474 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
L__Check_Timers712:
L__Check_Timers711:
L__Check_Timers710:
L__Check_Timers709:
;Solar_Auto_Switcher.c,481 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
	LDS        R20, _Mini_Battery_Voltage_T2+0
	LDS        R21, _Mini_Battery_Voltage_T2+1
	LDS        R22, _Mini_Battery_Voltage_T2+2
	LDS        R23, _Mini_Battery_Voltage_T2+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers939
	LDI        R16, 1
L__Check_Timers939:
	TST        R16
	BRNE       L__Check_Timers940
	JMP        L__Check_Timers716
L__Check_Timers940:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers715
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers941
	JMP        L__Check_Timers714
L__Check_Timers941:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers942
	JMP        L__Check_Timers713
L__Check_Timers942:
L__Check_Timers634:
;Solar_Auto_Switcher.c,483 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,484 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,481 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
L__Check_Timers716:
L__Check_Timers715:
L__Check_Timers714:
L__Check_Timers713:
;Solar_Auto_Switcher.c,502 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_GetVoltageNow:

;Solar_Auto_Switcher.c,505 :: 		void GetVoltageNow()
;Solar_Auto_Switcher.c,507 :: 		v=ReadAC();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _ReadAC+0
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,508 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 160
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,509 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,510 :: 		v/=sqrt(2);
	LDI        R27, 0
	MOV        R2, R27
	MOV        R3, R27
	MOV        R4, R27
	LDI        R27, 64
	MOV        R5, R27
	CALL       _sqrt+0
	MOVW       R20, R16
	MOVW       R22, R18
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpdiv1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,511 :: 		}
L_end_GetVoltageNow:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _GetVoltageNow

_ToggleBuzzer:

;Solar_Auto_Switcher.c,513 :: 		void ToggleBuzzer()
;Solar_Auto_Switcher.c,515 :: 		if (AcBuzzerActiveTimes==0)
	LDS        R16, _AcBuzzerActiveTimes+0
	CPI        R16, 0
	BREQ       L__ToggleBuzzer945
	JMP        L_ToggleBuzzer98
L__ToggleBuzzer945:
;Solar_Auto_Switcher.c,517 :: 		AcBuzzerActiveTimes =1 ;
	LDI        R27, 1
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,518 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,519 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_ToggleBuzzer99:
	DEC        R16
	BRNE       L_ToggleBuzzer99
	DEC        R17
	BRNE       L_ToggleBuzzer99
	DEC        R18
	BRNE       L_ToggleBuzzer99
;Solar_Auto_Switcher.c,520 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,521 :: 		}
L_ToggleBuzzer98:
;Solar_Auto_Switcher.c,522 :: 		}
L_end_ToggleBuzzer:
	RET
; end of _ToggleBuzzer

_Interrupt_Routine:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,524 :: 		void Interrupt_Routine () iv IVT_ADDR_INT0
;Solar_Auto_Switcher.c,527 :: 		Delay_ms(100);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Interrupt_Routine101:
	DEC        R16
	BRNE       L_Interrupt_Routine101
	DEC        R17
	BRNE       L_Interrupt_Routine101
	DEC        R18
	BRNE       L_Interrupt_Routine101
;Solar_Auto_Switcher.c,528 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,529 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Interrupt_Routine103
;Solar_Auto_Switcher.c,530 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
L_Interrupt_Routine103:
;Solar_Auto_Switcher.c,531 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,532 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,533 :: 		}
L_end_Interrupt_Routine:
	POP        R4
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interrupt_Routine

_SetUpProgram:

;Solar_Auto_Switcher.c,536 :: 		void SetUpProgram()
;Solar_Auto_Switcher.c,538 :: 		Delay_ms(100);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetUpProgram104:
	DEC        R16
	BRNE       L_SetUpProgram104
	DEC        R17
	BRNE       L_SetUpProgram104
	DEC        R18
	BRNE       L_SetUpProgram104
;Solar_Auto_Switcher.c,539 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,540 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_SetUpProgram106
;Solar_Auto_Switcher.c,542 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,543 :: 		LCD_OUT(1,1,"Setup Program");
	LDI        R27, #lo_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,544 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetUpProgram107:
	DEC        R16
	BRNE       L_SetUpProgram107
	DEC        R17
	BRNE       L_SetUpProgram107
	DEC        R18
	BRNE       L_SetUpProgram107
;Solar_Auto_Switcher.c,547 :: 		while (Set==1 )
L_SetUpProgram109:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetUpProgram110
;Solar_Auto_Switcher.c,550 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Auto_Switcher.c,551 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram111
	JMP        L_SetUpProgram110
L_SetUpProgram111:
;Solar_Auto_Switcher.c,552 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Auto_Switcher.c,553 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram112
	JMP        L_SetUpProgram110
L_SetUpProgram112:
;Solar_Auto_Switcher.c,554 :: 		SetTimerOn_2();
	CALL       _SetTimerOn_2+0
;Solar_Auto_Switcher.c,555 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram113
	JMP        L_SetUpProgram110
L_SetUpProgram113:
;Solar_Auto_Switcher.c,556 :: 		SetTimerOff_2();
	CALL       _SetTimerOff_2+0
;Solar_Auto_Switcher.c,557 :: 		if (Exit==1) break ;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram114
	JMP        L_SetUpProgram110
L_SetUpProgram114:
;Solar_Auto_Switcher.c,558 :: 		SetLowBatteryVoltage();// program 5 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Auto_Switcher.c,559 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram115
	JMP        L_SetUpProgram110
L_SetUpProgram115:
;Solar_Auto_Switcher.c,560 :: 		SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Auto_Switcher.c,561 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram116
	JMP        L_SetUpProgram110
L_SetUpProgram116:
;Solar_Auto_Switcher.c,563 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram117
	JMP        L_SetUpProgram110
L_SetUpProgram117:
;Solar_Auto_Switcher.c,565 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram118
	JMP        L_SetUpProgram110
L_SetUpProgram118:
;Solar_Auto_Switcher.c,566 :: 		SetDS1307_Time();    // program 10
	CALL       _SetDS1307_Time+0
;Solar_Auto_Switcher.c,572 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Auto_Switcher.c,573 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram119
	JMP        L_SetUpProgram110
L_SetUpProgram119:
;Solar_Auto_Switcher.c,578 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,580 :: 		} // end while
	JMP        L_SetUpProgram109
L_SetUpProgram110:
;Solar_Auto_Switcher.c,581 :: 		}    // end main if
L_SetUpProgram106:
;Solar_Auto_Switcher.c,582 :: 		}
L_end_SetUpProgram:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Auto_Switcher.c,585 :: 		void SetTimerOn_1()
;Solar_Auto_Switcher.c,587 :: 		LCD_Clear(1,1,16);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,588 :: 		LCD_OUT(1,1,"T1 On: [1]");
	LDI        R27, #lo_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,589 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1120:
	DEC        R16
	BRNE       L_SetTimerOn_1120
	DEC        R17
	BRNE       L_SetTimerOn_1120
	DEC        R18
	BRNE       L_SetTimerOn_1120
;Solar_Auto_Switcher.c,590 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,591 :: 		while (Set==1)
L_SetTimerOn_1122:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1123
;Solar_Auto_Switcher.c,597 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,598 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,599 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,600 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,602 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1124
;Solar_Auto_Switcher.c,604 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,605 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1123
;Solar_Auto_Switcher.c,606 :: 		}
L_SetTimerOn_1124:
;Solar_Auto_Switcher.c,609 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1125:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1721
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1720
	JMP        L_SetTimerOn_1126
L__SetTimerOn_1721:
L__SetTimerOn_1720:
;Solar_Auto_Switcher.c,611 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1129
;Solar_Auto_Switcher.c,613 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1130:
	DEC        R16
	BRNE       L_SetTimerOn_1130
	DEC        R17
	BRNE       L_SetTimerOn_1130
	DEC        R18
	BRNE       L_SetTimerOn_1130
	NOP
;Solar_Auto_Switcher.c,614 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,615 :: 		}
L_SetTimerOn_1129:
;Solar_Auto_Switcher.c,616 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1132
;Solar_Auto_Switcher.c,618 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1133:
	DEC        R16
	BRNE       L_SetTimerOn_1133
	DEC        R17
	BRNE       L_SetTimerOn_1133
	DEC        R18
	BRNE       L_SetTimerOn_1133
	NOP
;Solar_Auto_Switcher.c,619 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,620 :: 		}
L_SetTimerOn_1132:
;Solar_Auto_Switcher.c,622 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_1949
	JMP        L_SetTimerOn_1135
L__SetTimerOn_1949:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1135:
;Solar_Auto_Switcher.c,623 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1950
	JMP        L_SetTimerOn_1136
L__SetTimerOn_1950:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1136:
;Solar_Auto_Switcher.c,624 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_1125
L_SetTimerOn_1126:
;Solar_Auto_Switcher.c,625 :: 		} // end first while
	JMP        L_SetTimerOn_1122
L_SetTimerOn_1123:
;Solar_Auto_Switcher.c,627 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_1137:
	DEC        R16
	BRNE       L_SetTimerOn_1137
	DEC        R17
	BRNE       L_SetTimerOn_1137
	DEC        R18
	BRNE       L_SetTimerOn_1137
;Solar_Auto_Switcher.c,628 :: 		while (Set==1)
L_SetTimerOn_1139:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1140
;Solar_Auto_Switcher.c,630 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,632 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,636 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1141
;Solar_Auto_Switcher.c,638 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,639 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1140
;Solar_Auto_Switcher.c,640 :: 		}
L_SetTimerOn_1141:
;Solar_Auto_Switcher.c,642 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1142:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1723
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1722
	JMP        L_SetTimerOn_1143
L__SetTimerOn_1723:
L__SetTimerOn_1722:
;Solar_Auto_Switcher.c,644 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1146
;Solar_Auto_Switcher.c,646 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1147:
	DEC        R16
	BRNE       L_SetTimerOn_1147
	DEC        R17
	BRNE       L_SetTimerOn_1147
	DEC        R18
	BRNE       L_SetTimerOn_1147
	NOP
;Solar_Auto_Switcher.c,647 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,648 :: 		}
L_SetTimerOn_1146:
;Solar_Auto_Switcher.c,649 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1149
;Solar_Auto_Switcher.c,651 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1150:
	DEC        R16
	BRNE       L_SetTimerOn_1150
	DEC        R17
	BRNE       L_SetTimerOn_1150
	DEC        R18
	BRNE       L_SetTimerOn_1150
	NOP
;Solar_Auto_Switcher.c,652 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,653 :: 		}
L_SetTimerOn_1149:
;Solar_Auto_Switcher.c,655 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_1951
	JMP        L_SetTimerOn_1152
L__SetTimerOn_1951:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1152:
;Solar_Auto_Switcher.c,656 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1952
	JMP        L_SetTimerOn_1153
L__SetTimerOn_1952:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1153:
;Solar_Auto_Switcher.c,657 :: 		} // end while increment
	JMP        L_SetTimerOn_1142
L_SetTimerOn_1143:
;Solar_Auto_Switcher.c,658 :: 		} // end first while
	JMP        L_SetTimerOn_1139
L_SetTimerOn_1140:
;Solar_Auto_Switcher.c,660 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,661 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,662 :: 		}
L_end_SetTimerOn_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Auto_Switcher.c,664 :: 		void SetTimerOff_1()
;Solar_Auto_Switcher.c,666 :: 		LCD_Clear(1,1,16);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,667 :: 		LCD_OUT(1,1,"T1 Off: [2]");
	LDI        R27, #lo_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,668 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,669 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1154:
	DEC        R16
	BRNE       L_SetTimerOff_1154
	DEC        R17
	BRNE       L_SetTimerOff_1154
	DEC        R18
	BRNE       L_SetTimerOff_1154
	NOP
;Solar_Auto_Switcher.c,670 :: 		while (Set==1)
L_SetTimerOff_1156:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1157
;Solar_Auto_Switcher.c,676 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,677 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,678 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,679 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,680 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1158
;Solar_Auto_Switcher.c,682 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,683 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1157
;Solar_Auto_Switcher.c,684 :: 		}
L_SetTimerOff_1158:
;Solar_Auto_Switcher.c,686 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1159:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1727
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1726
	JMP        L_SetTimerOff_1160
L__SetTimerOff_1727:
L__SetTimerOff_1726:
;Solar_Auto_Switcher.c,689 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1163
;Solar_Auto_Switcher.c,691 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1164:
	DEC        R16
	BRNE       L_SetTimerOff_1164
	DEC        R17
	BRNE       L_SetTimerOff_1164
	DEC        R18
	BRNE       L_SetTimerOff_1164
	NOP
;Solar_Auto_Switcher.c,692 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,693 :: 		}
L_SetTimerOff_1163:
;Solar_Auto_Switcher.c,694 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1166
;Solar_Auto_Switcher.c,696 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1167:
	DEC        R16
	BRNE       L_SetTimerOff_1167
	DEC        R17
	BRNE       L_SetTimerOff_1167
	DEC        R18
	BRNE       L_SetTimerOff_1167
	NOP
;Solar_Auto_Switcher.c,697 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,698 :: 		}
L_SetTimerOff_1166:
;Solar_Auto_Switcher.c,700 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_1954
	JMP        L_SetTimerOff_1169
L__SetTimerOff_1954:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1169:
;Solar_Auto_Switcher.c,701 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1955
	JMP        L_SetTimerOff_1170
L__SetTimerOff_1955:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1170:
;Solar_Auto_Switcher.c,703 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1159
L_SetTimerOff_1160:
;Solar_Auto_Switcher.c,704 :: 		} // end first while
	JMP        L_SetTimerOff_1156
L_SetTimerOff_1157:
;Solar_Auto_Switcher.c,706 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1171:
	DEC        R16
	BRNE       L_SetTimerOff_1171
	DEC        R17
	BRNE       L_SetTimerOff_1171
	DEC        R18
	BRNE       L_SetTimerOff_1171
	NOP
;Solar_Auto_Switcher.c,707 :: 		while (Set==1)
L_SetTimerOff_1173:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1174
;Solar_Auto_Switcher.c,709 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,711 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,715 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1175
;Solar_Auto_Switcher.c,717 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,718 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1174
;Solar_Auto_Switcher.c,719 :: 		}
L_SetTimerOff_1175:
;Solar_Auto_Switcher.c,721 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1176:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1729
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1728
	JMP        L_SetTimerOff_1177
L__SetTimerOff_1729:
L__SetTimerOff_1728:
;Solar_Auto_Switcher.c,723 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1180
;Solar_Auto_Switcher.c,725 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1181:
	DEC        R16
	BRNE       L_SetTimerOff_1181
	DEC        R17
	BRNE       L_SetTimerOff_1181
	DEC        R18
	BRNE       L_SetTimerOff_1181
	NOP
;Solar_Auto_Switcher.c,726 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,727 :: 		}
L_SetTimerOff_1180:
;Solar_Auto_Switcher.c,728 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1183
;Solar_Auto_Switcher.c,730 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1184:
	DEC        R16
	BRNE       L_SetTimerOff_1184
	DEC        R17
	BRNE       L_SetTimerOff_1184
	DEC        R18
	BRNE       L_SetTimerOff_1184
	NOP
;Solar_Auto_Switcher.c,731 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,732 :: 		}
L_SetTimerOff_1183:
;Solar_Auto_Switcher.c,733 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_1956
	JMP        L_SetTimerOff_1186
L__SetTimerOff_1956:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1186:
;Solar_Auto_Switcher.c,734 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1957
	JMP        L_SetTimerOff_1187
L__SetTimerOff_1957:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1187:
;Solar_Auto_Switcher.c,735 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1176
L_SetTimerOff_1177:
;Solar_Auto_Switcher.c,736 :: 		} // end first while
	JMP        L_SetTimerOff_1173
L_SetTimerOff_1174:
;Solar_Auto_Switcher.c,737 :: 		EEPROM_Write(0x03,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,738 :: 		EEPROM_Write(0x04,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,739 :: 		}
L_end_SetTimerOff_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetTimerOn_2:

;Solar_Auto_Switcher.c,742 :: 		void SetTimerOn_2()
;Solar_Auto_Switcher.c,744 :: 		LCD_Clear(1,1,16);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,745 :: 		LCD_OUT(1,1,"T2 On: [3]");
	LDI        R27, #lo_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,746 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2188:
	DEC        R16
	BRNE       L_SetTimerOn_2188
	DEC        R17
	BRNE       L_SetTimerOn_2188
	DEC        R18
	BRNE       L_SetTimerOn_2188
;Solar_Auto_Switcher.c,747 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,748 :: 		while (Set==1)
L_SetTimerOn_2190:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2191
;Solar_Auto_Switcher.c,754 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,755 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,756 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,757 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,759 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2192
;Solar_Auto_Switcher.c,761 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,762 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2191
;Solar_Auto_Switcher.c,763 :: 		}
L_SetTimerOn_2192:
;Solar_Auto_Switcher.c,766 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2193:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2733
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2732
	JMP        L_SetTimerOn_2194
L__SetTimerOn_2733:
L__SetTimerOn_2732:
;Solar_Auto_Switcher.c,768 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2197
;Solar_Auto_Switcher.c,770 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2198:
	DEC        R16
	BRNE       L_SetTimerOn_2198
	DEC        R17
	BRNE       L_SetTimerOn_2198
	DEC        R18
	BRNE       L_SetTimerOn_2198
	NOP
;Solar_Auto_Switcher.c,771 :: 		minutes_lcd_timer2_start++;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,772 :: 		}
L_SetTimerOn_2197:
;Solar_Auto_Switcher.c,773 :: 		if (Decrement==1 )
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2200
;Solar_Auto_Switcher.c,775 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2201:
	DEC        R16
	BRNE       L_SetTimerOn_2201
	DEC        R17
	BRNE       L_SetTimerOn_2201
	DEC        R18
	BRNE       L_SetTimerOn_2201
	NOP
;Solar_Auto_Switcher.c,776 :: 		minutes_lcd_timer2_start--;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,777 :: 		}
L_SetTimerOn_2200:
;Solar_Auto_Switcher.c,779 :: 		if (minutes_lcd_timer2_start>59)    minutes_lcd_timer2_start=0;
	LDS        R17, _minutes_lcd_timer2_start+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_2959
	JMP        L_SetTimerOn_2203
L__SetTimerOn_2959:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2203:
;Solar_Auto_Switcher.c,780 :: 		if (minutes_lcd_timer2_start<0)  minutes_lcd_timer2_start=0;
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_2960
	JMP        L_SetTimerOn_2204
L__SetTimerOn_2960:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2204:
;Solar_Auto_Switcher.c,781 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_2193
L_SetTimerOn_2194:
;Solar_Auto_Switcher.c,782 :: 		} // end first while
	JMP        L_SetTimerOn_2190
L_SetTimerOn_2191:
;Solar_Auto_Switcher.c,784 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_2205:
	DEC        R16
	BRNE       L_SetTimerOn_2205
	DEC        R17
	BRNE       L_SetTimerOn_2205
	DEC        R18
	BRNE       L_SetTimerOn_2205
;Solar_Auto_Switcher.c,785 :: 		while (Set==1)
L_SetTimerOn_2207:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2208
;Solar_Auto_Switcher.c,787 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,789 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,794 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2209
;Solar_Auto_Switcher.c,796 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2208
;Solar_Auto_Switcher.c,797 :: 		}
L_SetTimerOn_2209:
;Solar_Auto_Switcher.c,799 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2210:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2735
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2734
	JMP        L_SetTimerOn_2211
L__SetTimerOn_2735:
L__SetTimerOn_2734:
;Solar_Auto_Switcher.c,801 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2214
;Solar_Auto_Switcher.c,803 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2215:
	DEC        R16
	BRNE       L_SetTimerOn_2215
	DEC        R17
	BRNE       L_SetTimerOn_2215
	DEC        R18
	BRNE       L_SetTimerOn_2215
	NOP
;Solar_Auto_Switcher.c,804 :: 		hours_lcd_timer2_start++;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,805 :: 		}
L_SetTimerOn_2214:
;Solar_Auto_Switcher.c,806 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2217
;Solar_Auto_Switcher.c,808 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2218:
	DEC        R16
	BRNE       L_SetTimerOn_2218
	DEC        R17
	BRNE       L_SetTimerOn_2218
	DEC        R18
	BRNE       L_SetTimerOn_2218
	NOP
;Solar_Auto_Switcher.c,809 :: 		hours_lcd_timer2_start--;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,810 :: 		}
L_SetTimerOn_2217:
;Solar_Auto_Switcher.c,812 :: 		if  (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
	LDS        R17, _hours_lcd_timer2_start+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_2961
	JMP        L_SetTimerOn_2220
L__SetTimerOn_2961:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2220:
;Solar_Auto_Switcher.c,813 :: 		if  (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_2962
	JMP        L_SetTimerOn_2221
L__SetTimerOn_2962:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2221:
;Solar_Auto_Switcher.c,814 :: 		} // end while increment
	JMP        L_SetTimerOn_2210
L_SetTimerOn_2211:
;Solar_Auto_Switcher.c,815 :: 		} // end first while
	JMP        L_SetTimerOn_2207
L_SetTimerOn_2208:
;Solar_Auto_Switcher.c,817 :: 		EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_start+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,818 :: 		EEPROM_Write(0x19,minutes_lcd_timer2_start); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_start+0
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,819 :: 		}
L_end_SetTimerOn_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_2

_SetTimerOff_2:

;Solar_Auto_Switcher.c,821 :: 		void SetTimerOff_2()
;Solar_Auto_Switcher.c,823 :: 		LCD_Clear(1,1,16);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,824 :: 		LCD_OUT(1,1,"T2 Off: [4]");
	LDI        R27, #lo_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,825 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,826 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2222:
	DEC        R16
	BRNE       L_SetTimerOff_2222
	DEC        R17
	BRNE       L_SetTimerOff_2222
	DEC        R18
	BRNE       L_SetTimerOff_2222
	NOP
;Solar_Auto_Switcher.c,827 :: 		while (Set==1)
L_SetTimerOff_2224:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2225
;Solar_Auto_Switcher.c,833 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,834 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,835 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,836 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,837 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2226
	JMP        L_SetTimerOff_2225
L_SetTimerOff_2226:
;Solar_Auto_Switcher.c,839 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2227:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2739
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2738
	JMP        L_SetTimerOff_2228
L__SetTimerOff_2739:
L__SetTimerOff_2738:
;Solar_Auto_Switcher.c,841 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2231
;Solar_Auto_Switcher.c,843 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2232:
	DEC        R16
	BRNE       L_SetTimerOff_2232
	DEC        R17
	BRNE       L_SetTimerOff_2232
	DEC        R18
	BRNE       L_SetTimerOff_2232
	NOP
;Solar_Auto_Switcher.c,844 :: 		minutes_lcd_timer2_stop++;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,845 :: 		}
L_SetTimerOff_2231:
;Solar_Auto_Switcher.c,846 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2234
;Solar_Auto_Switcher.c,848 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2235:
	DEC        R16
	BRNE       L_SetTimerOff_2235
	DEC        R17
	BRNE       L_SetTimerOff_2235
	DEC        R18
	BRNE       L_SetTimerOff_2235
	NOP
;Solar_Auto_Switcher.c,849 :: 		minutes_lcd_timer2_stop--;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,850 :: 		}
L_SetTimerOff_2234:
;Solar_Auto_Switcher.c,852 :: 		if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
	LDS        R17, _minutes_lcd_timer2_stop+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_2964
	JMP        L_SetTimerOff_2237
L__SetTimerOff_2964:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2237:
;Solar_Auto_Switcher.c,853 :: 		if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_2965
	JMP        L_SetTimerOff_2238
L__SetTimerOff_2965:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2238:
;Solar_Auto_Switcher.c,855 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2227
L_SetTimerOff_2228:
;Solar_Auto_Switcher.c,856 :: 		} // end first while
	JMP        L_SetTimerOff_2224
L_SetTimerOff_2225:
;Solar_Auto_Switcher.c,858 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2239:
	DEC        R16
	BRNE       L_SetTimerOff_2239
	DEC        R17
	BRNE       L_SetTimerOff_2239
	DEC        R18
	BRNE       L_SetTimerOff_2239
	NOP
;Solar_Auto_Switcher.c,859 :: 		while (Set==1)
L_SetTimerOff_2241:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2242
;Solar_Auto_Switcher.c,861 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,863 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,868 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2243
;Solar_Auto_Switcher.c,870 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,871 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_2242
;Solar_Auto_Switcher.c,872 :: 		}
L_SetTimerOff_2243:
;Solar_Auto_Switcher.c,874 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_2244:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2741
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2740
	JMP        L_SetTimerOff_2245
L__SetTimerOff_2741:
L__SetTimerOff_2740:
;Solar_Auto_Switcher.c,876 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2248
;Solar_Auto_Switcher.c,878 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2249:
	DEC        R16
	BRNE       L_SetTimerOff_2249
	DEC        R17
	BRNE       L_SetTimerOff_2249
	DEC        R18
	BRNE       L_SetTimerOff_2249
	NOP
;Solar_Auto_Switcher.c,879 :: 		hours_lcd_timer2_stop++;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,880 :: 		}
L_SetTimerOff_2248:
;Solar_Auto_Switcher.c,881 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2251
;Solar_Auto_Switcher.c,883 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2252:
	DEC        R16
	BRNE       L_SetTimerOff_2252
	DEC        R17
	BRNE       L_SetTimerOff_2252
	DEC        R18
	BRNE       L_SetTimerOff_2252
	NOP
;Solar_Auto_Switcher.c,884 :: 		hours_lcd_timer2_stop--;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,885 :: 		}
L_SetTimerOff_2251:
;Solar_Auto_Switcher.c,886 :: 		if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
	LDS        R17, _hours_lcd_timer2_stop+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_2966
	JMP        L_SetTimerOff_2254
L__SetTimerOff_2966:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2254:
;Solar_Auto_Switcher.c,887 :: 		if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_2967
	JMP        L_SetTimerOff_2255
L__SetTimerOff_2967:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2255:
;Solar_Auto_Switcher.c,888 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2244
L_SetTimerOff_2245:
;Solar_Auto_Switcher.c,889 :: 		} // end first while
	JMP        L_SetTimerOff_2241
L_SetTimerOff_2242:
;Solar_Auto_Switcher.c,890 :: 		EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_timer2_stop+0
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,891 :: 		EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_timer2_stop+0
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,892 :: 		}
L_end_SetTimerOff_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_2

_SetDS1307_Time:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Auto_Switcher.c,896 :: 		void SetDS1307_Time()
;Solar_Auto_Switcher.c,898 :: 		LCD_Clear(1,1,16);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,899 :: 		LCD_OUT(1,1,"Set Time[H] [9]");
	LDI        R27, #lo_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,900 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time256:
	DEC        R16
	BRNE       L_SetDS1307_Time256
	DEC        R17
	BRNE       L_SetDS1307_Time256
	DEC        R18
	BRNE       L_SetDS1307_Time256
	NOP
;Solar_Auto_Switcher.c,901 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,902 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,904 :: 		while (Set==1)
L_SetDS1307_Time258:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time259
;Solar_Auto_Switcher.c,906 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,907 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,908 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,910 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,911 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,912 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,914 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,915 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,916 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,917 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time260
	JMP        L_SetDS1307_Time259
L_SetDS1307_Time260:
;Solar_Auto_Switcher.c,918 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time261:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time761
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time760
	JMP        L_SetDS1307_Time262
L__SetDS1307_Time761:
L__SetDS1307_Time760:
;Solar_Auto_Switcher.c,920 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time265
;Solar_Auto_Switcher.c,922 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time266:
	DEC        R16
	BRNE       L_SetDS1307_Time266
	DEC        R17
	BRNE       L_SetDS1307_Time266
	DEC        R18
	BRNE       L_SetDS1307_Time266
	NOP
;Solar_Auto_Switcher.c,923 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,925 :: 		}
L_SetDS1307_Time265:
;Solar_Auto_Switcher.c,926 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time268
;Solar_Auto_Switcher.c,928 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time269:
	DEC        R16
	BRNE       L_SetDS1307_Time269
	DEC        R17
	BRNE       L_SetDS1307_Time269
	DEC        R18
	BRNE       L_SetDS1307_Time269
	NOP
;Solar_Auto_Switcher.c,929 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,930 :: 		}
L_SetDS1307_Time268:
;Solar_Auto_Switcher.c,931 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time969
	JMP        L_SetDS1307_Time271
L__SetDS1307_Time969:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time271:
;Solar_Auto_Switcher.c,932 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time970
	JMP        L_SetDS1307_Time272
L__SetDS1307_Time970:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time272:
;Solar_Auto_Switcher.c,933 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time261
L_SetDS1307_Time262:
;Solar_Auto_Switcher.c,934 :: 		} // end first while
	JMP        L_SetDS1307_Time258
L_SetDS1307_Time259:
;Solar_Auto_Switcher.c,936 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time273:
	DEC        R16
	BRNE       L_SetDS1307_Time273
	DEC        R17
	BRNE       L_SetDS1307_Time273
	DEC        R18
	BRNE       L_SetDS1307_Time273
	NOP
;Solar_Auto_Switcher.c,937 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,938 :: 		LCD_OUT(1,1,"Set Time[M] [10]");
	LDI        R27, #lo_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,939 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time275:
	DEC        R16
	BRNE       L_SetDS1307_Time275
	DEC        R17
	BRNE       L_SetDS1307_Time275
	DEC        R18
	BRNE       L_SetDS1307_Time275
	NOP
;Solar_Auto_Switcher.c,940 :: 		while (Set==1)
L_SetDS1307_Time277:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time278
;Solar_Auto_Switcher.c,942 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,944 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,946 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time279
	JMP        L_SetDS1307_Time278
L_SetDS1307_Time279:
;Solar_Auto_Switcher.c,947 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time280:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time763
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time762
	JMP        L_SetDS1307_Time281
L__SetDS1307_Time763:
L__SetDS1307_Time762:
;Solar_Auto_Switcher.c,949 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time284
;Solar_Auto_Switcher.c,951 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time285:
	DEC        R16
	BRNE       L_SetDS1307_Time285
	DEC        R17
	BRNE       L_SetDS1307_Time285
	DEC        R18
	BRNE       L_SetDS1307_Time285
	NOP
;Solar_Auto_Switcher.c,952 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,953 :: 		}
L_SetDS1307_Time284:
;Solar_Auto_Switcher.c,955 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time287
;Solar_Auto_Switcher.c,957 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time288:
	DEC        R16
	BRNE       L_SetDS1307_Time288
	DEC        R17
	BRNE       L_SetDS1307_Time288
	DEC        R18
	BRNE       L_SetDS1307_Time288
	NOP
;Solar_Auto_Switcher.c,958 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,959 :: 		}
L_SetDS1307_Time287:
;Solar_Auto_Switcher.c,960 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time971
	JMP        L_SetDS1307_Time290
L__SetDS1307_Time971:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time290:
;Solar_Auto_Switcher.c,961 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time972
	JMP        L_SetDS1307_Time291
L__SetDS1307_Time972:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time291:
;Solar_Auto_Switcher.c,962 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time280
L_SetDS1307_Time281:
;Solar_Auto_Switcher.c,963 :: 		} // end first while
	JMP        L_SetDS1307_Time277
L_SetDS1307_Time278:
;Solar_Auto_Switcher.c,965 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time292:
	DEC        R16
	BRNE       L_SetDS1307_Time292
	DEC        R17
	BRNE       L_SetDS1307_Time292
	DEC        R18
	BRNE       L_SetDS1307_Time292
	NOP
;Solar_Auto_Switcher.c,966 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,967 :: 		LCD_OUT(1,1,"Set Time[S] [11]");
	LDI        R27, #lo_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,968 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time294:
	DEC        R16
	BRNE       L_SetDS1307_Time294
	DEC        R17
	BRNE       L_SetDS1307_Time294
	DEC        R18
	BRNE       L_SetDS1307_Time294
	NOP
;Solar_Auto_Switcher.c,969 :: 		while (Set==1)
L_SetDS1307_Time296:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time297
;Solar_Auto_Switcher.c,971 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,973 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,974 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time298
	JMP        L_SetDS1307_Time297
L_SetDS1307_Time298:
;Solar_Auto_Switcher.c,975 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time299:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time765
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time764
	JMP        L_SetDS1307_Time300
L__SetDS1307_Time765:
L__SetDS1307_Time764:
;Solar_Auto_Switcher.c,977 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time303
;Solar_Auto_Switcher.c,979 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time304:
	DEC        R16
	BRNE       L_SetDS1307_Time304
	DEC        R17
	BRNE       L_SetDS1307_Time304
	DEC        R18
	BRNE       L_SetDS1307_Time304
	NOP
;Solar_Auto_Switcher.c,980 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,981 :: 		}
L_SetDS1307_Time303:
;Solar_Auto_Switcher.c,982 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time306
;Solar_Auto_Switcher.c,984 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time307:
	DEC        R16
	BRNE       L_SetDS1307_Time307
	DEC        R17
	BRNE       L_SetDS1307_Time307
	DEC        R18
	BRNE       L_SetDS1307_Time307
	NOP
;Solar_Auto_Switcher.c,985 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,986 :: 		}
L_SetDS1307_Time306:
;Solar_Auto_Switcher.c,987 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time973
	JMP        L_SetDS1307_Time309
L__SetDS1307_Time973:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time309:
;Solar_Auto_Switcher.c,988 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time974
	JMP        L_SetDS1307_Time310
L__SetDS1307_Time974:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time310:
;Solar_Auto_Switcher.c,991 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
	LDS        R2, _set_ds1307_hours+0
	CALL       _Dec2Bcd+0
	STD        Y+1, R16
	LDS        R2, _set_ds1307_minutes+0
	CALL       _Dec2Bcd+0
	STD        Y+0, R16
	LDS        R2, _set_ds1307_seconds+0
	CALL       _Dec2Bcd+0
	LDD        R18, Y+1
	LDD        R17, Y+0
	MOV        R6, R18
	LDI        R27, 0
	MOV        R7, R27
	MOV        R4, R17
	LDI        R27, 0
	MOV        R5, R27
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Write_Time+0
;Solar_Auto_Switcher.c,992 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time299
L_SetDS1307_Time300:
;Solar_Auto_Switcher.c,993 :: 		} // end first while
	JMP        L_SetDS1307_Time296
L_SetDS1307_Time297:
;Solar_Auto_Switcher.c,995 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time311:
	DEC        R16
	BRNE       L_SetDS1307_Time311
	DEC        R17
	BRNE       L_SetDS1307_Time311
	DEC        R18
	BRNE       L_SetDS1307_Time311
;Solar_Auto_Switcher.c,996 :: 		LCD_Clear(1,1,16);  // clear the lcd first row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,997 :: 		LCD_CLear(2,1,16); // clear the lcd two row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,998 :: 		LCD_OUT(1,1,"Set Date[D] [12]");
	LDI        R27, #lo_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1000 :: 		set_ds1307_day=ReadDate(0x04);
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1001 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time313:
	DEC        R16
	BRNE       L_SetDS1307_Time313
	DEC        R17
	BRNE       L_SetDS1307_Time313
	DEC        R18
	BRNE       L_SetDS1307_Time313
	NOP
;Solar_Auto_Switcher.c,1002 :: 		while (Set==1)
L_SetDS1307_Time315:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time316
;Solar_Auto_Switcher.c,1004 :: 		ByteToStr(set_ds1307_day,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_day+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1005 :: 		LCD_OUT(2,1,"D:");
	LDI        R27, #lo_addr(?lstr23_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr23_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1006 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1007 :: 		LCD_OUT(2,12,"Y:");
	LDI        R27, #lo_addr(?lstr25_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr25_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1008 :: 		LCD_Out(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1009 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time317
	JMP        L_SetDS1307_Time316
L_SetDS1307_Time317:
;Solar_Auto_Switcher.c,1010 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time318:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time767
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time766
	JMP        L_SetDS1307_Time319
L__SetDS1307_Time767:
L__SetDS1307_Time766:
;Solar_Auto_Switcher.c,1012 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time322
;Solar_Auto_Switcher.c,1014 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time323:
	DEC        R16
	BRNE       L_SetDS1307_Time323
	DEC        R17
	BRNE       L_SetDS1307_Time323
	DEC        R18
	BRNE       L_SetDS1307_Time323
	NOP
;Solar_Auto_Switcher.c,1015 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1016 :: 		}
L_SetDS1307_Time322:
;Solar_Auto_Switcher.c,1017 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time325
;Solar_Auto_Switcher.c,1019 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time326:
	DEC        R16
	BRNE       L_SetDS1307_Time326
	DEC        R17
	BRNE       L_SetDS1307_Time326
	DEC        R18
	BRNE       L_SetDS1307_Time326
	NOP
;Solar_Auto_Switcher.c,1020 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1021 :: 		}
L_SetDS1307_Time325:
;Solar_Auto_Switcher.c,1022 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time975
	JMP        L_SetDS1307_Time328
L__SetDS1307_Time975:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time328:
;Solar_Auto_Switcher.c,1023 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time976
	JMP        L_SetDS1307_Time329
L__SetDS1307_Time976:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time329:
;Solar_Auto_Switcher.c,1024 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time318
L_SetDS1307_Time319:
;Solar_Auto_Switcher.c,1025 :: 		} //  end while set
	JMP        L_SetDS1307_Time315
L_SetDS1307_Time316:
;Solar_Auto_Switcher.c,1027 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time330:
	DEC        R16
	BRNE       L_SetDS1307_Time330
	DEC        R17
	BRNE       L_SetDS1307_Time330
	DEC        R18
	BRNE       L_SetDS1307_Time330
;Solar_Auto_Switcher.c,1028 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1031 :: 		set_ds1307_month=ReadDate(0x05);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1032 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time332:
	DEC        R16
	BRNE       L_SetDS1307_Time332
	DEC        R17
	BRNE       L_SetDS1307_Time332
	DEC        R18
	BRNE       L_SetDS1307_Time332
	NOP
;Solar_Auto_Switcher.c,1033 :: 		while (Set==1)
L_SetDS1307_Time334:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time335
;Solar_Auto_Switcher.c,1035 :: 		ByteToStr(set_ds1307_month,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_month+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1036 :: 		LCD_Out(2,8,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1037 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time336
	JMP        L_SetDS1307_Time335
L_SetDS1307_Time336:
;Solar_Auto_Switcher.c,1038 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time337:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time769
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time768
	JMP        L_SetDS1307_Time338
L__SetDS1307_Time769:
L__SetDS1307_Time768:
;Solar_Auto_Switcher.c,1040 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time341
;Solar_Auto_Switcher.c,1042 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time342:
	DEC        R16
	BRNE       L_SetDS1307_Time342
	DEC        R17
	BRNE       L_SetDS1307_Time342
	DEC        R18
	BRNE       L_SetDS1307_Time342
	NOP
;Solar_Auto_Switcher.c,1043 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1045 :: 		}
L_SetDS1307_Time341:
;Solar_Auto_Switcher.c,1046 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time344
;Solar_Auto_Switcher.c,1048 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time345:
	DEC        R16
	BRNE       L_SetDS1307_Time345
	DEC        R17
	BRNE       L_SetDS1307_Time345
	DEC        R18
	BRNE       L_SetDS1307_Time345
	NOP
;Solar_Auto_Switcher.c,1049 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1050 :: 		}
L_SetDS1307_Time344:
;Solar_Auto_Switcher.c,1051 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time977
	JMP        L_SetDS1307_Time347
L__SetDS1307_Time977:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time347:
;Solar_Auto_Switcher.c,1052 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time978
	JMP        L_SetDS1307_Time348
L__SetDS1307_Time978:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time348:
;Solar_Auto_Switcher.c,1053 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time337
L_SetDS1307_Time338:
;Solar_Auto_Switcher.c,1054 :: 		} //  end while set
	JMP        L_SetDS1307_Time334
L_SetDS1307_Time335:
;Solar_Auto_Switcher.c,1056 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time349:
	DEC        R16
	BRNE       L_SetDS1307_Time349
	DEC        R17
	BRNE       L_SetDS1307_Time349
	DEC        R18
	BRNE       L_SetDS1307_Time349
;Solar_Auto_Switcher.c,1057 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1060 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1061 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time351:
	DEC        R16
	BRNE       L_SetDS1307_Time351
	DEC        R17
	BRNE       L_SetDS1307_Time351
	DEC        R18
	BRNE       L_SetDS1307_Time351
	NOP
;Solar_Auto_Switcher.c,1062 :: 		while (Set==1)
L_SetDS1307_Time353:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time354
;Solar_Auto_Switcher.c,1064 :: 		ByteToStr(set_ds1307_year,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_year+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1065 :: 		LCD_Out(2,14,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1066 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time355
	JMP        L_SetDS1307_Time354
L_SetDS1307_Time355:
;Solar_Auto_Switcher.c,1067 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time356:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time771
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time770
	JMP        L_SetDS1307_Time357
L__SetDS1307_Time771:
L__SetDS1307_Time770:
;Solar_Auto_Switcher.c,1069 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time360
;Solar_Auto_Switcher.c,1071 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time361:
	DEC        R16
	BRNE       L_SetDS1307_Time361
	DEC        R17
	BRNE       L_SetDS1307_Time361
	DEC        R18
	BRNE       L_SetDS1307_Time361
	NOP
;Solar_Auto_Switcher.c,1072 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1074 :: 		}
L_SetDS1307_Time360:
;Solar_Auto_Switcher.c,1075 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time363
;Solar_Auto_Switcher.c,1077 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time364:
	DEC        R16
	BRNE       L_SetDS1307_Time364
	DEC        R17
	BRNE       L_SetDS1307_Time364
	DEC        R18
	BRNE       L_SetDS1307_Time364
	NOP
;Solar_Auto_Switcher.c,1078 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1079 :: 		}
L_SetDS1307_Time363:
;Solar_Auto_Switcher.c,1080 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time979
	JMP        L_SetDS1307_Time366
L__SetDS1307_Time979:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time366:
;Solar_Auto_Switcher.c,1081 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time980
	JMP        L_SetDS1307_Time367
L__SetDS1307_Time980:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time367:
;Solar_Auto_Switcher.c,1083 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time356
L_SetDS1307_Time357:
;Solar_Auto_Switcher.c,1084 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
	LDS        R2, _set_ds1307_year+0
	CALL       _Dec2Bcd+0
	STD        Y+1, R16
	LDS        R2, _set_ds1307_month+0
	CALL       _Dec2Bcd+0
	STD        Y+0, R16
	LDS        R2, _set_ds1307_day+0
	CALL       _Dec2Bcd+0
	LDD        R18, Y+1
	LDD        R17, Y+0
	MOV        R6, R18
	LDI        R27, 0
	MOV        R7, R27
	MOV        R4, R17
	LDI        R27, 0
	MOV        R5, R27
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Write_Date+0
;Solar_Auto_Switcher.c,1085 :: 		} //  end while set
	JMP        L_SetDS1307_Time353
L_SetDS1307_Time354:
;Solar_Auto_Switcher.c,1086 :: 		}  // end setTimeAndData
L_end_SetDS1307_Time:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _SetDS1307_Time

_SetLowBatteryVoltage:

;Solar_Auto_Switcher.c,1179 :: 		void SetLowBatteryVoltage()
;Solar_Auto_Switcher.c,1181 :: 		LCD_OUT(1,1,"Low Battery  [5]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr26_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr26_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1182 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage368:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage368
	DEC        R17
	BRNE       L_SetLowBatteryVoltage368
	DEC        R18
	BRNE       L_SetLowBatteryVoltage368
	NOP
;Solar_Auto_Switcher.c,1183 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1184 :: 		while(Set==1)
L_SetLowBatteryVoltage370:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage371
;Solar_Auto_Switcher.c,1186 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1187 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_28_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_28_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, hi_addr(_txt+0)
	PUSH       R27
	LDI        R27, #lo_addr(_txt+0)
	PUSH       R27
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1188 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1190 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage372
	JMP        L_SetLowBatteryVoltage371
L_SetLowBatteryVoltage372:
;Solar_Auto_Switcher.c,1191 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage373:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage745
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage744
	JMP        L_SetLowBatteryVoltage374
L__SetLowBatteryVoltage745:
L__SetLowBatteryVoltage744:
;Solar_Auto_Switcher.c,1193 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage377
;Solar_Auto_Switcher.c,1195 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage378:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage378
	DEC        R17
	BRNE       L_SetLowBatteryVoltage378
	DEC        R18
	BRNE       L_SetLowBatteryVoltage378
	NOP
;Solar_Auto_Switcher.c,1196 :: 		Mini_Battery_Voltage+=0.1;
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _Mini_Battery_Voltage+0, R16
	STS        _Mini_Battery_Voltage+1, R17
	STS        _Mini_Battery_Voltage+2, R18
	STS        _Mini_Battery_Voltage+3, R19
;Solar_Auto_Switcher.c,1198 :: 		}
L_SetLowBatteryVoltage377:
;Solar_Auto_Switcher.c,1199 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage380
;Solar_Auto_Switcher.c,1201 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage381:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage381
	DEC        R17
	BRNE       L_SetLowBatteryVoltage381
	DEC        R18
	BRNE       L_SetLowBatteryVoltage381
	NOP
;Solar_Auto_Switcher.c,1202 :: 		Mini_Battery_Voltage-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	CALL       _float_fpsub1+0
	STS        _Mini_Battery_Voltage+0, R16
	STS        _Mini_Battery_Voltage+1, R17
	STS        _Mini_Battery_Voltage+2, R18
	STS        _Mini_Battery_Voltage+3, R19
;Solar_Auto_Switcher.c,1203 :: 		}
L_SetLowBatteryVoltage380:
;Solar_Auto_Switcher.c,1204 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 130
	LDI        R23, 66
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetLowBatteryVoltage982
	LDI        R16, 1
L__SetLowBatteryVoltage982:
	TST        R16
	BRNE       L__SetLowBatteryVoltage983
	JMP        L_SetLowBatteryVoltage383
L__SetLowBatteryVoltage983:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage383:
;Solar_Auto_Switcher.c,1205 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetLowBatteryVoltage984
	LDI        R16, 1
L__SetLowBatteryVoltage984:
	TST        R16
	BRNE       L__SetLowBatteryVoltage985
	JMP        L_SetLowBatteryVoltage384
L__SetLowBatteryVoltage985:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage384:
;Solar_Auto_Switcher.c,1206 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage373
L_SetLowBatteryVoltage374:
;Solar_Auto_Switcher.c,1207 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage370
L_SetLowBatteryVoltage371:
;Solar_Auto_Switcher.c,1209 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetLowBatteryVoltage385:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage385
	DEC        R17
	BRNE       L_SetLowBatteryVoltage385
	DEC        R18
	BRNE       L_SetLowBatteryVoltage385
;Solar_Auto_Switcher.c,1210 :: 		while(Set==1)
L_SetLowBatteryVoltage387:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage388
;Solar_Auto_Switcher.c,1212 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1213 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_30_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_30_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, hi_addr(_txt+0)
	PUSH       R27
	LDI        R27, #lo_addr(_txt+0)
	PUSH       R27
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1214 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1216 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage389
	JMP        L_SetLowBatteryVoltage388
L_SetLowBatteryVoltage389:
;Solar_Auto_Switcher.c,1217 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage390:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage747
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage746
	JMP        L_SetLowBatteryVoltage391
L__SetLowBatteryVoltage747:
L__SetLowBatteryVoltage746:
;Solar_Auto_Switcher.c,1219 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage394
;Solar_Auto_Switcher.c,1221 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage395:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage395
	DEC        R17
	BRNE       L_SetLowBatteryVoltage395
	DEC        R18
	BRNE       L_SetLowBatteryVoltage395
	NOP
;Solar_Auto_Switcher.c,1222 :: 		Mini_Battery_Voltage_T2+=0.1;
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _Mini_Battery_Voltage_T2+0, R16
	STS        _Mini_Battery_Voltage_T2+1, R17
	STS        _Mini_Battery_Voltage_T2+2, R18
	STS        _Mini_Battery_Voltage_T2+3, R19
;Solar_Auto_Switcher.c,1224 :: 		}
L_SetLowBatteryVoltage394:
;Solar_Auto_Switcher.c,1225 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage397
;Solar_Auto_Switcher.c,1227 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage398:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage398
	DEC        R17
	BRNE       L_SetLowBatteryVoltage398
	DEC        R18
	BRNE       L_SetLowBatteryVoltage398
	NOP
;Solar_Auto_Switcher.c,1228 :: 		Mini_Battery_Voltage_T2-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	CALL       _float_fpsub1+0
	STS        _Mini_Battery_Voltage_T2+0, R16
	STS        _Mini_Battery_Voltage_T2+1, R17
	STS        _Mini_Battery_Voltage_T2+2, R18
	STS        _Mini_Battery_Voltage_T2+3, R19
;Solar_Auto_Switcher.c,1229 :: 		}
L_SetLowBatteryVoltage397:
;Solar_Auto_Switcher.c,1230 :: 		if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 130
	LDI        R23, 66
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetLowBatteryVoltage986
	LDI        R16, 1
L__SetLowBatteryVoltage986:
	TST        R16
	BRNE       L__SetLowBatteryVoltage987
	JMP        L_SetLowBatteryVoltage400
L__SetLowBatteryVoltage987:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage400:
;Solar_Auto_Switcher.c,1231 :: 		if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetLowBatteryVoltage988
	LDI        R16, 1
L__SetLowBatteryVoltage988:
	TST        R16
	BRNE       L__SetLowBatteryVoltage989
	JMP        L_SetLowBatteryVoltage401
L__SetLowBatteryVoltage989:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage401:
;Solar_Auto_Switcher.c,1232 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage390
L_SetLowBatteryVoltage391:
;Solar_Auto_Switcher.c,1233 :: 		}// end while set
	JMP        L_SetLowBatteryVoltage387
L_SetLowBatteryVoltage388:
;Solar_Auto_Switcher.c,1234 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 48
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1235 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R5, R27
	LDI        R27, 81
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1236 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1237 :: 		}
L_end_SetLowBatteryVoltage:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowBatteryVoltage

_SetStartUpLoadsVoltage:

;Solar_Auto_Switcher.c,1239 :: 		void SetStartUpLoadsVoltage()
;Solar_Auto_Switcher.c,1241 :: 		LCD_OUT(1,1,"Start Loads V[6]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr31_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr31_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1242 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage402:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage402
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage402
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage402
	NOP
;Solar_Auto_Switcher.c,1243 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1244 :: 		while(Set==1)
L_SetStartUpLoadsVoltage404:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage405
;Solar_Auto_Switcher.c,1246 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1247 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_33_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_33_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, hi_addr(_txt+0)
	PUSH       R27
	LDI        R27, #lo_addr(_txt+0)
	PUSH       R27
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1248 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1250 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage406
	JMP        L_SetStartUpLoadsVoltage405
L_SetStartUpLoadsVoltage406:
;Solar_Auto_Switcher.c,1251 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage407:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage751
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage750
	JMP        L_SetStartUpLoadsVoltage408
L__SetStartUpLoadsVoltage751:
L__SetStartUpLoadsVoltage750:
;Solar_Auto_Switcher.c,1253 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage411
;Solar_Auto_Switcher.c,1255 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage412:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage412
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage412
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage412
	NOP
;Solar_Auto_Switcher.c,1256 :: 		StartLoadsVoltage+=0.1;
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _StartLoadsVoltage+0, R16
	STS        _StartLoadsVoltage+1, R17
	STS        _StartLoadsVoltage+2, R18
	STS        _StartLoadsVoltage+3, R19
;Solar_Auto_Switcher.c,1258 :: 		}
L_SetStartUpLoadsVoltage411:
;Solar_Auto_Switcher.c,1259 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage414
;Solar_Auto_Switcher.c,1261 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage415:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage415
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage415
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage415
	NOP
;Solar_Auto_Switcher.c,1262 :: 		StartLoadsVoltage-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	CALL       _float_fpsub1+0
	STS        _StartLoadsVoltage+0, R16
	STS        _StartLoadsVoltage+1, R17
	STS        _StartLoadsVoltage+2, R18
	STS        _StartLoadsVoltage+3, R19
;Solar_Auto_Switcher.c,1263 :: 		}
L_SetStartUpLoadsVoltage414:
;Solar_Auto_Switcher.c,1264 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 130
	LDI        R23, 66
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetStartUpLoadsVoltage991
	LDI        R16, 1
L__SetStartUpLoadsVoltage991:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage992
	JMP        L_SetStartUpLoadsVoltage417
L__SetStartUpLoadsVoltage992:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage417:
;Solar_Auto_Switcher.c,1265 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetStartUpLoadsVoltage993
	LDI        R16, 1
L__SetStartUpLoadsVoltage993:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage994
	JMP        L_SetStartUpLoadsVoltage418
L__SetStartUpLoadsVoltage994:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage418:
;Solar_Auto_Switcher.c,1266 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage407
L_SetStartUpLoadsVoltage408:
;Solar_Auto_Switcher.c,1267 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage404
L_SetStartUpLoadsVoltage405:
;Solar_Auto_Switcher.c,1269 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetStartUpLoadsVoltage419:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage419
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage419
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage419
;Solar_Auto_Switcher.c,1270 :: 		while(Set==1)
L_SetStartUpLoadsVoltage421:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage422
;Solar_Auto_Switcher.c,1272 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1273 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);     // re format vin_battery to have 2 decimals
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_35_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_35_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, hi_addr(_txt+0)
	PUSH       R27
	LDI        R27, #lo_addr(_txt+0)
	PUSH       R27
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1274 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1276 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage423
	JMP        L_SetStartUpLoadsVoltage422
L_SetStartUpLoadsVoltage423:
;Solar_Auto_Switcher.c,1277 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage424:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage753
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage752
	JMP        L_SetStartUpLoadsVoltage425
L__SetStartUpLoadsVoltage753:
L__SetStartUpLoadsVoltage752:
;Solar_Auto_Switcher.c,1282 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage428
;Solar_Auto_Switcher.c,1284 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage429:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage429
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage429
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage429
	NOP
;Solar_Auto_Switcher.c,1285 :: 		StartLoadsVoltage_T2+=0.1;
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _StartLoadsVoltage_T2+0, R16
	STS        _StartLoadsVoltage_T2+1, R17
	STS        _StartLoadsVoltage_T2+2, R18
	STS        _StartLoadsVoltage_T2+3, R19
;Solar_Auto_Switcher.c,1287 :: 		}
L_SetStartUpLoadsVoltage428:
;Solar_Auto_Switcher.c,1288 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage431
;Solar_Auto_Switcher.c,1290 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage432:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage432
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage432
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage432
	NOP
;Solar_Auto_Switcher.c,1291 :: 		StartLoadsVoltage_T2-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
	CALL       _float_fpsub1+0
	STS        _StartLoadsVoltage_T2+0, R16
	STS        _StartLoadsVoltage_T2+1, R17
	STS        _StartLoadsVoltage_T2+2, R18
	STS        _StartLoadsVoltage_T2+3, R19
;Solar_Auto_Switcher.c,1292 :: 		}
L_SetStartUpLoadsVoltage431:
;Solar_Auto_Switcher.c,1293 :: 		if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 130
	LDI        R23, 66
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetStartUpLoadsVoltage995
	LDI        R16, 1
L__SetStartUpLoadsVoltage995:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage996
	JMP        L_SetStartUpLoadsVoltage434
L__SetStartUpLoadsVoltage996:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage434:
;Solar_Auto_Switcher.c,1294 :: 		if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetStartUpLoadsVoltage997
	LDI        R16, 1
L__SetStartUpLoadsVoltage997:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage998
	JMP        L_SetStartUpLoadsVoltage435
L__SetStartUpLoadsVoltage998:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage435:
;Solar_Auto_Switcher.c,1295 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage424
L_SetStartUpLoadsVoltage425:
;Solar_Auto_Switcher.c,1296 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage421
L_SetStartUpLoadsVoltage422:
;Solar_Auto_Switcher.c,1297 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 64
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1298 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);   // save float number to
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage_T2+0)
	MOV        R5, R27
	LDI        R27, 85
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1300 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1301 :: 		}
L_end_SetStartUpLoadsVoltage:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetStartUpLoadsVoltage

_SetHighVoltage:

;Solar_Auto_Switcher.c,1303 :: 		void SetHighVoltage()
;Solar_Auto_Switcher.c,1305 :: 		LCD_OUT(1,1,"High AC Volt [7]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1306 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetHighVoltage436:
	DEC        R16
	BRNE       L_SetHighVoltage436
	DEC        R17
	BRNE       L_SetHighVoltage436
	DEC        R18
	BRNE       L_SetHighVoltage436
	NOP
;Solar_Auto_Switcher.c,1307 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1308 :: 		while(Set==1)
L_SetHighVoltage438:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetHighVoltage439
;Solar_Auto_Switcher.c,1310 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1311 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1312 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage440
	JMP        L_SetHighVoltage439
L_SetHighVoltage440:
;Solar_Auto_Switcher.c,1313 :: 		while(Increment==1 || Decrement==1)
L_SetHighVoltage441:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetHighVoltage780
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetHighVoltage779
	JMP        L_SetHighVoltage442
L__SetHighVoltage780:
L__SetHighVoltage779:
;Solar_Auto_Switcher.c,1315 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1316 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1317 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage445
;Solar_Auto_Switcher.c,1319 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage446:
	DEC        R16
	BRNE       L_SetHighVoltage446
	DEC        R17
	BRNE       L_SetHighVoltage446
	DEC        R18
	BRNE       L_SetHighVoltage446
	NOP
;Solar_Auto_Switcher.c,1320 :: 		High_Voltage++;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1321 :: 		}
L_SetHighVoltage445:
;Solar_Auto_Switcher.c,1322 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetHighVoltage448
;Solar_Auto_Switcher.c,1324 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage449:
	DEC        R16
	BRNE       L_SetHighVoltage449
	DEC        R17
	BRNE       L_SetHighVoltage449
	DEC        R18
	BRNE       L_SetHighVoltage449
	NOP
;Solar_Auto_Switcher.c,1325 :: 		High_Voltage--;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1326 :: 		}
L_SetHighVoltage448:
;Solar_Auto_Switcher.c,1327 :: 		if(High_Voltage > 255 ) High_Voltage=0;
	LDS        R18, _High_Voltage+0
	LDS        R19, _High_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetHighVoltage1000
	JMP        L_SetHighVoltage451
L__SetHighVoltage1000:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage451:
;Solar_Auto_Switcher.c,1328 :: 		if (High_Voltage < 0 ) High_Voltage=0;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CPI        R17, 0
	BRNE       L__SetHighVoltage1001
	CPI        R16, 0
L__SetHighVoltage1001:
	BRLO       L__SetHighVoltage1002
	JMP        L_SetHighVoltage452
L__SetHighVoltage1002:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage452:
;Solar_Auto_Switcher.c,1329 :: 		} // end while increment or decrement
	JMP        L_SetHighVoltage441
L_SetHighVoltage442:
;Solar_Auto_Switcher.c,1330 :: 		} // end while set
	JMP        L_SetHighVoltage438
L_SetHighVoltage439:
;Solar_Auto_Switcher.c,1331 :: 		EEPROM_Write(0x12,High_Voltage);
	LDS        R4, _High_Voltage+0
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1332 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1333 :: 		}
L_end_SetHighVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetHighVoltage

_SetLowVoltage:

;Solar_Auto_Switcher.c,1335 :: 		void SetLowVoltage()
;Solar_Auto_Switcher.c,1337 :: 		LCD_OUT(1,1,"Low AC Volt [8]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1338 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowVoltage453:
	DEC        R16
	BRNE       L_SetLowVoltage453
	DEC        R17
	BRNE       L_SetLowVoltage453
	DEC        R18
	BRNE       L_SetLowVoltage453
	NOP
;Solar_Auto_Switcher.c,1339 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1340 :: 		while(Set==1)
L_SetLowVoltage455:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowVoltage456
;Solar_Auto_Switcher.c,1342 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1343 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1344 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage457
	JMP        L_SetLowVoltage456
L_SetLowVoltage457:
;Solar_Auto_Switcher.c,1345 :: 		while(Increment==1 || Decrement==1)
L_SetLowVoltage458:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowVoltage783
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowVoltage782
	JMP        L_SetLowVoltage459
L__SetLowVoltage783:
L__SetLowVoltage782:
;Solar_Auto_Switcher.c,1347 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1348 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1349 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage462
;Solar_Auto_Switcher.c,1351 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage463:
	DEC        R16
	BRNE       L_SetLowVoltage463
	DEC        R17
	BRNE       L_SetLowVoltage463
	DEC        R18
	BRNE       L_SetLowVoltage463
	NOP
;Solar_Auto_Switcher.c,1352 :: 		Low_Voltage++;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1353 :: 		}
L_SetLowVoltage462:
;Solar_Auto_Switcher.c,1354 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowVoltage465
;Solar_Auto_Switcher.c,1356 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage466:
	DEC        R16
	BRNE       L_SetLowVoltage466
	DEC        R17
	BRNE       L_SetLowVoltage466
	DEC        R18
	BRNE       L_SetLowVoltage466
	NOP
;Solar_Auto_Switcher.c,1357 :: 		Low_Voltage--;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1358 :: 		}
L_SetLowVoltage465:
;Solar_Auto_Switcher.c,1359 :: 		if(Low_Voltage > 255 ) Low_Voltage=0;
	LDS        R18, _Low_Voltage+0
	LDS        R19, _Low_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetLowVoltage1004
	JMP        L_SetLowVoltage468
L__SetLowVoltage1004:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage468:
;Solar_Auto_Switcher.c,1360 :: 		if (Low_Voltage < 0 ) Low_Voltage=0;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CPI        R17, 0
	BRNE       L__SetLowVoltage1005
	CPI        R16, 0
L__SetLowVoltage1005:
	BRLO       L__SetLowVoltage1006
	JMP        L_SetLowVoltage469
L__SetLowVoltage1006:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage469:
;Solar_Auto_Switcher.c,1361 :: 		} // end while increment or decrement
	JMP        L_SetLowVoltage458
L_SetLowVoltage459:
;Solar_Auto_Switcher.c,1362 :: 		} // end while set
	JMP        L_SetLowVoltage455
L_SetLowVoltage456:
;Solar_Auto_Switcher.c,1363 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1364 :: 		EEPROM_Write(0x13,Low_Voltage);
	LDS        R4, _Low_Voltage+0
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1365 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1366 :: 		}
L_end_SetLowVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowVoltage

_Startup_Timers:

;Solar_Auto_Switcher.c,1370 :: 		void Startup_Timers()
;Solar_Auto_Switcher.c,1372 :: 		LCD_OUT(1,1,"Start Loads [15]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1373 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers470:
	DEC        R16
	BRNE       L_Startup_Timers470
	DEC        R17
	BRNE       L_Startup_Timers470
	DEC        R18
	BRNE       L_Startup_Timers470
	NOP
;Solar_Auto_Switcher.c,1374 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1375 :: 		while(Set==1)
L_Startup_Timers472:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers473
;Solar_Auto_Switcher.c,1377 :: 		IntToStr(startupTIme_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_1+0
	LDS        R3, _startupTIme_1+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1378 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1380 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1381 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers474
	JMP        L_Startup_Timers473
L_Startup_Timers474:
;Solar_Auto_Switcher.c,1382 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers475:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers775
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers774
	JMP        L_Startup_Timers476
L__Startup_Timers775:
L__Startup_Timers774:
;Solar_Auto_Switcher.c,1384 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers479
;Solar_Auto_Switcher.c,1386 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers480:
	DEC        R16
	BRNE       L_Startup_Timers480
	DEC        R17
	BRNE       L_Startup_Timers480
	DEC        R18
	BRNE       L_Startup_Timers480
	NOP
;Solar_Auto_Switcher.c,1387 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1388 :: 		}
L_Startup_Timers479:
;Solar_Auto_Switcher.c,1389 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers482
;Solar_Auto_Switcher.c,1391 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers483:
	DEC        R16
	BRNE       L_Startup_Timers483
	DEC        R17
	BRNE       L_Startup_Timers483
	DEC        R18
	BRNE       L_Startup_Timers483
	NOP
;Solar_Auto_Switcher.c,1392 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1393 :: 		}
L_Startup_Timers482:
;Solar_Auto_Switcher.c,1394 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1008
	JMP        L_Startup_Timers485
L__Startup_Timers1008:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers485:
;Solar_Auto_Switcher.c,1395 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1009
	CPI        R16, 0
L__Startup_Timers1009:
	BRLO       L__Startup_Timers1010
	JMP        L_Startup_Timers486
L__Startup_Timers1010:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers486:
;Solar_Auto_Switcher.c,1396 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers475
L_Startup_Timers476:
;Solar_Auto_Switcher.c,1397 :: 		} // end while main while set
	JMP        L_Startup_Timers472
L_Startup_Timers473:
;Solar_Auto_Switcher.c,1399 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_Startup_Timers487:
	DEC        R16
	BRNE       L_Startup_Timers487
	DEC        R17
	BRNE       L_Startup_Timers487
	DEC        R18
	BRNE       L_Startup_Timers487
;Solar_Auto_Switcher.c,1400 :: 		while (Set==1)
L_Startup_Timers489:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers490
;Solar_Auto_Switcher.c,1402 :: 		IntToStr(startupTIme_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_2+0
	LDS        R3, _startupTIme_2+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1403 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1405 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1406 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers491
	JMP        L_Startup_Timers490
L_Startup_Timers491:
;Solar_Auto_Switcher.c,1407 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers492:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers777
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers776
	JMP        L_Startup_Timers493
L__Startup_Timers777:
L__Startup_Timers776:
;Solar_Auto_Switcher.c,1409 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers496
;Solar_Auto_Switcher.c,1411 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers497:
	DEC        R16
	BRNE       L_Startup_Timers497
	DEC        R17
	BRNE       L_Startup_Timers497
	DEC        R18
	BRNE       L_Startup_Timers497
	NOP
;Solar_Auto_Switcher.c,1412 :: 		startupTIme_2++;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1413 :: 		}
L_Startup_Timers496:
;Solar_Auto_Switcher.c,1414 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers499
;Solar_Auto_Switcher.c,1416 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers500:
	DEC        R16
	BRNE       L_Startup_Timers500
	DEC        R17
	BRNE       L_Startup_Timers500
	DEC        R18
	BRNE       L_Startup_Timers500
	NOP
;Solar_Auto_Switcher.c,1417 :: 		startupTIme_2--;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1418 :: 		}
L_Startup_Timers499:
;Solar_Auto_Switcher.c,1419 :: 		if(startupTIme_2 > 600 ) startupTIme_2=0;
	LDS        R18, _startupTIme_2+0
	LDS        R19, _startupTIme_2+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1011
	JMP        L_Startup_Timers502
L__Startup_Timers1011:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers502:
;Solar_Auto_Switcher.c,1420 :: 		if (startupTIme_2<0) startupTIme_2=0;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1012
	CPI        R16, 0
L__Startup_Timers1012:
	BRLO       L__Startup_Timers1013
	JMP        L_Startup_Timers503
L__Startup_Timers1013:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers503:
;Solar_Auto_Switcher.c,1421 :: 		} // end while increment and decrement
	JMP        L_Startup_Timers492
L_Startup_Timers493:
;Solar_Auto_Switcher.c,1422 :: 		} // end while set
	JMP        L_Startup_Timers489
L_Startup_Timers490:
;Solar_Auto_Switcher.c,1424 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 69
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1425 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);   // save float number to eeprom
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_2+0)
	MOV        R5, R27
	LDI        R27, 71
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1426 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1429 :: 		} // end  function
L_end_Startup_Timers:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Startup_Timers

_Screen_1:

;Solar_Auto_Switcher.c,1457 :: 		void Screen_1()
;Solar_Auto_Switcher.c,1461 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Auto_Switcher.c,1462 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Auto_Switcher.c,1463 :: 		CalculateAC();
	CALL       _CalculateAC+0
;Solar_Auto_Switcher.c,1464 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Auto_Switcher.c,1466 :: 		void ADCBattery()
;Solar_Auto_Switcher.c,1468 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Auto_Switcher.c,1469 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Auto_Switcher.c,1470 :: 		ADPS2_Bit=1;
	LDS        R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	STS        ADPS2_bit+0, R27
;Solar_Auto_Switcher.c,1471 :: 		ADPS1_Bit=1;
	LDS        R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	STS        ADPS1_bit+0, R27
;Solar_Auto_Switcher.c,1472 :: 		ADPS0_Bit=0;
	LDS        R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	STS        ADPS0_bit+0, R27
;Solar_Auto_Switcher.c,1473 :: 		}
L_end_ADCBattery:
	POP        R2
	RET
; end of _ADCBattery

_Read_Battery:

;Solar_Auto_Switcher.c,1475 :: 		void Read_Battery()
;Solar_Auto_Switcher.c,1477 :: 		ADC_Value=ADC_Read(1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Auto_Switcher.c,1478 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 160
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	STS        _Battery_Voltage+0, R16
	STS        _Battery_Voltage+1, R17
	STS        _Battery_Voltage+2, R18
	STS        _Battery_Voltage+3, R19
;Solar_Auto_Switcher.c,1481 :: 		Vin_Battery=((10.5/0.5)*Battery_Voltage); // 0.3 volt error from reading
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 168
	LDI        R23, 65
	CALL       _float_fpmul1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
;Solar_Auto_Switcher.c,1482 :: 		LCD_OUT(2,1,"V=");
	LDI        R27, #lo_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1483 :: 		sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_42_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_42_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, hi_addr(_txt+0)
	PUSH       R27
	LDI        R27, #lo_addr(_txt+0)
	PUSH       R27
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1484 :: 		LCD_OUT(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1486 :: 		}
L_end_Read_Battery:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Read_Battery

_LowBatteryVoltageAlarm:

;Solar_Auto_Switcher.c,1489 :: 		void LowBatteryVoltageAlarm()
;Solar_Auto_Switcher.c,1491 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
	LDS        R20, _Mini_Battery_Voltage+0
	LDS        R21, _Mini_Battery_Voltage+1
	LDS        R22, _Mini_Battery_Voltage+2
	LDS        R23, _Mini_Battery_Voltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__LowBatteryVoltageAlarm1018
	LDI        R16, 1
L__LowBatteryVoltageAlarm1018:
	TST        R16
	BRNE       L__LowBatteryVoltageAlarm1019
	JMP        L__LowBatteryVoltageAlarm799
L__LowBatteryVoltageAlarm1019:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__LowBatteryVoltageAlarm1020
	JMP        L__LowBatteryVoltageAlarm798
L__LowBatteryVoltageAlarm1020:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1021
	JMP        L__LowBatteryVoltageAlarm797
L__LowBatteryVoltageAlarm1021:
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1022
	JMP        L__LowBatteryVoltageAlarm796
L__LowBatteryVoltageAlarm1022:
	JMP        L_LowBatteryVoltageAlarm508
L__LowBatteryVoltageAlarm797:
L__LowBatteryVoltageAlarm796:
L__LowBatteryVoltageAlarm794:
;Solar_Auto_Switcher.c,1493 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1494 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm509:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm509
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm509
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm509
	NOP
;Solar_Auto_Switcher.c,1495 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1496 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm511:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm511
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm511
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm511
	NOP
;Solar_Auto_Switcher.c,1497 :: 		}
L_LowBatteryVoltageAlarm508:
;Solar_Auto_Switcher.c,1491 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
L__LowBatteryVoltageAlarm799:
L__LowBatteryVoltageAlarm798:
;Solar_Auto_Switcher.c,1498 :: 		}
L_end_LowBatteryVoltageAlarm:
	RET
; end of _LowBatteryVoltageAlarm

_ReadAC:

;Solar_Auto_Switcher.c,1500 :: 		unsigned int ReadAC()
;Solar_Auto_Switcher.c,1503 :: 		unsigned int max_v=0;
	PUSH       R2
; max_v start address is: 21 (R21)
	LDI        R21, 0
	LDI        R22, 0
;Solar_Auto_Switcher.c,1504 :: 		char i=0;
;Solar_Auto_Switcher.c,1505 :: 		for (i=0;i<100;i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; max_v end address is: 21 (R21)
; i end address is: 18 (R18)
L_ReadAC513:
; i start address is: 18 (R18)
; max_v start address is: 21 (R21)
	CPI        R18, 100
	BRLO       L__ReadAC1024
	JMP        L_ReadAC514
L__ReadAC1024:
;Solar_Auto_Switcher.c,1507 :: 		r=ADC_Read(3);
	PUSH       R18
	LDI        R27, 3
	MOV        R2, R27
	CALL       _ADC_Read+0
	POP        R18
; r start address is: 19 (R19)
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,1508 :: 		if (max_v<r) max_v=r;
	CP         R21, R16
	CPC        R22, R17
	BRLO       L__ReadAC1025
	JMP        L__ReadAC717
L__ReadAC1025:
; max_v end address is: 21 (R21)
; max_v start address is: 16 (R16)
	MOV        R16, R19
	MOV        R17, R20
; r end address is: 19 (R19)
; max_v end address is: 16 (R16)
	MOV        R21, R16
	MOV        R22, R17
	JMP        L_ReadAC516
L__ReadAC717:
L_ReadAC516:
;Solar_Auto_Switcher.c,1509 :: 		delay_us(200);
; max_v start address is: 21 (R21)
	LDI        R17, 3
	LDI        R16, 19
L_ReadAC517:
	DEC        R16
	BRNE       L_ReadAC517
	DEC        R17
	BRNE       L_ReadAC517
;Solar_Auto_Switcher.c,1505 :: 		for (i=0;i<100;i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Solar_Auto_Switcher.c,1510 :: 		}
; i end address is: 18 (R18)
	JMP        L_ReadAC513
L_ReadAC514:
;Solar_Auto_Switcher.c,1511 :: 		return max_v;
	MOV        R16, R21
	MOV        R17, R22
; max_v end address is: 21 (R21)
;Solar_Auto_Switcher.c,1512 :: 		}
;Solar_Auto_Switcher.c,1511 :: 		return max_v;
;Solar_Auto_Switcher.c,1512 :: 		}
L_end_ReadAC:
	POP        R2
	RET
; end of _ReadAC

_CalculateAC:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 15
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Auto_Switcher.c,1514 :: 		void CalculateAC()
;Solar_Auto_Switcher.c,1517 :: 		v=ReadAC();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _ReadAC+0
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1518 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 160
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1519 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1520 :: 		v/=sqrt(2);
	LDI        R27, 0
	MOV        R2, R27
	MOV        R3, R27
	MOV        R4, R27
	LDI        R27, 64
	MOV        R5, R27
	CALL       _sqrt+0
	MOVW       R20, R16
	MOVW       R22, R18
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpdiv1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1521 :: 		v=v+Error_Voltage;
	LDS        R16, _Error_Voltage+0
	LDI        R17, 0
	MOV        R18, R17
	MOV        R19, R17
	CALL       _float_ulong2fp+0
	LDS        R20, _v+0
	LDS        R21, _v+1
	LDS        R22, _v+2
	LDS        R23, _v+3
	CALL       _float_fpadd1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1523 :: 		if (AC_Available==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_CalculateAC519
;Solar_Auto_Switcher.c,1525 :: 		sprintf(buf,"%4.0fV",v);
	MOVW       R20, R28
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_43_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_43_Solar_Auto_Switcher+0)
	PUSH       R27
	PUSH       R21
	PUSH       R20
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1526 :: 		LCD_OUT(2,8,"-");
	LDI        R27, #lo_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1527 :: 		LCD_OUT(2,9,buf);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1528 :: 		}
	JMP        L_CalculateAC520
L_CalculateAC519:
;Solar_Auto_Switcher.c,1532 :: 		}
L_CalculateAC520:
;Solar_Auto_Switcher.c,1533 :: 		VoltageProtector(v);
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _VoltageProtector+0
;Solar_Auto_Switcher.c,1534 :: 		}
L_end_CalculateAC:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 14
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _CalculateAC

_VoltageProtector:

;Solar_Auto_Switcher.c,1538 :: 		void VoltageProtector(unsigned long voltage)
;Solar_Auto_Switcher.c,1541 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRSH       L__VoltageProtector1028
	JMP        L__VoltageProtector789
L__VoltageProtector1028:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRSH       L__VoltageProtector1029
	JMP        L__VoltageProtector788
L__VoltageProtector1029:
	JMP        L_VoltageProtector525
L__VoltageProtector789:
L__VoltageProtector788:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector790
L__VoltageProtector786:
;Solar_Auto_Switcher.c,1543 :: 		VoltageProtectorGood=0;
	LDI        R27, 0
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1544 :: 		}
L_VoltageProtector525:
;Solar_Auto_Switcher.c,1541 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
L__VoltageProtector790:
;Solar_Auto_Switcher.c,1546 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRLO       L__VoltageProtector1030
	JMP        L__VoltageProtector793
L__VoltageProtector1030:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRLO       L__VoltageProtector1031
	JMP        L__VoltageProtector792
L__VoltageProtector1031:
L__VoltageProtector785:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector791
L__VoltageProtector784:
;Solar_Auto_Switcher.c,1548 :: 		VoltageProtectorGood=1;
	LDI        R27, 1
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1546 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
L__VoltageProtector793:
L__VoltageProtector792:
L__VoltageProtector791:
;Solar_Auto_Switcher.c,1550 :: 		}
L_end_VoltageProtector:
	RET
; end of _VoltageProtector

_ErrorList:

;Solar_Auto_Switcher.c,1552 :: 		void ErrorList()
;Solar_Auto_Switcher.c,1563 :: 		if(VoltageProtectorGood==0 && AC_Available==0)  {LCD_OUT(1,16,"2");}  else {LCD_OUT(2,16," ");}
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__ErrorList1033
	JMP        L__ErrorList802
L__ErrorList1033:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__ErrorList801
L__ErrorList800:
	LDI        R27, #lo_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_ErrorList534
L__ErrorList802:
L__ErrorList801:
	LDI        R27, #lo_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_ErrorList534:
;Solar_Auto_Switcher.c,1565 :: 		}
L_end_ErrorList:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _ErrorList

_Start_Timer_0_A:

;Solar_Auto_Switcher.c,1568 :: 		void Start_Timer_0_A()
;Solar_Auto_Switcher.c,1570 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Auto_Switcher.c,1571 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Auto_Switcher.c,1572 :: 		WGM02_bit=0;
	IN         R27, WGM02_bit+0
	CBR        R27, BitMask(WGM02_bit+0)
	OUT        WGM02_bit+0, R27
;Solar_Auto_Switcher.c,1573 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1574 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1575 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1576 :: 		OCR0A=0xFF;
	LDI        R27, 255
	OUT        OCR0A+0, R27
;Solar_Auto_Switcher.c,1577 :: 		OCIE0A_Bit=1;
	LDS        R27, OCIE0A_bit+0
	SBR        R27, BitMask(OCIE0A_bit+0)
	STS        OCIE0A_bit+0, R27
;Solar_Auto_Switcher.c,1578 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_A_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,1580 :: 		void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
;Solar_Auto_Switcher.c,1582 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1583 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Auto_Switcher.c,1584 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Auto_Switcher.c,1585 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Auto_Switcher.c,1588 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1036
	CPI        R18, 244
L__Interupt_Timer_0_A_OFFTime1036:
	BREQ       L__Interupt_Timer_0_A_OFFTime1037
	JMP        L_Interupt_Timer_0_A_OFFTime535
L__Interupt_Timer_0_A_OFFTime1037:
;Solar_Auto_Switcher.c,1591 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
	LDS        R20, _Mini_Battery_Voltage+0
	LDS        R21, _Mini_Battery_Voltage+1
	LDS        R22, _Mini_Battery_Voltage+2
	LDS        R23, _Mini_Battery_Voltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1038
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1038:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1039
	JMP        L__Interupt_Timer_0_A_OFFTime807
L__Interupt_Timer_0_A_OFFTime1039:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime806
L__Interupt_Timer_0_A_OFFTime805:
;Solar_Auto_Switcher.c,1593 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1594 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime539:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime539
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime539
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime539
	NOP
;Solar_Auto_Switcher.c,1595 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1596 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1591 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime807:
L__Interupt_Timer_0_A_OFFTime806:
;Solar_Auto_Switcher.c,1598 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Auto_Switcher.c,1599 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1600 :: 		}
L_Interupt_Timer_0_A_OFFTime535:
;Solar_Auto_Switcher.c,1603 :: 		if (Timer_Counter_4==500)              // more than 10 seconds
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	CPI        R17, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1040
	CPI        R16, 244
L__Interupt_Timer_0_A_OFFTime1040:
	BREQ       L__Interupt_Timer_0_A_OFFTime1041
	JMP        L_Interupt_Timer_0_A_OFFTime541
L__Interupt_Timer_0_A_OFFTime1041:
;Solar_Auto_Switcher.c,1606 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
	LDS        R20, _Mini_Battery_Voltage_T2+0
	LDS        R21, _Mini_Battery_Voltage_T2+1
	LDS        R22, _Mini_Battery_Voltage_T2+2
	LDS        R23, _Mini_Battery_Voltage_T2+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1042
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1042:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1043
	JMP        L__Interupt_Timer_0_A_OFFTime809
L__Interupt_Timer_0_A_OFFTime1043:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime808
L__Interupt_Timer_0_A_OFFTime804:
;Solar_Auto_Switcher.c,1608 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1609 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime545:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime545
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime545
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime545
	NOP
;Solar_Auto_Switcher.c,1610 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1611 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1606 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime809:
L__Interupt_Timer_0_A_OFFTime808:
;Solar_Auto_Switcher.c,1613 :: 		Timer_Counter_4=0;
	LDI        R27, 0
	STS        _Timer_Counter_4+0, R27
	STS        _Timer_Counter_4+1, R27
;Solar_Auto_Switcher.c,1614 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1615 :: 		}
L_Interupt_Timer_0_A_OFFTime541:
;Solar_Auto_Switcher.c,1619 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_A_OFFTime1044
	CPI        R16, 232
L__Interupt_Timer_0_A_OFFTime1044:
	BREQ       L__Interupt_Timer_0_A_OFFTime1045
	JMP        L_Interupt_Timer_0_A_OFFTime547
L__Interupt_Timer_0_A_OFFTime1045:
;Solar_Auto_Switcher.c,1621 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1046
	JMP        L__Interupt_Timer_0_A_OFFTime811
L__Interupt_Timer_0_A_OFFTime1046:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime810
L__Interupt_Timer_0_A_OFFTime803:
;Solar_Auto_Switcher.c,1623 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1624 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1625 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1626 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1621 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
L__Interupt_Timer_0_A_OFFTime811:
L__Interupt_Timer_0_A_OFFTime810:
;Solar_Auto_Switcher.c,1628 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Auto_Switcher.c,1629 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1630 :: 		}
L_Interupt_Timer_0_A_OFFTime547:
;Solar_Auto_Switcher.c,1632 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1633 :: 		OCF0A_Bit=1; // clear
	IN         R27, OCF0A_bit+0
	SBR        R27, BitMask(OCF0A_bit+0)
	OUT        OCF0A_bit+0, R27
;Solar_Auto_Switcher.c,1634 :: 		}
L_end_Interupt_Timer_0_A_OFFTime:
	POP        R4
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interupt_Timer_0_A_OFFTime

_Stop_Timer_0:

;Solar_Auto_Switcher.c,1636 :: 		void Stop_Timer_0()
;Solar_Auto_Switcher.c,1638 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1639 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Auto_Switcher.c,1640 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1641 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Auto_Switcher.c,1644 :: 		void EEPROM_FactorySettings(char period)
;Solar_Auto_Switcher.c,1646 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1049
	JMP        L_EEPROM_FactorySettings551
L__EEPROM_FactorySettings1049:
;Solar_Auto_Switcher.c,1648 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1649 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1650 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1651 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1652 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1653 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1655 :: 		EEPROM_Write(0x00,8);  // writing start hours
	PUSH       R2
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1656 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1657 :: 		EEPROM_Write(0x03,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1658 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1660 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1661 :: 		EEPROM_Write(0x19,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1662 :: 		EEPROM_Write(0x20,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1663 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1665 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 48
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1666 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 64
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1667 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 69
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1668 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_2+0)
	MOV        R5, R27
	LDI        R27, 71
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1669 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R5, R27
	LDI        R27, 81
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1670 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage_T2+0)
	MOV        R5, R27
	LDI        R27, 85
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
	POP        R2
;Solar_Auto_Switcher.c,1671 :: 		}
L_EEPROM_FactorySettings551:
;Solar_Auto_Switcher.c,1672 :: 		if (period==0) // winter timer
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1050
	JMP        L_EEPROM_FactorySettings552
L__EEPROM_FactorySettings1050:
;Solar_Auto_Switcher.c,1674 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1675 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1676 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1677 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1678 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1679 :: 		StartLoadsVoltage_T2=2.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 32
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 64
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1681 :: 		EEPROM_Write(0x00,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1682 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1683 :: 		EEPROM_Write(0x03,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1684 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1686 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1687 :: 		EEPROM_Write(0x19,30);    // writing  start minutes
	LDI        R27, 30
	MOV        R4, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1688 :: 		EEPROM_Write(0x20,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1689 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1691 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 48
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1692 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 64
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1693 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 69
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1694 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_2+0)
	MOV        R5, R27
	LDI        R27, 71
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1695 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R5, R27
	LDI        R27, 81
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1696 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage_T2+0)
	MOV        R5, R27
	LDI        R27, 85
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1697 :: 		}
L_EEPROM_FactorySettings552:
;Solar_Auto_Switcher.c,1699 :: 		EEPROM_Write(0x12,255); //  high voltage Grid
	LDI        R27, 255
	MOV        R4, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1700 :: 		EEPROM_Write(0x13,170); // load low voltage
	LDI        R27, 170
	MOV        R4, R27
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1701 :: 		EEPROM_Write(0x49,0); //  timer1_ison
	CLR        R4
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1702 :: 		EEPROM_Write(0x50,0); // timer2_is on
	CLR        R4
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1703 :: 		}
L_end_EEPROM_FactorySettings:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _EEPROM_FactorySettings

_RunTimersNowCheck:

;Solar_Auto_Switcher.c,1705 :: 		RunTimersNowCheck()
;Solar_Auto_Switcher.c,1725 :: 		if(Increment==1 && Exit==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck823
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck822
L__RunTimersNowCheck819:
;Solar_Auto_Switcher.c,1727 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck556:
	DEC        R16
	BRNE       L_RunTimersNowCheck556
	DEC        R17
	BRNE       L_RunTimersNowCheck556
	DEC        R18
	BRNE       L_RunTimersNowCheck556
	NOP
;Solar_Auto_Switcher.c,1728 :: 		if (Increment==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck821
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck820
L__RunTimersNowCheck818:
;Solar_Auto_Switcher.c,1730 :: 		RunLoadsByBass++;
	LDS        R16, _RunLoadsByBass+0
	SUBI       R16, 255
	STS        _RunLoadsByBass+0, R16
;Solar_Auto_Switcher.c,1731 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	CPI        R16, 1
	BREQ       L__RunTimersNowCheck1052
	JMP        L_RunTimersNowCheck561
L__RunTimersNowCheck1052:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_RunTimersNowCheck561:
;Solar_Auto_Switcher.c,1732 :: 		if (RunLoadsByBass>=2 )
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 2
	BRSH       L__RunTimersNowCheck1053
	JMP        L_RunTimersNowCheck562
L__RunTimersNowCheck1053:
;Solar_Auto_Switcher.c,1734 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck563:
	DEC        R16
	BRNE       L_RunTimersNowCheck563
	DEC        R17
	BRNE       L_RunTimersNowCheck563
	DEC        R18
	BRNE       L_RunTimersNowCheck563
	NOP
;Solar_Auto_Switcher.c,1735 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1736 :: 		}
L_RunTimersNowCheck562:
;Solar_Auto_Switcher.c,1737 :: 		LCD_OUT(1,16,"B");
	LDI        R27, #lo_addr(?lstr47_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr47_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1728 :: 		if (Increment==1 && Exit==0)
L__RunTimersNowCheck821:
L__RunTimersNowCheck820:
;Solar_Auto_Switcher.c,1725 :: 		if(Increment==1 && Exit==0)
L__RunTimersNowCheck823:
L__RunTimersNowCheck822:
;Solar_Auto_Switcher.c,1741 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck829
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck828
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck827
L__RunTimersNowCheck817:
;Solar_Auto_Switcher.c,1743 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck568:
	DEC        R16
	BRNE       L_RunTimersNowCheck568
	DEC        R17
	BRNE       L_RunTimersNowCheck568
	DEC        R18
	BRNE       L_RunTimersNowCheck568
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1744 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck826
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck825
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck824
L__RunTimersNowCheck816:
;Solar_Auto_Switcher.c,1746 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck573:
	DEC        R16
	BRNE       L_RunTimersNowCheck573
	DEC        R17
	BRNE       L_RunTimersNowCheck573
	DEC        R18
	BRNE       L_RunTimersNowCheck573
	NOP
;Solar_Auto_Switcher.c,1747 :: 		EEPROM_FactorySettings(1);        // summer time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1748 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck575:
	DEC        R16
	BRNE       L_RunTimersNowCheck575
	DEC        R17
	BRNE       L_RunTimersNowCheck575
	DEC        R18
	BRNE       L_RunTimersNowCheck575
;Solar_Auto_Switcher.c,1749 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1750 :: 		LCD_OUT(2,1,"Reset Summer    ");
	LDI        R27, #lo_addr(?lstr48_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr48_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1751 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck577:
	DEC        R16
	BRNE       L_RunTimersNowCheck577
	DEC        R17
	BRNE       L_RunTimersNowCheck577
	DEC        R18
	BRNE       L_RunTimersNowCheck577
;Solar_Auto_Switcher.c,1752 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1744 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
L__RunTimersNowCheck826:
L__RunTimersNowCheck825:
L__RunTimersNowCheck824:
;Solar_Auto_Switcher.c,1741 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
L__RunTimersNowCheck829:
L__RunTimersNowCheck828:
L__RunTimersNowCheck827:
;Solar_Auto_Switcher.c,1755 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck835
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck834
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck833
L__RunTimersNowCheck815:
;Solar_Auto_Switcher.c,1757 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck582:
	DEC        R16
	BRNE       L_RunTimersNowCheck582
	DEC        R17
	BRNE       L_RunTimersNowCheck582
	DEC        R18
	BRNE       L_RunTimersNowCheck582
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1758 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck832
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck831
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck830
L__RunTimersNowCheck814:
;Solar_Auto_Switcher.c,1760 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck587:
	DEC        R16
	BRNE       L_RunTimersNowCheck587
	DEC        R17
	BRNE       L_RunTimersNowCheck587
	DEC        R18
	BRNE       L_RunTimersNowCheck587
	NOP
;Solar_Auto_Switcher.c,1761 :: 		EEPROM_FactorySettings(0);        // winter time
	CLR        R2
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1762 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck589:
	DEC        R16
	BRNE       L_RunTimersNowCheck589
	DEC        R17
	BRNE       L_RunTimersNowCheck589
	DEC        R18
	BRNE       L_RunTimersNowCheck589
;Solar_Auto_Switcher.c,1763 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1764 :: 		LCD_OUT(2,1,"Reset Winter    ");
	LDI        R27, #lo_addr(?lstr49_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr49_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1765 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck591:
	DEC        R16
	BRNE       L_RunTimersNowCheck591
	DEC        R17
	BRNE       L_RunTimersNowCheck591
	DEC        R18
	BRNE       L_RunTimersNowCheck591
;Solar_Auto_Switcher.c,1766 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1758 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
L__RunTimersNowCheck832:
L__RunTimersNowCheck831:
L__RunTimersNowCheck830:
;Solar_Auto_Switcher.c,1755 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
L__RunTimersNowCheck835:
L__RunTimersNowCheck834:
L__RunTimersNowCheck833:
;Solar_Auto_Switcher.c,1788 :: 		if(Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck839
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck838
L__RunTimersNowCheck813:
;Solar_Auto_Switcher.c,1790 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck596:
	DEC        R16
	BRNE       L_RunTimersNowCheck596
	DEC        R17
	BRNE       L_RunTimersNowCheck596
	DEC        R18
	BRNE       L_RunTimersNowCheck596
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1791 :: 		if (Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck837
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck836
L__RunTimersNowCheck812:
;Solar_Auto_Switcher.c,1793 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,1794 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Auto_Switcher.c,1795 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1796 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1798 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr50_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr50_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1791 :: 		if (Decrement==1 && Exit==0)
L__RunTimersNowCheck837:
L__RunTimersNowCheck836:
;Solar_Auto_Switcher.c,1788 :: 		if(Decrement==1 && Exit==0)
L__RunTimersNowCheck839:
L__RunTimersNowCheck838:
;Solar_Auto_Switcher.c,1801 :: 		}
L_end_RunTimersNowCheck:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_WDT_Enable:

;Solar_Auto_Switcher.c,1803 :: 		void WDT_Enable()
;Solar_Auto_Switcher.c,1807 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1808 :: 		MCUSR &= ~(1<<WDRF);
	IN         R27, MCUSR+0
	CBR        R27, 8
	OUT        MCUSR+0, R27
;Solar_Auto_Switcher.c,1809 :: 		WDTCSR |= (1<<WDCE) | (1<<WDE);     //write a logic one to the Watchdog change enable bit (WDCE) and WDE
	LDS        R16, WDTCSR+0
	ORI        R16, 24
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1810 :: 		WDTCSR |=  (1<<WDE);               //logic one must be written to WDE regardless of the previous value of the WDE bit.
	LDS        R16, WDTCSR+0
	ORI        R16, 8
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1812 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1813 :: 		}
L_end_WDT_Enable:
	RET
; end of _WDT_Enable

_WDT_Prescaler_Change:

;Solar_Auto_Switcher.c,1815 :: 		void WDT_Prescaler_Change()
;Solar_Auto_Switcher.c,1819 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1820 :: 		WDTCSR |= (1<<WDCE) | (1<<WDE);
	LDS        R16, WDTCSR+0
	ORI        R16, 24
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1822 :: 		WDTCSR  = (1<<WDE) | (1<<WDP3) | (1<<WDP0);     // very important the equal as in datasheet examples code
	LDI        R27, 41
	STS        WDTCSR+0, R27
;Solar_Auto_Switcher.c,1824 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1825 :: 		}
L_end_WDT_Prescaler_Change:
	RET
; end of _WDT_Prescaler_Change

_WDT_Disable:

;Solar_Auto_Switcher.c,1827 :: 		void WDT_Disable()
;Solar_Auto_Switcher.c,1831 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1832 :: 		MCUSR &= ~(1<<WDRF);
	IN         R27, MCUSR+0
	CBR        R27, 8
	OUT        MCUSR+0, R27
;Solar_Auto_Switcher.c,1833 :: 		WDTCSR |= (1<<WDCE) | (1<<WDE);
	LDS        R16, WDTCSR+0
	ORI        R16, 24
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1835 :: 		WDTCSR = 0x00;
	LDI        R27, 0
	STS        WDTCSR+0, R27
;Solar_Auto_Switcher.c,1837 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1838 :: 		}
L_end_WDT_Disable:
	RET
; end of _WDT_Disable

_CheckForSet:

;Solar_Auto_Switcher.c,1841 :: 		void CheckForSet()
;Solar_Auto_Switcher.c,1844 :: 		if (Set==0) SetUpProgram();
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_CheckForSet601
	CALL       _SetUpProgram+0
L_CheckForSet601:
;Solar_Auto_Switcher.c,1846 :: 		}
L_end_CheckForSet:
	RET
; end of _CheckForSet

_AutoRunWithOutBatteryProtection:

;Solar_Auto_Switcher.c,1849 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Auto_Switcher.c,1851 :: 		if (Vin_Battery==0)
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	CALL       _float_op_equ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__AutoRunWithOutBatteryProtection1059
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection1059:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection1060
	JMP        L_AutoRunWithOutBatteryProtection602
L__AutoRunWithOutBatteryProtection1060:
;Solar_Auto_Switcher.c,1853 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1854 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection603
L_AutoRunWithOutBatteryProtection602:
;Solar_Auto_Switcher.c,1857 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1858 :: 		}
L_AutoRunWithOutBatteryProtection603:
;Solar_Auto_Switcher.c,1859 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Auto_Switcher.c,1861 :: 		void CheckForTimerActivationInRange()
;Solar_Auto_Switcher.c,1865 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1062
	JMP        L__CheckForTimerActivationInRange846
L__CheckForTimerActivationInRange1062:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1063
	JMP        L__CheckForTimerActivationInRange845
L__CheckForTimerActivationInRange1063:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1064
	JMP        L__CheckForTimerActivationInRange844
L__CheckForTimerActivationInRange1064:
L__CheckForTimerActivationInRange843:
;Solar_Auto_Switcher.c,1867 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1868 :: 		EEPROM_Write(0x49,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1865 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
L__CheckForTimerActivationInRange846:
L__CheckForTimerActivationInRange845:
L__CheckForTimerActivationInRange844:
;Solar_Auto_Switcher.c,1872 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1065
	JMP        L__CheckForTimerActivationInRange849
L__CheckForTimerActivationInRange1065:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1066
	JMP        L__CheckForTimerActivationInRange848
L__CheckForTimerActivationInRange1066:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1067
	JMP        L__CheckForTimerActivationInRange847
L__CheckForTimerActivationInRange1067:
L__CheckForTimerActivationInRange842:
;Solar_Auto_Switcher.c,1875 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1068
	JMP        L_CheckForTimerActivationInRange610
L__CheckForTimerActivationInRange1068:
;Solar_Auto_Switcher.c,1877 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1878 :: 		EEPROM_Write(0x49,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1879 :: 		}
L_CheckForTimerActivationInRange610:
;Solar_Auto_Switcher.c,1872 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
L__CheckForTimerActivationInRange849:
L__CheckForTimerActivationInRange848:
L__CheckForTimerActivationInRange847:
;Solar_Auto_Switcher.c,1907 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1069
	JMP        L__CheckForTimerActivationInRange852
L__CheckForTimerActivationInRange1069:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1070
	JMP        L__CheckForTimerActivationInRange851
L__CheckForTimerActivationInRange1070:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1071
	JMP        L__CheckForTimerActivationInRange850
L__CheckForTimerActivationInRange1071:
L__CheckForTimerActivationInRange841:
;Solar_Auto_Switcher.c,1909 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1910 :: 		EEPROM_Write(0x50,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1907 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange852:
L__CheckForTimerActivationInRange851:
L__CheckForTimerActivationInRange850:
;Solar_Auto_Switcher.c,1913 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1072
	JMP        L__CheckForTimerActivationInRange855
L__CheckForTimerActivationInRange1072:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1073
	JMP        L__CheckForTimerActivationInRange854
L__CheckForTimerActivationInRange1073:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1074
	JMP        L__CheckForTimerActivationInRange853
L__CheckForTimerActivationInRange1074:
L__CheckForTimerActivationInRange840:
;Solar_Auto_Switcher.c,1915 :: 		if(ReadMinutes()<minutes_lcd_timer2_stop)
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1075
	JMP        L_CheckForTimerActivationInRange617
L__CheckForTimerActivationInRange1075:
;Solar_Auto_Switcher.c,1917 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1918 :: 		EEPROM_Write(0x50,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1919 :: 		}
L_CheckForTimerActivationInRange617:
;Solar_Auto_Switcher.c,1913 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange855:
L__CheckForTimerActivationInRange854:
L__CheckForTimerActivationInRange853:
;Solar_Auto_Switcher.c,1945 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Auto_Switcher.c,1948 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Auto_Switcher.c,1951 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff860
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1077
	JMP        L__TurnLoadsOffWhenGridOff859
L__TurnLoadsOffWhenGridOff1077:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1078
	JMP        L__TurnLoadsOffWhenGridOff858
L__TurnLoadsOffWhenGridOff1078:
L__TurnLoadsOffWhenGridOff857:
;Solar_Auto_Switcher.c,1953 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1954 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1955 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1956 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1951 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__TurnLoadsOffWhenGridOff860:
L__TurnLoadsOffWhenGridOff859:
L__TurnLoadsOffWhenGridOff858:
;Solar_Auto_Switcher.c,1959 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff863
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1079
	JMP        L__TurnLoadsOffWhenGridOff862
L__TurnLoadsOffWhenGridOff1079:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1080
	JMP        L__TurnLoadsOffWhenGridOff861
L__TurnLoadsOffWhenGridOff1080:
L__TurnLoadsOffWhenGridOff856:
;Solar_Auto_Switcher.c,1961 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1962 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1963 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1964 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1959 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__TurnLoadsOffWhenGridOff863:
L__TurnLoadsOffWhenGridOff862:
L__TurnLoadsOffWhenGridOff861:
;Solar_Auto_Switcher.c,1967 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _TurnLoadsOffWhenGridOff

_CheckbatterySystemVoltage:

;Solar_Auto_Switcher.c,1970 :: 		void CheckbatterySystemVoltage()
;Solar_Auto_Switcher.c,1975 :: 		}
L_end_CheckbatterySystemVoltage:
	RET
; end of _CheckbatterySystemVoltage

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Auto_Switcher.c,1977 :: 		void main() {
;Solar_Auto_Switcher.c,1979 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Auto_Switcher.c,1980 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Auto_Switcher.c,1981 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1982 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Auto_Switcher.c,1983 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Auto_Switcher.c,1984 :: 		ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 48
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1985 :: 		ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 64
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1986 :: 		ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 69
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1987 :: 		ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_2+0)
	MOV        R5, R27
	LDI        R27, 71
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1988 :: 		ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage_T2+0)
	MOV        R5, R27
	LDI        R27, 81
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1989 :: 		ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage_T2+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage_T2+0)
	MOV        R5, R27
	LDI        R27, 85
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1990 :: 		while(1)
L_main624:
;Solar_Auto_Switcher.c,1992 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Auto_Switcher.c,1993 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Auto_Switcher.c,1994 :: 		CheckForSet();
	CALL       _CheckForSet+0
;Solar_Auto_Switcher.c,1995 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Auto_Switcher.c,1998 :: 		Screen_1();
	CALL       _Screen_1+0
;Solar_Auto_Switcher.c,1999 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Auto_Switcher.c,2000 :: 		TurnLoadsOffWhenGridOff();        // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Auto_Switcher.c,2002 :: 		ErrorList();
	CALL       _ErrorList+0
;Solar_Auto_Switcher.c,2003 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main626:
	DEC        R16
	BRNE       L_main626
	DEC        R17
	BRNE       L_main626
	DEC        R18
	BRNE       L_main626
	NOP
;Solar_Auto_Switcher.c,2006 :: 		} // end while
	JMP        L_main624
;Solar_Auto_Switcher.c,2007 :: 		}   // end main
L_end_main:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
