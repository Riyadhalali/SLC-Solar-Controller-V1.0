
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
	BRSH       L__LCD_Clear936
	JMP        L_LCD_Clear3
L__LCD_Clear936:
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
;Solar_Auto_Switcher.c,204 :: 		if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1661
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1939
	JMP        L__Interrupt_INT1660
L__Interrupt_INT1939:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1940
	JMP        L__Interrupt_INT1659
L__Interrupt_INT1940:
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
;Solar_Auto_Switcher.c,204 :: 		if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0)
L__Interrupt_INT1661:
L__Interrupt_INT1660:
L__Interrupt_INT1659:
;Solar_Auto_Switcher.c,213 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interrupt_INT1664
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1941
	JMP        L__Interrupt_INT1663
L__Interrupt_INT1941:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT1942
	JMP        L__Interrupt_INT1662
L__Interrupt_INT1942:
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
;Solar_Auto_Switcher.c,213 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__Interrupt_INT1664:
L__Interrupt_INT1663:
L__Interrupt_INT1662:
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
	BRLO       L__StoreBytesIntoEEprom945
	JMP        L_StoreBytesIntoEEprom12
L__StoreBytesIntoEEprom945:
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
	BRLO       L__ReadBytesFromEEprom947
	JMP        L_ReadBytesFromEEprom17
L__ReadBytesFromEEprom947:
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
	BREQ       L__Check_Timers949
	JMP        L_Check_Timers21
L__Check_Timers949:
;Solar_Auto_Switcher.c,287 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,288 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,292 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers691
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers950
	JMP        L__Check_Timers690
L__Check_Timers950:
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
	BREQ       L__Check_Timers951
	LDI        R16, 1
L__Check_Timers951:
	TST        R16
	BRNE       L__Check_Timers952
	JMP        L__Check_Timers689
L__Check_Timers952:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers953
	JMP        L__Check_Timers688
L__Check_Timers953:
L__Check_Timers687:
;Solar_Auto_Switcher.c,294 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,292 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false )
L__Check_Timers691:
L__Check_Timers690:
L__Check_Timers689:
L__Check_Timers688:
;Solar_Auto_Switcher.c,298 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers694
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers954
	JMP        L__Check_Timers693
L__Check_Timers954:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers955
	JMP        L__Check_Timers692
L__Check_Timers955:
L__Check_Timers686:
;Solar_Auto_Switcher.c,300 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,298 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers694:
L__Check_Timers693:
L__Check_Timers692:
;Solar_Auto_Switcher.c,302 :: 		} // end if ac_available
L_Check_Timers21:
;Solar_Auto_Switcher.c,305 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers956
	JMP        L_Check_Timers28
L__Check_Timers956:
;Solar_Auto_Switcher.c,307 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,310 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers697
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers957
	JMP        L__Check_Timers696
L__Check_Timers957:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers958
	JMP        L__Check_Timers695
L__Check_Timers958:
L__Check_Timers685:
;Solar_Auto_Switcher.c,313 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,314 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,310 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
L__Check_Timers697:
L__Check_Timers696:
L__Check_Timers695:
;Solar_Auto_Switcher.c,317 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers700
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers959
	JMP        L__Check_Timers699
L__Check_Timers959:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers960
	JMP        L__Check_Timers698
L__Check_Timers960:
L__Check_Timers684:
;Solar_Auto_Switcher.c,320 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,321 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,317 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
L__Check_Timers700:
L__Check_Timers699:
L__Check_Timers698:
;Solar_Auto_Switcher.c,323 :: 		}
L_Check_Timers28:
;Solar_Auto_Switcher.c,327 :: 		if (matched_timer_2_start==1)
	LDS        R16, _matched_timer_2_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers961
	JMP        L_Check_Timers35
L__Check_Timers961:
;Solar_Auto_Switcher.c,329 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,330 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,333 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers704
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers962
	JMP        L__Check_Timers703
L__Check_Timers962:
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
	BREQ       L__Check_Timers963
	LDI        R16, 1
L__Check_Timers963:
	TST        R16
	BRNE       L__Check_Timers964
	JMP        L__Check_Timers702
L__Check_Timers964:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers965
	JMP        L__Check_Timers701
L__Check_Timers965:
L__Check_Timers683:
;Solar_Auto_Switcher.c,335 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,333 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false)
L__Check_Timers704:
L__Check_Timers703:
L__Check_Timers702:
L__Check_Timers701:
;Solar_Auto_Switcher.c,339 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers707
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers966
	JMP        L__Check_Timers706
L__Check_Timers966:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers967
	JMP        L__Check_Timers705
L__Check_Timers967:
L__Check_Timers682:
;Solar_Auto_Switcher.c,341 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,339 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
L__Check_Timers707:
L__Check_Timers706:
L__Check_Timers705:
;Solar_Auto_Switcher.c,344 :: 		} // end if ac_available
L_Check_Timers35:
;Solar_Auto_Switcher.c,347 :: 		if (matched_timer_2_stop==1)
	LDS        R16, _matched_timer_2_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers968
	JMP        L_Check_Timers42
L__Check_Timers968:
;Solar_Auto_Switcher.c,349 :: 		Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,352 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers710
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers969
	JMP        L__Check_Timers709
L__Check_Timers969:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers970
	JMP        L__Check_Timers708
L__Check_Timers970:
L__Check_Timers681:
;Solar_Auto_Switcher.c,356 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,357 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,352 :: 		if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
L__Check_Timers710:
L__Check_Timers709:
L__Check_Timers708:
;Solar_Auto_Switcher.c,361 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers713
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers971
	JMP        L__Check_Timers712
L__Check_Timers971:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers972
	JMP        L__Check_Timers711
L__Check_Timers972:
L__Check_Timers680:
;Solar_Auto_Switcher.c,363 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,364 :: 		Relay_L_Solar_2=0; // relay off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,361 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
L__Check_Timers713:
L__Check_Timers712:
L__Check_Timers711:
;Solar_Auto_Switcher.c,367 :: 		} // end match timer stop
L_Check_Timers42:
;Solar_Auto_Switcher.c,372 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers721
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers973
	JMP        L__Check_Timers720
L__Check_Timers973:
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 1
	BREQ       L__Check_Timers974
	JMP        L__Check_Timers719
L__Check_Timers974:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers975
	JMP        L__Check_Timers718
L__Check_Timers975:
L__Check_Timers679:
;Solar_Auto_Switcher.c,375 :: 		Delay_ms(300);       // for error to get one seconds approxmiallty
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
	BRSH       L__Check_Timers976
	JMP        L__Check_Timers715
L__Check_Timers976:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers714
L__Check_Timers678:
;Solar_Auto_Switcher.c,381 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,378 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers715:
L__Check_Timers714:
;Solar_Auto_Switcher.c,384 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers977
	JMP        L__Check_Timers717
L__Check_Timers977:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers716
L__Check_Timers677:
;Solar_Auto_Switcher.c,386 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,384 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers717:
L__Check_Timers716:
;Solar_Auto_Switcher.c,389 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,372 :: 		if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )       //bypass enabled
L__Check_Timers721:
L__Check_Timers720:
L__Check_Timers719:
L__Check_Timers718:
;Solar_Auto_Switcher.c,395 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers724
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Check_Timers978
	JMP        L__Check_Timers723
L__Check_Timers978:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers979
	JMP        L__Check_Timers722
L__Check_Timers979:
L__Check_Timers676:
;Solar_Auto_Switcher.c,397 :: 		Start_Timer_0_A();         // give some time ac grid to stabilize
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,395 :: 		if(AC_Available==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
L__Check_Timers724:
L__Check_Timers723:
L__Check_Timers722:
;Solar_Auto_Switcher.c,400 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers727
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers980
	JMP        L__Check_Timers726
L__Check_Timers980:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers981
	JMP        L__Check_Timers725
L__Check_Timers981:
L__Check_Timers675:
;Solar_Auto_Switcher.c,402 :: 		LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,400 :: 		if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
L__Check_Timers727:
L__Check_Timers726:
L__Check_Timers725:
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers733
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__Check_Timers982
	JMP        L__Check_Timers732
L__Check_Timers982:
L__Check_Timers674:
;Solar_Auto_Switcher.c,408 :: 		Delay_ms(300);       // for error to get one seconds approxmiallty
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
	BRSH       L__Check_Timers983
	JMP        L__Check_Timers729
L__Check_Timers983:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers728
L__Check_Timers673:
;Solar_Auto_Switcher.c,414 :: 		Relay_L_Solar=1;
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,411 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers729:
L__Check_Timers728:
;Solar_Auto_Switcher.c,417 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers984
	JMP        L__Check_Timers731
L__Check_Timers984:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers730
L__Check_Timers672:
;Solar_Auto_Switcher.c,420 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,417 :: 		if(SecondsRealTime >= startupTIme_2 && AC_Available==0)
L__Check_Timers731:
L__Check_Timers730:
;Solar_Auto_Switcher.c,422 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==0 &&   VoltageProtectionEnable==0 )   // voltage protector is not enabled
L__Check_Timers733:
L__Check_Timers732:
;Solar_Auto_Switcher.c,431 :: 		if (AC_Available==0 && SecondsRealTime==startupTIme_2)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers735
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CP         R18, R16
	CPC        R19, R17
	BREQ       L__Check_Timers985
	JMP        L__Check_Timers734
L__Check_Timers985:
L__Check_Timers671:
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
L__Check_Timers735:
L__Check_Timers734:
;Solar_Auto_Switcher.c,443 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers740
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers986
	JMP        L__Check_Timers739
L__Check_Timers986:
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
	BREQ       L__Check_Timers987
	LDI        R16, 1
L__Check_Timers987:
	TST        R16
	BRNE       L__Check_Timers988
	JMP        L__Check_Timers738
L__Check_Timers988:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers989
	JMP        L__Check_Timers737
L__Check_Timers989:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers990
	JMP        L__Check_Timers736
L__Check_Timers990:
L__Check_Timers670:
;Solar_Auto_Switcher.c,446 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,447 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers83:
	DEC        R16
	BRNE       L_Check_Timers83
	DEC        R17
	BRNE       L_Check_Timers83
	DEC        R18
	BRNE       L_Check_Timers83
	NOP
;Solar_Auto_Switcher.c,448 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers991
	JMP        L_Check_Timers85
L__Check_Timers991:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers85:
;Solar_Auto_Switcher.c,443 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 )
L__Check_Timers740:
L__Check_Timers739:
L__Check_Timers738:
L__Check_Timers737:
L__Check_Timers736:
;Solar_Auto_Switcher.c,451 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers744
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers992
	JMP        L__Check_Timers743
L__Check_Timers992:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers993
	JMP        L__Check_Timers742
L__Check_Timers993:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers994
	JMP        L__Check_Timers741
L__Check_Timers994:
L__Check_Timers669:
;Solar_Auto_Switcher.c,453 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Auto_Switcher.c,454 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers89:
	DEC        R16
	BRNE       L_Check_Timers89
	DEC        R17
	BRNE       L_Check_Timers89
	DEC        R18
	BRNE       L_Check_Timers89
	NOP
;Solar_Auto_Switcher.c,456 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers995
	JMP        L_Check_Timers91
L__Check_Timers995:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_Check_Timers91:
;Solar_Auto_Switcher.c,451 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 )
L__Check_Timers744:
L__Check_Timers743:
L__Check_Timers742:
L__Check_Timers741:
;Solar_Auto_Switcher.c,460 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers749
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers996
	JMP        L__Check_Timers748
L__Check_Timers996:
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
	BREQ       L__Check_Timers997
	LDI        R16, 1
L__Check_Timers997:
	TST        R16
	BRNE       L__Check_Timers998
	JMP        L__Check_Timers747
L__Check_Timers998:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers999
	JMP        L__Check_Timers746
L__Check_Timers999:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers1000
	JMP        L__Check_Timers745
L__Check_Timers1000:
L__Check_Timers668:
;Solar_Auto_Switcher.c,462 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,463 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
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
	BRLO       L__Check_Timers1001
	JMP        L_Check_Timers97
L__Check_Timers1001:
;Solar_Auto_Switcher.c,465 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers97:
;Solar_Auto_Switcher.c,460 :: 		if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery==false && TurnOffLoadsByPass==0)     //run with battery
L__Check_Timers749:
L__Check_Timers748:
L__Check_Timers747:
L__Check_Timers746:
L__Check_Timers745:
;Solar_Auto_Switcher.c,468 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers753
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers1002
	JMP        L__Check_Timers752
L__Check_Timers1002:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers1003
	JMP        L__Check_Timers751
L__Check_Timers1003:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers1004
	JMP        L__Check_Timers750
L__Check_Timers1004:
L__Check_Timers667:
;Solar_Auto_Switcher.c,470 :: 		SecondsRealTimePv_ReConnect_T2++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T2+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T2+0, R16
	STS        _SecondsRealTimePv_ReConnect_T2+1, R17
;Solar_Auto_Switcher.c,471 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
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
	BRLO       L__Check_Timers1005
	JMP        L_Check_Timers103
L__Check_Timers1005:
;Solar_Auto_Switcher.c,473 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
L_Check_Timers103:
;Solar_Auto_Switcher.c,468 :: 		if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true && TurnOffLoadsByPass==0)            //run without battery
L__Check_Timers753:
L__Check_Timers752:
L__Check_Timers751:
L__Check_Timers750:
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
	BREQ       L__Check_Timers1006
	LDI        R16, 1
L__Check_Timers1006:
	TST        R16
	BRNE       L__Check_Timers1007
	JMP        L__Check_Timers757
L__Check_Timers1007:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers756
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers1008
	JMP        L__Check_Timers755
L__Check_Timers1008:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers1009
	JMP        L__Check_Timers754
L__Check_Timers1009:
L__Check_Timers666:
;Solar_Auto_Switcher.c,479 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,480 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,477 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
L__Check_Timers757:
L__Check_Timers756:
L__Check_Timers755:
L__Check_Timers754:
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
	BREQ       L__Check_Timers1010
	LDI        R16, 1
L__Check_Timers1010:
	TST        R16
	BRNE       L__Check_Timers1011
	JMP        L__Check_Timers761
L__Check_Timers1011:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers760
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers1012
	JMP        L__Check_Timers759
L__Check_Timers1012:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers1013
	JMP        L__Check_Timers758
L__Check_Timers1013:
L__Check_Timers665:
;Solar_Auto_Switcher.c,486 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,487 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Auto_Switcher.c,484 :: 		if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
L__Check_Timers761:
L__Check_Timers760:
L__Check_Timers759:
L__Check_Timers758:
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
	BREQ       L__ToggleBuzzer1016
	JMP        L_ToggleBuzzer110
L__ToggleBuzzer1016:
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
L_SetUpProgram113:
	DEC        R16
	BRNE       L_SetUpProgram113
	DEC        R17
	BRNE       L_SetUpProgram113
	DEC        R18
	BRNE       L_SetUpProgram113
;Solar_Auto_Switcher.c,527 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_SetUpProgram115
;Solar_Auto_Switcher.c,529 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,530 :: 		LCD_OUT(1,1,"Setup Program");
	LDI        R27, #lo_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,531 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram116:
	DEC        R16
	BRNE       L_SetUpProgram116
	DEC        R17
	BRNE       L_SetUpProgram116
	DEC        R18
	BRNE       L_SetUpProgram116
	NOP
;Solar_Auto_Switcher.c,534 :: 		while (Set==1 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetUpProgram119
;Solar_Auto_Switcher.c,537 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Auto_Switcher.c,538 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram120
	JMP        L_SetUpProgram119
L_SetUpProgram120:
;Solar_Auto_Switcher.c,539 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Auto_Switcher.c,540 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram121
	JMP        L_SetUpProgram119
L_SetUpProgram121:
;Solar_Auto_Switcher.c,541 :: 		SetTimerOn_2();
	CALL       _SetTimerOn_2+0
;Solar_Auto_Switcher.c,542 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram122
	JMP        L_SetUpProgram119
L_SetUpProgram122:
;Solar_Auto_Switcher.c,543 :: 		SetTimerOff_2();
	CALL       _SetTimerOff_2+0
;Solar_Auto_Switcher.c,544 :: 		if (Exit==1) break ;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram123
	JMP        L_SetUpProgram119
L_SetUpProgram123:
;Solar_Auto_Switcher.c,545 :: 		SetLowBatteryVoltage();// program 5 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Auto_Switcher.c,546 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram124
	JMP        L_SetUpProgram119
L_SetUpProgram124:
;Solar_Auto_Switcher.c,547 :: 		SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Auto_Switcher.c,548 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram125
	JMP        L_SetUpProgram119
L_SetUpProgram125:
;Solar_Auto_Switcher.c,550 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram126
	JMP        L_SetUpProgram119
L_SetUpProgram126:
;Solar_Auto_Switcher.c,552 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram127
	JMP        L_SetUpProgram119
L_SetUpProgram127:
;Solar_Auto_Switcher.c,553 :: 		SetDS1307_Time();    // program 10
	CALL       _SetDS1307_Time+0
;Solar_Auto_Switcher.c,554 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram128
	JMP        L_SetUpProgram119
L_SetUpProgram128:
;Solar_Auto_Switcher.c,559 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Auto_Switcher.c,560 :: 		if(Exit==1) break;
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetUpProgram129
	JMP        L_SetUpProgram119
L_SetUpProgram129:
;Solar_Auto_Switcher.c,568 :: 		} // end while
L_SetUpProgram119:
;Solar_Auto_Switcher.c,569 :: 		}    // end main if
L_SetUpProgram115:
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
L_SetTimerOn_1130:
	DEC        R16
	BRNE       L_SetTimerOn_1130
	DEC        R17
	BRNE       L_SetTimerOn_1130
	DEC        R18
	BRNE       L_SetTimerOn_1130
;Solar_Auto_Switcher.c,578 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,579 :: 		while (Set==1)
L_SetTimerOn_1132:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1133
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
	JMP        L_SetTimerOn_1134
;Solar_Auto_Switcher.c,592 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,593 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1133
;Solar_Auto_Switcher.c,594 :: 		}
L_SetTimerOn_1134:
;Solar_Auto_Switcher.c,597 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1135:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1766
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1765
	JMP        L_SetTimerOn_1136
L__SetTimerOn_1766:
L__SetTimerOn_1765:
;Solar_Auto_Switcher.c,599 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1139
;Solar_Auto_Switcher.c,601 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1140:
	DEC        R16
	BRNE       L_SetTimerOn_1140
	DEC        R17
	BRNE       L_SetTimerOn_1140
	DEC        R18
	BRNE       L_SetTimerOn_1140
	NOP
;Solar_Auto_Switcher.c,602 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,603 :: 		}
L_SetTimerOn_1139:
;Solar_Auto_Switcher.c,604 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1142
;Solar_Auto_Switcher.c,606 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,607 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,608 :: 		}
L_SetTimerOn_1142:
;Solar_Auto_Switcher.c,610 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_11019
	JMP        L_SetTimerOn_1145
L__SetTimerOn_11019:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1145:
;Solar_Auto_Switcher.c,611 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11020
	JMP        L_SetTimerOn_1146
L__SetTimerOn_11020:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1146:
;Solar_Auto_Switcher.c,612 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,613 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,614 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_1135
L_SetTimerOn_1136:
;Solar_Auto_Switcher.c,615 :: 		} // end first while
	JMP        L_SetTimerOn_1132
L_SetTimerOn_1133:
;Solar_Auto_Switcher.c,617 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_1147:
	DEC        R16
	BRNE       L_SetTimerOn_1147
	DEC        R17
	BRNE       L_SetTimerOn_1147
	DEC        R18
	BRNE       L_SetTimerOn_1147
	NOP
;Solar_Auto_Switcher.c,618 :: 		while (Set==1)
L_SetTimerOn_1149:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1150
;Solar_Auto_Switcher.c,620 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,622 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,626 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1151
;Solar_Auto_Switcher.c,628 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,629 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_1150
;Solar_Auto_Switcher.c,630 :: 		}
L_SetTimerOn_1151:
;Solar_Auto_Switcher.c,632 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1152:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1768
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1767
	JMP        L_SetTimerOn_1153
L__SetTimerOn_1768:
L__SetTimerOn_1767:
;Solar_Auto_Switcher.c,634 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1156
;Solar_Auto_Switcher.c,636 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1157:
	DEC        R16
	BRNE       L_SetTimerOn_1157
	DEC        R17
	BRNE       L_SetTimerOn_1157
	DEC        R18
	BRNE       L_SetTimerOn_1157
	NOP
;Solar_Auto_Switcher.c,637 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,638 :: 		}
L_SetTimerOn_1156:
;Solar_Auto_Switcher.c,639 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1159
;Solar_Auto_Switcher.c,641 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,642 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,643 :: 		}
L_SetTimerOn_1159:
;Solar_Auto_Switcher.c,645 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_11021
	JMP        L_SetTimerOn_1162
L__SetTimerOn_11021:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1162:
;Solar_Auto_Switcher.c,646 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_11022
	JMP        L_SetTimerOn_1163
L__SetTimerOn_11022:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1163:
;Solar_Auto_Switcher.c,647 :: 		Timer_isOn=0; //
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,648 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,649 :: 		} // end while increment
	JMP        L_SetTimerOn_1152
L_SetTimerOn_1153:
;Solar_Auto_Switcher.c,650 :: 		} // end first while
	JMP        L_SetTimerOn_1149
L_SetTimerOn_1150:
;Solar_Auto_Switcher.c,652 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,653 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,655 :: 		}
L_end_SetTimerOn_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Auto_Switcher.c,657 :: 		void SetTimerOff_1()
;Solar_Auto_Switcher.c,659 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,660 :: 		LCD_OUT(1,1,"T1 Off: [2]");
	LDI        R27, #lo_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,661 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,662 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1164:
	DEC        R16
	BRNE       L_SetTimerOff_1164
	DEC        R17
	BRNE       L_SetTimerOff_1164
	DEC        R18
	BRNE       L_SetTimerOff_1164
	NOP
;Solar_Auto_Switcher.c,663 :: 		while (Set==1)
L_SetTimerOff_1166:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1167
;Solar_Auto_Switcher.c,669 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,670 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,671 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,672 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,673 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1168
;Solar_Auto_Switcher.c,675 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,676 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1167
;Solar_Auto_Switcher.c,677 :: 		}
L_SetTimerOff_1168:
;Solar_Auto_Switcher.c,679 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1169:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1772
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1771
	JMP        L_SetTimerOff_1170
L__SetTimerOff_1772:
L__SetTimerOff_1771:
;Solar_Auto_Switcher.c,682 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1173
;Solar_Auto_Switcher.c,684 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1174:
	DEC        R16
	BRNE       L_SetTimerOff_1174
	DEC        R17
	BRNE       L_SetTimerOff_1174
	DEC        R18
	BRNE       L_SetTimerOff_1174
	NOP
;Solar_Auto_Switcher.c,685 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,686 :: 		}
L_SetTimerOff_1173:
;Solar_Auto_Switcher.c,687 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1176
;Solar_Auto_Switcher.c,689 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,690 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,691 :: 		}
L_SetTimerOff_1176:
;Solar_Auto_Switcher.c,693 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_11024
	JMP        L_SetTimerOff_1179
L__SetTimerOff_11024:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1179:
;Solar_Auto_Switcher.c,694 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11025
	JMP        L_SetTimerOff_1180
L__SetTimerOff_11025:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1180:
;Solar_Auto_Switcher.c,695 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,696 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,697 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1169
L_SetTimerOff_1170:
;Solar_Auto_Switcher.c,698 :: 		} // end first while
	JMP        L_SetTimerOff_1166
L_SetTimerOff_1167:
;Solar_Auto_Switcher.c,700 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1181:
	DEC        R16
	BRNE       L_SetTimerOff_1181
	DEC        R17
	BRNE       L_SetTimerOff_1181
	DEC        R18
	BRNE       L_SetTimerOff_1181
	NOP
;Solar_Auto_Switcher.c,701 :: 		while (Set==1)
L_SetTimerOff_1183:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1184
;Solar_Auto_Switcher.c,703 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,705 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,709 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1185
;Solar_Auto_Switcher.c,711 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,712 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_1184
;Solar_Auto_Switcher.c,713 :: 		}
L_SetTimerOff_1185:
;Solar_Auto_Switcher.c,715 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1186:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1774
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1773
	JMP        L_SetTimerOff_1187
L__SetTimerOff_1774:
L__SetTimerOff_1773:
;Solar_Auto_Switcher.c,717 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1190
;Solar_Auto_Switcher.c,719 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1191:
	DEC        R16
	BRNE       L_SetTimerOff_1191
	DEC        R17
	BRNE       L_SetTimerOff_1191
	DEC        R18
	BRNE       L_SetTimerOff_1191
	NOP
;Solar_Auto_Switcher.c,720 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,721 :: 		}
L_SetTimerOff_1190:
;Solar_Auto_Switcher.c,722 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1193
;Solar_Auto_Switcher.c,724 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,725 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,726 :: 		}
L_SetTimerOff_1193:
;Solar_Auto_Switcher.c,727 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_11026
	JMP        L_SetTimerOff_1196
L__SetTimerOff_11026:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1196:
;Solar_Auto_Switcher.c,728 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_11027
	JMP        L_SetTimerOff_1197
L__SetTimerOff_11027:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1197:
;Solar_Auto_Switcher.c,729 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Auto_Switcher.c,730 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,731 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1186
L_SetTimerOff_1187:
;Solar_Auto_Switcher.c,732 :: 		} // end first while
	JMP        L_SetTimerOff_1183
L_SetTimerOff_1184:
;Solar_Auto_Switcher.c,733 :: 		EEPROM_Write(0x03,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,734 :: 		EEPROM_Write(0x04,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,736 :: 		}
L_end_SetTimerOff_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetTimerOn_2:

;Solar_Auto_Switcher.c,739 :: 		void SetTimerOn_2()
;Solar_Auto_Switcher.c,741 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,742 :: 		LCD_OUT(1,1,"T2 On: [3]");
	LDI        R27, #lo_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,743 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_2198:
	DEC        R16
	BRNE       L_SetTimerOn_2198
	DEC        R17
	BRNE       L_SetTimerOn_2198
	DEC        R18
	BRNE       L_SetTimerOn_2198
;Solar_Auto_Switcher.c,744 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,745 :: 		while (Set==1)
L_SetTimerOn_2200:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2201
;Solar_Auto_Switcher.c,751 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,752 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,753 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,754 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,756 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2202
;Solar_Auto_Switcher.c,758 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,759 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2201
;Solar_Auto_Switcher.c,760 :: 		}
L_SetTimerOn_2202:
;Solar_Auto_Switcher.c,763 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2203:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2778
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2777
	JMP        L_SetTimerOn_2204
L__SetTimerOn_2778:
L__SetTimerOn_2777:
;Solar_Auto_Switcher.c,765 :: 		if (Increment==1  )
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2207
;Solar_Auto_Switcher.c,767 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2208:
	DEC        R16
	BRNE       L_SetTimerOn_2208
	DEC        R17
	BRNE       L_SetTimerOn_2208
	DEC        R18
	BRNE       L_SetTimerOn_2208
	NOP
;Solar_Auto_Switcher.c,768 :: 		minutes_lcd_timer2_start++;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,769 :: 		}
L_SetTimerOn_2207:
;Solar_Auto_Switcher.c,770 :: 		if (Decrement==1 )
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2210
;Solar_Auto_Switcher.c,772 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,773 :: 		minutes_lcd_timer2_start--;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,774 :: 		}
L_SetTimerOn_2210:
;Solar_Auto_Switcher.c,776 :: 		if (minutes_lcd_timer2_start>59)    minutes_lcd_timer2_start=0;
	LDS        R17, _minutes_lcd_timer2_start+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_21029
	JMP        L_SetTimerOn_2213
L__SetTimerOn_21029:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2213:
;Solar_Auto_Switcher.c,777 :: 		if (minutes_lcd_timer2_start<0)  minutes_lcd_timer2_start=0;
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21030
	JMP        L_SetTimerOn_2214
L__SetTimerOn_21030:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2214:
;Solar_Auto_Switcher.c,778 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,779 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,781 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_2203
L_SetTimerOn_2204:
;Solar_Auto_Switcher.c,782 :: 		} // end first while
	JMP        L_SetTimerOn_2200
L_SetTimerOn_2201:
;Solar_Auto_Switcher.c,784 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_2215:
	DEC        R16
	BRNE       L_SetTimerOn_2215
	DEC        R17
	BRNE       L_SetTimerOn_2215
	DEC        R18
	BRNE       L_SetTimerOn_2215
	NOP
;Solar_Auto_Switcher.c,785 :: 		while (Set==1)
L_SetTimerOn_2217:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2218
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
	JMP        L_SetTimerOn_2219
;Solar_Auto_Switcher.c,796 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOn_2218
;Solar_Auto_Switcher.c,797 :: 		}
L_SetTimerOn_2219:
;Solar_Auto_Switcher.c,799 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_2220:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2780
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2779
	JMP        L_SetTimerOn_2221
L__SetTimerOn_2780:
L__SetTimerOn_2779:
;Solar_Auto_Switcher.c,801 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2224
;Solar_Auto_Switcher.c,803 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2225:
	DEC        R16
	BRNE       L_SetTimerOn_2225
	DEC        R17
	BRNE       L_SetTimerOn_2225
	DEC        R18
	BRNE       L_SetTimerOn_2225
	NOP
;Solar_Auto_Switcher.c,804 :: 		hours_lcd_timer2_start++;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,805 :: 		}
L_SetTimerOn_2224:
;Solar_Auto_Switcher.c,806 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2227
;Solar_Auto_Switcher.c,808 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,809 :: 		hours_lcd_timer2_start--;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,810 :: 		}
L_SetTimerOn_2227:
;Solar_Auto_Switcher.c,812 :: 		if  (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
	LDS        R17, _hours_lcd_timer2_start+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_21031
	JMP        L_SetTimerOn_2230
L__SetTimerOn_21031:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2230:
;Solar_Auto_Switcher.c,813 :: 		if  (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_21032
	JMP        L_SetTimerOn_2231
L__SetTimerOn_21032:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2231:
;Solar_Auto_Switcher.c,814 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,815 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,817 :: 		} // end while increment
	JMP        L_SetTimerOn_2220
L_SetTimerOn_2221:
;Solar_Auto_Switcher.c,818 :: 		} // end first while
	JMP        L_SetTimerOn_2217
L_SetTimerOn_2218:
;Solar_Auto_Switcher.c,820 :: 		EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_start+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,821 :: 		EEPROM_Write(0x19,minutes_lcd_timer2_start); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_start+0
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,823 :: 		}
L_end_SetTimerOn_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_2

_SetTimerOff_2:

;Solar_Auto_Switcher.c,825 :: 		void SetTimerOff_2()
;Solar_Auto_Switcher.c,827 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,828 :: 		LCD_OUT(1,1,"T2 Off: [4]");
	LDI        R27, #lo_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,829 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,830 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2232:
	DEC        R16
	BRNE       L_SetTimerOff_2232
	DEC        R17
	BRNE       L_SetTimerOff_2232
	DEC        R18
	BRNE       L_SetTimerOff_2232
	NOP
;Solar_Auto_Switcher.c,831 :: 		while (Set==1)
L_SetTimerOff_2234:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2235
;Solar_Auto_Switcher.c,837 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,838 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,839 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,840 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,841 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2236
	JMP        L_SetTimerOff_2235
L_SetTimerOff_2236:
;Solar_Auto_Switcher.c,843 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2237:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2784
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2783
	JMP        L_SetTimerOff_2238
L__SetTimerOff_2784:
L__SetTimerOff_2783:
;Solar_Auto_Switcher.c,845 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2241
;Solar_Auto_Switcher.c,847 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2242:
	DEC        R16
	BRNE       L_SetTimerOff_2242
	DEC        R17
	BRNE       L_SetTimerOff_2242
	DEC        R18
	BRNE       L_SetTimerOff_2242
	NOP
;Solar_Auto_Switcher.c,848 :: 		minutes_lcd_timer2_stop++;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,849 :: 		}
L_SetTimerOff_2241:
;Solar_Auto_Switcher.c,850 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2244
;Solar_Auto_Switcher.c,852 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,853 :: 		minutes_lcd_timer2_stop--;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,854 :: 		}
L_SetTimerOff_2244:
;Solar_Auto_Switcher.c,856 :: 		if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
	LDS        R17, _minutes_lcd_timer2_stop+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_21034
	JMP        L_SetTimerOff_2247
L__SetTimerOff_21034:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2247:
;Solar_Auto_Switcher.c,857 :: 		if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21035
	JMP        L_SetTimerOff_2248
L__SetTimerOff_21035:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2248:
;Solar_Auto_Switcher.c,858 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,859 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,861 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2237
L_SetTimerOff_2238:
;Solar_Auto_Switcher.c,862 :: 		} // end first while
	JMP        L_SetTimerOff_2234
L_SetTimerOff_2235:
;Solar_Auto_Switcher.c,864 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_2249:
	DEC        R16
	BRNE       L_SetTimerOff_2249
	DEC        R17
	BRNE       L_SetTimerOff_2249
	DEC        R18
	BRNE       L_SetTimerOff_2249
	NOP
;Solar_Auto_Switcher.c,865 :: 		while (Set==1)
L_SetTimerOff_2251:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2252
;Solar_Auto_Switcher.c,867 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,869 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,874 :: 		if (Exit==1)
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2253
;Solar_Auto_Switcher.c,876 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,877 :: 		break;     //break out of the while loop
	JMP        L_SetTimerOff_2252
;Solar_Auto_Switcher.c,878 :: 		}
L_SetTimerOff_2253:
;Solar_Auto_Switcher.c,880 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_2254:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2786
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2785
	JMP        L_SetTimerOff_2255
L__SetTimerOff_2786:
L__SetTimerOff_2785:
;Solar_Auto_Switcher.c,882 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2258
;Solar_Auto_Switcher.c,884 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2259:
	DEC        R16
	BRNE       L_SetTimerOff_2259
	DEC        R17
	BRNE       L_SetTimerOff_2259
	DEC        R18
	BRNE       L_SetTimerOff_2259
	NOP
;Solar_Auto_Switcher.c,885 :: 		hours_lcd_timer2_stop++;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,886 :: 		}
L_SetTimerOff_2258:
;Solar_Auto_Switcher.c,887 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2261
;Solar_Auto_Switcher.c,889 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,890 :: 		hours_lcd_timer2_stop--;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,891 :: 		}
L_SetTimerOff_2261:
;Solar_Auto_Switcher.c,892 :: 		if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
	LDS        R17, _hours_lcd_timer2_stop+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_21036
	JMP        L_SetTimerOff_2264
L__SetTimerOff_21036:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2264:
;Solar_Auto_Switcher.c,893 :: 		if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_21037
	JMP        L_SetTimerOff_2265
L__SetTimerOff_21037:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2265:
;Solar_Auto_Switcher.c,894 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,895 :: 		SecondsRealTimePv_ReConnect_T2=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T2+0, R27
	STS        _SecondsRealTimePv_ReConnect_T2+1, R27
;Solar_Auto_Switcher.c,897 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2254
L_SetTimerOff_2255:
;Solar_Auto_Switcher.c,898 :: 		} // end first while
	JMP        L_SetTimerOff_2251
L_SetTimerOff_2252:
;Solar_Auto_Switcher.c,899 :: 		EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_timer2_stop+0
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,900 :: 		EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_timer2_stop+0
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,902 :: 		}
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

;Solar_Auto_Switcher.c,906 :: 		void SetDS1307_Time()
;Solar_Auto_Switcher.c,908 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,909 :: 		LCD_OUT(1,1,"Set Time [9]");
	LDI        R27, #lo_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,910 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time266:
	DEC        R16
	BRNE       L_SetDS1307_Time266
	DEC        R17
	BRNE       L_SetDS1307_Time266
	DEC        R18
	BRNE       L_SetDS1307_Time266
	NOP
;Solar_Auto_Switcher.c,911 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,912 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,914 :: 		while (Set==1)
L_SetDS1307_Time268:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time269
;Solar_Auto_Switcher.c,916 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,917 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,918 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,927 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time270
	JMP        L_SetDS1307_Time269
L_SetDS1307_Time270:
;Solar_Auto_Switcher.c,928 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time271:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time806
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time805
	JMP        L_SetDS1307_Time272
L__SetDS1307_Time806:
L__SetDS1307_Time805:
;Solar_Auto_Switcher.c,930 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time275
;Solar_Auto_Switcher.c,932 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time276:
	DEC        R16
	BRNE       L_SetDS1307_Time276
	DEC        R17
	BRNE       L_SetDS1307_Time276
	DEC        R18
	BRNE       L_SetDS1307_Time276
	NOP
;Solar_Auto_Switcher.c,933 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,935 :: 		}
L_SetDS1307_Time275:
;Solar_Auto_Switcher.c,936 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time278
;Solar_Auto_Switcher.c,938 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,939 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,940 :: 		}
L_SetDS1307_Time278:
;Solar_Auto_Switcher.c,941 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time1039
	JMP        L_SetDS1307_Time281
L__SetDS1307_Time1039:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time281:
;Solar_Auto_Switcher.c,942 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1040
	JMP        L_SetDS1307_Time282
L__SetDS1307_Time1040:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time282:
;Solar_Auto_Switcher.c,943 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time271
L_SetDS1307_Time272:
;Solar_Auto_Switcher.c,944 :: 		} // end first while
	JMP        L_SetDS1307_Time268
L_SetDS1307_Time269:
;Solar_Auto_Switcher.c,946 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time283:
	DEC        R16
	BRNE       L_SetDS1307_Time283
	DEC        R17
	BRNE       L_SetDS1307_Time283
	DEC        R18
	BRNE       L_SetDS1307_Time283
	NOP
;Solar_Auto_Switcher.c,947 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,949 :: 		Delay_ms(500);
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
;Solar_Auto_Switcher.c,950 :: 		while (Set==1)
L_SetDS1307_Time287:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time288
;Solar_Auto_Switcher.c,957 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,958 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,959 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,960 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time289
	JMP        L_SetDS1307_Time288
L_SetDS1307_Time289:
;Solar_Auto_Switcher.c,961 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time290:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time808
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time807
	JMP        L_SetDS1307_Time291
L__SetDS1307_Time808:
L__SetDS1307_Time807:
;Solar_Auto_Switcher.c,963 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time294
;Solar_Auto_Switcher.c,965 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time295:
	DEC        R16
	BRNE       L_SetDS1307_Time295
	DEC        R17
	BRNE       L_SetDS1307_Time295
	DEC        R18
	BRNE       L_SetDS1307_Time295
	NOP
;Solar_Auto_Switcher.c,966 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,967 :: 		}
L_SetDS1307_Time294:
;Solar_Auto_Switcher.c,969 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time297
;Solar_Auto_Switcher.c,971 :: 		delay_ms(ButtonDelay);
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
;Solar_Auto_Switcher.c,972 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,973 :: 		}
L_SetDS1307_Time297:
;Solar_Auto_Switcher.c,974 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1041
	JMP        L_SetDS1307_Time300
L__SetDS1307_Time1041:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time300:
;Solar_Auto_Switcher.c,975 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1042
	JMP        L_SetDS1307_Time301
L__SetDS1307_Time1042:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time301:
;Solar_Auto_Switcher.c,976 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time290
L_SetDS1307_Time291:
;Solar_Auto_Switcher.c,977 :: 		} // end first while
	JMP        L_SetDS1307_Time287
L_SetDS1307_Time288:
;Solar_Auto_Switcher.c,979 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time302:
	DEC        R16
	BRNE       L_SetDS1307_Time302
	DEC        R17
	BRNE       L_SetDS1307_Time302
	DEC        R18
	BRNE       L_SetDS1307_Time302
	NOP
;Solar_Auto_Switcher.c,980 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,983 :: 		while (Set==1)
L_SetDS1307_Time304:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time305
;Solar_Auto_Switcher.c,988 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,989 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,990 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,991 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time306
	JMP        L_SetDS1307_Time305
L_SetDS1307_Time306:
;Solar_Auto_Switcher.c,992 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time307:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time810
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time809
	JMP        L_SetDS1307_Time308
L__SetDS1307_Time810:
L__SetDS1307_Time809:
;Solar_Auto_Switcher.c,994 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time311
;Solar_Auto_Switcher.c,996 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time312:
	DEC        R16
	BRNE       L_SetDS1307_Time312
	DEC        R17
	BRNE       L_SetDS1307_Time312
	DEC        R18
	BRNE       L_SetDS1307_Time312
	NOP
;Solar_Auto_Switcher.c,997 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,998 :: 		}
L_SetDS1307_Time311:
;Solar_Auto_Switcher.c,999 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time314
;Solar_Auto_Switcher.c,1001 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time315:
	DEC        R16
	BRNE       L_SetDS1307_Time315
	DEC        R17
	BRNE       L_SetDS1307_Time315
	DEC        R18
	BRNE       L_SetDS1307_Time315
	NOP
;Solar_Auto_Switcher.c,1002 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,1003 :: 		}
L_SetDS1307_Time314:
;Solar_Auto_Switcher.c,1004 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time1043
	JMP        L_SetDS1307_Time317
L__SetDS1307_Time1043:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time317:
;Solar_Auto_Switcher.c,1005 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1044
	JMP        L_SetDS1307_Time318
L__SetDS1307_Time1044:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time318:
;Solar_Auto_Switcher.c,1008 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Auto_Switcher.c,1009 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time307
L_SetDS1307_Time308:
;Solar_Auto_Switcher.c,1010 :: 		} // end first while
	JMP        L_SetDS1307_Time304
L_SetDS1307_Time305:
;Solar_Auto_Switcher.c,1012 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time319:
	DEC        R16
	BRNE       L_SetDS1307_Time319
	DEC        R17
	BRNE       L_SetDS1307_Time319
	DEC        R18
	BRNE       L_SetDS1307_Time319
	NOP
;Solar_Auto_Switcher.c,1013 :: 		LCD_Clear(1,1,16);  // clear the lcd first row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1014 :: 		LCD_CLear(2,1,16); // clear the lcd two row
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1017 :: 		set_ds1307_day=ReadDate(0x04);
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1019 :: 		while (Set==1)
L_SetDS1307_Time321:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time322
;Solar_Auto_Switcher.c,1021 :: 		ByteToStr(set_ds1307_day,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_day+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1022 :: 		LCD_OUT(2,1,"D:");
	LDI        R27, #lo_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1023 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1024 :: 		LCD_OUT(2,12,"Y:");
	LDI        R27, #lo_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1025 :: 		LCD_Out(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1026 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time323
	JMP        L_SetDS1307_Time322
L_SetDS1307_Time323:
;Solar_Auto_Switcher.c,1027 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time324:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time812
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time811
	JMP        L_SetDS1307_Time325
L__SetDS1307_Time812:
L__SetDS1307_Time811:
;Solar_Auto_Switcher.c,1029 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time328
;Solar_Auto_Switcher.c,1031 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time329:
	DEC        R16
	BRNE       L_SetDS1307_Time329
	DEC        R17
	BRNE       L_SetDS1307_Time329
	DEC        R18
	BRNE       L_SetDS1307_Time329
	NOP
;Solar_Auto_Switcher.c,1032 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1033 :: 		}
L_SetDS1307_Time328:
;Solar_Auto_Switcher.c,1034 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time331
;Solar_Auto_Switcher.c,1036 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time332:
	DEC        R16
	BRNE       L_SetDS1307_Time332
	DEC        R17
	BRNE       L_SetDS1307_Time332
	DEC        R18
	BRNE       L_SetDS1307_Time332
	NOP
;Solar_Auto_Switcher.c,1037 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Auto_Switcher.c,1038 :: 		}
L_SetDS1307_Time331:
;Solar_Auto_Switcher.c,1039 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time1045
	JMP        L_SetDS1307_Time334
L__SetDS1307_Time1045:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time334:
;Solar_Auto_Switcher.c,1040 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1046
	JMP        L_SetDS1307_Time335
L__SetDS1307_Time1046:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time335:
;Solar_Auto_Switcher.c,1041 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time324
L_SetDS1307_Time325:
;Solar_Auto_Switcher.c,1042 :: 		} //  end while set
	JMP        L_SetDS1307_Time321
L_SetDS1307_Time322:
;Solar_Auto_Switcher.c,1044 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time336:
	DEC        R16
	BRNE       L_SetDS1307_Time336
	DEC        R17
	BRNE       L_SetDS1307_Time336
	DEC        R18
	BRNE       L_SetDS1307_Time336
	NOP
;Solar_Auto_Switcher.c,1045 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1048 :: 		set_ds1307_month=ReadDate(0x05);
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1049 :: 		while (Set==1)
L_SetDS1307_Time338:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time339
;Solar_Auto_Switcher.c,1051 :: 		ByteToStr(set_ds1307_month,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_month+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1052 :: 		LCD_Out(2,8,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1053 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time340
	JMP        L_SetDS1307_Time339
L_SetDS1307_Time340:
;Solar_Auto_Switcher.c,1054 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time341:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time814
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time813
	JMP        L_SetDS1307_Time342
L__SetDS1307_Time814:
L__SetDS1307_Time813:
;Solar_Auto_Switcher.c,1056 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time345
;Solar_Auto_Switcher.c,1058 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time346:
	DEC        R16
	BRNE       L_SetDS1307_Time346
	DEC        R17
	BRNE       L_SetDS1307_Time346
	DEC        R18
	BRNE       L_SetDS1307_Time346
	NOP
;Solar_Auto_Switcher.c,1059 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1061 :: 		}
L_SetDS1307_Time345:
;Solar_Auto_Switcher.c,1062 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time348
;Solar_Auto_Switcher.c,1064 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time349:
	DEC        R16
	BRNE       L_SetDS1307_Time349
	DEC        R17
	BRNE       L_SetDS1307_Time349
	DEC        R18
	BRNE       L_SetDS1307_Time349
	NOP
;Solar_Auto_Switcher.c,1065 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Auto_Switcher.c,1066 :: 		}
L_SetDS1307_Time348:
;Solar_Auto_Switcher.c,1067 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time1047
	JMP        L_SetDS1307_Time351
L__SetDS1307_Time1047:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time351:
;Solar_Auto_Switcher.c,1068 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1048
	JMP        L_SetDS1307_Time352
L__SetDS1307_Time1048:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time352:
;Solar_Auto_Switcher.c,1069 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time341
L_SetDS1307_Time342:
;Solar_Auto_Switcher.c,1070 :: 		} //  end while set
	JMP        L_SetDS1307_Time338
L_SetDS1307_Time339:
;Solar_Auto_Switcher.c,1072 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time353:
	DEC        R16
	BRNE       L_SetDS1307_Time353
	DEC        R17
	BRNE       L_SetDS1307_Time353
	DEC        R18
	BRNE       L_SetDS1307_Time353
	NOP
;Solar_Auto_Switcher.c,1073 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1076 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1078 :: 		while (Set==1)
L_SetDS1307_Time355:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307_Time356
;Solar_Auto_Switcher.c,1080 :: 		ByteToStr(set_ds1307_year,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_year+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1081 :: 		LCD_Out(2,14,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 14
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1082 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time357
	JMP        L_SetDS1307_Time356
L_SetDS1307_Time357:
;Solar_Auto_Switcher.c,1083 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time358:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307_Time816
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307_Time815
	JMP        L_SetDS1307_Time359
L__SetDS1307_Time816:
L__SetDS1307_Time815:
;Solar_Auto_Switcher.c,1085 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307_Time362
;Solar_Auto_Switcher.c,1087 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time363:
	DEC        R16
	BRNE       L_SetDS1307_Time363
	DEC        R17
	BRNE       L_SetDS1307_Time363
	DEC        R18
	BRNE       L_SetDS1307_Time363
	NOP
;Solar_Auto_Switcher.c,1088 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1090 :: 		}
L_SetDS1307_Time362:
;Solar_Auto_Switcher.c,1091 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307_Time365
;Solar_Auto_Switcher.c,1093 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time366:
	DEC        R16
	BRNE       L_SetDS1307_Time366
	DEC        R17
	BRNE       L_SetDS1307_Time366
	DEC        R18
	BRNE       L_SetDS1307_Time366
	NOP
;Solar_Auto_Switcher.c,1094 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Auto_Switcher.c,1095 :: 		}
L_SetDS1307_Time365:
;Solar_Auto_Switcher.c,1096 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time1049
	JMP        L_SetDS1307_Time368
L__SetDS1307_Time1049:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time368:
;Solar_Auto_Switcher.c,1097 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time1050
	JMP        L_SetDS1307_Time369
L__SetDS1307_Time1050:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time369:
;Solar_Auto_Switcher.c,1099 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time358
L_SetDS1307_Time359:
;Solar_Auto_Switcher.c,1100 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
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
;Solar_Auto_Switcher.c,1101 :: 		} //  end while set
	JMP        L_SetDS1307_Time355
L_SetDS1307_Time356:
;Solar_Auto_Switcher.c,1102 :: 		}  // end setTimeAndData
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

;Solar_Auto_Switcher.c,1195 :: 		void SetLowBatteryVoltage()
;Solar_Auto_Switcher.c,1197 :: 		LCD_OUT(1,1,"Low Battery  [5]");
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
;Solar_Auto_Switcher.c,1198 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage370:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage370
	DEC        R17
	BRNE       L_SetLowBatteryVoltage370
	DEC        R18
	BRNE       L_SetLowBatteryVoltage370
	NOP
;Solar_Auto_Switcher.c,1199 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1200 :: 		while(Set==1)
L_SetLowBatteryVoltage372:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage373
;Solar_Auto_Switcher.c,1202 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1203 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1204 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1206 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage374
	JMP        L_SetLowBatteryVoltage373
L_SetLowBatteryVoltage374:
;Solar_Auto_Switcher.c,1207 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage375:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage790
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage789
	JMP        L_SetLowBatteryVoltage376
L__SetLowBatteryVoltage790:
L__SetLowBatteryVoltage789:
;Solar_Auto_Switcher.c,1209 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage379
;Solar_Auto_Switcher.c,1211 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage380:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage380
	DEC        R17
	BRNE       L_SetLowBatteryVoltage380
	DEC        R18
	BRNE       L_SetLowBatteryVoltage380
	NOP
;Solar_Auto_Switcher.c,1212 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Auto_Switcher.c,1214 :: 		}
L_SetLowBatteryVoltage379:
;Solar_Auto_Switcher.c,1215 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage382
;Solar_Auto_Switcher.c,1217 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage383:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage383
	DEC        R17
	BRNE       L_SetLowBatteryVoltage383
	DEC        R18
	BRNE       L_SetLowBatteryVoltage383
	NOP
;Solar_Auto_Switcher.c,1218 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Auto_Switcher.c,1219 :: 		}
L_SetLowBatteryVoltage382:
;Solar_Auto_Switcher.c,1220 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1052
	LDI        R16, 1
L__SetLowBatteryVoltage1052:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1053
	JMP        L_SetLowBatteryVoltage385
L__SetLowBatteryVoltage1053:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage385:
;Solar_Auto_Switcher.c,1221 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage1054
	LDI        R16, 1
L__SetLowBatteryVoltage1054:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1055
	JMP        L_SetLowBatteryVoltage386
L__SetLowBatteryVoltage1055:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage386:
;Solar_Auto_Switcher.c,1222 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage375
L_SetLowBatteryVoltage376:
;Solar_Auto_Switcher.c,1223 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage372
L_SetLowBatteryVoltage373:
;Solar_Auto_Switcher.c,1224 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1226 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage387:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage387
	DEC        R17
	BRNE       L_SetLowBatteryVoltage387
	DEC        R18
	BRNE       L_SetLowBatteryVoltage387
	NOP
;Solar_Auto_Switcher.c,1227 :: 		while(Set==1)
L_SetLowBatteryVoltage389:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage390
;Solar_Auto_Switcher.c,1229 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1230 :: 		sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1231 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1233 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage391
	JMP        L_SetLowBatteryVoltage390
L_SetLowBatteryVoltage391:
;Solar_Auto_Switcher.c,1234 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage392:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage792
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage791
	JMP        L_SetLowBatteryVoltage393
L__SetLowBatteryVoltage792:
L__SetLowBatteryVoltage791:
;Solar_Auto_Switcher.c,1236 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage396
;Solar_Auto_Switcher.c,1238 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage397:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage397
	DEC        R17
	BRNE       L_SetLowBatteryVoltage397
	DEC        R18
	BRNE       L_SetLowBatteryVoltage397
	NOP
;Solar_Auto_Switcher.c,1239 :: 		Mini_Battery_Voltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1241 :: 		}
L_SetLowBatteryVoltage396:
;Solar_Auto_Switcher.c,1242 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage399
;Solar_Auto_Switcher.c,1244 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage400:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage400
	DEC        R17
	BRNE       L_SetLowBatteryVoltage400
	DEC        R18
	BRNE       L_SetLowBatteryVoltage400
	NOP
;Solar_Auto_Switcher.c,1245 :: 		Mini_Battery_Voltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1246 :: 		}
L_SetLowBatteryVoltage399:
;Solar_Auto_Switcher.c,1247 :: 		if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1056
	LDI        R16, 1
L__SetLowBatteryVoltage1056:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1057
	JMP        L_SetLowBatteryVoltage402
L__SetLowBatteryVoltage1057:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage402:
;Solar_Auto_Switcher.c,1248 :: 		if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
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
	BREQ       L__SetLowBatteryVoltage1058
	LDI        R16, 1
L__SetLowBatteryVoltage1058:
	TST        R16
	BRNE       L__SetLowBatteryVoltage1059
	JMP        L_SetLowBatteryVoltage403
L__SetLowBatteryVoltage1059:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	STS        _Mini_Battery_Voltage_T2+2, R27
	STS        _Mini_Battery_Voltage_T2+3, R27
L_SetLowBatteryVoltage403:
;Solar_Auto_Switcher.c,1249 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage392
L_SetLowBatteryVoltage393:
;Solar_Auto_Switcher.c,1250 :: 		}// end while set
	JMP        L_SetLowBatteryVoltage389
L_SetLowBatteryVoltage390:
;Solar_Auto_Switcher.c,1252 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1253 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1254 :: 		}
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

;Solar_Auto_Switcher.c,1256 :: 		void SetStartUpLoadsVoltage()
;Solar_Auto_Switcher.c,1258 :: 		LCD_OUT(1,1,"Start Loads V[6]");
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
;Solar_Auto_Switcher.c,1259 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage404:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage404
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage404
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage404
	NOP
;Solar_Auto_Switcher.c,1260 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1261 :: 		while(Set==1)
L_SetStartUpLoadsVoltage406:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage407
;Solar_Auto_Switcher.c,1263 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1264 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1265 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1267 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage408
	JMP        L_SetStartUpLoadsVoltage407
L_SetStartUpLoadsVoltage408:
;Solar_Auto_Switcher.c,1268 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage409:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage796
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage795
	JMP        L_SetStartUpLoadsVoltage410
L__SetStartUpLoadsVoltage796:
L__SetStartUpLoadsVoltage795:
;Solar_Auto_Switcher.c,1270 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage413
;Solar_Auto_Switcher.c,1272 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage414:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage414
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage414
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage414
	NOP
;Solar_Auto_Switcher.c,1273 :: 		StartLoadsVoltage+=0.1;
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
;Solar_Auto_Switcher.c,1275 :: 		}
L_SetStartUpLoadsVoltage413:
;Solar_Auto_Switcher.c,1276 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage416
;Solar_Auto_Switcher.c,1278 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage417:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage417
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage417
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage417
	NOP
;Solar_Auto_Switcher.c,1279 :: 		StartLoadsVoltage-=0.1;
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
;Solar_Auto_Switcher.c,1280 :: 		}
L_SetStartUpLoadsVoltage416:
;Solar_Auto_Switcher.c,1281 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1061
	LDI        R16, 1
L__SetStartUpLoadsVoltage1061:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1062
	JMP        L_SetStartUpLoadsVoltage419
L__SetStartUpLoadsVoltage1062:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage419:
;Solar_Auto_Switcher.c,1282 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage1063
	LDI        R16, 1
L__SetStartUpLoadsVoltage1063:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1064
	JMP        L_SetStartUpLoadsVoltage420
L__SetStartUpLoadsVoltage1064:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage420:
;Solar_Auto_Switcher.c,1283 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage409
L_SetStartUpLoadsVoltage410:
;Solar_Auto_Switcher.c,1284 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage406
L_SetStartUpLoadsVoltage407:
;Solar_Auto_Switcher.c,1286 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1287 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage421:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage421
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage421
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage421
	NOP
;Solar_Auto_Switcher.c,1289 :: 		while(Set==1)
L_SetStartUpLoadsVoltage423:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetStartUpLoadsVoltage424
;Solar_Auto_Switcher.c,1291 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1292 :: 		sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1293 :: 		LCD_OUT(2,4,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1295 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage425
	JMP        L_SetStartUpLoadsVoltage424
L_SetStartUpLoadsVoltage425:
;Solar_Auto_Switcher.c,1296 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage426:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetStartUpLoadsVoltage798
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetStartUpLoadsVoltage797
	JMP        L_SetStartUpLoadsVoltage427
L__SetStartUpLoadsVoltage798:
L__SetStartUpLoadsVoltage797:
;Solar_Auto_Switcher.c,1301 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetStartUpLoadsVoltage430
;Solar_Auto_Switcher.c,1303 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage431:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage431
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage431
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage431
	NOP
;Solar_Auto_Switcher.c,1304 :: 		StartLoadsVoltage_T2+=0.1;
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
;Solar_Auto_Switcher.c,1306 :: 		}
L_SetStartUpLoadsVoltage430:
;Solar_Auto_Switcher.c,1307 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetStartUpLoadsVoltage433
;Solar_Auto_Switcher.c,1309 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage434:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage434
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage434
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage434
	NOP
;Solar_Auto_Switcher.c,1310 :: 		StartLoadsVoltage_T2-=0.1;
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
;Solar_Auto_Switcher.c,1311 :: 		}
L_SetStartUpLoadsVoltage433:
;Solar_Auto_Switcher.c,1312 :: 		if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1065
	LDI        R16, 1
L__SetStartUpLoadsVoltage1065:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1066
	JMP        L_SetStartUpLoadsVoltage436
L__SetStartUpLoadsVoltage1066:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage436:
;Solar_Auto_Switcher.c,1313 :: 		if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
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
	BREQ       L__SetStartUpLoadsVoltage1067
	LDI        R16, 1
L__SetStartUpLoadsVoltage1067:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage1068
	JMP        L_SetStartUpLoadsVoltage437
L__SetStartUpLoadsVoltage1068:
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	STS        _StartLoadsVoltage_T2+2, R27
	STS        _StartLoadsVoltage_T2+3, R27
L_SetStartUpLoadsVoltage437:
;Solar_Auto_Switcher.c,1314 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage426
L_SetStartUpLoadsVoltage427:
;Solar_Auto_Switcher.c,1315 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage423
L_SetStartUpLoadsVoltage424:
;Solar_Auto_Switcher.c,1317 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);   // save float number to
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
;Solar_Auto_Switcher.c,1319 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1320 :: 		}
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

;Solar_Auto_Switcher.c,1322 :: 		void SetHighVoltage()
;Solar_Auto_Switcher.c,1325 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetHighVoltage438:
	DEC        R16
	BRNE       L_SetHighVoltage438
	DEC        R17
	BRNE       L_SetHighVoltage438
	DEC        R18
	BRNE       L_SetHighVoltage438
	NOP
;Solar_Auto_Switcher.c,1326 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1327 :: 		while(Set==1)
L_SetHighVoltage440:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetHighVoltage441
;Solar_Auto_Switcher.c,1329 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1330 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1331 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage442
	JMP        L_SetHighVoltage441
L_SetHighVoltage442:
;Solar_Auto_Switcher.c,1332 :: 		while(Increment==1 || Decrement==1)
L_SetHighVoltage443:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetHighVoltage825
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetHighVoltage824
	JMP        L_SetHighVoltage444
L__SetHighVoltage825:
L__SetHighVoltage824:
;Solar_Auto_Switcher.c,1334 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1335 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1336 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage447
;Solar_Auto_Switcher.c,1338 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage448:
	DEC        R16
	BRNE       L_SetHighVoltage448
	DEC        R17
	BRNE       L_SetHighVoltage448
	DEC        R18
	BRNE       L_SetHighVoltage448
	NOP
;Solar_Auto_Switcher.c,1339 :: 		High_Voltage++;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1340 :: 		}
L_SetHighVoltage447:
;Solar_Auto_Switcher.c,1341 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetHighVoltage450
;Solar_Auto_Switcher.c,1343 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage451:
	DEC        R16
	BRNE       L_SetHighVoltage451
	DEC        R17
	BRNE       L_SetHighVoltage451
	DEC        R18
	BRNE       L_SetHighVoltage451
	NOP
;Solar_Auto_Switcher.c,1344 :: 		High_Voltage--;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1345 :: 		}
L_SetHighVoltage450:
;Solar_Auto_Switcher.c,1346 :: 		if(High_Voltage > 255 ) High_Voltage=0;
	LDS        R18, _High_Voltage+0
	LDS        R19, _High_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetHighVoltage1070
	JMP        L_SetHighVoltage453
L__SetHighVoltage1070:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage453:
;Solar_Auto_Switcher.c,1347 :: 		if (High_Voltage < 0 ) High_Voltage=0;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CPI        R17, 0
	BRNE       L__SetHighVoltage1071
	CPI        R16, 0
L__SetHighVoltage1071:
	BRLO       L__SetHighVoltage1072
	JMP        L_SetHighVoltage454
L__SetHighVoltage1072:
	LDI        R27, 0
	STS        _High_Voltage+0, R27
	STS        _High_Voltage+1, R27
L_SetHighVoltage454:
;Solar_Auto_Switcher.c,1348 :: 		} // end while increment or decrement
	JMP        L_SetHighVoltage443
L_SetHighVoltage444:
;Solar_Auto_Switcher.c,1349 :: 		} // end while set
	JMP        L_SetHighVoltage440
L_SetHighVoltage441:
;Solar_Auto_Switcher.c,1350 :: 		EEPROM_Write(0x12,High_Voltage);
	LDS        R4, _High_Voltage+0
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1351 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1352 :: 		}
L_end_SetHighVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetHighVoltage

_SetLowVoltage:

;Solar_Auto_Switcher.c,1354 :: 		void SetLowVoltage()
;Solar_Auto_Switcher.c,1357 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowVoltage455:
	DEC        R16
	BRNE       L_SetLowVoltage455
	DEC        R17
	BRNE       L_SetLowVoltage455
	DEC        R18
	BRNE       L_SetLowVoltage455
	NOP
;Solar_Auto_Switcher.c,1358 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1359 :: 		while(Set==1)
L_SetLowVoltage457:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowVoltage458
;Solar_Auto_Switcher.c,1361 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1362 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1363 :: 		if (Exit==1)   break;     //break out of the while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage459
	JMP        L_SetLowVoltage458
L_SetLowVoltage459:
;Solar_Auto_Switcher.c,1364 :: 		while(Increment==1 || Decrement==1)
L_SetLowVoltage460:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowVoltage828
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowVoltage827
	JMP        L_SetLowVoltage461
L__SetLowVoltage828:
L__SetLowVoltage827:
;Solar_Auto_Switcher.c,1366 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1367 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1368 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage464
;Solar_Auto_Switcher.c,1370 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage465:
	DEC        R16
	BRNE       L_SetLowVoltage465
	DEC        R17
	BRNE       L_SetLowVoltage465
	DEC        R18
	BRNE       L_SetLowVoltage465
	NOP
;Solar_Auto_Switcher.c,1371 :: 		Low_Voltage++;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1372 :: 		}
L_SetLowVoltage464:
;Solar_Auto_Switcher.c,1373 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowVoltage467
;Solar_Auto_Switcher.c,1375 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage468:
	DEC        R16
	BRNE       L_SetLowVoltage468
	DEC        R17
	BRNE       L_SetLowVoltage468
	DEC        R18
	BRNE       L_SetLowVoltage468
	NOP
;Solar_Auto_Switcher.c,1376 :: 		Low_Voltage--;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1377 :: 		}
L_SetLowVoltage467:
;Solar_Auto_Switcher.c,1378 :: 		if(Low_Voltage > 255 ) Low_Voltage=0;
	LDS        R18, _Low_Voltage+0
	LDS        R19, _Low_Voltage+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__SetLowVoltage1074
	JMP        L_SetLowVoltage470
L__SetLowVoltage1074:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage470:
;Solar_Auto_Switcher.c,1379 :: 		if (Low_Voltage < 0 ) Low_Voltage=0;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CPI        R17, 0
	BRNE       L__SetLowVoltage1075
	CPI        R16, 0
L__SetLowVoltage1075:
	BRLO       L__SetLowVoltage1076
	JMP        L_SetLowVoltage471
L__SetLowVoltage1076:
	LDI        R27, 0
	STS        _Low_Voltage+0, R27
	STS        _Low_Voltage+1, R27
L_SetLowVoltage471:
;Solar_Auto_Switcher.c,1380 :: 		} // end while increment or decrement
	JMP        L_SetLowVoltage460
L_SetLowVoltage461:
;Solar_Auto_Switcher.c,1381 :: 		} // end while set
	JMP        L_SetLowVoltage457
L_SetLowVoltage458:
;Solar_Auto_Switcher.c,1382 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1383 :: 		EEPROM_Write(0x13,Low_Voltage);
	LDS        R4, _Low_Voltage+0
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1384 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1385 :: 		}
L_end_SetLowVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowVoltage

_Startup_Timers:

;Solar_Auto_Switcher.c,1389 :: 		void Startup_Timers()
;Solar_Auto_Switcher.c,1391 :: 		LCD_OUT(1,1,"Start Loads [15]");
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
;Solar_Auto_Switcher.c,1392 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers472:
	DEC        R16
	BRNE       L_Startup_Timers472
	DEC        R17
	BRNE       L_Startup_Timers472
	DEC        R18
	BRNE       L_Startup_Timers472
	NOP
;Solar_Auto_Switcher.c,1393 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1394 :: 		while(Set==1)
L_Startup_Timers474:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers475
;Solar_Auto_Switcher.c,1396 :: 		IntToStr(startupTIme_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_1+0
	LDS        R3, _startupTIme_1+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1397 :: 		LCD_OUT(2,1,"T1");
	LDI        R27, #lo_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1399 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1400 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers476
	JMP        L_Startup_Timers475
L_Startup_Timers476:
;Solar_Auto_Switcher.c,1401 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers477:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers820
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers819
	JMP        L_Startup_Timers478
L__Startup_Timers820:
L__Startup_Timers819:
;Solar_Auto_Switcher.c,1403 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers481
;Solar_Auto_Switcher.c,1406 :: 		Delay_ms(100);
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
;Solar_Auto_Switcher.c,1407 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1408 :: 		}
L_Startup_Timers481:
;Solar_Auto_Switcher.c,1409 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers484
;Solar_Auto_Switcher.c,1412 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers485:
	DEC        R16
	BRNE       L_Startup_Timers485
	DEC        R17
	BRNE       L_Startup_Timers485
	DEC        R18
	BRNE       L_Startup_Timers485
;Solar_Auto_Switcher.c,1413 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Auto_Switcher.c,1414 :: 		}
L_Startup_Timers484:
;Solar_Auto_Switcher.c,1415 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1078
	JMP        L_Startup_Timers487
L__Startup_Timers1078:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers487:
;Solar_Auto_Switcher.c,1416 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1079
	CPI        R16, 0
L__Startup_Timers1079:
	BRLO       L__Startup_Timers1080
	JMP        L_Startup_Timers488
L__Startup_Timers1080:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers488:
;Solar_Auto_Switcher.c,1417 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers477
L_Startup_Timers478:
;Solar_Auto_Switcher.c,1418 :: 		} // end while main while set
	JMP        L_Startup_Timers474
L_Startup_Timers475:
;Solar_Auto_Switcher.c,1419 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1421 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers489:
	DEC        R16
	BRNE       L_Startup_Timers489
	DEC        R17
	BRNE       L_Startup_Timers489
	DEC        R18
	BRNE       L_Startup_Timers489
	NOP
;Solar_Auto_Switcher.c,1422 :: 		while (Set==1)
L_Startup_Timers491:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_Startup_Timers492
;Solar_Auto_Switcher.c,1424 :: 		IntToStr(startupTIme_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _startupTIme_2+0
	LDS        R3, _startupTIme_2+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1425 :: 		LCD_OUT(2,1,"T2");
	LDI        R27, #lo_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1427 :: 		LCD_OUT(2,5,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1428 :: 		if(Exit==1) break ; // break while loop
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L_Startup_Timers493
	JMP        L_Startup_Timers492
L_Startup_Timers493:
;Solar_Auto_Switcher.c,1429 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers494:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__Startup_Timers822
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__Startup_Timers821
	JMP        L_Startup_Timers495
L__Startup_Timers822:
L__Startup_Timers821:
;Solar_Auto_Switcher.c,1431 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_Startup_Timers498
;Solar_Auto_Switcher.c,1434 :: 		Delay_ms(100);
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
;Solar_Auto_Switcher.c,1435 :: 		startupTIme_2++;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1436 :: 		}
L_Startup_Timers498:
;Solar_Auto_Switcher.c,1437 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_Startup_Timers501
;Solar_Auto_Switcher.c,1440 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Startup_Timers502:
	DEC        R16
	BRNE       L_Startup_Timers502
	DEC        R17
	BRNE       L_Startup_Timers502
	DEC        R18
	BRNE       L_Startup_Timers502
;Solar_Auto_Switcher.c,1441 :: 		startupTIme_2--;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_2+0, R16
	STS        _startupTIme_2+1, R17
;Solar_Auto_Switcher.c,1442 :: 		}
L_Startup_Timers501:
;Solar_Auto_Switcher.c,1443 :: 		if(startupTIme_2 > 600 ) startupTIme_2=0;
	LDS        R18, _startupTIme_2+0
	LDS        R19, _startupTIme_2+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers1081
	JMP        L_Startup_Timers504
L__Startup_Timers1081:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers504:
;Solar_Auto_Switcher.c,1444 :: 		if (startupTIme_2<0) startupTIme_2=0;
	LDS        R16, _startupTIme_2+0
	LDS        R17, _startupTIme_2+1
	CPI        R17, 0
	BRNE       L__Startup_Timers1082
	CPI        R16, 0
L__Startup_Timers1082:
	BRLO       L__Startup_Timers1083
	JMP        L_Startup_Timers505
L__Startup_Timers1083:
	LDI        R27, 0
	STS        _startupTIme_2+0, R27
	STS        _startupTIme_2+1, R27
L_Startup_Timers505:
;Solar_Auto_Switcher.c,1445 :: 		} // end while increment and decrement
	JMP        L_Startup_Timers494
L_Startup_Timers495:
;Solar_Auto_Switcher.c,1446 :: 		} // end while set
	JMP        L_Startup_Timers491
L_Startup_Timers492:
;Solar_Auto_Switcher.c,1449 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1450 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1453 :: 		} // end  function
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

;Solar_Auto_Switcher.c,1481 :: 		void Screen_1()
;Solar_Auto_Switcher.c,1485 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Auto_Switcher.c,1486 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Auto_Switcher.c,1487 :: 		CalculateAC();
	CALL       _CalculateAC+0
;Solar_Auto_Switcher.c,1488 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Auto_Switcher.c,1490 :: 		void ADCBattery()
;Solar_Auto_Switcher.c,1492 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Auto_Switcher.c,1493 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Auto_Switcher.c,1494 :: 		ADPS2_Bit=1;
	LDS        R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	STS        ADPS2_bit+0, R27
;Solar_Auto_Switcher.c,1495 :: 		ADPS1_Bit=1;
	LDS        R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	STS        ADPS1_bit+0, R27
;Solar_Auto_Switcher.c,1496 :: 		ADPS0_Bit=0;
	LDS        R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	STS        ADPS0_bit+0, R27
;Solar_Auto_Switcher.c,1497 :: 		}
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

;Solar_Auto_Switcher.c,1499 :: 		void Read_Battery()
;Solar_Auto_Switcher.c,1501 :: 		float sum=0 , Battery[10];
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 0
	STD        Y+40, R27
	STD        Y+41, R27
	STD        Y+42, R27
	STD        Y+43, R27
;Solar_Auto_Switcher.c,1502 :: 		char i=0;
;Solar_Auto_Switcher.c,1503 :: 		ADC_Value=ADC_Read(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Auto_Switcher.c,1504 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
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
;Solar_Auto_Switcher.c,1508 :: 		for ( i=0; i<10 ; i++)
	LDI        R27, 0
	STD        Y+44, R27
L_Read_Battery506:
	LDD        R16, Y+44
	CPI        R16, 10
	BRLO       L__Read_Battery1087
	JMP        L_Read_Battery507
L__Read_Battery1087:
;Solar_Auto_Switcher.c,1510 :: 		Battery[i]=((10.5/0.5)*Battery_Voltage);
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
;Solar_Auto_Switcher.c,1511 :: 		delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Read_Battery509:
	DEC        R16
	BRNE       L_Read_Battery509
	DEC        R17
	BRNE       L_Read_Battery509
	DEC        R18
	BRNE       L_Read_Battery509
;Solar_Auto_Switcher.c,1512 :: 		sum+=Battery[i];
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
;Solar_Auto_Switcher.c,1508 :: 		for ( i=0; i<10 ; i++)
	LDD        R16, Y+44
	SUBI       R16, 255
	STD        Y+44, R16
;Solar_Auto_Switcher.c,1513 :: 		}
	JMP        L_Read_Battery506
L_Read_Battery507:
;Solar_Auto_Switcher.c,1514 :: 		Vin_Battery= sum/10.0 ;
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
;Solar_Auto_Switcher.c,1515 :: 		LCD_OUT(2,1,"V=");
	LDI        R27, #lo_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1516 :: 		sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
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
;Solar_Auto_Switcher.c,1517 :: 		LCD_OUT(2,3,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1519 :: 		}
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

;Solar_Auto_Switcher.c,1522 :: 		void LowBatteryVoltageAlarm()
;Solar_Auto_Switcher.c,1524 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
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
	BREQ       L__LowBatteryVoltageAlarm1089
	LDI        R16, 1
L__LowBatteryVoltageAlarm1089:
	TST        R16
	BRNE       L__LowBatteryVoltageAlarm1090
	JMP        L__LowBatteryVoltageAlarm850
L__LowBatteryVoltageAlarm1090:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__LowBatteryVoltageAlarm1091
	JMP        L__LowBatteryVoltageAlarm849
L__LowBatteryVoltageAlarm1091:
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1092
	JMP        L__LowBatteryVoltageAlarm848
L__LowBatteryVoltageAlarm1092:
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 1
	BRNE       L__LowBatteryVoltageAlarm1093
	JMP        L__LowBatteryVoltageAlarm847
L__LowBatteryVoltageAlarm1093:
	JMP        L_LowBatteryVoltageAlarm515
L__LowBatteryVoltageAlarm848:
L__LowBatteryVoltageAlarm847:
L__LowBatteryVoltageAlarm845:
;Solar_Auto_Switcher.c,1526 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1527 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm516:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm516
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm516
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm516
	NOP
;Solar_Auto_Switcher.c,1528 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1529 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_LowBatteryVoltageAlarm518:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm518
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm518
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm518
	NOP
;Solar_Auto_Switcher.c,1530 :: 		}
L_LowBatteryVoltageAlarm515:
;Solar_Auto_Switcher.c,1524 :: 		if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false && (Timer_isOn==1 || Timer_2_isOn==1)  ) // to give some time to the handle the situation
L__LowBatteryVoltageAlarm850:
L__LowBatteryVoltageAlarm849:
;Solar_Auto_Switcher.c,1531 :: 		}
L_end_LowBatteryVoltageAlarm:
	RET
; end of _LowBatteryVoltageAlarm

_ReadAC:

;Solar_Auto_Switcher.c,1533 :: 		unsigned int ReadAC()
;Solar_Auto_Switcher.c,1535 :: 		char numberOfSamples=100;
	PUSH       R2
;Solar_Auto_Switcher.c,1536 :: 		char numberOfAverage=10;
;Solar_Auto_Switcher.c,1537 :: 		unsigned long sum=0;
;Solar_Auto_Switcher.c,1538 :: 		unsigned long r=0;
;Solar_Auto_Switcher.c,1539 :: 		unsigned long max_v=0;
; max_v start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
;Solar_Auto_Switcher.c,1540 :: 		char i=0;
;Solar_Auto_Switcher.c,1541 :: 		char j=0;
;Solar_Auto_Switcher.c,1542 :: 		unsigned long average=0;
;Solar_Auto_Switcher.c,1544 :: 		for (i=0;i<100;i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; max_v end address is: 19 (R19)
; i end address is: 18 (R18)
L_ReadAC520:
; i start address is: 18 (R18)
; max_v start address is: 19 (R19)
	CPI        R18, 100
	BRLO       L__ReadAC1095
	JMP        L_ReadAC521
L__ReadAC1095:
;Solar_Auto_Switcher.c,1546 :: 		r=ADC_Read(3);
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
;Solar_Auto_Switcher.c,1547 :: 		if (max_v<r) max_v=r;
	CP         R19, R23
	CPC        R20, R24
	CPC        R21, R25
	CPC        R22, R26
	BRLO       L__ReadAC1096
	JMP        L__ReadAC762
L__ReadAC1096:
	MOV        R19, R23
	MOV        R20, R24
	MOV        R21, R25
	MOV        R22, R26
; r end address is: 23 (R23)
; max_v end address is: 19 (R19)
	JMP        L_ReadAC523
L__ReadAC762:
L_ReadAC523:
;Solar_Auto_Switcher.c,1548 :: 		delay_us(200);
; max_v start address is: 19 (R19)
	LDI        R17, 3
	LDI        R16, 19
L_ReadAC524:
	DEC        R16
	BRNE       L_ReadAC524
	DEC        R17
	BRNE       L_ReadAC524
;Solar_Auto_Switcher.c,1544 :: 		for (i=0;i<100;i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Solar_Auto_Switcher.c,1549 :: 		}
; i end address is: 18 (R18)
	JMP        L_ReadAC520
L_ReadAC521:
;Solar_Auto_Switcher.c,1550 :: 		return max_v;
	MOV        R16, R19
	MOV        R17, R20
; max_v end address is: 19 (R19)
;Solar_Auto_Switcher.c,1564 :: 		}
;Solar_Auto_Switcher.c,1550 :: 		return max_v;
;Solar_Auto_Switcher.c,1564 :: 		}
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

;Solar_Auto_Switcher.c,1566 :: 		void CalculateAC()
;Solar_Auto_Switcher.c,1569 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,1570 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,1571 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1572 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,1573 :: 		v=v+Error_Voltage;
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
;Solar_Auto_Switcher.c,1575 :: 		if (AC_Available==0 && VoltageProtectionEnable==1)   // disable the ac voltage if voltage protector is enabeled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__CalculateAC842
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CalculateAC1098
	JMP        L__CalculateAC841
L__CalculateAC1098:
L__CalculateAC840:
;Solar_Auto_Switcher.c,1577 :: 		sprintf(buf,"%4.0fV",v);
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
;Solar_Auto_Switcher.c,1578 :: 		LCD_OUT(2,8,"-");
	LDI        R27, #lo_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1579 :: 		LCD_OUT(2,9,buf);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1580 :: 		}
	JMP        L_CalculateAC529
;Solar_Auto_Switcher.c,1575 :: 		if (AC_Available==0 && VoltageProtectionEnable==1)   // disable the ac voltage if voltage protector is enabeled
L__CalculateAC842:
L__CalculateAC841:
;Solar_Auto_Switcher.c,1581 :: 		else if (AC_Available== 0 && VoltageProtectionEnable==0) // in this if voltage protector is turned of no need for voltage read
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__CalculateAC844
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__CalculateAC1099
	JMP        L__CalculateAC843
L__CalculateAC1099:
L__CalculateAC839:
;Solar_Auto_Switcher.c,1583 :: 		LCD_out(2,8,"- Grid");
	LDI        R27, #lo_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1581 :: 		else if (AC_Available== 0 && VoltageProtectionEnable==0) // in this if voltage protector is turned of no need for voltage read
L__CalculateAC844:
L__CalculateAC843:
;Solar_Auto_Switcher.c,1584 :: 		}
L_CalculateAC529:
;Solar_Auto_Switcher.c,1585 :: 		VoltageProtector(v);
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _VoltageProtector+0
;Solar_Auto_Switcher.c,1586 :: 		}
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

;Solar_Auto_Switcher.c,1590 :: 		void VoltageProtector(unsigned long voltage)
;Solar_Auto_Switcher.c,1593 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRSH       L__VoltageProtector1101
	JMP        L__VoltageProtector834
L__VoltageProtector1101:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRSH       L__VoltageProtector1102
	JMP        L__VoltageProtector833
L__VoltageProtector1102:
	JMP        L_VoltageProtector537
L__VoltageProtector834:
L__VoltageProtector833:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector835
L__VoltageProtector831:
;Solar_Auto_Switcher.c,1595 :: 		VoltageProtectorGood=0;
	LDI        R27, 0
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1596 :: 		}
L_VoltageProtector537:
;Solar_Auto_Switcher.c,1593 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
L__VoltageProtector835:
;Solar_Auto_Switcher.c,1598 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRLO       L__VoltageProtector1103
	JMP        L__VoltageProtector838
L__VoltageProtector1103:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRLO       L__VoltageProtector1104
	JMP        L__VoltageProtector837
L__VoltageProtector1104:
L__VoltageProtector830:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector836
L__VoltageProtector829:
;Solar_Auto_Switcher.c,1600 :: 		VoltageProtectorGood=1;
	LDI        R27, 1
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1598 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
L__VoltageProtector838:
L__VoltageProtector837:
L__VoltageProtector836:
;Solar_Auto_Switcher.c,1602 :: 		}
L_end_VoltageProtector:
	RET
; end of _VoltageProtector

_ErrorList:

;Solar_Auto_Switcher.c,1604 :: 		void ErrorList()
;Solar_Auto_Switcher.c,1617 :: 		}
L_end_ErrorList:
	RET
; end of _ErrorList

_Start_Timer_0_A:

;Solar_Auto_Switcher.c,1620 :: 		void Start_Timer_0_A()
;Solar_Auto_Switcher.c,1622 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Auto_Switcher.c,1623 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Auto_Switcher.c,1624 :: 		WGM02_bit=0;
	IN         R27, WGM02_bit+0
	CBR        R27, BitMask(WGM02_bit+0)
	OUT        WGM02_bit+0, R27
;Solar_Auto_Switcher.c,1625 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1626 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1627 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1628 :: 		OCR0A=0xFF;
	LDI        R27, 255
	OUT        OCR0A+0, R27
;Solar_Auto_Switcher.c,1629 :: 		OCIE0A_Bit=1;
	LDS        R27, OCIE0A_bit+0
	SBR        R27, BitMask(OCIE0A_bit+0)
	STS        OCIE0A_bit+0, R27
;Solar_Auto_Switcher.c,1630 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_A_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,1632 :: 		void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
;Solar_Auto_Switcher.c,1634 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1635 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Auto_Switcher.c,1636 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Auto_Switcher.c,1637 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Auto_Switcher.c,1640 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1108
	CPI        R18, 244
L__Interupt_Timer_0_A_OFFTime1108:
	BREQ       L__Interupt_Timer_0_A_OFFTime1109
	JMP        L_Interupt_Timer_0_A_OFFTime543
L__Interupt_Timer_0_A_OFFTime1109:
;Solar_Auto_Switcher.c,1643 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1110
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1110:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1111
	JMP        L__Interupt_Timer_0_A_OFFTime855
L__Interupt_Timer_0_A_OFFTime1111:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime854
L__Interupt_Timer_0_A_OFFTime853:
;Solar_Auto_Switcher.c,1645 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1646 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_A_OFFTime547:
	DEC        R16
	BRNE       L_Interupt_Timer_0_A_OFFTime547
	DEC        R17
	BRNE       L_Interupt_Timer_0_A_OFFTime547
	DEC        R18
	BRNE       L_Interupt_Timer_0_A_OFFTime547
	NOP
;Solar_Auto_Switcher.c,1647 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1648 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1643 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime855:
L__Interupt_Timer_0_A_OFFTime854:
;Solar_Auto_Switcher.c,1650 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Auto_Switcher.c,1651 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1652 :: 		}
L_Interupt_Timer_0_A_OFFTime543:
;Solar_Auto_Switcher.c,1655 :: 		if (Timer_Counter_4==500)              // more than 10 seconds
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	CPI        R17, 1
	BRNE       L__Interupt_Timer_0_A_OFFTime1112
	CPI        R16, 244
L__Interupt_Timer_0_A_OFFTime1112:
	BREQ       L__Interupt_Timer_0_A_OFFTime1113
	JMP        L_Interupt_Timer_0_A_OFFTime549
L__Interupt_Timer_0_A_OFFTime1113:
;Solar_Auto_Switcher.c,1658 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_A_OFFTime1114
	LDI        R16, 1
L__Interupt_Timer_0_A_OFFTime1114:
	TST        R16
	BRNE       L__Interupt_Timer_0_A_OFFTime1115
	JMP        L__Interupt_Timer_0_A_OFFTime857
L__Interupt_Timer_0_A_OFFTime1115:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime856
L__Interupt_Timer_0_A_OFFTime852:
;Solar_Auto_Switcher.c,1660 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1661 :: 		Delay_ms(500);
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
;Solar_Auto_Switcher.c,1662 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1663 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1658 :: 		if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
L__Interupt_Timer_0_A_OFFTime857:
L__Interupt_Timer_0_A_OFFTime856:
;Solar_Auto_Switcher.c,1665 :: 		Timer_Counter_4=0;
	LDI        R27, 0
	STS        _Timer_Counter_4+0, R27
	STS        _Timer_Counter_4+1, R27
;Solar_Auto_Switcher.c,1666 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1667 :: 		}
L_Interupt_Timer_0_A_OFFTime549:
;Solar_Auto_Switcher.c,1671 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_A_OFFTime1116
	CPI        R16, 232
L__Interupt_Timer_0_A_OFFTime1116:
	BREQ       L__Interupt_Timer_0_A_OFFTime1117
	JMP        L_Interupt_Timer_0_A_OFFTime555
L__Interupt_Timer_0_A_OFFTime1117:
;Solar_Auto_Switcher.c,1673 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 0
	BREQ       L__Interupt_Timer_0_A_OFFTime1118
	JMP        L__Interupt_Timer_0_A_OFFTime859
L__Interupt_Timer_0_A_OFFTime1118:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Interupt_Timer_0_A_OFFTime858
L__Interupt_Timer_0_A_OFFTime851:
;Solar_Auto_Switcher.c,1675 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1676 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1677 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1678 :: 		LCD_CLEAR(2,7,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1673 :: 		if(VoltageProtectorGood==0 && AC_Available==0)
L__Interupt_Timer_0_A_OFFTime859:
L__Interupt_Timer_0_A_OFFTime858:
;Solar_Auto_Switcher.c,1680 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Auto_Switcher.c,1681 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Auto_Switcher.c,1682 :: 		}
L_Interupt_Timer_0_A_OFFTime555:
;Solar_Auto_Switcher.c,1684 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,1685 :: 		OCF0A_Bit=1; // clear
	IN         R27, OCF0A_bit+0
	SBR        R27, BitMask(OCF0A_bit+0)
	OUT        OCF0A_bit+0, R27
;Solar_Auto_Switcher.c,1686 :: 		}
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

;Solar_Auto_Switcher.c,1688 :: 		void Stop_Timer_0()
;Solar_Auto_Switcher.c,1690 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Auto_Switcher.c,1691 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Auto_Switcher.c,1692 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Auto_Switcher.c,1693 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Auto_Switcher.c,1696 :: 		void EEPROM_FactorySettings(char period)
;Solar_Auto_Switcher.c,1698 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1121
	JMP        L_EEPROM_FactorySettings559
L__EEPROM_FactorySettings1121:
;Solar_Auto_Switcher.c,1700 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1701 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1702 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1703 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1704 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1705 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1707 :: 		EEPROM_Write(0x00,8);  // writing start hours
	PUSH       R2
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1708 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1709 :: 		EEPROM_Write(0x03,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1710 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1712 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1713 :: 		EEPROM_Write(0x19,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1714 :: 		EEPROM_Write(0x20,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1715 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1717 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1718 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1719 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1720 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1721 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1722 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1723 :: 		}
L_EEPROM_FactorySettings559:
;Solar_Auto_Switcher.c,1724 :: 		if (period==0) // winter timer
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings1122
	JMP        L_EEPROM_FactorySettings560
L__EEPROM_FactorySettings1122:
;Solar_Auto_Switcher.c,1726 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Auto_Switcher.c,1727 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Auto_Switcher.c,1728 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Auto_Switcher.c,1729 :: 		startupTIme_2=240,
	LDI        R27, 240
	STS        _startupTIme_2+0, R27
	LDI        R27, 0
	STS        _startupTIme_2+1, R27
;Solar_Auto_Switcher.c,1730 :: 		Mini_Battery_Voltage_T2=25.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage_T2+0, R27
	STS        _Mini_Battery_Voltage_T2+1, R27
	LDI        R27, 204
	STS        _Mini_Battery_Voltage_T2+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage_T2+3, R27
;Solar_Auto_Switcher.c,1731 :: 		StartLoadsVoltage_T2=27.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage_T2+0, R27
	STS        _StartLoadsVoltage_T2+1, R27
	LDI        R27, 220
	STS        _StartLoadsVoltage_T2+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage_T2+3, R27
;Solar_Auto_Switcher.c,1733 :: 		EEPROM_Write(0x00,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1734 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1735 :: 		EEPROM_Write(0x03,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1736 :: 		EEPROM_Write(0x04,0);    // writing off minutes
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1738 :: 		EEPROM_Write(0x18,9);  // writing start hours
	LDI        R27, 9
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1739 :: 		EEPROM_Write(0x19,30);    // writing  start minutes
	LDI        R27, 30
	MOV        R4, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1740 :: 		EEPROM_Write(0x20,15);    // writing off hours
	LDI        R27, 15
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1741 :: 		EEPROM_Write(0x21,0);    // writing off minutes
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1743 :: 		StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Auto_Switcher.c,1744 :: 		StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Auto_Switcher.c,1745 :: 		StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,1746 :: 		StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,1747 :: 		StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,1748 :: 		StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,1749 :: 		}
L_EEPROM_FactorySettings560:
;Solar_Auto_Switcher.c,1751 :: 		EEPROM_Write(0x12,255); //  high voltage Grid
	LDI        R27, 255
	MOV        R4, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1752 :: 		EEPROM_Write(0x13,170); // load low voltage
	LDI        R27, 170
	MOV        R4, R27
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1755 :: 		EEPROM_Write(0x15,0); // voltage protector not enabled as default
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1756 :: 		}
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

;Solar_Auto_Switcher.c,1758 :: 		RunTimersNowCheck()
;Solar_Auto_Switcher.c,1778 :: 		if(Increment==1 && Exit==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck871
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck870
L__RunTimersNowCheck867:
;Solar_Auto_Switcher.c,1780 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck564:
	DEC        R16
	BRNE       L_RunTimersNowCheck564
	DEC        R17
	BRNE       L_RunTimersNowCheck564
	DEC        R18
	BRNE       L_RunTimersNowCheck564
	NOP
;Solar_Auto_Switcher.c,1781 :: 		if (Increment==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck869
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck868
L__RunTimersNowCheck866:
;Solar_Auto_Switcher.c,1783 :: 		RunLoadsByBass++;
	LDS        R16, _RunLoadsByBass+0
	SUBI       R16, 255
	STS        _RunLoadsByBass+0, R16
;Solar_Auto_Switcher.c,1784 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	CPI        R16, 1
	BREQ       L__RunTimersNowCheck1124
	JMP        L_RunTimersNowCheck569
L__RunTimersNowCheck1124:
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
L_RunTimersNowCheck569:
;Solar_Auto_Switcher.c,1785 :: 		if (RunLoadsByBass>=2 )
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 2
	BRSH       L__RunTimersNowCheck1125
	JMP        L_RunTimersNowCheck570
L__RunTimersNowCheck1125:
;Solar_Auto_Switcher.c,1787 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck571:
	DEC        R16
	BRNE       L_RunTimersNowCheck571
	DEC        R17
	BRNE       L_RunTimersNowCheck571
	DEC        R18
	BRNE       L_RunTimersNowCheck571
	NOP
;Solar_Auto_Switcher.c,1788 :: 		Relay_L_Solar_2=1;
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1789 :: 		}
L_RunTimersNowCheck570:
;Solar_Auto_Switcher.c,1790 :: 		LCD_OUT(1,15,"B");
	LDI        R27, #lo_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1781 :: 		if (Increment==1 && Exit==0)
L__RunTimersNowCheck869:
L__RunTimersNowCheck868:
;Solar_Auto_Switcher.c,1778 :: 		if(Increment==1 && Exit==0)
L__RunTimersNowCheck871:
L__RunTimersNowCheck870:
;Solar_Auto_Switcher.c,1794 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck877
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck876
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck875
L__RunTimersNowCheck865:
;Solar_Auto_Switcher.c,1796 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck576:
	DEC        R16
	BRNE       L_RunTimersNowCheck576
	DEC        R17
	BRNE       L_RunTimersNowCheck576
	DEC        R18
	BRNE       L_RunTimersNowCheck576
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1797 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck874
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck873
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__RunTimersNowCheck872
L__RunTimersNowCheck864:
;Solar_Auto_Switcher.c,1799 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck581:
	DEC        R16
	BRNE       L_RunTimersNowCheck581
	DEC        R17
	BRNE       L_RunTimersNowCheck581
	DEC        R18
	BRNE       L_RunTimersNowCheck581
	NOP
;Solar_Auto_Switcher.c,1800 :: 		EEPROM_FactorySettings(1);        // summer time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1801 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck583:
	DEC        R16
	BRNE       L_RunTimersNowCheck583
	DEC        R17
	BRNE       L_RunTimersNowCheck583
	DEC        R18
	BRNE       L_RunTimersNowCheck583
;Solar_Auto_Switcher.c,1802 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1803 :: 		LCD_OUT(2,1,"Reset Summer    ");
	LDI        R27, #lo_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1804 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck585:
	DEC        R16
	BRNE       L_RunTimersNowCheck585
	DEC        R17
	BRNE       L_RunTimersNowCheck585
	DEC        R18
	BRNE       L_RunTimersNowCheck585
;Solar_Auto_Switcher.c,1805 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1797 :: 		if ( Increment==1 && Exit==1 && Decrement==0)
L__RunTimersNowCheck874:
L__RunTimersNowCheck873:
L__RunTimersNowCheck872:
;Solar_Auto_Switcher.c,1794 :: 		if (Increment==1 && Exit==1 && Decrement==0)      // first
L__RunTimersNowCheck877:
L__RunTimersNowCheck876:
L__RunTimersNowCheck875:
;Solar_Auto_Switcher.c,1808 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck883
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck882
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck881
L__RunTimersNowCheck863:
;Solar_Auto_Switcher.c,1810 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck590:
	DEC        R16
	BRNE       L_RunTimersNowCheck590
	DEC        R17
	BRNE       L_RunTimersNowCheck590
	DEC        R18
	BRNE       L_RunTimersNowCheck590
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1811 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck880
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__RunTimersNowCheck879
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck878
L__RunTimersNowCheck862:
;Solar_Auto_Switcher.c,1813 :: 		Delay_ms(5000);
	LDI        R18, 203
	LDI        R17, 236
	LDI        R16, 133
L_RunTimersNowCheck595:
	DEC        R16
	BRNE       L_RunTimersNowCheck595
	DEC        R17
	BRNE       L_RunTimersNowCheck595
	DEC        R18
	BRNE       L_RunTimersNowCheck595
	NOP
;Solar_Auto_Switcher.c,1814 :: 		EEPROM_FactorySettings(0);        // winter time
	CLR        R2
	CALL       _EEPROM_FactorySettings+0
;Solar_Auto_Switcher.c,1815 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck597:
	DEC        R16
	BRNE       L_RunTimersNowCheck597
	DEC        R17
	BRNE       L_RunTimersNowCheck597
	DEC        R18
	BRNE       L_RunTimersNowCheck597
;Solar_Auto_Switcher.c,1816 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1817 :: 		LCD_OUT(2,1,"Reset Winter    ");
	LDI        R27, #lo_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1818 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck599:
	DEC        R16
	BRNE       L_RunTimersNowCheck599
	DEC        R17
	BRNE       L_RunTimersNowCheck599
	DEC        R18
	BRNE       L_RunTimersNowCheck599
;Solar_Auto_Switcher.c,1819 :: 		LCD_CLEAR(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1811 :: 		if ( Increment==0 && Exit==1 && Decrement==1)
L__RunTimersNowCheck880:
L__RunTimersNowCheck879:
L__RunTimersNowCheck878:
;Solar_Auto_Switcher.c,1808 :: 		if (Increment==0 && Exit==1 && Decrement==1)      // first
L__RunTimersNowCheck883:
L__RunTimersNowCheck882:
L__RunTimersNowCheck881:
;Solar_Auto_Switcher.c,1841 :: 		if(Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck887
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck886
L__RunTimersNowCheck861:
;Solar_Auto_Switcher.c,1843 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck604:
	DEC        R16
	BRNE       L_RunTimersNowCheck604
	DEC        R17
	BRNE       L_RunTimersNowCheck604
	DEC        R18
	BRNE       L_RunTimersNowCheck604
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1844 :: 		if (Decrement==1 && Exit==0)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L__RunTimersNowCheck885
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__RunTimersNowCheck884
L__RunTimersNowCheck860:
;Solar_Auto_Switcher.c,1846 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Auto_Switcher.c,1847 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Auto_Switcher.c,1848 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1849 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1851 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1844 :: 		if (Decrement==1 && Exit==0)
L__RunTimersNowCheck885:
L__RunTimersNowCheck884:
;Solar_Auto_Switcher.c,1841 :: 		if(Decrement==1 && Exit==0)
L__RunTimersNowCheck887:
L__RunTimersNowCheck886:
;Solar_Auto_Switcher.c,1854 :: 		}
L_end_RunTimersNowCheck:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_CheckForSet:

;Solar_Auto_Switcher.c,1857 :: 		void CheckForSet()
;Solar_Auto_Switcher.c,1860 :: 		if (Set==0 && Exit==0) SetUpProgram();
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForSet890
	IN         R27, PINC+0
	SBRC       R27, 0
	JMP        L__CheckForSet889
L__CheckForSet888:
	CALL       _SetUpProgram+0
L__CheckForSet890:
L__CheckForSet889:
;Solar_Auto_Switcher.c,1862 :: 		}
L_end_CheckForSet:
	RET
; end of _CheckForSet

_AutoRunWithOutBatteryProtection:

;Solar_Auto_Switcher.c,1865 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Auto_Switcher.c,1867 :: 		if (Vin_Battery==0)
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
	BREQ       L__AutoRunWithOutBatteryProtection1128
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection1128:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection1129
	JMP        L_AutoRunWithOutBatteryProtection612
L__AutoRunWithOutBatteryProtection1129:
;Solar_Auto_Switcher.c,1869 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1870 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection613
L_AutoRunWithOutBatteryProtection612:
;Solar_Auto_Switcher.c,1873 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Auto_Switcher.c,1874 :: 		}
L_AutoRunWithOutBatteryProtection613:
;Solar_Auto_Switcher.c,1875 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Auto_Switcher.c,1877 :: 		void CheckForTimerActivationInRange()
;Solar_Auto_Switcher.c,1881 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1131
	JMP        L__CheckForTimerActivationInRange897
L__CheckForTimerActivationInRange1131:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1132
	JMP        L__CheckForTimerActivationInRange896
L__CheckForTimerActivationInRange1132:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1133
	JMP        L__CheckForTimerActivationInRange895
L__CheckForTimerActivationInRange1133:
L__CheckForTimerActivationInRange894:
;Solar_Auto_Switcher.c,1883 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1881 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
L__CheckForTimerActivationInRange897:
L__CheckForTimerActivationInRange896:
L__CheckForTimerActivationInRange895:
;Solar_Auto_Switcher.c,1888 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1134
	JMP        L__CheckForTimerActivationInRange900
L__CheckForTimerActivationInRange1134:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1135
	JMP        L__CheckForTimerActivationInRange899
L__CheckForTimerActivationInRange1135:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1136
	JMP        L__CheckForTimerActivationInRange898
L__CheckForTimerActivationInRange1136:
L__CheckForTimerActivationInRange893:
;Solar_Auto_Switcher.c,1891 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1137
	JMP        L_CheckForTimerActivationInRange620
L__CheckForTimerActivationInRange1137:
;Solar_Auto_Switcher.c,1893 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,1895 :: 		}
L_CheckForTimerActivationInRange620:
;Solar_Auto_Switcher.c,1888 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
L__CheckForTimerActivationInRange900:
L__CheckForTimerActivationInRange899:
L__CheckForTimerActivationInRange898:
;Solar_Auto_Switcher.c,1923 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1138
	JMP        L__CheckForTimerActivationInRange903
L__CheckForTimerActivationInRange1138:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1139
	JMP        L__CheckForTimerActivationInRange902
L__CheckForTimerActivationInRange1139:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1140
	JMP        L__CheckForTimerActivationInRange901
L__CheckForTimerActivationInRange1140:
L__CheckForTimerActivationInRange892:
;Solar_Auto_Switcher.c,1925 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1923 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange903:
L__CheckForTimerActivationInRange902:
L__CheckForTimerActivationInRange901:
;Solar_Auto_Switcher.c,1929 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1141
	JMP        L__CheckForTimerActivationInRange906
L__CheckForTimerActivationInRange1141:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange1142
	JMP        L__CheckForTimerActivationInRange905
L__CheckForTimerActivationInRange1142:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange1143
	JMP        L__CheckForTimerActivationInRange904
L__CheckForTimerActivationInRange1143:
L__CheckForTimerActivationInRange891:
;Solar_Auto_Switcher.c,1931 :: 		if(ReadMinutes()<minutes_lcd_timer2_stop)
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange1144
	JMP        L_CheckForTimerActivationInRange627
L__CheckForTimerActivationInRange1144:
;Solar_Auto_Switcher.c,1933 :: 		Timer_2_isOn=1;
	LDI        R27, 1
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,1935 :: 		}
L_CheckForTimerActivationInRange627:
;Solar_Auto_Switcher.c,1929 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
L__CheckForTimerActivationInRange906:
L__CheckForTimerActivationInRange905:
L__CheckForTimerActivationInRange904:
;Solar_Auto_Switcher.c,1961 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Auto_Switcher.c,1964 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Auto_Switcher.c,1967 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff911
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1146
	JMP        L__TurnLoadsOffWhenGridOff910
L__TurnLoadsOffWhenGridOff1146:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1147
	JMP        L__TurnLoadsOffWhenGridOff909
L__TurnLoadsOffWhenGridOff1147:
L__TurnLoadsOffWhenGridOff908:
;Solar_Auto_Switcher.c,1969 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1970 :: 		Relay_L_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1971 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1972 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1967 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__TurnLoadsOffWhenGridOff911:
L__TurnLoadsOffWhenGridOff910:
L__TurnLoadsOffWhenGridOff909:
;Solar_Auto_Switcher.c,1975 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__TurnLoadsOffWhenGridOff914
	LDS        R16, _Timer_2_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1148
	JMP        L__TurnLoadsOffWhenGridOff913
L__TurnLoadsOffWhenGridOff1148:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff1149
	JMP        L__TurnLoadsOffWhenGridOff912
L__TurnLoadsOffWhenGridOff1149:
L__TurnLoadsOffWhenGridOff907:
;Solar_Auto_Switcher.c,1977 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Auto_Switcher.c,1978 :: 		Relay_L_Solar_2=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1979 :: 		AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,1980 :: 		LCD_Clear(2,7,16); // to clear lcd when grid is not available
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1975 :: 		if (AC_Available==1 && Timer_2_isOn==0 && RunLoadsByBass==0)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
L__TurnLoadsOffWhenGridOff914:
L__TurnLoadsOffWhenGridOff913:
L__TurnLoadsOffWhenGridOff912:
;Solar_Auto_Switcher.c,1983 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _TurnLoadsOffWhenGridOff

_CheckForVoltageProtection:

;Solar_Auto_Switcher.c,1985 :: 		CheckForVoltageProtection()
;Solar_Auto_Switcher.c,1987 :: 		if (VoltageProtectionEnable==1)  LCD_OUT(1,16,"P"); else LCD_OUT(1,16," ") ;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1151
	JMP        L_CheckForVoltageProtection634
L__CheckForVoltageProtection1151:
	LDI        R27, #lo_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_CheckForVoltageProtection635
L_CheckForVoltageProtection634:
	LDI        R27, #lo_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_CheckForVoltageProtection635:
;Solar_Auto_Switcher.c,1988 :: 		if(Exit==1 && Set==0 )
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection920
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection919
L__CheckForVoltageProtection916:
;Solar_Auto_Switcher.c,1990 :: 		delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_CheckForVoltageProtection639:
	DEC        R16
	BRNE       L_CheckForVoltageProtection639
	DEC        R17
	BRNE       L_CheckForVoltageProtection639
	DEC        R18
	BRNE       L_CheckForVoltageProtection639
	NOP
	NOP
	NOP
	NOP
;Solar_Auto_Switcher.c,1991 :: 		if(Exit==1 && Set==0 ) {
	IN         R27, PINC+0
	SBRS       R27, 0
	JMP        L__CheckForVoltageProtection918
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__CheckForVoltageProtection917
L__CheckForVoltageProtection915:
;Solar_Auto_Switcher.c,1992 :: 		if (VoltageProtectorEnableFlag==1)         // protector as default is enabled so make it not enabled
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 1
	BREQ       L__CheckForVoltageProtection1152
	JMP        L_CheckForVoltageProtection644
L__CheckForVoltageProtection1152:
;Solar_Auto_Switcher.c,1994 :: 		VoltageProtectionEnable=0;
	LDI        R27, 0
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,1995 :: 		VoltageProtectorEnableFlag=0;
	LDI        R27, 0
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,1996 :: 		EEPROM_Write(0x15,0);
	CLR        R4
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1997 :: 		}
	JMP        L_CheckForVoltageProtection645
L_CheckForVoltageProtection644:
;Solar_Auto_Switcher.c,1998 :: 		else if ( VoltageProtectorEnableFlag==0)
	LDS        R16, _VoltageProtectorEnableFlag+0
	CPI        R16, 0
	BREQ       L__CheckForVoltageProtection1153
	JMP        L_CheckForVoltageProtection646
L__CheckForVoltageProtection1153:
;Solar_Auto_Switcher.c,2000 :: 		VoltageProtectionEnable=1;
	LDI        R27, 1
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,2001 :: 		VoltageProtectorEnableFlag=1;
	LDI        R27, 1
	STS        _VoltageProtectorEnableFlag+0, R27
;Solar_Auto_Switcher.c,2002 :: 		EEPROM_Write(0x15,1);
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,2003 :: 		}
L_CheckForVoltageProtection646:
L_CheckForVoltageProtection645:
;Solar_Auto_Switcher.c,1991 :: 		if(Exit==1 && Set==0 ) {
L__CheckForVoltageProtection918:
L__CheckForVoltageProtection917:
;Solar_Auto_Switcher.c,1988 :: 		if(Exit==1 && Set==0 )
L__CheckForVoltageProtection920:
L__CheckForVoltageProtection919:
;Solar_Auto_Switcher.c,2007 :: 		}
L_end_CheckForVoltageProtection:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForVoltageProtection

_CheckForTimerActivationOutRange:

;Solar_Auto_Switcher.c,2009 :: 		CheckForTimerActivationOutRange()
;Solar_Auto_Switcher.c,2012 :: 		if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2)
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1155
	JMP        L__CheckForTimerActivationOutRange926
L__CheckForTimerActivationOutRange1155:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1156
	JMP        L__CheckForTimerActivationOutRange925
L__CheckForTimerActivationOutRange1156:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1157
	JMP        L__CheckForTimerActivationOutRange924
L__CheckForTimerActivationOutRange1157:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1158
	JMP        L__CheckForTimerActivationOutRange923
L__CheckForTimerActivationOutRange1158:
L__CheckForTimerActivationOutRange922:
;Solar_Auto_Switcher.c,2014 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Auto_Switcher.c,2012 :: 		if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2)
L__CheckForTimerActivationOutRange926:
L__CheckForTimerActivationOutRange925:
L__CheckForTimerActivationOutRange924:
L__CheckForTimerActivationOutRange923:
;Solar_Auto_Switcher.c,2017 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() >= hours_lcd_timer2_stop && ReadMinutes()>=minutes_lcd_timer2_stop)
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1159
	JMP        L__CheckForTimerActivationOutRange930
L__CheckForTimerActivationOutRange1159:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_start+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1160
	JMP        L__CheckForTimerActivationOutRange929
L__CheckForTimerActivationOutRange1160:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_timer2_stop+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1161
	JMP        L__CheckForTimerActivationOutRange928
L__CheckForTimerActivationOutRange1161:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_timer2_stop+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange1162
	JMP        L__CheckForTimerActivationOutRange927
L__CheckForTimerActivationOutRange1162:
L__CheckForTimerActivationOutRange921:
;Solar_Auto_Switcher.c,2019 :: 		Timer_2_isOn=0;
	LDI        R27, 0
	STS        _Timer_2_isOn+0, R27
;Solar_Auto_Switcher.c,2017 :: 		if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() >= hours_lcd_timer2_stop && ReadMinutes()>=minutes_lcd_timer2_stop)
L__CheckForTimerActivationOutRange930:
L__CheckForTimerActivationOutRange929:
L__CheckForTimerActivationOutRange928:
L__CheckForTimerActivationOutRange927:
;Solar_Auto_Switcher.c,2021 :: 		}
L_end_CheckForTimerActivationOutRange:
	RET
; end of _CheckForTimerActivationOutRange

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Auto_Switcher.c,2023 :: 		void main() {
;Solar_Auto_Switcher.c,2024 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Auto_Switcher.c,2025 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Auto_Switcher.c,2026 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,2027 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Auto_Switcher.c,2028 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Auto_Switcher.c,2029 :: 		ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
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
;Solar_Auto_Switcher.c,2030 :: 		ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
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
;Solar_Auto_Switcher.c,2031 :: 		ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
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
;Solar_Auto_Switcher.c,2032 :: 		ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
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
;Solar_Auto_Switcher.c,2033 :: 		ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
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
;Solar_Auto_Switcher.c,2034 :: 		ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
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
;Solar_Auto_Switcher.c,2035 :: 		while(1)
L_main653:
;Solar_Auto_Switcher.c,2037 :: 		CheckForSet();
	CALL       _CheckForSet+0
;Solar_Auto_Switcher.c,2038 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Auto_Switcher.c,2039 :: 		CheckForTimerActivationOutRange();
	CALL       _CheckForTimerActivationOutRange+0
;Solar_Auto_Switcher.c,2040 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Auto_Switcher.c,2041 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Auto_Switcher.c,2042 :: 		CheckForVoltageProtection();
	CALL       _CheckForVoltageProtection+0
;Solar_Auto_Switcher.c,2043 :: 		Screen_1();
	CALL       _Screen_1+0
;Solar_Auto_Switcher.c,2044 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Auto_Switcher.c,2045 :: 		TurnLoadsOffWhenGridOff();        // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Auto_Switcher.c,2048 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_main655:
	DEC        R16
	BRNE       L_main655
	DEC        R17
	BRNE       L_main655
	DEC        R18
	BRNE       L_main655
;Solar_Auto_Switcher.c,2049 :: 		} // end while
	JMP        L_main653
;Solar_Auto_Switcher.c,2050 :: 		}   // end main
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
