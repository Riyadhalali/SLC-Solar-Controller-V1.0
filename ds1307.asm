
_write_Ds1307:

;ds1307.c,32 :: 		void write_Ds1307(unsigned short Address, unsigned short w_data)
;ds1307.c,35 :: 		TWI_Start();
	PUSH       R2
	PUSH       R3
	PUSH       R2
	CALL       _TWI_Start+0
;ds1307.c,36 :: 		TWI_Write(0xD0);
	LDI        R27, 208
	MOV        R2, R27
	CALL       _TWI_Write+0
	POP        R2
;ds1307.c,37 :: 		TWI_Write(Address);
	CALL       _TWI_Write+0
	POP        R3
;ds1307.c,38 :: 		TWI_Write(W_data);
	MOV        R2, R3
	CALL       _TWI_Write+0
;ds1307.c,39 :: 		TWI_Stop();
	CALL       _TWI_Stop+0
;ds1307.c,40 :: 		}
L_end_write_Ds1307:
	POP        R2
	RET
; end of _write_Ds1307

_Read_DS1307:

;ds1307.c,42 :: 		unsigned short Read_DS1307(unsigned short Address)
;ds1307.c,44 :: 		TWI_Start();   //as mentioned in the datasheet we must deal with is as a reciever mode
	PUSH       R2
	PUSH       R2
	CALL       _TWI_Start+0
;ds1307.c,45 :: 		TWI_Write(0xD0);   //the DS1307 Address
	LDI        R27, 208
	MOV        R2, R27
	CALL       _TWI_Write+0
	POP        R2
;ds1307.c,46 :: 		TWI_Write(address);
	CALL       _TWI_Write+0
;ds1307.c,47 :: 		TWI_Start();
	CALL       _TWI_Start+0
;ds1307.c,48 :: 		TWI_Write(0xD1);   ///then we send this address for tuning to Read Mode
	LDI        R27, 209
	MOV        R2, R27
	CALL       _TWI_Write+0
;ds1307.c,49 :: 		Data=TWI_Read(0);   // read Data and send not acknownlegment byte for ending the Data   reading
	CLR        R2
	CALL       _TWI_Read+0
	STS        _Data+0, R16
;ds1307.c,50 :: 		TWI_Stop();      //stop and close connection
	CALL       _TWI_Stop+0
;ds1307.c,51 :: 		return Data;
	LDS        R16, _Data+0
;ds1307.c,52 :: 		}
;ds1307.c,51 :: 		return Data;
;ds1307.c,52 :: 		}
L_end_Read_DS1307:
	POP        R2
	RET
; end of _Read_DS1307

_ReadSeconds:

;ds1307.c,54 :: 		unsigned short ReadSeconds()
;ds1307.c,57 :: 		Read_DS1307(0x00);
	PUSH       R2
	CLR        R2
	CALL       _Read_DS1307+0
;ds1307.c,58 :: 		reg_1 = Data & 0x0F;
	LDS        R16, _Data+0
	MOV        R17, R16
	ANDI       R17, 15
	STS        _reg_1+0, R17
;ds1307.c,59 :: 		reg_2 = Data & 0xF0;
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,60 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,61 :: 		Full_Seconds=(reg_2<<4)+reg_1;
	LSL        R16
	LSL        R16
	LSL        R16
	LSL        R16
	ADD        R16, R17
	STS        _Full_Seconds+0, R16
;ds1307.c,62 :: 		Full_Seconds=Bcd2Dec(Full_Seconds);
	MOV        R2, R16
	CALL       _Bcd2Dec+0
	STS        _Full_Seconds+0, R16
;ds1307.c,63 :: 		return Full_Seconds;
;ds1307.c,64 :: 		}
;ds1307.c,63 :: 		return Full_Seconds;
;ds1307.c,64 :: 		}
L_end_ReadSeconds:
	POP        R2
	RET
; end of _ReadSeconds

_ReadMinutes:

;ds1307.c,67 :: 		unsigned short ReadMinutes()
;ds1307.c,70 :: 		Read_DS1307(0x01);
	PUSH       R2
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Read_DS1307+0
;ds1307.c,71 :: 		reg_1 = Data & 0x0F;
	LDS        R16, _Data+0
	MOV        R17, R16
	ANDI       R17, 15
	STS        _reg_1+0, R17
;ds1307.c,72 :: 		reg_2 = Data & 0xF0;
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,73 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,74 :: 		Full_Minutes=(reg_2<<4)+reg_1;
	LSL        R16
	LSL        R16
	LSL        R16
	LSL        R16
	ADD        R16, R17
	STS        _Full_Minutes+0, R16
;ds1307.c,75 :: 		Full_Minutes=Bcd2Dec(Full_Minutes);
	MOV        R2, R16
	CALL       _Bcd2Dec+0
	STS        _Full_Minutes+0, R16
;ds1307.c,76 :: 		return Full_Minutes;
;ds1307.c,77 :: 		}
;ds1307.c,76 :: 		return Full_Minutes;
;ds1307.c,77 :: 		}
L_end_ReadMinutes:
	POP        R2
	RET
; end of _ReadMinutes

_ReadHours:

;ds1307.c,79 :: 		unsigned short ReadHours()
;ds1307.c,82 :: 		Read_DS1307(0x02);    //read seconds "0x00" or read minutes "0x01"
	PUSH       R2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Read_DS1307+0
;ds1307.c,83 :: 		reg_1 = Data & 0x0F;
	LDS        R16, _Data+0
	MOV        R17, R16
	ANDI       R17, 15
	STS        _reg_1+0, R17
;ds1307.c,84 :: 		reg_2 = Data & 0xF0;
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,85 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,86 :: 		Full_Hours=(reg_2<<4)+reg_1;
	LSL        R16
	LSL        R16
	LSL        R16
	LSL        R16
	ADD        R16, R17
	STS        _Full_Hours+0, R16
;ds1307.c,87 :: 		Full_Hours=Bcd2Dec(Full_Hours);
	MOV        R2, R16
	CALL       _Bcd2Dec+0
	STS        _Full_Hours+0, R16
;ds1307.c,88 :: 		return Full_Hours;
;ds1307.c,89 :: 		}
;ds1307.c,88 :: 		return Full_Hours;
;ds1307.c,89 :: 		}
L_end_ReadHours:
	POP        R2
	RET
; end of _ReadHours

_ReadDate:

;ds1307.c,130 :: 		unsigned short ReadDate (unsigned short date_address)
;ds1307.c,132 :: 		Read_DS1307(date_address);    //read seconds "0x00" or read minutes "0x01"
	PUSH       R2
	CALL       _Read_DS1307+0
;ds1307.c,133 :: 		reg_1 = Data & 0x0F;
	LDS        R16, _Data+0
	MOV        R17, R16
	ANDI       R17, 15
	STS        _reg_1+0, R17
;ds1307.c,134 :: 		reg_2 = Data & 0xF0;
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,135 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,136 :: 		date=(reg_2<<4)+reg_1;
	LSL        R16
	LSL        R16
	LSL        R16
	LSL        R16
	ADD        R16, R17
	STS        _date+0, R16
;ds1307.c,137 :: 		date=Bcd2Dec(date);
	MOV        R2, R16
	CALL       _Bcd2Dec+0
	STS        _date+0, R16
;ds1307.c,138 :: 		return date;
;ds1307.c,139 :: 		}
;ds1307.c,138 :: 		return date;
;ds1307.c,139 :: 		}
L_end_ReadDate:
	POP        R2
	RET
; end of _ReadDate

_Read_time:

;ds1307.c,169 :: 		void Read_time()
;ds1307.c,172 :: 		Read_DS1307(0x02);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Read_DS1307+0
;ds1307.c,173 :: 		reg_1 = Data & 0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _reg_1+0, R16
;ds1307.c,174 :: 		reg_2 = Data & 0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,175 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,176 :: 		LCD_OUT(1,1,"Time:");
	LDI        R27, #lo_addr(?lstr1_ds1307+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_ds1307+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;ds1307.c,177 :: 		Lcd_Chr(1 , 6, reg_2+0x30);
	LDS        R16, _reg_2+0
	SUBI       R16, 208
	MOV        R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Chr+0
;ds1307.c,178 :: 		Lcd_Chr_Cp(reg_1 + 0x30);
	LDS        R16, _reg_1+0
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ds1307.c,179 :: 		Lcd_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;ds1307.c,180 :: 		Read_DS1307(0x01);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Read_DS1307+0
;ds1307.c,181 :: 		reg_1 = Data & 0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _reg_1+0, R16
;ds1307.c,182 :: 		reg_2 = Data & 0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,183 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,184 :: 		Lcd_Chr_Cp(reg_2 + 0x30);
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ds1307.c,185 :: 		Lcd_Chr_Cp(reg_1 + 0x30);
	LDS        R16, _reg_1+0
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ds1307.c,186 :: 		Lcd_Chr_Cp('-');
	LDI        R27, 45
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;ds1307.c,187 :: 		Read_DS1307(0x00);
	CLR        R2
	CALL       _Read_DS1307+0
;ds1307.c,188 :: 		reg_1 = Data&0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _reg_1+0, R16
;ds1307.c,189 :: 		reg_2 = Data&0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _reg_2+0, R16
;ds1307.c,190 :: 		reg_2 = reg_2 >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _reg_2+0, R16
;ds1307.c,191 :: 		Lcd_Chr_cp(reg_2 + 0x30);
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ds1307.c,192 :: 		Lcd_Chr_cp(reg_1 + 0x30);
	LDS        R16, _reg_1+0
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ds1307.c,193 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_Read_time0:
	DEC        R16
	BRNE       L_Read_time0
	DEC        R17
	BRNE       L_Read_time0
	DEC        R18
	BRNE       L_Read_time0
;ds1307.c,194 :: 		}
L_end_Read_time:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Read_time

_TWI_Config:

;ds1307.c,196 :: 		void TWI_Config()
;ds1307.c,198 :: 		TWI_Init(50000);
	LDS        R27, TWPS0_bit+0
	CBR        R27, BitMask(TWPS0_bit+0)
	STS        TWPS0_bit+0, R27
	LDS        R27, TWPS1_bit+0
	CBR        R27, BitMask(TWPS1_bit+0)
	STS        TWPS1_bit+0, R27
	LDI        R27, 72
	STS        TWBR+0, R27
	CALL       _TWI_Init+0
;ds1307.c,199 :: 		}
L_end_TWI_Config:
	RET
; end of _TWI_Config

_CheckTimeOccuredOn:

;ds1307.c,201 :: 		char CheckTimeOccuredOn(char seconds_required, char minutes_required,char hours_required)
;ds1307.c,205 :: 		Read_DS1307(0x00);         //Read seconds
	PUSH       R2
	PUSH       R4
	PUSH       R3
	CLR        R2
	CALL       _Read_DS1307+0
;ds1307.c,206 :: 		seconds_reg_1_On = Data & 0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _seconds_reg_1_On+0, R16
;ds1307.c,207 :: 		seconds_reg_2_On = Data & 0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _seconds_reg_2_On+0, R16
;ds1307.c,208 :: 		seconds_reg_2_On = seconds_reg_2_On >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _seconds_reg_2_On+0, R16
;ds1307.c,211 :: 		Read_DS1307(0x01);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Read_DS1307+0
;ds1307.c,212 :: 		minutes_reg_1_On = Data & 0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _minutes_reg_1_On+0, R16
;ds1307.c,213 :: 		minutes_reg_2_On = Data & 0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _minutes_reg_2_On+0, R16
;ds1307.c,214 :: 		minutes_reg_2_On = minutes_reg_2_On >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _minutes_reg_2_On+0, R16
;ds1307.c,216 :: 		Read_Ds1307(0x02);
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Read_DS1307+0
	POP        R3
	POP        R4
;ds1307.c,217 :: 		hours_reg_1_On = Data & 0x0F;     // least important
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _hours_reg_1_On+0, R16
;ds1307.c,218 :: 		hours_reg_2_On = Data & 0xF0;     //most importanat
	MOV        R16, R17
	ANDI       R16, 240
	STS        _hours_reg_2_On+0, R16
;ds1307.c,219 :: 		hours_reg_2_On = hours_reg_2_On >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _hours_reg_2_On+0, R16
;ds1307.c,224 :: 		bcd_value_minutes_L_On=Dec2Bcd(minutes_required)& 0x0F;       //least important
	MOV        R2, R3
	CALL       _Dec2Bcd+0
	ANDI       R16, 15
	STS        _bcd_value_minutes_L_On+0, R16
;ds1307.c,225 :: 		bcd_value_minutes_H_On=(Dec2Bcd(minutes_required)&0xF0)>> 4; // getting most important
	MOV        R2, R3
	CALL       _Dec2Bcd+0
	ANDI       R16, 240
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _bcd_value_minutes_H_On+0, R16
;ds1307.c,226 :: 		bcd_value_hours_L_On=Dec2Bcd(hours_required)& 0x0F;       //least important
	MOV        R2, R4
	CALL       _Dec2Bcd+0
	ANDI       R16, 15
	STS        _bcd_value_hours_L_On+0, R16
;ds1307.c,227 :: 		bcd_value_hours_H_On=(Dec2Bcd(hours_required)&0xF0)>> 4; // getting most important
	MOV        R2, R4
	CALL       _Dec2Bcd+0
	ANDI       R16, 240
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _bcd_value_hours_H_On+0, R16
;ds1307.c,229 :: 		if(minutes_reg_1_On==bcd_value_minutes_L_On && minutes_reg_2_On==bcd_value_minutes_H_On
	LDS        R17, _minutes_reg_1_On+0
	LDS        R16, _bcd_value_minutes_L_On+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOn29
	JMP        L__CheckTimeOccuredOn14
L__CheckTimeOccuredOn29:
	LDS        R17, _minutes_reg_2_On+0
	LDS        R16, _bcd_value_minutes_H_On+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOn30
	JMP        L__CheckTimeOccuredOn13
L__CheckTimeOccuredOn30:
;ds1307.c,230 :: 		&& hours_reg_1_On==bcd_value_hours_L_On && hours_reg_2_On==bcd_value_hours_H_On )
	LDS        R17, _hours_reg_1_On+0
	LDS        R16, _bcd_value_hours_L_On+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOn31
	JMP        L__CheckTimeOccuredOn12
L__CheckTimeOccuredOn31:
	LDS        R17, _hours_reg_2_On+0
	LDS        R16, _bcd_value_hours_H_On+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOn32
	JMP        L__CheckTimeOccuredOn11
L__CheckTimeOccuredOn32:
L__CheckTimeOccuredOn10:
;ds1307.c,232 :: 		return 1;
	LDI        R16, 1
	JMP        L_end_CheckTimeOccuredOn
;ds1307.c,229 :: 		if(minutes_reg_1_On==bcd_value_minutes_L_On && minutes_reg_2_On==bcd_value_minutes_H_On
L__CheckTimeOccuredOn14:
L__CheckTimeOccuredOn13:
;ds1307.c,230 :: 		&& hours_reg_1_On==bcd_value_hours_L_On && hours_reg_2_On==bcd_value_hours_H_On )
L__CheckTimeOccuredOn12:
L__CheckTimeOccuredOn11:
;ds1307.c,237 :: 		return 0;
	LDI        R16, 0
;ds1307.c,240 :: 		}
;ds1307.c,237 :: 		return 0;
;ds1307.c,240 :: 		}
L_end_CheckTimeOccuredOn:
	POP        R2
	RET
; end of _CheckTimeOccuredOn

_CheckTimeOccuredOff:

;ds1307.c,242 :: 		char CheckTimeOccuredOff(char seconds_required, char minutes_required,char hours_required)
;ds1307.c,247 :: 		Read_DS1307(0x00);         //Read seconds
	PUSH       R2
	PUSH       R4
	PUSH       R3
	CLR        R2
	CALL       _Read_DS1307+0
;ds1307.c,248 :: 		seconds_reg_1_Off = Data & 0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _seconds_reg_1_Off+0, R16
;ds1307.c,249 :: 		seconds_reg_2_Off = Data & 0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _seconds_reg_2_Off+0, R16
;ds1307.c,250 :: 		seconds_reg_2_Off = seconds_reg_2_Off >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _seconds_reg_2_Off+0, R16
;ds1307.c,253 :: 		Read_DS1307(0x01);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Read_DS1307+0
;ds1307.c,254 :: 		minutes_reg_1_Off = Data & 0x0F;
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _minutes_reg_1_Off+0, R16
;ds1307.c,255 :: 		minutes_reg_2_Off = Data & 0xF0;
	MOV        R16, R17
	ANDI       R16, 240
	STS        _minutes_reg_2_Off+0, R16
;ds1307.c,256 :: 		minutes_reg_2_Off = minutes_reg_2_Off >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _minutes_reg_2_Off+0, R16
;ds1307.c,258 :: 		Read_Ds1307(0x02);
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Read_DS1307+0
	POP        R3
	POP        R4
;ds1307.c,259 :: 		hours_reg_1_Off = Data & 0x0F;     // least important
	LDS        R17, _Data+0
	MOV        R16, R17
	ANDI       R16, 15
	STS        _hours_reg_1_Off+0, R16
;ds1307.c,260 :: 		hours_reg_2_Off = Data & 0xF0;     //most importanat
	MOV        R16, R17
	ANDI       R16, 240
	STS        _hours_reg_2_Off+0, R16
;ds1307.c,261 :: 		hours_reg_2_Off = hours_reg_2_Off >> 4;
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _hours_reg_2_Off+0, R16
;ds1307.c,266 :: 		bcd_value_minutes_L_Off=Dec2Bcd(minutes_required)& 0x0F;       //least important
	MOV        R2, R3
	CALL       _Dec2Bcd+0
	ANDI       R16, 15
	STS        _bcd_value_minutes_L_Off+0, R16
;ds1307.c,267 :: 		bcd_value_minutes_H_Off=(Dec2Bcd(minutes_required)&0xF0)>> 4; // getting most important
	MOV        R2, R3
	CALL       _Dec2Bcd+0
	ANDI       R16, 240
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _bcd_value_minutes_H_Off+0, R16
;ds1307.c,268 :: 		bcd_value_hours_L_Off=Dec2Bcd(hours_required)& 0x0F;       //least important
	MOV        R2, R4
	CALL       _Dec2Bcd+0
	ANDI       R16, 15
	STS        _bcd_value_hours_L_Off+0, R16
;ds1307.c,269 :: 		bcd_value_hours_H_Off=(Dec2Bcd(hours_required)&0xF0)>> 4; // getting most important
	MOV        R2, R4
	CALL       _Dec2Bcd+0
	ANDI       R16, 240
	LSR        R16
	LSR        R16
	LSR        R16
	LSR        R16
	STS        _bcd_value_hours_H_Off+0, R16
;ds1307.c,271 :: 		if(minutes_reg_1_Off==bcd_value_minutes_L_Off && minutes_reg_2_Off==bcd_value_minutes_H_Off
	LDS        R17, _minutes_reg_1_Off+0
	LDS        R16, _bcd_value_minutes_L_Off+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOff34
	JMP        L__CheckTimeOccuredOff19
L__CheckTimeOccuredOff34:
	LDS        R17, _minutes_reg_2_Off+0
	LDS        R16, _bcd_value_minutes_H_Off+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOff35
	JMP        L__CheckTimeOccuredOff18
L__CheckTimeOccuredOff35:
;ds1307.c,272 :: 		&& hours_reg_1_Off==bcd_value_hours_L_Off && hours_reg_2_Off==bcd_value_hours_H_Off )
	LDS        R17, _hours_reg_1_Off+0
	LDS        R16, _bcd_value_hours_L_Off+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOff36
	JMP        L__CheckTimeOccuredOff17
L__CheckTimeOccuredOff36:
	LDS        R17, _hours_reg_2_Off+0
	LDS        R16, _bcd_value_hours_H_Off+0
	CP         R17, R16
	BREQ       L__CheckTimeOccuredOff37
	JMP        L__CheckTimeOccuredOff16
L__CheckTimeOccuredOff37:
L__CheckTimeOccuredOff15:
;ds1307.c,274 :: 		return 1;
	LDI        R16, 1
	JMP        L_end_CheckTimeOccuredOff
;ds1307.c,271 :: 		if(minutes_reg_1_Off==bcd_value_minutes_L_Off && minutes_reg_2_Off==bcd_value_minutes_H_Off
L__CheckTimeOccuredOff19:
L__CheckTimeOccuredOff18:
;ds1307.c,272 :: 		&& hours_reg_1_Off==bcd_value_hours_L_Off && hours_reg_2_Off==bcd_value_hours_H_Off )
L__CheckTimeOccuredOff17:
L__CheckTimeOccuredOff16:
;ds1307.c,278 :: 		return 0;
	LDI        R16, 0
;ds1307.c,281 :: 		}
;ds1307.c,278 :: 		return 0;
;ds1307.c,281 :: 		}
L_end_CheckTimeOccuredOff:
	POP        R2
	RET
; end of _CheckTimeOccuredOff

ds1307____?ag:

L_end_ds1307___?ag:
	RET
; end of ds1307____?ag
