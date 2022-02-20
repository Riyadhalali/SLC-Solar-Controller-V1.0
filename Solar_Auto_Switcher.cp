#line 1 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Auto Switcher/MikroC/Solar_Auto_Switcher.c"
#line 1 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar auto switcher/mikroc/ds1307.h"
#line 1 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar auto switcher/mikroc/ds1307.h"
#line 7 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar auto switcher/mikroc/ds1307.h"
void write_Ds1307(unsigned short Address, unsigned short w_data);
unsigned short Read_DS1307(unsigned short Address);
void Read_time();
void TWI_Config();
char CheckTimeOccuredOn(char seconds_required, char minutes_required, char hours_required);
char CheckTimeOccuredOff(char seconds_required, char minutes_required, char hours_required);
char CorrectionLoad();
#line 52 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Auto Switcher/MikroC/Solar_Auto_Switcher.c"
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
char txt[10];
char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char hours_lcd_timer2_start=0,hours_lcd_timer2_stop=0;
char minutes_lcd_timer2_start=0,minutes_lcd_timer2_stop=0;
char hours_lcd_timer3_start=0,hours_lcd_timer3_stop=0;
char minutes_lcd_timer3_start=0,minutes_lcd_timer3_stop=0;
char Relay_State;
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0;
char ByPassState=0;
float Battery_Voltage;
char BatteryVoltageSystem=0;
unsigned int ADC_Value;
float Vin_Battery;
float Mini_Battery_Voltage=12.0;
char outBuff[21];
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
void SetTimerOn_3();
void SetTimerOff_3();
void SetDS1307Hours_Program();
void SetDS1307Minutes_Program();
void SetDS1307Seconds_Program();
void AC_Available_ByPass_System();
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

void Gpio_Init()
{
DDRD.B4=1;
DDRD.B5=1;
DDRD.B6=1;
DDRD.B7=1;
DDRD.B0=1;
DDRD.B2=0;
DDRD.B1=0;
DDRD.B0=0;
DDRD.B3=0;
DDRC.B2=1;
DDRC.B0=1;
}


void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
{
write_Ds1307(0x00,seconds);
write_Ds1307(0x01,minutes);
write_Ds1307(0x02,hours);
}

void Config()
{
GPIO_Init();
LCD_Init();
LCD_CMD(_LCD_CURSOR_OFF);
LCD_CMD(_LCD_CLEAR);
LCD_OUT(1,1,"Starting ... ");
Delay_ms(2000);

}

void Config_Interrupts()
{
ISC01_bit=0;
ISC00_bit=0;
INT0_bit=1;
SREG_I_bit=1;
}

void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
{
 unsigned short Column;
 for(Column=Start; Column<=End; Column++)
 {
 Lcd_Chr(Row,Column,32);
 }
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

hours_lcd_timer3_start=EEPROM_Read(0x22);
minutes_lcd_timer3_start=EEPROM_Read(0x23);
hours_lcd_timer3_stop=EEPROM_Read(0x24);
minutes_lcd_timer3_stop=EEPROM_Read(0x25);

ByPassState=EEPROM_Read(0x06);
Timer_Enable=EEPROM_Read(0x011);
High_Voltage=EEPROM_Read(0x12);
Low_Voltage=EEPROM_Read(0x13);

VoltageProtectionEnable=EEPROM_Read(0x15);
Error_Voltage=EEPROM_Read(0x16);
Adjusted_Voltage=EEPROM_Read(0x17);

if (hours_lcd_1== 0xff ) EEPROM_Write(0x00,0x0A);
if(minutes_lcd_1==0xFF) EEPROM_Write(0x01,0x00);
if(hours_lcd_2==0xFF) EEPROM_Write(0x03,0x0E);
if(minutes_lcd_2==0xFF) EEPROM_Write(0x04,0x00);
if(ByPassState==0xFF) EEPROM_Write(0x06,0x01) ;
if(Timer_Enable==0xFF) EEPROM_Write(0x11,0x01);
if(High_Voltage==0xFF) EEPROM_Write(0x12,0xF5);
if(Low_Voltage==0xFF) EEPROM_Write(0x13,0xAA);

if(VoltageProtectionEnable==0xFF) EEPROM_Write(0x15,0x01);
if(Error_Voltage==0xFF) EEPROM_Write(0x16,0x00);
if(Adjusted_Voltage==0xFF) EEPROM_Write(0x17,0x00);
if(hours_lcd_timer2_start==0xFF) EEPROM_Write(0x18,0x0A);
if(minutes_lcd_timer2_start==0xFF) EEPROM_Read(0x00);
if(hours_lcd_timer2_stop==0xFF) EEPROM_Write(0x20,0x0E);
if(minutes_lcd_timer2_stop==0xFF) EEPROM_Write(0x21,0x00);
if(hours_lcd_timer3_start==0xFF) EEPROM_Write(0x22,0x0A);
if(minutes_lcd_timer3_start==0xFF) EEPROM_Write(0x23,0X00);
if(hours_lcd_timer3_stop==0xFF) EEPROM_Write(0x24,0x0E);
if(minutes_lcd_timer3_stop==0xFF) EEPROM_Write(0x25,0x00);

hours_lcd_1=EEPROM_Read(0x00);
minutes_lcd_1=EEPROM_Read(0x01);

hours_lcd_2=EEPROM_Read(0x03);
minutes_lcd_2=EEPROM_Read(0x04);

ByPassState=EEPROM_Read(0x06);
Timer_Enable=EEPROM_Read(0x011);
High_Voltage=EEPROM_Read(0x12);
Low_Voltage=EEPROM_Read(0x13);

VoltageProtectionEnable=EEPROM_Read(0x15);
Error_Voltage=EEPROM_Read(0x16);
Adjusted_Voltage=EEPROM_Read(0x17);
hours_lcd_timer2_start=EEPROM_Read(0x18);
minutes_lcd_timer2_start=EEPROM_Read(0x19);
hours_lcd_timer2_stop=EEPROM_Read(0x20);
minutes_lcd_timer2_stop=EEPROM_Read(0x21);
hours_lcd_timer3_start=EEPROM_Read(0x22);
minutes_lcd_timer3_start=EEPROM_Read(0x23);
hours_lcd_timer3_stop=EEPROM_Read(0x24);
minutes_lcd_timer3_stop=EEPROM_Read(0x25);
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
char matched_timer_1_start,matched_timer_1_stop;
char matched_timer_2_start,matched_timer_2_stop;
char matched_timer_3_start,matched_timer_3_stop;

matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
matched_timer_2_start=CheckTimeOccuredOn(0x00,minutes_lcd_timer2_start,hours_lcd_timer2_start);
matched_timer_2_stop=CheckTimeOccuredOff(0x00,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
matched_timer_3_start=CheckTimeOccuredOn(0x00,minutes_lcd_timer3_start,hours_lcd_timer3_start);
matched_timer_3_stop=CheckTimeOccuredOff(0x00,minutes_lcd_timer3_stop,hours_lcd_timer3_stop);



if ( PIND.B3 ==1 && Timer_Enable==1 )
{

if (matched_timer_1_start==1)
{

 PORTD.B4 =1;
LCD_OUT(1,16,"1");
}

if (matched_timer_1_stop==1)
{

 PORTD.B4 =0;
LCD_OUT(1,16," ");
}
}


if ( PIND.B3 ==1 && Timer_2_Enable==1 )
{

if (matched_timer_2_start==1)
{

 PORTD.B5 =1;
LCD_OUT(1,16,"2");
}

if (matched_timer_2_stop==1)
{

 PORTD.B5 =0;
LCD_OUT(1,16," ");
}
}

 if ( PIND.B3 ==1 && Timer_3_Enable==1 )
{

if (matched_timer_3_start==1)
{

 PORTD.B6 =1;
LCD_OUT(1,16,"3");
}

if (matched_timer_3_stop==1)
{

 PORTD.B6 =0;
LCD_OUT(1,16," ");
}
}

if((matched_timer_1_start==1 || matched_timer_2_start==1 || matched_timer_3_start==1) && ( PIND.B3 ==1 && Timer_Enable==1) )
{

 PORTD.B7 =1;
}

if (( PORTD.B4 ==0 &&  PORTD.B5 ==0 &&  PORTD.B6 ==0 ) && ( PIND.B3 ==1 && Timer_Enable==1) )
{
 PORTD.B7 =0;
}




if(VoltageProtectionEnable==1)
{
if(VoltageProtectorGood==1)
{
if ( PIND.B3 ==0 && ByPassState==0 )
{
 PORTD.B4 =0;
 PORTD.B5 =0;
 PORTD.B6 =0 ;
 PORTD.B7 =0;
 PORTC.B0 =1;
LCD_OUT(2,16,"G");
ToggleBuzzer();
}
if( PIND.B3 ==0 && ByPassState==1 )
{
 PORTD.B4 =1;
 PORTD.B5 =1;
 PORTD.B6 =1 ;
 PORTC.B0 =0;
 PORTD.B7 =1;
LCD_OUT(2,15,"~G");
}
}
}


if (VoltageProtectionEnable==0)
{
if ( PIND.B3 ==0 && ByPassState==0 )
{
 PORTD.B4 =0;
 PORTD.B5 =0 ;
 PORTD.B6 =0;
 PORTD.B7 =0;
 PORTC.B0 =1;
LCD_OUT(2,16,"G");
}
}

if( PIND.B3 ==1)
{
AcBuzzerActiveTimes=0;
LCD_OUT(2,15,"  ");
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
 PORTC.B2 =1;
Delay_ms(1000);
 PORTC.B2 =0;
AcBuzzerActiveTimes =1 ;
}
}

void Interrupt_Routine () iv IVT_ADDR_INT0
{

Delay_ms(100);
INTF0_bit=1;
GetVoltageNow();
Saved_Voltage=v;
if ( PIND.B2 ==0)
SetUpProgram();
LCD_Clear(1,1,16);
INTF0_bit=1;
}


void SetUpProgram()
{
Delay_ms(100);
LCD_CMD(_LCD_CLEAR);

TimerDelay();
}

void Timer_Delay_Config()
{
WGM10_bit=0;
WGM11_bit=0;
WGM12_bit=1;
WGM13_bit=0;
CS10_bit=1;
CS11_bit=0;
CS12_bit=1;
OCIE1A_bit=1;
SREG_I_bit=1;
OCR1AL=0xFF;
OCR1AH=0xFF;
}


void TimerDelay()
{
INTF0_bit=1;
if ( PIND.B2 ==0)
{
LCD_CMD(_LCD_CLEAR);
LCD_OUT(1,1,"Setup Program");
Delay_ms(1000);


while ( PIND.B2 ==1)
{

SetTimerOn_1();
SetTimerOff_1();
SetTimerOn_2();
SetTimerOff_2();
SetTimerOn_3();
SetTimerOff_3();
SetDS1307Hours_Program();
SetDS1307Minutes_Program();
SetDS1307Seconds_Program();
AC_Available_ByPass_System();
SetLowBatteryVoltage();
SetTimer();
SetHighVoltage();
SetLowVoltage();

EnableVoltageGuard();

}
}


else
{

CS10_bit=0;
CS11_bit=0;
CS12_bit=0;
}
}


void SetTimerOn_1()
{

LCD_OUT(1,1,"T1 On: [1]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_1 >=59 || minutes_lcd_1<=0 ) {minutes_lcd_1=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
minutes_lcd_1++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
minutes_lcd_1--;
}
}
}

Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_1 >=24 || hours_lcd_1 <=0) {hours_lcd_1=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
hours_lcd_1++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
hours_lcd_1--;
}
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
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_2 >=59 ||minutes_lcd_2<=0 ) {minutes_lcd_2=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
minutes_lcd_2++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
minutes_lcd_2--;
}
}
}

Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while( PIND.B0 == 1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_2 >=24 || hours_lcd_2<=0) {hours_lcd_2=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
hours_lcd_2++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
hours_lcd_2--;
}
}
}
EEPROM_Write(0x03,hours_lcd_2);
EEPROM_Write(0x04,minutes_lcd_2);
}

void SetTimerOn_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 On: [3]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer2_start >=59 ||minutes_lcd_timer2_start<=0 ) {minutes_lcd_timer2_start=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
minutes_lcd_timer2_start++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
minutes_lcd_timer2_start--;
}
}
}

Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer2_start >=24 || hours_lcd_timer2_start<=0 ) {hours_lcd_timer2_start=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
hours_lcd_timer2_start++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
hours_lcd_timer2_start--;
}
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
Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{

ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer2_stop >=59 || minutes_lcd_timer2_stop<=0 ) {minutes_lcd_timer2_stop=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
minutes_lcd_timer2_stop++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
minutes_lcd_timer2_stop--;
}
}
}

Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer2_stop >=24 ||hours_lcd_timer2_stop<=0 ) {hours_lcd_timer2_stop=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
hours_lcd_timer2_stop++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
hours_lcd_timer2_stop--;
}
}
}
EEPROM_Write(0x20,hours_lcd_timer2_stop);
EEPROM_Write(0x21,minutes_lcd_timer2_stop);
}

void SetTimerOn_3()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T3 On: [5]");
LCD_Clear(2,1,16);
Delay_ms(1000);
while( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
while( PIND.B0 ==1 ||  PIND.B1 ==1 )
{

ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer3_start >=60 || minutes_lcd_timer3_start <=0 ) {minutes_lcd_timer3_start=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
minutes_lcd_timer3_start++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
minutes_lcd_timer3_start--;
}
}
}


Delay_ms(1000);
while( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
while( PIND.B0 ==1 ||  PIND.B1 ==1 )
{
ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer3_start >=24 || hours_lcd_timer3_start <=0 ) {hours_lcd_timer3_start=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
hours_lcd_timer3_start++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
hours_lcd_timer3_start--;
}
}
}
EEPROM_Write(0x22,hours_lcd_timer3_start);
EEPROM_Write(0x23,minutes_lcd_timer3_start);
}

void SetTimerOff_3()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T3 Off: [6]");
LCD_Clear(2,1,16);
Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{

ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer3_stop >=59 || minutes_lcd_timer3_stop<=0 ) {minutes_lcd_timer3_stop=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
minutes_lcd_timer3_stop++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
minutes_lcd_timer3_stop--;
}
}
}


Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{

ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer3_stop >=23 || hours_lcd_timer3_stop<=0 ) {hours_lcd_timer3_stop=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
hours_lcd_timer3_stop++;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
hours_lcd_timer3_stop--;
}
}
}

EEPROM_Write(0x25,minutes_lcd_timer3_stop);
EEPROM_Write(0x24,hours_lcd_timer3_stop);
}

void SetDS1307Hours_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[H] [7]");
Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
while ( PIND.B0 ==1 ||  PIND.B1 ==1 )
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
if ( set_ds1307_hours >=23 ) {set_ds1307_hours=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
set_ds1307_hours++;

}
if ( PIND.B1 ==1)
{
delay_ms(200);
set_ds1307_hours--;
}
}
}
}

void SetDS1307Minutes_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[M] [8]");
Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
if ( set_ds1307_minutes >59 ) {set_ds1307_minutes=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
set_ds1307_minutes++;

}
if ( PIND.B1 ==1)
{
delay_ms(200);
set_ds1307_minutes--;
}
}
}
}

void SetDS1307Seconds_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[S] [9]");
Delay_ms(1000);
while ( PIND.B2 ==1)
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
ByteToStr(set_ds1307_hours,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
if ( set_ds1307_seconds >59 ) {set_ds1307_seconds=0;}
if ( PIND.B0 ==1)
{
delay_ms(200);
set_ds1307_seconds++;

}
if ( PIND.B1 ==1)
{
delay_ms(200);
set_ds1307_seconds--;
}


Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours));
}
}
}

void AC_Available_ByPass_System()
{

LCD_OUT(1,1,"ByPass Grid: [10]");
Delay_ms(1000);
LCD_Clear(2,1,16);


if (ByPassState==0) LCD_OUT(2,1,"Enabled"); else LCD_OUT(2,1,"Disabled");
while ( PIND.B2 ==1)
{
if (ByPassState==0) LCD_OUT(2,1,"Enabled"); else LCD_OUT(2,1,"Disabled");

while ( PIND.B0  == 1 ||  PIND.B1 ==1)
{
if ( PIND.B0 ==1) ByPassState=1;
if ( PIND.B1 ==1) ByPassState=0;

}
}
EEPROM_Write(0x06,ByPassState);
LCD_CMD(_LCD_CLEAR);
}

void SetLowBatteryVoltage()
{
LCD_OUT(1,1,"Low Battery: [11]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
sprintf(txt,"%4.1f",Mini_Battery_Voltage);
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
sprintf(txt,"%4.1f",Mini_Battery_Voltage);
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");
if(Mini_Battery_Voltage> 65 ) Mini_Battery_Voltage=0.0;

if ( PIND.B0 ==1)
{
Delay_ms(200);
Mini_Battery_Voltage+=0.1;

}
if ( PIND.B1 ==1)
{
Delay_ms(200);
Mini_Battery_Voltage-=0.1;
}
}
}
Delay_ms(1000);
StoreBytesIntoEEprom(0x07,(unsigned short *)&Mini_Battery_Voltage,4);
LCD_CMD(_LCD_CLEAR);
}

void SetTimer()
{
LCD_OUT(1,1,"Timer State:[12]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while ( PIND.B2 ==1)
{
LCD_OUT(1,1,"Timer : [10]");
if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled");}
while( PIND.B0  == 1 ||  PIND.B1  == 1 )
{


if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled");}
if ( PIND.B0 ==1)
{
delay_ms(200);
Timer_Enable=1;
}
if ( PIND.B1 ==1)
{
delay_ms(200);
Timer_Enable=0;
}
}
}
EEPROM_Write(0x11,Timer_Enable);
LCD_CMD(_LCD_CLEAR);
}

void SetHighVoltage()
{
LCD_OUT(1,1,"High Volt: [13]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
if ( PIND.B0 ==1)
{
Delay_ms(200);
High_Voltage++;
}
if( PIND.B1 ==1)
{
Delay_ms(200);
High_Voltage--;
}
}
}
EEPROM_Write(0x12,High_Voltage);
}

void SetLowVoltage()
{
LCD_OUT(1,1,"Low Volt: [14]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
if ( PIND.B0 ==1)
{
Delay_ms(200);
Low_Voltage++;
}
if( PIND.B1 ==1)
{
Delay_ms(200);
Low_Voltage--;
}
}
}
LCD_Clear(1,1,16);
EEPROM_Write(0x13,Low_Voltage);
}

void EnableBatteryGuard()
{
LCD_OUT(1,1,"Batt Guard:[15]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
if(BatteryGuardEnable==1) LCD_OUT(2,1,"Enabled"); if(BatteryGuardEnable==0) LCD_OUT(2,1,"Disabled");
while( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if(BatteryGuardEnable==1) LCD_OUT(2,1,"Enabled"); if(BatteryGuardEnable==0) LCD_OUT(2,1,"Disabled");
if ( PIND.B0 ==1)
{
Delay_ms(200);
BatteryGuardEnable=1;
}
if( PIND.B1 ==1)
{
Delay_ms(200);
BatteryGuardEnable=0;
}

}
}
LCD_Clear(1,1,16);
EEPROM_Write(0x14,BatteryGuardEnable);
}

void EnableVoltageGuard()
{
LCD_OUT(1,1,"Volt Prot: [16]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while( PIND.B2 ==1)
{
if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled"); if(VoltageProtectionEnable==0) LCD_OUT(2,1,"Disabled");
while ( PIND.B0 ==1 ||  PIND.B1 ==1)
{
if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled"); if(VoltageProtectionEnable==0) LCD_OUT(2,1,"Disabled");
if ( PIND.B0 ==1)
{
Delay_ms(200);
VoltageProtectionEnable=1;
}
if( PIND.B1 ==1)
{
Delay_ms(200);
VoltageProtectionEnable=0;
}

}
}
LCD_Clear(1,1,16);
EEPROM_Write(0x15,VoltageProtectionEnable);
}


void SetACVoltageError()
{
LCD_OUT(1,1,"Volt Error: [17]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while ( PIND.B2 ==1)
{
IntToStr(Adjusted_Voltage,txt);
LCD_OUT(2,1,txt);
while( PIND.B0 ==1 ||  PIND.B1  == 1 )
{
IntToStr(Adjusted_Voltage,txt);
LCD_OUT(2,1,txt);
if(Adjusted_Voltage <= 0 ) Adjusted_Voltage=0;
if( PIND.B0 ==1)
{
Delay_ms(200);
Adjusted_Voltage++;
}
if( PIND.B1 ==1)
{
Delay_ms(200);
Adjusted_Voltage--;
}
}
}
LCD_Clear(1,1,16);
LCD_Clear(2,1,16);
Error_Voltage=Adjusted_Voltage-Saved_Voltage;
EEPROM_Write(0x16,Error_Voltage);
EEPROM_Write(0x17,Adjusted_Voltage);
}

void Screen_1()
{
Read_Time();
Read_Battery();
CalculateAC();
DisplayTimerActivation();
}

void ADCBattery()
{
ADC_Init();
ADC_Init_Advanced(_ADC_EXTERNAL_REF);
}

void Read_Battery()
{
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value*5.0)/1024.0;



Vin_Battery=((103.653/4.653)*Battery_Voltage)+0.3;

sprintf(txt,"%4.1f",Vin_Battery);
LCD_OUT(2,1,txt);
}

void LowBatteryVoltageAlarm()
{

if (Vin_Battery<Mini_Battery_Voltage)
{
 PORTD.B4 =0;
 PORTC.B2 =1;
Delay_ms(300);
 PORTC.B2 =0;
Delay_ms(300);
}

}


unsigned int ReadAC()
{

unsigned int r;
unsigned int max_v=0;
char i=0;
for (i=0;i<100;i++)
{
r=ADC_Read(3);
if (max_v<r) max_v=r;
delay_us(200);
}
return max_v;
}

void CalculateAC()
{
char buf[15];





v=ReadAC();
v=v*5.0/1024.0;
v=255.5*v;
v/=sqrt(2);
v=v+Error_Voltage;

if ( PIND.B3 ==0)
{
sprintf(buf,"%4.0fV",v);
LCD_OUT(2,8,"-");
LCD_OUT(2,9,buf);
}
else
{
LCD_OUT(2,9,"   ");
}
VoltageProtector(v);
#line 1445 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Auto Switcher/MikroC/Solar_Auto_Switcher.c"
}

void DisplayTimerActivation()
{
if (Timer_Enable==1) LCD_OUT(1,15,"T");
if(Timer_Enable==0) LCD_OUT(1,15," ");
}

void VoltageProtector(unsigned long voltage)
{
if(VoltageProtectionEnable==1)
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
}


void main() {
Config();
ADCBattery();
EEPROM_Load();
ReadBytesFromEEprom(0x07,(unsigned short *)&Mini_Battery_Voltage,4);
TWI_Config();
Config_Interrupts();
while(1)
{
Screen_1();
Check_Timers();

Delay_ms(200);

}
}
