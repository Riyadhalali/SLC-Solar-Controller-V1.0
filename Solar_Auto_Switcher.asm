
_Gpio_Init:

;Solar_Auto_Switcher.c,136 :: 		void Gpio_Init()
;Solar_Auto_Switcher.c,138 :: 		DDRD.B4=1; // Relay_L_1 pin set as output
	IN         R27, DDRD+0
	SBR        R27, 16
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,139 :: 		DDRD.B5=1; // Relay_L_2 set as output
	IN         R27, DDRD+0
	SBR        R27, 32
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,140 :: 		DDRD.B6=1; // Relay_L_3 set as output
	IN         R27, DDRD+0
	SBR        R27, 64
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,141 :: 		DDRD.B7=1; // Relay_N_Solar set as output
	IN         R27, DDRD+0
	SBR        R27, 128
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,142 :: 		DDRD.B0=1; // Relay_N_Grid set as output
	IN         R27, DDRD+0
	SBR        R27, 1
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,143 :: 		DDRD.B2=0; // Set as input
	IN         R27, DDRD+0
	CBR        R27, 4
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,144 :: 		DDRD.B1=0; // decrement set as input
	IN         R27, DDRD+0
	CBR        R27, 2
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,145 :: 		DDRD.B0=0; // increment set as input
	IN         R27, DDRD+0
	CBR        R27, 1
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,146 :: 		DDRD.B3=0; // set ac_available as input
	IN         R27, DDRD+0
	CBR        R27, 8
	OUT        DDRD+0, R27
;Solar_Auto_Switcher.c,147 :: 		DDRC.B2=1; // set buzzer as output
	IN         R27, DDRC+0
	SBR        R27, 4
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,148 :: 		DDRC.B0=1; // set relay N as output
	IN         R27, DDRC+0
	SBR        R27, 1
	OUT        DDRC+0, R27
;Solar_Auto_Switcher.c,149 :: 		}
L_end_Gpio_Init:
	RET
; end of _Gpio_Init

_Write_Time:

;Solar_Auto_Switcher.c,152 :: 		void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
;Solar_Auto_Switcher.c,154 :: 		write_Ds1307(0x00,seconds);           //seconds
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
;Solar_Auto_Switcher.c,155 :: 		write_Ds1307(0x01,minutes);          // minutes
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Auto_Switcher.c,156 :: 		write_Ds1307(0x02,hours); // using the 24 hour system
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Auto_Switcher.c,157 :: 		}
L_end_Write_Time:
	POP        R3
	POP        R2
	RET
; end of _Write_Time

_Config:

;Solar_Auto_Switcher.c,159 :: 		void Config()
;Solar_Auto_Switcher.c,161 :: 		GPIO_Init();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _Gpio_Init+0
;Solar_Auto_Switcher.c,162 :: 		LCD_Init();
	CALL       _Lcd_Init+0
;Solar_Auto_Switcher.c,163 :: 		LCD_CMD(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,164 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,165 :: 		LCD_OUT(1,1,"Starting ... ");
	LDI        R27, #lo_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,166 :: 		Delay_ms(2000);
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
;Solar_Auto_Switcher.c,168 :: 		}
L_end_Config:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Config

_Config_Interrupts:

;Solar_Auto_Switcher.c,170 :: 		void Config_Interrupts()
;Solar_Auto_Switcher.c,172 :: 		ISC01_bit=0;   // Config The rising edge of INT0 generates an interrupt request.
	LDS        R27, ISC01_bit+0
	CBR        R27, BitMask(ISC01_bit+0)
	STS        ISC01_bit+0, R27
;Solar_Auto_Switcher.c,173 :: 		ISC00_bit=0;
	LDS        R27, ISC00_bit+0
	CBR        R27, BitMask(ISC00_bit+0)
	STS        ISC00_bit+0, R27
;Solar_Auto_Switcher.c,174 :: 		INT0_bit=1;
	IN         R27, INT0_bit+0
	SBR        R27, BitMask(INT0_bit+0)
	OUT        INT0_bit+0, R27
;Solar_Auto_Switcher.c,175 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,176 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_LCD_Clear:

;Solar_Auto_Switcher.c,178 :: 		void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
;Solar_Auto_Switcher.c,181 :: 		for(Column=Start; Column<=End; Column++)
; Column start address is: 17 (R17)
	MOV        R17, R3
; Column end address is: 17 (R17)
L_LCD_Clear2:
; Column start address is: 17 (R17)
	CP         R4, R17
	BRSH       L__LCD_Clear650
	JMP        L_LCD_Clear3
L__LCD_Clear650:
;Solar_Auto_Switcher.c,183 :: 		Lcd_Chr(Row,Column,32);
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
;Solar_Auto_Switcher.c,181 :: 		for(Column=Start; Column<=End; Column++)
	MOV        R16, R17
	SUBI       R16, 255
	MOV        R17, R16
;Solar_Auto_Switcher.c,184 :: 		}
; Column end address is: 17 (R17)
	JMP        L_LCD_Clear2
L_LCD_Clear3:
;Solar_Auto_Switcher.c,185 :: 		}
L_end_LCD_Clear:
	RET
; end of _LCD_Clear

_EEPROM_Load:

;Solar_Auto_Switcher.c,187 :: 		void EEPROM_Load()
;Solar_Auto_Switcher.c,190 :: 		hours_lcd_1=EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,191 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,192 :: 		hours_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,193 :: 		minutes_lcd_2=EEPROM_Read(0x04);
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,195 :: 		hours_lcd_timer2_start=EEPROM_Read(0x18);
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,196 :: 		minutes_lcd_timer2_start=EEPROM_Read(0x19);
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,197 :: 		hours_lcd_timer2_stop=EEPROM_Read(0x20);
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,198 :: 		minutes_lcd_timer2_stop=EEPROM_Read(0x21);
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,200 :: 		hours_lcd_timer3_start=EEPROM_Read(0x22);
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,201 :: 		minutes_lcd_timer3_start=EEPROM_Read(0x23);
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,202 :: 		hours_lcd_timer3_stop=EEPROM_Read(0x24);
	LDI        R27, 36
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,203 :: 		minutes_lcd_timer3_stop=EEPROM_Read(0x25);
	LDI        R27, 37
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,205 :: 		ByPassState=EEPROM_Read(0x06); // read bypass system if it is disabled or enabled
	LDI        R27, 6
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _ByPassState+0, R16
;Solar_Auto_Switcher.c,206 :: 		Timer_Enable=EEPROM_Read(0x011);
	LDI        R27, 17
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Timer_Enable+0, R16
;Solar_Auto_Switcher.c,207 :: 		High_Voltage=EEPROM_Read(0x12); // load high voltage
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _High_Voltage+0, R16
	LDI        R27, 0
	STS        _High_Voltage+1, R27
;Solar_Auto_Switcher.c,208 :: 		Low_Voltage=EEPROM_Read(0x13); // load low voltage
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Low_Voltage+0, R16
	LDI        R27, 0
	STS        _Low_Voltage+1, R27
;Solar_Auto_Switcher.c,210 :: 		VoltageProtectionEnable=EEPROM_Read(0x15);
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _VoltageProtectionEnable+0, R16
;Solar_Auto_Switcher.c,211 :: 		Error_Voltage=EEPROM_Read(0x16);
	LDI        R27, 22
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Error_Voltage+0, R16
;Solar_Auto_Switcher.c,212 :: 		Adjusted_Voltage=EEPROM_Read(0x17);// read saved error voltage
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Adjusted_Voltage+0, R16
;Solar_Auto_Switcher.c,214 :: 		if (hours_lcd_1== 0xff ) EEPROM_Write(0x00,0x0A); // write 10 to eeprom
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load652
	JMP        L_EEPROM_Load5
L__EEPROM_Load652:
	LDI        R27, 10
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
L_EEPROM_Load5:
;Solar_Auto_Switcher.c,215 :: 		if(minutes_lcd_1==0xFF) EEPROM_Write(0x01,0x00);   //write 00
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load653
	JMP        L_EEPROM_Load6
L__EEPROM_Load653:
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load6:
;Solar_Auto_Switcher.c,216 :: 		if(hours_lcd_2==0xFF) EEPROM_Write(0x03,0x0E);
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load654
	JMP        L_EEPROM_Load7
L__EEPROM_Load654:
	LDI        R27, 14
	MOV        R4, R27
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load7:
;Solar_Auto_Switcher.c,217 :: 		if(minutes_lcd_2==0xFF) EEPROM_Write(0x04,0x00);
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load655
	JMP        L_EEPROM_Load8
L__EEPROM_Load655:
	CLR        R4
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load8:
;Solar_Auto_Switcher.c,218 :: 		if(ByPassState==0xFF) EEPROM_Write(0x06,0x01) ; // write by pass 1 to enable as default
	LDS        R16, _ByPassState+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load656
	JMP        L_EEPROM_Load9
L__EEPROM_Load656:
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 6
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load9:
;Solar_Auto_Switcher.c,219 :: 		if(Timer_Enable==0xFF) EEPROM_Write(0x11,0x01);
	LDS        R16, _Timer_Enable+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load657
	JMP        L_EEPROM_Load10
L__EEPROM_Load657:
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 17
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load10:
;Solar_Auto_Switcher.c,220 :: 		if(High_Voltage==0xFF) EEPROM_Write(0x12,0xF5); // 245 high voltage
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CPI        R17, 0
	BRNE       L__EEPROM_Load658
	CPI        R16, 255
L__EEPROM_Load658:
	BREQ       L__EEPROM_Load659
	JMP        L_EEPROM_Load11
L__EEPROM_Load659:
	LDI        R27, 245
	MOV        R4, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load11:
;Solar_Auto_Switcher.c,221 :: 		if(Low_Voltage==0xFF) EEPROM_Write(0x13,0xAA); // 170 Low voltage
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CPI        R17, 0
	BRNE       L__EEPROM_Load660
	CPI        R16, 255
L__EEPROM_Load660:
	BREQ       L__EEPROM_Load661
	JMP        L_EEPROM_Load12
L__EEPROM_Load661:
	LDI        R27, 170
	MOV        R4, R27
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load12:
;Solar_Auto_Switcher.c,223 :: 		if(VoltageProtectionEnable==0xFF) EEPROM_Write(0x15,0x01); // Enable voltage Protection in default mode
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load662
	JMP        L_EEPROM_Load13
L__EEPROM_Load662:
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load13:
;Solar_Auto_Switcher.c,224 :: 		if(Error_Voltage==0xFF) EEPROM_Write(0x16,0x00);
	LDS        R16, _Error_Voltage+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load663
	JMP        L_EEPROM_Load14
L__EEPROM_Load663:
	CLR        R4
	LDI        R27, 22
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load14:
;Solar_Auto_Switcher.c,225 :: 		if(Adjusted_Voltage==0xFF) EEPROM_Write(0x17,0x00);
	LDS        R16, _Adjusted_Voltage+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load664
	JMP        L_EEPROM_Load15
L__EEPROM_Load664:
	CLR        R4
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load15:
;Solar_Auto_Switcher.c,226 :: 		if(hours_lcd_timer2_start==0xFF) EEPROM_Write(0x18,0x0A);
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load665
	JMP        L_EEPROM_Load16
L__EEPROM_Load665:
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load16:
;Solar_Auto_Switcher.c,227 :: 		if(minutes_lcd_timer2_start==0xFF) EEPROM_Read(0x00);
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load666
	JMP        L_EEPROM_Load17
L__EEPROM_Load666:
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
L_EEPROM_Load17:
;Solar_Auto_Switcher.c,228 :: 		if(hours_lcd_timer2_stop==0xFF) EEPROM_Write(0x20,0x0E);
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load667
	JMP        L_EEPROM_Load18
L__EEPROM_Load667:
	LDI        R27, 14
	MOV        R4, R27
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load18:
;Solar_Auto_Switcher.c,229 :: 		if(minutes_lcd_timer2_stop==0xFF) EEPROM_Write(0x21,0x00);
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load668
	JMP        L_EEPROM_Load19
L__EEPROM_Load668:
	CLR        R4
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load19:
;Solar_Auto_Switcher.c,230 :: 		if(hours_lcd_timer3_start==0xFF) EEPROM_Write(0x22,0x0A);
	LDS        R16, _hours_lcd_timer3_start+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load669
	JMP        L_EEPROM_Load20
L__EEPROM_Load669:
	LDI        R27, 10
	MOV        R4, R27
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load20:
;Solar_Auto_Switcher.c,231 :: 		if(minutes_lcd_timer3_start==0xFF) EEPROM_Write(0x23,0X00);
	LDS        R16, _minutes_lcd_timer3_start+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load670
	JMP        L_EEPROM_Load21
L__EEPROM_Load670:
	CLR        R4
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load21:
;Solar_Auto_Switcher.c,232 :: 		if(hours_lcd_timer3_stop==0xFF) EEPROM_Write(0x24,0x0E);
	LDS        R16, _hours_lcd_timer3_stop+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load671
	JMP        L_EEPROM_Load22
L__EEPROM_Load671:
	LDI        R27, 14
	MOV        R4, R27
	LDI        R27, 36
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load22:
;Solar_Auto_Switcher.c,233 :: 		if(minutes_lcd_timer3_stop==0xFF) EEPROM_Write(0x25,0x00);
	LDS        R16, _minutes_lcd_timer3_stop+0
	CPI        R16, 255
	BREQ       L__EEPROM_Load672
	JMP        L_EEPROM_Load23
L__EEPROM_Load672:
	CLR        R4
	LDI        R27, 37
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
L_EEPROM_Load23:
;Solar_Auto_Switcher.c,235 :: 		hours_lcd_1=EEPROM_Read(0x00);
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,236 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,238 :: 		hours_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,239 :: 		minutes_lcd_2=EEPROM_Read(0x04);
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,241 :: 		ByPassState=EEPROM_Read(0x06); // read bypass system if it is disabled or enabled
	LDI        R27, 6
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _ByPassState+0, R16
;Solar_Auto_Switcher.c,242 :: 		Timer_Enable=EEPROM_Read(0x011);
	LDI        R27, 17
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Timer_Enable+0, R16
;Solar_Auto_Switcher.c,243 :: 		High_Voltage=EEPROM_Read(0x12); // load high voltage
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _High_Voltage+0, R16
	LDI        R27, 0
	STS        _High_Voltage+1, R27
;Solar_Auto_Switcher.c,244 :: 		Low_Voltage=EEPROM_Read(0x13); // load low voltage
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
;Solar_Auto_Switcher.c,247 :: 		Error_Voltage=EEPROM_Read(0x16);
	LDI        R27, 22
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Error_Voltage+0, R16
;Solar_Auto_Switcher.c,248 :: 		Adjusted_Voltage=EEPROM_Read(0x17);
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Adjusted_Voltage+0, R16
;Solar_Auto_Switcher.c,249 :: 		hours_lcd_timer2_start=EEPROM_Read(0x18);
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,250 :: 		minutes_lcd_timer2_start=EEPROM_Read(0x19);
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,251 :: 		hours_lcd_timer2_stop=EEPROM_Read(0x20);
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,252 :: 		minutes_lcd_timer2_stop=EEPROM_Read(0x21);
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,253 :: 		hours_lcd_timer3_start=EEPROM_Read(0x22);
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,254 :: 		minutes_lcd_timer3_start=EEPROM_Read(0x23);
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,255 :: 		hours_lcd_timer3_stop=EEPROM_Read(0x24);
	LDI        R27, 36
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,256 :: 		minutes_lcd_timer3_stop=EEPROM_Read(0x25);
	LDI        R27, 37
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,257 :: 		}
L_end_EEPROM_Load:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _EEPROM_Load

_StoreBytesIntoEEprom:

;Solar_Auto_Switcher.c,260 :: 		void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,263 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_StoreBytesIntoEEprom24:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__StoreBytesIntoEEprom674
	JMP        L_StoreBytesIntoEEprom25
L__StoreBytesIntoEEprom674:
;Solar_Auto_Switcher.c,265 :: 		EEprom_Write(address+j,*(ptr+j));
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
;Solar_Auto_Switcher.c,266 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_StoreBytesIntoEEprom27:
	DEC        R16
	BRNE       L_StoreBytesIntoEEprom27
	DEC        R17
	BRNE       L_StoreBytesIntoEEprom27
	DEC        R18
	BRNE       L_StoreBytesIntoEEprom27
;Solar_Auto_Switcher.c,263 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,267 :: 		};
; j end address is: 19 (R19)
	JMP        L_StoreBytesIntoEEprom24
L_StoreBytesIntoEEprom25:
;Solar_Auto_Switcher.c,268 :: 		}
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

;Solar_Auto_Switcher.c,271 :: 		void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Auto_Switcher.c,274 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_ReadBytesFromEEprom29:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__ReadBytesFromEEprom676
	JMP        L_ReadBytesFromEEprom30
L__ReadBytesFromEEprom676:
;Solar_Auto_Switcher.c,276 :: 		*(ptr+j)=EEPROM_Read(address+j);
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
;Solar_Auto_Switcher.c,277 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_ReadBytesFromEEprom32:
	DEC        R16
	BRNE       L_ReadBytesFromEEprom32
	DEC        R17
	BRNE       L_ReadBytesFromEEprom32
	DEC        R18
	BRNE       L_ReadBytesFromEEprom32
;Solar_Auto_Switcher.c,274 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,278 :: 		}
; j end address is: 19 (R19)
	JMP        L_ReadBytesFromEEprom29
L_ReadBytesFromEEprom30:
;Solar_Auto_Switcher.c,279 :: 		}
L_end_ReadBytesFromEEprom:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ReadBytesFromEEprom

_Check_Timers:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Auto_Switcher.c,282 :: 		void Check_Timers()
;Solar_Auto_Switcher.c,288 :: 		matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R4, _hours_lcd_1+0
	LDS        R3, _minutes_lcd_1+0
	LDS        R2, _seconds_lcd_1+0
	CALL       _CheckTimeOccuredOn+0
	STD        Y+0, R16
;Solar_Auto_Switcher.c,289 :: 		matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
	LDS        R4, _hours_lcd_2+0
	LDS        R3, _minutes_lcd_2+0
	LDS        R2, _seconds_lcd_2+0
	CALL       _CheckTimeOccuredOff+0
	STD        Y+1, R16
;Solar_Auto_Switcher.c,290 :: 		matched_timer_2_start=CheckTimeOccuredOn(0x00,minutes_lcd_timer2_start,hours_lcd_timer2_start);
	LDS        R4, _hours_lcd_timer2_start+0
	LDS        R3, _minutes_lcd_timer2_start+0
	CLR        R2
	CALL       _CheckTimeOccuredOn+0
	STD        Y+2, R16
;Solar_Auto_Switcher.c,291 :: 		matched_timer_2_stop=CheckTimeOccuredOff(0x00,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
	LDS        R4, _hours_lcd_timer2_stop+0
	LDS        R3, _minutes_lcd_timer2_stop+0
	CLR        R2
	CALL       _CheckTimeOccuredOff+0
	STD        Y+3, R16
;Solar_Auto_Switcher.c,292 :: 		matched_timer_3_start=CheckTimeOccuredOn(0x00,minutes_lcd_timer3_start,hours_lcd_timer3_start);
	LDS        R4, _hours_lcd_timer3_start+0
	LDS        R3, _minutes_lcd_timer3_start+0
	CLR        R2
	CALL       _CheckTimeOccuredOn+0
	STD        Y+4, R16
;Solar_Auto_Switcher.c,293 :: 		matched_timer_3_stop=CheckTimeOccuredOff(0x00,minutes_lcd_timer3_stop,hours_lcd_timer3_stop);
	LDS        R4, _hours_lcd_timer3_stop+0
	LDS        R3, _minutes_lcd_timer3_stop+0
	CLR        R2
	CALL       _CheckTimeOccuredOff+0
	STD        Y+5, R16
;Solar_Auto_Switcher.c,297 :: 		if (AC_Available==1 && Timer_Enable==1   )        // AC GRID is not available and timer is enabled
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers508
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers678
	JMP        L__Check_Timers507
L__Check_Timers678:
L__Check_Timers506:
;Solar_Auto_Switcher.c,300 :: 		if (matched_timer_1_start==1)
	LDD        R16, Y+0
	CPI        R16, 1
	BREQ       L__Check_Timers679
	JMP        L_Check_Timers37
L__Check_Timers679:
;Solar_Auto_Switcher.c,303 :: 		Relay_L_1=1; // relay on to solar
	IN         R27, PORTD+0
	SBR        R27, 16
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,304 :: 		LCD_OUT(1,16,"1");
	LDI        R27, #lo_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,305 :: 		}
L_Check_Timers37:
;Solar_Auto_Switcher.c,307 :: 		if (matched_timer_1_stop==1)
	LDD        R16, Y+1
	CPI        R16, 1
	BREQ       L__Check_Timers680
	JMP        L_Check_Timers38
L__Check_Timers680:
;Solar_Auto_Switcher.c,310 :: 		Relay_L_1=0; // relay off to grid
	IN         R27, PORTD+0
	CBR        R27, 16
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,311 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,312 :: 		}
L_Check_Timers38:
;Solar_Auto_Switcher.c,297 :: 		if (AC_Available==1 && Timer_Enable==1   )        // AC GRID is not available and timer is enabled
L__Check_Timers508:
L__Check_Timers507:
;Solar_Auto_Switcher.c,316 :: 		if (AC_Available==1 && Timer_2_Enable==1   )        // AC GRID is not available and timer is enabled
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers510
	LDS        R16, _Timer_2_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers681
	JMP        L__Check_Timers509
L__Check_Timers681:
L__Check_Timers505:
;Solar_Auto_Switcher.c,319 :: 		if (matched_timer_2_start==1)
	LDD        R16, Y+2
	CPI        R16, 1
	BREQ       L__Check_Timers682
	JMP        L_Check_Timers42
L__Check_Timers682:
;Solar_Auto_Switcher.c,322 :: 		Relay_L_2=1; // relay on to solar
	IN         R27, PORTD+0
	SBR        R27, 32
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,323 :: 		LCD_OUT(1,16,"2");
	LDI        R27, #lo_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,324 :: 		}
L_Check_Timers42:
;Solar_Auto_Switcher.c,326 :: 		if (matched_timer_2_stop==1)
	LDD        R16, Y+3
	CPI        R16, 1
	BREQ       L__Check_Timers683
	JMP        L_Check_Timers43
L__Check_Timers683:
;Solar_Auto_Switcher.c,329 :: 		Relay_L_2=0; // relay off to grid
	IN         R27, PORTD+0
	CBR        R27, 32
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,330 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,331 :: 		}
L_Check_Timers43:
;Solar_Auto_Switcher.c,316 :: 		if (AC_Available==1 && Timer_2_Enable==1   )        // AC GRID is not available and timer is enabled
L__Check_Timers510:
L__Check_Timers509:
;Solar_Auto_Switcher.c,334 :: 		if (AC_Available==1 && Timer_3_Enable==1   )        // AC GRID is not available and timer is enabled
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers512
	LDS        R16, _Timer_3_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers684
	JMP        L__Check_Timers511
L__Check_Timers684:
L__Check_Timers504:
;Solar_Auto_Switcher.c,337 :: 		if (matched_timer_3_start==1)
	LDD        R16, Y+4
	CPI        R16, 1
	BREQ       L__Check_Timers685
	JMP        L_Check_Timers47
L__Check_Timers685:
;Solar_Auto_Switcher.c,340 :: 		Relay_L_3=1; // relay on to solar
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,341 :: 		LCD_OUT(1,16,"3");
	LDI        R27, #lo_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,342 :: 		}
L_Check_Timers47:
;Solar_Auto_Switcher.c,344 :: 		if (matched_timer_3_stop==1)
	LDD        R16, Y+5
	CPI        R16, 1
	BREQ       L__Check_Timers686
	JMP        L_Check_Timers48
L__Check_Timers686:
;Solar_Auto_Switcher.c,347 :: 		Relay_L_3=0; // relay off to grid
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,348 :: 		LCD_OUT(1,16," ");
	LDI        R27, #lo_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,349 :: 		}
L_Check_Timers48:
;Solar_Auto_Switcher.c,334 :: 		if (AC_Available==1 && Timer_3_Enable==1   )        // AC GRID is not available and timer is enabled
L__Check_Timers512:
L__Check_Timers511:
;Solar_Auto_Switcher.c,352 :: 		if((matched_timer_1_start==1 || matched_timer_2_start==1 || matched_timer_3_start==1) && (AC_Available==1 && Timer_Enable==1) )
	LDD        R16, Y+0
	CPI        R16, 1
	BRNE       L__Check_Timers687
	JMP        L__Check_Timers515
L__Check_Timers687:
	LDD        R16, Y+2
	CPI        R16, 1
	BRNE       L__Check_Timers688
	JMP        L__Check_Timers514
L__Check_Timers688:
	LDD        R16, Y+4
	CPI        R16, 1
	BRNE       L__Check_Timers689
	JMP        L__Check_Timers513
L__Check_Timers689:
	JMP        L_Check_Timers55
L__Check_Timers515:
L__Check_Timers514:
L__Check_Timers513:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers517
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers690
	JMP        L__Check_Timers516
L__Check_Timers690:
L__Check_Timers502:
L__Check_Timers501:
;Solar_Auto_Switcher.c,355 :: 		Relay_N_Solar=1;   // turm n solar on
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,356 :: 		}
L_Check_Timers55:
;Solar_Auto_Switcher.c,352 :: 		if((matched_timer_1_start==1 || matched_timer_2_start==1 || matched_timer_3_start==1) && (AC_Available==1 && Timer_Enable==1) )
L__Check_Timers517:
L__Check_Timers516:
;Solar_Auto_Switcher.c,358 :: 		if ((Relay_L_1==0 && Relay_L_2==0 && Relay_L_3==0 ) && (AC_Available==1 && Timer_Enable==1) )
	IN         R27, PORTD+0
	SBRC       R27, 4
	JMP        L__Check_Timers522
	IN         R27, PORTD+0
	SBRC       R27, 5
	JMP        L__Check_Timers521
	IN         R27, PORTD+0
	SBRC       R27, 6
	JMP        L__Check_Timers520
L__Check_Timers500:
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L__Check_Timers519
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers691
	JMP        L__Check_Timers518
L__Check_Timers691:
L__Check_Timers499:
L__Check_Timers498:
;Solar_Auto_Switcher.c,360 :: 		Relay_N_Solar=0;
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,358 :: 		if ((Relay_L_1==0 && Relay_L_2==0 && Relay_L_3==0 ) && (AC_Available==1 && Timer_Enable==1) )
L__Check_Timers522:
L__Check_Timers521:
L__Check_Timers520:
L__Check_Timers519:
L__Check_Timers518:
;Solar_Auto_Switcher.c,366 :: 		if(VoltageProtectionEnable==1)  // do not enter the bypass if the voltage is not good because it will be already switched to solar
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__Check_Timers692
	JMP        L_Check_Timers63
L__Check_Timers692:
;Solar_Auto_Switcher.c,368 :: 		if(VoltageProtectorGood==1)
	LDS        R16, _VoltageProtectorGood+0
	CPI        R16, 1
	BREQ       L__Check_Timers693
	JMP        L_Check_Timers64
L__Check_Timers693:
;Solar_Auto_Switcher.c,370 :: 		if (AC_Available==0 && ByPassState==0 )       //bypass enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers524
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers694
	JMP        L__Check_Timers523
L__Check_Timers694:
L__Check_Timers497:
;Solar_Auto_Switcher.c,372 :: 		Relay_L_1=0; // switch to grid
	IN         R27, PORTD+0
	CBR        R27, 16
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,373 :: 		Relay_L_2=0; // switch to grid
	IN         R27, PORTD+0
	CBR        R27, 32
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,374 :: 		Relay_L_3=0 ; // switch to grid
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,375 :: 		Relay_N_Solar=0;  // make sure all n is offf
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,376 :: 		Relay_N_Grid=1;    // make sure all n is on and make sure the n_grid is the output
	IN         R27, PORTC+0
	SBR        R27, 1
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,377 :: 		LCD_OUT(2,16,"G");
	LDI        R27, #lo_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr8_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,378 :: 		ToggleBuzzer();
	CALL       _ToggleBuzzer+0
;Solar_Auto_Switcher.c,370 :: 		if (AC_Available==0 && ByPassState==0 )       //bypass enabled
L__Check_Timers524:
L__Check_Timers523:
;Solar_Auto_Switcher.c,380 :: 		if(AC_Available==0 && ByPassState==1 )     //bypass not enabled
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers526
	LDS        R16, _ByPassState+0
	CPI        R16, 1
	BREQ       L__Check_Timers695
	JMP        L__Check_Timers525
L__Check_Timers695:
L__Check_Timers496:
;Solar_Auto_Switcher.c,382 :: 		Relay_L_1=1;   // switch to solar
	IN         R27, PORTD+0
	SBR        R27, 16
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,383 :: 		Relay_L_2=1;   // switch to solar
	IN         R27, PORTD+0
	SBR        R27, 32
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,384 :: 		Relay_L_3=1 ; // switch to solar
	IN         R27, PORTD+0
	SBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,385 :: 		Relay_N_Grid=0;    // make sure all n is off
	IN         R27, PORTC+0
	CBR        R27, 1
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,386 :: 		Relay_N_Solar=1;    // make sure all n is on and make sure the n_solar  is the output
	IN         R27, PORTD+0
	SBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,387 :: 		LCD_OUT(2,15,"~G");
	LDI        R27, #lo_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr9_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,380 :: 		if(AC_Available==0 && ByPassState==1 )     //bypass not enabled
L__Check_Timers526:
L__Check_Timers525:
;Solar_Auto_Switcher.c,389 :: 		}   //end if voltageProtectorgood
L_Check_Timers64:
;Solar_Auto_Switcher.c,390 :: 		} // end if voltage protection is enabled
L_Check_Timers63:
;Solar_Auto_Switcher.c,393 :: 		if (VoltageProtectionEnable==0)
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__Check_Timers696
	JMP        L_Check_Timers71
L__Check_Timers696:
;Solar_Auto_Switcher.c,395 :: 		if (AC_Available==0 && ByPassState==0 )
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__Check_Timers528
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__Check_Timers697
	JMP        L__Check_Timers527
L__Check_Timers697:
L__Check_Timers495:
;Solar_Auto_Switcher.c,397 :: 		Relay_L_1=0; // switch to grid
	IN         R27, PORTD+0
	CBR        R27, 16
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,398 :: 		Relay_L_2=0 ;
	IN         R27, PORTD+0
	CBR        R27, 32
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,399 :: 		Relay_L_3=0;
	IN         R27, PORTD+0
	CBR        R27, 64
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,400 :: 		Relay_N_Solar=0;  // make sure all n is off
	IN         R27, PORTD+0
	CBR        R27, 128
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,401 :: 		Relay_N_Grid=1;    // make sure all n is on and make sure the n_grid  is the output
	IN         R27, PORTC+0
	SBR        R27, 1
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,402 :: 		LCD_OUT(2,16,"G");
	LDI        R27, #lo_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr10_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 16
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,395 :: 		if (AC_Available==0 && ByPassState==0 )
L__Check_Timers528:
L__Check_Timers527:
;Solar_Auto_Switcher.c,404 :: 		} // end voltage protection enable
L_Check_Timers71:
;Solar_Auto_Switcher.c,406 :: 		if(AC_Available==1)
	IN         R27, PIND+0
	SBRS       R27, 3
	JMP        L_Check_Timers75
;Solar_Auto_Switcher.c,408 :: 		AcBuzzerActiveTimes=0; // make buzzer variable zero to get activated once again
	LDI        R27, 0
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,409 :: 		LCD_OUT(2,15,"  "); // clear lcd
	LDI        R27, #lo_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr11_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,410 :: 		}
L_Check_Timers75:
;Solar_Auto_Switcher.c,411 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _Check_Timers

_GetVoltageNow:

;Solar_Auto_Switcher.c,414 :: 		void GetVoltageNow()
;Solar_Auto_Switcher.c,416 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,417 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,418 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,419 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,420 :: 		}
L_end_GetVoltageNow:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _GetVoltageNow

_ToggleBuzzer:

;Solar_Auto_Switcher.c,422 :: 		void ToggleBuzzer()
;Solar_Auto_Switcher.c,424 :: 		if (AcBuzzerActiveTimes==0)
	LDS        R16, _AcBuzzerActiveTimes+0
	CPI        R16, 0
	BREQ       L__ToggleBuzzer700
	JMP        L_ToggleBuzzer76
L__ToggleBuzzer700:
;Solar_Auto_Switcher.c,426 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,427 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_ToggleBuzzer77:
	DEC        R16
	BRNE       L_ToggleBuzzer77
	DEC        R17
	BRNE       L_ToggleBuzzer77
	DEC        R18
	BRNE       L_ToggleBuzzer77
;Solar_Auto_Switcher.c,428 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,429 :: 		AcBuzzerActiveTimes =1 ;
	LDI        R27, 1
	STS        _AcBuzzerActiveTimes+0, R27
;Solar_Auto_Switcher.c,430 :: 		}
L_ToggleBuzzer76:
;Solar_Auto_Switcher.c,431 :: 		}
L_end_ToggleBuzzer:
	RET
; end of _ToggleBuzzer

_Interrupt_Routine:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Auto_Switcher.c,433 :: 		void Interrupt_Routine () iv IVT_ADDR_INT0
;Solar_Auto_Switcher.c,436 :: 		Delay_ms(100);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Interrupt_Routine79:
	DEC        R16
	BRNE       L_Interrupt_Routine79
	DEC        R17
	BRNE       L_Interrupt_Routine79
	DEC        R18
	BRNE       L_Interrupt_Routine79
;Solar_Auto_Switcher.c,437 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,438 :: 		GetVoltageNow();    //Read voltage at this time without error value
	CALL       _GetVoltageNow+0
;Solar_Auto_Switcher.c,439 :: 		Saved_Voltage=v;            //take snapshot of the voltage in the time the user saved it
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	STS        _Saved_Voltage+0, R16
;Solar_Auto_Switcher.c,440 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Interrupt_Routine81
;Solar_Auto_Switcher.c,441 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
L_Interrupt_Routine81:
;Solar_Auto_Switcher.c,442 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,443 :: 		INTF0_bit=1;     //clear  flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,444 :: 		}
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

;Solar_Auto_Switcher.c,447 :: 		void SetUpProgram()
;Solar_Auto_Switcher.c,449 :: 		Delay_ms(100);
	PUSH       R2
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetUpProgram82:
	DEC        R16
	BRNE       L_SetUpProgram82
	DEC        R17
	BRNE       L_SetUpProgram82
	DEC        R18
	BRNE       L_SetUpProgram82
;Solar_Auto_Switcher.c,450 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,452 :: 		TimerDelay();
	CALL       _TimerDelay+0
;Solar_Auto_Switcher.c,453 :: 		}
L_end_SetUpProgram:
	POP        R2
	RET
; end of _SetUpProgram

_Timer_Delay_Config:

;Solar_Auto_Switcher.c,455 :: 		void Timer_Delay_Config()
;Solar_Auto_Switcher.c,457 :: 		WGM10_bit=0;
	LDS        R27, WGM10_bit+0
	CBR        R27, BitMask(WGM10_bit+0)
	STS        WGM10_bit+0, R27
;Solar_Auto_Switcher.c,458 :: 		WGM11_bit=0;
	LDS        R27, WGM11_bit+0
	CBR        R27, BitMask(WGM11_bit+0)
	STS        WGM11_bit+0, R27
;Solar_Auto_Switcher.c,459 :: 		WGM12_bit=1;
	LDS        R27, WGM12_bit+0
	SBR        R27, BitMask(WGM12_bit+0)
	STS        WGM12_bit+0, R27
;Solar_Auto_Switcher.c,460 :: 		WGM13_bit=0;
	LDS        R27, WGM13_bit+0
	CBR        R27, BitMask(WGM13_bit+0)
	STS        WGM13_bit+0, R27
;Solar_Auto_Switcher.c,461 :: 		CS10_bit=1;
	LDS        R27, CS10_bit+0
	SBR        R27, BitMask(CS10_bit+0)
	STS        CS10_bit+0, R27
;Solar_Auto_Switcher.c,462 :: 		CS11_bit=0;
	LDS        R27, CS11_bit+0
	CBR        R27, BitMask(CS11_bit+0)
	STS        CS11_bit+0, R27
;Solar_Auto_Switcher.c,463 :: 		CS12_bit=1;
	LDS        R27, CS12_bit+0
	SBR        R27, BitMask(CS12_bit+0)
	STS        CS12_bit+0, R27
;Solar_Auto_Switcher.c,464 :: 		OCIE1A_bit=1;
	LDS        R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	STS        OCIE1A_bit+0, R27
;Solar_Auto_Switcher.c,465 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Auto_Switcher.c,466 :: 		OCR1AL=0xFF;   // 500ms
	LDI        R27, 255
	STS        OCR1AL+0, R27
;Solar_Auto_Switcher.c,467 :: 		OCR1AH=0xFF;   // 500 ms
	LDI        R27, 255
	STS        OCR1AH+0, R27
;Solar_Auto_Switcher.c,468 :: 		}
L_end_Timer_Delay_Config:
	RET
; end of _Timer_Delay_Config

_TimerDelay:

;Solar_Auto_Switcher.c,471 :: 		void TimerDelay()
;Solar_Auto_Switcher.c,473 :: 		INTF0_bit=1;     //clear  flag to reset the interrupt and read interrupt state again
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Auto_Switcher.c,474 :: 		if (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_TimerDelay84
;Solar_Auto_Switcher.c,476 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,477 :: 		LCD_OUT(1,1,"Setup Program");
	LDI        R27, #lo_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr12_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,478 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_TimerDelay85:
	DEC        R16
	BRNE       L_TimerDelay85
	DEC        R17
	BRNE       L_TimerDelay85
	DEC        R18
	BRNE       L_TimerDelay85
;Solar_Auto_Switcher.c,481 :: 		while (Set==1)
L_TimerDelay87:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_TimerDelay88
;Solar_Auto_Switcher.c,484 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Auto_Switcher.c,485 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Auto_Switcher.c,486 :: 		SetTimerOn_2();
	CALL       _SetTimerOn_2+0
;Solar_Auto_Switcher.c,487 :: 		SetTimerOff_2();
	CALL       _SetTimerOff_2+0
;Solar_Auto_Switcher.c,488 :: 		SetTimerOn_3();
	CALL       _SetTimerOn_3+0
;Solar_Auto_Switcher.c,489 :: 		SetTimerOff_3();
	CALL       _SetTimerOff_3+0
;Solar_Auto_Switcher.c,490 :: 		SetDS1307Hours_Program();    // program 10
	CALL       _SetDS1307Hours_Program+0
;Solar_Auto_Switcher.c,491 :: 		SetDS1307Minutes_Program(); // program 11
	CALL       _SetDS1307Minutes_Program+0
;Solar_Auto_Switcher.c,492 :: 		SetDS1307Seconds_Program(); // program 12
	CALL       _SetDS1307Seconds_Program+0
;Solar_Auto_Switcher.c,493 :: 		AC_Available_ByPass_System(); // program 13 by pass grid system
	CALL       _AC_Available_ByPass_System+0
;Solar_Auto_Switcher.c,494 :: 		SetLowBatteryVoltage();// program 14 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Auto_Switcher.c,495 :: 		SetTimer(); // program 15 to enable timer or disable
	CALL       _SetTimer+0
;Solar_Auto_Switcher.c,496 :: 		SetHighVoltage(); // program 16 to set high voltage
	CALL       _SetHighVoltage+0
;Solar_Auto_Switcher.c,497 :: 		SetLowVoltage();   // program 17 to set low voltage
	CALL       _SetLowVoltage+0
;Solar_Auto_Switcher.c,499 :: 		EnableVoltageGuard(); // program 19
	CALL       _EnableVoltageGuard+0
;Solar_Auto_Switcher.c,501 :: 		} // end while
	JMP        L_TimerDelay87
L_TimerDelay88:
;Solar_Auto_Switcher.c,502 :: 		}    // end main if
	JMP        L_TimerDelay89
L_TimerDelay84:
;Solar_Auto_Switcher.c,508 :: 		CS10_bit=0;
	LDS        R27, CS10_bit+0
	CBR        R27, BitMask(CS10_bit+0)
	STS        CS10_bit+0, R27
;Solar_Auto_Switcher.c,509 :: 		CS11_bit=0;
	LDS        R27, CS11_bit+0
	CBR        R27, BitMask(CS11_bit+0)
	STS        CS11_bit+0, R27
;Solar_Auto_Switcher.c,510 :: 		CS12_bit=0;
	LDS        R27, CS12_bit+0
	CBR        R27, BitMask(CS12_bit+0)
	STS        CS12_bit+0, R27
;Solar_Auto_Switcher.c,511 :: 		}
L_TimerDelay89:
;Solar_Auto_Switcher.c,512 :: 		}
L_end_TimerDelay:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _TimerDelay

_SetTimerOn_1:

;Solar_Auto_Switcher.c,515 :: 		void SetTimerOn_1()
;Solar_Auto_Switcher.c,518 :: 		LCD_OUT(1,1,"T1 On: [1]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,519 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_190:
	DEC        R16
	BRNE       L_SetTimerOn_190
	DEC        R17
	BRNE       L_SetTimerOn_190
	DEC        R18
	BRNE       L_SetTimerOn_190
;Solar_Auto_Switcher.c,520 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,521 :: 		while (Set==1)
L_SetTimerOn_192:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_193
;Solar_Auto_Switcher.c,523 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,524 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,525 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,526 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,527 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,528 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr15_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,529 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,531 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_194:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1535
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1534
	JMP        L_SetTimerOn_195
L__SetTimerOn_1535:
L__SetTimerOn_1534:
;Solar_Auto_Switcher.c,533 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,534 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,535 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,536 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,537 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,538 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,539 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,540 :: 		if ( minutes_lcd_1 >=59 || minutes_lcd_1<=0 ) {minutes_lcd_1=0;}
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 59
	BRLO       L__SetTimerOn_1706
	JMP        L__SetTimerOn_1537
L__SetTimerOn_1706:
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOn_1707
	JMP        L__SetTimerOn_1536
L__SetTimerOn_1707:
	JMP        L_SetTimerOn_1100
L__SetTimerOn_1537:
L__SetTimerOn_1536:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1100:
;Solar_Auto_Switcher.c,541 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1101
;Solar_Auto_Switcher.c,543 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1102:
	DEC        R16
	BRNE       L_SetTimerOn_1102
	DEC        R17
	BRNE       L_SetTimerOn_1102
	DEC        R18
	BRNE       L_SetTimerOn_1102
	NOP
;Solar_Auto_Switcher.c,544 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,545 :: 		}
L_SetTimerOn_1101:
;Solar_Auto_Switcher.c,546 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1104
;Solar_Auto_Switcher.c,548 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1105:
	DEC        R16
	BRNE       L_SetTimerOn_1105
	DEC        R17
	BRNE       L_SetTimerOn_1105
	DEC        R18
	BRNE       L_SetTimerOn_1105
	NOP
;Solar_Auto_Switcher.c,549 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Auto_Switcher.c,550 :: 		}
L_SetTimerOn_1104:
;Solar_Auto_Switcher.c,551 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_194
L_SetTimerOn_195:
;Solar_Auto_Switcher.c,552 :: 		} // end first while
	JMP        L_SetTimerOn_192
L_SetTimerOn_193:
;Solar_Auto_Switcher.c,554 :: 		Delay_ms(1000);     //read time for state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_1107:
	DEC        R16
	BRNE       L_SetTimerOn_1107
	DEC        R17
	BRNE       L_SetTimerOn_1107
	DEC        R18
	BRNE       L_SetTimerOn_1107
;Solar_Auto_Switcher.c,555 :: 		while (Set==1)
L_SetTimerOn_1109:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_1110
;Solar_Auto_Switcher.c,557 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,558 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,559 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,560 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,561 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr18_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,562 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,564 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1111:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_1539
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_1538
	JMP        L_SetTimerOn_1112
L__SetTimerOn_1539:
L__SetTimerOn_1538:
;Solar_Auto_Switcher.c,566 :: 		ByteToStr(hours_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,567 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,568 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,569 :: 		ByteToStr(minutes_lcd_1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_1+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,570 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr19_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,571 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,572 :: 		if ( hours_lcd_1 >=24  || hours_lcd_1 <=0) {hours_lcd_1=0;}
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 24
	BRLO       L__SetTimerOn_1708
	JMP        L__SetTimerOn_1541
L__SetTimerOn_1708:
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOn_1709
	JMP        L__SetTimerOn_1540
L__SetTimerOn_1709:
	JMP        L_SetTimerOn_1117
L__SetTimerOn_1541:
L__SetTimerOn_1540:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1117:
;Solar_Auto_Switcher.c,573 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_1118
;Solar_Auto_Switcher.c,575 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1119:
	DEC        R16
	BRNE       L_SetTimerOn_1119
	DEC        R17
	BRNE       L_SetTimerOn_1119
	DEC        R18
	BRNE       L_SetTimerOn_1119
	NOP
;Solar_Auto_Switcher.c,576 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,577 :: 		}
L_SetTimerOn_1118:
;Solar_Auto_Switcher.c,578 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_1121
;Solar_Auto_Switcher.c,580 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1122:
	DEC        R16
	BRNE       L_SetTimerOn_1122
	DEC        R17
	BRNE       L_SetTimerOn_1122
	DEC        R18
	BRNE       L_SetTimerOn_1122
	NOP
;Solar_Auto_Switcher.c,581 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Auto_Switcher.c,582 :: 		}
L_SetTimerOn_1121:
;Solar_Auto_Switcher.c,583 :: 		} // end while increment
	JMP        L_SetTimerOn_1111
L_SetTimerOn_1112:
;Solar_Auto_Switcher.c,584 :: 		} // end first while
	JMP        L_SetTimerOn_1109
L_SetTimerOn_1110:
;Solar_Auto_Switcher.c,585 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,586 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,587 :: 		}
L_end_SetTimerOn_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Auto_Switcher.c,589 :: 		void SetTimerOff_1()
;Solar_Auto_Switcher.c,591 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,592 :: 		LCD_OUT(1,1,"T1 Off: [2]");
	LDI        R27, #lo_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr20_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,593 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,594 :: 		while (Set==1)
L_SetTimerOff_1124:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1125
;Solar_Auto_Switcher.c,596 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,597 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr21_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,598 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,599 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,600 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,601 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr22_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,602 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,604 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1126:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1547
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1546
	JMP        L_SetTimerOff_1127
L__SetTimerOff_1547:
L__SetTimerOff_1546:
;Solar_Auto_Switcher.c,606 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,607 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr23_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr23_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,608 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,609 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,610 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,611 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr24_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,612 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,613 :: 		if ( minutes_lcd_2 >=59 ||minutes_lcd_2<=0 ) {minutes_lcd_2=0;}
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 59
	BRLO       L__SetTimerOff_1711
	JMP        L__SetTimerOff_1549
L__SetTimerOff_1711:
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOff_1712
	JMP        L__SetTimerOff_1548
L__SetTimerOff_1712:
	JMP        L_SetTimerOff_1132
L__SetTimerOff_1549:
L__SetTimerOff_1548:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1132:
;Solar_Auto_Switcher.c,614 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1133
;Solar_Auto_Switcher.c,616 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1134:
	DEC        R16
	BRNE       L_SetTimerOff_1134
	DEC        R17
	BRNE       L_SetTimerOff_1134
	DEC        R18
	BRNE       L_SetTimerOff_1134
	NOP
;Solar_Auto_Switcher.c,617 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,618 :: 		}
L_SetTimerOff_1133:
;Solar_Auto_Switcher.c,619 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1136
;Solar_Auto_Switcher.c,621 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1137:
	DEC        R16
	BRNE       L_SetTimerOff_1137
	DEC        R17
	BRNE       L_SetTimerOff_1137
	DEC        R18
	BRNE       L_SetTimerOff_1137
	NOP
;Solar_Auto_Switcher.c,622 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Auto_Switcher.c,623 :: 		}
L_SetTimerOff_1136:
;Solar_Auto_Switcher.c,624 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1126
L_SetTimerOff_1127:
;Solar_Auto_Switcher.c,625 :: 		} // end first while
	JMP        L_SetTimerOff_1124
L_SetTimerOff_1125:
;Solar_Auto_Switcher.c,627 :: 		Delay_ms(1000); // read button state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOff_1139:
	DEC        R16
	BRNE       L_SetTimerOff_1139
	DEC        R17
	BRNE       L_SetTimerOff_1139
	DEC        R18
	BRNE       L_SetTimerOff_1139
;Solar_Auto_Switcher.c,628 :: 		while (Set==1)
L_SetTimerOff_1141:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_1142
;Solar_Auto_Switcher.c,630 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,631 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr25_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr25_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
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
;Solar_Auto_Switcher.c,633 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,634 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,635 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr26_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr26_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,636 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,638 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1143:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_1551
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_1550
	JMP        L_SetTimerOff_1144
L__SetTimerOff_1551:
L__SetTimerOff_1550:
;Solar_Auto_Switcher.c,640 :: 		ByteToStr(hours_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,641 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr27_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,642 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,643 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,644 :: 		ByteToStr(minutes_lcd_2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_2+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,645 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr28_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr28_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,646 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,647 :: 		if ( hours_lcd_2 >=24 || hours_lcd_2<=0) {hours_lcd_2=0;}
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 24
	BRLO       L__SetTimerOff_1713
	JMP        L__SetTimerOff_1553
L__SetTimerOff_1713:
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOff_1714
	JMP        L__SetTimerOff_1552
L__SetTimerOff_1714:
	JMP        L_SetTimerOff_1149
L__SetTimerOff_1553:
L__SetTimerOff_1552:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1149:
;Solar_Auto_Switcher.c,648 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_1150
;Solar_Auto_Switcher.c,650 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1151:
	DEC        R16
	BRNE       L_SetTimerOff_1151
	DEC        R17
	BRNE       L_SetTimerOff_1151
	DEC        R18
	BRNE       L_SetTimerOff_1151
	NOP
;Solar_Auto_Switcher.c,651 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,652 :: 		}
L_SetTimerOff_1150:
;Solar_Auto_Switcher.c,653 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_1153
;Solar_Auto_Switcher.c,655 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1154:
	DEC        R16
	BRNE       L_SetTimerOff_1154
	DEC        R17
	BRNE       L_SetTimerOff_1154
	DEC        R18
	BRNE       L_SetTimerOff_1154
	NOP
;Solar_Auto_Switcher.c,656 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Auto_Switcher.c,657 :: 		}
L_SetTimerOff_1153:
;Solar_Auto_Switcher.c,658 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1143
L_SetTimerOff_1144:
;Solar_Auto_Switcher.c,659 :: 		} // end first while
	JMP        L_SetTimerOff_1141
L_SetTimerOff_1142:
;Solar_Auto_Switcher.c,660 :: 		EEPROM_Write(0x03,hours_lcd_2); // save hours 2 timer tp eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,661 :: 		EEPROM_Write(0x04,minutes_lcd_2); // save hours 1 timer tp eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,662 :: 		}
L_end_SetTimerOff_1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetTimerOn_2:

;Solar_Auto_Switcher.c,664 :: 		void SetTimerOn_2()
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
;Solar_Auto_Switcher.c,667 :: 		LCD_OUT(1,1,"T2 On: [3]");
	LDI        R27, #lo_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr29_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,668 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_2156:
	DEC        R16
	BRNE       L_SetTimerOn_2156
	DEC        R17
	BRNE       L_SetTimerOn_2156
	DEC        R18
	BRNE       L_SetTimerOn_2156
;Solar_Auto_Switcher.c,669 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,670 :: 		while (Set==1)
L_SetTimerOn_2158:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2159
;Solar_Auto_Switcher.c,672 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,673 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr30_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr30_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,674 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,675 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,676 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,677 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr31_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr31_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,678 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,680 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOn_2160:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2559
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2558
	JMP        L_SetTimerOn_2161
L__SetTimerOn_2559:
L__SetTimerOn_2558:
;Solar_Auto_Switcher.c,682 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,683 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr32_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,684 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,685 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,686 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,687 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr33_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,688 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,689 :: 		if ( minutes_lcd_timer2_start >=59 ||minutes_lcd_timer2_start<=0 ) {minutes_lcd_timer2_start=0;}
	LDS        R16, _minutes_lcd_timer2_start+0
	CPI        R16, 59
	BRLO       L__SetTimerOn_2716
	JMP        L__SetTimerOn_2561
L__SetTimerOn_2716:
	LDS        R17, _minutes_lcd_timer2_start+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOn_2717
	JMP        L__SetTimerOn_2560
L__SetTimerOn_2717:
	JMP        L_SetTimerOn_2166
L__SetTimerOn_2561:
L__SetTimerOn_2560:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_start+0, R27
L_SetTimerOn_2166:
;Solar_Auto_Switcher.c,690 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2167
;Solar_Auto_Switcher.c,692 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2168:
	DEC        R16
	BRNE       L_SetTimerOn_2168
	DEC        R17
	BRNE       L_SetTimerOn_2168
	DEC        R18
	BRNE       L_SetTimerOn_2168
	NOP
;Solar_Auto_Switcher.c,693 :: 		minutes_lcd_timer2_start++;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,694 :: 		}
L_SetTimerOn_2167:
;Solar_Auto_Switcher.c,695 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2170
;Solar_Auto_Switcher.c,697 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2171:
	DEC        R16
	BRNE       L_SetTimerOn_2171
	DEC        R17
	BRNE       L_SetTimerOn_2171
	DEC        R18
	BRNE       L_SetTimerOn_2171
	NOP
;Solar_Auto_Switcher.c,698 :: 		minutes_lcd_timer2_start--;
	LDS        R16, _minutes_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,699 :: 		}
L_SetTimerOn_2170:
;Solar_Auto_Switcher.c,700 :: 		} // end while increment or decrement
	JMP        L_SetTimerOn_2160
L_SetTimerOn_2161:
;Solar_Auto_Switcher.c,701 :: 		} // end first while
	JMP        L_SetTimerOn_2158
L_SetTimerOn_2159:
;Solar_Auto_Switcher.c,703 :: 		Delay_ms(1000); // read button state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_2173:
	DEC        R16
	BRNE       L_SetTimerOn_2173
	DEC        R17
	BRNE       L_SetTimerOn_2173
	DEC        R18
	BRNE       L_SetTimerOn_2173
;Solar_Auto_Switcher.c,704 :: 		while (Set==1)
L_SetTimerOn_2175:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_2176
;Solar_Auto_Switcher.c,706 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,707 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr34_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,708 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,709 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,710 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,711 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr35_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr35_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,712 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,714 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOn_2177:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_2563
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_2562
	JMP        L_SetTimerOn_2178
L__SetTimerOn_2563:
L__SetTimerOn_2562:
;Solar_Auto_Switcher.c,716 :: 		ByteToStr(hours_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,717 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr36_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,718 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,719 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,720 :: 		ByteToStr(minutes_lcd_timer2_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,721 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr37_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,722 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,723 :: 		if ( hours_lcd_timer2_start >=24 || hours_lcd_timer2_start<=0 ) {hours_lcd_timer2_start=0;}
	LDS        R16, _hours_lcd_timer2_start+0
	CPI        R16, 24
	BRLO       L__SetTimerOn_2718
	JMP        L__SetTimerOn_2565
L__SetTimerOn_2718:
	LDS        R17, _hours_lcd_timer2_start+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOn_2719
	JMP        L__SetTimerOn_2564
L__SetTimerOn_2719:
	JMP        L_SetTimerOn_2183
L__SetTimerOn_2565:
L__SetTimerOn_2564:
	LDI        R27, 0
	STS        _hours_lcd_timer2_start+0, R27
L_SetTimerOn_2183:
;Solar_Auto_Switcher.c,724 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_2184
;Solar_Auto_Switcher.c,726 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2185:
	DEC        R16
	BRNE       L_SetTimerOn_2185
	DEC        R17
	BRNE       L_SetTimerOn_2185
	DEC        R18
	BRNE       L_SetTimerOn_2185
	NOP
;Solar_Auto_Switcher.c,727 :: 		hours_lcd_timer2_start++;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,728 :: 		}
L_SetTimerOn_2184:
;Solar_Auto_Switcher.c,729 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_2187
;Solar_Auto_Switcher.c,731 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_2188:
	DEC        R16
	BRNE       L_SetTimerOn_2188
	DEC        R17
	BRNE       L_SetTimerOn_2188
	DEC        R18
	BRNE       L_SetTimerOn_2188
	NOP
;Solar_Auto_Switcher.c,732 :: 		hours_lcd_timer2_start--;
	LDS        R16, _hours_lcd_timer2_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_start+0, R16
;Solar_Auto_Switcher.c,733 :: 		}
L_SetTimerOn_2187:
;Solar_Auto_Switcher.c,734 :: 		} // end while increment or decrement
	JMP        L_SetTimerOn_2177
L_SetTimerOn_2178:
;Solar_Auto_Switcher.c,735 :: 		} // end first while
	JMP        L_SetTimerOn_2175
L_SetTimerOn_2176:
;Solar_Auto_Switcher.c,736 :: 		EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_start+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,737 :: 		EEPROM_Write(0x19,minutes_lcd_timer2_start); // save hours 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_start+0
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,738 :: 		}
L_end_SetTimerOn_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_2

_SetTimerOff_2:

;Solar_Auto_Switcher.c,741 :: 		void SetTimerOff_2()
;Solar_Auto_Switcher.c,743 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,744 :: 		LCD_OUT(1,1,"T2 Off: [4]");
	LDI        R27, #lo_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr38_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,745 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,746 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOff_2190:
	DEC        R16
	BRNE       L_SetTimerOff_2190
	DEC        R17
	BRNE       L_SetTimerOff_2190
	DEC        R18
	BRNE       L_SetTimerOff_2190
;Solar_Auto_Switcher.c,747 :: 		while (Set==1)
L_SetTimerOff_2192:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2193
;Solar_Auto_Switcher.c,749 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,750 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr39_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,751 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,752 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,753 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,754 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr40_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
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
;Solar_Auto_Switcher.c,757 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2194:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2571
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2570
	JMP        L_SetTimerOff_2195
L__SetTimerOff_2571:
L__SetTimerOff_2570:
;Solar_Auto_Switcher.c,760 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,761 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr41_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,762 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,763 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,764 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,765 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr42_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,766 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,767 :: 		if ( minutes_lcd_timer2_stop >=59 || minutes_lcd_timer2_stop<=0 ) {minutes_lcd_timer2_stop=0;}
	LDS        R16, _minutes_lcd_timer2_stop+0
	CPI        R16, 59
	BRLO       L__SetTimerOff_2721
	JMP        L__SetTimerOff_2573
L__SetTimerOff_2721:
	LDS        R17, _minutes_lcd_timer2_stop+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOff_2722
	JMP        L__SetTimerOff_2572
L__SetTimerOff_2722:
	JMP        L_SetTimerOff_2200
L__SetTimerOff_2573:
L__SetTimerOff_2572:
	LDI        R27, 0
	STS        _minutes_lcd_timer2_stop+0, R27
L_SetTimerOff_2200:
;Solar_Auto_Switcher.c,768 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2201
;Solar_Auto_Switcher.c,770 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2202:
	DEC        R16
	BRNE       L_SetTimerOff_2202
	DEC        R17
	BRNE       L_SetTimerOff_2202
	DEC        R18
	BRNE       L_SetTimerOff_2202
	NOP
;Solar_Auto_Switcher.c,771 :: 		minutes_lcd_timer2_stop++;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,772 :: 		}
L_SetTimerOff_2201:
;Solar_Auto_Switcher.c,773 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2204
;Solar_Auto_Switcher.c,775 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2205:
	DEC        R16
	BRNE       L_SetTimerOff_2205
	DEC        R17
	BRNE       L_SetTimerOff_2205
	DEC        R18
	BRNE       L_SetTimerOff_2205
	NOP
;Solar_Auto_Switcher.c,776 :: 		minutes_lcd_timer2_stop--;
	LDS        R16, _minutes_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,777 :: 		}
L_SetTimerOff_2204:
;Solar_Auto_Switcher.c,778 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2194
L_SetTimerOff_2195:
;Solar_Auto_Switcher.c,779 :: 		} // end first while
	JMP        L_SetTimerOff_2192
L_SetTimerOff_2193:
;Solar_Auto_Switcher.c,781 :: 		Delay_ms(1000); // read button state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOff_2207:
	DEC        R16
	BRNE       L_SetTimerOff_2207
	DEC        R17
	BRNE       L_SetTimerOff_2207
	DEC        R18
	BRNE       L_SetTimerOff_2207
;Solar_Auto_Switcher.c,782 :: 		while (Set==1)
L_SetTimerOff_2209:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_2210
;Solar_Auto_Switcher.c,784 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,785 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr43_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,786 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,787 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,788 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,789 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr44_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,790 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,792 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_2211:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_2575
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_2574
	JMP        L_SetTimerOff_2212
L__SetTimerOff_2575:
L__SetTimerOff_2574:
;Solar_Auto_Switcher.c,794 :: 		ByteToStr(hours_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,795 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr45_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,796 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,797 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,798 :: 		ByteToStr(minutes_lcd_timer2_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer2_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,799 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr46_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,800 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,801 :: 		if ( hours_lcd_timer2_stop >=24 ||hours_lcd_timer2_stop<=0  ) {hours_lcd_timer2_stop=0;}
	LDS        R16, _hours_lcd_timer2_stop+0
	CPI        R16, 24
	BRLO       L__SetTimerOff_2723
	JMP        L__SetTimerOff_2577
L__SetTimerOff_2723:
	LDS        R17, _hours_lcd_timer2_stop+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOff_2724
	JMP        L__SetTimerOff_2576
L__SetTimerOff_2724:
	JMP        L_SetTimerOff_2217
L__SetTimerOff_2577:
L__SetTimerOff_2576:
	LDI        R27, 0
	STS        _hours_lcd_timer2_stop+0, R27
L_SetTimerOff_2217:
;Solar_Auto_Switcher.c,802 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_2218
;Solar_Auto_Switcher.c,804 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2219:
	DEC        R16
	BRNE       L_SetTimerOff_2219
	DEC        R17
	BRNE       L_SetTimerOff_2219
	DEC        R18
	BRNE       L_SetTimerOff_2219
	NOP
;Solar_Auto_Switcher.c,805 :: 		hours_lcd_timer2_stop++;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,806 :: 		}
L_SetTimerOff_2218:
;Solar_Auto_Switcher.c,807 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_2221
;Solar_Auto_Switcher.c,809 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_2222:
	DEC        R16
	BRNE       L_SetTimerOff_2222
	DEC        R17
	BRNE       L_SetTimerOff_2222
	DEC        R18
	BRNE       L_SetTimerOff_2222
	NOP
;Solar_Auto_Switcher.c,810 :: 		hours_lcd_timer2_stop--;
	LDS        R16, _hours_lcd_timer2_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer2_stop+0, R16
;Solar_Auto_Switcher.c,811 :: 		}
L_SetTimerOff_2221:
;Solar_Auto_Switcher.c,812 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_2211
L_SetTimerOff_2212:
;Solar_Auto_Switcher.c,813 :: 		} // end first while
	JMP        L_SetTimerOff_2209
L_SetTimerOff_2210:
;Solar_Auto_Switcher.c,814 :: 		EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_timer2_stop+0
	LDI        R27, 32
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,815 :: 		EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save hours 1 timer tp eeprom
	LDS        R4, _minutes_lcd_timer2_stop+0
	LDI        R27, 33
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,816 :: 		}
L_end_SetTimerOff_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_2

_SetTimerOn_3:

;Solar_Auto_Switcher.c,818 :: 		void SetTimerOn_3()
;Solar_Auto_Switcher.c,820 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,821 :: 		LCD_OUT(1,1,"T3 On: [5]");
	LDI        R27, #lo_addr(?lstr47_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr47_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,822 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,823 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_3224:
	DEC        R16
	BRNE       L_SetTimerOn_3224
	DEC        R17
	BRNE       L_SetTimerOn_3224
	DEC        R18
	BRNE       L_SetTimerOn_3224
;Solar_Auto_Switcher.c,824 :: 		while(Set==1)
L_SetTimerOn_3226:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_3227
;Solar_Auto_Switcher.c,826 :: 		ByteToStr(hours_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,827 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr48_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr48_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,828 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,829 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,830 :: 		ByteToStr(minutes_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,831 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr49_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr49_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,832 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,833 :: 		while(Increment==1 || Decrement==1 )
L_SetTimerOn_3228:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_3583
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_3582
	JMP        L_SetTimerOn_3229
L__SetTimerOn_3583:
L__SetTimerOn_3582:
;Solar_Auto_Switcher.c,836 :: 		ByteToStr(hours_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,837 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr50_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr50_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,838 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,839 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,840 :: 		ByteToStr(minutes_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,841 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr51_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr51_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,842 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,843 :: 		if ( minutes_lcd_timer3_start >=60 || minutes_lcd_timer3_start <=0 ) {minutes_lcd_timer3_start=0;}
	LDS        R16, _minutes_lcd_timer3_start+0
	CPI        R16, 60
	BRLO       L__SetTimerOn_3726
	JMP        L__SetTimerOn_3585
L__SetTimerOn_3726:
	LDS        R17, _minutes_lcd_timer3_start+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOn_3727
	JMP        L__SetTimerOn_3584
L__SetTimerOn_3727:
	JMP        L_SetTimerOn_3234
L__SetTimerOn_3585:
L__SetTimerOn_3584:
	LDI        R27, 0
	STS        _minutes_lcd_timer3_start+0, R27
L_SetTimerOn_3234:
;Solar_Auto_Switcher.c,844 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_3235
;Solar_Auto_Switcher.c,846 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_3236:
	DEC        R16
	BRNE       L_SetTimerOn_3236
	DEC        R17
	BRNE       L_SetTimerOn_3236
	DEC        R18
	BRNE       L_SetTimerOn_3236
	NOP
;Solar_Auto_Switcher.c,847 :: 		minutes_lcd_timer3_start++;
	LDS        R16, _minutes_lcd_timer3_start+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,848 :: 		}
L_SetTimerOn_3235:
;Solar_Auto_Switcher.c,849 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_3238
;Solar_Auto_Switcher.c,851 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_3239:
	DEC        R16
	BRNE       L_SetTimerOn_3239
	DEC        R17
	BRNE       L_SetTimerOn_3239
	DEC        R18
	BRNE       L_SetTimerOn_3239
	NOP
;Solar_Auto_Switcher.c,852 :: 		minutes_lcd_timer3_start--;
	LDS        R16, _minutes_lcd_timer3_start+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,853 :: 		}
L_SetTimerOn_3238:
;Solar_Auto_Switcher.c,854 :: 		} // end while increment decrement
	JMP        L_SetTimerOn_3228
L_SetTimerOn_3229:
;Solar_Auto_Switcher.c,855 :: 		} // end while set for minutes
	JMP        L_SetTimerOn_3226
L_SetTimerOn_3227:
;Solar_Auto_Switcher.c,858 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOn_3241:
	DEC        R16
	BRNE       L_SetTimerOn_3241
	DEC        R17
	BRNE       L_SetTimerOn_3241
	DEC        R18
	BRNE       L_SetTimerOn_3241
;Solar_Auto_Switcher.c,859 :: 		while(Set==1)
L_SetTimerOn_3243:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOn_3244
;Solar_Auto_Switcher.c,861 :: 		ByteToStr(hours_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,862 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr52_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr52_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
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
;Solar_Auto_Switcher.c,864 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,865 :: 		ByteToStr(minutes_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,866 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr53_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr53_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,867 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,868 :: 		while(Increment==1 || Decrement==1 )
L_SetTimerOn_3245:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOn_3587
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOn_3586
	JMP        L_SetTimerOn_3246
L__SetTimerOn_3587:
L__SetTimerOn_3586:
;Solar_Auto_Switcher.c,870 :: 		ByteToStr(hours_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,871 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr54_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr54_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,872 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,873 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,874 :: 		ByteToStr(minutes_lcd_timer3_start,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_start+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,875 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr55_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr55_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,876 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,877 :: 		if ( hours_lcd_timer3_start >=24 || hours_lcd_timer3_start <=0 ) {hours_lcd_timer3_start=0;}
	LDS        R16, _hours_lcd_timer3_start+0
	CPI        R16, 24
	BRLO       L__SetTimerOn_3728
	JMP        L__SetTimerOn_3589
L__SetTimerOn_3728:
	LDS        R17, _hours_lcd_timer3_start+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOn_3729
	JMP        L__SetTimerOn_3588
L__SetTimerOn_3729:
	JMP        L_SetTimerOn_3251
L__SetTimerOn_3589:
L__SetTimerOn_3588:
	LDI        R27, 0
	STS        _hours_lcd_timer3_start+0, R27
L_SetTimerOn_3251:
;Solar_Auto_Switcher.c,878 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOn_3252
;Solar_Auto_Switcher.c,880 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_3253:
	DEC        R16
	BRNE       L_SetTimerOn_3253
	DEC        R17
	BRNE       L_SetTimerOn_3253
	DEC        R18
	BRNE       L_SetTimerOn_3253
	NOP
;Solar_Auto_Switcher.c,881 :: 		hours_lcd_timer3_start++;
	LDS        R16, _hours_lcd_timer3_start+0
	SUBI       R16, 255
	STS        _hours_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,882 :: 		}
L_SetTimerOn_3252:
;Solar_Auto_Switcher.c,883 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOn_3255
;Solar_Auto_Switcher.c,885 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_3256:
	DEC        R16
	BRNE       L_SetTimerOn_3256
	DEC        R17
	BRNE       L_SetTimerOn_3256
	DEC        R18
	BRNE       L_SetTimerOn_3256
	NOP
;Solar_Auto_Switcher.c,886 :: 		hours_lcd_timer3_start--;
	LDS        R16, _hours_lcd_timer3_start+0
	SUBI       R16, 1
	STS        _hours_lcd_timer3_start+0, R16
;Solar_Auto_Switcher.c,887 :: 		}
L_SetTimerOn_3255:
;Solar_Auto_Switcher.c,888 :: 		} // end while increment decrement
	JMP        L_SetTimerOn_3245
L_SetTimerOn_3246:
;Solar_Auto_Switcher.c,889 :: 		}     // end while set for hours
	JMP        L_SetTimerOn_3243
L_SetTimerOn_3244:
;Solar_Auto_Switcher.c,890 :: 		EEPROM_Write(0x22,hours_lcd_timer3_start); // save hours 1 timer tp eepro
	LDS        R4, _hours_lcd_timer3_start+0
	LDI        R27, 34
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,891 :: 		EEPROM_Write(0x23,minutes_lcd_timer3_start); // save hours 1 timer tp eepro
	LDS        R4, _minutes_lcd_timer3_start+0
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,892 :: 		}
L_end_SetTimerOn_3:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_3

_SetTimerOff_3:

;Solar_Auto_Switcher.c,894 :: 		void SetTimerOff_3()
;Solar_Auto_Switcher.c,896 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,897 :: 		LCD_OUT(1,1,"T3 Off: [6]");
	LDI        R27, #lo_addr(?lstr56_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr56_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,898 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,899 :: 		Delay_ms(1000);         // delay for button to read state
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOff_3258:
	DEC        R16
	BRNE       L_SetTimerOff_3258
	DEC        R17
	BRNE       L_SetTimerOff_3258
	DEC        R18
	BRNE       L_SetTimerOff_3258
;Solar_Auto_Switcher.c,900 :: 		while (Set==1)
L_SetTimerOff_3260:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_3261
;Solar_Auto_Switcher.c,902 :: 		ByteToStr(hours_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,903 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr57_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr57_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,904 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,905 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,906 :: 		ByteToStr(minutes_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,907 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr58_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr58_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,908 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,910 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_3262:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_3595
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_3594
	JMP        L_SetTimerOff_3263
L__SetTimerOff_3595:
L__SetTimerOff_3594:
;Solar_Auto_Switcher.c,913 :: 		ByteToStr(hours_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,914 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr59_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr59_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,915 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,916 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,917 :: 		ByteToStr(minutes_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,918 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr60_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr60_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,919 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,920 :: 		if ( minutes_lcd_timer3_stop >=59  || minutes_lcd_timer3_stop<=0 ) {minutes_lcd_timer3_stop=0;}
	LDS        R16, _minutes_lcd_timer3_stop+0
	CPI        R16, 59
	BRLO       L__SetTimerOff_3731
	JMP        L__SetTimerOff_3597
L__SetTimerOff_3731:
	LDS        R17, _minutes_lcd_timer3_stop+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOff_3732
	JMP        L__SetTimerOff_3596
L__SetTimerOff_3732:
	JMP        L_SetTimerOff_3268
L__SetTimerOff_3597:
L__SetTimerOff_3596:
	LDI        R27, 0
	STS        _minutes_lcd_timer3_stop+0, R27
L_SetTimerOff_3268:
;Solar_Auto_Switcher.c,921 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_3269
;Solar_Auto_Switcher.c,923 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_3270:
	DEC        R16
	BRNE       L_SetTimerOff_3270
	DEC        R17
	BRNE       L_SetTimerOff_3270
	DEC        R18
	BRNE       L_SetTimerOff_3270
	NOP
;Solar_Auto_Switcher.c,924 :: 		minutes_lcd_timer3_stop++;
	LDS        R16, _minutes_lcd_timer3_stop+0
	SUBI       R16, 255
	STS        _minutes_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,925 :: 		}
L_SetTimerOff_3269:
;Solar_Auto_Switcher.c,926 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_3272
;Solar_Auto_Switcher.c,928 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_3273:
	DEC        R16
	BRNE       L_SetTimerOff_3273
	DEC        R17
	BRNE       L_SetTimerOff_3273
	DEC        R18
	BRNE       L_SetTimerOff_3273
	NOP
;Solar_Auto_Switcher.c,929 :: 		minutes_lcd_timer3_stop--;
	LDS        R16, _minutes_lcd_timer3_stop+0
	SUBI       R16, 1
	STS        _minutes_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,930 :: 		}
L_SetTimerOff_3272:
;Solar_Auto_Switcher.c,931 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_3262
L_SetTimerOff_3263:
;Solar_Auto_Switcher.c,932 :: 		} // end while set for minutes
	JMP        L_SetTimerOff_3260
L_SetTimerOff_3261:
;Solar_Auto_Switcher.c,935 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimerOff_3275:
	DEC        R16
	BRNE       L_SetTimerOff_3275
	DEC        R17
	BRNE       L_SetTimerOff_3275
	DEC        R18
	BRNE       L_SetTimerOff_3275
;Solar_Auto_Switcher.c,936 :: 		while (Set==1)
L_SetTimerOff_3277:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimerOff_3278
;Solar_Auto_Switcher.c,938 :: 		ByteToStr(hours_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,939 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr61_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr61_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,940 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,941 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,942 :: 		ByteToStr(minutes_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,943 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr62_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr62_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
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
;Solar_Auto_Switcher.c,946 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_3279:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimerOff_3599
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimerOff_3598
	JMP        L_SetTimerOff_3280
L__SetTimerOff_3599:
L__SetTimerOff_3598:
;Solar_Auto_Switcher.c,949 :: 		ByteToStr(hours_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _hours_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,950 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr63_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr63_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,951 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,952 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,953 :: 		ByteToStr(minutes_lcd_timer3_stop,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _minutes_lcd_timer3_stop+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,954 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr64_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr64_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,955 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,956 :: 		if ( hours_lcd_timer3_stop >=23  || hours_lcd_timer3_stop<=0 ) {hours_lcd_timer3_stop=0;}
	LDS        R16, _hours_lcd_timer3_stop+0
	CPI        R16, 23
	BRLO       L__SetTimerOff_3733
	JMP        L__SetTimerOff_3601
L__SetTimerOff_3733:
	LDS        R17, _hours_lcd_timer3_stop+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__SetTimerOff_3734
	JMP        L__SetTimerOff_3600
L__SetTimerOff_3734:
	JMP        L_SetTimerOff_3285
L__SetTimerOff_3601:
L__SetTimerOff_3600:
	LDI        R27, 0
	STS        _hours_lcd_timer3_stop+0, R27
L_SetTimerOff_3285:
;Solar_Auto_Switcher.c,957 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimerOff_3286
;Solar_Auto_Switcher.c,959 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_3287:
	DEC        R16
	BRNE       L_SetTimerOff_3287
	DEC        R17
	BRNE       L_SetTimerOff_3287
	DEC        R18
	BRNE       L_SetTimerOff_3287
	NOP
;Solar_Auto_Switcher.c,960 :: 		hours_lcd_timer3_stop++;
	LDS        R16, _hours_lcd_timer3_stop+0
	SUBI       R16, 255
	STS        _hours_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,961 :: 		}
L_SetTimerOff_3286:
;Solar_Auto_Switcher.c,962 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimerOff_3289
;Solar_Auto_Switcher.c,964 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_3290:
	DEC        R16
	BRNE       L_SetTimerOff_3290
	DEC        R17
	BRNE       L_SetTimerOff_3290
	DEC        R18
	BRNE       L_SetTimerOff_3290
	NOP
;Solar_Auto_Switcher.c,965 :: 		hours_lcd_timer3_stop--;
	LDS        R16, _hours_lcd_timer3_stop+0
	SUBI       R16, 1
	STS        _hours_lcd_timer3_stop+0, R16
;Solar_Auto_Switcher.c,966 :: 		}
L_SetTimerOff_3289:
;Solar_Auto_Switcher.c,967 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_3279
L_SetTimerOff_3280:
;Solar_Auto_Switcher.c,968 :: 		} // end while set for minutes
	JMP        L_SetTimerOff_3277
L_SetTimerOff_3278:
;Solar_Auto_Switcher.c,970 :: 		EEPROM_Write(0x25,minutes_lcd_timer3_stop); // save hours 1 timer tp eepro
	LDS        R4, _minutes_lcd_timer3_stop+0
	LDI        R27, 37
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,971 :: 		EEPROM_Write(0x24,hours_lcd_timer3_stop); // save hours 1 timer tp eepro
	LDS        R4, _hours_lcd_timer3_stop+0
	LDI        R27, 36
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,972 :: 		}
L_end_SetTimerOff_3:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_3

_SetDS1307Hours_Program:

;Solar_Auto_Switcher.c,974 :: 		void SetDS1307Hours_Program()
;Solar_Auto_Switcher.c,976 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,977 :: 		LCD_OUT(1,1,"Set Time:[H] [7]");
	LDI        R27, #lo_addr(?lstr65_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr65_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,978 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307Hours_Program292:
	DEC        R16
	BRNE       L_SetDS1307Hours_Program292
	DEC        R17
	BRNE       L_SetDS1307Hours_Program292
	DEC        R18
	BRNE       L_SetDS1307Hours_Program292
;Solar_Auto_Switcher.c,979 :: 		while (Set==1)
L_SetDS1307Hours_Program294:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307Hours_Program295
;Solar_Auto_Switcher.c,981 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,982 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr66_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr66_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,983 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,984 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,985 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,986 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr67_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr67_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,987 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,988 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,989 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,990 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr68_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr68_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,992 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307Hours_Program296:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307Hours_Program604
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307Hours_Program603
	JMP        L_SetDS1307Hours_Program297
L__SetDS1307Hours_Program604:
L__SetDS1307Hours_Program603:
;Solar_Auto_Switcher.c,994 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,995 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr69_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr69_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,996 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,997 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,998 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,999 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr70_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr70_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1000 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1001 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1002 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1003 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr71_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr71_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1004 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1005 :: 		if ( set_ds1307_hours >=23 ) {set_ds1307_hours=0;}
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 23
	BRSH       L__SetDS1307Hours_Program736
	JMP        L_SetDS1307Hours_Program300
L__SetDS1307Hours_Program736:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307Hours_Program300:
;Solar_Auto_Switcher.c,1006 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307Hours_Program301
;Solar_Auto_Switcher.c,1008 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307Hours_Program302:
	DEC        R16
	BRNE       L_SetDS1307Hours_Program302
	DEC        R17
	BRNE       L_SetDS1307Hours_Program302
	DEC        R18
	BRNE       L_SetDS1307Hours_Program302
	NOP
;Solar_Auto_Switcher.c,1009 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,1011 :: 		}
L_SetDS1307Hours_Program301:
;Solar_Auto_Switcher.c,1012 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307Hours_Program304
;Solar_Auto_Switcher.c,1014 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307Hours_Program305:
	DEC        R16
	BRNE       L_SetDS1307Hours_Program305
	DEC        R17
	BRNE       L_SetDS1307Hours_Program305
	DEC        R18
	BRNE       L_SetDS1307Hours_Program305
	NOP
;Solar_Auto_Switcher.c,1015 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Auto_Switcher.c,1016 :: 		}
L_SetDS1307Hours_Program304:
;Solar_Auto_Switcher.c,1017 :: 		} // end while decrement or increment
	JMP        L_SetDS1307Hours_Program296
L_SetDS1307Hours_Program297:
;Solar_Auto_Switcher.c,1018 :: 		} // end first while
	JMP        L_SetDS1307Hours_Program294
L_SetDS1307Hours_Program295:
;Solar_Auto_Switcher.c,1019 :: 		}
L_end_SetDS1307Hours_Program:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetDS1307Hours_Program

_SetDS1307Minutes_Program:

;Solar_Auto_Switcher.c,1021 :: 		void SetDS1307Minutes_Program()
;Solar_Auto_Switcher.c,1023 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,1024 :: 		LCD_OUT(1,1,"Set Time:[M] [8]");
	LDI        R27, #lo_addr(?lstr72_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr72_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1025 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307Minutes_Program307:
	DEC        R16
	BRNE       L_SetDS1307Minutes_Program307
	DEC        R17
	BRNE       L_SetDS1307Minutes_Program307
	DEC        R18
	BRNE       L_SetDS1307Minutes_Program307
;Solar_Auto_Switcher.c,1026 :: 		while (Set==1)
L_SetDS1307Minutes_Program309:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307Minutes_Program310
;Solar_Auto_Switcher.c,1028 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1029 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr73_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr73_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1030 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1031 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1032 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1033 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr74_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr74_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1034 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1035 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1036 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1037 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr75_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr75_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1038 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1039 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307Minutes_Program311:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307Minutes_Program607
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307Minutes_Program606
	JMP        L_SetDS1307Minutes_Program312
L__SetDS1307Minutes_Program607:
L__SetDS1307Minutes_Program606:
;Solar_Auto_Switcher.c,1041 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1042 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr76_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr76_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1043 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1044 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1045 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1046 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr77_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr77_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1047 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1048 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1049 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1050 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr78_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr78_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1051 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1052 :: 		if ( set_ds1307_minutes >59 ) {set_ds1307_minutes=0;}
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307Minutes_Program738
	JMP        L_SetDS1307Minutes_Program315
L__SetDS1307Minutes_Program738:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307Minutes_Program315:
;Solar_Auto_Switcher.c,1053 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307Minutes_Program316
;Solar_Auto_Switcher.c,1055 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307Minutes_Program317:
	DEC        R16
	BRNE       L_SetDS1307Minutes_Program317
	DEC        R17
	BRNE       L_SetDS1307Minutes_Program317
	DEC        R18
	BRNE       L_SetDS1307Minutes_Program317
	NOP
;Solar_Auto_Switcher.c,1056 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,1058 :: 		}
L_SetDS1307Minutes_Program316:
;Solar_Auto_Switcher.c,1059 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307Minutes_Program319
;Solar_Auto_Switcher.c,1061 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307Minutes_Program320:
	DEC        R16
	BRNE       L_SetDS1307Minutes_Program320
	DEC        R17
	BRNE       L_SetDS1307Minutes_Program320
	DEC        R18
	BRNE       L_SetDS1307Minutes_Program320
	NOP
;Solar_Auto_Switcher.c,1062 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Auto_Switcher.c,1063 :: 		}
L_SetDS1307Minutes_Program319:
;Solar_Auto_Switcher.c,1064 :: 		} // end while decrement or increment
	JMP        L_SetDS1307Minutes_Program311
L_SetDS1307Minutes_Program312:
;Solar_Auto_Switcher.c,1065 :: 		} // end first while
	JMP        L_SetDS1307Minutes_Program309
L_SetDS1307Minutes_Program310:
;Solar_Auto_Switcher.c,1066 :: 		}
L_end_SetDS1307Minutes_Program:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetDS1307Minutes_Program

_SetDS1307Seconds_Program:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Auto_Switcher.c,1068 :: 		void SetDS1307Seconds_Program()
;Solar_Auto_Switcher.c,1070 :: 		LCD_Clear(1,1,16);
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
;Solar_Auto_Switcher.c,1071 :: 		LCD_OUT(1,1,"Set Time:[S] [9]");
	LDI        R27, #lo_addr(?lstr79_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr79_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1072 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetDS1307Seconds_Program322:
	DEC        R16
	BRNE       L_SetDS1307Seconds_Program322
	DEC        R17
	BRNE       L_SetDS1307Seconds_Program322
	DEC        R18
	BRNE       L_SetDS1307Seconds_Program322
;Solar_Auto_Switcher.c,1073 :: 		while (Set==1)
L_SetDS1307Seconds_Program324:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetDS1307Seconds_Program325
;Solar_Auto_Switcher.c,1075 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1076 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr80_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr80_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1077 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1078 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1079 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1080 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr81_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr81_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1081 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1082 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1083 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1084 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr82_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr82_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1085 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1086 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307Seconds_Program326:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetDS1307Seconds_Program610
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetDS1307Seconds_Program609
	JMP        L_SetDS1307Seconds_Program327
L__SetDS1307Seconds_Program610:
L__SetDS1307Seconds_Program609:
;Solar_Auto_Switcher.c,1088 :: 		ByteToStr(set_ds1307_hours,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_hours+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1089 :: 		LCD_OUT(2,1,"H:");
	LDI        R27, #lo_addr(?lstr83_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr83_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1090 :: 		LCD_Out(2,2,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1091 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1092 :: 		ByteToStr(set_ds1307_minutes,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_minutes+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1093 :: 		LCD_OUT(2,6,"M:");
	LDI        R27, #lo_addr(?lstr84_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr84_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1094 :: 		LCD_Out(2,7,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1095 :: 		LCD_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;Solar_Auto_Switcher.c,1096 :: 		ByteToStr(set_ds1307_seconds,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R3, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R4, R27
	LDS        R2, _set_ds1307_seconds+0
	CALL       _ByteToStr+0
;Solar_Auto_Switcher.c,1097 :: 		LCD_OUT(2,12,"S:");
	LDI        R27, #lo_addr(?lstr85_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr85_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 12
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1098 :: 		LCD_Out(2,13,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1099 :: 		if ( set_ds1307_seconds >59 ) {set_ds1307_seconds=0;}
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307Seconds_Program740
	JMP        L_SetDS1307Seconds_Program330
L__SetDS1307Seconds_Program740:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307Seconds_Program330:
;Solar_Auto_Switcher.c,1100 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetDS1307Seconds_Program331
;Solar_Auto_Switcher.c,1102 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307Seconds_Program332:
	DEC        R16
	BRNE       L_SetDS1307Seconds_Program332
	DEC        R17
	BRNE       L_SetDS1307Seconds_Program332
	DEC        R18
	BRNE       L_SetDS1307Seconds_Program332
	NOP
;Solar_Auto_Switcher.c,1103 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,1105 :: 		}
L_SetDS1307Seconds_Program331:
;Solar_Auto_Switcher.c,1106 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetDS1307Seconds_Program334
;Solar_Auto_Switcher.c,1108 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307Seconds_Program335:
	DEC        R16
	BRNE       L_SetDS1307Seconds_Program335
	DEC        R17
	BRNE       L_SetDS1307Seconds_Program335
	DEC        R18
	BRNE       L_SetDS1307Seconds_Program335
	NOP
;Solar_Auto_Switcher.c,1109 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Auto_Switcher.c,1110 :: 		}
L_SetDS1307Seconds_Program334:
;Solar_Auto_Switcher.c,1113 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Auto_Switcher.c,1114 :: 		} // end while decrement or increment
	JMP        L_SetDS1307Seconds_Program326
L_SetDS1307Seconds_Program327:
;Solar_Auto_Switcher.c,1115 :: 		} // end first while
	JMP        L_SetDS1307Seconds_Program324
L_SetDS1307Seconds_Program325:
;Solar_Auto_Switcher.c,1116 :: 		}
L_end_SetDS1307Seconds_Program:
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
; end of _SetDS1307Seconds_Program

_AC_Available_ByPass_System:

;Solar_Auto_Switcher.c,1118 :: 		void AC_Available_ByPass_System()
;Solar_Auto_Switcher.c,1121 :: 		LCD_OUT(1,1,"ByPass Grid: [10]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr86_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr86_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1122 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_AC_Available_ByPass_System337:
	DEC        R16
	BRNE       L_AC_Available_ByPass_System337
	DEC        R17
	BRNE       L_AC_Available_ByPass_System337
	DEC        R18
	BRNE       L_AC_Available_ByPass_System337
;Solar_Auto_Switcher.c,1123 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1126 :: 		if (ByPassState==0) LCD_OUT(2,1,"Enabled"); else LCD_OUT(2,1,"Disabled");
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__AC_Available_ByPass_System742
	JMP        L_AC_Available_ByPass_System339
L__AC_Available_ByPass_System742:
	LDI        R27, #lo_addr(?lstr87_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr87_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_AC_Available_ByPass_System340
L_AC_Available_ByPass_System339:
	LDI        R27, #lo_addr(?lstr88_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr88_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_AC_Available_ByPass_System340:
;Solar_Auto_Switcher.c,1127 :: 		while (Set==1)
L_AC_Available_ByPass_System341:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_AC_Available_ByPass_System342
;Solar_Auto_Switcher.c,1129 :: 		if (ByPassState==0) LCD_OUT(2,1,"Enabled"); else LCD_OUT(2,1,"Disabled");
	LDS        R16, _ByPassState+0
	CPI        R16, 0
	BREQ       L__AC_Available_ByPass_System743
	JMP        L_AC_Available_ByPass_System343
L__AC_Available_ByPass_System743:
	LDI        R27, #lo_addr(?lstr89_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr89_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_AC_Available_ByPass_System344
L_AC_Available_ByPass_System343:
	LDI        R27, #lo_addr(?lstr90_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr90_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_AC_Available_ByPass_System344:
;Solar_Auto_Switcher.c,1131 :: 		while (Increment == 1 || Decrement==1)
L_AC_Available_ByPass_System345:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__AC_Available_ByPass_System613
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__AC_Available_ByPass_System612
	JMP        L_AC_Available_ByPass_System346
L__AC_Available_ByPass_System613:
L__AC_Available_ByPass_System612:
;Solar_Auto_Switcher.c,1133 :: 		if (Increment==1) ByPassState=1;
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_AC_Available_ByPass_System349
	LDI        R27, 1
	STS        _ByPassState+0, R27
L_AC_Available_ByPass_System349:
;Solar_Auto_Switcher.c,1134 :: 		if (Decrement==1) ByPassState=0;
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_AC_Available_ByPass_System350
	LDI        R27, 0
	STS        _ByPassState+0, R27
L_AC_Available_ByPass_System350:
;Solar_Auto_Switcher.c,1136 :: 		} // end while increment
	JMP        L_AC_Available_ByPass_System345
L_AC_Available_ByPass_System346:
;Solar_Auto_Switcher.c,1137 :: 		} // end first while
	JMP        L_AC_Available_ByPass_System341
L_AC_Available_ByPass_System342:
;Solar_Auto_Switcher.c,1138 :: 		EEPROM_Write(0x06,ByPassState); // save hours 1 timer tp eeprom
	LDS        R4, _ByPassState+0
	LDI        R27, 6
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1139 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1140 :: 		}
L_end_AC_Available_ByPass_System:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _AC_Available_ByPass_System

_SetLowBatteryVoltage:

;Solar_Auto_Switcher.c,1142 :: 		void SetLowBatteryVoltage()
;Solar_Auto_Switcher.c,1144 :: 		LCD_OUT(1,1,"Low Battery: [11]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, #lo_addr(?lstr91_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr91_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1145 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetLowBatteryVoltage351:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage351
	DEC        R17
	BRNE       L_SetLowBatteryVoltage351
	DEC        R18
	BRNE       L_SetLowBatteryVoltage351
;Solar_Auto_Switcher.c,1146 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1147 :: 		while(Set==1)
L_SetLowBatteryVoltage353:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowBatteryVoltage354
;Solar_Auto_Switcher.c,1149 :: 		sprintf(txt,"%4.1f",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_92_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_92_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1150 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1151 :: 		LCD_OUT(2,5,"V");
	LDI        R27, #lo_addr(?lstr93_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr93_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1152 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage355:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowBatteryVoltage616
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowBatteryVoltage615
	JMP        L_SetLowBatteryVoltage356
L__SetLowBatteryVoltage616:
L__SetLowBatteryVoltage615:
;Solar_Auto_Switcher.c,1154 :: 		sprintf(txt,"%4.1f",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_94_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_94_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1155 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1156 :: 		LCD_OUT(2,5,"V");
	LDI        R27, #lo_addr(?lstr95_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr95_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1157 :: 		if(Mini_Battery_Voltage> 65 ) Mini_Battery_Voltage=0.0;
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
	BREQ       L__SetLowBatteryVoltage745
	LDI        R16, 1
L__SetLowBatteryVoltage745:
	TST        R16
	BRNE       L__SetLowBatteryVoltage746
	JMP        L_SetLowBatteryVoltage359
L__SetLowBatteryVoltage746:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage359:
;Solar_Auto_Switcher.c,1159 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowBatteryVoltage360
;Solar_Auto_Switcher.c,1161 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage361:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage361
	DEC        R17
	BRNE       L_SetLowBatteryVoltage361
	DEC        R18
	BRNE       L_SetLowBatteryVoltage361
	NOP
;Solar_Auto_Switcher.c,1162 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Auto_Switcher.c,1164 :: 		}
L_SetLowBatteryVoltage360:
;Solar_Auto_Switcher.c,1165 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowBatteryVoltage363
;Solar_Auto_Switcher.c,1167 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage364:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage364
	DEC        R17
	BRNE       L_SetLowBatteryVoltage364
	DEC        R18
	BRNE       L_SetLowBatteryVoltage364
	NOP
;Solar_Auto_Switcher.c,1168 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Auto_Switcher.c,1169 :: 		}
L_SetLowBatteryVoltage363:
;Solar_Auto_Switcher.c,1170 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage355
L_SetLowBatteryVoltage356:
;Solar_Auto_Switcher.c,1171 :: 		}// end while set
	JMP        L_SetLowBatteryVoltage353
L_SetLowBatteryVoltage354:
;Solar_Auto_Switcher.c,1172 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetLowBatteryVoltage366:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage366
	DEC        R17
	BRNE       L_SetLowBatteryVoltage366
	DEC        R18
	BRNE       L_SetLowBatteryVoltage366
;Solar_Auto_Switcher.c,1173 :: 		StoreBytesIntoEEprom(0x07,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Auto_Switcher.c,1174 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1175 :: 		}
L_end_SetLowBatteryVoltage:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowBatteryVoltage

_SetTimer:

;Solar_Auto_Switcher.c,1177 :: 		void SetTimer()
;Solar_Auto_Switcher.c,1179 :: 		LCD_OUT(1,1,"Timer State:[12]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr96_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr96_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1180 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetTimer368:
	DEC        R16
	BRNE       L_SetTimer368
	DEC        R17
	BRNE       L_SetTimer368
	DEC        R18
	BRNE       L_SetTimer368
;Solar_Auto_Switcher.c,1181 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1182 :: 		while (Set==1)
L_SetTimer370:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetTimer371
;Solar_Auto_Switcher.c,1184 :: 		LCD_OUT(1,1,"Timer : [10]");
	LDI        R27, #lo_addr(?lstr97_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr97_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1185 :: 		if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled");}
	LDS        R16, _Timer_Enable+0
	CPI        R16, 0
	BREQ       L__SetTimer748
	JMP        L_SetTimer372
L__SetTimer748:
	LDI        R27, #lo_addr(?lstr98_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr98_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_SetTimer373
L_SetTimer372:
	LDI        R27, #lo_addr(?lstr99_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr99_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_SetTimer373:
;Solar_Auto_Switcher.c,1186 :: 		while(Increment == 1 || Decrement == 1 )
L_SetTimer374:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetTimer619
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetTimer618
	JMP        L_SetTimer375
L__SetTimer619:
L__SetTimer618:
;Solar_Auto_Switcher.c,1190 :: 		if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled");}
	LDS        R16, _Timer_Enable+0
	CPI        R16, 0
	BREQ       L__SetTimer749
	JMP        L_SetTimer378
L__SetTimer749:
	LDI        R27, #lo_addr(?lstr100_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr100_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_SetTimer379
L_SetTimer378:
	LDI        R27, #lo_addr(?lstr101_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr101_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_SetTimer379:
;Solar_Auto_Switcher.c,1191 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetTimer380
;Solar_Auto_Switcher.c,1193 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimer381:
	DEC        R16
	BRNE       L_SetTimer381
	DEC        R17
	BRNE       L_SetTimer381
	DEC        R18
	BRNE       L_SetTimer381
	NOP
;Solar_Auto_Switcher.c,1194 :: 		Timer_Enable=1; // timer is enabled
	LDI        R27, 1
	STS        _Timer_Enable+0, R27
;Solar_Auto_Switcher.c,1195 :: 		}
L_SetTimer380:
;Solar_Auto_Switcher.c,1196 :: 		if (Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetTimer383
;Solar_Auto_Switcher.c,1198 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimer384:
	DEC        R16
	BRNE       L_SetTimer384
	DEC        R17
	BRNE       L_SetTimer384
	DEC        R18
	BRNE       L_SetTimer384
	NOP
;Solar_Auto_Switcher.c,1199 :: 		Timer_Enable=0; // timer is disabled
	LDI        R27, 0
	STS        _Timer_Enable+0, R27
;Solar_Auto_Switcher.c,1200 :: 		}
L_SetTimer383:
;Solar_Auto_Switcher.c,1201 :: 		} // while increment decrement
	JMP        L_SetTimer374
L_SetTimer375:
;Solar_Auto_Switcher.c,1202 :: 		} // end while set
	JMP        L_SetTimer370
L_SetTimer371:
;Solar_Auto_Switcher.c,1203 :: 		EEPROM_Write(0x11,Timer_Enable); // save the state of the timer
	LDS        R4, _Timer_Enable+0
	LDI        R27, 17
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1204 :: 		LCD_CMD(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Solar_Auto_Switcher.c,1205 :: 		}
L_end_SetTimer:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimer

_SetHighVoltage:

;Solar_Auto_Switcher.c,1207 :: 		void SetHighVoltage()
;Solar_Auto_Switcher.c,1209 :: 		LCD_OUT(1,1,"High Volt: [13]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr102_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr102_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1210 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetHighVoltage386:
	DEC        R16
	BRNE       L_SetHighVoltage386
	DEC        R17
	BRNE       L_SetHighVoltage386
	DEC        R18
	BRNE       L_SetHighVoltage386
;Solar_Auto_Switcher.c,1211 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1212 :: 		while(Set==1)
L_SetHighVoltage388:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetHighVoltage389
;Solar_Auto_Switcher.c,1214 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1215 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1216 :: 		while(Increment==1 || Decrement==1)
L_SetHighVoltage390:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetHighVoltage622
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetHighVoltage621
	JMP        L_SetHighVoltage391
L__SetHighVoltage622:
L__SetHighVoltage621:
;Solar_Auto_Switcher.c,1218 :: 		IntToStr(High_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _High_Voltage+0
	LDS        R3, _High_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1219 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1220 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetHighVoltage394
;Solar_Auto_Switcher.c,1222 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage395:
	DEC        R16
	BRNE       L_SetHighVoltage395
	DEC        R17
	BRNE       L_SetHighVoltage395
	DEC        R18
	BRNE       L_SetHighVoltage395
	NOP
;Solar_Auto_Switcher.c,1223 :: 		High_Voltage++;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1224 :: 		}
L_SetHighVoltage394:
;Solar_Auto_Switcher.c,1225 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetHighVoltage397
;Solar_Auto_Switcher.c,1227 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetHighVoltage398:
	DEC        R16
	BRNE       L_SetHighVoltage398
	DEC        R17
	BRNE       L_SetHighVoltage398
	DEC        R18
	BRNE       L_SetHighVoltage398
	NOP
;Solar_Auto_Switcher.c,1228 :: 		High_Voltage--;
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _High_Voltage+0, R16
	STS        _High_Voltage+1, R17
;Solar_Auto_Switcher.c,1229 :: 		}
L_SetHighVoltage397:
;Solar_Auto_Switcher.c,1230 :: 		} // end while increment or decrement
	JMP        L_SetHighVoltage390
L_SetHighVoltage391:
;Solar_Auto_Switcher.c,1231 :: 		} // end while set
	JMP        L_SetHighVoltage388
L_SetHighVoltage389:
;Solar_Auto_Switcher.c,1232 :: 		EEPROM_Write(0x12,High_Voltage);
	LDS        R4, _High_Voltage+0
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1233 :: 		}
L_end_SetHighVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetHighVoltage

_SetLowVoltage:

;Solar_Auto_Switcher.c,1235 :: 		void SetLowVoltage()
;Solar_Auto_Switcher.c,1237 :: 		LCD_OUT(1,1,"Low Volt: [14]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr103_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr103_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1238 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetLowVoltage400:
	DEC        R16
	BRNE       L_SetLowVoltage400
	DEC        R17
	BRNE       L_SetLowVoltage400
	DEC        R18
	BRNE       L_SetLowVoltage400
;Solar_Auto_Switcher.c,1239 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1240 :: 		while(Set==1)
L_SetLowVoltage402:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetLowVoltage403
;Solar_Auto_Switcher.c,1242 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1243 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1244 :: 		while(Increment==1 || Decrement==1)
L_SetLowVoltage404:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetLowVoltage625
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetLowVoltage624
	JMP        L_SetLowVoltage405
L__SetLowVoltage625:
L__SetLowVoltage624:
;Solar_Auto_Switcher.c,1246 :: 		IntToStr(Low_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Low_Voltage+0
	LDS        R3, _Low_Voltage+1
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1247 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1248 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetLowVoltage408
;Solar_Auto_Switcher.c,1250 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage409:
	DEC        R16
	BRNE       L_SetLowVoltage409
	DEC        R17
	BRNE       L_SetLowVoltage409
	DEC        R18
	BRNE       L_SetLowVoltage409
	NOP
;Solar_Auto_Switcher.c,1251 :: 		Low_Voltage++;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1252 :: 		}
L_SetLowVoltage408:
;Solar_Auto_Switcher.c,1253 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetLowVoltage411
;Solar_Auto_Switcher.c,1255 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowVoltage412:
	DEC        R16
	BRNE       L_SetLowVoltage412
	DEC        R17
	BRNE       L_SetLowVoltage412
	DEC        R18
	BRNE       L_SetLowVoltage412
	NOP
;Solar_Auto_Switcher.c,1256 :: 		Low_Voltage--;
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Low_Voltage+0, R16
	STS        _Low_Voltage+1, R17
;Solar_Auto_Switcher.c,1257 :: 		}
L_SetLowVoltage411:
;Solar_Auto_Switcher.c,1258 :: 		} // end while increment or decrement
	JMP        L_SetLowVoltage404
L_SetLowVoltage405:
;Solar_Auto_Switcher.c,1259 :: 		} // end while set
	JMP        L_SetLowVoltage402
L_SetLowVoltage403:
;Solar_Auto_Switcher.c,1260 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1261 :: 		EEPROM_Write(0x13,Low_Voltage);
	LDS        R4, _Low_Voltage+0
	LDI        R27, 19
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1262 :: 		}
L_end_SetLowVoltage:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowVoltage

_EnableBatteryGuard:

;Solar_Auto_Switcher.c,1264 :: 		void EnableBatteryGuard()
;Solar_Auto_Switcher.c,1266 :: 		LCD_OUT(1,1,"Batt Guard:[15]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr104_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr104_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1267 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_EnableBatteryGuard414:
	DEC        R16
	BRNE       L_EnableBatteryGuard414
	DEC        R17
	BRNE       L_EnableBatteryGuard414
	DEC        R18
	BRNE       L_EnableBatteryGuard414
;Solar_Auto_Switcher.c,1268 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1269 :: 		while(Set==1)
L_EnableBatteryGuard416:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_EnableBatteryGuard417
;Solar_Auto_Switcher.c,1271 :: 		if(BatteryGuardEnable==1) LCD_OUT(2,1,"Enabled"); if(BatteryGuardEnable==0)  LCD_OUT(2,1,"Disabled");
	LDS        R16, _BatteryGuardEnable+0
	CPI        R16, 1
	BREQ       L__EnableBatteryGuard753
	JMP        L_EnableBatteryGuard418
L__EnableBatteryGuard753:
	LDI        R27, #lo_addr(?lstr105_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr105_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableBatteryGuard418:
	LDS        R16, _BatteryGuardEnable+0
	CPI        R16, 0
	BREQ       L__EnableBatteryGuard754
	JMP        L_EnableBatteryGuard419
L__EnableBatteryGuard754:
	LDI        R27, #lo_addr(?lstr106_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr106_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableBatteryGuard419:
;Solar_Auto_Switcher.c,1272 :: 		while(Increment==1 || Decrement==1)
L_EnableBatteryGuard420:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__EnableBatteryGuard631
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__EnableBatteryGuard630
	JMP        L_EnableBatteryGuard421
L__EnableBatteryGuard631:
L__EnableBatteryGuard630:
;Solar_Auto_Switcher.c,1274 :: 		if(BatteryGuardEnable==1) LCD_OUT(2,1,"Enabled"); if(BatteryGuardEnable==0)  LCD_OUT(2,1,"Disabled");
	LDS        R16, _BatteryGuardEnable+0
	CPI        R16, 1
	BREQ       L__EnableBatteryGuard755
	JMP        L_EnableBatteryGuard424
L__EnableBatteryGuard755:
	LDI        R27, #lo_addr(?lstr107_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr107_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableBatteryGuard424:
	LDS        R16, _BatteryGuardEnable+0
	CPI        R16, 0
	BREQ       L__EnableBatteryGuard756
	JMP        L_EnableBatteryGuard425
L__EnableBatteryGuard756:
	LDI        R27, #lo_addr(?lstr108_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr108_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableBatteryGuard425:
;Solar_Auto_Switcher.c,1275 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_EnableBatteryGuard426
;Solar_Auto_Switcher.c,1277 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_EnableBatteryGuard427:
	DEC        R16
	BRNE       L_EnableBatteryGuard427
	DEC        R17
	BRNE       L_EnableBatteryGuard427
	DEC        R18
	BRNE       L_EnableBatteryGuard427
	NOP
;Solar_Auto_Switcher.c,1278 :: 		BatteryGuardEnable=1;
	LDI        R27, 1
	STS        _BatteryGuardEnable+0, R27
;Solar_Auto_Switcher.c,1279 :: 		}
L_EnableBatteryGuard426:
;Solar_Auto_Switcher.c,1280 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_EnableBatteryGuard429
;Solar_Auto_Switcher.c,1282 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_EnableBatteryGuard430:
	DEC        R16
	BRNE       L_EnableBatteryGuard430
	DEC        R17
	BRNE       L_EnableBatteryGuard430
	DEC        R18
	BRNE       L_EnableBatteryGuard430
	NOP
;Solar_Auto_Switcher.c,1283 :: 		BatteryGuardEnable=0;
	LDI        R27, 0
	STS        _BatteryGuardEnable+0, R27
;Solar_Auto_Switcher.c,1284 :: 		}
L_EnableBatteryGuard429:
;Solar_Auto_Switcher.c,1286 :: 		} // end while increment decrement
	JMP        L_EnableBatteryGuard420
L_EnableBatteryGuard421:
;Solar_Auto_Switcher.c,1287 :: 		} //end while
	JMP        L_EnableBatteryGuard416
L_EnableBatteryGuard417:
;Solar_Auto_Switcher.c,1288 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1289 :: 		EEPROM_Write(0x14,BatteryGuardEnable);
	LDS        R4, _BatteryGuardEnable+0
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1290 :: 		}
L_end_EnableBatteryGuard:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _EnableBatteryGuard

_EnableVoltageGuard:

;Solar_Auto_Switcher.c,1292 :: 		void EnableVoltageGuard()
;Solar_Auto_Switcher.c,1294 :: 		LCD_OUT(1,1,"Volt Prot: [16]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr109_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr109_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1295 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_EnableVoltageGuard432:
	DEC        R16
	BRNE       L_EnableVoltageGuard432
	DEC        R17
	BRNE       L_EnableVoltageGuard432
	DEC        R18
	BRNE       L_EnableVoltageGuard432
;Solar_Auto_Switcher.c,1296 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1297 :: 		while(Set==1)
L_EnableVoltageGuard434:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_EnableVoltageGuard435
;Solar_Auto_Switcher.c,1299 :: 		if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled"); if(VoltageProtectionEnable==0)  LCD_OUT(2,1,"Disabled");
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__EnableVoltageGuard758
	JMP        L_EnableVoltageGuard436
L__EnableVoltageGuard758:
	LDI        R27, #lo_addr(?lstr110_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr110_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableVoltageGuard436:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__EnableVoltageGuard759
	JMP        L_EnableVoltageGuard437
L__EnableVoltageGuard759:
	LDI        R27, #lo_addr(?lstr111_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr111_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableVoltageGuard437:
;Solar_Auto_Switcher.c,1300 :: 		while (Increment==1 || Decrement==1)
L_EnableVoltageGuard438:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__EnableVoltageGuard628
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__EnableVoltageGuard627
	JMP        L_EnableVoltageGuard439
L__EnableVoltageGuard628:
L__EnableVoltageGuard627:
;Solar_Auto_Switcher.c,1302 :: 		if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled"); if(VoltageProtectionEnable==0)  LCD_OUT(2,1,"Disabled");
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__EnableVoltageGuard760
	JMP        L_EnableVoltageGuard442
L__EnableVoltageGuard760:
	LDI        R27, #lo_addr(?lstr112_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr112_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableVoltageGuard442:
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 0
	BREQ       L__EnableVoltageGuard761
	JMP        L_EnableVoltageGuard443
L__EnableVoltageGuard761:
	LDI        R27, #lo_addr(?lstr113_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr113_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_EnableVoltageGuard443:
;Solar_Auto_Switcher.c,1303 :: 		if (Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_EnableVoltageGuard444
;Solar_Auto_Switcher.c,1305 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_EnableVoltageGuard445:
	DEC        R16
	BRNE       L_EnableVoltageGuard445
	DEC        R17
	BRNE       L_EnableVoltageGuard445
	DEC        R18
	BRNE       L_EnableVoltageGuard445
	NOP
;Solar_Auto_Switcher.c,1306 :: 		VoltageProtectionEnable=1;
	LDI        R27, 1
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,1307 :: 		}
L_EnableVoltageGuard444:
;Solar_Auto_Switcher.c,1308 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_EnableVoltageGuard447
;Solar_Auto_Switcher.c,1310 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_EnableVoltageGuard448:
	DEC        R16
	BRNE       L_EnableVoltageGuard448
	DEC        R17
	BRNE       L_EnableVoltageGuard448
	DEC        R18
	BRNE       L_EnableVoltageGuard448
	NOP
;Solar_Auto_Switcher.c,1311 :: 		VoltageProtectionEnable=0;
	LDI        R27, 0
	STS        _VoltageProtectionEnable+0, R27
;Solar_Auto_Switcher.c,1312 :: 		}
L_EnableVoltageGuard447:
;Solar_Auto_Switcher.c,1314 :: 		} // end while increment and decrement
	JMP        L_EnableVoltageGuard438
L_EnableVoltageGuard439:
;Solar_Auto_Switcher.c,1315 :: 		}  // end while
	JMP        L_EnableVoltageGuard434
L_EnableVoltageGuard435:
;Solar_Auto_Switcher.c,1316 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1317 :: 		EEPROM_Write(0x15,VoltageProtectionEnable);
	LDS        R4, _VoltageProtectionEnable+0
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1318 :: 		} // end function
L_end_EnableVoltageGuard:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _EnableVoltageGuard

_SetACVoltageError:

;Solar_Auto_Switcher.c,1321 :: 		void SetACVoltageError()
;Solar_Auto_Switcher.c,1323 :: 		LCD_OUT(1,1,"Volt Error: [17]");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(?lstr114_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr114_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1324 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_SetACVoltageError450:
	DEC        R16
	BRNE       L_SetACVoltageError450
	DEC        R17
	BRNE       L_SetACVoltageError450
	DEC        R18
	BRNE       L_SetACVoltageError450
;Solar_Auto_Switcher.c,1325 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1326 :: 		while (Set==1)
L_SetACVoltageError452:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L_SetACVoltageError453
;Solar_Auto_Switcher.c,1328 :: 		IntToStr(Adjusted_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Adjusted_Voltage+0
	LDI        R27, 0
	MOV        R3, R27
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1329 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1330 :: 		while(Increment==1 || Decrement == 1 )
L_SetACVoltageError454:
	IN         R27, PIND+0
	SBRC       R27, 0
	JMP        L__SetACVoltageError634
	IN         R27, PIND+0
	SBRC       R27, 1
	JMP        L__SetACVoltageError633
	JMP        L_SetACVoltageError455
L__SetACVoltageError634:
L__SetACVoltageError633:
;Solar_Auto_Switcher.c,1332 :: 		IntToStr(Adjusted_Voltage,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _Adjusted_Voltage+0
	LDI        R27, 0
	MOV        R3, R27
	CALL       _IntToStr+0
;Solar_Auto_Switcher.c,1333 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1334 :: 		if(Adjusted_Voltage <= 0 ) Adjusted_Voltage=0;
	LDS        R17, _Adjusted_Voltage+0
	LDI        R16, 0
	CP         R16, R17
	BRSH       L__SetACVoltageError763
	JMP        L_SetACVoltageError458
L__SetACVoltageError763:
	LDI        R27, 0
	STS        _Adjusted_Voltage+0, R27
L_SetACVoltageError458:
;Solar_Auto_Switcher.c,1335 :: 		if(Increment==1)
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_SetACVoltageError459
;Solar_Auto_Switcher.c,1337 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetACVoltageError460:
	DEC        R16
	BRNE       L_SetACVoltageError460
	DEC        R17
	BRNE       L_SetACVoltageError460
	DEC        R18
	BRNE       L_SetACVoltageError460
	NOP
;Solar_Auto_Switcher.c,1338 :: 		Adjusted_Voltage++;
	LDS        R16, _Adjusted_Voltage+0
	SUBI       R16, 255
	STS        _Adjusted_Voltage+0, R16
;Solar_Auto_Switcher.c,1339 :: 		}
L_SetACVoltageError459:
;Solar_Auto_Switcher.c,1340 :: 		if(Decrement==1)
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_SetACVoltageError462
;Solar_Auto_Switcher.c,1342 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetACVoltageError463:
	DEC        R16
	BRNE       L_SetACVoltageError463
	DEC        R17
	BRNE       L_SetACVoltageError463
	DEC        R18
	BRNE       L_SetACVoltageError463
	NOP
;Solar_Auto_Switcher.c,1343 :: 		Adjusted_Voltage--;
	LDS        R16, _Adjusted_Voltage+0
	SUBI       R16, 1
	STS        _Adjusted_Voltage+0, R16
;Solar_Auto_Switcher.c,1344 :: 		}
L_SetACVoltageError462:
;Solar_Auto_Switcher.c,1345 :: 		} // end while increment or decrement
	JMP        L_SetACVoltageError454
L_SetACVoltageError455:
;Solar_Auto_Switcher.c,1346 :: 		} // end while set
	JMP        L_SetACVoltageError452
L_SetACVoltageError453:
;Solar_Auto_Switcher.c,1347 :: 		LCD_Clear(1,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1348 :: 		LCD_Clear(2,1,16);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _LCD_Clear+0
;Solar_Auto_Switcher.c,1349 :: 		Error_Voltage=Adjusted_Voltage-Saved_Voltage;
	LDS        R0, _Saved_Voltage+0
	LDS        R16, _Adjusted_Voltage+0
	SUB        R16, R0
	STS        _Error_Voltage+0, R16
;Solar_Auto_Switcher.c,1350 :: 		EEPROM_Write(0x16,Error_Voltage);   // difference in the voltage reading
	MOV        R4, R16
	LDI        R27, 22
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1351 :: 		EEPROM_Write(0x17,Adjusted_Voltage); // save the user voltage
	LDS        R4, _Adjusted_Voltage+0
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Auto_Switcher.c,1352 :: 		}   // end function
L_end_SetACVoltageError:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetACVoltageError

_Screen_1:

;Solar_Auto_Switcher.c,1354 :: 		void Screen_1()
;Solar_Auto_Switcher.c,1356 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Auto_Switcher.c,1357 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Auto_Switcher.c,1358 :: 		CalculateAC();
	CALL       _CalculateAC+0
;Solar_Auto_Switcher.c,1359 :: 		DisplayTimerActivation();
	CALL       _DisplayTimerActivation+0
;Solar_Auto_Switcher.c,1360 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Auto_Switcher.c,1362 :: 		void ADCBattery()
;Solar_Auto_Switcher.c,1364 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Auto_Switcher.c,1365 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Auto_Switcher.c,1366 :: 		}
L_end_ADCBattery:
	POP        R2
	RET
; end of _ADCBattery

_Read_Battery:

;Solar_Auto_Switcher.c,1368 :: 		void Read_Battery()
;Solar_Auto_Switcher.c,1370 :: 		ADC_Value=ADC_Read(1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Auto_Switcher.c,1371 :: 		Battery_Voltage=(ADC_Value*5.0)/1024.0;
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
;Solar_Auto_Switcher.c,1375 :: 		Vin_Battery=((103.653/4.653)*Battery_Voltage)+0.3; // 0.3 volt error from reading
	LDI        R20, 120
	LDI        R21, 54
	LDI        R22, 178
	LDI        R23, 65
	CALL       _float_fpmul1+0
	LDI        R20, 154
	LDI        R21, 153
	LDI        R22, 153
	LDI        R23, 62
	CALL       _float_fpadd1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
;Solar_Auto_Switcher.c,1377 :: 		sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_115_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_115_Solar_Auto_Switcher+0)
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
;Solar_Auto_Switcher.c,1378 :: 		LCD_OUT(2,1,txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1379 :: 		}
L_end_Read_Battery:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Read_Battery

_LowBatteryVoltageAlarm:

;Solar_Auto_Switcher.c,1381 :: 		void LowBatteryVoltageAlarm()
;Solar_Auto_Switcher.c,1384 :: 		if (Vin_Battery<Mini_Battery_Voltage)
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
	BREQ       L__LowBatteryVoltageAlarm768
	LDI        R16, 1
L__LowBatteryVoltageAlarm768:
	TST        R16
	BRNE       L__LowBatteryVoltageAlarm769
	JMP        L_LowBatteryVoltageAlarm465
L__LowBatteryVoltageAlarm769:
;Solar_Auto_Switcher.c,1386 :: 		Relay_L_1=0; // switch relay off the solar and turn it to grid
	IN         R27, PORTD+0
	CBR        R27, 16
	OUT        PORTD+0, R27
;Solar_Auto_Switcher.c,1387 :: 		Buzzer=1;
	IN         R27, PORTC+0
	SBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1388 :: 		Delay_ms(300);
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_LowBatteryVoltageAlarm466:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm466
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm466
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm466
	NOP
	NOP
;Solar_Auto_Switcher.c,1389 :: 		Buzzer=0;
	IN         R27, PORTC+0
	CBR        R27, 4
	OUT        PORTC+0, R27
;Solar_Auto_Switcher.c,1390 :: 		Delay_ms(300);
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_LowBatteryVoltageAlarm468:
	DEC        R16
	BRNE       L_LowBatteryVoltageAlarm468
	DEC        R17
	BRNE       L_LowBatteryVoltageAlarm468
	DEC        R18
	BRNE       L_LowBatteryVoltageAlarm468
	NOP
	NOP
;Solar_Auto_Switcher.c,1391 :: 		}
L_LowBatteryVoltageAlarm465:
;Solar_Auto_Switcher.c,1393 :: 		}
L_end_LowBatteryVoltageAlarm:
	RET
; end of _LowBatteryVoltageAlarm

_ReadAC:

;Solar_Auto_Switcher.c,1396 :: 		unsigned int ReadAC()
;Solar_Auto_Switcher.c,1400 :: 		unsigned int max_v=0;
	PUSH       R2
; max_v start address is: 21 (R21)
	LDI        R21, 0
	LDI        R22, 0
;Solar_Auto_Switcher.c,1401 :: 		char i=0;
;Solar_Auto_Switcher.c,1402 :: 		for (i=0;i<100;i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; max_v end address is: 21 (R21)
; i end address is: 18 (R18)
L_ReadAC470:
; i start address is: 18 (R18)
; max_v start address is: 21 (R21)
	CPI        R18, 100
	BRLO       L__ReadAC771
	JMP        L_ReadAC471
L__ReadAC771:
;Solar_Auto_Switcher.c,1404 :: 		r=ADC_Read(3);
	PUSH       R18
	LDI        R27, 3
	MOV        R2, R27
	CALL       _ADC_Read+0
	POP        R18
; r start address is: 19 (R19)
	MOV        R19, R16
	MOV        R20, R17
;Solar_Auto_Switcher.c,1405 :: 		if (max_v<r) max_v=r;
	CP         R21, R16
	CPC        R22, R17
	BRLO       L__ReadAC772
	JMP        L__ReadAC529
L__ReadAC772:
; max_v end address is: 21 (R21)
; max_v start address is: 16 (R16)
	MOV        R16, R19
	MOV        R17, R20
; r end address is: 19 (R19)
; max_v end address is: 16 (R16)
	MOV        R21, R16
	MOV        R22, R17
	JMP        L_ReadAC473
L__ReadAC529:
L_ReadAC473:
;Solar_Auto_Switcher.c,1406 :: 		delay_us(200);
; max_v start address is: 21 (R21)
	LDI        R17, 3
	LDI        R16, 19
L_ReadAC474:
	DEC        R16
	BRNE       L_ReadAC474
	DEC        R17
	BRNE       L_ReadAC474
;Solar_Auto_Switcher.c,1402 :: 		for (i=0;i<100;i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Solar_Auto_Switcher.c,1407 :: 		}
; i end address is: 18 (R18)
	JMP        L_ReadAC470
L_ReadAC471:
;Solar_Auto_Switcher.c,1408 :: 		return max_v;
	MOV        R16, R21
	MOV        R17, R22
; max_v end address is: 21 (R21)
;Solar_Auto_Switcher.c,1409 :: 		}
;Solar_Auto_Switcher.c,1408 :: 		return max_v;
;Solar_Auto_Switcher.c,1409 :: 		}
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

;Solar_Auto_Switcher.c,1411 :: 		void CalculateAC()
;Solar_Auto_Switcher.c,1419 :: 		v=ReadAC();
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
;Solar_Auto_Switcher.c,1420 :: 		v=v*5.0/1024.0; // 5000 mah adc voltage reference
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
;Solar_Auto_Switcher.c,1421 :: 		v=255.5*v;    // 2.2K/560K+2.2K
	LDI        R20, 0
	LDI        R21, 128
	LDI        R22, 127
	LDI        R23, 67
	CALL       _float_fpmul1+0
	STS        _v+0, R16
	STS        _v+1, R17
	STS        _v+2, R18
	STS        _v+3, R19
;Solar_Auto_Switcher.c,1422 :: 		v/=sqrt(2);
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
;Solar_Auto_Switcher.c,1423 :: 		v=v+Error_Voltage;
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
;Solar_Auto_Switcher.c,1425 :: 		if (AC_Available==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_CalculateAC476
;Solar_Auto_Switcher.c,1427 :: 		sprintf(buf,"%4.0fV",v);
	MOVW       R20, R28
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	PUSH       R19
	PUSH       R18
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_116_Solar_Auto_Switcher+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_116_Solar_Auto_Switcher+0)
	PUSH       R27
	PUSH       R21
	PUSH       R20
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 8
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;Solar_Auto_Switcher.c,1428 :: 		LCD_OUT(2,8,"-");
	LDI        R27, #lo_addr(?lstr117_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr117_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1429 :: 		LCD_OUT(2,9,buf);
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1430 :: 		}
	JMP        L_CalculateAC477
L_CalculateAC476:
;Solar_Auto_Switcher.c,1433 :: 		LCD_OUT(2,9,"   ");
	LDI        R27, #lo_addr(?lstr118_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr118_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;Solar_Auto_Switcher.c,1434 :: 		}
L_CalculateAC477:
;Solar_Auto_Switcher.c,1435 :: 		VoltageProtector(v);
	LDS        R16, _v+0
	LDS        R17, _v+1
	LDS        R18, _v+2
	LDS        R19, _v+3
	CALL       _float_fpint+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _VoltageProtector+0
;Solar_Auto_Switcher.c,1445 :: 		}
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

_DisplayTimerActivation:

;Solar_Auto_Switcher.c,1447 :: 		void DisplayTimerActivation()
;Solar_Auto_Switcher.c,1449 :: 		if (Timer_Enable==1) LCD_OUT(1,15,"T");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__DisplayTimerActivation775
	JMP        L_DisplayTimerActivation478
L__DisplayTimerActivation775:
	LDI        R27, #lo_addr(?lstr119_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr119_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_DisplayTimerActivation478:
;Solar_Auto_Switcher.c,1450 :: 		if(Timer_Enable==0) LCD_OUT(1,15," ");
	LDS        R16, _Timer_Enable+0
	CPI        R16, 0
	BREQ       L__DisplayTimerActivation776
	JMP        L_DisplayTimerActivation479
L__DisplayTimerActivation776:
	LDI        R27, #lo_addr(?lstr120_Solar_Auto_Switcher+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr120_Solar_Auto_Switcher+0)
	MOV        R5, R27
	LDI        R27, 15
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_DisplayTimerActivation479:
;Solar_Auto_Switcher.c,1451 :: 		}
L_end_DisplayTimerActivation:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _DisplayTimerActivation

_VoltageProtector:

;Solar_Auto_Switcher.c,1453 :: 		void VoltageProtector(unsigned long voltage)
;Solar_Auto_Switcher.c,1455 :: 		if(VoltageProtectionEnable==1)
	LDS        R16, _VoltageProtectionEnable+0
	CPI        R16, 1
	BREQ       L__VoltageProtector778
	JMP        L_VoltageProtector480
L__VoltageProtector778:
;Solar_Auto_Switcher.c,1457 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRSH       L__VoltageProtector779
	JMP        L__VoltageProtector640
L__VoltageProtector779:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRSH       L__VoltageProtector780
	JMP        L__VoltageProtector639
L__VoltageProtector780:
	JMP        L_VoltageProtector485
L__VoltageProtector640:
L__VoltageProtector639:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector641
L__VoltageProtector637:
;Solar_Auto_Switcher.c,1459 :: 		VoltageProtectorGood=0;
	LDI        R27, 0
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1460 :: 		}
L_VoltageProtector485:
;Solar_Auto_Switcher.c,1457 :: 		if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
L__VoltageProtector641:
;Solar_Auto_Switcher.c,1462 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
	LDS        R16, _Low_Voltage+0
	LDS        R17, _Low_Voltage+1
	LDI        R18, 0
	MOV        R19, R18
	CP         R16, R2
	CPC        R17, R3
	CPC        R18, R4
	CPC        R19, R5
	BRLO       L__VoltageProtector781
	JMP        L__VoltageProtector644
L__VoltageProtector781:
	LDS        R16, _High_Voltage+0
	LDS        R17, _High_Voltage+1
	CP         R2, R16
	CPC        R3, R17
	LDI        R27, 0
	CPC        R4, R27
	CPC        R5, R27
	BRLO       L__VoltageProtector782
	JMP        L__VoltageProtector643
L__VoltageProtector782:
L__VoltageProtector636:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L__VoltageProtector642
L__VoltageProtector635:
;Solar_Auto_Switcher.c,1464 :: 		VoltageProtectorGood=1;
	LDI        R27, 1
	STS        _VoltageProtectorGood+0, R27
;Solar_Auto_Switcher.c,1462 :: 		if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
L__VoltageProtector644:
L__VoltageProtector643:
L__VoltageProtector642:
;Solar_Auto_Switcher.c,1466 :: 		} // end voltage protection
L_VoltageProtector480:
;Solar_Auto_Switcher.c,1467 :: 		}
L_end_VoltageProtector:
	RET
; end of _VoltageProtector

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Auto_Switcher.c,1470 :: 		void main() {
;Solar_Auto_Switcher.c,1471 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Auto_Switcher.c,1472 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Auto_Switcher.c,1473 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Auto_Switcher.c,1474 :: 		ReadBytesFromEEprom(0x07,(unsigned short *)&Mini_Battery_Voltage,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 7
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Auto_Switcher.c,1475 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Auto_Switcher.c,1476 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Auto_Switcher.c,1477 :: 		while(1)
L_main491:
;Solar_Auto_Switcher.c,1479 :: 		Screen_1();
	CALL       _Screen_1+0
;Solar_Auto_Switcher.c,1480 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Auto_Switcher.c,1482 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main493:
	DEC        R16
	BRNE       L_main493
	DEC        R17
	BRNE       L_main493
	DEC        R18
	BRNE       L_main493
	NOP
;Solar_Auto_Switcher.c,1484 :: 		} // end while
	JMP        L_main491
;Solar_Auto_Switcher.c,1485 :: 		}   // end main
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
