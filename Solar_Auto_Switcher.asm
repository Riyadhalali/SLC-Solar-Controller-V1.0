
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
	BRSH       L__LCD_Clear924
	JMP        L_LCD_Clear3
L__LCD_Clear924:
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
	JMP        L__Interrupt_INT1660
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1927
	JMP        L__Interrupt_INT1659
L__Interrupt_INT1927:
L__Interrupt_INT1658:
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
L__Interrupt_INT1660:
L__Interrupt_INT1659:
;Solar_Auto_Switcher.c,213 :: 		if (AC_Available==1 && Timer_2_isOn==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1662
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1928
	JMP        L__Interrupt_INT1661
L__Interrupt_INT1928:
L__Interrupt_INT1657:
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
L__Interrupt_INT1662:
L__Interrupt_INT1661:
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
	BRLO       L__StoreBytesIntoEEprom931
	JMP        L_StoreBytesIntoEEprom12
L__StoreBytesIntoEEprom931:
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
	BRLO       L__ReadBytesFromEEprom933
	JMP        L_ReadBytesFromEEprom17
L__ReadBytesFromEEprom933:
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
	BREQ       L__Check_Timers935
	JMP        L_Check_Timers21
L__Check_Timers935:
;Solar_Auto_Switcher.c,287 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,288 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,292 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers689
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers936
	JMP        L__Check_Timers688
L__Check_Timers936:
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
	BREQ       L__Check_Timers937
	LDI        R16, 1
L__Check_Timers937:
	TST        R16
	BRNE       L__Check_Timers938
	JMP        L__Check_Timers687
L__Check_Timers938:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers939
	JMP        L__Check_Timers686
L__Check_Timers939:
L__Check_Timers685:
;Solar_Auto_Switcher.c,294 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,292 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
L__Check_Timers689:
L__Check_Timers688:
L__Check_Timers687:
L__Check_Timers686:
;Solar_Auto_Switcher.c,298 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers692
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers940
	JMP        L__Check_Timers691
L__Check_Timers940:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers941
	JMP        L__Check_Timers690
L__Check_Timers941:
L__Check_Timers684:
;Solar_Auto_Switcher.c,300 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,298 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers692:
L__Check_Timers691:
L__Check_Timers690:
;Solar_Auto_Switcher.c,302 :: 		} // end if ac_available
L_Check_Timers21:
;Solar_Auto_Switcher.c,305 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers942
	JMP        L_Check_Timers28
L__Check_Timers942:
;Solar_Auto_Switcher.c,307 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,310 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers695
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers943
	JMP        L__Check_Timers694
L__Check_Timers943:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers944
	JMP        L__Check_Timers693
L__Check_Timers944:
L__Check_Timers683:
;Solar_Auto_Switcher.c,313 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,314 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,310 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
L__Check_Timers695:
L__Check_Timers694:
L__Check_Timers693:
;Solar_Auto_Switcher.c,317 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers698
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers945
	JMP        L__Check_Timers697
L__Check_Timers945:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers946
	JMP        L__Check_Timers696
L__Check_Timers946:
L__Check_Timers682:
;Solar_Auto_Switcher.c,320 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,321 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,317 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
L__Check_Timers698:
L__Check_Timers697:
L__Check_Timers696:
;Solar_Auto_Switcher.c,323 :: 		}
L_Check_Timers28:
;Solar_Auto_Switcher.c,327 :: 		if (matched_timer_2_start==1)
	LDS        R16, _matched_timer_2_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers947
	JMP        L_Check_Timers35
L__Check_Timers947:
;Solar_Auto_Switcher.c,329 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,330 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,333 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers702
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers948
	JMP        L__Check_Timers701
L__Check_Timers948:
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
	BREQ       L__Check_Timers949
	LDI        R16, 1
L__Check_Timers949:
	TST        R16
	BRNE       L__Check_Timers950
	JMP        L__Check_Timers700
L__Check_Timers950:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers951
	JMP        L__Check_Timers699
L__Check_Timers951:
L__Check_Timers681:
;Solar_Auto_Switcher.c,335 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,333 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
L__Check_Timers702:
L__Check_Timers701:
L__Check_Timers700:
L__Check_Timers699:
;Solar_Auto_Switcher.c,339 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers705
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers952
	JMP        L__Check_Timers704
L__Check_Timers952:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers953
	JMP        L__Check_Timers703
L__Check_Timers953:
L__Check_Timers680:
;Solar_Auto_Switcher.c,341 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,339 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
L__Check_Timers705:
L__Check_Timers704:
L__Check_Timers703:
;Solar_Auto_Switcher.c,344 :: 		} // end if ac_available
L_Check_Timers35:
;Solar_Auto_Switcher.c,347 :: 		if (matched_timer_2_stop==1)
	LDS        R16, _matched_timer_2_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers954
	JMP        L_Check_Timers42
L__Check_Timers954:
;Solar_Auto_Switcher.c,349 :: 		Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,352 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers708
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers955
	JMP        L__Check_Timers707
L__Check_Timers955:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers956
	JMP        L__Check_Timers706
L__Check_Timers956:
L__Check_Timers679:
;Solar_Auto_Switcher.c,356 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,357 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,352 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
L__Check_Timers708:
L__Check_Timers707:
L__Check_Timers706:
;Solar_Auto_Switcher.c,361 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers711
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers957
	JMP        L__Check_Timers710
L__Check_Timers957:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers958
	JMP        L__Check_Timers709
L__Check_Timers958:
L__Check_Timers678:
;Solar_Auto_Switcher.c,363 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,364 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,361 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers711:
L__Check_Timers710:
L__Check_Timers709:
;Solar_Auto_Switcher.c,367 :: 		} // end match timer stop
L_Check_Timers42:
;Solar_Auto_Switcher.c,372 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers719
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers959
	JMP        L__Check_Timers718
L__Check_Timers959:
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 1
	BREQ       L__Check_Timers960
	JMP        L__Check_Timers717
L__Check_Timers960:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers961
	JMP        L__Check_Timers716
L__Check_Timers961:
L__Check_Timers677:
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
;Solar_Auto_Switcher.c,376 :: 		SecondsRealTime++;
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _SecondsRealTime+0, R18
	STS        _SecondsRealTime+1, R19
;Solar_Auto_Switcher.c,378 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers962
	JMP        L__Check_Timers713
L__Check_Timers962:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers712
L__Check_Timers676:
;Solar_Auto_Switcher.c,381 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,378 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers713:
L__Check_Timers712:
;Solar_Auto_Switcher.c,384 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers963
	JMP        L__Check_Timers715
L__Check_Timers963:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers714
L__Check_Timers675:
;Solar_Auto_Switcher.c,386 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,384 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers715:
L__Check_Timers714:
;Solar_Auto_Switcher.c,389 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,372 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
L__Check_Timers719:
L__Check_Timers718:
L__Check_Timers717:
L__Check_Timers716:
;Solar_Auto_Switcher.c,395 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers722
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Check_Timers964
	JMP        L__Check_Timers721
L__Check_Timers964:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers965
	JMP        L__Check_Timers720
L__Check_Timers965:
L__Check_Timers674:
;Solar_Auto_Switcher.c,397 :: 		Start_Timer_0_A();         // give some time ac grid to stabilize
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,395 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
L__Check_Timers722:
L__Check_Timers721:
L__Check_Timers720:
;Solar_Auto_Switcher.c,400 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers725
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers966
	JMP        L__Check_Timers724
L__Check_Timers966:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers967
	JMP        L__Check_Timers723
L__Check_Timers967:
L__Check_Timers673:
;Solar_Auto_Switcher.c,402 :: 		LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,400 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
L__Check_Timers725:
L__Check_Timers724:
L__Check_Timers723:
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers731
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__Check_Timers968
	JMP        L__Check_Timers730
L__Check_Timers968:
L__Check_Timers672:
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
	BRSH       L__Check_Timers969
	JMP        L__Check_Timers727
L__Check_Timers969:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers726
L__Check_Timers671:
;Solar_Auto_Switcher.c,414 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,411 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers727:
L__Check_Timers726:
;Solar_Auto_Switcher.c,417 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers970
	JMP        L__Check_Timers729
L__Check_Timers970:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers728
L__Check_Timers670:
;Solar_Auto_Switcher.c,420 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,417 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers729:
L__Check_Timers728:
;Solar_Auto_Switcher.c,422 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
L__Check_Timers731:
L__Check_Timers730:
;Solar_Auto_Switcher.c,431 :: 		if (AC_Available==0 && SecondsRealTime==startupTIme_2)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers733
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BREQ       L__Check_Timers971
	JMP        L__Check_Timers732
L__Check_Timers971:
L__Check_Timers669:
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
L__Check_Timers733:
L__Check_Timers732:
;Solar_Auto_Switcher.c,443 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers738
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers972
	JMP        L__Check_Timers737
L__Check_Timers972:
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
	BREQ       L__Check_Timers973
	LDI        R16, 1
L__Check_Timers973:
	TST        R16
	BRNE       L__Check_Timers974
	JMP        L__Check_Timers736
L__Check_Timers974:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers975
	JMP        L__Check_Timers735
L__Check_Timers975:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers976
	JMP        L__Check_Timers734
L__Check_Timers976:
L__Check_Timers668:
;Solar_Auto_Switcher.c,446 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,447 :: 		Delay_ms(400);
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
;Solar_Auto_Switcher.c,448 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers977
	JMP        L_Check_Timers85
L__Check_Timers977:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers85:
;Solar_Auto_Switcher.c,443 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
L__Check_Timers738:
L__Check_Timers737:
L__Check_Timers736:
L__Check_Timers735:
L__Check_Timers734:
;Solar_Auto_Switcher.c,451 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers742
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers978
	JMP        L__Check_Timers741
L__Check_Timers978:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers979
	JMP        L__Check_Timers740
L__Check_Timers979:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers980
	JMP        L__Check_Timers739
L__Check_Timers980:
L__Check_Timers667:
;Solar_Auto_Switcher.c,453 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,454 :: 		Delay_ms(400);
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
;Solar_Auto_Switcher.c,456 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers981
	JMP        L_Check_Timers91
L__Check_Timers981:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers91:
;Solar_Auto_Switcher.c,451 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
L__Check_Timers742:
L__Check_Timers741:
L__Check_Timers740:
L__Check_Timers739:
;Solar_Auto_Switcher.c,460 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers747
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers982
	JMP        L__Check_Timers746
L__Check_Timers982:
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
	BREQ       L__Check_Timers983
	LDI        R16, 1
L__Check_Timers983:
	TST        R16
	BRNE       L__Check_Timers984
	JMP        L__Check_Timers745
L__Check_Timers984:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers985
	JMP        L__Check_Timers744
L__Check_Timers985:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers986
	JMP        L__Check_Timers743
L__Check_Timers986:
L__Check_Timers666:
;Solar_Auto_Switcher.c,462 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,463 :: 		Delay_ms(400);
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
;Solar_Auto_Switcher.c,464 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers987
	JMP        L_Check_Timers97
L__Check_Timers987:
;Solar_Auto_Switcher.c,465 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers97:
;Solar_Auto_Switcher.c,460 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
L__Check_Timers747:
L__Check_Timers746:
L__Check_Timers745:
L__Check_Timers744:
L__Check_Timers743:
;Solar_Auto_Switcher.c,468 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers751
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers988
	JMP        L__Check_Timers750
L__Check_Timers988:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers989
	JMP        L__Check_Timers749
L__Check_Timers989:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers990
	JMP        L__Check_Timers748
L__Check_Timers990:
L__Check_Timers665:
;Solar_Auto_Switcher.c,470 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,471 :: 		Delay_ms(400);
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
;Solar_Auto_Switcher.c,472 :: 		if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
	LDS        R18, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T2+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers991
	JMP        L_Check_Timers103
L__Check_Timers991:
;Solar_Auto_Switcher.c,473 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers103:
;Solar_Auto_Switcher.c,468 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
L__Check_Timers751:
L__Check_Timers750:
L__Check_Timers749:
L__Check_Timers748:
;Solar_Auto_Switcher.c,477 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers992
	LDI        R16, 1
L__Check_Timers992:
	TST        R16
	BRNE       L__Check_Timers993
	JMP        L__Check_Timers755
L__Check_Timers993:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers754
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers994
	JMP        L__Check_Timers753
L__Check_Timers994:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers995
	JMP        L__Check_Timers752
L__Check_Timers995:
L__Check_Timers664:
;Solar_Auto_Switcher.c,479 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,480 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,477 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
L__Check_Timers755:
L__Check_Timers754:
L__Check_Timers753:
L__Check_Timers752:
;Solar_Auto_Switcher.c,484 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers996
	LDI        R16, 1
L__Check_Timers996:
	TST        R16
	BRNE       L__Check_Timers997
	JMP        L__Check_Timers759
L__Check_Timers997:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers758
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers998
	JMP        L__Check_Timers757
L__Check_Timers998:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers999
	JMP        L__Check_Timers756
L__Check_Timers999:
L__Check_Timers663:
;Solar_Auto_Switcher.c,486 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,487 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,484 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
L__Check_Timers759:
L__Check_Timers758:
L__Check_Timers757:
L__Check_Timers756:
;Solar_Auto_Switcher.c,490 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_GetVoltageNow:

;Solar_Auto_Switcher.c,493 :: 		void GetVoltageNow()
;Solar_Auto_Switcher.c,495 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,496 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,497 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,498 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,499 :: 		}
L_end_GetVoltageNow:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _GetVoltageNow

_ToggleBuzzer:

;Solar_Auto_Switcher.c,501 :: 		void ToggleBuzzer()
;Solar_Auto_Switcher.c,503 :: 		if (AcBuzzerActiveTimes==0)
	LDS        R16, _AcBuzzerActiveTimes+0
	CPI        R16, 0
	BREQ       L__ToggleBuzzer1002
	JMP        L_ToggleBuzzer110
L__ToggleBuzzer1002:
;Solar_Auto_Switcher.c,505 :: 		AcBuzzerActiveTimes =1 ;
	LDI        R27, 1
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,506 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,507 :: 		Delay_ms(1000);
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
;Solar_Auto_Switcher.c,508 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,509 :: 		}
L_ToggleBuzzer110:
;Solar_Auto_Switcher.c,510 :: 		}
L_end_ToggleBuzzer:
	RET
; end of _ToggleBuzzer

_Interrupt_Routine:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,512 :: 		void Interrupt_Routine () iv IVT_ADDR_INT0
;Solar_Auto_Switcher.c,515 :: 		Delay_ms(100);
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
;Solar_Auto_Switcher.c,516 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,517 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Interrupt_Routine115
;Solar_Auto_Switcher.c,518 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
L_Interrupt_Routine115:
;Solar_Auto_Switcher.c,519 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,520 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,521 :: 		}
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

;Solar_Auto_Switcher.c,524 :: 		void SetUpProgram()
;Solar_Auto_Switcher.c,526 :: 		Delay_ms(100);
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
;Solar_Auto_Switcher.c,528 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_SetUpProgram118
;Solar_Auto_Switcher.c,530 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,531 :: 		LCD_OUT(1,1,"Setup Program");
	LDI        R27, #lo_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,532 :: 		Delay_ms(1000);
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
;Solar_Auto_Switcher.c,535 :: 		while (Set==1 )
L_SetUpProgram121:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetUpProgram122
;Solar_Auto_Switcher.c,538 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Auto_Switcher.c,539 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram123
	JMP        L_SetUpProgram122
L_SetUpProgram123:
;Solar_Auto_Switcher.c,540 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Auto_Switcher.c,541 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram124
	JMP        L_SetUpProgram122
L_SetUpProgram124:
;Solar_Auto_Switcher.c,542 :: 		SetTimerOn_2();
	CALL       _SetTimerOn_2+0
;Solar_Auto_Switcher.c,543 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram125
	JMP        L_SetUpProgram122
L_SetUpProgram125:
;Solar_Auto_Switcher.c,544 :: 		SetTimerOff_2();
	CALL       _SetTimerOff_2+0
;Solar_Auto_Switcher.c,545 :: 		if (Exit==1) break ;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram126
	JMP        L_SetUpProgram122
L_SetUpProgram126:
;Solar_Auto_Switcher.c,546 :: 		SetLowBatteryVoltage();// program 5 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Auto_Switcher.c,547 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram127
	JMP        L_SetUpProgram122
L_SetUpProgram127:
;Solar_Auto_Switcher.c,548 :: 		SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Auto_Switcher.c,549 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram128
	JMP        L_SetUpProgram122
L_SetUpProgram128:
;Solar_Auto_Switcher.c,551 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram129
	JMP        L_SetUpProgram122
L_SetUpProgram129:
;Solar_Auto_Switcher.c,553 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram130
	JMP        L_SetUpProgram122
L_SetUpProgram130:
;Solar_Auto_Switcher.c,554 :: 		SetDS1307_Time();    // program 10
	CALL       _SetDS1307_Time+0
;Solar_Auto_Switcher.c,555 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram131
	JMP        L_SetUpProgram122
L_SetUpProgram131:
;Solar_Auto_Switcher.c,560 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Auto_Switcher.c,561 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram132
	JMP        L_SetUpProgram122
L_SetUpProgram132:
;Solar_Auto_Switcher.c,566 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,568 :: 		} // end while
	JMP        L_SetUpProgram121
L_SetUpProgram122:
;Solar_Auto_Switcher.c,569 :: 		}    // end main if
L_SetUpProgram118:
;Solar_Auto_Switcher.c,570 :: 		}
L_end_SetUpProgram:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Auto_Switcher.c,573 :: 		void SetTimerOn_1()
;Solar_Auto_Switcher.c,575 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,576 :: 		LCD_OUT(1,1,"T1 On: [1]");
	LDI        R27, #lo_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,577 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1133:
	DEC        R16
	BRNE       L_SetTimerOn_1133
	DEC        R17
	BRNE       L_SetTimerOn_1133
	DEC        R18
	BRNE       L_SetTimerOn_1133
;Solar_Auto_Switcher.c,578 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,579 :: 		while (Set==1)
L_SetTimerOn_1135:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1136
;Solar_Auto_Switcher.c,585 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,586 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,587 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,588 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,590 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1137
;Solar_Auto_Switcher.c,592 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,593 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1136
;Solar_Auto_Switcher.c,594 :: 		}
L_SetTimerOn_1137:
;Solar_Auto_Switcher.c,597 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1138:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1764
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1763
	JMP        L_SetTimerOn_1139
L__SetTimerOn_1764:
L__SetTimerOn_1763:
;Solar_Auto_Switcher.c,599 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1142
;Solar_Auto_Switcher.c,601 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1143:
	DEC        R16
	BRNE       L_SetTimerOn_1143
	DEC        R17
	BRNE       L_SetTimerOn_1143
	DEC        R18
	BRNE       L_SetTimerOn_1143
	NOP
;Solar_Auto_Switcher.c,602 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,603 :: 		}
L_SetTimerOn_1142:
;Solar_Auto_Switcher.c,604 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1145
;Solar_Auto_Switcher.c,606 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1146:
	DEC        R16
	BRNE       L_SetTimerOn_1146
	DEC        R17
	BRNE       L_SetTimerOn_1146
	DEC        R18
	BRNE       L_SetTimerOn_1146
	NOP
;Solar_Auto_Switcher.c,607 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,608 :: 		}
L_SetTimerOn_1145:
;Solar_Auto_Switcher.c,610 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_11006
	JMP        L_SetTimerOn_1148
L__SetTimerOn_11006:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1148:
;Solar_Auto_Switcher.c,611 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11007
	JMP        L_SetTimerOn_1149
L__SetTimerOn_11007:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1149:
;Solar_Auto_Switcher.c,612 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_1138
L_SetTimerOn_1139:
;Solar_Auto_Switcher.c,613 :: 		} // end first while
	JMP        L_SetTimerOn_1135
L_SetTimerOn_1136:
;Solar_Auto_Switcher.c,615 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_1150:
	DEC        R16
	BRNE       L_SetTimerOn_1150
	DEC        R17
	BRNE       L_SetTimerOn_1150
	DEC        R18
	BRNE       L_SetTimerOn_1150
;Solar_Auto_Switcher.c,616 :: 		while (Set==1)
L_SetTimerOn_1152:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1153
;Solar_Auto_Switcher.c,618 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,620 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,624 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1154
;Solar_Auto_Switcher.c,626 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,627 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1153
;Solar_Auto_Switcher.c,628 :: 		}
L_SetTimerOn_1154:
;Solar_Auto_Switcher.c,630 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1155:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1766
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1765
	JMP        L_SetTimerOn_1156
L__SetTimerOn_1766:
L__SetTimerOn_1765:
;Solar_Auto_Switcher.c,632 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1159
;Solar_Auto_Switcher.c,634 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1160:
	DEC        R16
	BRNE       L_SetTimerOn_1160
	DEC        R17
	BRNE       L_SetTimerOn_1160
	DEC        R18
	BRNE       L_SetTimerOn_1160
	NOP
;Solar_Auto_Switcher.c,635 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,636 :: 		}
L_SetTimerOn_1159:
;Solar_Auto_Switcher.c,637 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1162
;Solar_Auto_Switcher.c,639 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1163:
	DEC        R16
	BRNE       L_SetTimerOn_1163
	DEC        R17
	BRNE       L_SetTimerOn_1163
	DEC        R18
	BRNE       L_SetTimerOn_1163
	NOP
;Solar_Auto_Switcher.c,640 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,641 :: 		}
L_SetTimerOn_1162:
;Solar_Auto_Switcher.c,643 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_11008
	JMP        L_SetTimerOn_1165
L__SetTimerOn_11008:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1165:
;Solar_Auto_Switcher.c,644 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11009
	JMP        L_SetTimerOn_1166
L__SetTimerOn_11009:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1166:
;Solar_Auto_Switcher.c,645 :: 		} // end while increment
	JMP        L_SetTimerOn_1155
L_SetTimerOn_1156:
;Solar_Auto_Switcher.c,646 :: 		} // end first while
	JMP        L_SetTimerOn_1152
L_SetTimerOn_1153:
;Solar_Auto_Switcher.c,648 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,649 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,650 :: 		}
L_end_SetTimerOn_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Auto_Switcher.c,652 :: 		void SetTimerOff_1()
;Solar_Auto_Switcher.c,654 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,655 :: 		LCD_OUT(1,1,"T1 Off: [2]");
	LDI        R27, #lo_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,656 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,657 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1167:
	DEC        R16
	BRNE       L_SetTimerOff_1167
	DEC        R17
	BRNE       L_SetTimerOff_1167
	DEC        R18
	BRNE       L_SetTimerOff_1167
	NOP
;Solar_Auto_Switcher.c,658 :: 		while (Set==1)
L_SetTimerOff_1169:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1170
;Solar_Auto_Switcher.c,664 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,665 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,666 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,667 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,668 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1171
;Solar_Auto_Switcher.c,670 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,671 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1170
;Solar_Auto_Switcher.c,672 :: 		}
L_SetTimerOff_1171:
;Solar_Auto_Switcher.c,674 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1172:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1770
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1769
	JMP        L_SetTimerOff_1173
L__SetTimerOff_1770:
L__SetTimerOff_1769:
;Solar_Auto_Switcher.c,677 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1176
;Solar_Auto_Switcher.c,679 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1177:
	DEC        R16
	BRNE       L_SetTimerOff_1177
	DEC        R17
	BRNE       L_SetTimerOff_1177
	DEC        R18
	BRNE       L_SetTimerOff_1177
	NOP
;Solar_Auto_Switcher.c,680 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,681 :: 		}
L_SetTimerOff_1176:
;Solar_Auto_Switcher.c,682 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1179
;Solar_Auto_Switcher.c,684 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1180:
	DEC        R16
	BRNE       L_SetTimerOff_1180
	DEC        R17
	BRNE       L_SetTimerOff_1180
	DEC        R18
	BRNE       L_SetTimerOff_1180
	NOP
;Solar_Auto_Switcher.c,685 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,686 :: 		}
L_SetTimerOff_1179:
;Solar_Auto_Switcher.c,688 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_11011
	JMP        L_SetTimerOff_1182
L__SetTimerOff_11011:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1182:
;Solar_Auto_Switcher.c,689 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11012
	JMP        L_SetTimerOff_1183
L__SetTimerOff_11012:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1183:
;Solar_Auto_Switcher.c,691 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1172
L_SetTimerOff_1173:
;Solar_Auto_Switcher.c,692 :: 		} // end first while
	JMP        L_SetTimerOff_1169
L_SetTimerOff_1170:
;Solar_Auto_Switcher.c,694 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1184:
	DEC        R16
	BRNE       L_SetTimerOff_1184
	DEC        R17
	BRNE       L_SetTimerOff_1184
	DEC        R18
	BRNE       L_SetTimerOff_1184
	NOP
;Solar_Auto_Switcher.c,695 :: 		while (Set==1)
L_SetTimerOff_1186:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1187
;Solar_Auto_Switcher.c,697 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,699 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,703 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1188
;Solar_Auto_Switcher.c,705 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,706 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1187
;Solar_Auto_Switcher.c,707 :: 		}
L_SetTimerOff_1188:
;Solar_Auto_Switcher.c,709 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1189:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1772
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1771
	JMP        L_SetTimerOff_1190
L__SetTimerOff_1772:
L__SetTimerOff_1771:
;Solar_Auto_Switcher.c,711 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1193
;Solar_Auto_Switcher.c,713 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1194:
	DEC        R16
	BRNE       L_SetTimerOff_1194
	DEC        R17
	BRNE       L_SetTimerOff_1194
	DEC        R18
	BRNE       L_SetTimerOff_1194
	NOP
;Solar_Auto_Switcher.c,714 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,715 :: 		}
L_SetTimerOff_1193:
;Solar_Auto_Switcher.c,716 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1196
;Solar_Auto_Switcher.c,718 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1197:
	DEC        R16
	BRNE       L_SetTimerOff_1197
	DEC        R17
	BRNE       L_SetTimerOff_1197
	DEC        R18
	BRNE       L_SetTimerOff_1197
	NOP
;Solar_Auto_Switcher.c,719 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,720 :: 		}
L_SetTimerOff_1196:
;Solar_Auto_Switcher.c,721 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_11013
	JMP        L_SetTimerOff_1199
L__SetTimerOff_11013:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1199:
;Solar_Auto_Switcher.c,722 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11014
	JMP        L_SetTimerOff_1200
L__SetTimerOff_11014:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1200:
;Solar_Auto_Switcher.c,723 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1189
L_SetTimerOff_1190:
;Solar_Auto_Switcher.c,724 :: 		} // end first while
	JMP        L_SetTimerOff_1186
L_SetTimerOff_1187:
;Solar_Auto_Switcher.c,725 :: 		EEPROM_Write(0x03,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,726 :: 		EEPROM_Write(0x04,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,727 :: 		}
L_end_SetTimerOff_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetTimerOn_2:

;Solar_Auto_Switcher.c,730 :: 		void SetTimerOn_2()
;Solar_Auto_Switcher.c,732 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,733 :: 		LCD_OUT(1,1,"T2 On: [3]");
	LDI        R27, #lo_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,734 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2201:
	DEC        R16
	BRNE       L_SetTimerOn_2201
	DEC        R17
	BRNE       L_SetTimerOn_2201
	DEC        R18
	BRNE       L_SetTimerOn_2201
;Solar_Auto_Switcher.c,735 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,736 :: 		while (Set==1)
L_SetTimerOn_2203:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2204
;Solar_Auto_Switcher.c,742 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,743 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,744 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,745 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,747 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2205
;Solar_Auto_Switcher.c,749 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,750 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2204
;Solar_Auto_Switcher.c,751 :: 		}
L_SetTimerOn_2205:
;Solar_Auto_Switcher.c,754 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2206:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2776
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2775
	JMP        L_SetTimerOn_2207
L__SetTimerOn_2776:
L__SetTimerOn_2775:
;Solar_Auto_Switcher.c,756 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2210
;Solar_Auto_Switcher.c,758 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2211:
	DEC        R16
	BRNE       L_SetTimerOn_2211
	DEC        R17
	BRNE       L_SetTimerOn_2211
	DEC        R18
	BRNE       L_SetTimerOn_2211
	NOP
;Solar_Auto_Switcher.c,759 :: 		minutes_lcd_timer2_start++;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,760 :: 		}
L_SetTimerOn_2210:
;Solar_Auto_Switcher.c,761 :: 		if (Decrement==1 )
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2213
;Solar_Auto_Switcher.c,763 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2214:
	DEC        R16
	BRNE       L_SetTimerOn_2214
	DEC        R17
	BRNE       L_SetTimerOn_2214
	DEC        R18
	BRNE       L_SetTimerOn_2214
	NOP
;Solar_Auto_Switcher.c,764 :: 		minutes_lcd_timer2_start--;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,765 :: 		}
L_SetTimerOn_2213:
;Solar_Auto_Switcher.c,767 :: 		if (minutes_lcd_timer2_start>59)    minutes_lcd_timer2_start=0;
	LDS        R17, _minutes_lcd_timer2_start+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_21016
	JMP        L_SetTimerOn_2216
L__SetTimerOn_21016:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2216:
;Solar_Auto_Switcher.c,768 :: 		if (minutes_lcd_timer2_start<0)  minutes_lcd_timer2_start=0;
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21017
	JMP        L_SetTimerOn_2217
L__SetTimerOn_21017:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2217:
;Solar_Auto_Switcher.c,769 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_2206
L_SetTimerOn_2207:
;Solar_Auto_Switcher.c,770 :: 		} // end first while
	JMP        L_SetTimerOn_2203
L_SetTimerOn_2204:
;Solar_Auto_Switcher.c,772 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_2218:
	DEC        R16
	BRNE       L_SetTimerOn_2218
	DEC        R17
	BRNE       L_SetTimerOn_2218
	DEC        R18
	BRNE       L_SetTimerOn_2218
;Solar_Auto_Switcher.c,773 :: 		while (Set==1)
L_SetTimerOn_2220:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2221
;Solar_Auto_Switcher.c,775 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,777 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,782 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2222
;Solar_Auto_Switcher.c,784 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2221
;Solar_Auto_Switcher.c,785 :: 		}
L_SetTimerOn_2222:
;Solar_Auto_Switcher.c,787 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2223:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2778
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2777
	JMP        L_SetTimerOn_2224
L__SetTimerOn_2778:
L__SetTimerOn_2777:
;Solar_Auto_Switcher.c,789 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2227
;Solar_Auto_Switcher.c,791 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2228:
	DEC        R16
	BRNE       L_SetTimerOn_2228
	DEC        R17
	BRNE       L_SetTimerOn_2228
	DEC        R18
	BRNE       L_SetTimerOn_2228
	NOP
;Solar_Auto_Switcher.c,792 :: 		hours_lcd_timer2_start++;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,793 :: 		}
L_SetTimerOn_2227:
;Solar_Auto_Switcher.c,794 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2230
;Solar_Auto_Switcher.c,796 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2231:
	DEC        R16
	BRNE       L_SetTimerOn_2231
	DEC        R17
	BRNE       L_SetTimerOn_2231
	DEC        R18
	BRNE       L_SetTimerOn_2231
	NOP
;Solar_Auto_Switcher.c,797 :: 		hours_lcd_timer2_start--;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,798 :: 		}
L_SetTimerOn_2230:
;Solar_Auto_Switcher.c,800 :: 		if  (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
	LDS        R17, _hours_lcd_timer2_start+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_21018
	JMP        L_SetTimerOn_2233
L__SetTimerOn_21018:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2233:
;Solar_Auto_Switcher.c,801 :: 		if  (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21019
	JMP        L_SetTimerOn_2234
L__SetTimerOn_21019:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2234:
;Solar_Auto_Switcher.c,802 :: 		} // end while increment
	JMP        L_SetTimerOn_2223
L_SetTimerOn_2224:
;Solar_Auto_Switcher.c,803 :: 		} // end first while
	JMP        L_SetTimerOn_2220
L_SetTimerOn_2221:
;Solar_Auto_Switcher.c,805 :: 		EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_start+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,806 :: 		EEPROM_Write(0x19,minutes_lcd_timer2_start); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_start+0
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,807 :: 		}
L_end_SetTimerOn_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_2

_SetTimerOff_2:

;Solar_Auto_Switcher.c,809 :: 		void SetTimerOff_2()
;Solar_Auto_Switcher.c,811 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,812 :: 		LCD_OUT(1,1,"T2 Off: [4]");
	LDI        R27, #lo_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,813 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,814 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2235:
	DEC        R16
	BRNE       L_SetTimerOff_2235
	DEC        R17
	BRNE       L_SetTimerOff_2235
	DEC        R18
	BRNE       L_SetTimerOff_2235
	NOP
;Solar_Auto_Switcher.c,815 :: 		while (Set==1)
L_SetTimerOff_2237:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2238
;Solar_Auto_Switcher.c,821 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,822 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,823 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,824 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,825 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2239
	JMP        L_SetTimerOff_2238
L_SetTimerOff_2239:
;Solar_Auto_Switcher.c,827 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2240:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2782
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2781
	JMP        L_SetTimerOff_2241
L__SetTimerOff_2782:
L__SetTimerOff_2781:
;Solar_Auto_Switcher.c,829 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2244
;Solar_Auto_Switcher.c,831 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2245:
	DEC        R16
	BRNE       L_SetTimerOff_2245
	DEC        R17
	BRNE       L_SetTimerOff_2245
	DEC        R18
	BRNE       L_SetTimerOff_2245
	NOP
;Solar_Auto_Switcher.c,832 :: 		minutes_lcd_timer2_stop++;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,833 :: 		}
L_SetTimerOff_2244:
;Solar_Auto_Switcher.c,834 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2247
;Solar_Auto_Switcher.c,836 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2248:
	DEC        R16
	BRNE       L_SetTimerOff_2248
	DEC        R17
	BRNE       L_SetTimerOff_2248
	DEC        R18
	BRNE       L_SetTimerOff_2248
	NOP
;Solar_Auto_Switcher.c,837 :: 		minutes_lcd_timer2_stop--;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,838 :: 		}
L_SetTimerOff_2247:
;Solar_Auto_Switcher.c,840 :: 		if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
	LDS        R17, _minutes_lcd_timer2_stop+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_21021
	JMP        L_SetTimerOff_2250
L__SetTimerOff_21021:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2250:
;Solar_Auto_Switcher.c,841 :: 		if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21022
	JMP        L_SetTimerOff_2251
L__SetTimerOff_21022:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2251:
;Solar_Auto_Switcher.c,843 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2240
L_SetTimerOff_2241:
;Solar_Auto_Switcher.c,844 :: 		} // end first while
	JMP        L_SetTimerOff_2237
L_SetTimerOff_2238:
;Solar_Auto_Switcher.c,846 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2252:
	DEC        R16
	BRNE       L_SetTimerOff_2252
	DEC        R17
	BRNE       L_SetTimerOff_2252
	DEC        R18
	BRNE       L_SetTimerOff_2252
	NOP
;Solar_Auto_Switcher.c,847 :: 		while (Set==1)
L_SetTimerOff_2254:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2255
;Solar_Auto_Switcher.c,849 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,851 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,856 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2256
;Solar_Auto_Switcher.c,858 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,859 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_2255
;Solar_Auto_Switcher.c,860 :: 		}
L_SetTimerOff_2256:
;Solar_Auto_Switcher.c,862 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_2257:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2784
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2783
	JMP        L_SetTimerOff_2258
L__SetTimerOff_2784:
L__SetTimerOff_2783:
;Solar_Auto_Switcher.c,864 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2261
;Solar_Auto_Switcher.c,866 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2262:
	DEC        R16
	BRNE       L_SetTimerOff_2262
	DEC        R17
	BRNE       L_SetTimerOff_2262
	DEC        R18
	BRNE       L_SetTimerOff_2262
	NOP
;Solar_Auto_Switcher.c,867 :: 		hours_lcd_timer2_stop++;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,868 :: 		}
L_SetTimerOff_2261:
;Solar_Auto_Switcher.c,869 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2264
;Solar_Auto_Switcher.c,871 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2265:
	DEC        R16
	BRNE       L_SetTimerOff_2265
	DEC        R17
	BRNE       L_SetTimerOff_2265
	DEC        R18
	BRNE       L_SetTimerOff_2265
	NOP
;Solar_Auto_Switcher.c,872 :: 		hours_lcd_timer2_stop--;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,873 :: 		}
L_SetTimerOff_2264:
;Solar_Auto_Switcher.c,874 :: 		if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
	LDS        R17, _hours_lcd_timer2_stop+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_21023
	JMP        L_SetTimerOff_2267
L__SetTimerOff_21023:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2267:
;Solar_Auto_Switcher.c,875 :: 		if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21024
	JMP        L_SetTimerOff_2268
L__SetTimerOff_21024:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2268:
;Solar_Auto_Switcher.c,876 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2257
L_SetTimerOff_2258:
;Solar_Auto_Switcher.c,877 :: 		} // end first while
	JMP        L_SetTimerOff_2254
L_SetTimerOff_2255:
;Solar_Auto_Switcher.c,878 :: 		EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_timer2_stop+0
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,879 :: 		EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_timer2_stop+0
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,880 :: 		}
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

;Solar_Auto_Switcher.c,884 :: 		void SetDS1307_Time()
;Solar_Auto_Switcher.c,886 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,887 :: 		LCD_OUT(1,1,"Set Time [9]");
	LDI        R27, #lo_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,888 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time269:
	DEC        R16
	BRNE       L_SetDS1307_Time269
	DEC        R17
	BRNE       L_SetDS1307_Time269
	DEC        R18
	BRNE       L_SetDS1307_Time269
	NOP
;Solar_Auto_Switcher.c,889 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,890 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,892 :: 		while (Set==1)
L_SetDS1307_Time271:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time272
;Solar_Auto_Switcher.c,894 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,895 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,896 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,905 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time273
	JMP        L_SetDS1307_Time272
L_SetDS1307_Time273:
;Solar_Auto_Switcher.c,906 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time274:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time804
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time803
	JMP        L_SetDS1307_Time275
L__SetDS1307_Time804:
L__SetDS1307_Time803:
;Solar_Auto_Switcher.c,908 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time278
;Solar_Auto_Switcher.c,910 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time279:
	DEC        R16
	BRNE       L_SetDS1307_Time279
	DEC        R17
	BRNE       L_SetDS1307_Time279
	DEC        R18
	BRNE       L_SetDS1307_Time279
	NOP
;Solar_Auto_Switcher.c,911 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,913 :: 		}
L_SetDS1307_Time278:
;Solar_Auto_Switcher.c,914 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time281
;Solar_Auto_Switcher.c,916 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time282:
	DEC        R16
	BRNE       L_SetDS1307_Time282
	DEC        R17
	BRNE       L_SetDS1307_Time282
	DEC        R18
	BRNE       L_SetDS1307_Time282
	NOP
;Solar_Auto_Switcher.c,917 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,918 :: 		}
L_SetDS1307_Time281:
;Solar_Auto_Switcher.c,919 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time1026
	JMP        L_SetDS1307_Time284
L__SetDS1307_Time1026:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time284:
;Solar_Auto_Switcher.c,920 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1027
	JMP        L_SetDS1307_Time285
L__SetDS1307_Time1027:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time285:
;Solar_Auto_Switcher.c,921 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time274
L_SetDS1307_Time275:
;Solar_Auto_Switcher.c,922 :: 		} // end first while
	JMP        L_SetDS1307_Time271
L_SetDS1307_Time272:
;Solar_Auto_Switcher.c,924 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time286:
	DEC        R16
	BRNE       L_SetDS1307_Time286
	DEC        R17
	BRNE       L_SetDS1307_Time286
	DEC        R18
	BRNE       L_SetDS1307_Time286
	NOP
;Solar_Auto_Switcher.c,925 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,927 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time288:
	DEC        R16
	BRNE       L_SetDS1307_Time288
	DEC        R17
	BRNE       L_SetDS1307_Time288
	DEC        R18
	BRNE       L_SetDS1307_Time288
	NOP
;Solar_Auto_Switcher.c,928 :: 		while (Set==1)
L_SetDS1307_Time290:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time291
;Solar_Auto_Switcher.c,935 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,936 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,937 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,938 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time292
	JMP        L_SetDS1307_Time291
L_SetDS1307_Time292:
;Solar_Auto_Switcher.c,939 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time293:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time806
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time805
	JMP        L_SetDS1307_Time294
L__SetDS1307_Time806:
L__SetDS1307_Time805:
;Solar_Auto_Switcher.c,941 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time297
;Solar_Auto_Switcher.c,943 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time298:
	DEC        R16
	BRNE       L_SetDS1307_Time298
	DEC        R17
	BRNE       L_SetDS1307_Time298
	DEC        R18
	BRNE       L_SetDS1307_Time298
	NOP
;Solar_Auto_Switcher.c,944 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,945 :: 		}
L_SetDS1307_Time297:
;Solar_Auto_Switcher.c,947 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time300
;Solar_Auto_Switcher.c,949 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time301:
	DEC        R16
	BRNE       L_SetDS1307_Time301
	DEC        R17
	BRNE       L_SetDS1307_Time301
	DEC        R18
	BRNE       L_SetDS1307_Time301
	NOP
;Solar_Auto_Switcher.c,950 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,951 :: 		}
L_SetDS1307_Time300:
;Solar_Auto_Switcher.c,952 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1028
	JMP        L_SetDS1307_Time303
L__SetDS1307_Time1028:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time303:
;Solar_Auto_Switcher.c,953 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1029
	JMP        L_SetDS1307_Time304
L__SetDS1307_Time1029:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time304:
;Solar_Auto_Switcher.c,954 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time293
L_SetDS1307_Time294:
;Solar_Auto_Switcher.c,955 :: 		} // end first while
	JMP        L_SetDS1307_Time290
L_SetDS1307_Time291:
;Solar_Auto_Switcher.c,957 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time305:
	DEC        R16
	BRNE       L_SetDS1307_Time305
	DEC        R17
	BRNE       L_SetDS1307_Time305
	DEC        R18
	BRNE       L_SetDS1307_Time305
	NOP
;Solar_Auto_Switcher.c,958 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,960 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time307:
	DEC        R16
	BRNE       L_SetDS1307_Time307
	DEC        R17
	BRNE       L_SetDS1307_Time307
	DEC        R18
	BRNE       L_SetDS1307_Time307
	NOP
;Solar_Auto_Switcher.c,961 :: 		while (Set==1)
L_SetDS1307_Time309:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time310
;Solar_Auto_Switcher.c,966 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,967 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,968 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,969 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time311
	JMP        L_SetDS1307_Time310
L_SetDS1307_Time311:
;Solar_Auto_Switcher.c,970 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time312:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time808
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time807
	JMP        L_SetDS1307_Time313
L__SetDS1307_Time808:
L__SetDS1307_Time807:
;Solar_Auto_Switcher.c,972 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time316
;Solar_Auto_Switcher.c,974 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time317:
	DEC        R16
	BRNE       L_SetDS1307_Time317
	DEC        R17
	BRNE       L_SetDS1307_Time317
	DEC        R18
	BRNE       L_SetDS1307_Time317
	NOP
;Solar_Auto_Switcher.c,975 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,976 :: 		}
L_SetDS1307_Time316:
;Solar_Auto_Switcher.c,977 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time319
;Solar_Auto_Switcher.c,979 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time320:
	DEC        R16
	BRNE       L_SetDS1307_Time320
	DEC        R17
	BRNE       L_SetDS1307_Time320
	DEC        R18
	BRNE       L_SetDS1307_Time320
	NOP
;Solar_Auto_Switcher.c,980 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,981 :: 		}
L_SetDS1307_Time319:
;Solar_Auto_Switcher.c,982 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1030
	JMP        L_SetDS1307_Time322
L__SetDS1307_Time1030:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time322:
;Solar_Auto_Switcher.c,983 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1031
	JMP        L_SetDS1307_Time323
L__SetDS1307_Time1031:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time323:
;Solar_Auto_Switcher.c,986 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Auto_Switcher.c,987 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time312
L_SetDS1307_Time313:
;Solar_Auto_Switcher.c,988 :: 		} // end first while
	JMP        L_SetDS1307_Time309
L_SetDS1307_Time310:
;Solar_Auto_Switcher.c,990 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time324:
	DEC        R16
	BRNE       L_SetDS1307_Time324
	DEC        R17
	BRNE       L_SetDS1307_Time324
	DEC        R18
	BRNE       L_SetDS1307_Time324
;Solar_Auto_Switcher.c,991 :: 		LCD_Clear(1,1,16);  // clear the lcd first row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,992 :: 		LCD_CLear(2,1,16); // clear the lcd two row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,995 :: 		set_ds1307_day=ReadDate(0x04);
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,996 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time326:
	DEC        R16
	BRNE       L_SetDS1307_Time326
	DEC        R17
	BRNE       L_SetDS1307_Time326
	DEC        R18
	BRNE       L_SetDS1307_Time326
	NOP
;Solar_Auto_Switcher.c,997 :: 		while (Set==1)
L_SetDS1307_Time328:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time329
;Solar_Auto_Switcher.c,999 :: 		ByteToStr(set_ds1307_day,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_day+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1000 :: 		LCD_OUT(2,1,"D:");
	LDI        R27, #lo_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1001 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1002 :: 		LCD_OUT(2,12,"Y:");
	LDI        R27, #lo_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1003 :: 		LCD_Out(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1004 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time330
	JMP        L_SetDS1307_Time329
L_SetDS1307_Time330:
;Solar_Auto_Switcher.c,1005 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time331:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time810
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time809
	JMP        L_SetDS1307_Time332
L__SetDS1307_Time810:
L__SetDS1307_Time809:
;Solar_Auto_Switcher.c,1007 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time335
;Solar_Auto_Switcher.c,1009 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time336:
	DEC        R16
	BRNE       L_SetDS1307_Time336
	DEC        R17
	BRNE       L_SetDS1307_Time336
	DEC        R18
	BRNE       L_SetDS1307_Time336
	NOP
;Solar_Auto_Switcher.c,1010 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1011 :: 		}
L_SetDS1307_Time335:
;Solar_Auto_Switcher.c,1012 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time338
;Solar_Auto_Switcher.c,1014 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time339:
	DEC        R16
	BRNE       L_SetDS1307_Time339
	DEC        R17
	BRNE       L_SetDS1307_Time339
	DEC        R18
	BRNE       L_SetDS1307_Time339
	NOP
;Solar_Auto_Switcher.c,1015 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1016 :: 		}
L_SetDS1307_Time338:
;Solar_Auto_Switcher.c,1017 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time1032
	JMP        L_SetDS1307_Time341
L__SetDS1307_Time1032:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time341:
;Solar_Auto_Switcher.c,1018 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1033
	JMP        L_SetDS1307_Time342
L__SetDS1307_Time1033:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time342:
;Solar_Auto_Switcher.c,1019 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time331
L_SetDS1307_Time332:
;Solar_Auto_Switcher.c,1020 :: 		} //  end while set
	JMP        L_SetDS1307_Time328
L_SetDS1307_Time329:
;Solar_Auto_Switcher.c,1022 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time343:
	DEC        R16
	BRNE       L_SetDS1307_Time343
	DEC        R17
	BRNE       L_SetDS1307_Time343
	DEC        R18
	BRNE       L_SetDS1307_Time343
;Solar_Auto_Switcher.c,1023 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1026 :: 		set_ds1307_month=ReadDate(0x05);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1027 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time345:
	DEC        R16
	BRNE       L_SetDS1307_Time345
	DEC        R17
	BRNE       L_SetDS1307_Time345
	DEC        R18
	BRNE       L_SetDS1307_Time345
	NOP
;Solar_Auto_Switcher.c,1028 :: 		while (Set==1)
L_SetDS1307_Time347:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time348
;Solar_Auto_Switcher.c,1030 :: 		ByteToStr(set_ds1307_month,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_month+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1031 :: 		LCD_Out(2,8,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1032 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time349
	JMP        L_SetDS1307_Time348
L_SetDS1307_Time349:
;Solar_Auto_Switcher.c,1033 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time350:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time812
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time811
	JMP        L_SetDS1307_Time351
L__SetDS1307_Time812:
L__SetDS1307_Time811:
;Solar_Auto_Switcher.c,1035 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time354
;Solar_Auto_Switcher.c,1037 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time355:
	DEC        R16
	BRNE       L_SetDS1307_Time355
	DEC        R17
	BRNE       L_SetDS1307_Time355
	DEC        R18
	BRNE       L_SetDS1307_Time355
	NOP
;Solar_Auto_Switcher.c,1038 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1040 :: 		}
L_SetDS1307_Time354:
;Solar_Auto_Switcher.c,1041 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time357
;Solar_Auto_Switcher.c,1043 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time358:
	DEC        R16
	BRNE       L_SetDS1307_Time358
	DEC        R17
	BRNE       L_SetDS1307_Time358
	DEC        R18
	BRNE       L_SetDS1307_Time358
	NOP
;Solar_Auto_Switcher.c,1044 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1045 :: 		}
L_SetDS1307_Time357:
;Solar_Auto_Switcher.c,1046 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time1034
	JMP        L_SetDS1307_Time360
L__SetDS1307_Time1034:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time360:
;Solar_Auto_Switcher.c,1047 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1035
	JMP        L_SetDS1307_Time361
L__SetDS1307_Time1035:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time361:
;Solar_Auto_Switcher.c,1048 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time350
L_SetDS1307_Time351:
;Solar_Auto_Switcher.c,1049 :: 		} //  end while set
	JMP        L_SetDS1307_Time347
L_SetDS1307_Time348:
;Solar_Auto_Switcher.c,1051 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307_Time362:
	DEC        R16
	BRNE       L_SetDS1307_Time362
	DEC        R17
	BRNE       L_SetDS1307_Time362
	DEC        R18
	BRNE       L_SetDS1307_Time362
;Solar_Auto_Switcher.c,1052 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1055 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1056 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time364:
	DEC        R16
	BRNE       L_SetDS1307_Time364
	DEC        R17
	BRNE       L_SetDS1307_Time364
	DEC        R18
	BRNE       L_SetDS1307_Time364
	NOP
;Solar_Auto_Switcher.c,1057 :: 		while (Set==1)
L_SetDS1307_Time366:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time367
;Solar_Auto_Switcher.c,1059 :: 		ByteToStr(set_ds1307_year,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_year+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1060 :: 		LCD_Out(2,14,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1061 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time368
	JMP        L_SetDS1307_Time367
L_SetDS1307_Time368:
;Solar_Auto_Switcher.c,1062 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time369:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time814
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time813
	JMP        L_SetDS1307_Time370
L__SetDS1307_Time814:
L__SetDS1307_Time813:
;Solar_Auto_Switcher.c,1064 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time373
;Solar_Auto_Switcher.c,1066 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time374:
	DEC        R16
	BRNE       L_SetDS1307_Time374
	DEC        R17
	BRNE       L_SetDS1307_Time374
	DEC        R18
	BRNE       L_SetDS1307_Time374
	NOP
;Solar_Auto_Switcher.c,1067 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1069 :: 		}
L_SetDS1307_Time373:
;Solar_Auto_Switcher.c,1070 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time376
;Solar_Auto_Switcher.c,1072 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time377:
	DEC        R16
	BRNE       L_SetDS1307_Time377
	DEC        R17
	BRNE       L_SetDS1307_Time377
	DEC        R18
	BRNE       L_SetDS1307_Time377
	NOP
;Solar_Auto_Switcher.c,1073 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1074 :: 		}
L_SetDS1307_Time376:
;Solar_Auto_Switcher.c,1075 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time1036
	JMP        L_SetDS1307_Time379
L__SetDS1307_Time1036:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time379:
;Solar_Auto_Switcher.c,1076 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1037
	JMP        L_SetDS1307_Time380
L__SetDS1307_Time1037:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time380:
;Solar_Auto_Switcher.c,1078 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time369
L_SetDS1307_Time370:
;Solar_Auto_Switcher.c,1079 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
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
;Solar_Auto_Switcher.c,1080 :: 		} //  end while set
	JMP        L_SetDS1307_Time366
L_SetDS1307_Time367:
;Solar_Auto_Switcher.c,1081 :: 		}  // end setTimeAndData
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

;Solar_Auto_Switcher.c,1174 :: 		void SetLowBatteryVoltage()
;Solar_Auto_Switcher.c,1176 :: 		LCD_OUT(1,1,"Low Battery  [5]");
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
;Solar_Auto_Switcher.c,1177 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage381:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage381
	DEC        R17
	BRNE       L_SetLowBatteryVoltage381
	DEC        R18
	BRNE       L_SetLowBatteryVoltage381
	NOP
;Solar_Auto_Switcher.c,1178 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1179 :: 		while(Set==1)
L_SetLowBatteryVoltage383:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage384
;Solar_Auto_Switcher.c,1181 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1182 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1183 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1185 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage385
	JMP        L_SetLowBatteryVoltage384
L_SetLowBatteryVoltage385:
;Solar_Auto_Switcher.c,1186 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage386:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage788
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage787
	JMP        L_SetLowBatteryVoltage387
L__SetLowBatteryVoltage788:
L__SetLowBatteryVoltage787:
;Solar_Auto_Switcher.c,1188 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage390
;Solar_Auto_Switcher.c,1190 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage391:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage391
	DEC        R17
	BRNE       L_SetLowBatteryVoltage391
	DEC        R18
	BRNE       L_SetLowBatteryVoltage391
	NOP
;Solar_Auto_Switcher.c,1191 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Auto_Switcher.c,1193 :: 		}
L_SetLowBatteryVoltage390:
;Solar_Auto_Switcher.c,1194 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage393
;Solar_Auto_Switcher.c,1196 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage394:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage394
	DEC        R17
	BRNE       L_SetLowBatteryVoltage394
	DEC        R18
	BRNE       L_SetLowBatteryVoltage394
	NOP
;Solar_Auto_Switcher.c,1197 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Auto_Switcher.c,1198 :: 		}
L_SetLowBatteryVoltage393:
;Solar_Auto_Switcher.c,1199 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1039
	LDI        R16, 1
L__SetLowBatteryVoltage1039:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1040
	JMP        L_SetLowBatteryVoltage396
L__SetLowBatteryVoltage1040:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage396:
;Solar_Auto_Switcher.c,1200 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1041
	LDI        R16, 1
L__SetLowBatteryVoltage1041:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1042
	JMP        L_SetLowBatteryVoltage397
L__SetLowBatteryVoltage1042:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage397:
;Solar_Auto_Switcher.c,1201 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage386
L_SetLowBatteryVoltage387:
;Solar_Auto_Switcher.c,1202 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage383
L_SetLowBatteryVoltage384:
;Solar_Auto_Switcher.c,1203 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1205 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetLowBatteryVoltage398:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage398
	DEC        R17
	BRNE       L_SetLowBatteryVoltage398
	DEC        R18
	BRNE       L_SetLowBatteryVoltage398
;Solar_Auto_Switcher.c,1206 :: 		while(Set==1)
L_SetLowBatteryVoltage400:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage401
;Solar_Auto_Switcher.c,1208 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1209 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1210 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1212 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage402
	JMP        L_SetLowBatteryVoltage401
L_SetLowBatteryVoltage402:
;Solar_Auto_Switcher.c,1213 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage403:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage790
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage789
	JMP        L_SetLowBatteryVoltage404
L__SetLowBatteryVoltage790:
L__SetLowBatteryVoltage789:
;Solar_Auto_Switcher.c,1215 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage407
;Solar_Auto_Switcher.c,1217 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage408:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage408
	DEC        R17
	BRNE       L_SetLowBatteryVoltage408
	DEC        R18
	BRNE       L_SetLowBatteryVoltage408
	NOP
;Solar_Auto_Switcher.c,1218 :: 		Mini_Battery_Voltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1220 :: 		}
L_SetLowBatteryVoltage407:
;Solar_Auto_Switcher.c,1221 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage410
;Solar_Auto_Switcher.c,1223 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage411:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage411
	DEC        R17
	BRNE       L_SetLowBatteryVoltage411
	DEC        R18
	BRNE       L_SetLowBatteryVoltage411
	NOP
;Solar_Auto_Switcher.c,1224 :: 		Mini_Battery_Voltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1225 :: 		}
L_SetLowBatteryVoltage410:
;Solar_Auto_Switcher.c,1226 :: 		if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1043
	LDI        R16, 1
L__SetLowBatteryVoltage1043:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1044
	JMP        L_SetLowBatteryVoltage413
L__SetLowBatteryVoltage1044:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage413:
;Solar_Auto_Switcher.c,1227 :: 		if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1045
	LDI        R16, 1
L__SetLowBatteryVoltage1045:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1046
	JMP        L_SetLowBatteryVoltage414
L__SetLowBatteryVoltage1046:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage414:
;Solar_Auto_Switcher.c,1228 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage403
L_SetLowBatteryVoltage404:
;Solar_Auto_Switcher.c,1229 :: 		}// end while set
	JMP        L_SetLowBatteryVoltage400
L_SetLowBatteryVoltage401:
;Solar_Auto_Switcher.c,1231 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1232 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1233 :: 		}
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

;Solar_Auto_Switcher.c,1235 :: 		void SetStartUpLoadsVoltage()
;Solar_Auto_Switcher.c,1237 :: 		LCD_OUT(1,1,"Start Loads V[6]");
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
;Solar_Auto_Switcher.c,1238 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage415:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage415
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage415
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage415
	NOP
;Solar_Auto_Switcher.c,1239 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1240 :: 		while(Set==1)
L_SetStartUpLoadsVoltage417:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage418
;Solar_Auto_Switcher.c,1242 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1243 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1244 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1246 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage419
	JMP        L_SetStartUpLoadsVoltage418
L_SetStartUpLoadsVoltage419:
;Solar_Auto_Switcher.c,1247 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage420:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage794
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage793
	JMP        L_SetStartUpLoadsVoltage421
L__SetStartUpLoadsVoltage794:
L__SetStartUpLoadsVoltage793:
;Solar_Auto_Switcher.c,1249 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage424
;Solar_Auto_Switcher.c,1251 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage425:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage425
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage425
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage425
	NOP
;Solar_Auto_Switcher.c,1252 :: 		StartLoadsVoltage+=0.1;
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
;Solar_Auto_Switcher.c,1254 :: 		}
L_SetStartUpLoadsVoltage424:
;Solar_Auto_Switcher.c,1255 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage427
;Solar_Auto_Switcher.c,1257 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage428:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage428
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage428
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage428
	NOP
;Solar_Auto_Switcher.c,1258 :: 		StartLoadsVoltage-=0.1;
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
;Solar_Auto_Switcher.c,1259 :: 		}
L_SetStartUpLoadsVoltage427:
;Solar_Auto_Switcher.c,1260 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1048
	LDI        R16, 1
L__SetStartUpLoadsVoltage1048:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1049
	JMP        L_SetStartUpLoadsVoltage430
L__SetStartUpLoadsVoltage1049:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage430:
;Solar_Auto_Switcher.c,1261 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1050
	LDI        R16, 1
L__SetStartUpLoadsVoltage1050:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1051
	JMP        L_SetStartUpLoadsVoltage431
L__SetStartUpLoadsVoltage1051:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage431:
;Solar_Auto_Switcher.c,1262 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage420
L_SetStartUpLoadsVoltage421:
;Solar_Auto_Switcher.c,1263 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage417
L_SetStartUpLoadsVoltage418:
;Solar_Auto_Switcher.c,1265 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1266 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetStartUpLoadsVoltage432:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage432
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage432
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage432
;Solar_Auto_Switcher.c,1268 :: 		while(Set==1)
L_SetStartUpLoadsVoltage434:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage435
;Solar_Auto_Switcher.c,1270 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1271 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1272 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1274 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage436
	JMP        L_SetStartUpLoadsVoltage435
L_SetStartUpLoadsVoltage436:
;Solar_Auto_Switcher.c,1275 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage437:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage796
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage795
	JMP        L_SetStartUpLoadsVoltage438
L__SetStartUpLoadsVoltage796:
L__SetStartUpLoadsVoltage795:
;Solar_Auto_Switcher.c,1280 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage441
;Solar_Auto_Switcher.c,1282 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage442:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage442
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage442
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage442
	NOP
;Solar_Auto_Switcher.c,1283 :: 		StartLoadsVoltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1285 :: 		}
L_SetStartUpLoadsVoltage441:
;Solar_Auto_Switcher.c,1286 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage444
;Solar_Auto_Switcher.c,1288 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage445:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage445
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage445
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage445
	NOP
;Solar_Auto_Switcher.c,1289 :: 		StartLoadsVoltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1290 :: 		}
L_SetStartUpLoadsVoltage444:
;Solar_Auto_Switcher.c,1291 :: 		if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1052
	LDI        R16, 1
L__SetStartUpLoadsVoltage1052:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1053
	JMP        L_SetStartUpLoadsVoltage447
L__SetStartUpLoadsVoltage1053:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage447:
;Solar_Auto_Switcher.c,1292 :: 		if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1054
	LDI        R16, 1
L__SetStartUpLoadsVoltage1054:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1055
	JMP        L_SetStartUpLoadsVoltage448
L__SetStartUpLoadsVoltage1055:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage448:
;Solar_Auto_Switcher.c,1293 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage437
L_SetStartUpLoadsVoltage438:
;Solar_Auto_Switcher.c,1294 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage434
L_SetStartUpLoadsVoltage435:
;Solar_Auto_Switcher.c,1296 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);   // save float number to
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
;Solar_Auto_Switcher.c,1298 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1299 :: 		}
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

;Solar_Auto_Switcher.c,1301 :: 		void SetHighVoltage()
;Solar_Auto_Switcher.c,1303 :: 		LCD_OUT(1,1,"High AC Volt [7]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr31_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr31_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1304 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetHighVoltage449:
	DEC        R16
	BRNE       L_SetHighVoltage449
	DEC        R17
	BRNE       L_SetHighVoltage449
	DEC        R18
	BRNE       L_SetHighVoltage449
	NOP
;Solar_Auto_Switcher.c,1305 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1306 :: 		while(Set==1)
L_SetHighVoltage451:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetHighVoltage452
;Solar_Auto_Switcher.c,1308 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1309 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1310 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage453
	JMP        L_SetHighVoltage452
L_SetHighVoltage453:
;Solar_Auto_Switcher.c,1311 :: 		while(Increment==1 || Decrement==1)
L_SetHighVoltage454:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetHighVoltage823
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetHighVoltage822
	JMP        L_SetHighVoltage455
L__SetHighVoltage823:
L__SetHighVoltage822:
;Solar_Auto_Switcher.c,1313 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1314 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1315 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage458
;Solar_Auto_Switcher.c,1317 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage459:
	DEC        R16
	BRNE       L_SetHighVoltage459
	DEC        R17
	BRNE       L_SetHighVoltage459
	DEC        R18
	BRNE       L_SetHighVoltage459
	NOP
;Solar_Auto_Switcher.c,1318 :: 		High_Voltage++;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1319 :: 		}
L_SetHighVoltage458:
;Solar_Auto_Switcher.c,1320 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetHighVoltage461
;Solar_Auto_Switcher.c,1322 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage462:
	DEC        R16
	BRNE       L_SetHighVoltage462
	DEC        R17
	BRNE       L_SetHighVoltage462
	DEC        R18
	BRNE       L_SetHighVoltage462
	NOP
;Solar_Auto_Switcher.c,1323 :: 		High_Voltage--;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1324 :: 		}
L_SetHighVoltage461:
;Solar_Auto_Switcher.c,1325 :: 		if(High_Voltage > 255 ) High_Voltage=0;
	LDS        R18, _High_Voltage+0
	LDS        R19, _High_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetHighVoltage1057
	JMP        L_SetHighVoltage464
L__SetHighVoltage1057:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage464:
;Solar_Auto_Switcher.c,1326 :: 		if (High_Voltage < 0 ) High_Voltage=0;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CPI        R17, 0
	BRNE       L__SetHighVoltage1058
	CPI        R16, 0
L__SetHighVoltage1058:
	BRLO       L__SetHighVoltage1059
	JMP        L_SetHighVoltage465
L__SetHighVoltage1059:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage465:
;Solar_Auto_Switcher.c,1327 :: 		} // end while increment or decrement
	JMP        L_SetHighVoltage454
L_SetHighVoltage455:
;Solar_Auto_Switcher.c,1328 :: 		} // end while set
	JMP        L_SetHighVoltage451
L_SetHighVoltage452:
;Solar_Auto_Switcher.c,1329 :: 		EEPROM_Write(0x12,High_Voltage);
	LDS        R4, _High_Voltage+0
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1330 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1331 :: 		}
L_end_SetHighVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetHighVoltage

_SetLowVoltage:

;Solar_Auto_Switcher.c,1333 :: 		void SetLowVoltage()
;Solar_Auto_Switcher.c,1335 :: 		LCD_OUT(1,1,"Low AC Volt [8]");
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
;Solar_Auto_Switcher.c,1336 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowVoltage466:
	DEC        R16
	BRNE       L_SetLowVoltage466
	DEC        R17
	BRNE       L_SetLowVoltage466
	DEC        R18
	BRNE       L_SetLowVoltage466
	NOP
;Solar_Auto_Switcher.c,1337 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1338 :: 		while(Set==1)
L_SetLowVoltage468:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowVoltage469
;Solar_Auto_Switcher.c,1340 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1341 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1342 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage470
	JMP        L_SetLowVoltage469
L_SetLowVoltage470:
;Solar_Auto_Switcher.c,1343 :: 		while(Increment==1 || Decrement==1)
L_SetLowVoltage471:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowVoltage826
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowVoltage825
	JMP        L_SetLowVoltage472
L__SetLowVoltage826:
L__SetLowVoltage825:
;Solar_Auto_Switcher.c,1345 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1346 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1347 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage475
;Solar_Auto_Switcher.c,1349 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage476:
	DEC        R16
	BRNE       L_SetLowVoltage476
	DEC        R17
	BRNE       L_SetLowVoltage476
	DEC        R18
	BRNE       L_SetLowVoltage476
	NOP
;Solar_Auto_Switcher.c,1350 :: 		Low_Voltage++;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1351 :: 		}
L_SetLowVoltage475:
;Solar_Auto_Switcher.c,1352 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowVoltage478
;Solar_Auto_Switcher.c,1354 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage479:
	DEC        R16
	BRNE       L_SetLowVoltage479
	DEC        R17
	BRNE       L_SetLowVoltage479
	DEC        R18
	BRNE       L_SetLowVoltage479
	NOP
;Solar_Auto_Switcher.c,1355 :: 		Low_Voltage--;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1356 :: 		}
L_SetLowVoltage478:
;Solar_Auto_Switcher.c,1357 :: 		if(Low_Voltage > 255 ) Low_Voltage=0;
	LDS        R18, _Low_Voltage+0
	LDS        R19, _Low_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetLowVoltage1061
	JMP        L_SetLowVoltage481
L__SetLowVoltage1061:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage481:
;Solar_Auto_Switcher.c,1358 :: 		if (Low_Voltage < 0 ) Low_Voltage=0;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CPI        R17, 0
	BRNE       L__SetLowVoltage1062
	CPI        R16, 0
L__SetLowVoltage1062:
	BRLO       L__SetLowVoltage1063
	JMP        L_SetLowVoltage482
L__SetLowVoltage1063:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage482:
;Solar_Auto_Switcher.c,1359 :: 		} // end while increment or decrement
	JMP        L_SetLowVoltage471
L_SetLowVoltage472:
;Solar_Auto_Switcher.c,1360 :: 		} // end while set
	JMP        L_SetLowVoltage468
L_SetLowVoltage469:
;Solar_Auto_Switcher.c,1361 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1362 :: 		EEPROM_Write(0x13,Low_Voltage);
	LDS        R4, _Low_Voltage+0
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1363 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1364 :: 		}
L_end_SetLowVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowVoltage

_Startup_Timers:

;Solar_Auto_Switcher.c,1368 :: 		void Startup_Timers()
;Solar_Auto_Switcher.c,1370 :: 		LCD_OUT(1,1,"Start Loads [15]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1371 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers483:
	DEC        R16
	BRNE       L_Startup_Timers483
	DEC        R17
	BRNE       L_Startup_Timers483
	DEC        R18
	BRNE       L_Startup_Timers483
	NOP
;Solar_Auto_Switcher.c,1372 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1373 :: 		while(Set==1)
L_Startup_Timers485:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers486
;Solar_Auto_Switcher.c,1375 :: 		IntToStr(startupTIme_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_1+0
	LDS        R3, _startupTIme_1+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1376 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1378 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1379 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers487
	JMP        L_Startup_Timers486
L_Startup_Timers487:
;Solar_Auto_Switcher.c,1380 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers488:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers818
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers817
	JMP        L_Startup_Timers489
L__Startup_Timers818:
L__Startup_Timers817:
;Solar_Auto_Switcher.c,1382 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers492
;Solar_Auto_Switcher.c,1385 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers493:
	DEC        R16
	BRNE       L_Startup_Timers493
	DEC        R17
	BRNE       L_Startup_Timers493
	DEC        R18
	BRNE       L_Startup_Timers493
;Solar_Auto_Switcher.c,1386 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1387 :: 		}
L_Startup_Timers492:
;Solar_Auto_Switcher.c,1388 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers495
;Solar_Auto_Switcher.c,1391 :: 		Delay_ms(100);
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
;Solar_Auto_Switcher.c,1392 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1393 :: 		}
L_Startup_Timers495:
;Solar_Auto_Switcher.c,1394 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1065
	JMP        L_Startup_Timers498
L__Startup_Timers1065:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers498:
;Solar_Auto_Switcher.c,1395 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1066
	CPI        R16, 0
L__Startup_Timers1066:
	BRLO       L__Startup_Timers1067
	JMP        L_Startup_Timers499
L__Startup_Timers1067:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers499:
;Solar_Auto_Switcher.c,1396 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers488
L_Startup_Timers489:
;Solar_Auto_Switcher.c,1397 :: 		} // end while main while set
	JMP        L_Startup_Timers485
L_Startup_Timers486:
;Solar_Auto_Switcher.c,1398 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1400 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_Startup_Timers500:
	DEC        R16
	BRNE       L_Startup_Timers500
	DEC        R17
	BRNE       L_Startup_Timers500
	DEC        R18
	BRNE       L_Startup_Timers500
;Solar_Auto_Switcher.c,1401 :: 		while (Set==1)
L_Startup_Timers502:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers503
;Solar_Auto_Switcher.c,1403 :: 		IntToStr(startupTIme_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_2+0
	LDS        R3, _startupTIme_2+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1404 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr35_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr35_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1406 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1407 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers504
	JMP        L_Startup_Timers503
L_Startup_Timers504:
;Solar_Auto_Switcher.c,1408 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers505:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers820
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers819
	JMP        L_Startup_Timers506
L__Startup_Timers820:
L__Startup_Timers819:
;Solar_Auto_Switcher.c,1410 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers509
;Solar_Auto_Switcher.c,1413 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers510:
	DEC        R16
	BRNE       L_Startup_Timers510
	DEC        R17
	BRNE       L_Startup_Timers510
	DEC        R18
	BRNE       L_Startup_Timers510
;Solar_Auto_Switcher.c,1414 :: 		startupTIme_2++;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1415 :: 		}
L_Startup_Timers509:
;Solar_Auto_Switcher.c,1416 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers512
;Solar_Auto_Switcher.c,1419 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers513:
	DEC        R16
	BRNE       L_Startup_Timers513
	DEC        R17
	BRNE       L_Startup_Timers513
	DEC        R18
	BRNE       L_Startup_Timers513
;Solar_Auto_Switcher.c,1420 :: 		startupTIme_2--;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1421 :: 		}
L_Startup_Timers512:
;Solar_Auto_Switcher.c,1422 :: 		if(startupTIme_2 > 600 ) startupTIme_2=0;
	LDS        R18, _startupTIme_2+0
	LDS        R19, _startupTIme_2+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1068
	JMP        L_Startup_Timers515
L__Startup_Timers1068:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers515:
;Solar_Auto_Switcher.c,1423 :: 		if (startupTIme_2<0) startupTIme_2=0;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1069
	CPI        R16, 0
L__Startup_Timers1069:
	BRLO       L__Startup_Timers1070
	JMP        L_Startup_Timers516
L__Startup_Timers1070:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers516:
;Solar_Auto_Switcher.c,1424 :: 		} // end while increment and decrement
	JMP        L_Startup_Timers505
L_Startup_Timers506:
;Solar_Auto_Switcher.c,1425 :: 		} // end while set
	JMP        L_Startup_Timers502
L_Startup_Timers503:
;Solar_Auto_Switcher.c,1428 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1429 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1432 :: 		} // end  function
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

;Solar_Auto_Switcher.c,1460 :: 		void Screen_1()
;Solar_Auto_Switcher.c,1464 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Auto_Switcher.c,1465 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Auto_Switcher.c,1466 :: 		CalculateAC();
	CALL       _CalculateAC+0
;Solar_Auto_Switcher.c,1467 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Auto_Switcher.c,1469 :: 		void ADCBattery()
;Solar_Auto_Switcher.c,1471 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Auto_Switcher.c,1472 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Auto_Switcher.c,1473 :: 		ADPS2_Bit=1;
	LDS        R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	STS        ADPS2_bit+0, R27
;Solar_Auto_Switcher.c,1474 :: 		ADPS1_Bit=1;
	LDS        R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	STS        ADPS1_bit+0, R27
;Solar_Auto_Switcher.c,1475 :: 		ADPS0_Bit=0;
	LDS        R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	STS        ADPS0_bit+0, R27
;Solar_Auto_Switcher.c,1476 :: 		}
L_end_ADCBattery:
	POP        R2
	RET
; end of _ADCBattery

_Read_Battery:

;Solar_Auto_Switcher.c,1478 :: 		void Read_Battery()
;Solar_Auto_Switcher.c,1480 :: 		ADC_Value=ADC_Read(1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Auto_Switcher.c,1481 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
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
;Solar_Auto_Switcher.c,1484 :: 		Vin_Battery=((10.5/0.5)*Battery_Voltage); // 0.3 volt error from reading
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 168
	LDI        R23, 65
	CALL       _float_fpmul1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
;Solar_Auto_Switcher.c,1485 :: 		LCD_OUT(2,1,"V=");
	LDI        R27, #lo_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1486 :: 		sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_37_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_37_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1487 :: 		LCD_OUT(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1489 :: 		}
L_end_Read_Battery:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Read_Battery

_LowBatteryVoltageAlarm:

;Solar_Auto_Switcher.c,1492 :: 		void LowBatteryVoltageAlarm()
;Solar_Auto_Switcher.c,1494 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
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
	BREQ       L__LowBatteryVoltageAlarm1075
	LDI        R16, 1
L__LowBatteryVoltageAlarm1075:
	TST        R16
	BRNE       L__LowBatteryVoltageAlarm1076
	JMP        L__LowBatteryVoltageAlarm848
L__LowBatteryVoltageAlarm1076:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__LowBatteryVoltageAlarm1077
	JMP        L__LowBatteryVoltageAlarm847
L__LowBatteryVoltageAlarm1077:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1078
	JMP        L__LowBatteryVoltageAlarm846
L__LowBatteryVoltageAlarm1078:
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1079
	JMP        L__LowBatteryVoltageAlarm845
L__LowBatteryVoltageAlarm1079:
	JMP        L_LowBatteryVoltageAlarm521
L__LowBatteryVoltageAlarm846:
L__LowBatteryVoltageAlarm845:
L__LowBatteryVoltageAlarm843:
;Solar_Auto_Switcher.c,1496 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1497 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm522:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm522
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm522
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm522
	NOP
;Solar_Auto_Switcher.c,1498 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1499 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm524:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm524
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm524
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm524
	NOP
;Solar_Auto_Switcher.c,1500 :: 		}
L_LowBatteryVoltageAlarm521:
;Solar_Auto_Switcher.c,1494 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
L__LowBatteryVoltageAlarm848:
L__LowBatteryVoltageAlarm847:
;Solar_Auto_Switcher.c,1501 :: 		}
L_end_LowBatteryVoltageAlarm:
	RET
; end of _LowBatteryVoltageAlarm

_ReadAC:

;Solar_Auto_Switcher.c,1503 :: 		unsigned int ReadAC()
;Solar_Auto_Switcher.c,1505 :: 		char numberOfSamples=100;
	PUSH       R2
;Solar_Auto_Switcher.c,1506 :: 		char numberOfAverage=10;
;Solar_Auto_Switcher.c,1507 :: 		unsigned long sum=0;
;Solar_Auto_Switcher.c,1508 :: 		unsigned long r=0;
;Solar_Auto_Switcher.c,1509 :: 		unsigned long max_v=0;
; max_v start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
;Solar_Auto_Switcher.c,1510 :: 		char i=0;
;Solar_Auto_Switcher.c,1511 :: 		char j=0;
;Solar_Auto_Switcher.c,1512 :: 		unsigned long average=0;
;Solar_Auto_Switcher.c,1514 :: 		for (i=0;i<100;i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; max_v end address is: 19 (R19)
; i end address is: 18 (R18)
L_ReadAC526:
; i start address is: 18 (R18)
; max_v start address is: 19 (R19)
	CPI        R18, 100
	BRLO       L__ReadAC1081
	JMP        L_ReadAC527
L__ReadAC1081:
;Solar_Auto_Switcher.c,1516 :: 		r=ADC_Read(3);
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
;Solar_Auto_Switcher.c,1517 :: 		if (max_v<r) max_v=r;
	CP         R19, R23
	CPC        R20, R24
	CPC        R21, R25
	CPC        R22, R26
	BRLO       L__ReadAC1082
	JMP        L__ReadAC760
L__ReadAC1082:
	MOV        R19, R23
	MOV        R20, R24
	MOV        R21, R25
	MOV        R22, R26
; r end address is: 23 (R23)
; max_v end address is: 19 (R19)
	JMP        L_ReadAC529
L__ReadAC760:
L_ReadAC529:
;Solar_Auto_Switcher.c,1518 :: 		delay_us(200);
; max_v start address is: 19 (R19)
	LDI        R17, 3
	LDI        R16, 19
L_ReadAC530:
	DEC        R16
	BRNE       L_ReadAC530
	DEC        R17
	BRNE       L_ReadAC530
;Solar_Auto_Switcher.c,1514 :: 		for (i=0;i<100;i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Solar_Auto_Switcher.c,1519 :: 		}
; i end address is: 18 (R18)
	JMP        L_ReadAC526
L_ReadAC527:
;Solar_Auto_Switcher.c,1520 :: 		return max_v;
	MOV        R16, R19
	MOV        R17, R20
; max_v end address is: 19 (R19)
;Solar_Auto_Switcher.c,1534 :: 		}
;Solar_Auto_Switcher.c,1520 :: 		return max_v;
;Solar_Auto_Switcher.c,1534 :: 		}
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

;Solar_Auto_Switcher.c,1536 :: 		void CalculateAC()
;Solar_Auto_Switcher.c,1539 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,1540 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,1541 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1542 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,1543 :: 		v=v+Error_Voltage;
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
;Solar_Auto_Switcher.c,1545 :: 		if (AC_Available==0 && VoltageProtectionEnable==1)   // disable the ac voltage if voltage protector is enabeled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__CalculateAC840
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CalculateAC1084
	JMP        L__CalculateAC839
L__CalculateAC1084:
L__CalculateAC838:
;Solar_Auto_Switcher.c,1547 :: 		sprintf(buf,"%4.0fV",v);
	MOVW       R20, R28
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_38_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_38_Solar_Auto_Switcher+0)
	PUSH       R27
	PUSH       R21
	PUSH       R20
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1548 :: 		LCD_OUT(2,8,"-");
	LDI        R27, #lo_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1549 :: 		LCD_OUT(2,9,buf);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1550 :: 		}
	JMP        L_CalculateAC535
;Solar_Auto_Switcher.c,1545 :: 		if (AC_Available==0 && VoltageProtectionEnable==1)   // disable the ac voltage if voltage protector is enabeled
L__CalculateAC840:
L__CalculateAC839:
;Solar_Auto_Switcher.c,1551 :: 		else if (AC_Available== 0 && VoltageProtectionEnable==0) // in this if voltage protector is turned of no need for voltage read
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__CalculateAC842
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__CalculateAC1085
	JMP        L__CalculateAC841
L__CalculateAC1085:
L__CalculateAC837:
;Solar_Auto_Switcher.c,1553 :: 		LCD_out(2,8,"- Grid");
	LDI        R27, #lo_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1551 :: 		else if (AC_Available== 0 && VoltageProtectionEnable==0) // in this if voltage protector is turned of no need for voltage read
L__CalculateAC842:
L__CalculateAC841:
;Solar_Auto_Switcher.c,1554 :: 		}
L_CalculateAC535:
;Solar_Auto_Switcher.c,1555 :: 		VoltageProtector(v);
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _VoltageProtector+0
;Solar_Auto_Switcher.c,1556 :: 		}
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

;Solar_Auto_Switcher.c,1560 :: 		void VoltageProtector(unsigned long voltage)
;Solar_Auto_Switcher.c,1563 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRSH       L__VoltageProtector1087
	JMP        L__VoltageProtector832
L__VoltageProtector1087:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRSH       L__VoltageProtector1088
	JMP        L__VoltageProtector831
L__VoltageProtector1088:
	JMP        L_VoltageProtector543
L__VoltageProtector832:
L__VoltageProtector831:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector833
L__VoltageProtector829:
;Solar_Auto_Switcher.c,1565 :: 		VoltageProtectorGood=0;
	LDI        R27, 0
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1566 :: 		}
L_VoltageProtector543:
;Solar_Auto_Switcher.c,1563 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
L__VoltageProtector833:
;Solar_Auto_Switcher.c,1568 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRLO       L__VoltageProtector1089
	JMP        L__VoltageProtector836
L__VoltageProtector1089:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRLO       L__VoltageProtector1090
	JMP        L__VoltageProtector835
L__VoltageProtector1090:
L__VoltageProtector828:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector834
L__VoltageProtector827:
;Solar_Auto_Switcher.c,1570 :: 		VoltageProtectorGood=1;
	LDI        R27, 1
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1568 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
L__VoltageProtector836:
L__VoltageProtector835:
L__VoltageProtector834:
;Solar_Auto_Switcher.c,1572 :: 		}
L_end_VoltageProtector:
	RET
; end of _VoltageProtector

_ErrorList:

;Solar_Auto_Switcher.c,1574 :: 		void ErrorList()
;Solar_Auto_Switcher.c,1587 :: 		}
L_end_ErrorList:
	RET
; end of _ErrorList

_Start_Timer_0_A:

;Solar_Auto_Switcher.c,1590 :: 		void Start_Timer_0_A()
;Solar_Auto_Switcher.c,1592 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Auto_Switcher.c,1593 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Auto_Switcher.c,1594 :: 		WGM02_bit=0;
	IN         R27, WGM02_bit+0
	CBR        R27, BitMask(WGM02_bit+0)
	OUT        WGM02_bit+0, R27
;Solar_Auto_Switcher.c,1595 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1596 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1597 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1598 :: 		OCR0A=0xFF;
	LDI        R27, 255
	OUT        OCR0A+0, R27
;Solar_Auto_Switcher.c,1599 :: 		OCIE0A_Bit=1;
	LDS        R27, OCIE0A_bit+0
	SBR        R27, BitMask(OCIE0A_bit+0)
	STS        OCIE0A_bit+0, R27
;Solar_Auto_Switcher.c,1600 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_A_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,1602 :: 		void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
;Solar_Auto_Switcher.c,1604 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1605 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Auto_Switcher.c,1606 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Auto_Switcher.c,1607 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Auto_Switcher.c,1610 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1094
	CPI        R18, 244
L__Interupt_Timer_0_A_OFFTime1094:
	BREQ       L__Interupt_Timer_0_A_OFFTime1095
	JMP        L_Interupt_Timer_0_A_OFFTime549
L__Interupt_Timer_0_A_OFFTime1095:
;Solar_Auto_Switcher.c,1613 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1096
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1096:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1097
	JMP        L__Interupt_Timer_0_A_OFFTime853
L__Interupt_Timer_0_A_OFFTime1097:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime852
L__Interupt_Timer_0_A_OFFTime851:
;Solar_Auto_Switcher.c,1615 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1616 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime553:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime553
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime553
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime553
	NOP
;Solar_Auto_Switcher.c,1617 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1618 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1613 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime853:
L__Interupt_Timer_0_A_OFFTime852:
;Solar_Auto_Switcher.c,1620 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Auto_Switcher.c,1621 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1622 :: 		}
L_Interupt_Timer_0_A_OFFTime549:
;Solar_Auto_Switcher.c,1625 :: 		if (Timer_Counter_4==500)              // more than 10 seconds
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	CPI        R17, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1098
	CPI        R16, 244
L__Interupt_Timer_0_A_OFFTime1098:
	BREQ       L__Interupt_Timer_0_A_OFFTime1099
	JMP        L_Interupt_Timer_0_A_OFFTime555
L__Interupt_Timer_0_A_OFFTime1099:
;Solar_Auto_Switcher.c,1628 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1100
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1100:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1101
	JMP        L__Interupt_Timer_0_A_OFFTime855
L__Interupt_Timer_0_A_OFFTime1101:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime854
L__Interupt_Timer_0_A_OFFTime850:
;Solar_Auto_Switcher.c,1630 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1631 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime559:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime559
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime559
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime559
	NOP
;Solar_Auto_Switcher.c,1632 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1633 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1628 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime855:
L__Interupt_Timer_0_A_OFFTime854:
;Solar_Auto_Switcher.c,1635 :: 		Timer_Counter_4=0;
	LDI        R27, 0
	STS        _Timer_Counter_4+0, R27
	STS        _Timer_Counter_4+1, R27
;Solar_Auto_Switcher.c,1636 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1637 :: 		}
L_Interupt_Timer_0_A_OFFTime555:
;Solar_Auto_Switcher.c,1641 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_A_OFFTime1102
	CPI        R16, 232
L__Interupt_Timer_0_A_OFFTime1102:
	BREQ       L__Interupt_Timer_0_A_OFFTime1103
	JMP        L_Interupt_Timer_0_A_OFFTime561
L__Interupt_Timer_0_A_OFFTime1103:
;Solar_Auto_Switcher.c,1643 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1104
	JMP        L__Interupt_Timer_0_A_OFFTime857
L__Interupt_Timer_0_A_OFFTime1104:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime856
L__Interupt_Timer_0_A_OFFTime849:
;Solar_Auto_Switcher.c,1645 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1646 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1647 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1648 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1643 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
L__Interupt_Timer_0_A_OFFTime857:
L__Interupt_Timer_0_A_OFFTime856:
;Solar_Auto_Switcher.c,1650 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Auto_Switcher.c,1651 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1652 :: 		}
L_Interupt_Timer_0_A_OFFTime561:
;Solar_Auto_Switcher.c,1654 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1655 :: 		OCF0A_Bit=1; // clear
	IN         R27, OCF0A_bit+0
	SBR        R27, BitMask(OCF0A_bit+0)
	OUT        OCF0A_bit+0, R27
;Solar_Auto_Switcher.c,1656 :: 		}
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

;Solar_Auto_Switcher.c,1658 :: 		void Stop_Timer_0()
;Solar_Auto_Switcher.c,1660 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1661 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Auto_Switcher.c,1662 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1663 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Auto_Switcher.c,1666 :: 		void EEPROM_FactorySettings(char period)
;Solar_Auto_Switcher.c,1668 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1107
	JMP        L_EEPROM_FactorySettings565
L__EEPROM_FactorySettings1107:
;Solar_Auto_Switcher.c,1670 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1671 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1672 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1673 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1674 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1675 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1677 :: 		EEPROM_Write(0x00,8);  // writing start hours
	PUSH       R2
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1678 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1679 :: 		EEPROM_Write(0x03,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1680 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1682 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1683 :: 		EEPROM_Write(0x19,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1684 :: 		EEPROM_Write(0x20,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1685 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1687 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1688 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1689 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1690 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1691 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1692 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1693 :: 		}
L_EEPROM_FactorySettings565:
;Solar_Auto_Switcher.c,1694 :: 		if (period==0) // winter timer
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1108
	JMP        L_EEPROM_FactorySettings566
L__EEPROM_FactorySettings1108:
;Solar_Auto_Switcher.c,1696 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1697 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1698 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1699 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1700 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1701 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1703 :: 		EEPROM_Write(0x00,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1704 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1705 :: 		EEPROM_Write(0x03,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1706 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1708 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1709 :: 		EEPROM_Write(0x19,30);    // writing  start minutes
	LDI        R27, 30
	MOV        R4, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1710 :: 		EEPROM_Write(0x20,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1711 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1713 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1714 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1715 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1716 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1717 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1718 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1719 :: 		}
L_EEPROM_FactorySettings566:
;Solar_Auto_Switcher.c,1721 :: 		EEPROM_Write(0x12,255); //  high voltage Grid
	LDI        R27, 255
	MOV        R4, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1722 :: 		EEPROM_Write(0x13,170); // load low voltage
	LDI        R27, 170
	MOV        R4, R27
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1723 :: 		EEPROM_Write(0x49,0); //  timer1_ison
	CLR        R4
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1724 :: 		EEPROM_Write(0x50,0); // timer2_is on
	CLR        R4
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1725 :: 		EEPROM_Write(0x15,0); // voltage protector not enabled as default
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1726 :: 		}
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

;Solar_Auto_Switcher.c,1728 :: 		RunTimersNowCheck()
;Solar_Auto_Switcher.c,1748 :: 		if(Increment==1 && Exit==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck869
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck868
L__RunTimersNowCheck865:
;Solar_Auto_Switcher.c,1750 :: 		Delay_ms(5000);
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
;Solar_Auto_Switcher.c,1751 :: 		if (Increment==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck867
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck866
L__RunTimersNowCheck864:
;Solar_Auto_Switcher.c,1753 :: 		RunLoadsByBass++;
	LDS        R16, _RunLoadsByBass+0
	SUBI       R16, 255
	STS        _RunLoadsByBass+0, R16
;Solar_Auto_Switcher.c,1754 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	CPI        R16, 1
	BREQ       L__RunTimersNowCheck1110
	JMP        L_RunTimersNowCheck575
L__RunTimersNowCheck1110:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_RunTimersNowCheck575:
;Solar_Auto_Switcher.c,1755 :: 		if (RunLoadsByBass>=2 )
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 2
	BRSH       L__RunTimersNowCheck1111
	JMP        L_RunTimersNowCheck576
L__RunTimersNowCheck1111:
;Solar_Auto_Switcher.c,1757 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck577:
	DEC        R16
	BRNE       L_RunTimersNowCheck577
	DEC        R17
	BRNE       L_RunTimersNowCheck577
	DEC        R18
	BRNE       L_RunTimersNowCheck577
	NOP
;Solar_Auto_Switcher.c,1758 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1759 :: 		}
L_RunTimersNowCheck576:
;Solar_Auto_Switcher.c,1760 :: 		LCD_OUT(1,15,"B");
	LDI        R27, #lo_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1751 :: 		if (Increment==1 && Exit==0)
L__RunTimersNowCheck867:
L__RunTimersNowCheck866:
;Solar_Auto_Switcher.c,1748 :: 		if(Increment==1 && Exit==0)
L__RunTimersNowCheck869:
L__RunTimersNowCheck868:
;Solar_Auto_Switcher.c,1764 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck875
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck874
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck873
L__RunTimersNowCheck863:
;Solar_Auto_Switcher.c,1766 :: 		Delay_ms(2000);
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
;Solar_Auto_Switcher.c,1767 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck872
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck871
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck870
L__RunTimersNowCheck862:
;Solar_Auto_Switcher.c,1769 :: 		Delay_ms(5000);
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
;Solar_Auto_Switcher.c,1770 :: 		EEPROM_FactorySettings(1);        // summer time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1771 :: 		Delay_ms(100);
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
;Solar_Auto_Switcher.c,1772 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1773 :: 		LCD_OUT(2,1,"Reset Summer    ");
	LDI        R27, #lo_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1774 :: 		Delay_ms(1000);
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
;Solar_Auto_Switcher.c,1775 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1767 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
L__RunTimersNowCheck872:
L__RunTimersNowCheck871:
L__RunTimersNowCheck870:
;Solar_Auto_Switcher.c,1764 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
L__RunTimersNowCheck875:
L__RunTimersNowCheck874:
L__RunTimersNowCheck873:
;Solar_Auto_Switcher.c,1778 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck881
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck880
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck879
L__RunTimersNowCheck861:
;Solar_Auto_Switcher.c,1780 :: 		Delay_ms(2000);
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
;Solar_Auto_Switcher.c,1781 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck878
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck877
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck876
L__RunTimersNowCheck860:
;Solar_Auto_Switcher.c,1783 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck601:
	DEC        R16
	BRNE       L_RunTimersNowCheck601
	DEC        R17
	BRNE       L_RunTimersNowCheck601
	DEC        R18
	BRNE       L_RunTimersNowCheck601
	NOP
;Solar_Auto_Switcher.c,1784 :: 		EEPROM_FactorySettings(0);        // winter time
	CLR        R2
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1785 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck603:
	DEC        R16
	BRNE       L_RunTimersNowCheck603
	DEC        R17
	BRNE       L_RunTimersNowCheck603
	DEC        R18
	BRNE       L_RunTimersNowCheck603
;Solar_Auto_Switcher.c,1786 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1787 :: 		LCD_OUT(2,1,"Reset Winter    ");
	LDI        R27, #lo_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1788 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck605:
	DEC        R16
	BRNE       L_RunTimersNowCheck605
	DEC        R17
	BRNE       L_RunTimersNowCheck605
	DEC        R18
	BRNE       L_RunTimersNowCheck605
;Solar_Auto_Switcher.c,1789 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1781 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
L__RunTimersNowCheck878:
L__RunTimersNowCheck877:
L__RunTimersNowCheck876:
;Solar_Auto_Switcher.c,1778 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
L__RunTimersNowCheck881:
L__RunTimersNowCheck880:
L__RunTimersNowCheck879:
;Solar_Auto_Switcher.c,1811 :: 		if(Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck885
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck884
L__RunTimersNowCheck859:
;Solar_Auto_Switcher.c,1813 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck610:
	DEC        R16
	BRNE       L_RunTimersNowCheck610
	DEC        R17
	BRNE       L_RunTimersNowCheck610
	DEC        R18
	BRNE       L_RunTimersNowCheck610
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1814 :: 		if (Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck883
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck882
L__RunTimersNowCheck858:
;Solar_Auto_Switcher.c,1816 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,1817 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Auto_Switcher.c,1818 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1819 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1821 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1814 :: 		if (Decrement==1 && Exit==0)
L__RunTimersNowCheck883:
L__RunTimersNowCheck882:
;Solar_Auto_Switcher.c,1811 :: 		if(Decrement==1 && Exit==0)
L__RunTimersNowCheck885:
L__RunTimersNowCheck884:
;Solar_Auto_Switcher.c,1824 :: 		}
L_end_RunTimersNowCheck:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_CheckForSet:

;Solar_Auto_Switcher.c,1827 :: 		void CheckForSet()
;Solar_Auto_Switcher.c,1830 :: 		if (Set==0 && Exit==0) SetUpProgram();
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForSet888
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__CheckForSet887
L__CheckForSet886:
	CALL       _SetUpProgram+0
L__CheckForSet888:
L__CheckForSet887:
;Solar_Auto_Switcher.c,1832 :: 		}
L_end_CheckForSet:
	RET
; end of _CheckForSet

_AutoRunWithOutBatteryProtection:

;Solar_Auto_Switcher.c,1835 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Auto_Switcher.c,1837 :: 		if (Vin_Battery==0)
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
	BREQ       L__AutoRunWithOutBatteryProtection1114
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection1114:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection1115
	JMP        L_AutoRunWithOutBatteryProtection618
L__AutoRunWithOutBatteryProtection1115:
;Solar_Auto_Switcher.c,1839 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1840 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection619
L_AutoRunWithOutBatteryProtection618:
;Solar_Auto_Switcher.c,1843 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1844 :: 		}
L_AutoRunWithOutBatteryProtection619:
;Solar_Auto_Switcher.c,1845 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Auto_Switcher.c,1847 :: 		void CheckForTimerActivationInRange()
;Solar_Auto_Switcher.c,1851 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1117
	JMP        L__CheckForTimerActivationInRange895
L__CheckForTimerActivationInRange1117:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1118
	JMP        L__CheckForTimerActivationInRange894
L__CheckForTimerActivationInRange1118:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1119
	JMP        L__CheckForTimerActivationInRange893
L__CheckForTimerActivationInRange1119:
L__CheckForTimerActivationInRange892:
;Solar_Auto_Switcher.c,1853 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1854 :: 		EEPROM_Write(0x49,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1851 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
L__CheckForTimerActivationInRange895:
L__CheckForTimerActivationInRange894:
L__CheckForTimerActivationInRange893:
;Solar_Auto_Switcher.c,1858 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1120
	JMP        L__CheckForTimerActivationInRange898
L__CheckForTimerActivationInRange1120:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1121
	JMP        L__CheckForTimerActivationInRange897
L__CheckForTimerActivationInRange1121:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1122
	JMP        L__CheckForTimerActivationInRange896
L__CheckForTimerActivationInRange1122:
L__CheckForTimerActivationInRange891:
;Solar_Auto_Switcher.c,1861 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1123
	JMP        L_CheckForTimerActivationInRange626
L__CheckForTimerActivationInRange1123:
;Solar_Auto_Switcher.c,1863 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1864 :: 		EEPROM_Write(0x49,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 73
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1865 :: 		}
L_CheckForTimerActivationInRange626:
;Solar_Auto_Switcher.c,1858 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
L__CheckForTimerActivationInRange898:
L__CheckForTimerActivationInRange897:
L__CheckForTimerActivationInRange896:
;Solar_Auto_Switcher.c,1893 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1124
	JMP        L__CheckForTimerActivationInRange901
L__CheckForTimerActivationInRange1124:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1125
	JMP        L__CheckForTimerActivationInRange900
L__CheckForTimerActivationInRange1125:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1126
	JMP        L__CheckForTimerActivationInRange899
L__CheckForTimerActivationInRange1126:
L__CheckForTimerActivationInRange890:
;Solar_Auto_Switcher.c,1895 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1896 :: 		EEPROM_Write(0x50,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1893 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange901:
L__CheckForTimerActivationInRange900:
L__CheckForTimerActivationInRange899:
;Solar_Auto_Switcher.c,1899 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1127
	JMP        L__CheckForTimerActivationInRange904
L__CheckForTimerActivationInRange1127:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1128
	JMP        L__CheckForTimerActivationInRange903
L__CheckForTimerActivationInRange1128:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1129
	JMP        L__CheckForTimerActivationInRange902
L__CheckForTimerActivationInRange1129:
L__CheckForTimerActivationInRange889:
;Solar_Auto_Switcher.c,1901 :: 		if(ReadMinutes()<minutes_lcd_timer2_stop)
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1130
	JMP        L_CheckForTimerActivationInRange633
L__CheckForTimerActivationInRange1130:
;Solar_Auto_Switcher.c,1903 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1904 :: 		EEPROM_Write(0x50,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 80
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1905 :: 		}
L_CheckForTimerActivationInRange633:
;Solar_Auto_Switcher.c,1899 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange904:
L__CheckForTimerActivationInRange903:
L__CheckForTimerActivationInRange902:
;Solar_Auto_Switcher.c,1931 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Auto_Switcher.c,1934 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Auto_Switcher.c,1937 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff909
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1132
	JMP        L__TurnLoadsOffWhenGridOff908
L__TurnLoadsOffWhenGridOff1132:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1133
	JMP        L__TurnLoadsOffWhenGridOff907
L__TurnLoadsOffWhenGridOff1133:
L__TurnLoadsOffWhenGridOff906:
;Solar_Auto_Switcher.c,1939 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1940 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1941 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1942 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1937 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__TurnLoadsOffWhenGridOff909:
L__TurnLoadsOffWhenGridOff908:
L__TurnLoadsOffWhenGridOff907:
;Solar_Auto_Switcher.c,1945 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff912
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1134
	JMP        L__TurnLoadsOffWhenGridOff911
L__TurnLoadsOffWhenGridOff1134:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1135
	JMP        L__TurnLoadsOffWhenGridOff910
L__TurnLoadsOffWhenGridOff1135:
L__TurnLoadsOffWhenGridOff905:
;Solar_Auto_Switcher.c,1947 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1948 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1949 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1950 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1945 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__TurnLoadsOffWhenGridOff912:
L__TurnLoadsOffWhenGridOff911:
L__TurnLoadsOffWhenGridOff910:
;Solar_Auto_Switcher.c,1953 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _TurnLoadsOffWhenGridOff

_CheckForVoltageProtection:

;Solar_Auto_Switcher.c,1955 :: 		CheckForVoltageProtection()
;Solar_Auto_Switcher.c,1957 :: 		if (VoltageProtectionEnable==1)  LCD_OUT(1,16,"P"); else LCD_OUT(1,16," ") ;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1137
	JMP        L_CheckForVoltageProtection640
L__CheckForVoltageProtection1137:
	LDI        R27, #lo_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_CheckForVoltageProtection641
L_CheckForVoltageProtection640:
	LDI        R27, #lo_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_CheckForVoltageProtection641:
;Solar_Auto_Switcher.c,1958 :: 		if(Exit==1 && Set==0 )
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection918
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection917
L__CheckForVoltageProtection914:
;Solar_Auto_Switcher.c,1960 :: 		delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_CheckForVoltageProtection645:
	DEC        R16
	BRNE       L_CheckForVoltageProtection645
	DEC        R17
	BRNE       L_CheckForVoltageProtection645
	DEC        R18
	BRNE       L_CheckForVoltageProtection645
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1961 :: 		if(Exit==1 && Set==0 ) {
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection916
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection915
L__CheckForVoltageProtection913:
;Solar_Auto_Switcher.c,1962 :: 		if (VoltageProtectorEnableFlag==1)         // protector as default is enabled so make it not enabled
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1138
	JMP        L_CheckForVoltageProtection650
L__CheckForVoltageProtection1138:
;Solar_Auto_Switcher.c,1964 :: 		VoltageProtectionEnable=0;
	LDI        R27, 0
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,1965 :: 		VoltageProtectorEnableFlag=0;
	LDI        R27, 0
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,1966 :: 		EEPROM_Write(0x15,0);
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1967 :: 		}
	JMP        L_CheckForVoltageProtection651
L_CheckForVoltageProtection650:
;Solar_Auto_Switcher.c,1968 :: 		else if ( VoltageProtectorEnableFlag==0)
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 0
	BREQ       L__CheckForVoltageProtection1139
	JMP        L_CheckForVoltageProtection652
L__CheckForVoltageProtection1139:
;Solar_Auto_Switcher.c,1970 :: 		VoltageProtectionEnable=1;
	LDI        R27, 1
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,1971 :: 		VoltageProtectorEnableFlag=1;
	LDI        R27, 1
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,1972 :: 		EEPROM_Write(0x15,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1973 :: 		}
L_CheckForVoltageProtection652:
L_CheckForVoltageProtection651:
;Solar_Auto_Switcher.c,1961 :: 		if(Exit==1 && Set==0 ) {
L__CheckForVoltageProtection916:
L__CheckForVoltageProtection915:
;Solar_Auto_Switcher.c,1958 :: 		if(Exit==1 && Set==0 )
L__CheckForVoltageProtection918:
L__CheckForVoltageProtection917:
;Solar_Auto_Switcher.c,1977 :: 		}
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

;Solar_Auto_Switcher.c,1979 :: 		void main() {
;Solar_Auto_Switcher.c,1980 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Auto_Switcher.c,1981 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Auto_Switcher.c,1982 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1983 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Auto_Switcher.c,1984 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Auto_Switcher.c,1985 :: 		ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
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
;Solar_Auto_Switcher.c,1986 :: 		ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
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
;Solar_Auto_Switcher.c,1987 :: 		ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1988 :: 		ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1989 :: 		ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1990 :: 		ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1991 :: 		while(1)
L_main653:
;Solar_Auto_Switcher.c,1993 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Auto_Switcher.c,1994 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Auto_Switcher.c,1995 :: 		CheckForSet();
	CALL       _CheckForSet+0
;Solar_Auto_Switcher.c,1996 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Auto_Switcher.c,1997 :: 		CheckForVoltageProtection();
	CALL       _CheckForVoltageProtection+0
;Solar_Auto_Switcher.c,1998 :: 		Screen_1();
	CALL       _Screen_1+0
;Solar_Auto_Switcher.c,1999 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Auto_Switcher.c,2000 :: 		TurnLoadsOffWhenGridOff();        // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Auto_Switcher.c,2003 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main655:
	DEC        R16
	BRNE       L_main655
	DEC        R17
	BRNE       L_main655
	DEC        R18
	BRNE       L_main655
	NOP
;Solar_Auto_Switcher.c,2004 :: 		} // end while
	JMP        L_main653
;Solar_Auto_Switcher.c,2005 :: 		}   // end main
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
