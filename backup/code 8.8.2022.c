#include "ds1307.h"
#include "stdint.h"
#include <stdbool.h>
 //---------------------------------Defines-------------------------------------
 #define Relay_L_Solar PORTD.B6
 #define Relay_L_Solar_2 PORTD.B7
 #define Set PIND.B2
 #define Decrement PIND.B1
 #define Increment PIND.B0
 #define AC_Available PIND.B3
 #define Buzzer PORTC.B2
 #define Exit PINC.B0
 

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
//unsigned short old_time_compare_pv,old_time_update_pv,old_time_screen_1=0,old_time_screen_2=0; // to async
char set_status=0;    //variable for the set button state
char txt[21];
float pvArr[1000];
unsigned char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char hours_lcd_timer2_start=0,hours_lcd_timer2_stop=0,seconds_lcd_timer2_start=0;
char minutes_lcd_timer2_start=0,minutes_lcd_timer2_stop=0,seconds_lcd_timer2_stop=0;
char hours_lcd_timer3_start=0,hours_lcd_timer3_stop=0;
char minutes_lcd_timer3_start=0,minutes_lcd_timer3_stop=0;
char Relay_State; // variable for toggling relay
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0;
char ByPassState=0;    //enabled is default 0 is enabled and 1 is disabled
float Battery_Voltage,PV_Voltage,Vin_PV,Vin_PV_Old=0,Vin_PV_Present=0;
char BatteryVoltageSystem=0; // to save the battery voltage system if it is 12v/24v/48v
unsigned int ADC_Value;   // adc value for battery voltage
unsigned int ADC_Value_PV;
float Vin_Battery;      //voltage of battery
float Mini_Battery_Voltage=0;
char Timer_Enable=1;   // timer 1
char Timer_2_Enable=1; // timer 2
char Timer_3_Enable=1; //timer 3
char CorrectionTime_State=0;  // this function to solve the error when battery is low and timer didn't start because of the low battery
unsigned int High_Voltage=245;      //ac high voltag`e
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
char matched_timer_1_start,matched_timer_1_stop, matched_timer_2_start,matched_timer_2_stop;
char Old_Reg=0;
char SolarOnGridOff=0,SolarOffGridOn=0;
char SolarOnGridOff_2=0,SolarOffGridOn_2=0;
char Timer_isOn=0,Timer_2_isOn=0;
unsigned int Timer_Counter_2=0, Timer_Counter_3=0;
unsigned int Low_PV_Voltage=50;       // PV panels low voltage
bool Grid_Already_On=false;            // to not enter conditions as the grid is available
unsigned short old_timer_1=0,old_timer_2=0,temp=0;
unsigned short startupTIme_1=0,startupTIme_2=0;  // 25 seconds for load one to start up and 50 seconds for load 2 to startup
char updateScreen=0;
float arrayBatt[21];
float StartLoadsVoltage=0;
float BuzzerVoltage=1.0; // voltage added to mini voltage to start giving the alarm before loads switches off
unsigned short ReadMinutesMinusOldTimer_1=0;
unsigned short ReadMinutesMinusOldTimer_2=0;
//-----------------------------------Functions---------------------------------
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
void Start_Timer();
void Stop_Timer();
void ReadPV_Voltage();
void SetLowPV_Voltage();
//void RestoreFactorySettings();
void EEPROM_FactorySettings();
void Start_Timer_2_B();   // timer for updating screen
void Start_Timer_0_A();  // timer for pv voltage to shutdown
void Stop_Timer_0();
void Read_PV_Continues();  // to eep updating pv
void Startup_Timers();
void SetStartUpLoadsVoltage();
//------------------------------------------------------------------------------
void Gpio_Init()
{
DDRD.B6=1; // Relay_L_Solar set as output
DDRD.B7=1; // Relay_L_Solar_2 set as output
DDRD.B2=0; // Set as input
DDRD.B1=0; // decrement set as input
DDRD.B0=0; // increment set as input
DDRD.B3=0; // set ac_available as input
DDRC.B2=1; // set buzzer as output
DDRC.B0=0;  //SET EXIT AS INPUT


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
//ByPassState=EEPROM_Read(0x06); // read bypass system if it is disabled or enabled
ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
//Timer_Enable=EEPROM_Read(0x011);
Timer_Enable=1;      // delete function to be programmed for rom space
High_Voltage=EEPROM_Read(0x12); // load high voltage
Low_Voltage=EEPROM_Read(0x13); // load low voltage
//BatteryGuardEnable=EEPROM_Read(0x14);
VoltageProtectionEnable=EEPROM_Read(0x15);
startupTIme_1=EEPROM_Read(0x40);
startupTIme_2=EEPROM_Read(0x41);

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
//-> timer start
matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
matched_timer_2_start=CheckTimeOccuredOn(seconds_lcd_timer2_start,minutes_lcd_timer2_start,hours_lcd_timer2_start);
matched_timer_2_stop=CheckTimeOccuredOff(seconds_lcd_timer2_stop,minutes_lcd_timer2_stop,hours_lcd_timer2_stop);
//---------------------------- Timer 1 -----------------------------------------
//if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > Mini_Battery_Voltage )        // AC GRID is not available and timer is enabled
//{ // start if
//-> turn Load On
if (matched_timer_1_start==1)
{
Timer_isOn=1;
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage  )
{
SolarOnGridOff=1;
//SolarOffGridOn=0;
Start_Timer();
LCD_OUT(1,16,"1");
}
} // end if ac_available
//-> Turn Load off
if (matched_timer_1_stop==1)
{
Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage   )
{
SolarOnGridOff=0; // to enter once again in the interrupt
//for the turn off there is no need for delay
Relay_L_Solar=0; // relay off
LCD_OUT(1,16," ");
}
}
//}// end if of ac_available


//-------------------------- Timer 1 End----------------------------------------
//------------------------- Timer 2 Start---------------------------------------
if (matched_timer_2_start==1)
{
Timer_2_isOn=1;
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage)
{
SolarOnGridOff_2=1;
Start_Timer();
LCD_OUT(1,16,"2");
}
} // end if ac_available


if (matched_timer_2_stop==1)
{
Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage   )
{
SolarOnGridOff_2=0; // to enter once again in the interrupt
//for the turn off there is no need for delay
Relay_L_Solar_2=0; // relay off
LCD_OUT(1,16," ");
}
}

//***************************ByPass System**************************************
// if voltage ac is good and voltage protection is enabled
  // do not enter the bypass if the voltage is not good because it will be already switched to solar
if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 )       //bypass enabled
{
////////////////////////////////////////////////////////////////////////////////
SolarOnGridOff=1;   // first timer
SolarOnGridOff_2=1;  // second timer
Start_Timer();
LCD_OUT(2,16,"G");
ToggleBuzzer();
}
//**********************Voltage Protector***************************************
/**
if voltage protector drops up or
*/
if(AC_Available==0 && VoltageProtectorGood==0)
{
Start_Timer_0_A();         // give some time ac grid to stabilize

}
//------------------------------------------------------------------------------
//-> functions for shutting down loads if there is no timers
if(AC_Available==1 && Timer_isOn==0 )
{
AcBuzzerActiveTimes=0; // make buzzer variable zero to get activated once again
//-> turn the relays of grid off
SolarOffGridOn=0;
//SolarOffGridOn_2=0;
Relay_L_Solar=0;
//Relay_L_Solar_2=0;
LCD_OUT(2,16," "); // clear lcd
}

if (AC_Available==1 && Timer_2_isOn==0)
{
//SolarOffGridOn=0;
SolarOffGridOn_2=0;
//Relay_L_Solar=0;
Relay_L_Solar_2=0;
LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
}
//------------------------Functions for reactiving timers------------------------
/*
 these function is used for reactiving timers when grid available in the same timer is on or off
*/
//-> if the  ac is shutdown and timer is steel in the range of being on  so reactive timer 1
if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage  )
{
SolarOnGridOff=1;
Start_Timer();
}
//-> if the  ac is shutdown and timer is steel in the range of being on  so reactive timer 2
if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage )
{
SolarOnGridOff_2=1;
Start_Timer();
}

//--Turn Load off when battery Voltage  is Low and AC Not available and Bypass is enabled
if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && (Timer_isOn==1 || Timer_2_isOn==1))
{
//Relay_L_Solar=0;

//Relay_L_Solar_2=0;
Start_Timer_0_A();         // give some time for battery voltage
}

//--Turn Load off when Pv Voltage is Low and AC Not available so when working in timer mode
/*if (Vin_PV<Low_PV_Voltage && AC_Available==1 && (Timer_isOn==1 || Timer_2_isOn==1))
{
//Relay_L_Solar=0;
Start_Timer_0_A();
}*/

// when shutdown solar must be done and grid available it will not enter the shutdown timer so i made this
/*if (AC_Available==1 && Timer_isOn==0)
{
SolarOnGridOff=0;
//SolarOnGridOff_2=0;
Relay_L_Solar=0;
//Relay_L_Solar_2=0;
}*/
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
if (Set==0)
{
LCD_CMD(_LCD_CLEAR);
LCD_OUT(1,1,"Setup Program");
Delay_ms(1000);
//---------------------------------Enter Programs ------------------------------
//-> enter setup mode and don't exit it until the user hit set button
while (Set==1 )
{
//-> Enter First Timer Setting and test for exit button at every screen moving in and out
SetTimerOn_1();
if (Exit==1)   break;     //break out of the while loop
SetTimerOff_1();
if (Exit==1)   break;     //break out of the while loop
SetTimerOn_2();
if(Exit==1) break;
SetTimerOff_2();
if (Exit==1) break ;
//AC_Available_ByPass_System(); // program 13 by pass grid system
//if (Exit==1)   break;     //break out of the while loop
SetLowBatteryVoltage();// program 14 to set low battery voltage
if (Exit==1)   break;     //break out of the while loop
SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
if (Exit==1)   break;     //break out of the while loop
SetHighVoltage(); // program 16 to set high voltage
if (Exit==1)   break;     //break out of the while loop
SetLowVoltage();   // program 17 to set low voltage
if (Exit==1)   break;     //break out of the while loop
//EnableVoltageGuard(); // program 19
if (Exit==1)   break;     //break out of the while loop
//SetLowPV_Voltage();
//if (Exit==1)   break;     //break out of the while loop
SetDS1307Hours_Program();    // program 10
if (Exit==1)   break;     //break out of the while loop
SetDS1307Minutes_Program(); // program 11
if (Exit==1)   break;     //break out of the while loop
SetDS1307Seconds_Program(); // program 12
if (Exit==1)   break;
/*RestoreFactorySettings();
if (Exit==1)   break;       //break out of the while loop*/
Startup_Timers();
if(Exit==1) break;
LCD_CMD(_LCD_CLEAR);
} // end while
}    // end main if
}

//-----------------------------Setting Hour Timer 1-----------------------------
void SetTimerOn_1()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T1 On: [1]");
Delay_ms(100);
LCD_Clear(2,1,16);

while (Set==1)
{

ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M");
LCD_Out(2,7,txt);
//break out while loop and interupt
if (Exit==1)
{
break;     //break out of the while loop
}

//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M ");
LCD_Out(2,7,txt);



if (Increment==1  )
{
delay_ms(100);
minutes_lcd_1++;
}
if (Decrement==1&&minutes_lcd_1<=59)
{
delay_ms(100);
minutes_lcd_1--;
}
//-> perfect
if (minutes_lcd_1>59)    minutes_lcd_1=0;
if (minutes_lcd_1<0) minutes_lcd_1=0;
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
if (Exit==1)
{
break;     //break out of the while loop
}
 //-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
ByteToStr(hours_lcd_1,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

if (Increment==1)
{
delay_ms(100);
hours_lcd_1++;
}
if (Decrement==1)
{
delay_ms(100);
hours_lcd_1--;
}

if  (hours_lcd_1>23) hours_lcd_1=0;
if  (hours_lcd_1<0) hours_lcd_1=0;
} // end while increment
} // end first while

EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
}
//--------------------------------Set Timer 1 Off ------------------------------
void SetTimerOff_1()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T1 Off: [2]");
LCD_Clear(2,1,16);
Delay_ms(500);
while (Set==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)   break;     //break out of the while loop
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

if (Increment==1)
{
delay_ms(100);
minutes_lcd_2++;
}
if (Decrement==1)
{
delay_ms(100);
minutes_lcd_2--;
}

if(minutes_lcd_2>59) minutes_lcd_2=0;
if (minutes_lcd_2<0) minutes_lcd_2=0;

} // end while increment or decrement
} // end first while
//*********************************Hours Off************************************
Delay_ms(500); // read button state
while (Set==1)
{
ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)   break;     //break out of the while loop
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

if (Increment==1)
{
delay_ms(100);
hours_lcd_2++;
}
if (Decrement==1)
{
delay_ms(100);
hours_lcd_2--;
}
if(hours_lcd_2>23) hours_lcd_2=0;
if (hours_lcd_2<0 ) hours_lcd_2=0;
} // end while increment or decrement
} // end first while
EEPROM_Write(0x03,hours_lcd_2); // save hours off  timer_1 to eeprom
EEPROM_Write(0x04,minutes_lcd_2); // save minutes off timer_1 to eeprom
}
//----------------------------- Timer  2 ---------------------------------------
//******************************************************************************
void SetTimerOn_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 On: [1]");
Delay_ms(100);
LCD_Clear(2,1,16);
while (Set==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M");
LCD_Out(2,7,txt);
//break out while loop and interupt
if (Exit==1)
{
break;     //break out of the while loop
}

//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M ");
LCD_Out(2,7,txt);

if (Increment==1  )
{
delay_ms(100);
minutes_lcd_timer2_start++;
}
if (Decrement==1 )
{
delay_ms(100);
minutes_lcd_timer2_start--;
}
//-> perfect
if (minutes_lcd_timer2_start>59)    minutes_lcd_timer2_start=0;
if (minutes_lcd_timer2_start<0)  minutes_lcd_timer2_start=0;
} // end while increment and decrement
} // end first while
//******************************************************************************
Delay_ms(1000);     //read time for state
while (Set==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)
{
break;     //break out of the while loop
}
 //-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
ByteToStr(hours_lcd_timer2_start,txt);
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

if (Increment==1)
{
delay_ms(100);
hours_lcd_timer2_start++;
}
if (Decrement==1)
{
delay_ms(100);
hours_lcd_timer2_start--;
}

if  (hours_lcd_timer2_start>23) hours_lcd_timer2_start=0;
if  (hours_lcd_timer2_start<0) hours_lcd_timer2_start=0;
} // end while increment
} // end first while

EEPROM_Write(0x18,hours_lcd_timer2_start); // save hours 1 timer tp eeprom
EEPROM_Write(0x19,minutes_lcd_timer2_start); // save minutes 1 timer tp eeprom
}
//--------------------------------Set Timer 1 Off ------------------------------
void SetTimerOff_2()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"T2 Off: [2]");
LCD_Clear(2,1,16);
Delay_ms(500);
while (Set==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)   break;     //break out of the while loop
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

if (Increment==1)
{
delay_ms(100);
minutes_lcd_timer2_stop++;
}
if (Decrement==1)
{
delay_ms(100);
minutes_lcd_timer2_stop--;
}

if(minutes_lcd_timer2_stop>59) minutes_lcd_timer2_stop=0;
if (minutes_lcd_timer2_stop<0) minutes_lcd_timer2_stop=0;

} // end while increment or decrement
} // end first while
//*********************************Hours Off************************************
Delay_ms(500); // read button state
while (Set==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)   break;     //break out of the while loop
//-> to make sure that the value will never be changed until the user press increment or decrement
while(Increment== 1 || Decrement==1)
{
ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);

if (Increment==1)
{
delay_ms(100);
hours_lcd_timer2_stop++;
}
if (Decrement==1)
{
delay_ms(100);
hours_lcd_timer2_stop--;
}
if(hours_lcd_timer2_stop>23) hours_lcd_timer2_stop=0;
if (hours_lcd_timer2_stop<0 ) hours_lcd_timer2_stop=0;
} // end while increment or decrement
} // end first while
EEPROM_Write(0x20,hours_lcd_timer2_stop); // save hours off  timer_1 to eeprom
EEPROM_Write(0x21,minutes_lcd_timer2_stop); // save minutes off timer_1 to eeprom
}


//-------------------------------SetDS1307HoursDSProgram------------------------
void SetDS1307Hours_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[H] [7]");
Delay_ms(500);
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
if (Exit==1)   break;     //break out of the while loop
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
if (Increment==1)
{
delay_ms(100);
set_ds1307_hours++;

}
if (Decrement==1)
{
delay_ms(100);
set_ds1307_hours--;
}
if(set_ds1307_hours>23) set_ds1307_hours=0;
if (set_ds1307_hours<0) set_ds1307_hours=0;
} // end while decrement or increment
} // end first while
}
//--------------------------------Set Minutes Ds1307----------------------------
void SetDS1307Minutes_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[M] [8]");
Delay_ms(500);
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
if (Exit==1)   break;     //break out of the while loop
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

if (Increment==1)
{
delay_ms(100);
set_ds1307_minutes++;
}

if (Decrement==1)
{
delay_ms(100);
set_ds1307_minutes--;
}
if(set_ds1307_minutes>59) set_ds1307_minutes=0;
if(set_ds1307_minutes<0) set_ds1307_minutes=0;
} // end while decrement or increment
} // end first while
}
//--------------------------------Set DS1307 Seconds----------------------------
void SetDS1307Seconds_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time:[S] [9]");
Delay_ms(500);
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
if (Exit==1)   break;     //break out of the while loop
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
if (set_ds1307_seconds>59) set_ds1307_seconds=0;
if (set_ds1307_seconds<0) set_ds1307_seconds=0;
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
Delay_ms(500);
LCD_Clear(2,1,16);
//-> note: 0 is enabled and 1 is disabled because loading default value form epprom for the first time will be zero
// and i want the default value to be enabled and 0
if (ByPassState==0) LCD_OUT(2,1,"Enabled "); else LCD_OUT(2,1,"Disabled");
while (Set==1)
{
if (ByPassState==0) LCD_OUT(2,1,"Enabled "); else LCD_OUT(2,1,"Disabled");
if (Exit==1)   break;     //break out of the while loop
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
LCD_OUT(1,1,"Low Battery:[11]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
sprintf(txt,"%4.1f",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
sprintf(txt,"%4.1f",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");


if (Increment==1)
{
Delay_ms(100);
Mini_Battery_Voltage+=0.1;

}
if (Decrement==1)
{
Delay_ms(100);
Mini_Battery_Voltage-=0.1;
}
if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
} //end wile increment and decrement
}// end while set
Delay_ms(100);
StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
LCD_CMD(_LCD_CLEAR);
}
//-----------------------------------Set timer Program 10-----------------------
/*void SetTimer()
{
LCD_OUT(1,1,"Timer State:[12]");
Delay_ms(500);
LCD_Clear(2,1,16);
while (Set==1)
{
LCD_OUT(1,1,"Timer : [10]");
if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled ");}
if (Exit==1)   break;     //break out of the while loop
while(Increment == 1 || Decrement == 1 )
{


if (Timer_Enable==0) {LCD_OUT(2,1,"Disabled");} else {LCD_OUT(2,1,"Enabled ");}
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
}*/
//---------------------StatrtUp Battery Voltage for Loads-----------------------
void SetStartUpLoadsVoltage()
{
LCD_OUT(1,1,"Start Volt Bat");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
sprintf(txt,"%4.1f",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
sprintf(txt,"%4.1f",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,1,txt);
LCD_OUT(2,5,"V");


if (Increment==1)
{
Delay_ms(100);
StartLoadsVoltage+=0.1;

}
if (Decrement==1)
{
Delay_ms(100);
StartLoadsVoltage-=0.1;
}
if (StartLoadsVoltage>65) StartLoadsVoltage=0;
if (StartLoadsVoltage<0) StartLoadsVoltage=0;
} //end wile increment and decrement
}// end while set
Delay_ms(100);
StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
LCD_CMD(_LCD_CLEAR);
}
//----------------------------Program 11 Set High Voltage-----------------------
void SetHighVoltage()
{
LCD_OUT(1,1,"High Volt: [13]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
IntToStr(High_Voltage,txt);
LCD_OUT(2,1,txt);
if (Increment==1)
{
Delay_ms(100);
High_Voltage++;
}
if(Decrement==1)
{
Delay_ms(100);
High_Voltage--;
}
 if(High_Voltage > 255 ) High_Voltage=0;
 if (High_Voltage < 0 ) High_Voltage=0;
} // end while increment or decrement
} // end while set
EEPROM_Write(0x12,High_Voltage);
LCD_CMD(_LCD_CLEAR);
}
//-------------------------------Program 12-------------------------------------
void SetLowVoltage()
{
LCD_OUT(1,1,"Low Volt: [14]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
IntToStr(Low_Voltage,txt);
LCD_OUT(2,1,txt);
if (Increment==1)
{
Delay_ms(100);
Low_Voltage++;
}
if(Decrement==1)
{
Delay_ms(100);
Low_Voltage--;
}
 if(Low_Voltage > 255 ) Low_Voltage=0;
 if (Low_Voltage < 0 ) Low_Voltage=0;
} // end while increment or decrement
} // end while set
LCD_Clear(1,1,16);
EEPROM_Write(0x13,Low_Voltage);
LCD_CMD(_LCD_CLEAR);
}
//----------------------------Voltage Protection Enable-------------------------
/*void EnableVoltageGuard()
{
LCD_OUT(1,1,"Volt Prot: [16]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled "); if(VoltageProtectionEnable==0)  LCD_OUT(2,1,"Disabled");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
if(VoltageProtectionEnable==1) LCD_OUT(2,1,"Enabled "); if(VoltageProtectionEnable==0)  LCD_OUT(2,1,"Disabled");
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
LCD_CMD(_LCD_CLEAR);
} // end function*/
//---------------------------------LOW PV Voltage Program-----------------------
void SetLowPV_Voltage()
{
LCD_OUT(1,1,"Low PV: [14]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
IntToStr(Low_PV_Voltage,txt);
LCD_OUT(2,1,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
IntToStr(Low_PV_Voltage,txt);
LCD_OUT(2,1,txt);
if (Increment==1)
{
Delay_ms(100);
Low_PV_Voltage++;
}
if(Decrement==1)
{
Delay_ms(100);
Low_PV_Voltage--;
}
} // end while increment or decrement
} // end while set
LCD_Clear(1,1,16);
//EEPROM_Write(0x35,Low_PV_Voltage);
StoreBytesIntoEEprom(0x35,(unsigned short *)&Low_PV_Voltage,2);   // save float number to eeprom
LCD_CMD(_LCD_CLEAR);
}

//------------------------------ StartUp Timer----------------------------------
//- > when grid is available and load must turn on they must have time between each
//-> other so solar inverter don't switch off
void Startup_Timers()
{
LCD_OUT(1,1,"Startup Timers Sec");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
ByteToStr(startupTIme_1,txt);
LCD_OUT(2,1,"T1:");
LCD_OUT(2,4,txt);
ByteToStr(startupTIme_2,txt);
LCD_OUT(2,8,"T2:");
LCD_OUT(2,11,txt);
if(Exit==1) break ; // break while loop
while(Increment==1 || Decrement==1)
{
if(Increment==1)
{
Delay_ms(100);
startupTIme_1++;
}
if(Decrement==1)
{
Delay_ms(100);
startupTIme_1--;
}
if(startupTIme_1 > 255 ) startupTIme_1=0;
if (startupTIme_1<0) startupTIme_1=0;
} // end  while increment decrement
} // end while main while set
//**********************************End First While-----------------------------
Delay_ms(1000);
while (Set==1)
{
ByteToStr(startupTIme_1,txt);
LCD_OUT(2,1,"T1:");
LCD_OUT(2,4,txt);
ByteToStr(startupTIme_2,txt);
LCD_OUT(2,8,"T2:");
LCD_OUT(2,11,txt);
if(Exit==1) break ; // break while loop
while(Increment==1 || Decrement==1)
{
if(Increment==1)
{
Delay_ms(100);
startupTIme_2++;
}
if(Decrement==1)
{
Delay_ms(100);
startupTIme_2--;
}
if(startupTIme_2 > 255 ) startupTIme_2=0;
if (startupTIme_2<0) startupTIme_2=0;
} // end while increment and decrement
} // end while set
EEPROM_Write(0x40,startupTIme_1);
EEPROM_Write(0x41,startupTIme_2);

} // end  function
//------------------------------Reset factory Settings--------------------------
/*void RestoreFactorySettings()
{
LCD_OUT(1,1,"Restore Factory");
Delay_ms(500);
LCD_Clear(2,1,16);
 //-> entering first lock loop
while(Set==1)
{
Delay_ms(1000);
if (Set==0)
{
delay_ms(6000);     // if user pressed for 6 seconds then reset factory settings
if (Set==0)
{
LCD_OUT(2,1,"Resetting");

EEPROM_FactorySettings();
break; // break while loop
delay_ms(2000);
}
}
} // end first while
}*/
//----------------------------Screen 1------------------------------------------
void Screen_1()
{
//LCD_Clear(2,1,13);
Read_Time();
Read_Battery();
//Read_PV_Continues();
CalculateAC();
DisplayTimerActivation();
}
//----------------------------ADC Battery Voltage 12v/24v/48v-------------------
void ADCBattery()
{
ADC_Init();
ADC_Init_Advanced(_ADC_EXTERNAL_REF);
ADPS2_Bit=1;
ADPS1_Bit=1;
ADPS0_Bit=0;
}
//--------------------------Read Battery Voltage--------------------------------
void Read_Battery()
{
int i=0,j=0;
float sum=0, average=0;
// save results in array
/*for (i=0; i < 10 ; i++)
{
ADC_Value=ADC_Read(1);
arrayBatt[i]=ADC_value;
Delay_ms(10);
}
// calculate the average
for ( j=0; j<10 ; j++ )
{
sum = sum + arrayBatt[j];
}*/

//average=sum/10.0;
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value *5.0)/1024.0;
/*Vadc=Vin* (4.7K /100K) => Vin=(104.7/4.7k) * VADC*/
//100k*1.01=99K , 4.7K *1.01=4.653
Vin_Battery=((10.5/0.5)*Battery_Voltage); // 0.3 volt error from reading
LCD_OUT(2,1,"V=");
sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
LCD_OUT(2,3,txt);

}
//-> for always keep updating pv voltage in background
void Read_PV_Continues()
{
ADC_Value_PV=ADC_Read(2);
PV_Voltage=(ADC_Value_PV*5.0)/1024.0;
Vin_PV=((255.5)*PV_Voltage); // Vin_PV=pv_voltage *2.2K  /560K +2.2K
Delay_ms(50);
}
//---------------------------------LOW battery Voltage--------------------------
void LowBatteryVoltageAlarm()
{

if (Vin_Battery<Mini_Battery_Voltage+BuzzerVoltage) // to give some time to the handle the situation
{
Buzzer=1;
Delay_ms(500);
Buzzer=0;
Delay_ms(500);
}
}

//------------------------------Low PV voltage Alarm----------------------------
void LowPV_VoltageAlarm()
{
if (Timer_2_isOn ==1 || Timer_isOn==1)     // to make pv alarm actvivated just in timer activation not else because at night there is no pv

{
if (Vin_PV<=Low_PV_Voltage)
{
Buzzer=1;
Delay_ms(500);
Buzzer=0;
Delay_ms(500);
}
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
//LCD_OUT(2,9,"   ");
}
VoltageProtector(v);
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

if ((voltage < Low_Voltage || voltage> High_Voltage )&& AC_Available==0 ) // ac available
{
VoltageProtectorGood=0;
}

if ((voltage>Low_Voltage && voltage < High_Voltage) && AC_Available==0)
{
VoltageProtectorGood=1;
}
}


//------------------------------------------------------------------------------
 void Start_Timer()
 {
 //-> timer with delay of 500msec for screen reading
 /*
  target=(500x10^-3 * 8x10^6)  / 64 ;
 */
 COM1A1_bit=0;    // Normal port operation
 COM1A0_bit=0;   //Normal port operation
 WGM13_bit=0;    //ctc mode
 WGM12_bit=1;   //ctc mode
 WGM11_bit=0;   //ctc mode
 WGM10_bit=0;    //ctc mode
 CS12_bit=1;    //prescalar set to 1024
 CS11_bit=0;
 CS10_bit=1;
 OCR1AH=0x00;  // 7500msc
 OCR1AL=0x00;
 SREG_I_bit=1;
 OCIE1A_bit=1;  // enable compare a match
 }
 //-----------------------------------------------------------------------------
 void Stop_Timer()
 {
 CS12_bit=0;    //prescalar set to 64
 CS11_bit=0;
 CS10_bit=0;
 }
//------------------------------------------------------------------------------
void Timer_Interupt() iv IVT_ADDR_TIMER1_COMPA
{

Old_Reg=SREG;  // save interrupt register state
SREG_I_Bit=0; // disable interrupts
if (SolarOnGridOff==1 && Timer_isOn==1 )                        //when switching relays if there is voltage so relay is stucked and turn on load
{
Relay_L_Solar=1;
}
//Delay_ms(2000); // for not starting all loads in one time
if (SolarOnGridOff==1 && AC_Available==0 )      //for bypass mode                  //when switching relays if there is voltage so relay is stucked and turn on load
{
ReadMinutesMinusOldTimer_1= ReadMinutes() - old_timer_1;
if (ReadMinutesMinusOldTimer_1 <= 0 )     ReadMinutesMinusOldTimer_1 * -1 ;     // because when reading minutes and it was 56 seconds then oldtimer is 56 - 0 ( current reading ) the value will become negative and never update
if( (ReadMinutesMinusOldTimer_1)>=startupTIme_1)        // startup time for laod when grid is available
 {
  old_timer_1=ReadMinutes();
  Relay_L_Solar=1;
 }

}

if(SolarOnGridOff_2==1 && Timer_2_isOn==1)
{
Relay_L_Solar_2=1;
}
//Delay_ms(2000); // for not starting all loads in one time
if(SolarOnGridOff_2==1 && AC_Available==0)      //for bypass mode
{
ReadMinutesMinusOldTimer_2= ReadMinutes() - old_timer_2;
if ( ReadMinutesMinusOldTimer_2 <= 0 )     ReadMinutesMinusOldTimer_2 *-1 ;     // because when reading minutes and it was 56 seconds then oldtimer is 56 - 0 ( current reading ) the value will become negative and never update
 if( (ReadMinutesMinusOldTimer_2)>=startupTIme_2)        // startup time for laod when grid is available
 {
  old_timer_2=ReadMinutes();
  Relay_L_Solar_2=1;
  //Delay_ms(1000);
 }
}
SREG=Old_Reg; // return the state
OCF1A_bit=1;
Stop_Timer();
}
 //-----------------------------------Read Panels Voltage-----------------------
void ReadPV_Voltage()
{

/*ADC_Value_PV=ADC_Read(2);
PV_Voltage=(ADC_Value_PV*5.0)/1024.0;
Vin_PV=((255.5)*PV_Voltage); // Vin_PV=pv_voltage *2.2K  /560K +2.2K*/
LCD_Out(2,1,"PV=");
sprintf(txt,"%4.1f",Vin_PV);     // re format vin_battery to have 2 decimals
LCD_OUT(2,4,txt);
 
 }
 //--------------------Error List-----------------------------------------------
void ErrorList()
 {
if(Vin_Battery<Mini_Battery_Voltage) LCD_OUT(2,15,"1"); else { LCD_OUT(2,15," ");}
if(VoltageProtectorGood==0 && AC_Available==0) LCD_OUT(2,16,"2");  else {LCD_OUT(2,15," ");}
 }
//----------------------------Timer_2-------------------------------------------
//-> THIS TIMER is for updating screen
void Start_Timer_2_B()
{
WGM22_bit=0;
WGM21_bit=0;
WGM20_bit=0;
CS22_bit=1;
CS21_bit=1;
CS20_bit=1;
SREG_I_Bit=1;
OCR2B=0xFF;
OCIE2B_Bit=1;
}
//------------------------------------------------------------------------------
void Stop_Timer_2()
{
CS22_bit=0;
CS21_bit=0;
CS20_bit=0;
}
//------------------------------------------------------------------------------
void Timer_Interrupt_2() iv IVT_ADDR_TIMER2_COMPB
{
Old_Reg=SREG;  // save interrupt register state
SREG_I_Bit=0; // disable interrupts
// update screen for pv
Timer_Counter_2++;
if (Timer_Counter_2==125)              // more than 10 seconds
{
LCD_Clear(2,1,16);
Delay_ms(200);
Timer_Counter_2=0;
}
SREG=Old_Reg; // return the state
OCF2B_Bit=1; // clear
}
//-----------------------------------Timer 3 -----------------------------------
//-> this timer is used for giving some time to pv to turn off the load
void Start_Timer_0_A()
{
WGM00_bit=0;
WGM01_bit=0;
WGM02_bit=0;
CS00_bit=1; // prescalar 1024
CS02_bit=1; //prescalar 1024
SREG_I_Bit=1;
OCR0A=0xFF;
OCIE0A_Bit=1;
}
//------------------------------------------------------------------------------
void Interupt_Timer_0_A_PV_OFFTime() iv IVT_ADDR_TIMER0_COMPA
{
Old_Reg=SREG;  // save interrupt register state
SREG_I_Bit=0; // disable interrupts
Timer_Counter_3++;

//- give some time to battery to turn off loads
if (Timer_Counter_3==500)              // more than 10 seconds
{

if(Vin_Battery<Mini_Battery_Voltage)
{
Delay_ms(500);
Relay_L_Solar=0;
Relay_L_Solar_2=0;
}
Timer_Counter_3=0;
Stop_Timer_0();
}

 // give some time to ac loads when grid is available and grid is low or high to switch off
if (Timer_Counter_3==1000)              // more than 10 seconds
{

if(VoltageProtectorGood==0 && AC_Available==0)
{
Delay_ms(500);
Relay_L_Solar=0;
Relay_L_Solar_2=0;
}
Timer_Counter_3=0;
Stop_Timer_0();
}
SREG=Old_Reg; // return the state
OCF0A_Bit=1; // clear
}
//------------------------------------------------------------------------------
void Stop_Timer_0()
{
CS00_bit=0;
CS01_bit=0;
CS02_bit=0;
}
//------------------------------AsyncTask---------------------------------------
/*void AsyncTask_Screen_2()
{
 if( (ReadMinutes()-old_timer_1)>=10)
 {
  old_timer_1=ReadMinutes();
  LCD_OUT(2,1,"Time 10 S");
  Delay_ms(1000);
 }

 if( (ReadMinutes()-old_timer_2)>=20)
 {
  old_timer_2=ReadMinutes();
  LCD_OUT(2,1,"Time 15 S");
  Delay_ms(1000);
 }
}*/
//---------------------------Load EEPROM Factory Settings-----------------------
void EEPROM_FactorySettings()
{
float tempLowPv=50.0,tempLowBatt=22.0;
//*****************timer 1****************
EEPROM_Write(0x00,10);
EEPROM_Write(0x01,0);
EEPROM_Write(0x03,3);
EEPROM_Write(0x04,0);
//**********************************************
EEPROM_Write(0x06,0); // read bypass system if it is disabled or enabled
EEPROM_Write(0x011,1);     //Timer enable or disable
EEPROM_Write(0x12,245); //  high voltage Grid
EEPROM_Write(0x13,175); // load low voltage
EEPROM_Write(0x15,1);  // voltage protection enable
StoreBytesIntoEEprom(0x30,(unsigned short *)&tempLowBatt,4);   // save float number to eeprom Low Battery Voltage
StoreBytesIntoEEprom(0x35,(unsigned short *)&tempLowPv,2);   // save float number to eeprom Low Pv Voltage
}

//------------------------------------------------------------------------------
void main() {
Config();
ADCBattery(); // adc configuartion for adc
EEPROM_Load(); // load params programs
TWI_Config();
Config_Interrupts();
ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
//Start_Timer_2_B();      //for updating screen and pv
old_timer_1=ReadMinutes();
old_timer_2=ReadMinutes();
while(1)
{
Screen_1();
Check_Timers();
LowBatteryVoltageAlarm();
//LowPV_VoltageAlarm();
ErrorList();
//AsyncTask_Screen_2();
Delay_ms(1000);
} // end while
}   // end main
//--------------------------------TODO List-------------------------------------
/*
1- Design Error List.
2-

*/