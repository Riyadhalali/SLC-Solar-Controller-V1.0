
_Gpio_Init:

;Solar_Auto_Switcher.c,141 :: 		void Gpio_Init()
;Solar_Auto_Switcher.c,143 :: 		DDRD.B6=1; // Relay_L_Solar set as output
	IN         R27, DDRD+0
	SBR        R27, 64
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,144 :: 		DDRD.B7=1; // Relay_L_Solar_2 set as output
	IN         R27, DDRD+0
	SBR        R27, 128
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,145 :: 		DDRD.B2=0; // Set as input
	IN         R27, DDRD+0
	CBR        R27, 4
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,146 :: 		DDRD.B1=0; // decrement set as input
	IN         R27, DDRD+0
	CBR        R27, 2
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,147 :: 		DDRD.B0=0; // increment set as input
	IN         R27, DDRD+0
	CBR        R27, 1
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,148 :: 		DDRD.B3=0; // set ac_available as input
	IN         R27, DDRD+0
	CBR        R27, 8
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,149 :: 		DDRC.B2=1; // set buzzer as output
	IN         R27, DDRC+0
	SBR        R27, 4
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,150 :: 		DDRC.B0=0;  //SET EXIT AS INPUT
	IN         R27, DDRC+0
	CBR        R27, 1
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,151 :: 		}
L_end_Gpio_Init:
	RET
; end of _Gpio_Init

_Write_Time:

;Solar_Auto_Switcher.c,154 :: 		void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
;Solar_Auto_Switcher.c,156 :: 		write_Ds1307(0x00,seconds);           //seconds
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
;Solar_Auto_Switcher.c,157 :: 		write_Ds1307(0x01,minutes);          // minutes
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,158 :: 		write_Ds1307(0x02,hours); // using the 24 hour system
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,159 :: 		}
L_end_Write_Time:
	POP        R3
	POP        R2
	RET
; end of _Write_Time

_Write_Date:

;Solar_Auto_Switcher.c,162 :: 		void Write_Date(unsigned int day, unsigned int month,unsigned int year)
;Solar_Auto_Switcher.c,164 :: 		write_Ds1307(0x04,day);          //01-31
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
;Solar_Auto_Switcher.c,165 :: 		Write_Ds1307(0x05,month);       //01-12
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,166 :: 		Write_Ds1307(0x06,year);       // 00-99
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,167 :: 		}
L_end_Write_Date:
	POP        R3
	POP        R2
	RET
; end of _Write_Date

_Config:

;Solar_Auto_Switcher.c,169 :: 		void Config()
;Solar_Auto_Switcher.c,171 :: 		GPIO_Init();
	PUSH       R2
	CALL       _Gpio_Init+0
;Solar_Auto_Switcher.c,172 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,173 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,174 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,176 :: 		Delay_ms(1000);
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
;Solar_Auto_Switcher.c,177 :: 		}
L_end_Config:
	POP        R2
	RET
; end of _Config

_LCD_Clear:

;Solar_Auto_Switcher.c,180 :: 		void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
;Solar_Auto_Switcher.c,183 :: 		for(Column=Start; Column<=End; Column++)
; Column start address is: 17 (R17)
	MOV        R17, R3
; Column end address is: 17 (R17)
L_LCD_Clear2:
; Column start address is: 17 (R17)
	CP         R4, R17
	BRSH       L__LCD_Clear919
	JMP        L_LCD_Clear3
L__LCD_Clear919:
;Solar_Auto_Switcher.c,185 :: 		Lcd_Chr(Row,Column,32);
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
;Solar_Auto_Switcher.c,183 :: 		for(Column=Start; Column<=End; Column++)
	MOV        R16, R17
	SUBI       R16, 255
	MOV        R17, R16
;Solar_Auto_Switcher.c,186 :: 		}
; Column end address is: 17 (R17)
	JMP        L_LCD_Clear2
L_LCD_Clear3:
;Solar_Auto_Switcher.c,187 :: 		}
L_end_LCD_Clear:
	RET
; end of _LCD_Clear

_Config_Interrupts:

;Solar_Auto_Switcher.c,190 :: 		void Config_Interrupts()
;Solar_Auto_Switcher.c,192 :: 		ISC10_bit=1;   // Config The rising edge of INT0 generates an interrupt request.
	LDS        R27, ISC10_bit+0
	SBR        R27, BitMask(ISC10_bit+0)
	STS        ISC10_bit+0, R27
;Solar_Auto_Switcher.c,193 :: 		ISC11_bit=1;
	LDS        R27, ISC11_bit+0
	SBR        R27, BitMask(ISC11_bit+0)
	STS        ISC11_bit+0, R27
;Solar_Auto_Switcher.c,194 :: 		INT1_bit=1;
	IN         R27, INT1_bit+0
	SBR        R27, BitMask(INT1_bit+0)
	OUT        INT1_bit+0, R27
;Solar_Auto_Switcher.c,195 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,196 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_Interrupt_INT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,200 :: 		void Interrupt_INT1 () iv IVT_ADDR_INT1
;Solar_Auto_Switcher.c,202 :: 		AcBuzzerActiveTimes=0; // FOR ACTIVING BUZZER ONCE AGAIN
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,204 :: 		if(AC_Available==1 && Timer_isOn==0  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1658
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1922
	JMP        L__Interrupt_INT1657
L__Interrupt_INT1922:
L__Interrupt_INT1656:
;Solar_Auto_Switcher.c,208 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,209 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,210 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,204 :: 		if(AC_Available==1 && Timer_isOn==0  )
L__Interrupt_INT1658:
L__Interrupt_INT1657:
;Solar_Auto_Switcher.c,213 :: 		if (AC_Available==1 && Timer_2_isOn==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1660
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1923
	JMP        L__Interrupt_INT1659
L__Interrupt_INT1923:
L__Interrupt_INT1655:
;Solar_Auto_Switcher.c,217 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,218 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,219 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,213 :: 		if (AC_Available==1 && Timer_2_isOn==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__Interrupt_INT1660:
L__Interrupt_INT1659:
;Solar_Auto_Switcher.c,221 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,222 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,223 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,224 :: 		INTF1_bit=1;     //clear  flag
	IN         R27, INTF1_bit+0
	SBR        R27, BitMask(INTF1_bit+0)
	OUT        INTF1_bit+0, R27
;Solar_Auto_Switcher.c,225 :: 		}
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

;Solar_Auto_Switcher.c,228 :: 		void EEPROM_Load()
;Solar_Auto_Switcher.c,231 :: 		hours_lcd_1=EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,232 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,233 :: 		hours_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,234 :: 		minutes_lcd_2=EEPROM_Read(0x04);
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,236 :: 		hours_lcd_timer2_start=EEPROM_Read(0x18);
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,237 :: 		minutes_lcd_timer2_start=EEPROM_Read(0x19);
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,238 :: 		hours_lcd_timer2_stop=EEPROM_Read(0x20);
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,239 :: 		minutes_lcd_timer2_stop=EEPROM_Read(0x21);
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,242 :: 		ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
	LDI        R27, 0
	STS        _ByPassState+0, R27
;Solar_Auto_Switcher.c,244 :: 		Timer_Enable=1;      // delete function to be programmed for rom space
	LDI        R27, 1
	STS        _Timer_Enable+0, R27
;Solar_Auto_Switcher.c,245 :: 		High_Voltage=EEPROM_Read(0x12); // load high voltage
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _High_Voltage+0, R16
	LDI        R27, 0
	STS        _High_Voltage+1, R27
;Solar_Auto_Switcher.c,246 :: 		Low_Voltage=EEPROM_Read(0x13); // load low voltage
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Low_Voltage+0, R16
	LDI        R27, 0
	STS        _Low_Voltage+1, R27
;Solar_Auto_Switcher.c,247 :: 		VoltageProtectionEnable=EEPROM_Read(0x15);
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _VoltageProtectionEnable+0, R16
;Solar_Auto_Switcher.c,251 :: 		}
L_end_EEPROM_Load:
	POP        R3
	POP        R2
	RET
; end of _EEPROM_Load

_StoreBytesIntoEEprom:

;Solar_Auto_Switcher.c,254 :: 		void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,257 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_StoreBytesIntoEEprom11:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__StoreBytesIntoEEprom926
	JMP        L_StoreBytesIntoEEprom12
L__StoreBytesIntoEEprom926:
;Solar_Auto_Switcher.c,259 :: 		EEprom_Write(address+j,*(ptr+j));
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
;Solar_Auto_Switcher.c,260 :: 		Delay_ms(50);
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
;Solar_Auto_Switcher.c,257 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,261 :: 		};
; j end address is: 19 (R19)
	JMP        L_StoreBytesIntoEEprom11
L_StoreBytesIntoEEprom12:
;Solar_Auto_Switcher.c,262 :: 		}
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

;Solar_Auto_Switcher.c,265 :: 		void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,268 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_ReadBytesFromEEprom16:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__ReadBytesFromEEprom928
	JMP        L_ReadBytesFromEEprom17
L__ReadBytesFromEEprom928:
;Solar_Auto_Switcher.c,270 :: 		*(ptr+j)=EEPROM_Read(address+j);
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
;Solar_Auto_Switcher.c,271 :: 		Delay_ms(50);
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
;Solar_Auto_Switcher.c,268 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,272 :: 		}
; j end address is: 19 (R19)
	JMP        L_ReadBytesFromEEprom16
L_ReadBytesFromEEprom17:
;Solar_Auto_Switcher.c,273 :: 		}
L_end_ReadBytesFromEEprom:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ReadBytesFromEEprom

_Check_Timers:

;Solar_Auto_Switcher.c,276 :: 		void Check_Timers()
;Solar_Auto_Switcher.c,279 :: 		matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R4, _hours_lcd_1+0
	LDS        R3, _minutes_lcd_1+0
	LDS        R2, _seconds_lcd_1+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_1_start+0, R16
;Solar_Auto_Switcher.c,280 :: 		matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
	LDS        R4, _hours_lcd_2+0
	LDS        R3, _minutes_lcd_2+0
	LDS        R2, _seconds_lcd_2+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_1_stop+0, R16
;Solar_Auto_Switcher.c,281 :: 		matched_timer_2_start=CheckTimeOccuredOn(seconds_lcd_timer2_start,minutes_lcd_timer2_start,hours_lcd_timer2_start);
	LDS        R4, _hours_lcd_timer2_start+0
	LDS        R3, _minutes_lcd_timer2_start+0
	LDS        R2, _seconds_lcd_timer2_start+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_2_start+0, R16
;Solar_Auto_Switcher.c,282 :: 		matched_timer_2_stop=CheckTimeOccuredOff(seconds_lcd_timer2_stop,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
	LDS        R4, _hours_lcd_timer2_stop+0
	LDS        R3, _minutes_lcd_timer2_stop+0
	LDS        R2, _seconds_lcd_timer2_stop+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_2_stop+0, R16
;Solar_Auto_Switcher.c,285 :: 		if (matched_timer_1_start==1)
	LDS        R16, _matched_timer_1_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers930
	JMP        L_Check_Timers21
L__Check_Timers930:
;Solar_Auto_Switcher.c,287 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,288 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,289 :: 		EEPROM_write(0x49,1);        //- save it to eeprom if power is cut
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,292 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers687
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers931
	JMP        L__Check_Timers686
L__Check_Timers931:
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
	BREQ       L__Check_Timers932
	LDI        R16, 1
L__Check_Timers932:
	TST        R16
	BRNE       L__Check_Timers933
	JMP        L__Check_Timers685
L__Check_Timers933:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers934
	JMP        L__Check_Timers684
L__Check_Timers934:
L__Check_Timers683:
;Solar_Auto_Switcher.c,294 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,292 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
L__Check_Timers687:
L__Check_Timers686:
L__Check_Timers685:
L__Check_Timers684:
;Solar_Auto_Switcher.c,298 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers690
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers935
	JMP        L__Check_Timers689
L__Check_Timers935:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers936
	JMP        L__Check_Timers688
L__Check_Timers936:
L__Check_Timers682:
;Solar_Auto_Switcher.c,300 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,298 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers690:
L__Check_Timers689:
L__Check_Timers688:
;Solar_Auto_Switcher.c,302 :: 		} // end if ac_available
L_Check_Timers21:
;Solar_Auto_Switcher.c,305 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers937
	JMP        L_Check_Timers28
L__Check_Timers937:
;Solar_Auto_Switcher.c,307 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,308 :: 		EEPROM_write(0x49,0);        //- save it to eeprom if power is cut
	CLR        R4
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,310 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers693
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers938
	JMP        L__Check_Timers692
L__Check_Timers938:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers939
	JMP        L__Check_Timers691
L__Check_Timers939:
L__Check_Timers681:
;Solar_Auto_Switcher.c,313 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,314 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,310 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
L__Check_Timers693:
L__Check_Timers692:
L__Check_Timers691:
;Solar_Auto_Switcher.c,317 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers696
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers940
	JMP        L__Check_Timers695
L__Check_Timers940:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers941
	JMP        L__Check_Timers694
L__Check_Timers941:
L__Check_Timers680:
;Solar_Auto_Switcher.c,320 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,321 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,317 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
L__Check_Timers696:
L__Check_Timers695:
L__Check_Timers694:
;Solar_Auto_Switcher.c,323 :: 		}
L_Check_Timers28:
;Solar_Auto_Switcher.c,327 :: 		if (matched_timer_2_start==1)
	LDS        R16, _matched_timer_2_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers942
	JMP        L_Check_Timers35
L__Check_Timers942:
;Solar_Auto_Switcher.c,329 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,330 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,331 :: 		EEPROM_write(0x50,1);        //- save it to eeprom if power is cut
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,333 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers700
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers943
	JMP        L__Check_Timers699
L__Check_Timers943:
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
	BREQ       L__Check_Timers944
	LDI        R16, 1
L__Check_Timers944:
	TST        R16
	BRNE       L__Check_Timers945
	JMP        L__Check_Timers698
L__Check_Timers945:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers946
	JMP        L__Check_Timers697
L__Check_Timers946:
L__Check_Timers679:
;Solar_Auto_Switcher.c,335 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,333 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
L__Check_Timers700:
L__Check_Timers699:
L__Check_Timers698:
L__Check_Timers697:
;Solar_Auto_Switcher.c,339 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers703
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers947
	JMP        L__Check_Timers702
L__Check_Timers947:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers948
	JMP        L__Check_Timers701
L__Check_Timers948:
L__Check_Timers678:
;Solar_Auto_Switcher.c,341 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,339 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
L__Check_Timers703:
L__Check_Timers702:
L__Check_Timers701:
;Solar_Auto_Switcher.c,344 :: 		} // end if ac_available
L_Check_Timers35:
;Solar_Auto_Switcher.c,347 :: 		if (matched_timer_2_stop==1)
	LDS        R16, _matched_timer_2_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers949
	JMP        L_Check_Timers42
L__Check_Timers949:
;Solar_Auto_Switcher.c,349 :: 		Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,350 :: 		EEPROM_write(0x50,0);        //- save it to eeprom if power is cut
	CLR        R4
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,352 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers706
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers950
	JMP        L__Check_Timers705
L__Check_Timers950:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers951
	JMP        L__Check_Timers704
L__Check_Timers951:
L__Check_Timers677:
;Solar_Auto_Switcher.c,356 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,357 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,358 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,352 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
L__Check_Timers706:
L__Check_Timers705:
L__Check_Timers704:
;Solar_Auto_Switcher.c,361 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers709
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers952
	JMP        L__Check_Timers708
L__Check_Timers952:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers953
	JMP        L__Check_Timers707
L__Check_Timers953:
L__Check_Timers676:
;Solar_Auto_Switcher.c,363 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,364 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,361 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers709:
L__Check_Timers708:
L__Check_Timers707:
;Solar_Auto_Switcher.c,367 :: 		} // end match timer stop
L_Check_Timers42:
;Solar_Auto_Switcher.c,372 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers717
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers954
	JMP        L__Check_Timers716
L__Check_Timers954:
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 1
	BREQ       L__Check_Timers955
	JMP        L__Check_Timers715
L__Check_Timers955:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers956
	JMP        L__Check_Timers714
L__Check_Timers956:
L__Check_Timers675:
;Solar_Auto_Switcher.c,375 :: 		Delay_ms(500);       // for error to get one seconds approxmiallty
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
;Solar_Auto_Switcher.c,378 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers957
	JMP        L__Check_Timers711
L__Check_Timers957:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers710
L__Check_Timers674:
;Solar_Auto_Switcher.c,381 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,378 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers711:
L__Check_Timers710:
;Solar_Auto_Switcher.c,384 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers958
	JMP        L__Check_Timers713
L__Check_Timers958:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers712
L__Check_Timers673:
;Solar_Auto_Switcher.c,386 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,384 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers713:
L__Check_Timers712:
;Solar_Auto_Switcher.c,389 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,372 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
L__Check_Timers717:
L__Check_Timers716:
L__Check_Timers715:
L__Check_Timers714:
;Solar_Auto_Switcher.c,395 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers720
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Check_Timers959
	JMP        L__Check_Timers719
L__Check_Timers959:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers960
	JMP        L__Check_Timers718
L__Check_Timers960:
L__Check_Timers672:
;Solar_Auto_Switcher.c,397 :: 		Start_Timer_0_A();         // give some time ac grid to stabilize
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,395 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
L__Check_Timers720:
L__Check_Timers719:
L__Check_Timers718:
;Solar_Auto_Switcher.c,400 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers723
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers961
	JMP        L__Check_Timers722
L__Check_Timers961:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers962
	JMP        L__Check_Timers721
L__Check_Timers962:
L__Check_Timers671:
;Solar_Auto_Switcher.c,402 :: 		LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,400 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
L__Check_Timers723:
L__Check_Timers722:
L__Check_Timers721:
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers729
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__Check_Timers963
	JMP        L__Check_Timers728
L__Check_Timers963:
L__Check_Timers670:
;Solar_Auto_Switcher.c,408 :: 		Delay_ms(500);       // for error to get one seconds approxmiallty
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Check_Timers69:
	DEC        R16
	BRNE       L_Check_Timers69
	DEC        R17
	BRNE       L_Check_Timers69
	DEC        R18
	BRNE       L_Check_Timers69
	NOP
;Solar_Auto_Switcher.c,409 :: 		SecondsRealTime++;
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _SecondsRealTime+0, R18
	STS        _SecondsRealTime+1, R19
;Solar_Auto_Switcher.c,411 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers964
	JMP        L__Check_Timers725
L__Check_Timers964:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers724
L__Check_Timers669:
;Solar_Auto_Switcher.c,414 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,411 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers725:
L__Check_Timers724:
;Solar_Auto_Switcher.c,417 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers965
	JMP        L__Check_Timers727
L__Check_Timers965:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers726
L__Check_Timers668:
;Solar_Auto_Switcher.c,420 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,417 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers727:
L__Check_Timers726:
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
L__Check_Timers729:
L__Check_Timers728:
;Solar_Auto_Switcher.c,431 :: 		if (AC_Available==0 && SecondsRealTime==startupTIme_2)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers731
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BREQ       L__Check_Timers966
	JMP        L__Check_Timers730
L__Check_Timers966:
L__Check_Timers667:
;Solar_Auto_Switcher.c,433 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,434 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,435 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,431 :: 		if (AC_Available==0 && SecondsRealTime==startupTIme_2)
L__Check_Timers731:
L__Check_Timers730:
;Solar_Auto_Switcher.c,443 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers736
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers967
	JMP        L__Check_Timers735
L__Check_Timers967:
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
	BREQ       L__Check_Timers968
	LDI        R16, 1
L__Check_Timers968:
	TST        R16
	BRNE       L__Check_Timers969
	JMP        L__Check_Timers734
L__Check_Timers969:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers970
	JMP        L__Check_Timers733
L__Check_Timers970:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers971
	JMP        L__Check_Timers732
L__Check_Timers971:
L__Check_Timers666:
;Solar_Auto_Switcher.c,445 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,446 :: 		Delay_ms(400);
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
;Solar_Auto_Switcher.c,447 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers972
	JMP        L_Check_Timers85
L__Check_Timers972:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers85:
;Solar_Auto_Switcher.c,443 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
L__Check_Timers736:
L__Check_Timers735:
L__Check_Timers734:
L__Check_Timers733:
L__Check_Timers732:
;Solar_Auto_Switcher.c,450 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers740
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers973
	JMP        L__Check_Timers739
L__Check_Timers973:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers974
	JMP        L__Check_Timers738
L__Check_Timers974:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers975
	JMP        L__Check_Timers737
L__Check_Timers975:
L__Check_Timers665:
;Solar_Auto_Switcher.c,452 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,453 :: 		Delay_ms(400);
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
;Solar_Auto_Switcher.c,454 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers976
	JMP        L_Check_Timers91
L__Check_Timers976:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers91:
;Solar_Auto_Switcher.c,450 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
L__Check_Timers740:
L__Check_Timers739:
L__Check_Timers738:
L__Check_Timers737:
;Solar_Auto_Switcher.c,458 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers745
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers977
	JMP        L__Check_Timers744
L__Check_Timers977:
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
	BREQ       L__Check_Timers978
	LDI        R16, 1
L__Check_Timers978:
	TST        R16
	BRNE       L__Check_Timers979
	JMP        L__Check_Timers743
L__Check_Timers979:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers980
	JMP        L__Check_Timers742
L__Check_Timers980:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers981
	JMP        L__Check_Timers741
L__Check_Timers981:
L__Check_Timers664:
;Solar_Auto_Switcher.c,460 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,461 :: 		Delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_Check_Timers95:
	DEC        R16
	BRNE       L_Check_Timers95
	DEC        R17
	BRNE       L_Check_Timers95
	DEC        R18
	BRNE       L_Check_Timers95
;Solar_Auto_Switcher.c,462 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers982
	JMP        L_Check_Timers97
L__Check_Timers982:
;Solar_Auto_Switcher.c,463 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers97:
;Solar_Auto_Switcher.c,458 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
L__Check_Timers745:
L__Check_Timers744:
L__Check_Timers743:
L__Check_Timers742:
L__Check_Timers741:
;Solar_Auto_Switcher.c,466 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers749
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers983
	JMP        L__Check_Timers748
L__Check_Timers983:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers984
	JMP        L__Check_Timers747
L__Check_Timers984:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers985
	JMP        L__Check_Timers746
L__Check_Timers985:
L__Check_Timers663:
;Solar_Auto_Switcher.c,468 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,469 :: 		Delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_Check_Timers101:
	DEC        R16
	BRNE       L_Check_Timers101
	DEC        R17
	BRNE       L_Check_Timers101
	DEC        R18
	BRNE       L_Check_Timers101
;Solar_Auto_Switcher.c,470 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers986
	JMP        L_Check_Timers103
L__Check_Timers986:
;Solar_Auto_Switcher.c,471 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers103:
;Solar_Auto_Switcher.c,466 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
L__Check_Timers749:
L__Check_Timers748:
L__Check_Timers747:
L__Check_Timers746:
;Solar_Auto_Switcher.c,475 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers987
	LDI        R16, 1
L__Check_Timers987:
	TST        R16
	BRNE       L__Check_Timers988
	JMP        L__Check_Timers753
L__Check_Timers988:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers752
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers989
	JMP        L__Check_Timers751
L__Check_Timers989:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers990
	JMP        L__Check_Timers750
L__Check_Timers990:
L__Check_Timers662:
;Solar_Auto_Switcher.c,477 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,478 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,475 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
L__Check_Timers753:
L__Check_Timers752:
L__Check_Timers751:
L__Check_Timers750:
;Solar_Auto_Switcher.c,482 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers991
	LDI        R16, 1
L__Check_Timers991:
	TST        R16
	BRNE       L__Check_Timers992
	JMP        L__Check_Timers757
L__Check_Timers992:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers756
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers993
	JMP        L__Check_Timers755
L__Check_Timers993:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers994
	JMP        L__Check_Timers754
L__Check_Timers994:
L__Check_Timers661:
;Solar_Auto_Switcher.c,484 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,485 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,482 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
L__Check_Timers757:
L__Check_Timers756:
L__Check_Timers755:
L__Check_Timers754:
;Solar_Auto_Switcher.c,503 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_GetVoltageNow:

;Solar_Auto_Switcher.c,506 :: 		void GetVoltageNow()
;Solar_Auto_Switcher.c,508 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,509 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,510 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,511 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,512 :: 		}
L_end_GetVoltageNow:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _GetVoltageNow

_ToggleBuzzer:

;Solar_Auto_Switcher.c,514 :: 		void ToggleBuzzer()
;Solar_Auto_Switcher.c,516 :: 		if (AcBuzzerActiveTimes==0)
	LDS        R16, _AcBuzzerActiveTimes+0
	CPI        R16, 0
	BREQ       L__ToggleBuzzer997
	JMP        L_ToggleBuzzer110
L__ToggleBuzzer997:
;Solar_Auto_Switcher.c,518 :: 		AcBuzzerActiveTimes =1 ;
	LDI        R27, 1
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,519 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,520 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_ToggleBuzzer111:
	DEC        R16
	BRNE       L_ToggleBuzzer111
	DEC        R17
	BRNE       L_ToggleBuzzer111
	DEC        R18
	BRNE       L_ToggleBuzzer111
;Solar_Auto_Switcher.c,521 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,522 :: 		}
L_ToggleBuzzer110:
;Solar_Auto_Switcher.c,523 :: 		}
L_end_ToggleBuzzer:
	RET
; end of _ToggleBuzzer

_Interrupt_Routine:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,525 :: 		void Interrupt_Routine () iv IVT_ADDR_INT0
;Solar_Auto_Switcher.c,528 :: 		Delay_ms(100);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Interrupt_Routine113:
	DEC        R16
	BRNE       L_Interrupt_Routine113
	DEC        R17
	BRNE       L_Interrupt_Routine113
	DEC        R18
	BRNE       L_Interrupt_Routine113
;Solar_Auto_Switcher.c,529 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,530 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Interrupt_Routine115
;Solar_Auto_Switcher.c,531 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
L_Interrupt_Routine115:
;Solar_Auto_Switcher.c,532 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,533 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,534 :: 		}
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

;Solar_Auto_Switcher.c,537 :: 		void SetUpProgram()
;Solar_Auto_Switcher.c,539 :: 		Delay_ms(100);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetUpProgram116:
	DEC        R16
	BRNE       L_SetUpProgram116
	DEC        R17
	BRNE       L_SetUpProgram116
	DEC        R18
	BRNE       L_SetUpProgram116
;Solar_Auto_Switcher.c,541 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_SetUpProgram118
;Solar_Auto_Switcher.c,543 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,544 :: 		LCD_OUT(1,1,"Setup Program");
	LDI        R27, #lo_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,545 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetUpProgram119:
	DEC        R16
	BRNE       L_SetUpProgram119
	DEC        R17
	BRNE       L_SetUpProgram119
	DEC        R18
	BRNE       L_SetUpProgram119
;Solar_Auto_Switcher.c,548 :: 		while (Set==1 )
L_SetUpProgram121:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetUpProgram122
;Solar_Auto_Switcher.c,551 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Auto_Switcher.c,552 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram123
	JMP        L_SetUpProgram122
L_SetUpProgram123:
;Solar_Auto_Switcher.c,553 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Auto_Switcher.c,554 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram124
	JMP        L_SetUpProgram122
L_SetUpProgram124:
;Solar_Auto_Switcher.c,555 :: 		SetTimerOn_2();
	CALL       _SetTimerOn_2+0
;Solar_Auto_Switcher.c,556 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram125
	JMP        L_SetUpProgram122
L_SetUpProgram125:
;Solar_Auto_Switcher.c,557 :: 		SetTimerOff_2();
	CALL       _SetTimerOff_2+0
;Solar_Auto_Switcher.c,558 :: 		if (Exit==1) break ;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram126
	JMP        L_SetUpProgram122
L_SetUpProgram126:
;Solar_Auto_Switcher.c,559 :: 		SetLowBatteryVoltage();// program 5 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Auto_Switcher.c,560 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram127
	JMP        L_SetUpProgram122
L_SetUpProgram127:
;Solar_Auto_Switcher.c,561 :: 		SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Auto_Switcher.c,562 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram128
	JMP        L_SetUpProgram122
L_SetUpProgram128:
;Solar_Auto_Switcher.c,564 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram129
	JMP        L_SetUpProgram122
L_SetUpProgram129:
;Solar_Auto_Switcher.c,566 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram130
	JMP        L_SetUpProgram122
L_SetUpProgram130:
;Solar_Auto_Switcher.c,567 :: 		SetDS1307_Time();    // program 10
	CALL       _SetDS1307_Time+0
;Solar_Auto_Switcher.c,573 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Auto_Switcher.c,574 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram131
	JMP        L_SetUpProgram122
L_SetUpProgram131:
;Solar_Auto_Switcher.c,579 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,581 :: 		} // end while
	JMP        L_SetUpProgram121
L_SetUpProgram122:
;Solar_Auto_Switcher.c,582 :: 		}    // end main if
L_SetUpProgram118:
;Solar_Auto_Switcher.c,583 :: 		}
L_end_SetUpProgram:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Auto_Switcher.c,586 :: 		void SetTimerOn_1()
;Solar_Auto_Switcher.c,588 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,589 :: 		LCD_OUT(1,1,"T1 On: [1]");
	LDI        R27, #lo_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,590 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1132:
	DEC        R16
	BRNE       L_SetTimerOn_1132
	DEC        R17
	BRNE       L_SetTimerOn_1132
	DEC        R18
	BRNE       L_SetTimerOn_1132
;Solar_Auto_Switcher.c,591 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,592 :: 		while (Set==1)
L_SetTimerOn_1134:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1135
;Solar_Auto_Switcher.c,598 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,599 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,600 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,601 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,603 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1136
;Solar_Auto_Switcher.c,605 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,606 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1135
;Solar_Auto_Switcher.c,607 :: 		}
L_SetTimerOn_1136:
;Solar_Auto_Switcher.c,610 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1137:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1762
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1761
	JMP        L_SetTimerOn_1138
L__SetTimerOn_1762:
L__SetTimerOn_1761:
;Solar_Auto_Switcher.c,612 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1141
;Solar_Auto_Switcher.c,614 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1142:
	DEC        R16
	BRNE       L_SetTimerOn_1142
	DEC        R17
	BRNE       L_SetTimerOn_1142
	DEC        R18
	BRNE       L_SetTimerOn_1142
	NOP
;Solar_Auto_Switcher.c,615 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,616 :: 		}
L_SetTimerOn_1141:
;Solar_Auto_Switcher.c,617 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1144
;Solar_Auto_Switcher.c,619 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1145:
	DEC        R16
	BRNE       L_SetTimerOn_1145
	DEC        R17
	BRNE       L_SetTimerOn_1145
	DEC        R18
	BRNE       L_SetTimerOn_1145
	NOP
;Solar_Auto_Switcher.c,620 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,621 :: 		}
L_SetTimerOn_1144:
;Solar_Auto_Switcher.c,623 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_11001
	JMP        L_SetTimerOn_1147
L__SetTimerOn_11001:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1147:
;Solar_Auto_Switcher.c,624 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11002
	JMP        L_SetTimerOn_1148
L__SetTimerOn_11002:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1148:
;Solar_Auto_Switcher.c,625 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_1137
L_SetTimerOn_1138:
;Solar_Auto_Switcher.c,626 :: 		} // end first while
	JMP        L_SetTimerOn_1134
L_SetTimerOn_1135:
;Solar_Auto_Switcher.c,628 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_1149:
	DEC        R16
	BRNE       L_SetTimerOn_1149
	DEC        R17
	BRNE       L_SetTimerOn_1149
	DEC        R18
	BRNE       L_SetTimerOn_1149
;Solar_Auto_Switcher.c,629 :: 		while (Set==1)
L_SetTimerOn_1151:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1152
;Solar_Auto_Switcher.c,631 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,633 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,637 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1153
;Solar_Auto_Switcher.c,639 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,640 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1152
;Solar_Auto_Switcher.c,641 :: 		}
L_SetTimerOn_1153:
;Solar_Auto_Switcher.c,643 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1154:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1764
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1763
	JMP        L_SetTimerOn_1155
L__SetTimerOn_1764:
L__SetTimerOn_1763:
;Solar_Auto_Switcher.c,645 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1158
;Solar_Auto_Switcher.c,647 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1159:
	DEC        R16
	BRNE       L_SetTimerOn_1159
	DEC        R17
	BRNE       L_SetTimerOn_1159
	DEC        R18
	BRNE       L_SetTimerOn_1159
	NOP
;Solar_Auto_Switcher.c,648 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,649 :: 		}
L_SetTimerOn_1158:
;Solar_Auto_Switcher.c,650 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1161
;Solar_Auto_Switcher.c,652 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1162:
	DEC        R16
	BRNE       L_SetTimerOn_1162
	DEC        R17
	BRNE       L_SetTimerOn_1162
	DEC        R18
	BRNE       L_SetTimerOn_1162
	NOP
;Solar_Auto_Switcher.c,653 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,654 :: 		}
L_SetTimerOn_1161:
;Solar_Auto_Switcher.c,656 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_11003
	JMP        L_SetTimerOn_1164
L__SetTimerOn_11003:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1164:
;Solar_Auto_Switcher.c,657 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11004
	JMP        L_SetTimerOn_1165
L__SetTimerOn_11004:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1165:
;Solar_Auto_Switcher.c,658 :: 		} // end while increment
	JMP        L_SetTimerOn_1154
L_SetTimerOn_1155:
;Solar_Auto_Switcher.c,659 :: 		} // end first while
	JMP        L_SetTimerOn_1151
L_SetTimerOn_1152:
;Solar_Auto_Switcher.c,661 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,662 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,663 :: 		}
L_end_SetTimerOn_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Auto_Switcher.c,665 :: 		void SetTimerOff_1()
;Solar_Auto_Switcher.c,667 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,668 :: 		LCD_OUT(1,1,"T1 Off: [2]");
	LDI        R27, #lo_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,669 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,670 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1166:
	DEC        R16
	BRNE       L_SetTimerOff_1166
	DEC        R17
	BRNE       L_SetTimerOff_1166
	DEC        R18
	BRNE       L_SetTimerOff_1166
	NOP
;Solar_Auto_Switcher.c,671 :: 		while (Set==1)
L_SetTimerOff_1168:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1169
;Solar_Auto_Switcher.c,677 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,678 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,679 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,680 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,681 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1170
;Solar_Auto_Switcher.c,683 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,684 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1169
;Solar_Auto_Switcher.c,685 :: 		}
L_SetTimerOff_1170:
;Solar_Auto_Switcher.c,687 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1171:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1768
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1767
	JMP        L_SetTimerOff_1172
L__SetTimerOff_1768:
L__SetTimerOff_1767:
;Solar_Auto_Switcher.c,690 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1175
;Solar_Auto_Switcher.c,692 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1176:
	DEC        R16
	BRNE       L_SetTimerOff_1176
	DEC        R17
	BRNE       L_SetTimerOff_1176
	DEC        R18
	BRNE       L_SetTimerOff_1176
	NOP
;Solar_Auto_Switcher.c,693 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,694 :: 		}
L_SetTimerOff_1175:
;Solar_Auto_Switcher.c,695 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1178
;Solar_Auto_Switcher.c,697 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1179:
	DEC        R16
	BRNE       L_SetTimerOff_1179
	DEC        R17
	BRNE       L_SetTimerOff_1179
	DEC        R18
	BRNE       L_SetTimerOff_1179
	NOP
;Solar_Auto_Switcher.c,698 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,699 :: 		}
L_SetTimerOff_1178:
;Solar_Auto_Switcher.c,701 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_11006
	JMP        L_SetTimerOff_1181
L__SetTimerOff_11006:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1181:
;Solar_Auto_Switcher.c,702 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11007
	JMP        L_SetTimerOff_1182
L__SetTimerOff_11007:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1182:
;Solar_Auto_Switcher.c,704 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1171
L_SetTimerOff_1172:
;Solar_Auto_Switcher.c,705 :: 		} // end first while
	JMP        L_SetTimerOff_1168
L_SetTimerOff_1169:
;Solar_Auto_Switcher.c,707 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1183:
	DEC        R16
	BRNE       L_SetTimerOff_1183
	DEC        R17
	BRNE       L_SetTimerOff_1183
	DEC        R18
	BRNE       L_SetTimerOff_1183
	NOP
;Solar_Auto_Switcher.c,708 :: 		while (Set==1)
L_SetTimerOff_1185:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1186
;Solar_Auto_Switcher.c,710 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,712 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,716 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1187
;Solar_Auto_Switcher.c,718 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,719 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1186
;Solar_Auto_Switcher.c,720 :: 		}
L_SetTimerOff_1187:
;Solar_Auto_Switcher.c,722 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1188:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1770
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1769
	JMP        L_SetTimerOff_1189
L__SetTimerOff_1770:
L__SetTimerOff_1769:
;Solar_Auto_Switcher.c,724 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1192
;Solar_Auto_Switcher.c,726 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1193:
	DEC        R16
	BRNE       L_SetTimerOff_1193
	DEC        R17
	BRNE       L_SetTimerOff_1193
	DEC        R18
	BRNE       L_SetTimerOff_1193
	NOP
;Solar_Auto_Switcher.c,727 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,728 :: 		}
L_SetTimerOff_1192:
;Solar_Auto_Switcher.c,729 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1195
;Solar_Auto_Switcher.c,731 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1196:
	DEC        R16
	BRNE       L_SetTimerOff_1196
	DEC        R17
	BRNE       L_SetTimerOff_1196
	DEC        R18
	BRNE       L_SetTimerOff_1196
	NOP
;Solar_Auto_Switcher.c,732 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,733 :: 		}
L_SetTimerOff_1195:
;Solar_Auto_Switcher.c,734 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_11008
	JMP        L_SetTimerOff_1198
L__SetTimerOff_11008:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1198:
;Solar_Auto_Switcher.c,735 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11009
	JMP        L_SetTimerOff_1199
L__SetTimerOff_11009:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1199:
;Solar_Auto_Switcher.c,736 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1188
L_SetTimerOff_1189:
;Solar_Auto_Switcher.c,737 :: 		} // end first while
	JMP        L_SetTimerOff_1185
L_SetTimerOff_1186:
;Solar_Auto_Switcher.c,738 :: 		EEPROM_Write(0x03,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,739 :: 		EEPROM_Write(0x04,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,740 :: 		}
L_end_SetTimerOff_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetTimerOn_2:

;Solar_Auto_Switcher.c,743 :: 		void SetTimerOn_2()
;Solar_Auto_Switcher.c,745 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,746 :: 		LCD_OUT(1,1,"T2 On: [3]");
	LDI        R27, #lo_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,747 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2200:
	DEC        R16
	BRNE       L_SetTimerOn_2200
	DEC        R17
	BRNE       L_SetTimerOn_2200
	DEC        R18
	BRNE       L_SetTimerOn_2200
;Solar_Auto_Switcher.c,748 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,749 :: 		while (Set==1)
L_SetTimerOn_2202:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2203
;Solar_Auto_Switcher.c,755 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,756 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,757 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,758 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,760 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2204
;Solar_Auto_Switcher.c,762 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,763 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2203
;Solar_Auto_Switcher.c,764 :: 		}
L_SetTimerOn_2204:
;Solar_Auto_Switcher.c,767 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2205:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2774
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2773
	JMP        L_SetTimerOn_2206
L__SetTimerOn_2774:
L__SetTimerOn_2773:
;Solar_Auto_Switcher.c,769 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2209
;Solar_Auto_Switcher.c,771 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2210:
	DEC        R16
	BRNE       L_SetTimerOn_2210
	DEC        R17
	BRNE       L_SetTimerOn_2210
	DEC        R18
	BRNE       L_SetTimerOn_2210
	NOP
;Solar_Auto_Switcher.c,772 :: 		minutes_lcd_timer2_start++;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,773 :: 		}
L_SetTimerOn_2209:
;Solar_Auto_Switcher.c,774 :: 		if (Decrement==1 )
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2212
;Solar_Auto_Switcher.c,776 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2213:
	DEC        R16
	BRNE       L_SetTimerOn_2213
	DEC        R17
	BRNE       L_SetTimerOn_2213
	DEC        R18
	BRNE       L_SetTimerOn_2213
	NOP
;Solar_Auto_Switcher.c,777 :: 		minutes_lcd_timer2_start--;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,778 :: 		}
L_SetTimerOn_2212:
;Solar_Auto_Switcher.c,780 :: 		if (minutes_lcd_timer2_start>59)    minutes_lcd_timer2_start=0;
	LDS        R17, _minutes_lcd_timer2_start+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_21011
	JMP        L_SetTimerOn_2215
L__SetTimerOn_21011:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2215:
;Solar_Auto_Switcher.c,781 :: 		if (minutes_lcd_timer2_start<0)  minutes_lcd_timer2_start=0;
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21012
	JMP        L_SetTimerOn_2216
L__SetTimerOn_21012:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2216:
;Solar_Auto_Switcher.c,782 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_2205
L_SetTimerOn_2206:
;Solar_Auto_Switcher.c,783 :: 		} // end first while
	JMP        L_SetTimerOn_2202
L_SetTimerOn_2203:
;Solar_Auto_Switcher.c,785 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_2217:
	DEC        R16
	BRNE       L_SetTimerOn_2217
	DEC        R17
	BRNE       L_SetTimerOn_2217
	DEC        R18
	BRNE       L_SetTimerOn_2217
;Solar_Auto_Switcher.c,786 :: 		while (Set==1)
L_SetTimerOn_2219:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2220
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
	JMP        L_SetTimerOn_2221
;Solar_Auto_Switcher.c,797 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2220
;Solar_Auto_Switcher.c,798 :: 		}
L_SetTimerOn_2221:
;Solar_Auto_Switcher.c,800 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2222:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2776
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2775
	JMP        L_SetTimerOn_2223
L__SetTimerOn_2776:
L__SetTimerOn_2775:
;Solar_Auto_Switcher.c,802 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2226
;Solar_Auto_Switcher.c,804 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2227:
	DEC        R16
	BRNE       L_SetTimerOn_2227
	DEC        R17
	BRNE       L_SetTimerOn_2227
	DEC        R18
	BRNE       L_SetTimerOn_2227
	NOP
;Solar_Auto_Switcher.c,805 :: 		hours_lcd_timer2_start++;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,806 :: 		}
L_SetTimerOn_2226:
;Solar_Auto_Switcher.c,807 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2229
;Solar_Auto_Switcher.c,809 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2230:
	DEC        R16
	BRNE       L_SetTimerOn_2230
	DEC        R17
	BRNE       L_SetTimerOn_2230
	DEC        R18
	BRNE       L_SetTimerOn_2230
	NOP
;Solar_Auto_Switcher.c,810 :: 		hours_lcd_timer2_start--;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,811 :: 		}
L_SetTimerOn_2229:
;Solar_Auto_Switcher.c,813 :: 		if  (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
	LDS        R17, _hours_lcd_timer2_start+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_21013
	JMP        L_SetTimerOn_2232
L__SetTimerOn_21013:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2232:
;Solar_Auto_Switcher.c,814 :: 		if  (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21014
	JMP        L_SetTimerOn_2233
L__SetTimerOn_21014:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2233:
;Solar_Auto_Switcher.c,815 :: 		} // end while increment
	JMP        L_SetTimerOn_2222
L_SetTimerOn_2223:
;Solar_Auto_Switcher.c,816 :: 		} // end first while
	JMP        L_SetTimerOn_2219
L_SetTimerOn_2220:
;Solar_Auto_Switcher.c,818 :: 		EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_start+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,819 :: 		EEPROM_Write(0x19,minutes_lcd_timer2_start); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_start+0
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,820 :: 		}
L_end_SetTimerOn_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_2

_SetTimerOff_2:

;Solar_Auto_Switcher.c,822 :: 		void SetTimerOff_2()
;Solar_Auto_Switcher.c,824 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,825 :: 		LCD_OUT(1,1,"T2 Off: [4]");
	LDI        R27, #lo_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,826 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,827 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2234:
	DEC        R16
	BRNE       L_SetTimerOff_2234
	DEC        R17
	BRNE       L_SetTimerOff_2234
	DEC        R18
	BRNE       L_SetTimerOff_2234
	NOP
;Solar_Auto_Switcher.c,828 :: 		while (Set==1)
L_SetTimerOff_2236:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2237
;Solar_Auto_Switcher.c,834 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,835 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,836 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,837 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,838 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2238
	JMP        L_SetTimerOff_2237
L_SetTimerOff_2238:
;Solar_Auto_Switcher.c,840 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2239:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2780
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2779
	JMP        L_SetTimerOff_2240
L__SetTimerOff_2780:
L__SetTimerOff_2779:
;Solar_Auto_Switcher.c,842 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2243
;Solar_Auto_Switcher.c,844 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2244:
	DEC        R16
	BRNE       L_SetTimerOff_2244
	DEC        R17
	BRNE       L_SetTimerOff_2244
	DEC        R18
	BRNE       L_SetTimerOff_2244
	NOP
;Solar_Auto_Switcher.c,845 :: 		minutes_lcd_timer2_stop++;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,846 :: 		}
L_SetTimerOff_2243:
;Solar_Auto_Switcher.c,847 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2246
;Solar_Auto_Switcher.c,849 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2247:
	DEC        R16
	BRNE       L_SetTimerOff_2247
	DEC        R17
	BRNE       L_SetTimerOff_2247
	DEC        R18
	BRNE       L_SetTimerOff_2247
	NOP
;Solar_Auto_Switcher.c,850 :: 		minutes_lcd_timer2_stop--;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,851 :: 		}
L_SetTimerOff_2246:
;Solar_Auto_Switcher.c,853 :: 		if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
	LDS        R17, _minutes_lcd_timer2_stop+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_21016
	JMP        L_SetTimerOff_2249
L__SetTimerOff_21016:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2249:
;Solar_Auto_Switcher.c,854 :: 		if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21017
	JMP        L_SetTimerOff_2250
L__SetTimerOff_21017:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2250:
;Solar_Auto_Switcher.c,856 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2239
L_SetTimerOff_2240:
;Solar_Auto_Switcher.c,857 :: 		} // end first while
	JMP        L_SetTimerOff_2236
L_SetTimerOff_2237:
;Solar_Auto_Switcher.c,859 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2251:
	DEC        R16
	BRNE       L_SetTimerOff_2251
	DEC        R17
	BRNE       L_SetTimerOff_2251
	DEC        R18
	BRNE       L_SetTimerOff_2251
	NOP
;Solar_Auto_Switcher.c,860 :: 		while (Set==1)
L_SetTimerOff_2253:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2254
;Solar_Auto_Switcher.c,862 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,864 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,869 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2255
;Solar_Auto_Switcher.c,871 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,872 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_2254
;Solar_Auto_Switcher.c,873 :: 		}
L_SetTimerOff_2255:
;Solar_Auto_Switcher.c,875 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_2256:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2782
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2781
	JMP        L_SetTimerOff_2257
L__SetTimerOff_2782:
L__SetTimerOff_2781:
;Solar_Auto_Switcher.c,877 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2260
;Solar_Auto_Switcher.c,879 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2261:
	DEC        R16
	BRNE       L_SetTimerOff_2261
	DEC        R17
	BRNE       L_SetTimerOff_2261
	DEC        R18
	BRNE       L_SetTimerOff_2261
	NOP
;Solar_Auto_Switcher.c,880 :: 		hours_lcd_timer2_stop++;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,881 :: 		}
L_SetTimerOff_2260:
;Solar_Auto_Switcher.c,882 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2263
;Solar_Auto_Switcher.c,884 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2264:
	DEC        R16
	BRNE       L_SetTimerOff_2264
	DEC        R17
	BRNE       L_SetTimerOff_2264
	DEC        R18
	BRNE       L_SetTimerOff_2264
	NOP
;Solar_Auto_Switcher.c,885 :: 		hours_lcd_timer2_stop--;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,886 :: 		}
L_SetTimerOff_2263:
;Solar_Auto_Switcher.c,887 :: 		if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
	LDS        R17, _hours_lcd_timer2_stop+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_21018
	JMP        L_SetTimerOff_2266
L__SetTimerOff_21018:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2266:
;Solar_Auto_Switcher.c,888 :: 		if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21019
	JMP        L_SetTimerOff_2267
L__SetTimerOff_21019:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2267:
;Solar_Auto_Switcher.c,889 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2256
L_SetTimerOff_2257:
;Solar_Auto_Switcher.c,890 :: 		} // end first while
	JMP        L_SetTimerOff_2253
L_SetTimerOff_2254:
;Solar_Auto_Switcher.c,891 :: 		EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_timer2_stop+0
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,892 :: 		EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_timer2_stop+0
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,893 :: 		}
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

;Solar_Auto_Switcher.c,897 :: 		void SetDS1307_Time()
;Solar_Auto_Switcher.c,899 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,900 :: 		LCD_OUT(1,1,"Set Time [9]");
	LDI        R27, #lo_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,901 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time268:
	DEC        R16
	BRNE       L_SetDS1307_Time268
	DEC        R17
	BRNE       L_SetDS1307_Time268
	DEC        R18
	BRNE       L_SetDS1307_Time268
	NOP
;Solar_Auto_Switcher.c,902 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,903 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,905 :: 		while (Set==1)
L_SetDS1307_Time270:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time271
;Solar_Auto_Switcher.c,907 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,908 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,909 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,918 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time272
	JMP        L_SetDS1307_Time271
L_SetDS1307_Time272:
;Solar_Auto_Switcher.c,919 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time273:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time802
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time801
	JMP        L_SetDS1307_Time274
L__SetDS1307_Time802:
L__SetDS1307_Time801:
;Solar_Auto_Switcher.c,921 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time277
;Solar_Auto_Switcher.c,923 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time278:
	DEC        R16
	BRNE       L_SetDS1307_Time278
	DEC        R17
	BRNE       L_SetDS1307_Time278
	DEC        R18
	BRNE       L_SetDS1307_Time278
	NOP
;Solar_Auto_Switcher.c,924 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,926 :: 		}
L_SetDS1307_Time277:
;Solar_Auto_Switcher.c,927 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time280
;Solar_Auto_Switcher.c,929 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time281:
	DEC        R16
	BRNE       L_SetDS1307_Time281
	DEC        R17
	BRNE       L_SetDS1307_Time281
	DEC        R18
	BRNE       L_SetDS1307_Time281
	NOP
;Solar_Auto_Switcher.c,930 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,931 :: 		}
L_SetDS1307_Time280:
;Solar_Auto_Switcher.c,932 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time1021
	JMP        L_SetDS1307_Time283
L__SetDS1307_Time1021:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time283:
;Solar_Auto_Switcher.c,933 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1022
	JMP        L_SetDS1307_Time284
L__SetDS1307_Time1022:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time284:
;Solar_Auto_Switcher.c,934 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time273
L_SetDS1307_Time274:
;Solar_Auto_Switcher.c,935 :: 		} // end first while
	JMP        L_SetDS1307_Time270
L_SetDS1307_Time271:
;Solar_Auto_Switcher.c,937 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time285:
	DEC        R16
	BRNE       L_SetDS1307_Time285
	DEC        R17
	BRNE       L_SetDS1307_Time285
	DEC        R18
	BRNE       L_SetDS1307_Time285
	NOP
;Solar_Auto_Switcher.c,938 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,940 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time287:
	DEC        R16
	BRNE       L_SetDS1307_Time287
	DEC        R17
	BRNE       L_SetDS1307_Time287
	DEC        R18
	BRNE       L_SetDS1307_Time287
	NOP
;Solar_Auto_Switcher.c,941 :: 		while (Set==1)
L_SetDS1307_Time289:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time290
;Solar_Auto_Switcher.c,948 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,949 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,950 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,951 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time291
	JMP        L_SetDS1307_Time290
L_SetDS1307_Time291:
;Solar_Auto_Switcher.c,952 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time292:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time804
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time803
	JMP        L_SetDS1307_Time293
L__SetDS1307_Time804:
L__SetDS1307_Time803:
;Solar_Auto_Switcher.c,954 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time296
;Solar_Auto_Switcher.c,956 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time297:
	DEC        R16
	BRNE       L_SetDS1307_Time297
	DEC        R17
	BRNE       L_SetDS1307_Time297
	DEC        R18
	BRNE       L_SetDS1307_Time297
	NOP
;Solar_Auto_Switcher.c,957 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,958 :: 		}
L_SetDS1307_Time296:
;Solar_Auto_Switcher.c,960 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time299
;Solar_Auto_Switcher.c,962 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time300:
	DEC        R16
	BRNE       L_SetDS1307_Time300
	DEC        R17
	BRNE       L_SetDS1307_Time300
	DEC        R18
	BRNE       L_SetDS1307_Time300
	NOP
;Solar_Auto_Switcher.c,963 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,964 :: 		}
L_SetDS1307_Time299:
;Solar_Auto_Switcher.c,965 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1023
	JMP        L_SetDS1307_Time302
L__SetDS1307_Time1023:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time302:
;Solar_Auto_Switcher.c,966 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1024
	JMP        L_SetDS1307_Time303
L__SetDS1307_Time1024:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time303:
;Solar_Auto_Switcher.c,967 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time292
L_SetDS1307_Time293:
;Solar_Auto_Switcher.c,968 :: 		} // end first while
	JMP        L_SetDS1307_Time289
L_SetDS1307_Time290:
;Solar_Auto_Switcher.c,970 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time304:
	DEC        R16
	BRNE       L_SetDS1307_Time304
	DEC        R17
	BRNE       L_SetDS1307_Time304
	DEC        R18
	BRNE       L_SetDS1307_Time304
	NOP
;Solar_Auto_Switcher.c,971 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,973 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time306:
	DEC        R16
	BRNE       L_SetDS1307_Time306
	DEC        R17
	BRNE       L_SetDS1307_Time306
	DEC        R18
	BRNE       L_SetDS1307_Time306
	NOP
;Solar_Auto_Switcher.c,974 :: 		while (Set==1)
L_SetDS1307_Time308:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time309
;Solar_Auto_Switcher.c,979 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,980 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,981 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,982 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time310
	JMP        L_SetDS1307_Time309
L_SetDS1307_Time310:
;Solar_Auto_Switcher.c,983 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time311:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time806
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time805
	JMP        L_SetDS1307_Time312
L__SetDS1307_Time806:
L__SetDS1307_Time805:
;Solar_Auto_Switcher.c,985 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time315
;Solar_Auto_Switcher.c,987 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time316:
	DEC        R16
	BRNE       L_SetDS1307_Time316
	DEC        R17
	BRNE       L_SetDS1307_Time316
	DEC        R18
	BRNE       L_SetDS1307_Time316
	NOP
;Solar_Auto_Switcher.c,988 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,989 :: 		}
L_SetDS1307_Time315:
;Solar_Auto_Switcher.c,990 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time318
;Solar_Auto_Switcher.c,992 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time319:
	DEC        R16
	BRNE       L_SetDS1307_Time319
	DEC        R17
	BRNE       L_SetDS1307_Time319
	DEC        R18
	BRNE       L_SetDS1307_Time319
	NOP
;Solar_Auto_Switcher.c,993 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,994 :: 		}
L_SetDS1307_Time318:
;Solar_Auto_Switcher.c,995 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1025
	JMP        L_SetDS1307_Time321
L__SetDS1307_Time1025:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time321:
;Solar_Auto_Switcher.c,996 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1026
	JMP        L_SetDS1307_Time322
L__SetDS1307_Time1026:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time322:
;Solar_Auto_Switcher.c,999 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Auto_Switcher.c,1000 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time311
L_SetDS1307_Time312:
;Solar_Auto_Switcher.c,1001 :: 		} // end first while
	JMP        L_SetDS1307_Time308
L_SetDS1307_Time309:
;Solar_Auto_Switcher.c,1003 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time323:
	DEC        R16
	BRNE       L_SetDS1307_Time323
	DEC        R17
	BRNE       L_SetDS1307_Time323
	DEC        R18
	BRNE       L_SetDS1307_Time323
;Solar_Auto_Switcher.c,1004 :: 		LCD_Clear(1,1,16);  // clear the lcd first row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1005 :: 		LCD_CLear(2,1,16); // clear the lcd two row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1008 :: 		set_ds1307_day=ReadDate(0x04);
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1009 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time325:
	DEC        R16
	BRNE       L_SetDS1307_Time325
	DEC        R17
	BRNE       L_SetDS1307_Time325
	DEC        R18
	BRNE       L_SetDS1307_Time325
	NOP
;Solar_Auto_Switcher.c,1010 :: 		while (Set==1)
L_SetDS1307_Time327:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time328
;Solar_Auto_Switcher.c,1012 :: 		ByteToStr(set_ds1307_day,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_day+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1013 :: 		LCD_OUT(2,1,"D:");
	LDI        R27, #lo_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1014 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1015 :: 		LCD_OUT(2,12,"Y:");
	LDI        R27, #lo_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1016 :: 		LCD_Out(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1017 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time329
	JMP        L_SetDS1307_Time328
L_SetDS1307_Time329:
;Solar_Auto_Switcher.c,1018 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time330:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time808
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time807
	JMP        L_SetDS1307_Time331
L__SetDS1307_Time808:
L__SetDS1307_Time807:
;Solar_Auto_Switcher.c,1020 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time334
;Solar_Auto_Switcher.c,1022 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time335:
	DEC        R16
	BRNE       L_SetDS1307_Time335
	DEC        R17
	BRNE       L_SetDS1307_Time335
	DEC        R18
	BRNE       L_SetDS1307_Time335
	NOP
;Solar_Auto_Switcher.c,1023 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1024 :: 		}
L_SetDS1307_Time334:
;Solar_Auto_Switcher.c,1025 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time337
;Solar_Auto_Switcher.c,1027 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time338:
	DEC        R16
	BRNE       L_SetDS1307_Time338
	DEC        R17
	BRNE       L_SetDS1307_Time338
	DEC        R18
	BRNE       L_SetDS1307_Time338
	NOP
;Solar_Auto_Switcher.c,1028 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1029 :: 		}
L_SetDS1307_Time337:
;Solar_Auto_Switcher.c,1030 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time1027
	JMP        L_SetDS1307_Time340
L__SetDS1307_Time1027:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time340:
;Solar_Auto_Switcher.c,1031 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1028
	JMP        L_SetDS1307_Time341
L__SetDS1307_Time1028:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time341:
;Solar_Auto_Switcher.c,1032 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time330
L_SetDS1307_Time331:
;Solar_Auto_Switcher.c,1033 :: 		} //  end while set
	JMP        L_SetDS1307_Time327
L_SetDS1307_Time328:
;Solar_Auto_Switcher.c,1035 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time342:
	DEC        R16
	BRNE       L_SetDS1307_Time342
	DEC        R17
	BRNE       L_SetDS1307_Time342
	DEC        R18
	BRNE       L_SetDS1307_Time342
;Solar_Auto_Switcher.c,1036 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1039 :: 		set_ds1307_month=ReadDate(0x05);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1040 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time344:
	DEC        R16
	BRNE       L_SetDS1307_Time344
	DEC        R17
	BRNE       L_SetDS1307_Time344
	DEC        R18
	BRNE       L_SetDS1307_Time344
	NOP
;Solar_Auto_Switcher.c,1041 :: 		while (Set==1)
L_SetDS1307_Time346:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time347
;Solar_Auto_Switcher.c,1043 :: 		ByteToStr(set_ds1307_month,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_month+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1044 :: 		LCD_Out(2,8,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1045 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time348
	JMP        L_SetDS1307_Time347
L_SetDS1307_Time348:
;Solar_Auto_Switcher.c,1046 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time349:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time810
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time809
	JMP        L_SetDS1307_Time350
L__SetDS1307_Time810:
L__SetDS1307_Time809:
;Solar_Auto_Switcher.c,1048 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time353
;Solar_Auto_Switcher.c,1050 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time354:
	DEC        R16
	BRNE       L_SetDS1307_Time354
	DEC        R17
	BRNE       L_SetDS1307_Time354
	DEC        R18
	BRNE       L_SetDS1307_Time354
	NOP
;Solar_Auto_Switcher.c,1051 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1053 :: 		}
L_SetDS1307_Time353:
;Solar_Auto_Switcher.c,1054 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time356
;Solar_Auto_Switcher.c,1056 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time357:
	DEC        R16
	BRNE       L_SetDS1307_Time357
	DEC        R17
	BRNE       L_SetDS1307_Time357
	DEC        R18
	BRNE       L_SetDS1307_Time357
	NOP
;Solar_Auto_Switcher.c,1057 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1058 :: 		}
L_SetDS1307_Time356:
;Solar_Auto_Switcher.c,1059 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time1029
	JMP        L_SetDS1307_Time359
L__SetDS1307_Time1029:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time359:
;Solar_Auto_Switcher.c,1060 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1030
	JMP        L_SetDS1307_Time360
L__SetDS1307_Time1030:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time360:
;Solar_Auto_Switcher.c,1061 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time349
L_SetDS1307_Time350:
;Solar_Auto_Switcher.c,1062 :: 		} //  end while set
	JMP        L_SetDS1307_Time346
L_SetDS1307_Time347:
;Solar_Auto_Switcher.c,1064 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time361:
	DEC        R16
	BRNE       L_SetDS1307_Time361
	DEC        R17
	BRNE       L_SetDS1307_Time361
	DEC        R18
	BRNE       L_SetDS1307_Time361
;Solar_Auto_Switcher.c,1065 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1068 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1069 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time363:
	DEC        R16
	BRNE       L_SetDS1307_Time363
	DEC        R17
	BRNE       L_SetDS1307_Time363
	DEC        R18
	BRNE       L_SetDS1307_Time363
	NOP
;Solar_Auto_Switcher.c,1070 :: 		while (Set==1)
L_SetDS1307_Time365:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time366
;Solar_Auto_Switcher.c,1072 :: 		ByteToStr(set_ds1307_year,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_year+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1073 :: 		LCD_Out(2,14,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1074 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time367
	JMP        L_SetDS1307_Time366
L_SetDS1307_Time367:
;Solar_Auto_Switcher.c,1075 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time368:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time812
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time811
	JMP        L_SetDS1307_Time369
L__SetDS1307_Time812:
L__SetDS1307_Time811:
;Solar_Auto_Switcher.c,1077 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time372
;Solar_Auto_Switcher.c,1079 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time373:
	DEC        R16
	BRNE       L_SetDS1307_Time373
	DEC        R17
	BRNE       L_SetDS1307_Time373
	DEC        R18
	BRNE       L_SetDS1307_Time373
	NOP
;Solar_Auto_Switcher.c,1080 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1082 :: 		}
L_SetDS1307_Time372:
;Solar_Auto_Switcher.c,1083 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time375
;Solar_Auto_Switcher.c,1085 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time376:
	DEC        R16
	BRNE       L_SetDS1307_Time376
	DEC        R17
	BRNE       L_SetDS1307_Time376
	DEC        R18
	BRNE       L_SetDS1307_Time376
	NOP
;Solar_Auto_Switcher.c,1086 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1087 :: 		}
L_SetDS1307_Time375:
;Solar_Auto_Switcher.c,1088 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time1031
	JMP        L_SetDS1307_Time378
L__SetDS1307_Time1031:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time378:
;Solar_Auto_Switcher.c,1089 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1032
	JMP        L_SetDS1307_Time379
L__SetDS1307_Time1032:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time379:
;Solar_Auto_Switcher.c,1091 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time368
L_SetDS1307_Time369:
;Solar_Auto_Switcher.c,1092 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
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
;Solar_Auto_Switcher.c,1093 :: 		} //  end while set
	JMP        L_SetDS1307_Time365
L_SetDS1307_Time366:
;Solar_Auto_Switcher.c,1094 :: 		}  // end setTimeAndData
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

;Solar_Auto_Switcher.c,1187 :: 		void SetLowBatteryVoltage()
;Solar_Auto_Switcher.c,1189 :: 		LCD_OUT(1,1,"Low Battery  [5]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1190 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage380:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage380
	DEC        R17
	BRNE       L_SetLowBatteryVoltage380
	DEC        R18
	BRNE       L_SetLowBatteryVoltage380
	NOP
;Solar_Auto_Switcher.c,1191 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1192 :: 		while(Set==1)
L_SetLowBatteryVoltage382:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage383
;Solar_Auto_Switcher.c,1194 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr23_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr23_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1195 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_24_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_24_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1196 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1198 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage384
	JMP        L_SetLowBatteryVoltage383
L_SetLowBatteryVoltage384:
;Solar_Auto_Switcher.c,1199 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage385:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage786
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage785
	JMP        L_SetLowBatteryVoltage386
L__SetLowBatteryVoltage786:
L__SetLowBatteryVoltage785:
;Solar_Auto_Switcher.c,1201 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage389
;Solar_Auto_Switcher.c,1203 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage390:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage390
	DEC        R17
	BRNE       L_SetLowBatteryVoltage390
	DEC        R18
	BRNE       L_SetLowBatteryVoltage390
	NOP
;Solar_Auto_Switcher.c,1204 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Auto_Switcher.c,1206 :: 		}
L_SetLowBatteryVoltage389:
;Solar_Auto_Switcher.c,1207 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage392
;Solar_Auto_Switcher.c,1209 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage393:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage393
	DEC        R17
	BRNE       L_SetLowBatteryVoltage393
	DEC        R18
	BRNE       L_SetLowBatteryVoltage393
	NOP
;Solar_Auto_Switcher.c,1210 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Auto_Switcher.c,1211 :: 		}
L_SetLowBatteryVoltage392:
;Solar_Auto_Switcher.c,1212 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1034
	LDI        R16, 1
L__SetLowBatteryVoltage1034:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1035
	JMP        L_SetLowBatteryVoltage395
L__SetLowBatteryVoltage1035:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage395:
;Solar_Auto_Switcher.c,1213 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1036
	LDI        R16, 1
L__SetLowBatteryVoltage1036:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1037
	JMP        L_SetLowBatteryVoltage396
L__SetLowBatteryVoltage1037:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage396:
;Solar_Auto_Switcher.c,1214 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage385
L_SetLowBatteryVoltage386:
;Solar_Auto_Switcher.c,1215 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage382
L_SetLowBatteryVoltage383:
;Solar_Auto_Switcher.c,1216 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1218 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetLowBatteryVoltage397:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage397
	DEC        R17
	BRNE       L_SetLowBatteryVoltage397
	DEC        R18
	BRNE       L_SetLowBatteryVoltage397
;Solar_Auto_Switcher.c,1219 :: 		while(Set==1)
L_SetLowBatteryVoltage399:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage400
;Solar_Auto_Switcher.c,1221 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr25_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr25_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1222 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage_T2+0
	LDS        R17, _Mini_Battery_Voltage_T2+1
	LDS        R18, _Mini_Battery_Voltage_T2+2
	LDS        R19, _Mini_Battery_Voltage_T2+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_26_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_26_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1223 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1225 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage401
	JMP        L_SetLowBatteryVoltage400
L_SetLowBatteryVoltage401:
;Solar_Auto_Switcher.c,1226 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage402:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage788
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage787
	JMP        L_SetLowBatteryVoltage403
L__SetLowBatteryVoltage788:
L__SetLowBatteryVoltage787:
;Solar_Auto_Switcher.c,1228 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage406
;Solar_Auto_Switcher.c,1230 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage407:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage407
	DEC        R17
	BRNE       L_SetLowBatteryVoltage407
	DEC        R18
	BRNE       L_SetLowBatteryVoltage407
	NOP
;Solar_Auto_Switcher.c,1231 :: 		Mini_Battery_Voltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1233 :: 		}
L_SetLowBatteryVoltage406:
;Solar_Auto_Switcher.c,1234 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage409
;Solar_Auto_Switcher.c,1236 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage410:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage410
	DEC        R17
	BRNE       L_SetLowBatteryVoltage410
	DEC        R18
	BRNE       L_SetLowBatteryVoltage410
	NOP
;Solar_Auto_Switcher.c,1237 :: 		Mini_Battery_Voltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1238 :: 		}
L_SetLowBatteryVoltage409:
;Solar_Auto_Switcher.c,1239 :: 		if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1038
	LDI        R16, 1
L__SetLowBatteryVoltage1038:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1039
	JMP        L_SetLowBatteryVoltage412
L__SetLowBatteryVoltage1039:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage412:
;Solar_Auto_Switcher.c,1240 :: 		if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1040
	LDI        R16, 1
L__SetLowBatteryVoltage1040:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1041
	JMP        L_SetLowBatteryVoltage413
L__SetLowBatteryVoltage1041:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage413:
;Solar_Auto_Switcher.c,1241 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage402
L_SetLowBatteryVoltage403:
;Solar_Auto_Switcher.c,1242 :: 		}// end while set
	JMP        L_SetLowBatteryVoltage399
L_SetLowBatteryVoltage400:
;Solar_Auto_Switcher.c,1244 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1245 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1246 :: 		}
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

;Solar_Auto_Switcher.c,1248 :: 		void SetStartUpLoadsVoltage()
;Solar_Auto_Switcher.c,1250 :: 		LCD_OUT(1,1,"Start Loads V[6]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1251 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage414:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage414
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage414
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage414
	NOP
;Solar_Auto_Switcher.c,1252 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1253 :: 		while(Set==1)
L_SetStartUpLoadsVoltage416:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage417
;Solar_Auto_Switcher.c,1255 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr28_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr28_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1256 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_29_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_29_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1257 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1259 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage418
	JMP        L_SetStartUpLoadsVoltage417
L_SetStartUpLoadsVoltage418:
;Solar_Auto_Switcher.c,1260 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage419:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage792
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage791
	JMP        L_SetStartUpLoadsVoltage420
L__SetStartUpLoadsVoltage792:
L__SetStartUpLoadsVoltage791:
;Solar_Auto_Switcher.c,1262 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage423
;Solar_Auto_Switcher.c,1264 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage424:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage424
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage424
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage424
	NOP
;Solar_Auto_Switcher.c,1265 :: 		StartLoadsVoltage+=0.1;
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
;Solar_Auto_Switcher.c,1267 :: 		}
L_SetStartUpLoadsVoltage423:
;Solar_Auto_Switcher.c,1268 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage426
;Solar_Auto_Switcher.c,1270 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage427:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage427
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage427
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage427
	NOP
;Solar_Auto_Switcher.c,1271 :: 		StartLoadsVoltage-=0.1;
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
;Solar_Auto_Switcher.c,1272 :: 		}
L_SetStartUpLoadsVoltage426:
;Solar_Auto_Switcher.c,1273 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1043
	LDI        R16, 1
L__SetStartUpLoadsVoltage1043:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1044
	JMP        L_SetStartUpLoadsVoltage429
L__SetStartUpLoadsVoltage1044:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage429:
;Solar_Auto_Switcher.c,1274 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1045
	LDI        R16, 1
L__SetStartUpLoadsVoltage1045:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1046
	JMP        L_SetStartUpLoadsVoltage430
L__SetStartUpLoadsVoltage1046:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage430:
;Solar_Auto_Switcher.c,1275 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage419
L_SetStartUpLoadsVoltage420:
;Solar_Auto_Switcher.c,1276 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage416
L_SetStartUpLoadsVoltage417:
;Solar_Auto_Switcher.c,1278 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1279 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetStartUpLoadsVoltage431:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage431
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage431
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage431
;Solar_Auto_Switcher.c,1281 :: 		while(Set==1)
L_SetStartUpLoadsVoltage433:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage434
;Solar_Auto_Switcher.c,1283 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr30_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr30_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1284 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);     // re format vin_battery to have 2 decimals
	LDS        R16, _StartLoadsVoltage_T2+0
	LDS        R17, _StartLoadsVoltage_T2+1
	LDS        R18, _StartLoadsVoltage_T2+2
	LDS        R19, _StartLoadsVoltage_T2+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_31_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_31_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1285 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1287 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage435
	JMP        L_SetStartUpLoadsVoltage434
L_SetStartUpLoadsVoltage435:
;Solar_Auto_Switcher.c,1288 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage436:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage794
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage793
	JMP        L_SetStartUpLoadsVoltage437
L__SetStartUpLoadsVoltage794:
L__SetStartUpLoadsVoltage793:
;Solar_Auto_Switcher.c,1293 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage440
;Solar_Auto_Switcher.c,1295 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage441:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage441
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage441
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage441
	NOP
;Solar_Auto_Switcher.c,1296 :: 		StartLoadsVoltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1298 :: 		}
L_SetStartUpLoadsVoltage440:
;Solar_Auto_Switcher.c,1299 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage443
;Solar_Auto_Switcher.c,1301 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage444:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage444
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage444
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage444
	NOP
;Solar_Auto_Switcher.c,1302 :: 		StartLoadsVoltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1303 :: 		}
L_SetStartUpLoadsVoltage443:
;Solar_Auto_Switcher.c,1304 :: 		if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1047
	LDI        R16, 1
L__SetStartUpLoadsVoltage1047:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1048
	JMP        L_SetStartUpLoadsVoltage446
L__SetStartUpLoadsVoltage1048:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage446:
;Solar_Auto_Switcher.c,1305 :: 		if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1049
	LDI        R16, 1
L__SetStartUpLoadsVoltage1049:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1050
	JMP        L_SetStartUpLoadsVoltage447
L__SetStartUpLoadsVoltage1050:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage447:
;Solar_Auto_Switcher.c,1306 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage436
L_SetStartUpLoadsVoltage437:
;Solar_Auto_Switcher.c,1307 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage433
L_SetStartUpLoadsVoltage434:
;Solar_Auto_Switcher.c,1309 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);   // save float number to
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
;Solar_Auto_Switcher.c,1311 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1312 :: 		}
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

;Solar_Auto_Switcher.c,1314 :: 		void SetHighVoltage()
;Solar_Auto_Switcher.c,1316 :: 		LCD_OUT(1,1,"High AC Volt [7]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1317 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetHighVoltage448:
	DEC        R16
	BRNE       L_SetHighVoltage448
	DEC        R17
	BRNE       L_SetHighVoltage448
	DEC        R18
	BRNE       L_SetHighVoltage448
	NOP
;Solar_Auto_Switcher.c,1318 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1319 :: 		while(Set==1)
L_SetHighVoltage450:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetHighVoltage451
;Solar_Auto_Switcher.c,1321 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1322 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1323 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage452
	JMP        L_SetHighVoltage451
L_SetHighVoltage452:
;Solar_Auto_Switcher.c,1324 :: 		while(Increment==1 || Decrement==1)
L_SetHighVoltage453:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetHighVoltage821
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetHighVoltage820
	JMP        L_SetHighVoltage454
L__SetHighVoltage821:
L__SetHighVoltage820:
;Solar_Auto_Switcher.c,1326 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1327 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1328 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage457
;Solar_Auto_Switcher.c,1330 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage458:
	DEC        R16
	BRNE       L_SetHighVoltage458
	DEC        R17
	BRNE       L_SetHighVoltage458
	DEC        R18
	BRNE       L_SetHighVoltage458
	NOP
;Solar_Auto_Switcher.c,1331 :: 		High_Voltage++;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1332 :: 		}
L_SetHighVoltage457:
;Solar_Auto_Switcher.c,1333 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetHighVoltage460
;Solar_Auto_Switcher.c,1335 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage461:
	DEC        R16
	BRNE       L_SetHighVoltage461
	DEC        R17
	BRNE       L_SetHighVoltage461
	DEC        R18
	BRNE       L_SetHighVoltage461
	NOP
;Solar_Auto_Switcher.c,1336 :: 		High_Voltage--;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1337 :: 		}
L_SetHighVoltage460:
;Solar_Auto_Switcher.c,1338 :: 		if(High_Voltage > 255 ) High_Voltage=0;
	LDS        R18, _High_Voltage+0
	LDS        R19, _High_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetHighVoltage1052
	JMP        L_SetHighVoltage463
L__SetHighVoltage1052:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage463:
;Solar_Auto_Switcher.c,1339 :: 		if (High_Voltage < 0 ) High_Voltage=0;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CPI        R17, 0
	BRNE       L__SetHighVoltage1053
	CPI        R16, 0
L__SetHighVoltage1053:
	BRLO       L__SetHighVoltage1054
	JMP        L_SetHighVoltage464
L__SetHighVoltage1054:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage464:
;Solar_Auto_Switcher.c,1340 :: 		} // end while increment or decrement
	JMP        L_SetHighVoltage453
L_SetHighVoltage454:
;Solar_Auto_Switcher.c,1341 :: 		} // end while set
	JMP        L_SetHighVoltage450
L_SetHighVoltage451:
;Solar_Auto_Switcher.c,1342 :: 		EEPROM_Write(0x12,High_Voltage);
	LDS        R4, _High_Voltage+0
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1343 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1344 :: 		}
L_end_SetHighVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetHighVoltage

_SetLowVoltage:

;Solar_Auto_Switcher.c,1346 :: 		void SetLowVoltage()
;Solar_Auto_Switcher.c,1348 :: 		LCD_OUT(1,1,"Low AC Volt [8]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1349 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowVoltage465:
	DEC        R16
	BRNE       L_SetLowVoltage465
	DEC        R17
	BRNE       L_SetLowVoltage465
	DEC        R18
	BRNE       L_SetLowVoltage465
	NOP
;Solar_Auto_Switcher.c,1350 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1351 :: 		while(Set==1)
L_SetLowVoltage467:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowVoltage468
;Solar_Auto_Switcher.c,1353 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1354 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1355 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage469
	JMP        L_SetLowVoltage468
L_SetLowVoltage469:
;Solar_Auto_Switcher.c,1356 :: 		while(Increment==1 || Decrement==1)
L_SetLowVoltage470:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowVoltage824
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowVoltage823
	JMP        L_SetLowVoltage471
L__SetLowVoltage824:
L__SetLowVoltage823:
;Solar_Auto_Switcher.c,1358 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1359 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1360 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage474
;Solar_Auto_Switcher.c,1362 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage475:
	DEC        R16
	BRNE       L_SetLowVoltage475
	DEC        R17
	BRNE       L_SetLowVoltage475
	DEC        R18
	BRNE       L_SetLowVoltage475
	NOP
;Solar_Auto_Switcher.c,1363 :: 		Low_Voltage++;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1364 :: 		}
L_SetLowVoltage474:
;Solar_Auto_Switcher.c,1365 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowVoltage477
;Solar_Auto_Switcher.c,1367 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage478:
	DEC        R16
	BRNE       L_SetLowVoltage478
	DEC        R17
	BRNE       L_SetLowVoltage478
	DEC        R18
	BRNE       L_SetLowVoltage478
	NOP
;Solar_Auto_Switcher.c,1368 :: 		Low_Voltage--;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1369 :: 		}
L_SetLowVoltage477:
;Solar_Auto_Switcher.c,1370 :: 		if(Low_Voltage > 255 ) Low_Voltage=0;
	LDS        R18, _Low_Voltage+0
	LDS        R19, _Low_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetLowVoltage1056
	JMP        L_SetLowVoltage480
L__SetLowVoltage1056:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage480:
;Solar_Auto_Switcher.c,1371 :: 		if (Low_Voltage < 0 ) Low_Voltage=0;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CPI        R17, 0
	BRNE       L__SetLowVoltage1057
	CPI        R16, 0
L__SetLowVoltage1057:
	BRLO       L__SetLowVoltage1058
	JMP        L_SetLowVoltage481
L__SetLowVoltage1058:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage481:
;Solar_Auto_Switcher.c,1372 :: 		} // end while increment or decrement
	JMP        L_SetLowVoltage470
L_SetLowVoltage471:
;Solar_Auto_Switcher.c,1373 :: 		} // end while set
	JMP        L_SetLowVoltage467
L_SetLowVoltage468:
;Solar_Auto_Switcher.c,1374 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1375 :: 		EEPROM_Write(0x13,Low_Voltage);
	LDS        R4, _Low_Voltage+0
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1376 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1377 :: 		}
L_end_SetLowVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowVoltage

_Startup_Timers:

;Solar_Auto_Switcher.c,1381 :: 		void Startup_Timers()
;Solar_Auto_Switcher.c,1383 :: 		LCD_OUT(1,1,"Start Loads [15]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1384 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers482:
	DEC        R16
	BRNE       L_Startup_Timers482
	DEC        R17
	BRNE       L_Startup_Timers482
	DEC        R18
	BRNE       L_Startup_Timers482
	NOP
;Solar_Auto_Switcher.c,1385 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1386 :: 		while(Set==1)
L_Startup_Timers484:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers485
;Solar_Auto_Switcher.c,1388 :: 		IntToStr(startupTIme_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_1+0
	LDS        R3, _startupTIme_1+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1389 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr35_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr35_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1391 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1392 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers486
	JMP        L_Startup_Timers485
L_Startup_Timers486:
;Solar_Auto_Switcher.c,1393 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers487:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers816
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers815
	JMP        L_Startup_Timers488
L__Startup_Timers816:
L__Startup_Timers815:
;Solar_Auto_Switcher.c,1395 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers491
;Solar_Auto_Switcher.c,1397 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers492:
	DEC        R16
	BRNE       L_Startup_Timers492
	DEC        R17
	BRNE       L_Startup_Timers492
	DEC        R18
	BRNE       L_Startup_Timers492
	NOP
;Solar_Auto_Switcher.c,1398 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1399 :: 		}
L_Startup_Timers491:
;Solar_Auto_Switcher.c,1400 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers494
;Solar_Auto_Switcher.c,1402 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers495:
	DEC        R16
	BRNE       L_Startup_Timers495
	DEC        R17
	BRNE       L_Startup_Timers495
	DEC        R18
	BRNE       L_Startup_Timers495
	NOP
;Solar_Auto_Switcher.c,1403 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1404 :: 		}
L_Startup_Timers494:
;Solar_Auto_Switcher.c,1405 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1060
	JMP        L_Startup_Timers497
L__Startup_Timers1060:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers497:
;Solar_Auto_Switcher.c,1406 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1061
	CPI        R16, 0
L__Startup_Timers1061:
	BRLO       L__Startup_Timers1062
	JMP        L_Startup_Timers498
L__Startup_Timers1062:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers498:
;Solar_Auto_Switcher.c,1407 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers487
L_Startup_Timers488:
;Solar_Auto_Switcher.c,1408 :: 		} // end while main while set
	JMP        L_Startup_Timers484
L_Startup_Timers485:
;Solar_Auto_Switcher.c,1409 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1411 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_Startup_Timers499:
	DEC        R16
	BRNE       L_Startup_Timers499
	DEC        R17
	BRNE       L_Startup_Timers499
	DEC        R18
	BRNE       L_Startup_Timers499
;Solar_Auto_Switcher.c,1412 :: 		while (Set==1)
L_Startup_Timers501:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers502
;Solar_Auto_Switcher.c,1414 :: 		IntToStr(startupTIme_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_2+0
	LDS        R3, _startupTIme_2+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1415 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1417 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1418 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers503
	JMP        L_Startup_Timers502
L_Startup_Timers503:
;Solar_Auto_Switcher.c,1419 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers504:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers818
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers817
	JMP        L_Startup_Timers505
L__Startup_Timers818:
L__Startup_Timers817:
;Solar_Auto_Switcher.c,1421 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers508
;Solar_Auto_Switcher.c,1423 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers509:
	DEC        R16
	BRNE       L_Startup_Timers509
	DEC        R17
	BRNE       L_Startup_Timers509
	DEC        R18
	BRNE       L_Startup_Timers509
	NOP
;Solar_Auto_Switcher.c,1424 :: 		startupTIme_2++;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1425 :: 		}
L_Startup_Timers508:
;Solar_Auto_Switcher.c,1426 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers511
;Solar_Auto_Switcher.c,1428 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Startup_Timers512:
	DEC        R16
	BRNE       L_Startup_Timers512
	DEC        R17
	BRNE       L_Startup_Timers512
	DEC        R18
	BRNE       L_Startup_Timers512
	NOP
;Solar_Auto_Switcher.c,1429 :: 		startupTIme_2--;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1430 :: 		}
L_Startup_Timers511:
;Solar_Auto_Switcher.c,1431 :: 		if(startupTIme_2 > 600 ) startupTIme_2=0;
	LDS        R18, _startupTIme_2+0
	LDS        R19, _startupTIme_2+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1063
	JMP        L_Startup_Timers514
L__Startup_Timers1063:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers514:
;Solar_Auto_Switcher.c,1432 :: 		if (startupTIme_2<0) startupTIme_2=0;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1064
	CPI        R16, 0
L__Startup_Timers1064:
	BRLO       L__Startup_Timers1065
	JMP        L_Startup_Timers515
L__Startup_Timers1065:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers515:
;Solar_Auto_Switcher.c,1433 :: 		} // end while increment and decrement
	JMP        L_Startup_Timers504
L_Startup_Timers505:
;Solar_Auto_Switcher.c,1434 :: 		} // end while set
	JMP        L_Startup_Timers501
L_Startup_Timers502:
;Solar_Auto_Switcher.c,1437 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1438 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1441 :: 		} // end  function
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

;Solar_Auto_Switcher.c,1469 :: 		void Screen_1()
;Solar_Auto_Switcher.c,1473 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Auto_Switcher.c,1474 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Auto_Switcher.c,1475 :: 		CalculateAC();
	CALL       _CalculateAC+0
;Solar_Auto_Switcher.c,1476 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Auto_Switcher.c,1478 :: 		void ADCBattery()
;Solar_Auto_Switcher.c,1480 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Auto_Switcher.c,1481 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Auto_Switcher.c,1482 :: 		ADPS2_Bit=1;
	LDS        R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	STS        ADPS2_bit+0, R27
;Solar_Auto_Switcher.c,1483 :: 		ADPS1_Bit=1;
	LDS        R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	STS        ADPS1_bit+0, R27
;Solar_Auto_Switcher.c,1484 :: 		ADPS0_Bit=0;
	LDS        R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	STS        ADPS0_bit+0, R27
;Solar_Auto_Switcher.c,1485 :: 		}
L_end_ADCBattery:
	POP        R2
	RET
; end of _ADCBattery

_Read_Battery:

;Solar_Auto_Switcher.c,1487 :: 		void Read_Battery()
;Solar_Auto_Switcher.c,1489 :: 		ADC_Value=ADC_Read(1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Auto_Switcher.c,1490 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
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
;Solar_Auto_Switcher.c,1493 :: 		Vin_Battery=((10.5/0.5)*Battery_Voltage); // 0.3 volt error from reading
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 168
	LDI        R23, 65
	CALL       _float_fpmul1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
;Solar_Auto_Switcher.c,1494 :: 		LCD_OUT(2,1,"V=");
	LDI        R27, #lo_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1495 :: 		sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_38_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_38_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1496 :: 		LCD_OUT(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1498 :: 		}
L_end_Read_Battery:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Read_Battery

_LowBatteryVoltageAlarm:

;Solar_Auto_Switcher.c,1501 :: 		void LowBatteryVoltageAlarm()
;Solar_Auto_Switcher.c,1503 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
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
	BREQ       L__LowBatteryVoltageAlarm1070
	LDI        R16, 1
L__LowBatteryVoltageAlarm1070:
	TST        R16
	BRNE       L__LowBatteryVoltageAlarm1071
	JMP        L__LowBatteryVoltageAlarm840
L__LowBatteryVoltageAlarm1071:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__LowBatteryVoltageAlarm1072
	JMP        L__LowBatteryVoltageAlarm839
L__LowBatteryVoltageAlarm1072:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1073
	JMP        L__LowBatteryVoltageAlarm838
L__LowBatteryVoltageAlarm1073:
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1074
	JMP        L__LowBatteryVoltageAlarm837
L__LowBatteryVoltageAlarm1074:
	JMP        L_LowBatteryVoltageAlarm520
L__LowBatteryVoltageAlarm838:
L__LowBatteryVoltageAlarm837:
L__LowBatteryVoltageAlarm835:
;Solar_Auto_Switcher.c,1505 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1506 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm521:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm521
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm521
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm521
	NOP
;Solar_Auto_Switcher.c,1507 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1508 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm523:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm523
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm523
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm523
	NOP
;Solar_Auto_Switcher.c,1509 :: 		}
L_LowBatteryVoltageAlarm520:
;Solar_Auto_Switcher.c,1503 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
L__LowBatteryVoltageAlarm840:
L__LowBatteryVoltageAlarm839:
;Solar_Auto_Switcher.c,1510 :: 		}
L_end_LowBatteryVoltageAlarm:
	RET
; end of _LowBatteryVoltageAlarm

_ReadAC:

;Solar_Auto_Switcher.c,1512 :: 		unsigned int ReadAC()
;Solar_Auto_Switcher.c,1514 :: 		char numberOfSamples=100;
	PUSH       R2
;Solar_Auto_Switcher.c,1515 :: 		char numberOfAverage=10;
;Solar_Auto_Switcher.c,1516 :: 		unsigned long sum=0;
;Solar_Auto_Switcher.c,1517 :: 		unsigned long r=0;
;Solar_Auto_Switcher.c,1518 :: 		unsigned long max_v=0;
; max_v start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
;Solar_Auto_Switcher.c,1519 :: 		char i=0;
;Solar_Auto_Switcher.c,1520 :: 		char j=0;
;Solar_Auto_Switcher.c,1521 :: 		unsigned long average=0;
;Solar_Auto_Switcher.c,1523 :: 		for (i=0;i<100;i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; max_v end address is: 19 (R19)
; i end address is: 18 (R18)
L_ReadAC525:
; i start address is: 18 (R18)
; max_v start address is: 19 (R19)
	CPI        R18, 100
	BRLO       L__ReadAC1076
	JMP        L_ReadAC526
L__ReadAC1076:
;Solar_Auto_Switcher.c,1525 :: 		r=ADC_Read(3);
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
;Solar_Auto_Switcher.c,1526 :: 		if (max_v<r) max_v=r;
	CP         R19, R23
	CPC        R20, R24
	CPC        R21, R25
	CPC        R22, R26
	BRLO       L__ReadAC1077
	JMP        L__ReadAC758
L__ReadAC1077:
	MOV        R19, R23
	MOV        R20, R24
	MOV        R21, R25
	MOV        R22, R26
; r end address is: 23 (R23)
; max_v end address is: 19 (R19)
	JMP        L_ReadAC528
L__ReadAC758:
L_ReadAC528:
;Solar_Auto_Switcher.c,1527 :: 		delay_us(200);
; max_v start address is: 19 (R19)
	LDI        R17, 3
	LDI        R16, 19
L_ReadAC529:
	DEC        R16
	BRNE       L_ReadAC529
	DEC        R17
	BRNE       L_ReadAC529
;Solar_Auto_Switcher.c,1523 :: 		for (i=0;i<100;i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Solar_Auto_Switcher.c,1528 :: 		}
; i end address is: 18 (R18)
	JMP        L_ReadAC525
L_ReadAC526:
;Solar_Auto_Switcher.c,1529 :: 		return max_v;
	MOV        R16, R19
	MOV        R17, R20
; max_v end address is: 19 (R19)
;Solar_Auto_Switcher.c,1543 :: 		}
;Solar_Auto_Switcher.c,1529 :: 		return max_v;
;Solar_Auto_Switcher.c,1543 :: 		}
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

;Solar_Auto_Switcher.c,1545 :: 		void CalculateAC()
;Solar_Auto_Switcher.c,1548 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,1549 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,1550 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1551 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,1552 :: 		v=v+Error_Voltage;
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
;Solar_Auto_Switcher.c,1554 :: 		if (AC_Available==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_CalculateAC531
;Solar_Auto_Switcher.c,1556 :: 		sprintf(buf,"%4.0fV",v);
	MOVW       R20, R28
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_39_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_39_Solar_Auto_Switcher+0)
	PUSH       R27
	PUSH       R21
	PUSH       R20
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1557 :: 		LCD_OUT(2,8,"-");
	LDI        R27, #lo_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1558 :: 		LCD_OUT(2,9,buf);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1559 :: 		}
	JMP        L_CalculateAC532
L_CalculateAC531:
;Solar_Auto_Switcher.c,1563 :: 		}
L_CalculateAC532:
;Solar_Auto_Switcher.c,1564 :: 		VoltageProtector(v);
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _VoltageProtector+0
;Solar_Auto_Switcher.c,1565 :: 		}
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

;Solar_Auto_Switcher.c,1569 :: 		void VoltageProtector(unsigned long voltage)
;Solar_Auto_Switcher.c,1572 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRSH       L__VoltageProtector1080
	JMP        L__VoltageProtector830
L__VoltageProtector1080:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRSH       L__VoltageProtector1081
	JMP        L__VoltageProtector829
L__VoltageProtector1081:
	JMP        L_VoltageProtector537
L__VoltageProtector830:
L__VoltageProtector829:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector831
L__VoltageProtector827:
;Solar_Auto_Switcher.c,1574 :: 		VoltageProtectorGood=0;
	LDI        R27, 0
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1575 :: 		}
L_VoltageProtector537:
;Solar_Auto_Switcher.c,1572 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
L__VoltageProtector831:
;Solar_Auto_Switcher.c,1577 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRLO       L__VoltageProtector1082
	JMP        L__VoltageProtector834
L__VoltageProtector1082:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRLO       L__VoltageProtector1083
	JMP        L__VoltageProtector833
L__VoltageProtector1083:
L__VoltageProtector826:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector832
L__VoltageProtector825:
;Solar_Auto_Switcher.c,1579 :: 		VoltageProtectorGood=1;
	LDI        R27, 1
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1577 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
L__VoltageProtector834:
L__VoltageProtector833:
L__VoltageProtector832:
;Solar_Auto_Switcher.c,1581 :: 		}
L_end_VoltageProtector:
	RET
; end of _VoltageProtector

_ErrorList:

;Solar_Auto_Switcher.c,1583 :: 		void ErrorList()
;Solar_Auto_Switcher.c,1594 :: 		if(VoltageProtectorGood==0 && AC_Available==0)  {LCD_OUT(1,16,"2");}  else {LCD_OUT(2,16," ");}
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__ErrorList1085
	JMP        L__ErrorList843
L__ErrorList1085:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__ErrorList842
L__ErrorList841:
	LDI        R27, #lo_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_ErrorList546
L__ErrorList843:
L__ErrorList842:
	LDI        R27, #lo_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_ErrorList546:
;Solar_Auto_Switcher.c,1596 :: 		}
L_end_ErrorList:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _ErrorList

_Start_Timer_0_A:

;Solar_Auto_Switcher.c,1599 :: 		void Start_Timer_0_A()
;Solar_Auto_Switcher.c,1601 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Auto_Switcher.c,1602 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Auto_Switcher.c,1603 :: 		WGM02_bit=0;
	IN         R27, WGM02_bit+0
	CBR        R27, BitMask(WGM02_bit+0)
	OUT        WGM02_bit+0, R27
;Solar_Auto_Switcher.c,1604 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1605 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1606 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1607 :: 		OCR0A=0xFF;
	LDI        R27, 255
	OUT        OCR0A+0, R27
;Solar_Auto_Switcher.c,1608 :: 		OCIE0A_Bit=1;
	LDS        R27, OCIE0A_bit+0
	SBR        R27, BitMask(OCIE0A_bit+0)
	STS        OCIE0A_bit+0, R27
;Solar_Auto_Switcher.c,1609 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_A_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,1611 :: 		void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
;Solar_Auto_Switcher.c,1613 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1614 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Auto_Switcher.c,1615 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Auto_Switcher.c,1616 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Auto_Switcher.c,1619 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1088
	CPI        R18, 244
L__Interupt_Timer_0_A_OFFTime1088:
	BREQ       L__Interupt_Timer_0_A_OFFTime1089
	JMP        L_Interupt_Timer_0_A_OFFTime547
L__Interupt_Timer_0_A_OFFTime1089:
;Solar_Auto_Switcher.c,1622 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1090
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1090:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1091
	JMP        L__Interupt_Timer_0_A_OFFTime848
L__Interupt_Timer_0_A_OFFTime1091:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime847
L__Interupt_Timer_0_A_OFFTime846:
;Solar_Auto_Switcher.c,1624 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1625 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime551:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime551
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime551
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime551
	NOP
;Solar_Auto_Switcher.c,1626 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1627 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1622 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime848:
L__Interupt_Timer_0_A_OFFTime847:
;Solar_Auto_Switcher.c,1629 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Auto_Switcher.c,1630 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1631 :: 		}
L_Interupt_Timer_0_A_OFFTime547:
;Solar_Auto_Switcher.c,1634 :: 		if (Timer_Counter_4==500)              // more than 10 seconds
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	CPI        R17, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1092
	CPI        R16, 244
L__Interupt_Timer_0_A_OFFTime1092:
	BREQ       L__Interupt_Timer_0_A_OFFTime1093
	JMP        L_Interupt_Timer_0_A_OFFTime553
L__Interupt_Timer_0_A_OFFTime1093:
;Solar_Auto_Switcher.c,1637 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1094
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1094:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1095
	JMP        L__Interupt_Timer_0_A_OFFTime850
L__Interupt_Timer_0_A_OFFTime1095:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime849
L__Interupt_Timer_0_A_OFFTime845:
;Solar_Auto_Switcher.c,1639 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1640 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime557:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime557
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime557
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime557
	NOP
;Solar_Auto_Switcher.c,1641 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1642 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1637 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime850:
L__Interupt_Timer_0_A_OFFTime849:
;Solar_Auto_Switcher.c,1644 :: 		Timer_Counter_4=0;
	LDI        R27, 0
	STS        _Timer_Counter_4+0, R27
	STS        _Timer_Counter_4+1, R27
;Solar_Auto_Switcher.c,1645 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1646 :: 		}
L_Interupt_Timer_0_A_OFFTime553:
;Solar_Auto_Switcher.c,1650 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_A_OFFTime1096
	CPI        R16, 232
L__Interupt_Timer_0_A_OFFTime1096:
	BREQ       L__Interupt_Timer_0_A_OFFTime1097
	JMP        L_Interupt_Timer_0_A_OFFTime559
L__Interupt_Timer_0_A_OFFTime1097:
;Solar_Auto_Switcher.c,1652 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1098
	JMP        L__Interupt_Timer_0_A_OFFTime852
L__Interupt_Timer_0_A_OFFTime1098:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime851
L__Interupt_Timer_0_A_OFFTime844:
;Solar_Auto_Switcher.c,1654 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1655 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1656 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1657 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1652 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
L__Interupt_Timer_0_A_OFFTime852:
L__Interupt_Timer_0_A_OFFTime851:
;Solar_Auto_Switcher.c,1659 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Auto_Switcher.c,1660 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1661 :: 		}
L_Interupt_Timer_0_A_OFFTime559:
;Solar_Auto_Switcher.c,1663 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1664 :: 		OCF0A_Bit=1; // clear
	IN         R27, OCF0A_bit+0
	SBR        R27, BitMask(OCF0A_bit+0)
	OUT        OCF0A_bit+0, R27
;Solar_Auto_Switcher.c,1665 :: 		}
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

;Solar_Auto_Switcher.c,1667 :: 		void Stop_Timer_0()
;Solar_Auto_Switcher.c,1669 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1670 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Auto_Switcher.c,1671 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1672 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Auto_Switcher.c,1675 :: 		void EEPROM_FactorySettings(char period)
;Solar_Auto_Switcher.c,1677 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1101
	JMP        L_EEPROM_FactorySettings563
L__EEPROM_FactorySettings1101:
;Solar_Auto_Switcher.c,1679 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1680 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1681 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1682 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1683 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1684 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1686 :: 		EEPROM_Write(0x00,8);  // writing start hours
	PUSH       R2
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1687 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1688 :: 		EEPROM_Write(0x03,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1689 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1691 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1692 :: 		EEPROM_Write(0x19,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1693 :: 		EEPROM_Write(0x20,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1694 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1696 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1697 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1698 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1699 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1700 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1701 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1702 :: 		}
L_EEPROM_FactorySettings563:
;Solar_Auto_Switcher.c,1703 :: 		if (period==0) // winter timer
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1102
	JMP        L_EEPROM_FactorySettings564
L__EEPROM_FactorySettings1102:
;Solar_Auto_Switcher.c,1705 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1706 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1707 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1708 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1709 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1710 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1712 :: 		EEPROM_Write(0x00,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1713 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1714 :: 		EEPROM_Write(0x03,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1715 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1717 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1718 :: 		EEPROM_Write(0x19,30);    // writing  start minutes
	LDI        R27, 30
	MOV        R4, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1719 :: 		EEPROM_Write(0x20,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1720 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1722 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1723 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1724 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1725 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1726 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1727 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1728 :: 		}
L_EEPROM_FactorySettings564:
;Solar_Auto_Switcher.c,1730 :: 		EEPROM_Write(0x12,255); //  high voltage Grid
	LDI        R27, 255
	MOV        R4, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1731 :: 		EEPROM_Write(0x13,170); // load low voltage
	LDI        R27, 170
	MOV        R4, R27
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1732 :: 		EEPROM_Write(0x49,0); //  timer1_ison
	CLR        R4
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1733 :: 		EEPROM_Write(0x50,0); // timer2_is on
	CLR        R4
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1734 :: 		EEPROM_Write(0x15,1); // voltage protector enabled as default
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1735 :: 		}
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

;Solar_Auto_Switcher.c,1737 :: 		RunTimersNowCheck()
;Solar_Auto_Switcher.c,1757 :: 		if(Increment==1 && Exit==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck864
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck863
L__RunTimersNowCheck860:
;Solar_Auto_Switcher.c,1759 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck568:
	DEC        R16
	BRNE       L_RunTimersNowCheck568
	DEC        R17
	BRNE       L_RunTimersNowCheck568
	DEC        R18
	BRNE       L_RunTimersNowCheck568
	NOP
;Solar_Auto_Switcher.c,1760 :: 		if (Increment==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck862
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck861
L__RunTimersNowCheck859:
;Solar_Auto_Switcher.c,1762 :: 		RunLoadsByBass++;
	LDS        R16, _RunLoadsByBass+0
	SUBI       R16, 255
	STS        _RunLoadsByBass+0, R16
;Solar_Auto_Switcher.c,1763 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	CPI        R16, 1
	BREQ       L__RunTimersNowCheck1104
	JMP        L_RunTimersNowCheck573
L__RunTimersNowCheck1104:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_RunTimersNowCheck573:
;Solar_Auto_Switcher.c,1764 :: 		if (RunLoadsByBass>=2 )
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 2
	BRSH       L__RunTimersNowCheck1105
	JMP        L_RunTimersNowCheck574
L__RunTimersNowCheck1105:
;Solar_Auto_Switcher.c,1766 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck575:
	DEC        R16
	BRNE       L_RunTimersNowCheck575
	DEC        R17
	BRNE       L_RunTimersNowCheck575
	DEC        R18
	BRNE       L_RunTimersNowCheck575
	NOP
;Solar_Auto_Switcher.c,1767 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1768 :: 		}
L_RunTimersNowCheck574:
;Solar_Auto_Switcher.c,1769 :: 		LCD_OUT(1,16,"B");
	LDI        R27, #lo_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1760 :: 		if (Increment==1 && Exit==0)
L__RunTimersNowCheck862:
L__RunTimersNowCheck861:
;Solar_Auto_Switcher.c,1757 :: 		if(Increment==1 && Exit==0)
L__RunTimersNowCheck864:
L__RunTimersNowCheck863:
;Solar_Auto_Switcher.c,1773 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck870
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck869
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck868
L__RunTimersNowCheck858:
;Solar_Auto_Switcher.c,1775 :: 		Delay_ms(2000);
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
;Solar_Auto_Switcher.c,1776 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck867
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck866
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck865
L__RunTimersNowCheck857:
;Solar_Auto_Switcher.c,1778 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck585:
	DEC        R16
	BRNE       L_RunTimersNowCheck585
	DEC        R17
	BRNE       L_RunTimersNowCheck585
	DEC        R18
	BRNE       L_RunTimersNowCheck585
	NOP
;Solar_Auto_Switcher.c,1779 :: 		EEPROM_FactorySettings(1);        // summer time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1780 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck587:
	DEC        R16
	BRNE       L_RunTimersNowCheck587
	DEC        R17
	BRNE       L_RunTimersNowCheck587
	DEC        R18
	BRNE       L_RunTimersNowCheck587
;Solar_Auto_Switcher.c,1781 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1782 :: 		LCD_OUT(2,1,"Reset Summer    ");
	LDI        R27, #lo_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1783 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck589:
	DEC        R16
	BRNE       L_RunTimersNowCheck589
	DEC        R17
	BRNE       L_RunTimersNowCheck589
	DEC        R18
	BRNE       L_RunTimersNowCheck589
;Solar_Auto_Switcher.c,1784 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1776 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
L__RunTimersNowCheck867:
L__RunTimersNowCheck866:
L__RunTimersNowCheck865:
;Solar_Auto_Switcher.c,1773 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
L__RunTimersNowCheck870:
L__RunTimersNowCheck869:
L__RunTimersNowCheck868:
;Solar_Auto_Switcher.c,1787 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck876
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck875
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck874
L__RunTimersNowCheck856:
;Solar_Auto_Switcher.c,1789 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck594:
	DEC        R16
	BRNE       L_RunTimersNowCheck594
	DEC        R17
	BRNE       L_RunTimersNowCheck594
	DEC        R18
	BRNE       L_RunTimersNowCheck594
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1790 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck873
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck872
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck871
L__RunTimersNowCheck855:
;Solar_Auto_Switcher.c,1792 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck599:
	DEC        R16
	BRNE       L_RunTimersNowCheck599
	DEC        R17
	BRNE       L_RunTimersNowCheck599
	DEC        R18
	BRNE       L_RunTimersNowCheck599
	NOP
;Solar_Auto_Switcher.c,1793 :: 		EEPROM_FactorySettings(0);        // winter time
	CLR        R2
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1794 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck601:
	DEC        R16
	BRNE       L_RunTimersNowCheck601
	DEC        R17
	BRNE       L_RunTimersNowCheck601
	DEC        R18
	BRNE       L_RunTimersNowCheck601
;Solar_Auto_Switcher.c,1795 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1796 :: 		LCD_OUT(2,1,"Reset Winter    ");
	LDI        R27, #lo_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1797 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck603:
	DEC        R16
	BRNE       L_RunTimersNowCheck603
	DEC        R17
	BRNE       L_RunTimersNowCheck603
	DEC        R18
	BRNE       L_RunTimersNowCheck603
;Solar_Auto_Switcher.c,1798 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1790 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
L__RunTimersNowCheck873:
L__RunTimersNowCheck872:
L__RunTimersNowCheck871:
;Solar_Auto_Switcher.c,1787 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
L__RunTimersNowCheck876:
L__RunTimersNowCheck875:
L__RunTimersNowCheck874:
;Solar_Auto_Switcher.c,1820 :: 		if(Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck880
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck879
L__RunTimersNowCheck854:
;Solar_Auto_Switcher.c,1822 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck608:
	DEC        R16
	BRNE       L_RunTimersNowCheck608
	DEC        R17
	BRNE       L_RunTimersNowCheck608
	DEC        R18
	BRNE       L_RunTimersNowCheck608
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1823 :: 		if (Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck878
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck877
L__RunTimersNowCheck853:
;Solar_Auto_Switcher.c,1825 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,1826 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Auto_Switcher.c,1827 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1828 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1830 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1823 :: 		if (Decrement==1 && Exit==0)
L__RunTimersNowCheck878:
L__RunTimersNowCheck877:
;Solar_Auto_Switcher.c,1820 :: 		if(Decrement==1 && Exit==0)
L__RunTimersNowCheck880:
L__RunTimersNowCheck879:
;Solar_Auto_Switcher.c,1833 :: 		}
L_end_RunTimersNowCheck:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_WDT_Enable:

;Solar_Auto_Switcher.c,1835 :: 		void WDT_Enable()
;Solar_Auto_Switcher.c,1839 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1840 :: 		MCUSR &= ~(1<<WDRF);
	IN         R27, MCUSR+0
	CBR        R27, 8
	OUT        MCUSR+0, R27
;Solar_Auto_Switcher.c,1841 :: 		WDTCSR |= (1<<WDCE) | (1<<WDE);     //write a logic one to the Watchdog change enable bit (WDCE) and WDE
	LDS        R16, WDTCSR+0
	ORI        R16, 24
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1842 :: 		WDTCSR |=  (1<<WDE);               //logic one must be written to WDE regardless of the previous value of the WDE bit.
	LDS        R16, WDTCSR+0
	ORI        R16, 8
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1844 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1845 :: 		}
L_end_WDT_Enable:
	RET
; end of _WDT_Enable

_WDT_Prescaler_Change:

;Solar_Auto_Switcher.c,1847 :: 		void WDT_Prescaler_Change()
;Solar_Auto_Switcher.c,1851 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1852 :: 		WDTCSR |= (1<<WDCE) | (1<<WDE);
	LDS        R16, WDTCSR+0
	ORI        R16, 24
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1854 :: 		WDTCSR  = (1<<WDE) | (1<<WDP3) | (1<<WDP0);     // very important the equal as in datasheet examples code
	LDI        R27, 41
	STS        WDTCSR+0, R27
;Solar_Auto_Switcher.c,1856 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1857 :: 		}
L_end_WDT_Prescaler_Change:
	RET
; end of _WDT_Prescaler_Change

_WDT_Disable:

;Solar_Auto_Switcher.c,1859 :: 		void WDT_Disable()
;Solar_Auto_Switcher.c,1863 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1864 :: 		MCUSR &= ~(1<<WDRF);
	IN         R27, MCUSR+0
	CBR        R27, 8
	OUT        MCUSR+0, R27
;Solar_Auto_Switcher.c,1865 :: 		WDTCSR |= (1<<WDCE) | (1<<WDE);
	LDS        R16, WDTCSR+0
	ORI        R16, 24
	STS        WDTCSR+0, R16
;Solar_Auto_Switcher.c,1867 :: 		WDTCSR = 0x00;
	LDI        R27, 0
	STS        WDTCSR+0, R27
;Solar_Auto_Switcher.c,1869 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1870 :: 		}
L_end_WDT_Disable:
	RET
; end of _WDT_Disable

_CheckForSet:

;Solar_Auto_Switcher.c,1873 :: 		void CheckForSet()
;Solar_Auto_Switcher.c,1876 :: 		if (Set==0 && Exit==0) SetUpProgram();
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForSet883
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__CheckForSet882
L__CheckForSet881:
	CALL       _SetUpProgram+0
L__CheckForSet883:
L__CheckForSet882:
;Solar_Auto_Switcher.c,1878 :: 		}
L_end_CheckForSet:
	RET
; end of _CheckForSet

_AutoRunWithOutBatteryProtection:

;Solar_Auto_Switcher.c,1881 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Auto_Switcher.c,1883 :: 		if (Vin_Battery==0)
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
	BREQ       L__AutoRunWithOutBatteryProtection1111
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection1111:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection1112
	JMP        L_AutoRunWithOutBatteryProtection616
L__AutoRunWithOutBatteryProtection1112:
;Solar_Auto_Switcher.c,1885 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1886 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection617
L_AutoRunWithOutBatteryProtection616:
;Solar_Auto_Switcher.c,1889 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1890 :: 		}
L_AutoRunWithOutBatteryProtection617:
;Solar_Auto_Switcher.c,1891 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Auto_Switcher.c,1893 :: 		void CheckForTimerActivationInRange()
;Solar_Auto_Switcher.c,1897 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1114
	JMP        L__CheckForTimerActivationInRange890
L__CheckForTimerActivationInRange1114:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1115
	JMP        L__CheckForTimerActivationInRange889
L__CheckForTimerActivationInRange1115:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1116
	JMP        L__CheckForTimerActivationInRange888
L__CheckForTimerActivationInRange1116:
L__CheckForTimerActivationInRange887:
;Solar_Auto_Switcher.c,1899 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1900 :: 		EEPROM_Write(0x49,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1897 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
L__CheckForTimerActivationInRange890:
L__CheckForTimerActivationInRange889:
L__CheckForTimerActivationInRange888:
;Solar_Auto_Switcher.c,1904 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1117
	JMP        L__CheckForTimerActivationInRange893
L__CheckForTimerActivationInRange1117:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1118
	JMP        L__CheckForTimerActivationInRange892
L__CheckForTimerActivationInRange1118:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1119
	JMP        L__CheckForTimerActivationInRange891
L__CheckForTimerActivationInRange1119:
L__CheckForTimerActivationInRange886:
;Solar_Auto_Switcher.c,1907 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1120
	JMP        L_CheckForTimerActivationInRange624
L__CheckForTimerActivationInRange1120:
;Solar_Auto_Switcher.c,1909 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1910 :: 		EEPROM_Write(0x49,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1911 :: 		}
L_CheckForTimerActivationInRange624:
;Solar_Auto_Switcher.c,1904 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
L__CheckForTimerActivationInRange893:
L__CheckForTimerActivationInRange892:
L__CheckForTimerActivationInRange891:
;Solar_Auto_Switcher.c,1939 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1121
	JMP        L__CheckForTimerActivationInRange896
L__CheckForTimerActivationInRange1121:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1122
	JMP        L__CheckForTimerActivationInRange895
L__CheckForTimerActivationInRange1122:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1123
	JMP        L__CheckForTimerActivationInRange894
L__CheckForTimerActivationInRange1123:
L__CheckForTimerActivationInRange885:
;Solar_Auto_Switcher.c,1941 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1942 :: 		EEPROM_Write(0x50,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1939 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange896:
L__CheckForTimerActivationInRange895:
L__CheckForTimerActivationInRange894:
;Solar_Auto_Switcher.c,1945 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1124
	JMP        L__CheckForTimerActivationInRange899
L__CheckForTimerActivationInRange1124:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1125
	JMP        L__CheckForTimerActivationInRange898
L__CheckForTimerActivationInRange1125:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1126
	JMP        L__CheckForTimerActivationInRange897
L__CheckForTimerActivationInRange1126:
L__CheckForTimerActivationInRange884:
;Solar_Auto_Switcher.c,1947 :: 		if(ReadMinutes()<minutes_lcd_timer2_stop)
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1127
	JMP        L_CheckForTimerActivationInRange631
L__CheckForTimerActivationInRange1127:
;Solar_Auto_Switcher.c,1949 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1950 :: 		EEPROM_Write(0x50,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1951 :: 		}
L_CheckForTimerActivationInRange631:
;Solar_Auto_Switcher.c,1945 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange899:
L__CheckForTimerActivationInRange898:
L__CheckForTimerActivationInRange897:
;Solar_Auto_Switcher.c,1977 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Auto_Switcher.c,1980 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Auto_Switcher.c,1983 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff904
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1129
	JMP        L__TurnLoadsOffWhenGridOff903
L__TurnLoadsOffWhenGridOff1129:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1130
	JMP        L__TurnLoadsOffWhenGridOff902
L__TurnLoadsOffWhenGridOff1130:
L__TurnLoadsOffWhenGridOff901:
;Solar_Auto_Switcher.c,1985 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1986 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1987 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1988 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1983 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__TurnLoadsOffWhenGridOff904:
L__TurnLoadsOffWhenGridOff903:
L__TurnLoadsOffWhenGridOff902:
;Solar_Auto_Switcher.c,1991 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff907
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1131
	JMP        L__TurnLoadsOffWhenGridOff906
L__TurnLoadsOffWhenGridOff1131:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1132
	JMP        L__TurnLoadsOffWhenGridOff905
L__TurnLoadsOffWhenGridOff1132:
L__TurnLoadsOffWhenGridOff900:
;Solar_Auto_Switcher.c,1993 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1994 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1995 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1996 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1991 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__TurnLoadsOffWhenGridOff907:
L__TurnLoadsOffWhenGridOff906:
L__TurnLoadsOffWhenGridOff905:
;Solar_Auto_Switcher.c,1999 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _TurnLoadsOffWhenGridOff

_CheckForVoltageProtection:

;Solar_Auto_Switcher.c,2001 :: 		CheckForVoltageProtection()
;Solar_Auto_Switcher.c,2003 :: 		if (VoltageProtectionEnable==1)  LCD_OUT(2,16,"P"); else LCD_OUT(2,16," ") ;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1134
	JMP        L_CheckForVoltageProtection638
L__CheckForVoltageProtection1134:
	LDI        R27, #lo_addr(?lstr47_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr47_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_CheckForVoltageProtection639
L_CheckForVoltageProtection638:
	LDI        R27, #lo_addr(?lstr48_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr48_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_CheckForVoltageProtection639:
;Solar_Auto_Switcher.c,2004 :: 		if(Exit==1 && Set==0 )
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection913
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection912
L__CheckForVoltageProtection909:
;Solar_Auto_Switcher.c,2006 :: 		delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_CheckForVoltageProtection643:
	DEC        R16
	BRNE       L_CheckForVoltageProtection643
	DEC        R17
	BRNE       L_CheckForVoltageProtection643
	DEC        R18
	BRNE       L_CheckForVoltageProtection643
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,2007 :: 		if(Exit==1 && Set==0 ) {
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection911
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection910
L__CheckForVoltageProtection908:
;Solar_Auto_Switcher.c,2008 :: 		if (VoltageProtectorEnableFlag==1)         // protector as default is enabled so make it not enabled
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1135
	JMP        L_CheckForVoltageProtection648
L__CheckForVoltageProtection1135:
;Solar_Auto_Switcher.c,2010 :: 		VoltageProtectionEnable=0;
	LDI        R27, 0
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,2011 :: 		VoltageProtectorEnableFlag=0;
	LDI        R27, 0
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,2012 :: 		EEPROM_Write(0x15,0);
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,2013 :: 		}
	JMP        L_CheckForVoltageProtection649
L_CheckForVoltageProtection648:
;Solar_Auto_Switcher.c,2014 :: 		else if ( VoltageProtectorEnableFlag==0)
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 0
	BREQ       L__CheckForVoltageProtection1136
	JMP        L_CheckForVoltageProtection650
L__CheckForVoltageProtection1136:
;Solar_Auto_Switcher.c,2016 :: 		VoltageProtectionEnable=1;
	LDI        R27, 1
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,2017 :: 		VoltageProtectorEnableFlag=1;
	LDI        R27, 1
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,2018 :: 		EEPROM_Write(0x15,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,2019 :: 		}
L_CheckForVoltageProtection650:
L_CheckForVoltageProtection649:
;Solar_Auto_Switcher.c,2007 :: 		if(Exit==1 && Set==0 ) {
L__CheckForVoltageProtection911:
L__CheckForVoltageProtection910:
;Solar_Auto_Switcher.c,2004 :: 		if(Exit==1 && Set==0 )
L__CheckForVoltageProtection913:
L__CheckForVoltageProtection912:
;Solar_Auto_Switcher.c,2023 :: 		}
L_end_CheckForVoltageProtection:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForVoltageProtection

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Auto_Switcher.c,2025 :: 		void main() {
;Solar_Auto_Switcher.c,2027 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Auto_Switcher.c,2028 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Auto_Switcher.c,2029 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,2030 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Auto_Switcher.c,2031 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Auto_Switcher.c,2032 :: 		ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
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
;Solar_Auto_Switcher.c,2033 :: 		ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
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
;Solar_Auto_Switcher.c,2034 :: 		ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,2035 :: 		ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,2036 :: 		ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,2037 :: 		ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,2038 :: 		while(1)
L_main651:
;Solar_Auto_Switcher.c,2040 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Auto_Switcher.c,2041 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Auto_Switcher.c,2042 :: 		CheckForSet();
	CALL       _CheckForSet+0
;Solar_Auto_Switcher.c,2043 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Auto_Switcher.c,2044 :: 		CheckForVoltageProtection();
	CALL       _CheckForVoltageProtection+0
;Solar_Auto_Switcher.c,2047 :: 		Screen_1();
	CALL       _Screen_1+0
;Solar_Auto_Switcher.c,2048 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Auto_Switcher.c,2049 :: 		TurnLoadsOffWhenGridOff();        // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Auto_Switcher.c,2052 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main653:
	DEC        R16
	BRNE       L_main653
	DEC        R17
	BRNE       L_main653
	DEC        R18
	BRNE       L_main653
	NOP
;Solar_Auto_Switcher.c,2055 :: 		} // end while
	JMP        L_main651
;Solar_Auto_Switcher.c,2056 :: 		}   // end main
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
