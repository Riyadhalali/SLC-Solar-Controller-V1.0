#line 1 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/ds1307.c"
#line 1 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar loads control v1.0/mikroc/ds1307.h"
#line 1 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar loads control v1.0/mikroc/ds1307.h"
#line 7 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar loads control v1.0/mikroc/ds1307.h"
void write_Ds1307(unsigned short Address, unsigned short w_data);
unsigned short Read_DS1307(unsigned short Address);
void Read_time();
void TWI_Config();
char CheckTimeOccuredOn(char seconds_required, char minutes_required, char hours_required);
char CheckTimeOccuredOff(char seconds_required, char minutes_required, char hours_required);
char CorrectionLoad();
unsigned short ReadMinutes();
unsigned short ReadHours();




unsigned short ReadDate(unsigned short date_address);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 8 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/ds1307.c"
unsigned short Data;
unsigned short reg_1;
unsigned short reg_2;
unsigned short Full_Minutes,Full_Hours;
unsigned short seconds_reg_1_On;
unsigned short minutes_reg_1_On,hours_reg_1_On;
unsigned short seconds_reg_2_On;
unsigned short minutes_reg_2_On,hours_reg_2_On;
char bcd_value_seconds_L_On,bcd_value_seconds_H_On;
char bcd_value_minutes_L_On,bcd_value_minutes_H_On;
char bcd_value_hours_L_On,bcd_value_hours_H_On;

unsigned short seconds_reg_1_Off;
unsigned short minutes_reg_1_Off,hours_reg_1_Off;
unsigned short seconds_reg_2_Off;
unsigned short minutes_reg_2_Off,hours_reg_2_Off;
char bcd_value_seconds_L_Off,bcd_value_seconds_H_Off;
char bcd_value_minutes_L_Off,bcd_value_minutes_H_Off;
char bcd_value_hours_L_Off,bcd_value_hours_H_Off;

unsigned short day,month,year,date;
char txt2[15];


void write_Ds1307(unsigned short Address, unsigned short w_data)
{

TWI_Start();
TWI_Write(0xD0);
TWI_Write(Address);
TWI_Write(W_data);
TWI_Stop();
}

unsigned short Read_DS1307(unsigned short Address)
{
TWI_Start();
TWI_Write(0xD0);
TWI_Write(address);
TWI_Start();
TWI_Write(0xD1);
Data=TWI_Read(0);
TWI_Stop();
return Data;
}

unsigned short ReadMinutes()
{

Read_DS1307(0x01);
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
Full_Minutes=(reg_2<<4)+reg_1;
Full_Minutes=Bcd2Dec(Full_Minutes);
return Full_Minutes;
}

unsigned short ReadHours()
{

Read_DS1307(0x02);
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
Full_Hours=(reg_2<<4)+reg_1;
Full_Hours=Bcd2Dec(Full_Hours);
return Full_Hours;
}
#line 117 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/ds1307.c"
unsigned short ReadDate (unsigned short date_address)
{
Read_DS1307(date_address);
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
date=(reg_2<<4)+reg_1;
date=Bcd2Dec(date);
return date;
}
#line 156 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/ds1307.c"
void Read_time()
{

 Read_DS1307(0x02);
 reg_1 = Data & 0x0F;
 reg_2 = Data & 0xF0;
 reg_2 = reg_2 >> 4;
 LCD_OUT(1,1,"Time:");
 Lcd_Chr(1 , 6, reg_2+0x30);
 Lcd_Chr_Cp(reg_1 + 0x30);
 Lcd_Chr_Cp('-');
 Read_DS1307(0x01);
 reg_1 = Data & 0x0F;
 reg_2 = Data & 0xF0;
 reg_2 = reg_2 >> 4;
 Lcd_Chr_Cp(reg_2 + 0x30);
 Lcd_Chr_Cp(reg_1 + 0x30);
 Lcd_Chr_Cp('-');
 Read_DS1307(0x00);
 reg_1 = Data&0x0F;
 reg_2 = Data&0xF0;
 reg_2 = reg_2 >> 4;
 Lcd_Chr_cp(reg_2 + 0x30);
 Lcd_Chr_cp(reg_1 + 0x30);
 delay_ms(100);
 }

 void TWI_Config()
 {
 TWI_Init(50000);
 }

 char CheckTimeOccuredOn(char seconds_required, char minutes_required,char hours_required)
 {


 Read_DS1307(0x00);
 seconds_reg_1_On = Data & 0x0F;
 seconds_reg_2_On = Data & 0xF0;
 seconds_reg_2_On = seconds_reg_2_On >> 4;


 Read_DS1307(0x01);
 minutes_reg_1_On = Data & 0x0F;
 minutes_reg_2_On = Data & 0xF0;
 minutes_reg_2_On = minutes_reg_2_On >> 4;

 Read_Ds1307(0x02);
 hours_reg_1_On = Data & 0x0F;
 hours_reg_2_On = Data & 0xF0;
 hours_reg_2_On = hours_reg_2_On >> 4;




 bcd_value_minutes_L_On=Dec2Bcd(minutes_required)& 0x0F;
 bcd_value_minutes_H_On=(Dec2Bcd(minutes_required)&0xF0)>> 4;
 bcd_value_hours_L_On=Dec2Bcd(hours_required)& 0x0F;
 bcd_value_hours_H_On=(Dec2Bcd(hours_required)&0xF0)>> 4;

 if(minutes_reg_1_On==bcd_value_minutes_L_On && minutes_reg_2_On==bcd_value_minutes_H_On
 && hours_reg_1_On==bcd_value_hours_L_On && hours_reg_2_On==bcd_value_hours_H_On )
 {
 return 1;

 }
 else
 {
 return 0;
 }

 }

 char CheckTimeOccuredOff(char seconds_required, char minutes_required,char hours_required)
 {



 Read_DS1307(0x00);
 seconds_reg_1_Off = Data & 0x0F;
 seconds_reg_2_Off = Data & 0xF0;
 seconds_reg_2_Off = seconds_reg_2_Off >> 4;


 Read_DS1307(0x01);
 minutes_reg_1_Off = Data & 0x0F;
 minutes_reg_2_Off = Data & 0xF0;
 minutes_reg_2_Off = minutes_reg_2_Off >> 4;

 Read_Ds1307(0x02);
 hours_reg_1_Off = Data & 0x0F;
 hours_reg_2_Off = Data & 0xF0;
 hours_reg_2_Off = hours_reg_2_Off >> 4;




 bcd_value_minutes_L_Off=Dec2Bcd(minutes_required)& 0x0F;
 bcd_value_minutes_H_Off=(Dec2Bcd(minutes_required)&0xF0)>> 4;
 bcd_value_hours_L_Off=Dec2Bcd(hours_required)& 0x0F;
 bcd_value_hours_H_Off=(Dec2Bcd(hours_required)&0xF0)>> 4;

 if(minutes_reg_1_Off==bcd_value_minutes_L_Off && minutes_reg_2_Off==bcd_value_minutes_H_Off
 && hours_reg_1_Off==bcd_value_hours_L_Off && hours_reg_2_Off==bcd_value_hours_H_Off )
 {
 return 1;
 }
 else
 {
 return 0;
 }

 }
