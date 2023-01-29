#line 1 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdbool.h"



 typedef char _Bool;
#line 17 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
sbit LCD_RS at PORTB0_bit;
sbit LCD_EN at PORTB1_bit;
sbit LCD_D7 at PORTB5_bit;
sbit LCD_D6 at PORTB4_bit;
sbit LCD_D5 at PORTB3_bit;
sbit LCD_D4 at PORTB2_bit;

sbit LCD_RS_Direction at DDB0_bit;
sbit LCD_EN_Direction at DDB1_bit;
sbit LCD_D7_Direction at DDB5_bit;
sbit LCD_D6_Direction at DDB4_bit;
sbit LCD_D5_Direction at DDB3_bit;
sbit LCD_D4_Direction at DDB2_bit;


char set_status=0;
char txt[21];
char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char hours_lcd_timer2_start=0,hours_lcd_timer2_stop=0,seconds_lcd_timer2_start=0;
char minutes_lcd_timer2_start=0,minutes_lcd_timer2_stop=0,seconds_lcd_timer2_stop=0;
char Relay_State;
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0,set_ds1307_day=0,set_ds1307_month=0,set_ds1307_year=0;
char ByPassState=0;
float Battery_Voltage,PV_Voltage,Vin_PV,Vin_PV_Old=0,Vin_PV_Present=0;
char BatteryVoltageSystem=0;
unsigned int ADC_Value;
unsigned int ADC_Value_PV;
float Vin_Battery;
float Mini_Battery_Voltage=0,Mini_Battery_Voltage_T2=0;
char Timer_Enable=1;
char Timer_2_Enable=1;
char Timer_3_Enable=1;
char CorrectionTime_State=0;
unsigned int High_Voltage=245;
unsigned int Low_Voltage=175;
char VoltageProtectorGood;
char BatteryGuardEnable=1;
char VoltageProtectionEnable;
char Error_Voltage=0;
float v;
char Saved_Voltage;
char Adjusted_Voltage;
char AcBuzzerActiveTimes=0;
char AcBuzzerActive=0;
char matched_timer_1_start,matched_timer_1_stop, matched_timer_2_start,matched_timer_2_stop;
char Old_Reg=0;
char SolarOnGridOff=0,SolarOffGridOn=0;
char SolarOnGridOff_2=0,SolarOffGridOn_2=0;
char Timer_isOn=0,Timer_2_isOn=0;
unsigned int Timer_Counter_2=0, Timer_Counter_3=0,Timer_Counter_4=0;
unsigned int Low_PV_Voltage=50;
 _Bool  Grid_Already_On= 0 ;
unsigned short old_timer_1=0,old_timer_2=0,temp=0;
unsigned int startupTIme_1=0,startupTIme_2=0;
char updateScreen=0;
float arrayBatt[21];
float StartLoadsVoltage=0,StartLoadsVoltage_T2=0;
float BuzzerVoltage=0.1;
unsigned short ReadMinutesMinusOldTimer_1=0;
unsigned short ReadMinutesMinusOldTimer_2=0;
unsigned int Timer_Counter_For_Grid_Turn_Off=0;
char RunTimersNowState=0;
unsigned int SecondsRealTime=0;
unsigned int SecondsRealTimePv_ReConnect_T1=0,SecondsRealTimePv_ReConnect_T2=0;
unsigned int realTimeLoop=0;
 _Bool  RunWithOutBattery= 1 ;
int const ButtonDelay=200;
char RunLoadsByBass=0;
char TurnOffLoadsByPass=0;
char VoltageProtectorEnableFlag=1;

void EEPROM_Load();
void Gpio_Init();
void Write_Time();
void Config();
void Config_Interrupts();
void LCD_Clear();
void SetUpProgram();
void Timer_Delay_Config();
void SetTimerOn_1();
void SetTimerOff_1();
void SetTimerOn_2();
void SetTimerOff_2();
void SetDS1307_Time();
void SetDS1307Minutes_Program();
void SetDS1307Seconds_Program();
void TimerDelay();
void Read_Battery();
void SetLowBatteryVoltage();
void StoreBytesIntoEEprom();
void ReadBytesFromEEprom();
void SetTimer();
void LowBatteryVoltageAlarm();
unsigned int ReadAC();
void CalculateAC();
void DisplayTimerActivation();
void SetHighVoltage();
void SetLowVoltage();
void VoltageProtector(unsigned long voltage);
void EnableBatteryGuard();
void EnableVoltageGuard();
void SetACVoltageError() ;
void GetVoltageNow();
void ToggleBuzzer();
void Start_Timer();
void Stop_Timer();
void ReadPV_Voltage();
void SetLowPV_Voltage();
void RestoreFactorySettings();
void EEPROM_FactorySettings();
void Start_Timer_2_B();
void Start_Timer_0_A();
void Stop_Timer_0();
void Read_PV_Continues();
void Startup_Timers();
void SetStartUpLoadsVoltage();
void RunTimersNow();
void TurnACLoadsByPassOn();
void RunTimersNowCheck();
void Watch_Dog_Timer_Enable();
void Watch_Dog_Timer_Disable();
void Write_Date();

void Gpio_Init()
{
DDRD.B6=1;
DDRD.B7=1;
DDRD.B2=0;
DDRD.B1=0;
DDRD.B0=0;
DDRD.B3=0;
DDRC.B2=1;
DDRC.B0=0;
}


void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
{
write_Ds1307(0x00,seconds);
write_Ds1307(0x01,minutes);
write_Ds1307(0x02,hours);
}


void Write_Date(unsigned int day, unsigned int month,unsigned int year)
{
write_Ds1307(0x04,day);
Write_Ds1307(0x05,month);
Write_Ds1307(0x06,year);
}

void Config()
{
GPIO_Init();
LCD_CMD(_LCD_CLEAR);
LCD_Init();
LCD_CMD(_LCD_CURSOR_OFF);

Delay_ms(1000);
}


void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
{
 unsigned short Column;
 for(Column=Start; Column<=End; Column++)
 {
 Lcd_Chr(Row,Column,32);
 }
}


void Config_Interrupts()
{
ISC10_bit=1;
ISC11_bit=1;
INT1_bit=1;
SREG_I_bit=1;
}



void Interrupt_INT1 () iv IVT_ADDR_INT1
{
AcBuzzerActiveTimes=0;

if( PIND.B3 ==1 && Timer_isOn==0 )
{


SecondsRealTime=0;
 PORTD.B6 =0;
LCD_Clear(2,7,16);
}

if ( PIND.B3 ==1 && Timer_2_isOn==0)
{


SecondsRealTime=0;
 PORTD.B7 =0;
LCD_Clear(2,7,16);
}
LCD_Init();
LCD_CMD(_LCD_CLEAR);
LCD_CMD(_LCD_CURSOR_OFF);
INTF1_bit=1;
}


void EEPROM_Load()
{

hours_lcd_1=EEPROM_Read(0x00);
minutes_lcd_1=EEPROM_Read(0x01);
hours_lcd_2=EEPROM_Read(0x03);
minutes_lcd_2=EEPROM_Read(0x04);

hours_lcd_timer2_start=EEPROM_Read(0x18);
minutes_lcd_timer2_start=EEPROM_Read(0x19);
hours_lcd_timer2_stop=EEPROM_Read(0x20);
minutes_lcd_timer2_stop=EEPROM_Read(0x21);


ByPassState=0;

Timer_Enable=1;
High_Voltage=EEPROM_Read(0x12);
Low_Voltage=EEPROM_Read(0x13);
VoltageProtectionEnable=EEPROM_Read(0x15);



}


void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
EEprom_Write(address+j,*(ptr+j));
Delay_ms(50);
};
}


void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
*(ptr+j)=EEPROM_Read(address+j);
Delay_ms(50);
}
}


void Check_Timers()
{

matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
matched_timer_2_start=CheckTimeOccuredOn(seconds_lcd_timer2_start,minutes_lcd_timer2_start,hours_lcd_timer2_start);
matched_timer_2_stop=CheckTimeOccuredOff(seconds_lcd_timer2_stop,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);


if (matched_timer_1_start==1)
{
Timer_isOn=1;
TurnOffLoadsByPass=0;



if ( PIND.B3 ==1 && Timer_Enable==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery== 0  )
{
 PORTD.B6 =1;

}

if ( PIND.B3 ==1 && Timer_Enable==1 && RunWithOutBattery== 1  )
{
 PORTD.B6 =1;
}
}


if (matched_timer_1_stop==1)
{
Timer_isOn=0;


if ( PIND.B3 ==1 && Timer_Enable==1 && RunWithOutBattery== 0  )
{

SecondsRealTimePv_ReConnect_T1=0;
 PORTD.B6 =0;

}
if ( PIND.B3 ==1 && Timer_Enable==1 && RunWithOutBattery== 1  )
{

SecondsRealTimePv_ReConnect_T1=0;
 PORTD.B6 =0;
}
}



if (matched_timer_2_start==1)
{
Timer_2_isOn=1;
TurnOffLoadsByPass=0;


if ( PIND.B3 ==1 && Timer_Enable==1 && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery== 0 )
{
 PORTD.B7 =1;

}

if ( PIND.B3 ==1 && Timer_Enable==1 && RunWithOutBattery== 1 )
{
 PORTD.B7 =1;
}

}


if (matched_timer_2_stop==1)
{
Timer_2_isOn=0;


if ( PIND.B3 ==1 && Timer_Enable==1 && RunWithOutBattery== 0  )
{


 PORTD.B7 =0;
SecondsRealTimePv_ReConnect_T2=0;

}

if ( PIND.B3 ==1 && Timer_Enable==1 && RunWithOutBattery== 1  )
{
SecondsRealTimePv_ReConnect_T2=0;
 PORTD.B7 =0;
}

}




if ( PIND.B3 ==0 && ByPassState==0 && VoltageProtectorGood==1 && VoltageProtectionEnable==1 )
{

Delay_ms(300);
SecondsRealTime++;

if(SecondsRealTime >= startupTIme_1 &&  PIND.B3 ==0)
{

 PORTD.B6 =1;

}
if(SecondsRealTime >= startupTIme_2 &&  PIND.B3 ==0)
{
 PORTD.B7 =1;
}

ToggleBuzzer();
}
#line 395 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if( PIND.B3 ==0 && VoltageProtectorGood==0 && VoltageProtectionEnable==1)
{
Start_Timer_0_A();
}

if( PIND.B3 ==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
{
 LCD_CLEAR(2,7,16);
}


if( PIND.B3 ==0 && VoltageProtectionEnable==0 )
{
Delay_ms(300);
SecondsRealTime++;

if(SecondsRealTime >= startupTIme_1 &&  PIND.B3 ==0)
{

 PORTD.B6 =1;

}
if(SecondsRealTime >= startupTIme_2 &&  PIND.B3 ==0)
{

 PORTD.B7 =1;
}
ToggleBuzzer();
}
#line 431 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PIND.B3 ==0 && SecondsRealTime==startupTIme_2)
{
LCD_Init();
LCD_CMD(_LCD_CLEAR);
LCD_CMD(_LCD_CURSOR_OFF);
}
#line 443 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PIND.B3 ==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery== 0  && TurnOffLoadsByPass==0 )
{

SecondsRealTimePv_ReConnect_T1++;
Delay_ms(200);
if ( SecondsRealTimePv_ReConnect_T1 > startupTIme_1)  PORTD.B6 =1;

}
if ( PIND.B3 ==1 && Timer_isOn==1 && RunWithOutBattery== 1  && TurnOffLoadsByPass==0 )
{
SecondsRealTimePv_ReConnect_T1++;
Delay_ms(200);

if ( SecondsRealTimePv_ReConnect_T1 > startupTIme_1)  PORTD.B6 =1;

}

if ( PIND.B3 ==1 && Timer_2_isOn==1 && Vin_Battery >= StartLoadsVoltage_T2 && RunWithOutBattery== 0  && TurnOffLoadsByPass==0)
{
SecondsRealTimePv_ReConnect_T2++;
Delay_ms(50);
if ( SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
 PORTD.B7 =1;
}

if ( PIND.B3 ==1 && Timer_2_isOn==1 && RunWithOutBattery== 1  && TurnOffLoadsByPass==0)
{
SecondsRealTimePv_ReConnect_T2++;
Delay_ms(50);
if ( SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
 PORTD.B7 =1;
}


if (Vin_Battery<Mini_Battery_Voltage &&  PIND.B3 ==1 && Timer_isOn==1 && RunWithOutBattery== 0 )
{
SecondsRealTimePv_ReConnect_T1=0;
Start_Timer_0_A();
}


if (Vin_Battery<Mini_Battery_Voltage_T2 &&  PIND.B3 ==1 && Timer_2_isOn==1 && RunWithOutBattery== 0 )
{
SecondsRealTimePv_ReConnect_T2=0;
Start_Timer_0_A();
}

}


void GetVoltageNow()
{
v=ReadAC();
v=v*5.0/1024.0;
v=255.5*v;
v/=sqrt(2);
}

void ToggleBuzzer()
{
if (AcBuzzerActiveTimes==0)
{
AcBuzzerActiveTimes =1 ;
 PORTC.B2 =1;
Delay_ms(1000);
 PORTC.B2 =0;
}
}
#line 524 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
void SetUpProgram()
{
Delay_ms(100);
if ( PIND.B2 ==0)
{
LCD_CMD(_LCD_CLEAR);
LCD_OUT(1,1,"Setup Program");
Delay_ms(500);


while ( PIND.B2 ==1 )
{

SetTimerOn_1();
if ( PINC.B0 ==1) break;
SetTimerOff_1();
if ( PINC.B0 ==1) break;
SetTimerOn_2();
if( PINC.B0 ==1) break;
SetTimerOff_2();
if ( PINC.B0 ==1) break ;
SetLowBatteryVoltage();
if ( PINC.B0 ==1) break;
SetStartUpLoadsVoltage();
if ( PINC.B0 ==1) break;

if ( PINC.B0 ==1) break;

if ( PINC.B0 ==1) break;
SetDS1307_Time();
if ( PINC.B0 ==1) break;




Startup_Timers();
if( PINC.B0 ==1) break;
break;




LCD_CMD(_LCD_CLEAR);

}
}
}


void SetTimerOn_1()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T1 On: [1]");
Delay_ms(100);
LCD_Clear(2,1,16);
while ( PIND.B2 ==1)
{
#line 585 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_OUT(2,1,"H:");
LCD_Out(2,7,txt);

if ( PINC.B0 ==1)
{
LCD_Clear(2,1,16);
break;
}


while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1 )
{
delay_ms(ButtonDelay);
minutes_lcd_1++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_1--;
}

if (minutes_lcd_1>59) minutes_lcd_1=0;
if (minutes_lcd_1<0) minutes_lcd_1=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
}
}

Delay_ms(500);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_1,txt);

LCD_Out(2,2,txt);
#line 626 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PINC.B0 ==1)
{
LCD_Clear(2,1,16);
break;
}

while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_1++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_1--;
}

if (hours_lcd_1>23) hours_lcd_1=0;
if (hours_lcd_1<0) hours_lcd_1=0;
Timer_isOn=0;
SecondsRealTimePv_ReConnect_T1=0;
}
}

EEPROM_Write(0x00,hours_lcd_1);
EEPROM_Write(0x01,minutes_lcd_1);

}

void SetTimerOff_1()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T1 Off: [2]");
LCD_Clear(2,1,16);
Delay_ms(500);
while ( PIND.B2 ==1)
{
#line 669 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_OUT(2,1,"H:");
LCD_Out(2,7,txt);
if ( PINC.B0 ==1)
{
LCD_Clear(2,1,16);
break;
}

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{

if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_2++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_2--;
}

if(minutes_lcd_2>59) minutes_lcd_2=0;
if (minutes_lcd_2<0) minutes_lcd_2=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
}
}

Delay_ms(500);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_2,txt);

LCD_Out(2,2,txt);
#line 709 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PINC.B0 ==1)
{
LCD_Clear(2,1,16);
break;
}

while( PIND.B0 == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_2++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_2--;
}
if(hours_lcd_2>23) hours_lcd_2=0;
if (hours_lcd_2<0 ) hours_lcd_2=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
}
}
EEPROM_Write(0x03,hours_lcd_2);
EEPROM_Write(0x04,minutes_lcd_2);

}


void SetTimerOn_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 On: [3]");
Delay_ms(100);
LCD_Clear(2,1,16);
while ( PIND.B2 ==1)
{
#line 751 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_OUT(2,1,"H:");
LCD_Out(2,7,txt);

if ( PINC.B0 ==1)
{
LCD_Clear(2,1,16);
break;
}


while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1 )
{
delay_ms(ButtonDelay);
minutes_lcd_timer2_start++;
}
if ( PIND.B1 ==1 )
{
delay_ms(ButtonDelay);
minutes_lcd_timer2_start--;
}

if (minutes_lcd_timer2_start>59) minutes_lcd_timer2_start=0;
if (minutes_lcd_timer2_start<0) minutes_lcd_timer2_start=0;
Timer_2_isOn=0;
SecondsRealTimePv_ReConnect_T2=0;

}
}

Delay_ms(500);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer2_start,txt);

LCD_Out(2,2,txt);
#line 794 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PINC.B0 ==1)
{
break;
}

while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_timer2_start++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_timer2_start--;
}

if (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
if (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
Timer_2_isOn=0;
SecondsRealTimePv_ReConnect_T2=0;

}
}

EEPROM_Write(0x18,hours_lcd_timer2_start);
EEPROM_Write(0x19,minutes_lcd_timer2_start);

}

void SetTimerOff_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 Off: [4]");
LCD_Clear(2,1,16);
Delay_ms(500);
while ( PIND.B2 ==1)
{
#line 837 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_OUT(2,1,"H:");
LCD_Out(2,7,txt);
if ( PINC.B0 ==1) break;

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_timer2_stop++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_timer2_stop--;
}

if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;
Timer_2_isOn=0;
SecondsRealTimePv_ReConnect_T2=0;

}
}

Delay_ms(500);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);

LCD_Out(2,2,txt);
#line 874 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PINC.B0 ==1)
{
LCD_Clear(2,1,16);
break;
}

while( PIND.B0 == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_timer2_stop++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_timer2_stop--;
}
if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
Timer_2_isOn=0;
SecondsRealTimePv_ReConnect_T2=0;

}
}
EEPROM_Write(0x20,hours_lcd_timer2_stop);
EEPROM_Write(0x21,minutes_lcd_timer2_stop);

}



void SetDS1307_Time()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time [9]");
Delay_ms(500);
set_ds1307_minutes=ReadMinutes();
set_ds1307_hours=ReadHours();

while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
#line 927 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if ( PINC.B0 ==1) break;
while ( PIND.B0 ==1 ||  PIND.B1 ==1 )
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours++;

}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours--;
}
if(set_ds1307_hours>23) set_ds1307_hours=0;
if (set_ds1307_hours<0) set_ds1307_hours=0;
}
}

Delay_ms(500);
LCD_Clear(1,1,16);

Delay_ms(500);
while ( PIND.B2 ==1)
{
#line 957 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( PINC.B0 ==1) break;
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes++;
}

if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes--;
}
if(set_ds1307_minutes>59) set_ds1307_minutes=0;
if(set_ds1307_minutes<0) set_ds1307_minutes=0;
}
}

Delay_ms(500);
LCD_Clear(1,1,16);


while ( PIND.B2 ==1)
{
#line 988 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
if ( PINC.B0 ==1) break;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds--;
}
if (set_ds1307_seconds>59) set_ds1307_seconds=0;
if (set_ds1307_seconds<0) set_ds1307_seconds=0;


Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours));
}
}

Delay_ms(500);
LCD_Clear(1,1,16);
LCD_CLear(2,1,16);


set_ds1307_day=ReadDate(0x04);

while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_day,txt);
LCD_OUT(2,1,"D:");
LCD_OUT(2,6,"M:");
LCD_OUT(2,12,"Y:");
LCD_Out(2,3,txt);
if ( PINC.B0 ==1) break;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_day++;
}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_day--;
}
if (set_ds1307_day>31) set_ds1307_day=0;
if (set_ds1307_day<0) set_ds1307_day=0;
}
}

Delay_ms(500);
LCD_Clear(1,1,16);


set_ds1307_month=ReadDate(0x05);
while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_month,txt);
LCD_Out(2,8,txt);
if ( PINC.B0 ==1) break;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_month++;

}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_month--;
}
if (set_ds1307_month>12) set_ds1307_month=0;
if (set_ds1307_month<0) set_ds1307_month=0;
}
}

Delay_ms(500);
LCD_Clear(1,1,16);


set_ds1307_year=ReadDate(0x06);

while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_year,txt);
LCD_Out(2,14,txt);
if ( PINC.B0 ==1) break;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_year++;

}
if ( PIND.B1 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_year--;
}
if (set_ds1307_year>99) set_ds1307_year=0;
if (set_ds1307_year<0) set_ds1307_year=0;

}
Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year));
}
}
#line 1195 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
void SetLowBatteryVoltage()
{
LCD_OUT(1,1,"Low Battery  [5]");
Delay_ms(500);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
LCD_OUT(2,1,"T1");
sprintf(txt,"%4.1fV",Mini_Battery_Voltage);
LCD_OUT(2,4,txt);

if ( PINC.B0 ==1) break;
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage+=0.1;

}
if ( PIND.B1 ==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage-=0.1;
}
if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
}
}
StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);

Delay_ms(500);
while( PIND.B2 ==1)
{
LCD_OUT(2,1,"T2");
sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);
LCD_OUT(2,4,txt);

if ( PINC.B0 ==1) break;
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage_T2+=0.1;

}
if ( PIND.B1 ==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage_T2-=0.1;
}
if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
}
}

StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
LCD_CMD(_LCD_CLEAR);
}

void SetStartUpLoadsVoltage()
{
LCD_OUT(1,1,"Start Loads V[6]");
Delay_ms(500);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
LCD_OUT(2,1,"T1");
sprintf(txt,"%4.1fV",StartLoadsVoltage);
LCD_OUT(2,4,txt);

if ( PINC.B0 ==1) break;
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage+=0.1;

}
if ( PIND.B1 ==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage-=0.1;
}
if (StartLoadsVoltage>65) StartLoadsVoltage=0;
if (StartLoadsVoltage<0) StartLoadsVoltage=0;
}
}

StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
Delay_ms(500);

while( PIND.B2 ==1)
{
LCD_OUT(2,1,"T2");
sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);
LCD_OUT(2,4,txt);

if ( PINC.B0 ==1) break;
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{



if ( PIND.B0 ==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage_T2+=0.1;

}
if ( PIND.B1 ==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage_T2-=0.1;
}
if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
}
}

StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);

LCD_CMD(_LCD_CLEAR);
}

void SetHighVoltage()
{
LCD_OUT(1,1,"High AC Volt [7]");
Delay_ms(500);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
if ( PINC.B0 ==1) break;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
if ( PIND.B0 ==1)
{
Delay_ms(ButtonDelay);
High_Voltage++;
}
if( PIND.B1 ==1)
{
Delay_ms(ButtonDelay);
High_Voltage--;
}
 if(High_Voltage > 255 ) High_Voltage=0;
 if (High_Voltage < 0 ) High_Voltage=0;
}
}
EEPROM_Write(0x12,High_Voltage);
LCD_CMD(_LCD_CLEAR);
}

void SetLowVoltage()
{
LCD_OUT(1,1,"Low AC Volt [8]");
Delay_ms(500);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
if ( PINC.B0 ==1) break;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
if ( PIND.B0 ==1)
{
Delay_ms(ButtonDelay);
Low_Voltage++;
}
if( PIND.B1 ==1)
{
Delay_ms(ButtonDelay);
Low_Voltage--;
}
 if(Low_Voltage > 255 ) Low_Voltage=0;
 if (Low_Voltage < 0 ) Low_Voltage=0;
}
}
LCD_Clear(1,1,16);
EEPROM_Write(0x13,Low_Voltage);
LCD_CMD(_LCD_CLEAR);
}



void Startup_Timers()
{
LCD_OUT(1,1,"Start Loads [15]");
Delay_ms(500);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
IntToStr(startupTIme_1,txt);
LCD_OUT(2,1,"T1");

LCD_OUT(2,5,txt);
if( PINC.B0 ==1) break ;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if( PIND.B0 ==1)
{

Delay_ms(100);
startupTIme_1++;
}
if( PIND.B1 ==1)
{

Delay_ms(100);
startupTIme_1--;
}
if(startupTIme_1 > 600 ) startupTIme_1=0;
if (startupTIme_1<0) startupTIme_1=0;
}
}
StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);

Delay_ms(500);
while ( PIND.B2 ==1)
{
IntToStr(startupTIme_2,txt);
LCD_OUT(2,1,"T2");

LCD_OUT(2,5,txt);
if( PINC.B0 ==1) break ;
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if( PIND.B0 ==1)
{

Delay_ms(100);
startupTIme_2++;
}
if( PIND.B1 ==1)
{

Delay_ms(100);
startupTIme_2--;
}
if(startupTIme_2 > 600 ) startupTIme_2=0;
if (startupTIme_2<0) startupTIme_2=0;
}
}


StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
LCD_CMD(_LCD_CLEAR);


}
#line 1481 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
void Screen_1()
{


Read_Time();
Read_Battery();
CalculateAC();
}

void ADCBattery()
{
ADC_Init();
ADC_Init_Advanced(_ADC_EXTERNAL_REF);
ADPS2_Bit=1;
ADPS1_Bit=1;
ADPS0_Bit=0;
}

void Read_Battery()
{
float sum=0 , Battery[10];
char i=0;
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value *5.0)/1024.0;



for ( i=0; i<10 ; i++)
{
Battery[i]=((10.5/0.5)*Battery_Voltage);
delay_ms(50);
sum+=Battery[i];
}
Vin_Battery= sum/10.0 ;
LCD_OUT(2,1,"V=");
sprintf(txt,"%4.1f",Vin_Battery);
LCD_OUT(2,3,txt);

}


void LowBatteryVoltageAlarm()
{
if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery== 0  && (Timer_isOn==1 || Timer_2_isOn==1) )
{
 PORTC.B2 =1;
Delay_ms(500);
 PORTC.B2 =0;
Delay_ms(500);
}
}

unsigned int ReadAC()
{
char numberOfSamples=100;
char numberOfAverage=10;
unsigned long sum=0;
unsigned long r=0;
unsigned long max_v=0;
char i=0;
char j=0;
unsigned long average=0;

for (i=0;i<100;i++)
{
r=ADC_Read(3);
if (max_v<r) max_v=r;
delay_us(200);
}
return max_v;
#line 1564 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
}

void CalculateAC()
{
char buf[15];
v=ReadAC();
v=v*5.0/1024.0;
v=255.5*v;
v/=sqrt(2);
v=v+Error_Voltage;

if ( PIND.B3 ==0 && VoltageProtectionEnable==1)
{
sprintf(buf,"%4.0fV",v);
LCD_OUT(2,8,"-");
LCD_OUT(2,9,buf);
}
else if ( PIND.B3 == 0 && VoltageProtectionEnable==0)
{
LCD_out(2,8,"- Grid");
}
VoltageProtector(v);
}



void VoltageProtector(unsigned long voltage)
{

if ((voltage < Low_Voltage || voltage> High_Voltage )&&  PIND.B3 ==0 )
{
VoltageProtectorGood=0;
}

if ((voltage>Low_Voltage && voltage < High_Voltage) &&  PIND.B3 ==0)
{
VoltageProtectorGood=1;
}
}

void ErrorList()
 {
#line 1617 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
 }


void Start_Timer_0_A()
{
WGM00_bit=0;
WGM01_bit=0;
WGM02_bit=0;
CS00_bit=1;
CS02_bit=1;
SREG_I_Bit=1;
OCR0A=0xFF;
OCIE0A_Bit=1;
}

void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
{
SREG_I_Bit=0;
Timer_Counter_3++;
Timer_Counter_4++;
Timer_Counter_For_Grid_Turn_Off++;


if (Timer_Counter_3==500)
{

if(Vin_Battery<Mini_Battery_Voltage &&  PIND.B3 ==1)
{
SecondsRealTime=0;
Delay_ms(500);
 PORTD.B6 =0;
LCD_CLEAR(2,7,16);
}
Timer_Counter_3=0;
Stop_Timer_0();
}


if (Timer_Counter_4==500)
{

if(Vin_Battery<Mini_Battery_Voltage_T2 &&  PIND.B3 ==1)
{
SecondsRealTime=0;
Delay_ms(500);
 PORTD.B7 =0;
LCD_CLEAR(2,7,16);
}
Timer_Counter_4=0;
Stop_Timer_0();
}



if (Timer_Counter_For_Grid_Turn_Off==1000)
{
if(VoltageProtectorGood==0 &&  PIND.B3 ==0)
{
SecondsRealTime=0;
 PORTD.B6 =0;
 PORTD.B7 =0;
LCD_CLEAR(2,7,16);
}
Timer_Counter_For_Grid_Turn_Off=0;
Stop_Timer_0();
}

SREG_I_Bit=1;
OCF0A_Bit=1;
}

void Stop_Timer_0()
{
CS00_bit=0;
CS01_bit=0;
CS02_bit=0;
}


void EEPROM_FactorySettings(char period)
{
if(period==1)
{
Mini_Battery_Voltage=24.5,
StartLoadsVoltage=26.5,
startupTIme_1 =180,
startupTIme_2=240,
Mini_Battery_Voltage_T2=25.5,
StartLoadsVoltage_T2=27.5;

EEPROM_Write(0x00,8);
EEPROM_Write(0x01,0);
EEPROM_Write(0x03,17);
EEPROM_Write(0x04,0);

EEPROM_Write(0x18,9);
EEPROM_Write(0x19,0);
EEPROM_Write(0x20,17);
EEPROM_Write(0x21,0);

StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);
StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
}
if (period==0)
{
Mini_Battery_Voltage=24.5,
StartLoadsVoltage=26.5,
startupTIme_1 =180,
startupTIme_2=240,
Mini_Battery_Voltage_T2=25.5,
StartLoadsVoltage_T2=27.5;

EEPROM_Write(0x00,9);
EEPROM_Write(0x01,0);
EEPROM_Write(0x03,15);
EEPROM_Write(0x04,0);

EEPROM_Write(0x18,9);
EEPROM_Write(0x19,30);
EEPROM_Write(0x20,15);
EEPROM_Write(0x21,0);

StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);
StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
}

EEPROM_Write(0x12,255);
EEPROM_Write(0x13,170);
EEPROM_Write(0x49,0);
EEPROM_Write(0x50,0);
EEPROM_Write(0x15,0);
}

RunTimersNowCheck()
{
#line 1778 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if( PIND.B0 ==1 &&  PINC.B0 ==0)
{
Delay_ms(5000);
if ( PIND.B0 ==1 &&  PINC.B0 ==0)
{
RunLoadsByBass++;
if ( RunLoadsByBass==1 )  PORTD.B6 =1;
if (RunLoadsByBass>=2 )
{
Delay_ms(5000);
 PORTD.B7 =1;
}
LCD_OUT(1,15,"B");
}
}

if ( PIND.B0 ==1 &&  PINC.B0 ==1 &&  PIND.B1 ==0)
{
Delay_ms(2000);
if (  PIND.B0 ==1 &&  PINC.B0 ==1 &&  PIND.B1 ==0)
{
Delay_ms(5000);
EEPROM_FactorySettings(1);
Delay_ms(100);
EEPROM_Load();
LCD_OUT(2,1,"Reset Summer    ");
Delay_ms(1000);
LCD_CLEAR(2,1,16);
}
}
if ( PIND.B0 ==0 &&  PINC.B0 ==1 &&  PIND.B1 ==1)
{
Delay_ms(2000);
if (  PIND.B0 ==0 &&  PINC.B0 ==1 &&  PIND.B1 ==1)
{
Delay_ms(5000);
EEPROM_FactorySettings(0);
Delay_ms(100);
EEPROM_Load();
LCD_OUT(2,1,"Reset Winter    ");
Delay_ms(1000);
LCD_CLEAR(2,1,16);
}
}
#line 1841 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if( PIND.B1 ==1 &&  PINC.B0 ==0)
{
Delay_ms(2000);
if ( PIND.B1 ==1 &&  PINC.B0 ==0)
{
TurnOffLoadsByPass=1;
RunLoadsByBass=0;
 PORTD.B6 =0;
 PORTD.B7 =0;

LCD_OUT(1,16," ");
}
}
}


void CheckForSet()
{

if ( PIND.B2 ==0 &&  PINC.B0 ==0) SetUpProgram();

}


void AutoRunWithOutBatteryProtection()
{
if (Vin_Battery==0)
{
RunWithOutBattery= 1 ;
}
else
{
RunWithOutBattery= 0 ;
}
}

void CheckForTimerActivationInRange()
{


if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 )
{
Timer_isOn=1;

}


if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
{

if(ReadMinutes() < minutes_lcd_2)
{
Timer_isOn=1;

}
}
#line 1923 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
{
Timer_2_isOn=1;

}

if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
{
if(ReadMinutes()<minutes_lcd_timer2_stop)
{
Timer_2_isOn=1;

}
}
#line 1961 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Control V1.0/MikroC/Solar_Auto_Switcher.c"
}


void TurnLoadsOffWhenGridOff()
{

if( PIND.B3 ==1 && Timer_isOn==0 && RunLoadsByBass==0 )
{
SecondsRealTime=0;
 PORTD.B6 =0;
AcBuzzerActiveTimes=0;
LCD_Clear(2,7,16);
}

if ( PIND.B3 ==1 && Timer_2_isOn==0 && RunLoadsByBass==0)
{
SecondsRealTime=0;
 PORTD.B7 =0;
AcBuzzerActiveTimes=0;
LCD_Clear(2,7,16);
}

}

CheckForVoltageProtection()
{
if (VoltageProtectionEnable==1) LCD_OUT(1,16,"P"); else LCD_OUT(1,16," ") ;
if( PINC.B0 ==1 &&  PIND.B2 ==0 )
{
delay_ms(2000);
if( PINC.B0 ==1 &&  PIND.B2 ==0 ) {
if (VoltageProtectorEnableFlag==1)
{
VoltageProtectionEnable=0;
VoltageProtectorEnableFlag=0;
EEPROM_Write(0x15,0);
}
else if ( VoltageProtectorEnableFlag==0)
{
VoltageProtectionEnable=1;
VoltageProtectorEnableFlag=1;
EEPROM_Write(0x15,1);
}
}
}

}

void main() {
Config();
ADCBattery();
EEPROM_Load();
TWI_Config();
Config_Interrupts();
ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);
ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
while(1)
{
CheckForSet();
CheckForTimerActivationInRange();
AutoRunWithOutBatteryProtection();
RunTimersNowCheck();
CheckForVoltageProtection();
Screen_1();
Check_Timers();
TurnLoadsOffWhenGridOff();


Delay_ms(50);
}
}
