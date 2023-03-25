
_Gpio_Init:

;Solar_Auto_Switcher.c,145 :: 		void Gpio_Init()
;Solar_Auto_Switcher.c,147 :: 		DDRD.B6=1; // Relay_L_Solar set as output
	IN         R27, DDRD+0
	SBR        R27, 64
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,148 :: 		DDRD.B7=1; // Relay_L_Solar_2 set as output
	IN         R27, DDRD+0
	SBR        R27, 128
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,149 :: 		DDRD.B2=0; // Set as input
	IN         R27, DDRD+0
	CBR        R27, 4
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,150 :: 		DDRD.B1=0; // decrement set as input
	IN         R27, DDRD+0
	CBR        R27, 2
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,151 :: 		DDRD.B0=0; // increment set as input
	IN         R27, DDRD+0
	CBR        R27, 1
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,152 :: 		DDRD.B3=0; // set ac_available as input
	IN         R27, DDRD+0
	CBR        R27, 8
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,153 :: 		DDRC.B2=1; // set buzzer as output
	IN         R27, DDRC+0
	SBR        R27, 4
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,154 :: 		DDRC.B0=0;  //SET EXIT AS INPUT
	IN         R27, DDRC+0
	CBR        R27, 1
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,155 :: 		}
L_end_Gpio_Init:
	RET
; end of _Gpio_Init

_Write_Time:

;Solar_Auto_Switcher.c,158 :: 		void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
;Solar_Auto_Switcher.c,160 :: 		write_Ds1307(0x00,seconds);           //seconds
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
;Solar_Auto_Switcher.c,161 :: 		write_Ds1307(0x01,minutes);          // minutes
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,162 :: 		write_Ds1307(0x02,hours); // using the 24 hour system
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,163 :: 		}
L_end_Write_Time:
	POP        R3
	POP        R2
	RET
; end of _Write_Time

_Write_Date:

;Solar_Auto_Switcher.c,166 :: 		void Write_Date(unsigned int day, unsigned int month,unsigned int year)
;Solar_Auto_Switcher.c,168 :: 		write_Ds1307(0x04,day);          //01-31
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
;Solar_Auto_Switcher.c,169 :: 		Write_Ds1307(0x05,month);       //01-12
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,170 :: 		Write_Ds1307(0x06,year);       // 00-99
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,171 :: 		}
L_end_Write_Date:
	POP        R3
	POP        R2
	RET
; end of _Write_Date

_Config:

;Solar_Auto_Switcher.c,173 :: 		void Config()
;Solar_Auto_Switcher.c,175 :: 		GPIO_Init();
	PUSH       R2
	CALL       _Gpio_Init+0
;Solar_Auto_Switcher.c,176 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,177 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,178 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,180 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_Config0:
	DEC        R16
	BRNE       L_Config0
	DEC        R17
	BRNE       L_Config0
	DEC        R18
	BRNE       L_Config0
;Solar_Auto_Switcher.c,181 :: 		}
L_end_Config:
	POP        R2
	RET
; end of _Config

_LCD_Clear:

;Solar_Auto_Switcher.c,184 :: 		void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
;Solar_Auto_Switcher.c,187 :: 		for(Column=Start; Column<=End; Column++)
; Column start address is: 17 (R17)
	MOV        R17, R3
; Column end address is: 17 (R17)
L_LCD_Clear2:
; Column start address is: 17 (R17)
	CP         R4, R17
	BRSH       L__LCD_Clear938
	JMP        L_LCD_Clear3
L__LCD_Clear938:
;Solar_Auto_Switcher.c,189 :: 		Lcd_Chr(Row,Column,32);
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
;Solar_Auto_Switcher.c,187 :: 		for(Column=Start; Column<=End; Column++)
	MOV        R16, R17
	SUBI       R16, 255
	MOV        R17, R16
;Solar_Auto_Switcher.c,190 :: 		}
; Column end address is: 17 (R17)
	JMP        L_LCD_Clear2
L_LCD_Clear3:
;Solar_Auto_Switcher.c,191 :: 		}
L_end_LCD_Clear:
	RET
; end of _LCD_Clear

_Config_Interrupts:

;Solar_Auto_Switcher.c,194 :: 		void Config_Interrupts()
;Solar_Auto_Switcher.c,196 :: 		ISC10_bit=1;   // Config The rising edge of INT0 generates an interrupt request.
	LDS        R27, ISC10_bit+0
	SBR        R27, BitMask(ISC10_bit+0)
	STS        ISC10_bit+0, R27
;Solar_Auto_Switcher.c,197 :: 		ISC11_bit=1;
	LDS        R27, ISC11_bit+0
	SBR        R27, BitMask(ISC11_bit+0)
	STS        ISC11_bit+0, R27
;Solar_Auto_Switcher.c,198 :: 		INT1_bit=1;
	IN         R27, INT1_bit+0
	SBR        R27, BitMask(INT1_bit+0)
	OUT        INT1_bit+0, R27
;Solar_Auto_Switcher.c,199 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,200 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_Interrupt_INT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,204 :: 		void Interrupt_INT1 () iv IVT_ADDR_INT1
;Solar_Auto_Switcher.c,206 :: 		AcBuzzerActiveTimes=0; // FOR ACTIVING BUZZER ONCE AGAIN
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,208 :: 		if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1664
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1941
	JMP        L__Interrupt_INT1663
L__Interrupt_INT1941:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1942
	JMP        L__Interrupt_INT1662
L__Interrupt_INT1942:
L__Interrupt_INT1661:
;Solar_Auto_Switcher.c,212 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,213 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,214 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,208 :: 		if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0)
L__Interrupt_INT1664:
L__Interrupt_INT1663:
L__Interrupt_INT1662:
;Solar_Auto_Switcher.c,217 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1667
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1943
	JMP        L__Interrupt_INT1666
L__Interrupt_INT1943:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1944
	JMP        L__Interrupt_INT1665
L__Interrupt_INT1944:
L__Interrupt_INT1660:
;Solar_Auto_Switcher.c,221 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,222 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,223 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,217 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__Interrupt_INT1667:
L__Interrupt_INT1666:
L__Interrupt_INT1665:
;Solar_Auto_Switcher.c,226 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,227 :: 		INTF1_bit=1;     //clear  flag
	IN         R27, INTF1_bit+0
	SBR        R27, BitMask(INTF1_bit+0)
	OUT        INTF1_bit+0, R27
;Solar_Auto_Switcher.c,228 :: 		}
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

;Solar_Auto_Switcher.c,231 :: 		void EEPROM_Load()
;Solar_Auto_Switcher.c,234 :: 		hours_lcd_1=EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,235 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,236 :: 		hours_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,237 :: 		minutes_lcd_2=EEPROM_Read(0x04);
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,239 :: 		hours_lcd_timer2_start=EEPROM_Read(0x18);
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,240 :: 		minutes_lcd_timer2_start=EEPROM_Read(0x19);
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,241 :: 		hours_lcd_timer2_stop=EEPROM_Read(0x20);
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,242 :: 		minutes_lcd_timer2_stop=EEPROM_Read(0x21);
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,245 :: 		ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
	LDI        R27, 0
	STS        _ByPassState+0, R27
;Solar_Auto_Switcher.c,247 :: 		Timer_Enable=1;      // delete function to be programmed for rom space
	LDI        R27, 1
	STS        _Timer_Enable+0, R27
;Solar_Auto_Switcher.c,248 :: 		High_Voltage=EEPROM_Read(0x12); // load high voltage
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _High_Voltage+0, R16
	LDI        R27, 0
	STS        _High_Voltage+1, R27
;Solar_Auto_Switcher.c,249 :: 		Low_Voltage=EEPROM_Read(0x13); // load low voltage
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Low_Voltage+0, R16
	LDI        R27, 0
	STS        _Low_Voltage+1, R27
;Solar_Auto_Switcher.c,250 :: 		VoltageProtectionEnable=EEPROM_Read(0x15);
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _VoltageProtectionEnable+0, R16
;Solar_Auto_Switcher.c,254 :: 		}
L_end_EEPROM_Load:
	POP        R3
	POP        R2
	RET
; end of _EEPROM_Load

_StoreBytesIntoEEprom:

;Solar_Auto_Switcher.c,257 :: 		void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,260 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_StoreBytesIntoEEprom11:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__StoreBytesIntoEEprom947
	JMP        L_StoreBytesIntoEEprom12
L__StoreBytesIntoEEprom947:
;Solar_Auto_Switcher.c,262 :: 		EEprom_Write(address+j,*(ptr+j));
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
;Solar_Auto_Switcher.c,263 :: 		Delay_ms(50);
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
;Solar_Auto_Switcher.c,260 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,264 :: 		};
; j end address is: 19 (R19)
	JMP        L_StoreBytesIntoEEprom11
L_StoreBytesIntoEEprom12:
;Solar_Auto_Switcher.c,265 :: 		}
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

;Solar_Auto_Switcher.c,268 :: 		void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,271 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_ReadBytesFromEEprom16:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__ReadBytesFromEEprom949
	JMP        L_ReadBytesFromEEprom17
L__ReadBytesFromEEprom949:
;Solar_Auto_Switcher.c,273 :: 		*(ptr+j)=EEPROM_Read(address+j);
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
;Solar_Auto_Switcher.c,274 :: 		Delay_ms(50);
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
;Solar_Auto_Switcher.c,271 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,275 :: 		}
; j end address is: 19 (R19)
	JMP        L_ReadBytesFromEEprom16
L_ReadBytesFromEEprom17:
;Solar_Auto_Switcher.c,276 :: 		}
L_end_ReadBytesFromEEprom:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ReadBytesFromEEprom

_Check_Timers:

;Solar_Auto_Switcher.c,279 :: 		void Check_Timers()
;Solar_Auto_Switcher.c,282 :: 		matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDS        R4, _hours_lcd_1+0
	LDS        R3, _minutes_lcd_1+0
	LDS        R2, _seconds_lcd_1+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_1_start+0, R16
;Solar_Auto_Switcher.c,283 :: 		matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
	LDS        R4, _hours_lcd_2+0
	LDS        R3, _minutes_lcd_2+0
	LDS        R2, _seconds_lcd_2+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_1_stop+0, R16
;Solar_Auto_Switcher.c,284 :: 		matched_timer_2_start=CheckTimeOccuredOn(seconds_lcd_timer2_start,minutes_lcd_timer2_start,hours_lcd_timer2_start);
	LDS        R4, _hours_lcd_timer2_start+0
	LDS        R3, _minutes_lcd_timer2_start+0
	LDS        R2, _seconds_lcd_timer2_start+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_2_start+0, R16
;Solar_Auto_Switcher.c,285 :: 		matched_timer_2_stop=CheckTimeOccuredOff(seconds_lcd_timer2_stop,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
	LDS        R4, _hours_lcd_timer2_stop+0
	LDS        R3, _minutes_lcd_timer2_stop+0
	LDS        R2, _seconds_lcd_timer2_stop+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_2_stop+0, R16
;Solar_Auto_Switcher.c,288 :: 		if (matched_timer_1_start==1)
	LDS        R16, _matched_timer_1_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers951
	JMP        L_Check_Timers21
L__Check_Timers951:
;Solar_Auto_Switcher.c,290 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,291 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,295 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers693
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers952
	JMP        L__Check_Timers692
L__Check_Timers952:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers953
	LDI        R16, 1
L__Check_Timers953:
	TST        R16
	BRNE       L__Check_Timers954
	JMP        L__Check_Timers691
L__Check_Timers954:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers955
	JMP        L__Check_Timers690
L__Check_Timers955:
L__Check_Timers689:
;Solar_Auto_Switcher.c,297 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,295 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false )
L__Check_Timers693:
L__Check_Timers692:
L__Check_Timers691:
L__Check_Timers690:
;Solar_Auto_Switcher.c,301 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers696
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers956
	JMP        L__Check_Timers695
L__Check_Timers956:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers957
	JMP        L__Check_Timers694
L__Check_Timers957:
L__Check_Timers688:
;Solar_Auto_Switcher.c,303 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,301 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers696:
L__Check_Timers695:
L__Check_Timers694:
;Solar_Auto_Switcher.c,305 :: 		} // end if ac_available
L_Check_Timers21:
;Solar_Auto_Switcher.c,308 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers958
	JMP        L_Check_Timers28
L__Check_Timers958:
;Solar_Auto_Switcher.c,310 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,313 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers699
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers959
	JMP        L__Check_Timers698
L__Check_Timers959:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers960
	JMP        L__Check_Timers697
L__Check_Timers960:
L__Check_Timers687:
;Solar_Auto_Switcher.c,316 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,317 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,313 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
L__Check_Timers699:
L__Check_Timers698:
L__Check_Timers697:
;Solar_Auto_Switcher.c,320 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers702
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers961
	JMP        L__Check_Timers701
L__Check_Timers961:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers962
	JMP        L__Check_Timers700
L__Check_Timers962:
L__Check_Timers686:
;Solar_Auto_Switcher.c,323 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,324 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,320 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
L__Check_Timers702:
L__Check_Timers701:
L__Check_Timers700:
;Solar_Auto_Switcher.c,326 :: 		}
L_Check_Timers28:
;Solar_Auto_Switcher.c,330 :: 		if (matched_timer_2_start==1)
	LDS        R16, _matched_timer_2_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers963
	JMP        L_Check_Timers35
L__Check_Timers963:
;Solar_Auto_Switcher.c,332 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,333 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,336 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers706
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers964
	JMP        L__Check_Timers705
L__Check_Timers964:
	LDS        R20, _StartLoadsVoltage_T2+0
	LDS        R21, _StartLoadsVoltage_T2+1
	LDS        R22, _StartLoadsVoltage_T2+2
	LDS        R23, _StartLoadsVoltage_T2+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers965
	LDI        R16, 1
L__Check_Timers965:
	TST        R16
	BRNE       L__Check_Timers966
	JMP        L__Check_Timers704
L__Check_Timers966:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers967
	JMP        L__Check_Timers703
L__Check_Timers967:
L__Check_Timers685:
;Solar_Auto_Switcher.c,338 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,336 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false)
L__Check_Timers706:
L__Check_Timers705:
L__Check_Timers704:
L__Check_Timers703:
;Solar_Auto_Switcher.c,342 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers709
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers968
	JMP        L__Check_Timers708
L__Check_Timers968:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers969
	JMP        L__Check_Timers707
L__Check_Timers969:
L__Check_Timers684:
;Solar_Auto_Switcher.c,344 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,342 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
L__Check_Timers709:
L__Check_Timers708:
L__Check_Timers707:
;Solar_Auto_Switcher.c,347 :: 		} // end if ac_available
L_Check_Timers35:
;Solar_Auto_Switcher.c,350 :: 		if (matched_timer_2_stop==1)
	LDS        R16, _matched_timer_2_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers970
	JMP        L_Check_Timers42
L__Check_Timers970:
;Solar_Auto_Switcher.c,352 :: 		Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,355 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers712
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers971
	JMP        L__Check_Timers711
L__Check_Timers971:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers972
	JMP        L__Check_Timers710
L__Check_Timers972:
L__Check_Timers683:
;Solar_Auto_Switcher.c,359 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,360 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,355 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
L__Check_Timers712:
L__Check_Timers711:
L__Check_Timers710:
;Solar_Auto_Switcher.c,364 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers715
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers973
	JMP        L__Check_Timers714
L__Check_Timers973:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers974
	JMP        L__Check_Timers713
L__Check_Timers974:
L__Check_Timers682:
;Solar_Auto_Switcher.c,366 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,367 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,364 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers715:
L__Check_Timers714:
L__Check_Timers713:
;Solar_Auto_Switcher.c,370 :: 		} // end match timer stop
L_Check_Timers42:
;Solar_Auto_Switcher.c,375 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers723
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers975
	JMP        L__Check_Timers722
L__Check_Timers975:
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 1
	BREQ       L__Check_Timers976
	JMP        L__Check_Timers721
L__Check_Timers976:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers977
	JMP        L__Check_Timers720
L__Check_Timers977:
L__Check_Timers681:
;Solar_Auto_Switcher.c,378 :: 		Delay_ms(300);       // for error to get one seconds approxmiallty
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_Check_Timers52:
	DEC        R16
	BRNE       L_Check_Timers52
	DEC        R17
	BRNE       L_Check_Timers52
	DEC        R18
	BRNE       L_Check_Timers52
	NOP
	NOP
;Solar_Auto_Switcher.c,379 :: 		SecondsRealTime++;
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _SecondsRealTime+0, R18
	STS        _SecondsRealTime+1, R19
;Solar_Auto_Switcher.c,381 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers978
	JMP        L__Check_Timers717
L__Check_Timers978:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers716
L__Check_Timers680:
;Solar_Auto_Switcher.c,384 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,381 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers717:
L__Check_Timers716:
;Solar_Auto_Switcher.c,387 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers979
	JMP        L__Check_Timers719
L__Check_Timers979:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers718
L__Check_Timers679:
;Solar_Auto_Switcher.c,389 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,387 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers719:
L__Check_Timers718:
;Solar_Auto_Switcher.c,392 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,375 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
L__Check_Timers723:
L__Check_Timers722:
L__Check_Timers721:
L__Check_Timers720:
;Solar_Auto_Switcher.c,398 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers726
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Check_Timers980
	JMP        L__Check_Timers725
L__Check_Timers980:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers981
	JMP        L__Check_Timers724
L__Check_Timers981:
L__Check_Timers678:
;Solar_Auto_Switcher.c,400 :: 		Start_Timer_0_A();         // give some time ac grid to stabilize
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,398 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
L__Check_Timers726:
L__Check_Timers725:
L__Check_Timers724:
;Solar_Auto_Switcher.c,403 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers729
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers982
	JMP        L__Check_Timers728
L__Check_Timers982:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers983
	JMP        L__Check_Timers727
L__Check_Timers983:
L__Check_Timers677:
;Solar_Auto_Switcher.c,405 :: 		LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,403 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
L__Check_Timers729:
L__Check_Timers728:
L__Check_Timers727:
;Solar_Auto_Switcher.c,409 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers735
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__Check_Timers984
	JMP        L__Check_Timers734
L__Check_Timers984:
L__Check_Timers676:
;Solar_Auto_Switcher.c,411 :: 		Delay_ms(300);       // for error to get one seconds approxmiallty
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_Check_Timers69:
	DEC        R16
	BRNE       L_Check_Timers69
	DEC        R17
	BRNE       L_Check_Timers69
	DEC        R18
	BRNE       L_Check_Timers69
	NOP
	NOP
;Solar_Auto_Switcher.c,412 :: 		SecondsRealTime++;
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _SecondsRealTime+0, R18
	STS        _SecondsRealTime+1, R19
;Solar_Auto_Switcher.c,414 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers985
	JMP        L__Check_Timers731
L__Check_Timers985:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers730
L__Check_Timers675:
;Solar_Auto_Switcher.c,417 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,414 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers731:
L__Check_Timers730:
;Solar_Auto_Switcher.c,420 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers986
	JMP        L__Check_Timers733
L__Check_Timers986:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers732
L__Check_Timers674:
;Solar_Auto_Switcher.c,423 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,420 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers733:
L__Check_Timers732:
;Solar_Auto_Switcher.c,425 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,409 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
L__Check_Timers735:
L__Check_Timers734:
;Solar_Auto_Switcher.c,446 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers740
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers987
	JMP        L__Check_Timers739
L__Check_Timers987:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers988
	LDI        R16, 1
L__Check_Timers988:
	TST        R16
	BRNE       L__Check_Timers989
	JMP        L__Check_Timers738
L__Check_Timers989:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers990
	JMP        L__Check_Timers737
L__Check_Timers990:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers991
	JMP        L__Check_Timers736
L__Check_Timers991:
L__Check_Timers673:
;Solar_Auto_Switcher.c,449 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,450 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers80:
	DEC        R16
	BRNE       L_Check_Timers80
	DEC        R17
	BRNE       L_Check_Timers80
	DEC        R18
	BRNE       L_Check_Timers80
	NOP
;Solar_Auto_Switcher.c,451 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers992
	JMP        L_Check_Timers82
L__Check_Timers992:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers82:
;Solar_Auto_Switcher.c,446 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
L__Check_Timers740:
L__Check_Timers739:
L__Check_Timers738:
L__Check_Timers737:
L__Check_Timers736:
;Solar_Auto_Switcher.c,454 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers744
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers993
	JMP        L__Check_Timers743
L__Check_Timers993:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers994
	JMP        L__Check_Timers742
L__Check_Timers994:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers995
	JMP        L__Check_Timers741
L__Check_Timers995:
L__Check_Timers672:
;Solar_Auto_Switcher.c,456 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,457 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers86:
	DEC        R16
	BRNE       L_Check_Timers86
	DEC        R17
	BRNE       L_Check_Timers86
	DEC        R18
	BRNE       L_Check_Timers86
	NOP
;Solar_Auto_Switcher.c,459 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers996
	JMP        L_Check_Timers88
L__Check_Timers996:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers88:
;Solar_Auto_Switcher.c,454 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
L__Check_Timers744:
L__Check_Timers743:
L__Check_Timers742:
L__Check_Timers741:
;Solar_Auto_Switcher.c,463 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers749
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers997
	JMP        L__Check_Timers748
L__Check_Timers997:
	LDS        R20, _StartLoadsVoltage_T2+0
	LDS        R21, _StartLoadsVoltage_T2+1
	LDS        R22, _StartLoadsVoltage_T2+2
	LDS        R23, _StartLoadsVoltage_T2+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers998
	LDI        R16, 1
L__Check_Timers998:
	TST        R16
	BRNE       L__Check_Timers999
	JMP        L__Check_Timers747
L__Check_Timers999:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers1000
	JMP        L__Check_Timers746
L__Check_Timers1000:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers1001
	JMP        L__Check_Timers745
L__Check_Timers1001:
L__Check_Timers671:
;Solar_Auto_Switcher.c,465 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,466 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Check_Timers92:
	DEC        R16
	BRNE       L_Check_Timers92
	DEC        R17
	BRNE       L_Check_Timers92
	DEC        R18
	BRNE       L_Check_Timers92
;Solar_Auto_Switcher.c,467 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers1002
	JMP        L_Check_Timers94
L__Check_Timers1002:
;Solar_Auto_Switcher.c,468 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers94:
;Solar_Auto_Switcher.c,463 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
L__Check_Timers749:
L__Check_Timers748:
L__Check_Timers747:
L__Check_Timers746:
L__Check_Timers745:
;Solar_Auto_Switcher.c,471 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers753
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers1003
	JMP        L__Check_Timers752
L__Check_Timers1003:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers1004
	JMP        L__Check_Timers751
L__Check_Timers1004:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers1005
	JMP        L__Check_Timers750
L__Check_Timers1005:
L__Check_Timers670:
;Solar_Auto_Switcher.c,473 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,474 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Check_Timers98:
	DEC        R16
	BRNE       L_Check_Timers98
	DEC        R17
	BRNE       L_Check_Timers98
	DEC        R18
	BRNE       L_Check_Timers98
;Solar_Auto_Switcher.c,475 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers1006
	JMP        L_Check_Timers100
L__Check_Timers1006:
;Solar_Auto_Switcher.c,476 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers100:
;Solar_Auto_Switcher.c,471 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
L__Check_Timers753:
L__Check_Timers752:
L__Check_Timers751:
L__Check_Timers750:
;Solar_Auto_Switcher.c,480 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers1007
	LDI        R16, 1
L__Check_Timers1007:
	TST        R16
	BRNE       L__Check_Timers1008
	JMP        L__Check_Timers756
L__Check_Timers1008:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers755
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers1009
	JMP        L__Check_Timers754
L__Check_Timers1009:
L__Check_Timers669:
;Solar_Auto_Switcher.c,482 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,483 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,480 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false)
L__Check_Timers756:
L__Check_Timers755:
L__Check_Timers754:
;Solar_Auto_Switcher.c,487 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1  && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers1010
	LDI        R16, 1
L__Check_Timers1010:
	TST        R16
	BRNE       L__Check_Timers1011
	JMP        L__Check_Timers759
L__Check_Timers1011:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers758
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers1012
	JMP        L__Check_Timers757
L__Check_Timers1012:
L__Check_Timers668:
;Solar_Auto_Switcher.c,489 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,490 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,487 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1  && RunWithOutBattery==false)
L__Check_Timers759:
L__Check_Timers758:
L__Check_Timers757:
;Solar_Auto_Switcher.c,493 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_GetVoltageNow:

;Solar_Auto_Switcher.c,496 :: 		void GetVoltageNow()
;Solar_Auto_Switcher.c,498 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,499 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,500 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,501 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,502 :: 		}
L_end_GetVoltageNow:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _GetVoltageNow

_ToggleBuzzer:

;Solar_Auto_Switcher.c,504 :: 		void ToggleBuzzer()
;Solar_Auto_Switcher.c,506 :: 		if (AcBuzzerActiveTimes==0)
	LDS        R16, _AcBuzzerActiveTimes+0
	CPI        R16, 0
	BREQ       L__ToggleBuzzer1015
	JMP        L_ToggleBuzzer107
L__ToggleBuzzer1015:
;Solar_Auto_Switcher.c,508 :: 		AcBuzzerActiveTimes =1 ;
	LDI        R27, 1
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,509 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,510 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_ToggleBuzzer108:
	DEC        R16
	BRNE       L_ToggleBuzzer108
	DEC        R17
	BRNE       L_ToggleBuzzer108
	DEC        R18
	BRNE       L_ToggleBuzzer108
;Solar_Auto_Switcher.c,511 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,512 :: 		}
L_ToggleBuzzer107:
;Solar_Auto_Switcher.c,513 :: 		}
L_end_ToggleBuzzer:
	RET
; end of _ToggleBuzzer

_SetUpProgram:

;Solar_Auto_Switcher.c,527 :: 		void SetUpProgram()
;Solar_Auto_Switcher.c,529 :: 		Delay_ms(100);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetUpProgram110:
	DEC        R16
	BRNE       L_SetUpProgram110
	DEC        R17
	BRNE       L_SetUpProgram110
	DEC        R18
	BRNE       L_SetUpProgram110
;Solar_Auto_Switcher.c,530 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_SetUpProgram112
;Solar_Auto_Switcher.c,532 :: 		SREG_I_bit=0;     // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,533 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,534 :: 		LCD_OUT(1,1,"Setup Program");
	LDI        R27, #lo_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,535 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram113:
	DEC        R16
	BRNE       L_SetUpProgram113
	DEC        R17
	BRNE       L_SetUpProgram113
	DEC        R18
	BRNE       L_SetUpProgram113
	NOP
;Solar_Auto_Switcher.c,538 :: 		while (Set==1 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetUpProgram116
;Solar_Auto_Switcher.c,541 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Auto_Switcher.c,542 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram117
	JMP        L_SetUpProgram116
L_SetUpProgram117:
;Solar_Auto_Switcher.c,543 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Auto_Switcher.c,544 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram118
	JMP        L_SetUpProgram116
L_SetUpProgram118:
;Solar_Auto_Switcher.c,545 :: 		SetTimerOn_2();
	CALL       _SetTimerOn_2+0
;Solar_Auto_Switcher.c,546 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram119
	JMP        L_SetUpProgram116
L_SetUpProgram119:
;Solar_Auto_Switcher.c,547 :: 		SetTimerOff_2();
	CALL       _SetTimerOff_2+0
;Solar_Auto_Switcher.c,548 :: 		if (Exit==1) break ;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram120
	JMP        L_SetUpProgram116
L_SetUpProgram120:
;Solar_Auto_Switcher.c,549 :: 		SetLowBatteryVoltage();// program 5 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Auto_Switcher.c,550 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram121
	JMP        L_SetUpProgram116
L_SetUpProgram121:
;Solar_Auto_Switcher.c,551 :: 		SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Auto_Switcher.c,552 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram122
	JMP        L_SetUpProgram116
L_SetUpProgram122:
;Solar_Auto_Switcher.c,554 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram123
	JMP        L_SetUpProgram116
L_SetUpProgram123:
;Solar_Auto_Switcher.c,556 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram124
	JMP        L_SetUpProgram116
L_SetUpProgram124:
;Solar_Auto_Switcher.c,557 :: 		SetDS1307_Time();    // program 10
	CALL       _SetDS1307_Time+0
;Solar_Auto_Switcher.c,558 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram125
	JMP        L_SetUpProgram116
L_SetUpProgram125:
;Solar_Auto_Switcher.c,563 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Auto_Switcher.c,564 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram126
	JMP        L_SetUpProgram116
L_SetUpProgram126:
;Solar_Auto_Switcher.c,565 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,568 :: 		} // end while
L_SetUpProgram116:
;Solar_Auto_Switcher.c,569 :: 		SREG_I_bit=1;      //reactivate the lcd _inut timer
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,570 :: 		}    // end main if
L_SetUpProgram112:
;Solar_Auto_Switcher.c,571 :: 		}
L_end_SetUpProgram:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Auto_Switcher.c,574 :: 		void SetTimerOn_1()
;Solar_Auto_Switcher.c,576 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,577 :: 		LCD_OUT(1,1,"T1 On: [1]");
	LDI        R27, #lo_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,578 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1127:
	DEC        R16
	BRNE       L_SetTimerOn_1127
	DEC        R17
	BRNE       L_SetTimerOn_1127
	DEC        R18
	BRNE       L_SetTimerOn_1127
;Solar_Auto_Switcher.c,579 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,580 :: 		while (Set==1)
L_SetTimerOn_1129:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1130
;Solar_Auto_Switcher.c,586 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,587 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,588 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,589 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,591 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1131
;Solar_Auto_Switcher.c,594 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1130
;Solar_Auto_Switcher.c,595 :: 		}
L_SetTimerOn_1131:
;Solar_Auto_Switcher.c,598 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1132:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1764
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1763
	JMP        L_SetTimerOn_1133
L__SetTimerOn_1764:
L__SetTimerOn_1763:
;Solar_Auto_Switcher.c,600 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1136
;Solar_Auto_Switcher.c,602 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1137:
	DEC        R16
	BRNE       L_SetTimerOn_1137
	DEC        R17
	BRNE       L_SetTimerOn_1137
	DEC        R18
	BRNE       L_SetTimerOn_1137
;Solar_Auto_Switcher.c,603 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,604 :: 		}
L_SetTimerOn_1136:
;Solar_Auto_Switcher.c,605 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1139
;Solar_Auto_Switcher.c,607 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1140:
	DEC        R16
	BRNE       L_SetTimerOn_1140
	DEC        R17
	BRNE       L_SetTimerOn_1140
	DEC        R18
	BRNE       L_SetTimerOn_1140
;Solar_Auto_Switcher.c,608 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,609 :: 		}
L_SetTimerOn_1139:
;Solar_Auto_Switcher.c,611 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_11018
	JMP        L_SetTimerOn_1142
L__SetTimerOn_11018:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1142:
;Solar_Auto_Switcher.c,612 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11019
	JMP        L_SetTimerOn_1143
L__SetTimerOn_11019:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1143:
;Solar_Auto_Switcher.c,613 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,614 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,615 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_1132
L_SetTimerOn_1133:
;Solar_Auto_Switcher.c,616 :: 		} // end first while
	JMP        L_SetTimerOn_1129
L_SetTimerOn_1130:
;Solar_Auto_Switcher.c,618 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_1144:
	DEC        R16
	BRNE       L_SetTimerOn_1144
	DEC        R17
	BRNE       L_SetTimerOn_1144
	DEC        R18
	BRNE       L_SetTimerOn_1144
	NOP
;Solar_Auto_Switcher.c,619 :: 		while (Set==1)
L_SetTimerOn_1146:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1147
;Solar_Auto_Switcher.c,621 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,623 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,627 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1148
;Solar_Auto_Switcher.c,630 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1147
;Solar_Auto_Switcher.c,631 :: 		}
L_SetTimerOn_1148:
;Solar_Auto_Switcher.c,633 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1149:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1766
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1765
	JMP        L_SetTimerOn_1150
L__SetTimerOn_1766:
L__SetTimerOn_1765:
;Solar_Auto_Switcher.c,635 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1153
;Solar_Auto_Switcher.c,637 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1154:
	DEC        R16
	BRNE       L_SetTimerOn_1154
	DEC        R17
	BRNE       L_SetTimerOn_1154
	DEC        R18
	BRNE       L_SetTimerOn_1154
;Solar_Auto_Switcher.c,638 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,639 :: 		}
L_SetTimerOn_1153:
;Solar_Auto_Switcher.c,640 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1156
;Solar_Auto_Switcher.c,642 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1157:
	DEC        R16
	BRNE       L_SetTimerOn_1157
	DEC        R17
	BRNE       L_SetTimerOn_1157
	DEC        R18
	BRNE       L_SetTimerOn_1157
;Solar_Auto_Switcher.c,643 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,644 :: 		}
L_SetTimerOn_1156:
;Solar_Auto_Switcher.c,646 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_11020
	JMP        L_SetTimerOn_1159
L__SetTimerOn_11020:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1159:
;Solar_Auto_Switcher.c,647 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11021
	JMP        L_SetTimerOn_1160
L__SetTimerOn_11021:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1160:
;Solar_Auto_Switcher.c,648 :: 		Timer_isOn=0; //
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,649 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,650 :: 		} // end while increment
	JMP        L_SetTimerOn_1149
L_SetTimerOn_1150:
;Solar_Auto_Switcher.c,651 :: 		} // end first while
	JMP        L_SetTimerOn_1146
L_SetTimerOn_1147:
;Solar_Auto_Switcher.c,653 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,654 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,656 :: 		}
L_end_SetTimerOn_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Auto_Switcher.c,658 :: 		void SetTimerOff_1()
;Solar_Auto_Switcher.c,660 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,661 :: 		LCD_OUT(1,1,"T1 Off: [2]");
	LDI        R27, #lo_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,662 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,663 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1161:
	DEC        R16
	BRNE       L_SetTimerOff_1161
	DEC        R17
	BRNE       L_SetTimerOff_1161
	DEC        R18
	BRNE       L_SetTimerOff_1161
	NOP
;Solar_Auto_Switcher.c,664 :: 		while (Set==1)
L_SetTimerOff_1163:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1164
;Solar_Auto_Switcher.c,670 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,671 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,672 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,673 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,674 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1165
;Solar_Auto_Switcher.c,677 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1164
;Solar_Auto_Switcher.c,678 :: 		}
L_SetTimerOff_1165:
;Solar_Auto_Switcher.c,680 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1166:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1770
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1769
	JMP        L_SetTimerOff_1167
L__SetTimerOff_1770:
L__SetTimerOff_1769:
;Solar_Auto_Switcher.c,683 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1170
;Solar_Auto_Switcher.c,685 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1171:
	DEC        R16
	BRNE       L_SetTimerOff_1171
	DEC        R17
	BRNE       L_SetTimerOff_1171
	DEC        R18
	BRNE       L_SetTimerOff_1171
;Solar_Auto_Switcher.c,686 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,687 :: 		}
L_SetTimerOff_1170:
;Solar_Auto_Switcher.c,688 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1173
;Solar_Auto_Switcher.c,690 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1174:
	DEC        R16
	BRNE       L_SetTimerOff_1174
	DEC        R17
	BRNE       L_SetTimerOff_1174
	DEC        R18
	BRNE       L_SetTimerOff_1174
;Solar_Auto_Switcher.c,691 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,692 :: 		}
L_SetTimerOff_1173:
;Solar_Auto_Switcher.c,694 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_11023
	JMP        L_SetTimerOff_1176
L__SetTimerOff_11023:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1176:
;Solar_Auto_Switcher.c,695 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11024
	JMP        L_SetTimerOff_1177
L__SetTimerOff_11024:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1177:
;Solar_Auto_Switcher.c,696 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,697 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,698 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1166
L_SetTimerOff_1167:
;Solar_Auto_Switcher.c,699 :: 		} // end first while
	JMP        L_SetTimerOff_1163
L_SetTimerOff_1164:
;Solar_Auto_Switcher.c,701 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1178:
	DEC        R16
	BRNE       L_SetTimerOff_1178
	DEC        R17
	BRNE       L_SetTimerOff_1178
	DEC        R18
	BRNE       L_SetTimerOff_1178
	NOP
;Solar_Auto_Switcher.c,702 :: 		while (Set==1)
L_SetTimerOff_1180:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1181
;Solar_Auto_Switcher.c,704 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,706 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,710 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1182
;Solar_Auto_Switcher.c,713 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1181
;Solar_Auto_Switcher.c,714 :: 		}
L_SetTimerOff_1182:
;Solar_Auto_Switcher.c,716 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1183:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1772
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1771
	JMP        L_SetTimerOff_1184
L__SetTimerOff_1772:
L__SetTimerOff_1771:
;Solar_Auto_Switcher.c,718 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1187
;Solar_Auto_Switcher.c,720 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1188:
	DEC        R16
	BRNE       L_SetTimerOff_1188
	DEC        R17
	BRNE       L_SetTimerOff_1188
	DEC        R18
	BRNE       L_SetTimerOff_1188
;Solar_Auto_Switcher.c,721 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,722 :: 		}
L_SetTimerOff_1187:
;Solar_Auto_Switcher.c,723 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1190
;Solar_Auto_Switcher.c,725 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1191:
	DEC        R16
	BRNE       L_SetTimerOff_1191
	DEC        R17
	BRNE       L_SetTimerOff_1191
	DEC        R18
	BRNE       L_SetTimerOff_1191
;Solar_Auto_Switcher.c,726 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,727 :: 		}
L_SetTimerOff_1190:
;Solar_Auto_Switcher.c,728 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_11025
	JMP        L_SetTimerOff_1193
L__SetTimerOff_11025:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1193:
;Solar_Auto_Switcher.c,729 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11026
	JMP        L_SetTimerOff_1194
L__SetTimerOff_11026:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1194:
;Solar_Auto_Switcher.c,730 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,731 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,732 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1183
L_SetTimerOff_1184:
;Solar_Auto_Switcher.c,733 :: 		} // end first while
	JMP        L_SetTimerOff_1180
L_SetTimerOff_1181:
;Solar_Auto_Switcher.c,734 :: 		EEPROM_Write(0x03,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,735 :: 		EEPROM_Write(0x04,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,737 :: 		}
L_end_SetTimerOff_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetTimerOn_2:

;Solar_Auto_Switcher.c,740 :: 		void SetTimerOn_2()
;Solar_Auto_Switcher.c,742 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,743 :: 		LCD_OUT(1,1,"T2 On: [3]");
	LDI        R27, #lo_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,744 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2195:
	DEC        R16
	BRNE       L_SetTimerOn_2195
	DEC        R17
	BRNE       L_SetTimerOn_2195
	DEC        R18
	BRNE       L_SetTimerOn_2195
;Solar_Auto_Switcher.c,745 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,746 :: 		while (Set==1)
L_SetTimerOn_2197:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2198
;Solar_Auto_Switcher.c,752 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,753 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,754 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,755 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,757 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2199
;Solar_Auto_Switcher.c,760 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2198
;Solar_Auto_Switcher.c,761 :: 		}
L_SetTimerOn_2199:
;Solar_Auto_Switcher.c,764 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2200:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2776
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2775
	JMP        L_SetTimerOn_2201
L__SetTimerOn_2776:
L__SetTimerOn_2775:
;Solar_Auto_Switcher.c,766 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2204
;Solar_Auto_Switcher.c,768 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2205:
	DEC        R16
	BRNE       L_SetTimerOn_2205
	DEC        R17
	BRNE       L_SetTimerOn_2205
	DEC        R18
	BRNE       L_SetTimerOn_2205
;Solar_Auto_Switcher.c,769 :: 		minutes_lcd_timer2_start++;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,770 :: 		}
L_SetTimerOn_2204:
;Solar_Auto_Switcher.c,771 :: 		if (Decrement==1 )
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2207
;Solar_Auto_Switcher.c,773 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2208:
	DEC        R16
	BRNE       L_SetTimerOn_2208
	DEC        R17
	BRNE       L_SetTimerOn_2208
	DEC        R18
	BRNE       L_SetTimerOn_2208
;Solar_Auto_Switcher.c,774 :: 		minutes_lcd_timer2_start--;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,775 :: 		}
L_SetTimerOn_2207:
;Solar_Auto_Switcher.c,777 :: 		if (minutes_lcd_timer2_start>59)    minutes_lcd_timer2_start=0;
	LDS        R17, _minutes_lcd_timer2_start+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_21028
	JMP        L_SetTimerOn_2210
L__SetTimerOn_21028:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2210:
;Solar_Auto_Switcher.c,778 :: 		if (minutes_lcd_timer2_start<0)  minutes_lcd_timer2_start=0;
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21029
	JMP        L_SetTimerOn_2211
L__SetTimerOn_21029:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2211:
;Solar_Auto_Switcher.c,779 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,780 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,782 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_2200
L_SetTimerOn_2201:
;Solar_Auto_Switcher.c,783 :: 		} // end first while
	JMP        L_SetTimerOn_2197
L_SetTimerOn_2198:
;Solar_Auto_Switcher.c,785 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_2212:
	DEC        R16
	BRNE       L_SetTimerOn_2212
	DEC        R17
	BRNE       L_SetTimerOn_2212
	DEC        R18
	BRNE       L_SetTimerOn_2212
	NOP
;Solar_Auto_Switcher.c,786 :: 		while (Set==1)
L_SetTimerOn_2214:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2215
;Solar_Auto_Switcher.c,788 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,790 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,795 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2216
;Solar_Auto_Switcher.c,797 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2215
;Solar_Auto_Switcher.c,798 :: 		}
L_SetTimerOn_2216:
;Solar_Auto_Switcher.c,800 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2217:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2778
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2777
	JMP        L_SetTimerOn_2218
L__SetTimerOn_2778:
L__SetTimerOn_2777:
;Solar_Auto_Switcher.c,802 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2221
;Solar_Auto_Switcher.c,804 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2222:
	DEC        R16
	BRNE       L_SetTimerOn_2222
	DEC        R17
	BRNE       L_SetTimerOn_2222
	DEC        R18
	BRNE       L_SetTimerOn_2222
;Solar_Auto_Switcher.c,805 :: 		hours_lcd_timer2_start++;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,806 :: 		}
L_SetTimerOn_2221:
;Solar_Auto_Switcher.c,807 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2224
;Solar_Auto_Switcher.c,809 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2225:
	DEC        R16
	BRNE       L_SetTimerOn_2225
	DEC        R17
	BRNE       L_SetTimerOn_2225
	DEC        R18
	BRNE       L_SetTimerOn_2225
;Solar_Auto_Switcher.c,810 :: 		hours_lcd_timer2_start--;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,811 :: 		}
L_SetTimerOn_2224:
;Solar_Auto_Switcher.c,813 :: 		if  (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
	LDS        R17, _hours_lcd_timer2_start+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_21030
	JMP        L_SetTimerOn_2227
L__SetTimerOn_21030:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2227:
;Solar_Auto_Switcher.c,814 :: 		if  (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21031
	JMP        L_SetTimerOn_2228
L__SetTimerOn_21031:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2228:
;Solar_Auto_Switcher.c,815 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,816 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,818 :: 		} // end while increment
	JMP        L_SetTimerOn_2217
L_SetTimerOn_2218:
;Solar_Auto_Switcher.c,819 :: 		} // end first while
	JMP        L_SetTimerOn_2214
L_SetTimerOn_2215:
;Solar_Auto_Switcher.c,821 :: 		EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_start+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,822 :: 		EEPROM_Write(0x19,minutes_lcd_timer2_start); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_start+0
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,824 :: 		}
L_end_SetTimerOn_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_2

_SetTimerOff_2:

;Solar_Auto_Switcher.c,826 :: 		void SetTimerOff_2()
;Solar_Auto_Switcher.c,828 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,829 :: 		LCD_OUT(1,1,"T2 Off: [4]");
	LDI        R27, #lo_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,830 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,831 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2229:
	DEC        R16
	BRNE       L_SetTimerOff_2229
	DEC        R17
	BRNE       L_SetTimerOff_2229
	DEC        R18
	BRNE       L_SetTimerOff_2229
	NOP
;Solar_Auto_Switcher.c,832 :: 		while (Set==1)
L_SetTimerOff_2231:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2232
;Solar_Auto_Switcher.c,838 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,839 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,840 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,841 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,842 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2233
	JMP        L_SetTimerOff_2232
L_SetTimerOff_2233:
;Solar_Auto_Switcher.c,844 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2234:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2782
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2781
	JMP        L_SetTimerOff_2235
L__SetTimerOff_2782:
L__SetTimerOff_2781:
;Solar_Auto_Switcher.c,846 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2238
;Solar_Auto_Switcher.c,848 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_2239:
	DEC        R16
	BRNE       L_SetTimerOff_2239
	DEC        R17
	BRNE       L_SetTimerOff_2239
	DEC        R18
	BRNE       L_SetTimerOff_2239
;Solar_Auto_Switcher.c,849 :: 		minutes_lcd_timer2_stop++;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,850 :: 		}
L_SetTimerOff_2238:
;Solar_Auto_Switcher.c,851 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2241
;Solar_Auto_Switcher.c,853 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_2242:
	DEC        R16
	BRNE       L_SetTimerOff_2242
	DEC        R17
	BRNE       L_SetTimerOff_2242
	DEC        R18
	BRNE       L_SetTimerOff_2242
;Solar_Auto_Switcher.c,854 :: 		minutes_lcd_timer2_stop--;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,855 :: 		}
L_SetTimerOff_2241:
;Solar_Auto_Switcher.c,857 :: 		if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
	LDS        R17, _minutes_lcd_timer2_stop+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_21033
	JMP        L_SetTimerOff_2244
L__SetTimerOff_21033:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2244:
;Solar_Auto_Switcher.c,858 :: 		if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21034
	JMP        L_SetTimerOff_2245
L__SetTimerOff_21034:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2245:
;Solar_Auto_Switcher.c,859 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,860 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,862 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2234
L_SetTimerOff_2235:
;Solar_Auto_Switcher.c,863 :: 		} // end first while
	JMP        L_SetTimerOff_2231
L_SetTimerOff_2232:
;Solar_Auto_Switcher.c,865 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2246:
	DEC        R16
	BRNE       L_SetTimerOff_2246
	DEC        R17
	BRNE       L_SetTimerOff_2246
	DEC        R18
	BRNE       L_SetTimerOff_2246
	NOP
;Solar_Auto_Switcher.c,866 :: 		while (Set==1)
L_SetTimerOff_2248:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2249
;Solar_Auto_Switcher.c,868 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,870 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,875 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2250
;Solar_Auto_Switcher.c,878 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_2249
;Solar_Auto_Switcher.c,879 :: 		}
L_SetTimerOff_2250:
;Solar_Auto_Switcher.c,881 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_2251:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2784
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2783
	JMP        L_SetTimerOff_2252
L__SetTimerOff_2784:
L__SetTimerOff_2783:
;Solar_Auto_Switcher.c,883 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2255
;Solar_Auto_Switcher.c,885 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_2256:
	DEC        R16
	BRNE       L_SetTimerOff_2256
	DEC        R17
	BRNE       L_SetTimerOff_2256
	DEC        R18
	BRNE       L_SetTimerOff_2256
;Solar_Auto_Switcher.c,886 :: 		hours_lcd_timer2_stop++;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,887 :: 		}
L_SetTimerOff_2255:
;Solar_Auto_Switcher.c,888 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2258
;Solar_Auto_Switcher.c,890 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_2259:
	DEC        R16
	BRNE       L_SetTimerOff_2259
	DEC        R17
	BRNE       L_SetTimerOff_2259
	DEC        R18
	BRNE       L_SetTimerOff_2259
;Solar_Auto_Switcher.c,891 :: 		hours_lcd_timer2_stop--;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,892 :: 		}
L_SetTimerOff_2258:
;Solar_Auto_Switcher.c,893 :: 		if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
	LDS        R17, _hours_lcd_timer2_stop+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_21035
	JMP        L_SetTimerOff_2261
L__SetTimerOff_21035:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2261:
;Solar_Auto_Switcher.c,894 :: 		if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21036
	JMP        L_SetTimerOff_2262
L__SetTimerOff_21036:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2262:
;Solar_Auto_Switcher.c,895 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,896 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,898 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2251
L_SetTimerOff_2252:
;Solar_Auto_Switcher.c,899 :: 		} // end first while
	JMP        L_SetTimerOff_2248
L_SetTimerOff_2249:
;Solar_Auto_Switcher.c,900 :: 		EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_timer2_stop+0
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,901 :: 		EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_timer2_stop+0
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,903 :: 		}
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

;Solar_Auto_Switcher.c,907 :: 		void SetDS1307_Time()
;Solar_Auto_Switcher.c,909 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,910 :: 		LCD_OUT(1,1,"Set Time [9]");
	LDI        R27, #lo_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,911 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time263:
	DEC        R16
	BRNE       L_SetDS1307_Time263
	DEC        R17
	BRNE       L_SetDS1307_Time263
	DEC        R18
	BRNE       L_SetDS1307_Time263
	NOP
;Solar_Auto_Switcher.c,912 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,913 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,915 :: 		while (Set==1)
L_SetDS1307_Time265:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time266
;Solar_Auto_Switcher.c,917 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,918 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,919 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,928 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time267
	JMP        L_SetDS1307_Time266
L_SetDS1307_Time267:
;Solar_Auto_Switcher.c,929 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time268:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time804
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time803
	JMP        L_SetDS1307_Time269
L__SetDS1307_Time804:
L__SetDS1307_Time803:
;Solar_Auto_Switcher.c,931 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time272
;Solar_Auto_Switcher.c,933 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time273:
	DEC        R16
	BRNE       L_SetDS1307_Time273
	DEC        R17
	BRNE       L_SetDS1307_Time273
	DEC        R18
	BRNE       L_SetDS1307_Time273
;Solar_Auto_Switcher.c,934 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,936 :: 		}
L_SetDS1307_Time272:
;Solar_Auto_Switcher.c,937 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time275
;Solar_Auto_Switcher.c,939 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time276:
	DEC        R16
	BRNE       L_SetDS1307_Time276
	DEC        R17
	BRNE       L_SetDS1307_Time276
	DEC        R18
	BRNE       L_SetDS1307_Time276
;Solar_Auto_Switcher.c,940 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,941 :: 		}
L_SetDS1307_Time275:
;Solar_Auto_Switcher.c,942 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time1038
	JMP        L_SetDS1307_Time278
L__SetDS1307_Time1038:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time278:
;Solar_Auto_Switcher.c,943 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1039
	JMP        L_SetDS1307_Time279
L__SetDS1307_Time1039:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time279:
;Solar_Auto_Switcher.c,944 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time268
L_SetDS1307_Time269:
;Solar_Auto_Switcher.c,945 :: 		} // end first while
	JMP        L_SetDS1307_Time265
L_SetDS1307_Time266:
;Solar_Auto_Switcher.c,947 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time280:
	DEC        R16
	BRNE       L_SetDS1307_Time280
	DEC        R17
	BRNE       L_SetDS1307_Time280
	DEC        R18
	BRNE       L_SetDS1307_Time280
	NOP
;Solar_Auto_Switcher.c,948 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,950 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time282:
	DEC        R16
	BRNE       L_SetDS1307_Time282
	DEC        R17
	BRNE       L_SetDS1307_Time282
	DEC        R18
	BRNE       L_SetDS1307_Time282
	NOP
;Solar_Auto_Switcher.c,951 :: 		while (Set==1)
L_SetDS1307_Time284:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time285
;Solar_Auto_Switcher.c,958 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,959 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,960 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,961 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time286
	JMP        L_SetDS1307_Time285
L_SetDS1307_Time286:
;Solar_Auto_Switcher.c,962 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time287:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time806
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time805
	JMP        L_SetDS1307_Time288
L__SetDS1307_Time806:
L__SetDS1307_Time805:
;Solar_Auto_Switcher.c,964 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time291
;Solar_Auto_Switcher.c,966 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time292:
	DEC        R16
	BRNE       L_SetDS1307_Time292
	DEC        R17
	BRNE       L_SetDS1307_Time292
	DEC        R18
	BRNE       L_SetDS1307_Time292
;Solar_Auto_Switcher.c,967 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,968 :: 		}
L_SetDS1307_Time291:
;Solar_Auto_Switcher.c,970 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time294
;Solar_Auto_Switcher.c,972 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time295:
	DEC        R16
	BRNE       L_SetDS1307_Time295
	DEC        R17
	BRNE       L_SetDS1307_Time295
	DEC        R18
	BRNE       L_SetDS1307_Time295
;Solar_Auto_Switcher.c,973 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,974 :: 		}
L_SetDS1307_Time294:
;Solar_Auto_Switcher.c,975 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1040
	JMP        L_SetDS1307_Time297
L__SetDS1307_Time1040:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time297:
;Solar_Auto_Switcher.c,976 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1041
	JMP        L_SetDS1307_Time298
L__SetDS1307_Time1041:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time298:
;Solar_Auto_Switcher.c,977 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time287
L_SetDS1307_Time288:
;Solar_Auto_Switcher.c,978 :: 		} // end first while
	JMP        L_SetDS1307_Time284
L_SetDS1307_Time285:
;Solar_Auto_Switcher.c,980 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time299:
	DEC        R16
	BRNE       L_SetDS1307_Time299
	DEC        R17
	BRNE       L_SetDS1307_Time299
	DEC        R18
	BRNE       L_SetDS1307_Time299
	NOP
;Solar_Auto_Switcher.c,981 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,984 :: 		while (Set==1)
L_SetDS1307_Time301:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time302
;Solar_Auto_Switcher.c,989 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,990 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,991 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,992 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time303
	JMP        L_SetDS1307_Time302
L_SetDS1307_Time303:
;Solar_Auto_Switcher.c,993 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time304:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time808
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time807
	JMP        L_SetDS1307_Time305
L__SetDS1307_Time808:
L__SetDS1307_Time807:
;Solar_Auto_Switcher.c,995 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time308
;Solar_Auto_Switcher.c,997 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time309:
	DEC        R16
	BRNE       L_SetDS1307_Time309
	DEC        R17
	BRNE       L_SetDS1307_Time309
	DEC        R18
	BRNE       L_SetDS1307_Time309
;Solar_Auto_Switcher.c,998 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,999 :: 		}
L_SetDS1307_Time308:
;Solar_Auto_Switcher.c,1000 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time311
;Solar_Auto_Switcher.c,1002 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time312:
	DEC        R16
	BRNE       L_SetDS1307_Time312
	DEC        R17
	BRNE       L_SetDS1307_Time312
	DEC        R18
	BRNE       L_SetDS1307_Time312
;Solar_Auto_Switcher.c,1003 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,1004 :: 		}
L_SetDS1307_Time311:
;Solar_Auto_Switcher.c,1005 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1042
	JMP        L_SetDS1307_Time314
L__SetDS1307_Time1042:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time314:
;Solar_Auto_Switcher.c,1006 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1043
	JMP        L_SetDS1307_Time315
L__SetDS1307_Time1043:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time315:
;Solar_Auto_Switcher.c,1009 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Auto_Switcher.c,1010 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time304
L_SetDS1307_Time305:
;Solar_Auto_Switcher.c,1011 :: 		} // end first while
	JMP        L_SetDS1307_Time301
L_SetDS1307_Time302:
;Solar_Auto_Switcher.c,1013 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time316:
	DEC        R16
	BRNE       L_SetDS1307_Time316
	DEC        R17
	BRNE       L_SetDS1307_Time316
	DEC        R18
	BRNE       L_SetDS1307_Time316
	NOP
;Solar_Auto_Switcher.c,1014 :: 		LCD_Clear(1,1,16);  // clear the lcd first row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1015 :: 		LCD_CLear(2,1,16); // clear the lcd two row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1018 :: 		set_ds1307_day=ReadDate(0x04);
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1020 :: 		while (Set==1)
L_SetDS1307_Time318:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time319
;Solar_Auto_Switcher.c,1022 :: 		ByteToStr(set_ds1307_day,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_day+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1023 :: 		LCD_OUT(2,1,"D:");
	LDI        R27, #lo_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1024 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1025 :: 		LCD_OUT(2,12,"Y:");
	LDI        R27, #lo_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1026 :: 		LCD_Out(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1027 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time320
	JMP        L_SetDS1307_Time319
L_SetDS1307_Time320:
;Solar_Auto_Switcher.c,1028 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time321:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time810
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time809
	JMP        L_SetDS1307_Time322
L__SetDS1307_Time810:
L__SetDS1307_Time809:
;Solar_Auto_Switcher.c,1030 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time325
;Solar_Auto_Switcher.c,1032 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time326:
	DEC        R16
	BRNE       L_SetDS1307_Time326
	DEC        R17
	BRNE       L_SetDS1307_Time326
	DEC        R18
	BRNE       L_SetDS1307_Time326
;Solar_Auto_Switcher.c,1033 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1034 :: 		}
L_SetDS1307_Time325:
;Solar_Auto_Switcher.c,1035 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time328
;Solar_Auto_Switcher.c,1037 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time329:
	DEC        R16
	BRNE       L_SetDS1307_Time329
	DEC        R17
	BRNE       L_SetDS1307_Time329
	DEC        R18
	BRNE       L_SetDS1307_Time329
;Solar_Auto_Switcher.c,1038 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1039 :: 		}
L_SetDS1307_Time328:
;Solar_Auto_Switcher.c,1040 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time1044
	JMP        L_SetDS1307_Time331
L__SetDS1307_Time1044:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time331:
;Solar_Auto_Switcher.c,1041 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1045
	JMP        L_SetDS1307_Time332
L__SetDS1307_Time1045:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time332:
;Solar_Auto_Switcher.c,1042 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time321
L_SetDS1307_Time322:
;Solar_Auto_Switcher.c,1043 :: 		} //  end while set
	JMP        L_SetDS1307_Time318
L_SetDS1307_Time319:
;Solar_Auto_Switcher.c,1045 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time333:
	DEC        R16
	BRNE       L_SetDS1307_Time333
	DEC        R17
	BRNE       L_SetDS1307_Time333
	DEC        R18
	BRNE       L_SetDS1307_Time333
	NOP
;Solar_Auto_Switcher.c,1046 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1049 :: 		set_ds1307_month=ReadDate(0x05);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1050 :: 		while (Set==1)
L_SetDS1307_Time335:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time336
;Solar_Auto_Switcher.c,1052 :: 		ByteToStr(set_ds1307_month,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_month+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1053 :: 		LCD_Out(2,8,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1054 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time337
	JMP        L_SetDS1307_Time336
L_SetDS1307_Time337:
;Solar_Auto_Switcher.c,1055 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time338:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time812
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time811
	JMP        L_SetDS1307_Time339
L__SetDS1307_Time812:
L__SetDS1307_Time811:
;Solar_Auto_Switcher.c,1057 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time342
;Solar_Auto_Switcher.c,1059 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time343:
	DEC        R16
	BRNE       L_SetDS1307_Time343
	DEC        R17
	BRNE       L_SetDS1307_Time343
	DEC        R18
	BRNE       L_SetDS1307_Time343
;Solar_Auto_Switcher.c,1060 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1062 :: 		}
L_SetDS1307_Time342:
;Solar_Auto_Switcher.c,1063 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time345
;Solar_Auto_Switcher.c,1065 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time346:
	DEC        R16
	BRNE       L_SetDS1307_Time346
	DEC        R17
	BRNE       L_SetDS1307_Time346
	DEC        R18
	BRNE       L_SetDS1307_Time346
;Solar_Auto_Switcher.c,1066 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1067 :: 		}
L_SetDS1307_Time345:
;Solar_Auto_Switcher.c,1068 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time1046
	JMP        L_SetDS1307_Time348
L__SetDS1307_Time1046:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time348:
;Solar_Auto_Switcher.c,1069 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1047
	JMP        L_SetDS1307_Time349
L__SetDS1307_Time1047:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time349:
;Solar_Auto_Switcher.c,1070 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time338
L_SetDS1307_Time339:
;Solar_Auto_Switcher.c,1071 :: 		} //  end while set
	JMP        L_SetDS1307_Time335
L_SetDS1307_Time336:
;Solar_Auto_Switcher.c,1073 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time350:
	DEC        R16
	BRNE       L_SetDS1307_Time350
	DEC        R17
	BRNE       L_SetDS1307_Time350
	DEC        R18
	BRNE       L_SetDS1307_Time350
	NOP
;Solar_Auto_Switcher.c,1074 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1077 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1079 :: 		while (Set==1)
L_SetDS1307_Time352:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time353
;Solar_Auto_Switcher.c,1081 :: 		ByteToStr(set_ds1307_year,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_year+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1082 :: 		LCD_Out(2,14,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1083 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time354
	JMP        L_SetDS1307_Time353
L_SetDS1307_Time354:
;Solar_Auto_Switcher.c,1084 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time355:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time814
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time813
	JMP        L_SetDS1307_Time356
L__SetDS1307_Time814:
L__SetDS1307_Time813:
;Solar_Auto_Switcher.c,1086 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time359
;Solar_Auto_Switcher.c,1088 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time360:
	DEC        R16
	BRNE       L_SetDS1307_Time360
	DEC        R17
	BRNE       L_SetDS1307_Time360
	DEC        R18
	BRNE       L_SetDS1307_Time360
;Solar_Auto_Switcher.c,1089 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1091 :: 		}
L_SetDS1307_Time359:
;Solar_Auto_Switcher.c,1092 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time362
;Solar_Auto_Switcher.c,1094 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time363:
	DEC        R16
	BRNE       L_SetDS1307_Time363
	DEC        R17
	BRNE       L_SetDS1307_Time363
	DEC        R18
	BRNE       L_SetDS1307_Time363
;Solar_Auto_Switcher.c,1095 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1096 :: 		}
L_SetDS1307_Time362:
;Solar_Auto_Switcher.c,1097 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time1048
	JMP        L_SetDS1307_Time365
L__SetDS1307_Time1048:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time365:
;Solar_Auto_Switcher.c,1098 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1049
	JMP        L_SetDS1307_Time366
L__SetDS1307_Time1049:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time366:
;Solar_Auto_Switcher.c,1100 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time355
L_SetDS1307_Time356:
;Solar_Auto_Switcher.c,1101 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
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
;Solar_Auto_Switcher.c,1102 :: 		} //  end while set
	JMP        L_SetDS1307_Time352
L_SetDS1307_Time353:
;Solar_Auto_Switcher.c,1103 :: 		}  // end setTimeAndData
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

;Solar_Auto_Switcher.c,1196 :: 		void SetLowBatteryVoltage()
;Solar_Auto_Switcher.c,1198 :: 		LCD_OUT(1,1,"Low Battery  [5]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1199 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage367:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage367
	DEC        R17
	BRNE       L_SetLowBatteryVoltage367
	DEC        R18
	BRNE       L_SetLowBatteryVoltage367
	NOP
;Solar_Auto_Switcher.c,1200 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1201 :: 		while(Set==1)
L_SetLowBatteryVoltage369:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage370
;Solar_Auto_Switcher.c,1203 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1204 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_23_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_23_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1205 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1207 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage371
	JMP        L_SetLowBatteryVoltage370
L_SetLowBatteryVoltage371:
;Solar_Auto_Switcher.c,1208 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage372:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage788
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage787
	JMP        L_SetLowBatteryVoltage373
L__SetLowBatteryVoltage788:
L__SetLowBatteryVoltage787:
;Solar_Auto_Switcher.c,1210 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage376
;Solar_Auto_Switcher.c,1212 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage377:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage377
	DEC        R17
	BRNE       L_SetLowBatteryVoltage377
	DEC        R18
	BRNE       L_SetLowBatteryVoltage377
;Solar_Auto_Switcher.c,1213 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Auto_Switcher.c,1215 :: 		}
L_SetLowBatteryVoltage376:
;Solar_Auto_Switcher.c,1216 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage379
;Solar_Auto_Switcher.c,1218 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage380:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage380
	DEC        R17
	BRNE       L_SetLowBatteryVoltage380
	DEC        R18
	BRNE       L_SetLowBatteryVoltage380
;Solar_Auto_Switcher.c,1219 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Auto_Switcher.c,1220 :: 		}
L_SetLowBatteryVoltage379:
;Solar_Auto_Switcher.c,1221 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1051
	LDI        R16, 1
L__SetLowBatteryVoltage1051:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1052
	JMP        L_SetLowBatteryVoltage382
L__SetLowBatteryVoltage1052:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage382:
;Solar_Auto_Switcher.c,1222 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1053
	LDI        R16, 1
L__SetLowBatteryVoltage1053:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1054
	JMP        L_SetLowBatteryVoltage383
L__SetLowBatteryVoltage1054:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage383:
;Solar_Auto_Switcher.c,1223 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage372
L_SetLowBatteryVoltage373:
;Solar_Auto_Switcher.c,1224 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage369
L_SetLowBatteryVoltage370:
;Solar_Auto_Switcher.c,1225 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1227 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage384:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage384
	DEC        R17
	BRNE       L_SetLowBatteryVoltage384
	DEC        R18
	BRNE       L_SetLowBatteryVoltage384
	NOP
;Solar_Auto_Switcher.c,1228 :: 		while(Set==1)
L_SetLowBatteryVoltage386:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage387
;Solar_Auto_Switcher.c,1230 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1231 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_25_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_25_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1232 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1234 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage388
	JMP        L_SetLowBatteryVoltage387
L_SetLowBatteryVoltage388:
;Solar_Auto_Switcher.c,1235 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage389:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage790
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage789
	JMP        L_SetLowBatteryVoltage390
L__SetLowBatteryVoltage790:
L__SetLowBatteryVoltage789:
;Solar_Auto_Switcher.c,1237 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage393
;Solar_Auto_Switcher.c,1239 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage394:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage394
	DEC        R17
	BRNE       L_SetLowBatteryVoltage394
	DEC        R18
	BRNE       L_SetLowBatteryVoltage394
;Solar_Auto_Switcher.c,1240 :: 		Mini_Battery_Voltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1242 :: 		}
L_SetLowBatteryVoltage393:
;Solar_Auto_Switcher.c,1243 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage396
;Solar_Auto_Switcher.c,1245 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage397:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage397
	DEC        R17
	BRNE       L_SetLowBatteryVoltage397
	DEC        R18
	BRNE       L_SetLowBatteryVoltage397
;Solar_Auto_Switcher.c,1246 :: 		Mini_Battery_Voltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1247 :: 		}
L_SetLowBatteryVoltage396:
;Solar_Auto_Switcher.c,1248 :: 		if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1055
	LDI        R16, 1
L__SetLowBatteryVoltage1055:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1056
	JMP        L_SetLowBatteryVoltage399
L__SetLowBatteryVoltage1056:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage399:
;Solar_Auto_Switcher.c,1249 :: 		if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1057
	LDI        R16, 1
L__SetLowBatteryVoltage1057:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1058
	JMP        L_SetLowBatteryVoltage400
L__SetLowBatteryVoltage1058:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage400:
;Solar_Auto_Switcher.c,1250 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage389
L_SetLowBatteryVoltage390:
;Solar_Auto_Switcher.c,1251 :: 		}// end while set
	JMP        L_SetLowBatteryVoltage386
L_SetLowBatteryVoltage387:
;Solar_Auto_Switcher.c,1253 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1254 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1255 :: 		}
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

;Solar_Auto_Switcher.c,1257 :: 		void SetStartUpLoadsVoltage()
;Solar_Auto_Switcher.c,1259 :: 		LCD_OUT(1,1,"Start Loads V[6]");
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
;Solar_Auto_Switcher.c,1260 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage401:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage401
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage401
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage401
	NOP
;Solar_Auto_Switcher.c,1261 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1262 :: 		while(Set==1)
L_SetStartUpLoadsVoltage403:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage404
;Solar_Auto_Switcher.c,1264 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1265 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
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
;Solar_Auto_Switcher.c,1266 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1268 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage405
	JMP        L_SetStartUpLoadsVoltage404
L_SetStartUpLoadsVoltage405:
;Solar_Auto_Switcher.c,1269 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage406:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage794
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage793
	JMP        L_SetStartUpLoadsVoltage407
L__SetStartUpLoadsVoltage794:
L__SetStartUpLoadsVoltage793:
;Solar_Auto_Switcher.c,1271 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage410
;Solar_Auto_Switcher.c,1273 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage411:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage411
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage411
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage411
;Solar_Auto_Switcher.c,1274 :: 		StartLoadsVoltage+=0.1;
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
;Solar_Auto_Switcher.c,1276 :: 		}
L_SetStartUpLoadsVoltage410:
;Solar_Auto_Switcher.c,1277 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage413
;Solar_Auto_Switcher.c,1279 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage414:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage414
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage414
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage414
;Solar_Auto_Switcher.c,1280 :: 		StartLoadsVoltage-=0.1;
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
;Solar_Auto_Switcher.c,1281 :: 		}
L_SetStartUpLoadsVoltage413:
;Solar_Auto_Switcher.c,1282 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1060
	LDI        R16, 1
L__SetStartUpLoadsVoltage1060:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1061
	JMP        L_SetStartUpLoadsVoltage416
L__SetStartUpLoadsVoltage1061:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage416:
;Solar_Auto_Switcher.c,1283 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1062
	LDI        R16, 1
L__SetStartUpLoadsVoltage1062:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1063
	JMP        L_SetStartUpLoadsVoltage417
L__SetStartUpLoadsVoltage1063:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage417:
;Solar_Auto_Switcher.c,1284 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage406
L_SetStartUpLoadsVoltage407:
;Solar_Auto_Switcher.c,1285 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage403
L_SetStartUpLoadsVoltage404:
;Solar_Auto_Switcher.c,1287 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1288 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage418:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage418
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage418
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage418
	NOP
;Solar_Auto_Switcher.c,1290 :: 		while(Set==1)
L_SetStartUpLoadsVoltage420:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage421
;Solar_Auto_Switcher.c,1292 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1293 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);     // re format vin_battery to have 2 decimals
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
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
;Solar_Auto_Switcher.c,1294 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1296 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage422
	JMP        L_SetStartUpLoadsVoltage421
L_SetStartUpLoadsVoltage422:
;Solar_Auto_Switcher.c,1297 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage423:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage796
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage795
	JMP        L_SetStartUpLoadsVoltage424
L__SetStartUpLoadsVoltage796:
L__SetStartUpLoadsVoltage795:
;Solar_Auto_Switcher.c,1302 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage427
;Solar_Auto_Switcher.c,1304 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage428:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage428
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage428
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage428
;Solar_Auto_Switcher.c,1305 :: 		StartLoadsVoltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1307 :: 		}
L_SetStartUpLoadsVoltage427:
;Solar_Auto_Switcher.c,1308 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage430
;Solar_Auto_Switcher.c,1310 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage431:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage431
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage431
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage431
;Solar_Auto_Switcher.c,1311 :: 		StartLoadsVoltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1312 :: 		}
L_SetStartUpLoadsVoltage430:
;Solar_Auto_Switcher.c,1313 :: 		if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1064
	LDI        R16, 1
L__SetStartUpLoadsVoltage1064:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1065
	JMP        L_SetStartUpLoadsVoltage433
L__SetStartUpLoadsVoltage1065:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage433:
;Solar_Auto_Switcher.c,1314 :: 		if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1066
	LDI        R16, 1
L__SetStartUpLoadsVoltage1066:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1067
	JMP        L_SetStartUpLoadsVoltage434
L__SetStartUpLoadsVoltage1067:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage434:
;Solar_Auto_Switcher.c,1315 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage423
L_SetStartUpLoadsVoltage424:
;Solar_Auto_Switcher.c,1316 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage420
L_SetStartUpLoadsVoltage421:
;Solar_Auto_Switcher.c,1318 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);   // save float number to
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
;Solar_Auto_Switcher.c,1320 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1321 :: 		}
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

;Solar_Auto_Switcher.c,1323 :: 		void SetHighVoltage()
;Solar_Auto_Switcher.c,1326 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetHighVoltage435:
	DEC        R16
	BRNE       L_SetHighVoltage435
	DEC        R17
	BRNE       L_SetHighVoltage435
	DEC        R18
	BRNE       L_SetHighVoltage435
	NOP
;Solar_Auto_Switcher.c,1327 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1328 :: 		while(Set==1)
L_SetHighVoltage437:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetHighVoltage438
;Solar_Auto_Switcher.c,1330 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1331 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1332 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage439
	JMP        L_SetHighVoltage438
L_SetHighVoltage439:
;Solar_Auto_Switcher.c,1333 :: 		while(Increment==1 || Decrement==1)
L_SetHighVoltage440:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetHighVoltage823
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetHighVoltage822
	JMP        L_SetHighVoltage441
L__SetHighVoltage823:
L__SetHighVoltage822:
;Solar_Auto_Switcher.c,1335 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1336 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1337 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage444
;Solar_Auto_Switcher.c,1339 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetHighVoltage445:
	DEC        R16
	BRNE       L_SetHighVoltage445
	DEC        R17
	BRNE       L_SetHighVoltage445
	DEC        R18
	BRNE       L_SetHighVoltage445
;Solar_Auto_Switcher.c,1340 :: 		High_Voltage++;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1341 :: 		}
L_SetHighVoltage444:
;Solar_Auto_Switcher.c,1342 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetHighVoltage447
;Solar_Auto_Switcher.c,1344 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetHighVoltage448:
	DEC        R16
	BRNE       L_SetHighVoltage448
	DEC        R17
	BRNE       L_SetHighVoltage448
	DEC        R18
	BRNE       L_SetHighVoltage448
;Solar_Auto_Switcher.c,1345 :: 		High_Voltage--;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1346 :: 		}
L_SetHighVoltage447:
;Solar_Auto_Switcher.c,1347 :: 		if(High_Voltage > 255 ) High_Voltage=0;
	LDS        R18, _High_Voltage+0
	LDS        R19, _High_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetHighVoltage1069
	JMP        L_SetHighVoltage450
L__SetHighVoltage1069:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage450:
;Solar_Auto_Switcher.c,1348 :: 		if (High_Voltage < 0 ) High_Voltage=0;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CPI        R17, 0
	BRNE       L__SetHighVoltage1070
	CPI        R16, 0
L__SetHighVoltage1070:
	BRLO       L__SetHighVoltage1071
	JMP        L_SetHighVoltage451
L__SetHighVoltage1071:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage451:
;Solar_Auto_Switcher.c,1349 :: 		} // end while increment or decrement
	JMP        L_SetHighVoltage440
L_SetHighVoltage441:
;Solar_Auto_Switcher.c,1350 :: 		} // end while set
	JMP        L_SetHighVoltage437
L_SetHighVoltage438:
;Solar_Auto_Switcher.c,1351 :: 		EEPROM_Write(0x12,High_Voltage);
	LDS        R4, _High_Voltage+0
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1352 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1353 :: 		}
L_end_SetHighVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetHighVoltage

_SetLowVoltage:

;Solar_Auto_Switcher.c,1355 :: 		void SetLowVoltage()
;Solar_Auto_Switcher.c,1358 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowVoltage452:
	DEC        R16
	BRNE       L_SetLowVoltage452
	DEC        R17
	BRNE       L_SetLowVoltage452
	DEC        R18
	BRNE       L_SetLowVoltage452
	NOP
;Solar_Auto_Switcher.c,1359 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1360 :: 		while(Set==1)
L_SetLowVoltage454:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowVoltage455
;Solar_Auto_Switcher.c,1362 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1363 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1364 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage456
	JMP        L_SetLowVoltage455
L_SetLowVoltage456:
;Solar_Auto_Switcher.c,1365 :: 		while(Increment==1 || Decrement==1)
L_SetLowVoltage457:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowVoltage826
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowVoltage825
	JMP        L_SetLowVoltage458
L__SetLowVoltage826:
L__SetLowVoltage825:
;Solar_Auto_Switcher.c,1367 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1368 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1369 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage461
;Solar_Auto_Switcher.c,1371 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowVoltage462:
	DEC        R16
	BRNE       L_SetLowVoltage462
	DEC        R17
	BRNE       L_SetLowVoltage462
	DEC        R18
	BRNE       L_SetLowVoltage462
;Solar_Auto_Switcher.c,1372 :: 		Low_Voltage++;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1373 :: 		}
L_SetLowVoltage461:
;Solar_Auto_Switcher.c,1374 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowVoltage464
;Solar_Auto_Switcher.c,1376 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowVoltage465:
	DEC        R16
	BRNE       L_SetLowVoltage465
	DEC        R17
	BRNE       L_SetLowVoltage465
	DEC        R18
	BRNE       L_SetLowVoltage465
;Solar_Auto_Switcher.c,1377 :: 		Low_Voltage--;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1378 :: 		}
L_SetLowVoltage464:
;Solar_Auto_Switcher.c,1379 :: 		if(Low_Voltage > 255 ) Low_Voltage=0;
	LDS        R18, _Low_Voltage+0
	LDS        R19, _Low_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetLowVoltage1073
	JMP        L_SetLowVoltage467
L__SetLowVoltage1073:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage467:
;Solar_Auto_Switcher.c,1380 :: 		if (Low_Voltage < 0 ) Low_Voltage=0;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CPI        R17, 0
	BRNE       L__SetLowVoltage1074
	CPI        R16, 0
L__SetLowVoltage1074:
	BRLO       L__SetLowVoltage1075
	JMP        L_SetLowVoltage468
L__SetLowVoltage1075:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage468:
;Solar_Auto_Switcher.c,1381 :: 		} // end while increment or decrement
	JMP        L_SetLowVoltage457
L_SetLowVoltage458:
;Solar_Auto_Switcher.c,1382 :: 		} // end while set
	JMP        L_SetLowVoltage454
L_SetLowVoltage455:
;Solar_Auto_Switcher.c,1383 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1384 :: 		EEPROM_Write(0x13,Low_Voltage);
	LDS        R4, _Low_Voltage+0
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1385 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1386 :: 		}
L_end_SetLowVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowVoltage

_Startup_Timers:

;Solar_Auto_Switcher.c,1390 :: 		void Startup_Timers()
;Solar_Auto_Switcher.c,1392 :: 		LCD_OUT(1,1,"Start Loads [15]");
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
;Solar_Auto_Switcher.c,1393 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers469:
	DEC        R16
	BRNE       L_Startup_Timers469
	DEC        R17
	BRNE       L_Startup_Timers469
	DEC        R18
	BRNE       L_Startup_Timers469
	NOP
;Solar_Auto_Switcher.c,1394 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1395 :: 		while(Set==1)
L_Startup_Timers471:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers472
;Solar_Auto_Switcher.c,1397 :: 		IntToStr(startupTIme_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_1+0
	LDS        R3, _startupTIme_1+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1398 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1400 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1401 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers473
	JMP        L_Startup_Timers472
L_Startup_Timers473:
;Solar_Auto_Switcher.c,1402 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers474:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers818
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers817
	JMP        L_Startup_Timers475
L__Startup_Timers818:
L__Startup_Timers817:
;Solar_Auto_Switcher.c,1404 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers478
;Solar_Auto_Switcher.c,1407 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers479:
	DEC        R16
	BRNE       L_Startup_Timers479
	DEC        R17
	BRNE       L_Startup_Timers479
	DEC        R18
	BRNE       L_Startup_Timers479
;Solar_Auto_Switcher.c,1408 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1409 :: 		}
L_Startup_Timers478:
;Solar_Auto_Switcher.c,1410 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers481
;Solar_Auto_Switcher.c,1413 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers482:
	DEC        R16
	BRNE       L_Startup_Timers482
	DEC        R17
	BRNE       L_Startup_Timers482
	DEC        R18
	BRNE       L_Startup_Timers482
;Solar_Auto_Switcher.c,1414 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1415 :: 		}
L_Startup_Timers481:
;Solar_Auto_Switcher.c,1416 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1077
	JMP        L_Startup_Timers484
L__Startup_Timers1077:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers484:
;Solar_Auto_Switcher.c,1417 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1078
	CPI        R16, 0
L__Startup_Timers1078:
	BRLO       L__Startup_Timers1079
	JMP        L_Startup_Timers485
L__Startup_Timers1079:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers485:
;Solar_Auto_Switcher.c,1418 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers474
L_Startup_Timers475:
;Solar_Auto_Switcher.c,1419 :: 		} // end while main while set
	JMP        L_Startup_Timers471
L_Startup_Timers472:
;Solar_Auto_Switcher.c,1420 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1422 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers486:
	DEC        R16
	BRNE       L_Startup_Timers486
	DEC        R17
	BRNE       L_Startup_Timers486
	DEC        R18
	BRNE       L_Startup_Timers486
	NOP
;Solar_Auto_Switcher.c,1423 :: 		while (Set==1)
L_Startup_Timers488:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers489
;Solar_Auto_Switcher.c,1425 :: 		IntToStr(startupTIme_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_2+0
	LDS        R3, _startupTIme_2+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1426 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1428 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1429 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers490
	JMP        L_Startup_Timers489
L_Startup_Timers490:
;Solar_Auto_Switcher.c,1430 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers491:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers820
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers819
	JMP        L_Startup_Timers492
L__Startup_Timers820:
L__Startup_Timers819:
;Solar_Auto_Switcher.c,1432 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers495
;Solar_Auto_Switcher.c,1435 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers496:
	DEC        R16
	BRNE       L_Startup_Timers496
	DEC        R17
	BRNE       L_Startup_Timers496
	DEC        R18
	BRNE       L_Startup_Timers496
;Solar_Auto_Switcher.c,1436 :: 		startupTIme_2++;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1437 :: 		}
L_Startup_Timers495:
;Solar_Auto_Switcher.c,1438 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers498
;Solar_Auto_Switcher.c,1441 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers499:
	DEC        R16
	BRNE       L_Startup_Timers499
	DEC        R17
	BRNE       L_Startup_Timers499
	DEC        R18
	BRNE       L_Startup_Timers499
;Solar_Auto_Switcher.c,1442 :: 		startupTIme_2--;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1443 :: 		}
L_Startup_Timers498:
;Solar_Auto_Switcher.c,1444 :: 		if(startupTIme_2 > 600 ) startupTIme_2=0;
	LDS        R18, _startupTIme_2+0
	LDS        R19, _startupTIme_2+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1080
	JMP        L_Startup_Timers501
L__Startup_Timers1080:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers501:
;Solar_Auto_Switcher.c,1445 :: 		if (startupTIme_2<0) startupTIme_2=0;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1081
	CPI        R16, 0
L__Startup_Timers1081:
	BRLO       L__Startup_Timers1082
	JMP        L_Startup_Timers502
L__Startup_Timers1082:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers502:
;Solar_Auto_Switcher.c,1446 :: 		} // end while increment and decrement
	JMP        L_Startup_Timers491
L_Startup_Timers492:
;Solar_Auto_Switcher.c,1447 :: 		} // end while set
	JMP        L_Startup_Timers488
L_Startup_Timers489:
;Solar_Auto_Switcher.c,1450 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1451 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1454 :: 		} // end  function
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

;Solar_Auto_Switcher.c,1482 :: 		void Screen_1()
;Solar_Auto_Switcher.c,1486 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Auto_Switcher.c,1487 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Auto_Switcher.c,1488 :: 		CalculateAC();
	CALL       _CalculateAC+0
;Solar_Auto_Switcher.c,1489 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Auto_Switcher.c,1491 :: 		void ADCBattery()
;Solar_Auto_Switcher.c,1493 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Auto_Switcher.c,1494 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Auto_Switcher.c,1495 :: 		ADPS2_Bit=1;
	LDS        R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	STS        ADPS2_bit+0, R27
;Solar_Auto_Switcher.c,1496 :: 		ADPS1_Bit=1;
	LDS        R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	STS        ADPS1_bit+0, R27
;Solar_Auto_Switcher.c,1497 :: 		ADPS0_Bit=0;
	LDS        R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	STS        ADPS0_bit+0, R27
;Solar_Auto_Switcher.c,1498 :: 		}
L_end_ADCBattery:
	POP        R2
	RET
; end of _ADCBattery

_Read_Battery:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 49
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Auto_Switcher.c,1500 :: 		void Read_Battery()
;Solar_Auto_Switcher.c,1502 :: 		float sum=0 , Battery[10];
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 0
	STD        Y+40, R27
	STD        Y+41, R27
	STD        Y+42, R27
	STD        Y+43, R27
;Solar_Auto_Switcher.c,1503 :: 		char i=0;
;Solar_Auto_Switcher.c,1504 :: 		ADC_Value=ADC_Read(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Auto_Switcher.c,1505 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
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
;Solar_Auto_Switcher.c,1509 :: 		for ( i=0; i<10 ; i++)
	LDI        R27, 0
	STD        Y+44, R27
L_Read_Battery503:
	LDD        R16, Y+44
	CPI        R16, 10
	BRLO       L__Read_Battery1086
	JMP        L_Read_Battery504
L__Read_Battery1086:
;Solar_Auto_Switcher.c,1511 :: 		Battery[i]=((10.5/0.5)*Battery_Voltage);
	MOVW       R18, R28
	LDD        R16, Y+44
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	STD        Y+47, R16
	STD        Y+48, R17
	LDI        R16, 0
	LDI        R17, 0
	LDI        R18, 168
	LDI        R19, 65
	LDS        R20, _Battery_Voltage+0
	LDS        R21, _Battery_Voltage+1
	LDS        R22, _Battery_Voltage+2
	LDS        R23, _Battery_Voltage+3
	CALL       _float_fpmul1+0
	LDD        R20, Y+47
	LDD        R21, Y+48
	MOVW       R30, R20
	ST         Z+, R16
	ST         Z+, R17
	ST         Z+, R18
	ST         Z+, R19
;Solar_Auto_Switcher.c,1512 :: 		delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Read_Battery506:
	DEC        R16
	BRNE       L_Read_Battery506
	DEC        R17
	BRNE       L_Read_Battery506
	DEC        R18
	BRNE       L_Read_Battery506
;Solar_Auto_Switcher.c,1513 :: 		sum+=Battery[i];
	MOVW       R18, R28
	LDD        R16, Y+44
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z+
	LD         R17, Z+
	LD         R18, Z+
	LD         R19, Z+
	LDD        R20, Y+40
	LDD        R21, Y+41
	LDD        R22, Y+42
	LDD        R23, Y+43
	CALL       _float_fpadd1+0
	STD        Y+40, R16
	STD        Y+41, R17
	STD        Y+42, R18
	STD        Y+43, R19
;Solar_Auto_Switcher.c,1509 :: 		for ( i=0; i<10 ; i++)
	LDD        R16, Y+44
	SUBI       R16, 255
	STD        Y+44, R16
;Solar_Auto_Switcher.c,1514 :: 		}
	JMP        L_Read_Battery503
L_Read_Battery504:
;Solar_Auto_Switcher.c,1515 :: 		Vin_Battery= sum/10.0 ;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	LDD        R16, Y+40
	LDD        R17, Y+41
	LDD        R18, Y+42
	LDD        R19, Y+43
	CALL       _float_fpdiv1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
;Solar_Auto_Switcher.c,1516 :: 		LCD_OUT(2,1,"V=");
	LDI        R27, #lo_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1517 :: 		sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
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
;Solar_Auto_Switcher.c,1518 :: 		LCD_OUT(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1520 :: 		}
L_end_Read_Battery:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 48
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _Read_Battery

_LowBatteryVoltageAlarm:

;Solar_Auto_Switcher.c,1523 :: 		void LowBatteryVoltageAlarm()
;Solar_Auto_Switcher.c,1525 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
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
	BREQ       L__LowBatteryVoltageAlarm1088
	LDI        R16, 1
L__LowBatteryVoltageAlarm1088:
	TST        R16
	BRNE       L__LowBatteryVoltageAlarm1089
	JMP        L__LowBatteryVoltageAlarm848
L__LowBatteryVoltageAlarm1089:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__LowBatteryVoltageAlarm1090
	JMP        L__LowBatteryVoltageAlarm847
L__LowBatteryVoltageAlarm1090:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1091
	JMP        L__LowBatteryVoltageAlarm846
L__LowBatteryVoltageAlarm1091:
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1092
	JMP        L__LowBatteryVoltageAlarm845
L__LowBatteryVoltageAlarm1092:
	JMP        L_LowBatteryVoltageAlarm512
L__LowBatteryVoltageAlarm846:
L__LowBatteryVoltageAlarm845:
L__LowBatteryVoltageAlarm843:
;Solar_Auto_Switcher.c,1527 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1528 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm513:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm513
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm513
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm513
	NOP
;Solar_Auto_Switcher.c,1529 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1530 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm515:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm515
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm515
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm515
	NOP
;Solar_Auto_Switcher.c,1531 :: 		}
L_LowBatteryVoltageAlarm512:
;Solar_Auto_Switcher.c,1525 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
L__LowBatteryVoltageAlarm848:
L__LowBatteryVoltageAlarm847:
;Solar_Auto_Switcher.c,1532 :: 		}
L_end_LowBatteryVoltageAlarm:
	RET
; end of _LowBatteryVoltageAlarm

_ReadAC:

;Solar_Auto_Switcher.c,1534 :: 		unsigned int ReadAC()
;Solar_Auto_Switcher.c,1536 :: 		char numberOfSamples=100;
	PUSH       R2
;Solar_Auto_Switcher.c,1537 :: 		char numberOfAverage=10;
;Solar_Auto_Switcher.c,1538 :: 		unsigned long sum=0;
;Solar_Auto_Switcher.c,1539 :: 		unsigned long r=0;
;Solar_Auto_Switcher.c,1540 :: 		unsigned long max_v=0;
; max_v start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
;Solar_Auto_Switcher.c,1541 :: 		char i=0;
;Solar_Auto_Switcher.c,1542 :: 		char j=0;
;Solar_Auto_Switcher.c,1543 :: 		unsigned long average=0;
;Solar_Auto_Switcher.c,1545 :: 		for (i=0;i<100;i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; max_v end address is: 19 (R19)
; i end address is: 18 (R18)
L_ReadAC517:
; i start address is: 18 (R18)
; max_v start address is: 19 (R19)
	CPI        R18, 100
	BRLO       L__ReadAC1094
	JMP        L_ReadAC518
L__ReadAC1094:
;Solar_Auto_Switcher.c,1547 :: 		r=ADC_Read(3);
	PUSH       R22
	PUSH       R21
	PUSH       R20
	PUSH       R19
	PUSH       R18
	LDI        R27, 3
	MOV        R2, R27
	CALL       _ADC_Read+0
	POP        R18
	POP        R19
	POP        R20
	POP        R21
	POP        R22
; r start address is: 23 (R23)
	MOV        R23, R16
	MOV        R24, R17
	LDI        R25, 0
	MOV        R26, R25
;Solar_Auto_Switcher.c,1548 :: 		if (max_v<r) max_v=r;
	CP         R19, R23
	CPC        R20, R24
	CPC        R21, R25
	CPC        R22, R26
	BRLO       L__ReadAC1095
	JMP        L__ReadAC760
L__ReadAC1095:
	MOV        R19, R23
	MOV        R20, R24
	MOV        R21, R25
	MOV        R22, R26
; r end address is: 23 (R23)
; max_v end address is: 19 (R19)
	JMP        L_ReadAC520
L__ReadAC760:
L_ReadAC520:
;Solar_Auto_Switcher.c,1549 :: 		delay_us(200);
; max_v start address is: 19 (R19)
	LDI        R17, 3
	LDI        R16, 19
L_ReadAC521:
	DEC        R16
	BRNE       L_ReadAC521
	DEC        R17
	BRNE       L_ReadAC521
;Solar_Auto_Switcher.c,1545 :: 		for (i=0;i<100;i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Solar_Auto_Switcher.c,1550 :: 		}
; i end address is: 18 (R18)
	JMP        L_ReadAC517
L_ReadAC518:
;Solar_Auto_Switcher.c,1551 :: 		return max_v;
	MOV        R16, R19
	MOV        R17, R20
; max_v end address is: 19 (R19)
;Solar_Auto_Switcher.c,1565 :: 		}
;Solar_Auto_Switcher.c,1551 :: 		return max_v;
;Solar_Auto_Switcher.c,1565 :: 		}
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

;Solar_Auto_Switcher.c,1567 :: 		void CalculateAC()
;Solar_Auto_Switcher.c,1570 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,1571 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,1572 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1573 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,1574 :: 		v=v+Error_Voltage;
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
;Solar_Auto_Switcher.c,1576 :: 		if (AC_Available==0 && VoltageProtectionEnable==1)   // disable the ac voltage if voltage protector is enabeled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__CalculateAC840
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CalculateAC1097
	JMP        L__CalculateAC839
L__CalculateAC1097:
L__CalculateAC838:
;Solar_Auto_Switcher.c,1578 :: 		sprintf(buf,"%4.0fV",v);
	MOVW       R20, R28
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_36_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_36_Solar_Auto_Switcher+0)
	PUSH       R27
	PUSH       R21
	PUSH       R20
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1579 :: 		LCD_OUT(2,8,"-");
	LDI        R27, #lo_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1580 :: 		LCD_OUT(2,9,buf);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1581 :: 		}
	JMP        L_CalculateAC526
;Solar_Auto_Switcher.c,1576 :: 		if (AC_Available==0 && VoltageProtectionEnable==1)   // disable the ac voltage if voltage protector is enabeled
L__CalculateAC840:
L__CalculateAC839:
;Solar_Auto_Switcher.c,1582 :: 		else if (AC_Available== 0 && VoltageProtectionEnable==0) // in this if voltage protector is turned of no need for voltage read
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__CalculateAC842
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__CalculateAC1098
	JMP        L__CalculateAC841
L__CalculateAC1098:
L__CalculateAC837:
;Solar_Auto_Switcher.c,1584 :: 		LCD_out(2,8,"- Grid");
	LDI        R27, #lo_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1582 :: 		else if (AC_Available== 0 && VoltageProtectionEnable==0) // in this if voltage protector is turned of no need for voltage read
L__CalculateAC842:
L__CalculateAC841:
;Solar_Auto_Switcher.c,1585 :: 		}
L_CalculateAC526:
;Solar_Auto_Switcher.c,1586 :: 		VoltageProtector(v);
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _VoltageProtector+0
;Solar_Auto_Switcher.c,1587 :: 		}
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

;Solar_Auto_Switcher.c,1591 :: 		void VoltageProtector(unsigned long voltage)
;Solar_Auto_Switcher.c,1594 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRSH       L__VoltageProtector1100
	JMP        L__VoltageProtector832
L__VoltageProtector1100:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRSH       L__VoltageProtector1101
	JMP        L__VoltageProtector831
L__VoltageProtector1101:
	JMP        L_VoltageProtector534
L__VoltageProtector832:
L__VoltageProtector831:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector833
L__VoltageProtector829:
;Solar_Auto_Switcher.c,1596 :: 		VoltageProtectorGood=0;
	LDI        R27, 0
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1597 :: 		}
L_VoltageProtector534:
;Solar_Auto_Switcher.c,1594 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
L__VoltageProtector833:
;Solar_Auto_Switcher.c,1599 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRLO       L__VoltageProtector1102
	JMP        L__VoltageProtector836
L__VoltageProtector1102:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRLO       L__VoltageProtector1103
	JMP        L__VoltageProtector835
L__VoltageProtector1103:
L__VoltageProtector828:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector834
L__VoltageProtector827:
;Solar_Auto_Switcher.c,1601 :: 		VoltageProtectorGood=1;
	LDI        R27, 1
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1599 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
L__VoltageProtector836:
L__VoltageProtector835:
L__VoltageProtector834:
;Solar_Auto_Switcher.c,1603 :: 		}
L_end_VoltageProtector:
	RET
; end of _VoltageProtector

_ErrorList:

;Solar_Auto_Switcher.c,1605 :: 		void ErrorList()
;Solar_Auto_Switcher.c,1618 :: 		}
L_end_ErrorList:
	RET
; end of _ErrorList

_Start_Timer_0_A:

;Solar_Auto_Switcher.c,1621 :: 		void Start_Timer_0_A()
;Solar_Auto_Switcher.c,1623 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Auto_Switcher.c,1624 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Auto_Switcher.c,1625 :: 		WGM02_bit=0;
	IN         R27, WGM02_bit+0
	CBR        R27, BitMask(WGM02_bit+0)
	OUT        WGM02_bit+0, R27
;Solar_Auto_Switcher.c,1626 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1627 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1628 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1629 :: 		OCR0A=0xFF;
	LDI        R27, 255
	OUT        OCR0A+0, R27
;Solar_Auto_Switcher.c,1630 :: 		OCIE0A_Bit=1;
	LDS        R27, OCIE0A_bit+0
	SBR        R27, BitMask(OCIE0A_bit+0)
	STS        OCIE0A_bit+0, R27
;Solar_Auto_Switcher.c,1631 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_A_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,1633 :: 		void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
;Solar_Auto_Switcher.c,1635 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1636 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Auto_Switcher.c,1637 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Auto_Switcher.c,1638 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Auto_Switcher.c,1641 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1107
	CPI        R18, 244
L__Interupt_Timer_0_A_OFFTime1107:
	BREQ       L__Interupt_Timer_0_A_OFFTime1108
	JMP        L_Interupt_Timer_0_A_OFFTime540
L__Interupt_Timer_0_A_OFFTime1108:
;Solar_Auto_Switcher.c,1644 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1109
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1109:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1110
	JMP        L__Interupt_Timer_0_A_OFFTime853
L__Interupt_Timer_0_A_OFFTime1110:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime852
L__Interupt_Timer_0_A_OFFTime851:
;Solar_Auto_Switcher.c,1646 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1647 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime544:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime544
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime544
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime544
	NOP
;Solar_Auto_Switcher.c,1648 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1649 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1644 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime853:
L__Interupt_Timer_0_A_OFFTime852:
;Solar_Auto_Switcher.c,1651 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Auto_Switcher.c,1652 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1653 :: 		}
L_Interupt_Timer_0_A_OFFTime540:
;Solar_Auto_Switcher.c,1656 :: 		if (Timer_Counter_4==500)              // more than 10 seconds
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	CPI        R17, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1111
	CPI        R16, 244
L__Interupt_Timer_0_A_OFFTime1111:
	BREQ       L__Interupt_Timer_0_A_OFFTime1112
	JMP        L_Interupt_Timer_0_A_OFFTime546
L__Interupt_Timer_0_A_OFFTime1112:
;Solar_Auto_Switcher.c,1659 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1113
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1113:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1114
	JMP        L__Interupt_Timer_0_A_OFFTime855
L__Interupt_Timer_0_A_OFFTime1114:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime854
L__Interupt_Timer_0_A_OFFTime850:
;Solar_Auto_Switcher.c,1661 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1662 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime550:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime550
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime550
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime550
	NOP
;Solar_Auto_Switcher.c,1663 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1664 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1659 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime855:
L__Interupt_Timer_0_A_OFFTime854:
;Solar_Auto_Switcher.c,1666 :: 		Timer_Counter_4=0;
	LDI        R27, 0
	STS        _Timer_Counter_4+0, R27
	STS        _Timer_Counter_4+1, R27
;Solar_Auto_Switcher.c,1667 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1668 :: 		}
L_Interupt_Timer_0_A_OFFTime546:
;Solar_Auto_Switcher.c,1672 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_A_OFFTime1115
	CPI        R16, 232
L__Interupt_Timer_0_A_OFFTime1115:
	BREQ       L__Interupt_Timer_0_A_OFFTime1116
	JMP        L_Interupt_Timer_0_A_OFFTime552
L__Interupt_Timer_0_A_OFFTime1116:
;Solar_Auto_Switcher.c,1674 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1117
	JMP        L__Interupt_Timer_0_A_OFFTime857
L__Interupt_Timer_0_A_OFFTime1117:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime856
L__Interupt_Timer_0_A_OFFTime849:
;Solar_Auto_Switcher.c,1676 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1677 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1678 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1679 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1674 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
L__Interupt_Timer_0_A_OFFTime857:
L__Interupt_Timer_0_A_OFFTime856:
;Solar_Auto_Switcher.c,1681 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Auto_Switcher.c,1682 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1683 :: 		}
L_Interupt_Timer_0_A_OFFTime552:
;Solar_Auto_Switcher.c,1685 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1686 :: 		OCF0A_Bit=1; // clear
	IN         R27, OCF0A_bit+0
	SBR        R27, BitMask(OCF0A_bit+0)
	OUT        OCF0A_bit+0, R27
;Solar_Auto_Switcher.c,1687 :: 		}
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

;Solar_Auto_Switcher.c,1689 :: 		void Stop_Timer_0()
;Solar_Auto_Switcher.c,1691 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1692 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Auto_Switcher.c,1693 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1694 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Auto_Switcher.c,1697 :: 		void EEPROM_FactorySettings(char period)
;Solar_Auto_Switcher.c,1699 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1120
	JMP        L_EEPROM_FactorySettings556
L__EEPROM_FactorySettings1120:
;Solar_Auto_Switcher.c,1701 :: 		if(SystemBatteryMode==12)
	LDS        R16, _SystemBatteryMode+0
	CPI        R16, 12
	BREQ       L__EEPROM_FactorySettings1121
	JMP        L_EEPROM_FactorySettings557
L__EEPROM_FactorySettings1121:
;Solar_Auto_Switcher.c,1703 :: 		Mini_Battery_Voltage=12.0;
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 64
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1704 :: 		StartLoadsVoltage=13.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 88
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1705 :: 		Mini_Battery_Voltage_T2=12.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 72
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1706 :: 		StartLoadsVoltage_T2=13.8;
	LDI        R27, 205
	STS        _StartLoadsVoltage_T2+0, R27
	LDI        R27, 204
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 92
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1707 :: 		}
L_EEPROM_FactorySettings557:
;Solar_Auto_Switcher.c,1708 :: 		if(SystemBatteryMode==24)
	LDS        R16, _SystemBatteryMode+0
	CPI        R16, 24
	BREQ       L__EEPROM_FactorySettings1122
	JMP        L_EEPROM_FactorySettings558
L__EEPROM_FactorySettings1122:
;Solar_Auto_Switcher.c,1710 :: 		Mini_Battery_Voltage=24.5;
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1711 :: 		StartLoadsVoltage=26.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1712 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1713 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1714 :: 		}
L_EEPROM_FactorySettings558:
;Solar_Auto_Switcher.c,1715 :: 		if(SystemBatteryMode==48)
	LDS        R16, _SystemBatteryMode+0
	CPI        R16, 48
	BREQ       L__EEPROM_FactorySettings1123
	JMP        L_EEPROM_FactorySettings559
L__EEPROM_FactorySettings1123:
;Solar_Auto_Switcher.c,1717 :: 		Mini_Battery_Voltage=49.0;
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 68
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 66
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1718 :: 		StartLoadsVoltage=52.0;
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 80
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 66
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1719 :: 		Mini_Battery_Voltage_T2=50.0,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 72
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 66
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1720 :: 		StartLoadsVoltage_T2=54.0;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 88
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 66
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1721 :: 		}
L_EEPROM_FactorySettings559:
;Solar_Auto_Switcher.c,1722 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1723 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1725 :: 		EEPROM_Write(0x00,8);  // writing start hours
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1726 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1727 :: 		EEPROM_Write(0x03,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1728 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1730 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1731 :: 		EEPROM_Write(0x19,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1732 :: 		EEPROM_Write(0x20,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1733 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1735 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1736 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1737 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1738 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1739 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1740 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1741 :: 		}
L_EEPROM_FactorySettings556:
;Solar_Auto_Switcher.c,1769 :: 		EEPROM_Write(0x12,260); //  high voltage Grid
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1770 :: 		EEPROM_Write(0x13,170); // load low voltage
	LDI        R27, 170
	MOV        R4, R27
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1773 :: 		EEPROM_Write(0x15,0); // voltage protector not enabled as default
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1774 :: 		}
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

;Solar_Auto_Switcher.c,1776 :: 		RunTimersNowCheck()
;Solar_Auto_Switcher.c,1779 :: 		if(Increment==1 && Exit==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck867
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck866
L__RunTimersNowCheck863:
;Solar_Auto_Switcher.c,1781 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck563:
	DEC        R16
	BRNE       L_RunTimersNowCheck563
	DEC        R17
	BRNE       L_RunTimersNowCheck563
	DEC        R18
	BRNE       L_RunTimersNowCheck563
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1782 :: 		if (Increment==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck865
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck864
L__RunTimersNowCheck862:
;Solar_Auto_Switcher.c,1784 :: 		RunLoadsByBass++;
	LDS        R16, _RunLoadsByBass+0
	SUBI       R16, 255
	STS        _RunLoadsByBass+0, R16
;Solar_Auto_Switcher.c,1785 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	CPI        R16, 1
	BREQ       L__RunTimersNowCheck1125
	JMP        L_RunTimersNowCheck568
L__RunTimersNowCheck1125:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_RunTimersNowCheck568:
;Solar_Auto_Switcher.c,1786 :: 		if (RunLoadsByBass>=2 )
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 2
	BRSH       L__RunTimersNowCheck1126
	JMP        L_RunTimersNowCheck569
L__RunTimersNowCheck1126:
;Solar_Auto_Switcher.c,1788 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck570:
	DEC        R16
	BRNE       L_RunTimersNowCheck570
	DEC        R17
	BRNE       L_RunTimersNowCheck570
	DEC        R18
	BRNE       L_RunTimersNowCheck570
	NOP
;Solar_Auto_Switcher.c,1789 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1790 :: 		}
L_RunTimersNowCheck569:
;Solar_Auto_Switcher.c,1791 :: 		LCD_OUT(1,15,"B");
	LDI        R27, #lo_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1782 :: 		if (Increment==1 && Exit==0)
L__RunTimersNowCheck865:
L__RunTimersNowCheck864:
;Solar_Auto_Switcher.c,1779 :: 		if(Increment==1 && Exit==0)
L__RunTimersNowCheck867:
L__RunTimersNowCheck866:
;Solar_Auto_Switcher.c,1795 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck873
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck872
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck871
L__RunTimersNowCheck861:
;Solar_Auto_Switcher.c,1797 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck575:
	DEC        R16
	BRNE       L_RunTimersNowCheck575
	DEC        R17
	BRNE       L_RunTimersNowCheck575
	DEC        R18
	BRNE       L_RunTimersNowCheck575
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1798 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck870
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck869
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck868
L__RunTimersNowCheck860:
;Solar_Auto_Switcher.c,1800 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck580:
	DEC        R16
	BRNE       L_RunTimersNowCheck580
	DEC        R17
	BRNE       L_RunTimersNowCheck580
	DEC        R18
	BRNE       L_RunTimersNowCheck580
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1801 :: 		EEPROM_FactorySettings(1);        // summer time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1802 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck582:
	DEC        R16
	BRNE       L_RunTimersNowCheck582
	DEC        R17
	BRNE       L_RunTimersNowCheck582
	DEC        R18
	BRNE       L_RunTimersNowCheck582
;Solar_Auto_Switcher.c,1803 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1804 :: 		LCD_OUT(2,1,"Reset Done   ");
	LDI        R27, #lo_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1805 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck584:
	DEC        R16
	BRNE       L_RunTimersNowCheck584
	DEC        R17
	BRNE       L_RunTimersNowCheck584
	DEC        R18
	BRNE       L_RunTimersNowCheck584
;Solar_Auto_Switcher.c,1806 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1798 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
L__RunTimersNowCheck870:
L__RunTimersNowCheck869:
L__RunTimersNowCheck868:
;Solar_Auto_Switcher.c,1795 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
L__RunTimersNowCheck873:
L__RunTimersNowCheck872:
L__RunTimersNowCheck871:
;Solar_Auto_Switcher.c,1843 :: 		if(Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck877
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck876
L__RunTimersNowCheck859:
;Solar_Auto_Switcher.c,1845 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck589:
	DEC        R16
	BRNE       L_RunTimersNowCheck589
	DEC        R17
	BRNE       L_RunTimersNowCheck589
	DEC        R18
	BRNE       L_RunTimersNowCheck589
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1846 :: 		if (Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck875
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck874
L__RunTimersNowCheck858:
;Solar_Auto_Switcher.c,1848 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,1849 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Auto_Switcher.c,1850 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1851 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1853 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1846 :: 		if (Decrement==1 && Exit==0)
L__RunTimersNowCheck875:
L__RunTimersNowCheck874:
;Solar_Auto_Switcher.c,1843 :: 		if(Decrement==1 && Exit==0)
L__RunTimersNowCheck877:
L__RunTimersNowCheck876:
;Solar_Auto_Switcher.c,1856 :: 		}
L_end_RunTimersNowCheck:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_CheckForSet:

;Solar_Auto_Switcher.c,1859 :: 		void CheckForSet()
;Solar_Auto_Switcher.c,1862 :: 		if (Set==0 && Exit==0) SetUpProgram();
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForSet880
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__CheckForSet879
L__CheckForSet878:
	CALL       _SetUpProgram+0
L__CheckForSet880:
L__CheckForSet879:
;Solar_Auto_Switcher.c,1864 :: 		}
L_end_CheckForSet:
	RET
; end of _CheckForSet

_AutoRunWithOutBatteryProtection:

;Solar_Auto_Switcher.c,1867 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Auto_Switcher.c,1869 :: 		if (Vin_Battery==0)
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
	BREQ       L__AutoRunWithOutBatteryProtection1129
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection1129:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection1130
	JMP        L_AutoRunWithOutBatteryProtection597
L__AutoRunWithOutBatteryProtection1130:
;Solar_Auto_Switcher.c,1871 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1872 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection598
L_AutoRunWithOutBatteryProtection597:
;Solar_Auto_Switcher.c,1875 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1876 :: 		}
L_AutoRunWithOutBatteryProtection598:
;Solar_Auto_Switcher.c,1877 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Auto_Switcher.c,1879 :: 		void CheckForTimerActivationInRange()
;Solar_Auto_Switcher.c,1883 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1132
	JMP        L__CheckForTimerActivationInRange887
L__CheckForTimerActivationInRange1132:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1133
	JMP        L__CheckForTimerActivationInRange886
L__CheckForTimerActivationInRange1133:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1134
	JMP        L__CheckForTimerActivationInRange885
L__CheckForTimerActivationInRange1134:
L__CheckForTimerActivationInRange884:
;Solar_Auto_Switcher.c,1885 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1883 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
L__CheckForTimerActivationInRange887:
L__CheckForTimerActivationInRange886:
L__CheckForTimerActivationInRange885:
;Solar_Auto_Switcher.c,1890 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1135
	JMP        L__CheckForTimerActivationInRange890
L__CheckForTimerActivationInRange1135:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1136
	JMP        L__CheckForTimerActivationInRange889
L__CheckForTimerActivationInRange1136:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1137
	JMP        L__CheckForTimerActivationInRange888
L__CheckForTimerActivationInRange1137:
L__CheckForTimerActivationInRange883:
;Solar_Auto_Switcher.c,1893 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1138
	JMP        L_CheckForTimerActivationInRange605
L__CheckForTimerActivationInRange1138:
;Solar_Auto_Switcher.c,1895 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1897 :: 		}
L_CheckForTimerActivationInRange605:
;Solar_Auto_Switcher.c,1890 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
L__CheckForTimerActivationInRange890:
L__CheckForTimerActivationInRange889:
L__CheckForTimerActivationInRange888:
;Solar_Auto_Switcher.c,1925 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1139
	JMP        L__CheckForTimerActivationInRange893
L__CheckForTimerActivationInRange1139:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1140
	JMP        L__CheckForTimerActivationInRange892
L__CheckForTimerActivationInRange1140:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1141
	JMP        L__CheckForTimerActivationInRange891
L__CheckForTimerActivationInRange1141:
L__CheckForTimerActivationInRange882:
;Solar_Auto_Switcher.c,1927 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1925 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange893:
L__CheckForTimerActivationInRange892:
L__CheckForTimerActivationInRange891:
;Solar_Auto_Switcher.c,1931 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1142
	JMP        L__CheckForTimerActivationInRange896
L__CheckForTimerActivationInRange1142:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1143
	JMP        L__CheckForTimerActivationInRange895
L__CheckForTimerActivationInRange1143:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1144
	JMP        L__CheckForTimerActivationInRange894
L__CheckForTimerActivationInRange1144:
L__CheckForTimerActivationInRange881:
;Solar_Auto_Switcher.c,1933 :: 		if(ReadMinutes()<minutes_lcd_timer2_stop)
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1145
	JMP        L_CheckForTimerActivationInRange612
L__CheckForTimerActivationInRange1145:
;Solar_Auto_Switcher.c,1935 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1937 :: 		}
L_CheckForTimerActivationInRange612:
;Solar_Auto_Switcher.c,1931 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange896:
L__CheckForTimerActivationInRange895:
L__CheckForTimerActivationInRange894:
;Solar_Auto_Switcher.c,1963 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Auto_Switcher.c,1966 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Auto_Switcher.c,1969 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff901
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1147
	JMP        L__TurnLoadsOffWhenGridOff900
L__TurnLoadsOffWhenGridOff1147:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1148
	JMP        L__TurnLoadsOffWhenGridOff899
L__TurnLoadsOffWhenGridOff1148:
L__TurnLoadsOffWhenGridOff898:
;Solar_Auto_Switcher.c,1971 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1972 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1973 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1974 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1969 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__TurnLoadsOffWhenGridOff901:
L__TurnLoadsOffWhenGridOff900:
L__TurnLoadsOffWhenGridOff899:
;Solar_Auto_Switcher.c,1977 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff904
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1149
	JMP        L__TurnLoadsOffWhenGridOff903
L__TurnLoadsOffWhenGridOff1149:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1150
	JMP        L__TurnLoadsOffWhenGridOff902
L__TurnLoadsOffWhenGridOff1150:
L__TurnLoadsOffWhenGridOff897:
;Solar_Auto_Switcher.c,1979 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1980 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1981 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1982 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1977 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__TurnLoadsOffWhenGridOff904:
L__TurnLoadsOffWhenGridOff903:
L__TurnLoadsOffWhenGridOff902:
;Solar_Auto_Switcher.c,1985 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _TurnLoadsOffWhenGridOff

_CheckForVoltageProtection:

;Solar_Auto_Switcher.c,1987 :: 		CheckForVoltageProtection()
;Solar_Auto_Switcher.c,1989 :: 		if (VoltageProtectionEnable==1)  LCD_OUT(1,16,"P"); else LCD_OUT(1,16," ") ;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1152
	JMP        L_CheckForVoltageProtection619
L__CheckForVoltageProtection1152:
	LDI        R27, #lo_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_CheckForVoltageProtection620
L_CheckForVoltageProtection619:
	LDI        R27, #lo_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_CheckForVoltageProtection620:
;Solar_Auto_Switcher.c,1990 :: 		if(Exit==1 && Set==0 )
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection910
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection909
L__CheckForVoltageProtection906:
;Solar_Auto_Switcher.c,1992 :: 		delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_CheckForVoltageProtection624:
	DEC        R16
	BRNE       L_CheckForVoltageProtection624
	DEC        R17
	BRNE       L_CheckForVoltageProtection624
	DEC        R18
	BRNE       L_CheckForVoltageProtection624
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1993 :: 		if(Exit==1 && Set==0 ) {
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection908
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection907
L__CheckForVoltageProtection905:
;Solar_Auto_Switcher.c,1994 :: 		if (VoltageProtectorEnableFlag==1)         // protector as default is enabled so make it not enabled
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1153
	JMP        L_CheckForVoltageProtection629
L__CheckForVoltageProtection1153:
;Solar_Auto_Switcher.c,1996 :: 		VoltageProtectionEnable=0;
	LDI        R27, 0
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,1997 :: 		VoltageProtectorEnableFlag=0;
	LDI        R27, 0
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,1998 :: 		EEPROM_Write(0x15,0);
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1999 :: 		}
	JMP        L_CheckForVoltageProtection630
L_CheckForVoltageProtection629:
;Solar_Auto_Switcher.c,2000 :: 		else if ( VoltageProtectorEnableFlag==0)
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 0
	BREQ       L__CheckForVoltageProtection1154
	JMP        L_CheckForVoltageProtection631
L__CheckForVoltageProtection1154:
;Solar_Auto_Switcher.c,2002 :: 		VoltageProtectionEnable=1;
	LDI        R27, 1
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,2003 :: 		VoltageProtectorEnableFlag=1;
	LDI        R27, 1
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,2004 :: 		EEPROM_Write(0x15,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,2005 :: 		}
L_CheckForVoltageProtection631:
L_CheckForVoltageProtection630:
;Solar_Auto_Switcher.c,1993 :: 		if(Exit==1 && Set==0 ) {
L__CheckForVoltageProtection908:
L__CheckForVoltageProtection907:
;Solar_Auto_Switcher.c,1990 :: 		if(Exit==1 && Set==0 )
L__CheckForVoltageProtection910:
L__CheckForVoltageProtection909:
;Solar_Auto_Switcher.c,2009 :: 		}
L_end_CheckForVoltageProtection:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForVoltageProtection

_CheckForTimerActivationOutRange:

;Solar_Auto_Switcher.c,2011 :: 		CheckForTimerActivationOutRange()
;Solar_Auto_Switcher.c,2014 :: 		if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1156
	JMP        L__CheckForTimerActivationOutRange916
L__CheckForTimerActivationOutRange1156:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1157
	JMP        L__CheckForTimerActivationOutRange915
L__CheckForTimerActivationOutRange1157:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1158
	JMP        L__CheckForTimerActivationOutRange914
L__CheckForTimerActivationOutRange1158:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1159
	JMP        L__CheckForTimerActivationOutRange913
L__CheckForTimerActivationOutRange1159:
L__CheckForTimerActivationOutRange912:
;Solar_Auto_Switcher.c,2016 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,2014 :: 		if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2 )
L__CheckForTimerActivationOutRange916:
L__CheckForTimerActivationOutRange915:
L__CheckForTimerActivationOutRange914:
L__CheckForTimerActivationOutRange913:
;Solar_Auto_Switcher.c,2019 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() >= hours_lcd_timer2_stop && ReadMinutes()>=minutes_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1160
	JMP        L__CheckForTimerActivationOutRange920
L__CheckForTimerActivationOutRange1160:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1161
	JMP        L__CheckForTimerActivationOutRange919
L__CheckForTimerActivationOutRange1161:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1162
	JMP        L__CheckForTimerActivationOutRange918
L__CheckForTimerActivationOutRange1162:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1163
	JMP        L__CheckForTimerActivationOutRange917
L__CheckForTimerActivationOutRange1163:
L__CheckForTimerActivationOutRange911:
;Solar_Auto_Switcher.c,2021 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,2019 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() >= hours_lcd_timer2_stop && ReadMinutes()>=minutes_lcd_timer2_stop )
L__CheckForTimerActivationOutRange920:
L__CheckForTimerActivationOutRange919:
L__CheckForTimerActivationOutRange918:
L__CheckForTimerActivationOutRange917:
;Solar_Auto_Switcher.c,2023 :: 		}
L_end_CheckForTimerActivationOutRange:
	RET
; end of _CheckForTimerActivationOutRange

_InitLCD_EveryHour:

;Solar_Auto_Switcher.c,2025 :: 		void InitLCD_EveryHour(){
;Solar_Auto_Switcher.c,2027 :: 		every30MinutesInitScreen=ReadSeconds();
	PUSH       R2
	CALL       _ReadSeconds+0
	STS        _every30MinutesInitScreen+0, R16
;Solar_Auto_Switcher.c,2028 :: 		if( every30MinutesInitScreen==59  && initedScreenOnce==0  )
	CPI        R16, 59
	BREQ       L__InitLCD_EveryHour1165
	JMP        L__InitLCD_EveryHour923
L__InitLCD_EveryHour1165:
	LDS        R16, _initedScreenOnce+0
	CPI        R16, 0
	BREQ       L__InitLCD_EveryHour1166
	JMP        L__InitLCD_EveryHour922
L__InitLCD_EveryHour1166:
L__InitLCD_EveryHour921:
;Solar_Auto_Switcher.c,2030 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,2031 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,2032 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,2034 :: 		}
	JMP        L_InitLCD_EveryHour641
;Solar_Auto_Switcher.c,2028 :: 		if( every30MinutesInitScreen==59  && initedScreenOnce==0  )
L__InitLCD_EveryHour923:
L__InitLCD_EveryHour922:
;Solar_Auto_Switcher.c,2035 :: 		else if (every30MinutesInitScreen!=59)
	LDS        R16, _every30MinutesInitScreen+0
	CPI        R16, 59
	BRNE       L__InitLCD_EveryHour1167
	JMP        L_InitLCD_EveryHour642
L__InitLCD_EveryHour1167:
;Solar_Auto_Switcher.c,2038 :: 		}
L_InitLCD_EveryHour642:
L_InitLCD_EveryHour641:
;Solar_Auto_Switcher.c,2039 :: 		}
L_end_InitLCD_EveryHour:
	POP        R2
	RET
; end of _InitLCD_EveryHour

_UpdateScreenTimerInit_Timer_2:

;Solar_Auto_Switcher.c,2041 :: 		void UpdateScreenTimerInit_Timer_2()
;Solar_Auto_Switcher.c,2043 :: 		WGM21_bit=1;
	LDS        R27, WGM21_bit+0
	SBR        R27, BitMask(WGM21_bit+0)
	STS        WGM21_bit+0, R27
;Solar_Auto_Switcher.c,2044 :: 		CS20_bit=1; // prescalar 1024
	LDS        R27, CS20_bit+0
	SBR        R27, BitMask(CS20_bit+0)
	STS        CS20_bit+0, R27
;Solar_Auto_Switcher.c,2045 :: 		CS21_bit=1; //prescalar 1024
	LDS        R27, CS21_bit+0
	SBR        R27, BitMask(CS21_bit+0)
	STS        CS21_bit+0, R27
;Solar_Auto_Switcher.c,2046 :: 		CS22_bit=1; //prescalar 1024
	LDS        R27, CS22_bit+0
	SBR        R27, BitMask(CS22_bit+0)
	STS        CS22_bit+0, R27
;Solar_Auto_Switcher.c,2047 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,2048 :: 		OCR2A=0xFF;
	LDI        R27, 255
	STS        OCR2A+0, R27
;Solar_Auto_Switcher.c,2049 :: 		OCIE2A_Bit=1;
	LDS        R27, OCIE2A_bit+0
	SBR        R27, BitMask(OCIE2A_bit+0)
	STS        OCIE2A_bit+0, R27
;Solar_Auto_Switcher.c,2050 :: 		}
L_end_UpdateScreenTimerInit_Timer_2:
	RET
; end of _UpdateScreenTimerInit_Timer_2

_InitScreenTimer:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,2052 :: 		void InitScreenTimer() iv  IVT_ADDR_TIMER2_COMPA
;Solar_Auto_Switcher.c,2054 :: 		UpdateScreenTime++;
	PUSH       R2
	LDS        R16, _UpdateScreenTime+0
	LDS        R17, _UpdateScreenTime+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _UpdateScreenTime+0, R16
	STS        _UpdateScreenTime+1, R17
;Solar_Auto_Switcher.c,2055 :: 		if (UpdateScreenTime==1800)  // 60 seconds to update
	CPI        R17, 7
	BRNE       L__InitScreenTimer1170
	CPI        R16, 8
L__InitScreenTimer1170:
	BREQ       L__InitScreenTimer1171
	JMP        L_InitScreenTimer643
L__InitScreenTimer1171:
;Solar_Auto_Switcher.c,2057 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,2058 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,2059 :: 		UpdateScreenTime=0;
	LDI        R27, 0
	STS        _UpdateScreenTime+0, R27
	STS        _UpdateScreenTime+1, R27
;Solar_Auto_Switcher.c,2060 :: 		}
L_InitScreenTimer643:
;Solar_Auto_Switcher.c,2062 :: 		OCF2A_Bit=1;
	IN         R27, OCF2A_bit+0
	SBR        R27, BitMask(OCF2A_bit+0)
	OUT        OCF2A_bit+0, R27
;Solar_Auto_Switcher.c,2063 :: 		}
L_end_InitScreenTimer:
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _InitScreenTimer

_CheckSystemBatteryMode:

;Solar_Auto_Switcher.c,2065 :: 		void CheckSystemBatteryMode()
;Solar_Auto_Switcher.c,2067 :: 		if (Vin_Battery>= 35 && Vin_Battery <= 60) SystemBatteryMode=48;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 12
	LDI        R23, 66
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1173
	LDI        R16, 1
L__CheckSystemBatteryMode1173:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1174
	JMP        L__CheckSystemBatteryMode928
L__CheckSystemBatteryMode1174:
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 112
	LDI        R23, 66
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_lequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1175
	LDI        R16, 1
L__CheckSystemBatteryMode1175:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1176
	JMP        L__CheckSystemBatteryMode927
L__CheckSystemBatteryMode1176:
L__CheckSystemBatteryMode926:
	LDI        R27, 48
	STS        _SystemBatteryMode+0, R27
	JMP        L_CheckSystemBatteryMode647
L__CheckSystemBatteryMode928:
L__CheckSystemBatteryMode927:
;Solar_Auto_Switcher.c,2068 :: 		else if (Vin_Battery>=18 && Vin_Battery <=32) SystemBatteryMode=24;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 144
	LDI        R23, 65
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1177
	LDI        R16, 1
L__CheckSystemBatteryMode1177:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1178
	JMP        L__CheckSystemBatteryMode930
L__CheckSystemBatteryMode1178:
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 66
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_lequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1179
	LDI        R16, 1
L__CheckSystemBatteryMode1179:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1180
	JMP        L__CheckSystemBatteryMode929
L__CheckSystemBatteryMode1180:
L__CheckSystemBatteryMode925:
	LDI        R27, 24
	STS        _SystemBatteryMode+0, R27
	JMP        L_CheckSystemBatteryMode651
L__CheckSystemBatteryMode930:
L__CheckSystemBatteryMode929:
;Solar_Auto_Switcher.c,2069 :: 		else if (Vin_Battery >=1 && Vin_Battery<= 16 ) SystemBatteryMode=12;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 63
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1181
	LDI        R16, 1
L__CheckSystemBatteryMode1181:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1182
	JMP        L__CheckSystemBatteryMode932
L__CheckSystemBatteryMode1182:
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 65
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_lequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1183
	LDI        R16, 1
L__CheckSystemBatteryMode1183:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1184
	JMP        L__CheckSystemBatteryMode931
L__CheckSystemBatteryMode1184:
L__CheckSystemBatteryMode924:
	LDI        R27, 12
	STS        _SystemBatteryMode+0, R27
	JMP        L_CheckSystemBatteryMode655
L__CheckSystemBatteryMode932:
L__CheckSystemBatteryMode931:
;Solar_Auto_Switcher.c,2070 :: 		else SystemBatteryMode=24; // take it as default
	LDI        R27, 24
	STS        _SystemBatteryMode+0, R27
L_CheckSystemBatteryMode655:
L_CheckSystemBatteryMode651:
L_CheckSystemBatteryMode647:
;Solar_Auto_Switcher.c,2071 :: 		}
L_end_CheckSystemBatteryMode:
	RET
; end of _CheckSystemBatteryMode

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Auto_Switcher.c,2073 :: 		void main() {
;Solar_Auto_Switcher.c,2074 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Auto_Switcher.c,2075 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Auto_Switcher.c,2076 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,2077 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Auto_Switcher.c,2078 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Auto_Switcher.c,2079 :: 		ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
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
;Solar_Auto_Switcher.c,2080 :: 		ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
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
;Solar_Auto_Switcher.c,2081 :: 		ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,2082 :: 		ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,2083 :: 		ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,2084 :: 		ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,2085 :: 		UpdateScreenTimerInit_Timer_2();
	CALL       _UpdateScreenTimerInit_Timer_2+0
;Solar_Auto_Switcher.c,2086 :: 		while(1)
L_main656:
;Solar_Auto_Switcher.c,2089 :: 		CheckSystemBatteryMode();
	CALL       _CheckSystemBatteryMode+0
;Solar_Auto_Switcher.c,2090 :: 		CheckForSet();
	CALL       _CheckForSet+0
;Solar_Auto_Switcher.c,2091 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Auto_Switcher.c,2092 :: 		CheckForTimerActivationOutRange();
	CALL       _CheckForTimerActivationOutRange+0
;Solar_Auto_Switcher.c,2093 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Auto_Switcher.c,2094 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Auto_Switcher.c,2095 :: 		CheckForVoltageProtection();
	CALL       _CheckForVoltageProtection+0
;Solar_Auto_Switcher.c,2096 :: 		Screen_1();
	CALL       _Screen_1+0
;Solar_Auto_Switcher.c,2097 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Auto_Switcher.c,2098 :: 		TurnLoadsOffWhenGridOff();        // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Auto_Switcher.c,2099 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_main658:
	DEC        R16
	BRNE       L_main658
	DEC        R17
	BRNE       L_main658
	DEC        R18
	BRNE       L_main658
;Solar_Auto_Switcher.c,2100 :: 		} // end while
	JMP        L_main656
;Solar_Auto_Switcher.c,2101 :: 		}   // end main
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
