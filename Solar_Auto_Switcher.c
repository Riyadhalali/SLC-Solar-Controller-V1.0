#include "ds1307.h"
 //---------------------------------Defines-------------------------------------
 #define Relay_L_1 PORTD.B4
 #define Relay_L_2 PORTD.B5
 #define Relay_L_3 PORTD.B6
 #define Relay_N_Grid PORTC.B0
 #define Relay_N_Solar PORTD.B7
 #define Set PIND.B2
 #define Decrement PIND.B1
 #define Increment PIND.B0
 #define AC_Available PIND.B3
 #define Buzzer PORTC.B2
 //------------------------------EEPROM Table-----------------------------------
 /*
 0x00= timer 1 hours
 0x01=timer 1 minutes
 0x02= timer 1 seconds
 0x03= timer 2 hours
 0x04= timer 2 minutes
 0x05= timer 2 seconds
 0x06= bypass system on or off
 0x07~0x10= low voltage battery
 0x11=timer enable or disable
 0x12= high voltage protector
 0x13= low voltage protector
 0x14= Battery Guard Enable
 0x15=Voltage Protection Enable
 0x16=Ac Error Voltage
 0x17= adjusted ac voltage
 0x18= lcd_hours_timer2_start
 0x19= lcd_minutes_timer2_start
 0x20=lcd_hours_timer2_stop
 0x21=lcd_minutes_timer2_stop
 0x22= lcd_hours_timer3_start
 0x23=lcd_minutes_timer3_start
 0x24=lcd_hours_timer3_stop
 0x25=lcd_minutes_timer3_stop


 */
 //---------------------------------outputs-------------------------------------
 /*
  Relay=0 grid
  Relay=1 solar inverter
  //--------------------------------ADC Battery---------------------------------
  Vout=Vin* (R2 /R1+R2);
  5V= 65 * ( 1K / 100K + 1 );

 */
//---------------------------------LCD Defines----------------------------------
// Lcd pinout settings
sbit LCD_RS at PORTB0_bit;
sbit LCD_EN at PORTB1_bit;
sbit LCD_D7 at PORTB5_bit;
sbit LCD_D6 at PORTB4_bit;
sbit LCD_D5 at PORTB3_bit;
sbit LCD_D4 at PORTB2_bit;
// Pin direction
sbit LCD_RS_Direction at DDB0_bit;
sbit LCD_EN_Direction at DDB1_bit;
sbit LCD_D7_Direction at DDB5_bit;
sbit LCD_D6_Direction at DDB4_bit;
sbit LCD_D5_Direction at DDB3_bit;
sbit LCD_D4_Direction at DDB2_bit;
//-----------------------------------------Variables----------------------------
char set_status=0;    //variable for the set button state
char txt[10];
char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char hours_lcd_timer2_start=0,hours_lcd_timer2_stop=0;
char minutes_lcd_timer2_start=0,minutes_lcd_timer2_stop=0;
char hours_lcd_timer3_start=0,hours_lcd_timer3_stop=0;
char minutes_lcd_timer3_start=0,minutes_lcd_timer3_stop=0;
char Relay_State; // variable for toggling relay
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0;
char ByPassState=0;    //enabled is default 0 is enabled and 1 is disabled
float Battery_Voltage;
char BatteryVoltageSystem=0; // to save the battery voltage system if it is 12v/24v/48v
unsigned int ADC_Value;   // adc value for battery voltage
float Vin_Battery;      //voltage of battery
float Mini_Battery_Voltage=12.0;
char outBuff[21];
char Timer_Enable=1;   // timer 1
char Timer_2_Enable=1; // timer 2
char Timer_3_Enable=1; //timer 3
char CorrectionTime_State=0;  // this function to solve the error when battery is low and timer didn't start because of the low battery
unsigned int High_Voltage=245;      //ac high voltage
unsigned int Low_Voltage=175;       // ad low voltage
char VoltageProtectorGood;
char BatteryGuardEnable=1;   // enabled is default
char VoltageProtectionEnable; // enable voltage protection on grid
char Error_Voltage=0;       //difference between voltage and reading voltage
float v; // ac voltage as global variable
char Saved_Voltage;     // volatge when user hits set
char Adjusted_Voltage; // voltage saved by user
char AcBuzzerActiveTimes=0;  //for not making buzzer always on
char AcBuzzerActive=0;  //  for controlling buzzer activation just for one time
//------------------------------------Functions---------------------------------
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
void SetTimer();   // set timer to be activated or not activated
void LowBatteryVoltageAlarm();
unsigned int ReadAC();  //read ac voltage
void CalculateAC();   //calculate ac voltage
void DisplayTimerActivation(); // to display if timer is enabled or disabled on LCD
void SetHighVoltage();
void SetLowVoltage();
void VoltageProtector(unsigned long voltage);
void EnableBatteryGuard();         // this function is for enabling or disable the battery protection
void EnableVoltageGuard();   // AC voltage Protection
void SetACVoltageError() ; // this function to adjust differents in the reading volt because of the error in the resistors
void GetVoltageNow(); // get AC voltage at time
void ToggleBuzzer();
//------------------------------------------------------------------------------
void Gpio_Init()
{
DDRD.B4=1; // Relay_L_1 pin set as output
DDRD.B5=1; // Relay_L_2 set as output
DDRD.B6=1; // Relay_L_3 set as output
DDRD.B7=1; // Relay_N_Solar set as output
DDRD.B0=1; // Relay_N_Grid set as output
DDRD.B2=0; // Set as input
DDRD.B1=0; // decrement set as input
DDRD.B0=0; // increment set as input
DDRD.B3=0; // set ac_available as input
DDRC.B2=1; // set buzzer as output
DDRC.B0=1; // set relay N as output
}
//------------------------Write Time--------------------------------------------
//-> write time to DS1307
void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
{
write_Ds1307(0x00,seconds);           //seconds
write_Ds1307(0x01,minutes);          // minutes
write_Ds1307(0x02,hours); // using the 24 hour system
}
//------------------------------------------------------------------------------
void Config()
{
GPIO_Init();
LCD_Init();
LCD_CMD(_LCD_CURSOR_OFF);
LCD_CMD(_LCD_CLEAR);
LCD_OUT(1,1,"Starting ... ");
Delay_ms(2000);

}
//-------------------------------------Interrupts-------------------------------
void Config_Interrupts()
{
ISC01_bit=0;   // Config The rising edge of INT0 generates an interrupt request.
ISC00_bit=0;
INT0_bit=1;
SREG_I_bit=1; // enable the global interrupt vector
}
//-----------------------------------LCD Clear----------------------------------
void LCD_Clear(unsigned short Row, unsigned short Start, unsigned short End)
{
  unsigned short Column;
  for(Column=Start; Column<=End; Column++)
  {
    Lcd_Chr(Row,Column,32);
  }
}
//----------------------------------EEPROM--------------------------------------
void EEPROM_Load()
{
//*****************timer 1****************
hours_lcd_1=EEPROM_Read(0x00);
minutes_lcd_1=EEPROM_Read(0x01);
hours_lcd_2=EEPROM_Read(0x03);
minutes_lcd_2=EEPROM_Read(0x04);
//*****************timer 2*****************
hours_lcd_timer2_start=EEPROM_Read(0x18);
minutes_lcd_timer2_start=EEPROM_Read(0x19);
hours_lcd_timer2_stop=EEPROM_Read(0x20);
minutes_lcd_timer2_stop=EEPROM_Read(0x21);
//*****************timer 3*****************
hours_lcd_timer3_start=EEPROM_Read(0x22);
minutes_lcd_timer3_start=EEPROM_Read(0x23);
hours_lcd_timer3_stop=EEPROM_Read(0x24);
minutes_lcd_timer3_stop=EEPROM_Read(0x25);
//**********************************************
ByPassState=EEPROM_Read(0x06); // read bypass system if it is disabled or enabled
Timer_Enable=EEPROM_Read(0x011);
High_Voltage=EEPROM_Read(0x12); // load high voltage
Low_Voltage=EEPROM_Read(0x13); // load low voltage
//BatteryGuardEnable=EEPROM_Read(0x14);
VoltageProtectionEnable=EEPROM_Read(0x15);
Error_Voltage=EEPROM_Read(0x16);
Adjusted_Voltage=EEPROM_Read(0x17);// read saved error voltage
//-> write eeprom Config
if (hours_lcd_1== 0xff ) EEPROM_Write(0x00,0x0A); // write 10 to eeprom
if(minutes_lcd_1==0xFF) EEPROM_Write(0x01,0x00);   //write 00
if(hours_lcd_2==0xFF) EEPROM_Write(0x03,0x0E);
if(minutes_lcd_2==0xFF) EEPROM_Write(0x04,0x00);
if(ByPassState==0xFF) EEPROM_Write(0x06,0x01) ; // write by pass 1 to enable as default
if(Timer_Enable==0xFF) EEPROM_Write(0x11,0x01);
if(High_Voltage==0xFF) EEPROM_Write(0x12,0xF5); // 245 high voltage
if(Low_Voltage==0xFF) EEPROM_Write(0x13,0xAA); // 170 Low voltage
//if(BatteryGuardEnable==0xFF) EEPROM_Write(0x14,0x01); // Enable Battery guard
if(VoltageProtectionEnable==0xFF) EEPROM_Write(0x15,0x01); // Enable voltage Protection in default mode
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
//-> re write values
hours_lcd_1=EEPROM_Read(0x00);
minutes_lcd_1=EEPROM_Read(0x01);
//seconds_lcd_1=EEPROM_Read(0x02);
hours_lcd_2=EEPROM_Read(0x03);
minutes_lcd_2=EEPROM_Read(0x04);
//seconds_lcd_2=EEPROM_Read(0x05);
ByPassState=EEPROM_Read(0x06); // read bypass system if it is disabled or enabled
Timer_Enable=EEPROM_Read(0x011);
High_Voltage=EEPROM_Read(0x12); // load high voltage
Low_Voltage=EEPROM_Read(0x13); // load low voltage
//BatteryGuardEnable=EEPROM_Read(0x14);
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
//------------------------------------------------------------------------------
//-> Saving Float Value to EEPROM
void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
EEprom_Write(address+j,*(ptr+j));
Delay_ms(50);
};
}
//------------------------------------------------------------------------------
//-> Reading Float Value from EEPROM
void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
*(ptr+j)=EEPROM_Read(address+j);
Delay_ms(50);
}
}

//-------------------------------Check if timers time occured-------------------
void Check_Timers()
{
char matched_timer_1_start,matched_timer_1_stop;
char matched_timer_2_start,matched_timer_2_stop;
char matched_timer_3_start,matched_timer_3_stop;
//-> timer start
matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
matched_timer_2_start=CheckTimeOccuredOn(0x00,minutes_lcd_timer2_start,hours_lcd_timer2_start);
matched_timer_2_stop=CheckTimeOccuredOff(0x00,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
matched_timer_3_start=CheckTimeOccuredOn(0x00,minutes_lcd_timer3_start,hours_lcd_timer3_start);
matched_timer_3_stop=CheckTimeOccuredOff(0x00,minutes_lcd_timer3_stop,hours_lcd_timer3_stop);

// if the grid is not available and bypass is
//---------------------------- Timer 1 -----------------------------------------
if (AC_Available==1 && Timer_Enable==1   )        // AC GRID is not available and timer is enabled
{ // start if
//-> turn Load On
if (matched_timer_1_start==1)
{
//LCD_OUT(2,1,"Timer  Started");
Relay_L_1=1; // relay on to solar
LCD_OUT(1,16,"1");
}
//-> Turn Load off
if (matched_timer_1_stop==1)
{
//LCD_OUT(2,1,"Timer 1 Stoped");
Relay_L_1=0; // relay off to grid
LCD_OUT(1,16," ");
}
}// end if of ac_available
//-------------------------- Timer 1 End----------------------------------------
//--------------------------- Timer 2 ------------------------------------------
if (AC_Available==1 && Timer_2_Enable==1   )        // AC GRID is not available and timer is enabled
{ // start if
//-> turn Load On
if (matched_timer_2_start==1)
{
//LCD_OUT(2,1,"Timer  Started");
Relay_L_2=1; // relay on to solar
LCD_OUT(1,16,"2");
}
//-> Turn Load off
if (matched_timer_2_stop==1)
{
//LCD_OUT(2,1,"Timer 1 Stoped");
Relay_L_2=0; // relay off to grid
LCD_OUT(1,16," ");
}
}// end if of ac_available
//-----------------------------Timer 3 -----------------------------------------
 if (AC_Available==1 && Timer_3_Enable==1   )        // AC GRID is not available and timer is enabled
{ // start if
//-> turn Load On
if (matched_timer_3_start==1)
{
//LCD_OUT(2,1,"Timer  Started");
Relay_L_3=1; // relay on to solar
LCD_OUT(1,16,"3");
}
//-> Turn Load off
if (matched_timer_3_stop==1)
{
//LCD_OUT(2,1,"Timer 1 Stoped");
Relay_L_3=0; // relay off to grid
LCD_OUT(1,16," ");
}
}// end if of ac_available
//************************Turning N on if any timer is on **********************
if((matched_timer_1_start==1 || matched_timer_2_start==1 || matched_timer_3_start==1) && (AC_Available==1 && Timer_Enable==1) )
{
/*note: can't put a delay between them becuase load will switch on and off */
Relay_N_Solar=1;   // turm n solar on
}
 /// if all relays is of then n can be turned off
if ((Relay_L_1==0 && Relay_L_2==0 && Relay_L_3==0 ) && (AC_Available==1 && Timer_Enable==1) )
{
Relay_N_Solar=0;
}

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//-> checking ac options
// if voltage ac is good and voltage protection is enabled
if(VoltageProtectionEnable==1)  // do not enter the bypass if the voltage is not good because it will be already switched to solar
{
if(VoltageProtectorGood==1)
{
if (AC_Available==0 && ByPassState==0 )       //bypass enabled
{
Relay_L_1=0; // switch to grid
Relay_L_2=0; // switch to grid
Relay_L_3=0 ; // switch to grid
Relay_N_Solar=0;  // make sure all n is offf
Relay_N_Grid=1;    // make sure all n is on and make sure the n_grid is the output
LCD_OUT(2,16,"G");
ToggleBuzzer();
}
if(AC_Available==0 && ByPassState==1 )     //bypass not enabled
{
Relay_L_1=1;   // switch to solar
Relay_L_2=1;   // switch to solar
Relay_L_3=1 ; // switch to solar
Relay_N_Grid=0;    // make sure all n is off
Relay_N_Solar=1;    // make sure all n is on and make sure the n_solar  is the output
LCD_OUT(2,15,"~G");
}
}   //end if voltageProtectorgood
} // end if voltage protection is enabled
//****************************************************
//->  if
if (VoltageProtectionEnable==0)
{
if (AC_Available==0 && ByPassState==0 )
{
Relay_L_1=0; // switch to grid
Relay_L_2=0 ;
Relay_L_3=0;
Relay_N_Solar=0;  // make sure all n is off
Relay_N_Grid=1;    // make sure all n is on and make sure the n_grid  is the output
LCD_OUT(2,16,"G");
}
} // end voltage protection enable
//------------------------------------------------------------------------------
if(AC_Available==1)
{
AcBuzzerActiveTimes=0; // make buzzer variable zero to get activated once again
LCD_OUT(2,15,"  "); // clear lcd
}
}// end of check timers
//******************************************************************************
//-------------------------------Get Voltage At Moment--------------------------
void GetVoltageNow()
{
v=ReadAC();
v=v*5.0/1024.0; // 5000 mah adc voltage reference
v=255.5*v;    // 2.2K/560K+2.2K
v/=sqrt(2);
}
//------------------------------Toggle Buzzer-----------------------------------
void ToggleBuzzer()
{
if (AcBuzzerActiveTimes==0)
{
Buzzer=1;
Delay_ms(1000);
Buzzer=0;
AcBuzzerActiveTimes =1 ;
}
}
//---------------------------------Interrupt Routine----------------------------
void Interrupt_Routine () iv IVT_ADDR_INT0
{
//Enter Setting program
Delay_ms(100);
INTF0_bit=1;     //clear  flag
GetVoltageNow();    //Read voltage at this time without error value
Saved_Voltage=v;            //take snapshot of the voltage in the time the user saved it
if (Set==0)
SetUpProgram();
LCD_Clear(1,1,16);
INTF0_bit=1;     //clear  flag
}
//----------------------------Set up Program------------------------------------
//@ Note: Ente this program if user pressed the button ten seconds
void SetUpProgram()
{
Delay_ms(100);
LCD_CMD(_LCD_CLEAR);
//Timer_Delay_Config();
TimerDelay();
}
//----------------------------Timer to generate 10 Seconds----------------------
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
OCR1AL=0xFF;   // 500ms
OCR1AH=0xFF;   // 500 ms
}
//------------------------------Timer Delay Routine-----------------------------
//******************************************************************************
void TimerDelay()
{
INTF0_bit=1;     //clear  flag to reset the interrupt and read interrupt state again
if (Set==0)
{
LCD_CMD(_LCD_CLEAR);
LCD_OUT(1,1,"Setup Program");
Delay_ms(1000);
//---------------------------------Enter Programs ------------------------------
//-> enter setup mode and don't exit it until the user hit set button
while (Set==1)
{
//-> Enter First Timer Setting
SetTimerOn_1();
SetTimerOff_1();
SetTimerOn_2();
SetTimerOff_2();
SetTimerOn_3();
SetTimerOff_3();
SetDS1307Hours_Program();    // program 10
SetDS1307Minutes_Program(); // program 11
SetDS1307Seconds_Program(); // program 12
AC_Available_ByPass_System(); // program 13 by pass grid system
SetLowBatteryVoltage();// program 14 to set low battery voltage
SetTimer(); // program 15 to enable timer or disable
SetHighVoltage(); // program 16 to set high voltage
SetLowVoltage();   // program 17 to set low voltage
//EnableBatteryGuard(); // program 18
EnableVoltageGuard(); // program 19
//SetACVoltageError();  // program 20     // no ram left
} // end while
}    // end main if

//-------------------------------------Stop Timer-------------------------------
else
{
// stop the timer
CS10_bit=0;
CS11_bit=0;
CS12_bit=0;
}
}
//******************************************************************************
//-----------------------------Setting Hour Timer 1-----------------------------
void SetTimerOn_1()
{

LCD_OUT(1,1,"T1 On: [1]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while (Set==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_1 >=59 || minutes_lcd_1<=0 ) {minutes_lcd_1=0;}
if (Increment==1)
{
delay_ms(200);
minutes_lcd_1++;
}
if (Decrement==1)
{
delay_ms(200);
minutes_lcd_1--;
}
} // end while increment and decrement
} // end first while
//******************************************************************************
Delay_ms(1000);     //read time for state
while (Set==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
 //-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_1 >=24  || hours_lcd_1 <=0) {hours_lcd_1=0;}
if (Increment==1)
{
delay_ms(200);
hours_lcd_1++;
}
if (Decrement==1)
{
delay_ms(200);
hours_lcd_1--;
}
} // end while increment
} // end first while
EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
}
//--------------------------------Set Hours Timer 2-----------------------------
void SetTimerOff_1()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T1 Off: [2]");
LCD_Clear(2,1,16);
while (Set==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_2 >=59 ||minutes_lcd_2<=0 ) {minutes_lcd_2=0;}
if (Increment==1)
{
delay_ms(200);
minutes_lcd_2++;
}
if (Decrement==1)
{
delay_ms(200);
minutes_lcd_2--;
}
} // end while increment or decrement
} // end first while
//*********************************Hours Off************************************
Delay_ms(1000); // read button state
while (Set==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while(Increment== 1 || Decrement==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_2 >=24 || hours_lcd_2<=0) {hours_lcd_2=0;}
if (Increment==1)
{
delay_ms(200);
hours_lcd_2++;
}
if (Decrement==1)
{
delay_ms(200);
hours_lcd_2--;
}
} // end while increment or decrement
} // end first while
EEPROM_Write(0x03,hours_lcd_2); // save hours 2 timer tp eeprom
EEPROM_Write(0x04,minutes_lcd_2); // save hours 1 timer tp eeprom
}
//---------------------------------Set Hours Timer 2 Start----------------------
void SetTimerOn_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 On: [3]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while (Set==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer2_start >=59 ||minutes_lcd_timer2_start<=0 ) {minutes_lcd_timer2_start=0;}
if (Increment==1)
{
delay_ms(200);
minutes_lcd_timer2_start++;
}
if (Decrement==1)
{
delay_ms(200);
minutes_lcd_timer2_start--;
}
} // end while increment or decrement
} // end first while
//**************************************Hours***********************************
Delay_ms(1000); // read button state
while (Set==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer2_start >=24 || hours_lcd_timer2_start<=0 ) {hours_lcd_timer2_start=0;}
if (Increment==1)
{
delay_ms(200);
hours_lcd_timer2_start++;
}
if (Decrement==1)
{
delay_ms(200);
hours_lcd_timer2_start--;
}
} // end while increment or decrement
} // end first while
EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
EEPROM_Write(0x19,minutes_lcd_timer2_start); // save hours 1 timer tp eeprom
}

//----------------------------Set timer 2 off----------------------------
void SetTimerOff_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 Off: [4]");
LCD_Clear(2,1,16);
Delay_ms(1000);
while (Set==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{

ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer2_stop >=59 || minutes_lcd_timer2_stop<=0 ) {minutes_lcd_timer2_stop=0;}
if (Increment==1)
{
delay_ms(200);
minutes_lcd_timer2_stop++;
}
if (Decrement==1)
{
delay_ms(200);
minutes_lcd_timer2_stop--;
}
} // end while increment or decrement
} // end first while
//********************************Hours****************************************
Delay_ms(1000); // read button state
while (Set==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer2_stop >=24 ||hours_lcd_timer2_stop<=0  ) {hours_lcd_timer2_stop=0;}
if (Increment==1)
{
delay_ms(200);
hours_lcd_timer2_stop++;
}
if (Decrement==1)
{
delay_ms(200);
hours_lcd_timer2_stop--;
}
} // end while increment or decrement
} // end first while
EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours 1 timer tp eeprom
EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save hours 1 timer tp eeprom
}
//--------------------------Set Timer 3 on -------------------------------------
void SetTimerOn_3()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T3 On: [5]");
LCD_Clear(2,1,16);
Delay_ms(1000);
while(Set==1)
{
ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
while(Increment==1 || Decrement==1 )
{

ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer3_start >=60 || minutes_lcd_timer3_start <=0 ) {minutes_lcd_timer3_start=0;}
if (Increment==1)
{
delay_ms(200);
minutes_lcd_timer3_start++;
}
if (Decrement==1)
{
delay_ms(200);
minutes_lcd_timer3_start--;
}
} // end while increment decrement
} // end while set for minutes
//******************************************************************************
//-> give delay to read once again the button state
Delay_ms(1000);
while(Set==1)
{
ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
while(Increment==1 || Decrement==1 )
{
ByteToStr(hours_lcd_timer3_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer3_start >=24 || hours_lcd_timer3_start <=0 ) {hours_lcd_timer3_start=0;}
if (Increment==1)
{
delay_ms(200);
hours_lcd_timer3_start++;
}
if (Decrement==1)
{
delay_ms(200);
hours_lcd_timer3_start--;
}
} // end while increment decrement
}     // end while set for hours
EEPROM_Write(0x22,hours_lcd_timer3_start); // save hours 1 timer tp eepro
EEPROM_Write(0x23,minutes_lcd_timer3_start); // save hours 1 timer tp eepro
}
//--------------------------Set Timer 3 Off-------------------------------
void SetTimerOff_3()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T3 Off: [6]");
LCD_Clear(2,1,16);
Delay_ms(1000);         // delay for button to read state
while (Set==1)
{
ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{

ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( minutes_lcd_timer3_stop >=59  || minutes_lcd_timer3_stop<=0 ) {minutes_lcd_timer3_stop=0;}
if (Increment==1)
{
delay_ms(200);
minutes_lcd_timer3_stop++;
}
if (Decrement==1)
{
delay_ms(200);
minutes_lcd_timer3_stop--;
}
} // end while increment or decrement
} // end while set for minutes
//******************************************************************************
//-> give delay to read once again the button state
Delay_ms(1000);
while (Set==1)
{
ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{

ByteToStr(hours_lcd_timer3_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer3_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if ( hours_lcd_timer3_stop >=23  || hours_lcd_timer3_stop<=0 ) {hours_lcd_timer3_stop=0;}
if (Increment==1)
{
delay_ms(200);
hours_lcd_timer3_stop++;
}
if (Decrement==1)
{
delay_ms(200);
hours_lcd_timer3_stop--;
}
} // end while increment or decrement
} // end while set for minutes
//---------------
EEPROM_Write(0x25,minutes_lcd_timer3_stop); // save hours 1 timer tp eepro
EEPROM_Write(0x24,hours_lcd_timer3_stop); // save hours 1 timer tp eepro
}
//-------------------------------SetDS1307HoursDSProgram------------------------
void SetDS1307Hours_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[H] [7]");
Delay_ms(1000);
while (Set==1)
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
while (Increment==1 || Decrement==1 )
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
if (Increment==1)
{
delay_ms(200);
set_ds1307_hours++;

}
if (Decrement==1)
{
delay_ms(200);
set_ds1307_hours--;
}
} // end while decrement or increment
} // end first while
}
//--------------------------------Set Minutes Ds1307----------------------------
void SetDS1307Minutes_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[M] [8]");
Delay_ms(1000);
while (Set==1)
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
while (Increment==1 || Decrement==1)
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
if (Increment==1)
{
delay_ms(200);
set_ds1307_minutes++;

}
if (Decrement==1)
{
delay_ms(200);
set_ds1307_minutes--;
}
} // end while decrement or increment
} // end first while
}
//--------------------------------Set DS1307 Seconds----------------------------
void SetDS1307Seconds_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[S] [9]");
Delay_ms(1000);
while (Set==1)
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
while(Increment==1 || Decrement==1)
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
if (Increment==1)
{
delay_ms(200);
set_ds1307_seconds++;

}
if (Decrement==1)
{
delay_ms(200);
set_ds1307_seconds--;
}
//-> Send Now time to ds1307 to be set
//-> to force user to change the time when the last seconds options is changing it must be saved
Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
} // end while decrement or increment
} // end first while
}
//------------------------------------Detect AC---------------------------------
void AC_Available_ByPass_System()
{

LCD_OUT(1,1,"ByPass Grid: [10]");
Delay_ms(1000);
LCD_Clear(2,1,16);
//-> note: 0 is enabled and 1 is disabled because loading default value form epprom for the first time will be zero
// and i want the default value to be enabled and 0
if (ByPassState==0) LCD_OUT(2,1,"Enabled"); else LCD_OUT(2,1,"Disabled");
while (Set==1)
{
if (ByPassState==0) LCD_OUT(2,1,"Enabled"); else LCD_OUT(2,1,"Disabled");
 //-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1) ByPassState=1;
if (Decrement==1) ByPassState=0;

} // end while increment
} // end first while
EEPROM_Write(0x06,ByPassState); // save hours 1 timer tp eeprom
LCD_CMD(_LCD_CLEAR);
}
//----------------------SetLowBatteryVoltage------------------------------------
void SetLowBatteryVoltage()
{
LCD_OUT(1,1,"Low Battery: [11]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while(Set==1)
{
sprintf(txt,"%4.1f",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");
while (Increment==1 || Decrement==1)
{
sprintf(txt,"%4.1f",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");
if(Mini_Battery_Voltage> 65 ) Mini_Battery_Voltage=0.0;

if (Increment==1)
{
Delay_ms(200);
Mini_Battery_Voltage+=0.1;

}
if (Decrement==1)
{
Delay_ms(200);
Mini_Battery_Voltage-=0.1;
}
} //end wile increment and decrement
}// end while set
Delay_ms(1000);
StoreBytesIntoEEprom(0x07,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
LCD_CMD(_LCD_CLEAR);
}
//-----------------------------------Set timer Program 10-----------------------
void SetTimer()
{
LCD_OUT(1,1,"Timer State:[12]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while (Set==1)
{
LCD_OUT(1,1,"Timer : [10]");
if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled");}
while(Increment == 1 || Decrement == 1 )
{


if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled");}
if (Increment==1)
{
delay_ms(200);
Timer_Enable=1; // timer is enabled
}
if (Decrement==1)
{
delay_ms(200);
Timer_Enable=0; // timer is disabled
}
} // while increment decrement
} // end while set
EEPROM_Write(0x11,Timer_Enable); // save the state of the timer
LCD_CMD(_LCD_CLEAR);
}
//----------------------------Program 11 Set High Voltage-----------------------
void SetHighVoltage()
{
LCD_OUT(1,1,"High Volt: [13]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while(Set==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
while(Increment==1 || Decrement==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
if (Increment==1)
{
Delay_ms(200);
High_Voltage++;
}
if(Decrement==1)
{
Delay_ms(200);
High_Voltage--;
}
} // end while increment or decrement
} // end while set
EEPROM_Write(0x12,High_Voltage);
}
//-------------------------------Program 12-------------------------------------
void SetLowVoltage()
{
LCD_OUT(1,1,"Low Volt: [14]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while(Set==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
while(Increment==1 || Decrement==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
if (Increment==1)
{
Delay_ms(200);
Low_Voltage++;
}
if(Decrement==1)
{
Delay_ms(200);
Low_Voltage--;
}
} // end while increment or decrement
} // end while set
LCD_Clear(1,1,16);
EEPROM_Write(0x13,Low_Voltage);
}
//-----------------------------Enable Battery Guard-----------------------------
void EnableBatteryGuard()
{
LCD_OUT(1,1,"Batt Guard:[15]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while(Set==1)
{
if(BatteryGuardEnable==1) LCD_OUT(2,1,"Enabled"); if(BatteryGuardEnable==0)  LCD_OUT(2,1,"Disabled");
while(Increment==1 || Decrement==1)
{
if(BatteryGuardEnable==1) LCD_OUT(2,1,"Enabled"); if(BatteryGuardEnable==0)  LCD_OUT(2,1,"Disabled");
if (Increment==1)
{
Delay_ms(200);
BatteryGuardEnable=1;
}
if(Decrement==1)
{
Delay_ms(200);
BatteryGuardEnable=0;
}

} // end while increment decrement
} //end while
LCD_Clear(1,1,16);
EEPROM_Write(0x14,BatteryGuardEnable);
}
//----------------------------Voltage Protection Enable-------------------------
void EnableVoltageGuard()
{
LCD_OUT(1,1,"Volt Prot: [16]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while(Set==1)
{
if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled"); if(VoltageProtectionEnable==0)  LCD_OUT(2,1,"Disabled");
while (Increment==1 || Decrement==1)
{
if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled"); if(VoltageProtectionEnable==0)  LCD_OUT(2,1,"Disabled");
if (Increment==1)
{
Delay_ms(200);
VoltageProtectionEnable=1;
}
if(Decrement==1)
{
Delay_ms(200);
VoltageProtectionEnable=0;
}

} // end while increment and decrement
}  // end while
LCD_Clear(1,1,16);
EEPROM_Write(0x15,VoltageProtectionEnable);
} // end function
//--------------------------SetACVoltageError [15]------------------------------
//-> set the error of the voltage differents from the resistors
void SetACVoltageError()
{
LCD_OUT(1,1,"Volt Error: [17]");
Delay_ms(1000);
LCD_Clear(2,1,16);
while (Set==1)
{
IntToStr(Adjusted_Voltage,txt);
LCD_OUT(2,1,txt);
while(Increment==1 || Decrement == 1 )
{
IntToStr(Adjusted_Voltage,txt);
LCD_OUT(2,1,txt);
if(Adjusted_Voltage <= 0 ) Adjusted_Voltage=0;
if(Increment==1)
{
Delay_ms(200);
Adjusted_Voltage++;
}
if(Decrement==1)
{
Delay_ms(200);
Adjusted_Voltage--;
}
} // end while increment or decrement
} // end while set
LCD_Clear(1,1,16);
LCD_Clear(2,1,16);
Error_Voltage=Adjusted_Voltage-Saved_Voltage;
EEPROM_Write(0x16,Error_Voltage);   // difference in the voltage reading
EEPROM_Write(0x17,Adjusted_Voltage); // save the user voltage
}   // end function
//----------------------------Screen 1------------------------------------------
void Screen_1()
{
Read_Time();
Read_Battery();
CalculateAC();
DisplayTimerActivation();
}
//----------------------------ADC Battery Voltage 12v/24v/48v-------------------
void ADCBattery()
{
ADC_Init();
ADC_Init_Advanced(_ADC_EXTERNAL_REF);
}
//--------------------------Read Battery Voltage--------------------------------
void Read_Battery()
{
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value*5.0)/1024.0;
/*Vadc=Vin* (4.7K /100K) => Vin=(104.7/4.7k) * VADC*/

//100k*1.01=99K , 4.7K *1.01=4.653
Vin_Battery=((103.653/4.653)*Battery_Voltage)+0.3; // 0.3 volt error from reading
//LongToStr((((long)(1000.0*Vin_Battery)+5.0)/10.0),txt);
sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
}
//---------------------------------LOW battery Voltage--------------------------
void LowBatteryVoltageAlarm()
{

if (Vin_Battery<Mini_Battery_Voltage)
{
Relay_L_1=0; // switch relay off the solar and turn it to grid
Buzzer=1;
Delay_ms(300);
Buzzer=0;
Delay_ms(300);
}

}

//------------------------------------Read AC Voltage---------------------------
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
//---------------------------------Calculate AC---------------------------------
void CalculateAC()
{
char buf[15];

//int ADC_Value_v;
//-> don't read ac voltage until the grid is available
//if(AC_Available==0)
//{
v=ReadAC();
v=v*5.0/1024.0; // 5000 mah adc voltage reference
v=255.5*v;    // 2.2K/560K+2.2K
v/=sqrt(2);
v=v+Error_Voltage;
//-> to delete the error value displayed in lcd when there is not grid
if (AC_Available==0)
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
//}
/*else
{
v=0;
sprintf(buf,"%03uVAC",v);
LCD_OUT(2,8,"-");
LCD_OUT(2,9,buf);
VoltageProtector(v);
}*/
}
//----------------------------------DisplayTimerActivation----------------------
void DisplayTimerActivation()
{
if (Timer_Enable==1) LCD_OUT(1,15,"T");
if(Timer_Enable==0) LCD_OUT(1,15," ");
}
//----------------------------------Voltage Protector---------------------------
void VoltageProtector(unsigned long voltage)
{
if(VoltageProtectionEnable==1)
{
if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
{
VoltageProtectorGood=0;
}

if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
{
VoltageProtectorGood=1;
}
} // end voltage protection
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
void main() {
Config();
ADCBattery(); // adc configuartion for adc
EEPROM_Load(); // load params programs
ReadBytesFromEEprom(0x07,(unsigned short *)&Mini_Battery_Voltage,4);
TWI_Config();
Config_Interrupts();
while(1)
{
Screen_1();
Check_Timers();
//LowBatteryVoltageAlarm();
Delay_ms(200);

} // end while
}   // end main
//--------------------------------TODO List-------------------------------------
/*
Design Error List:
*/

/*
Todo List:
1- when pressing decrement it display 255 as a value
2- voltage protector
3- numbers in hours and minutes


*/