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
char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char hours_lcd_timer2_start=0,hours_lcd_timer2_stop=0,seconds_lcd_timer2_start=0;
char minutes_lcd_timer2_start=0,minutes_lcd_timer2_stop=0,seconds_lcd_timer2_stop=0;
char Relay_State; // variable for toggling relay
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0,set_ds1307_day=0,set_ds1307_month=0,set_ds1307_year=0;
char ByPassState=0;    //enabled is default 0 is enabled and 1 is disabled
float Battery_Voltage,PV_Voltage,Vin_PV,Vin_PV_Old=0,Vin_PV_Present=0;
char BatteryVoltageSystem=0; // to save the battery voltage system if it is 12v/24v/48v
unsigned int ADC_Value;   // adc value for battery voltage
unsigned int ADC_Value_PV;
float Vin_Battery;      //voltage of battery
float Mini_Battery_Voltage=0,Mini_Battery_Voltage_T2=0;     // for timer 1 and timer 2
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
unsigned int Timer_Counter_2=0, Timer_Counter_3=0,Timer_Counter_4=0;
unsigned int Low_PV_Voltage=50;       // PV panels low voltage
bool Grid_Already_On=false;            // to not enter conditions as the grid is available
unsigned short old_timer_1=0,old_timer_2=0,temp=0;
unsigned int startupTIme_1=0,startupTIme_2=0;  // 25 seconds for load one to start up and 50 seconds for load 2 to startup
char updateScreen=0;
float arrayBatt[21];
float StartLoadsVoltage=0,StartLoadsVoltage_T2=0;
float BuzzerVoltage=0.1; // voltage added to mini voltage to start giving the alarm before loads switches off
unsigned short ReadMinutesMinusOldTimer_1=0;
unsigned short ReadMinutesMinusOldTimer_2=0;
unsigned int Timer_Counter_For_Grid_Turn_Off=0;
char RunTimersNowState=0;
unsigned int SecondsRealTime=0;         // for holding reading seconds in real time for ac grid and startup timers
unsigned int SecondsRealTimePv_ReConnect_T1=0,SecondsRealTimePv_ReConnect_T2=0; // for reactive timers in sequence when timer switch off because off battery and wants to reload
unsigned int realTimeLoop=0;
bool RunWithOutBattery=true;
int const ButtonDelay=200;
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
void SetDS1307_Time();
void SetDS1307Minutes_Program();
void SetDS1307Seconds_Program();
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
void RestoreFactorySettings();
void EEPROM_FactorySettings();
void Start_Timer_2_B();   // timer for updating screen
void Start_Timer_0_A();  // timer for pv voltage to shutdown
void Stop_Timer_0();
void Read_PV_Continues();  // to eep updating pv
void Startup_Timers();
void SetStartUpLoadsVoltage();
void RunTimersNow();
void TurnACLoadsByPassOn();
void RunTimersNowCheck();
void Watch_Dog_Timer_Enable();
void Watch_Dog_Timer_Disable();
void Write_Date(); // to set date of ds1307
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

//-------------------------Write Data-------------------------------------------
void Write_Date(unsigned int day, unsigned int month,unsigned int year)
{
write_Ds1307(0x04,day);          //01-31
Write_Ds1307(0x05,month);       //01-12
Write_Ds1307(0x06,year);       // 00-99
}
//------------------------------------------------------------------------------
void Config()
{
GPIO_Init();
LCD_CMD(_LCD_CLEAR);
LCD_Init();
LCD_CMD(_LCD_CURSOR_OFF);
LCD_OUT(1,1,"Starting ... ");
Delay_ms(2000);
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
//-------------------------------------Interrupts-------------------------------
//-> Config the interrupts on ac_avilable pin for when grid is off cut off the loads
void Config_Interrupts()
{
ISC10_bit=1;   // Config The rising edge of INT0 generates an interrupt request.
ISC11_bit=1;
INT1_bit=1;
SREG_I_bit=1; // enable the global interrupt vector
}


//---------------External Interrupts for INT1 for ac available------------------
void Interrupt_INT1 () iv IVT_ADDR_INT1
{
SREG_I_bit=0;
AcBuzzerActiveTimes=0; // FOR ACTIVING BUZZER ONCE AGAIN
 //-> functions for shutting down loads if there is no timers and grid is off
if(AC_Available==1 && Timer_isOn!=1  )
{
//AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
///old_timer_1=ReadMinutes();  // time must be updated after grid is off
SecondsRealTime=0;
Relay_L_Solar=0;
LCD_Clear(2,7,16); // to clear lcd when grid is not available
}

if (AC_Available==1 && Timer_2_isOn!=1)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
{
//AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
///old_timer_2=ReadMinutes();   // time must be updated after grid is off
SecondsRealTime=0;
Relay_L_Solar_2=0;
LCD_Clear(2,7,16); // to clear lcd when grid is not available
}

INTF1_bit=1;     //clear  flag
SREG_I_bit=1;
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
//**********************************************
//ByPassState=EEPROM_Read(0x06); // read bypass system if it is disabled or enabled
ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
//Timer_Enable=EEPROM_Read(0x011);
Timer_Enable=1;      // delete function to be programmed for rom space
High_Voltage=EEPROM_Read(0x12); // load high voltage
Low_Voltage=EEPROM_Read(0x13); // load low voltage
VoltageProtectionEnable=EEPROM_Read(0x15);
Timer_isOn  =EEPROM_Read(0x49);
Timer_2_isOn =EEPROM_Read(0x50);

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
//-> turn Load On
if (matched_timer_1_start==1)
{
Timer_isOn=1;
EEPROM_write(0x49,1);        //- save it to eeprom if power is cut

//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
{
Relay_L_Solar=1;
}
//-> if run with out battery is selected
if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
{
Relay_L_Solar=1;
}
} // end if ac_available
//-> Turn Load off
//******************************************************************************
if (matched_timer_1_stop==1)
{
Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
EEPROM_write(0x49,0);        //- save it to eeprom if power is cut
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  )
{
//for the turn off there is no need for delay
SecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0; // relay off
//LCD_OUT(1,16," ");
}
if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  )
{
//for the turn off there is no need for delay
SecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0; // relay off
}
}
//}// end if of ac_available
//-------------------------- Timer 1 End----------------------------------------
//------------------------- Timer 2 Start---------------------------------------
if (matched_timer_2_start==1)
{
Timer_2_isOn=1;
EEPROM_write(0x50,1);        //- save it to eeprom if power is cut
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false)
{
Relay_L_Solar_2=1;
//LCD_OUT(1,16,"2");
}

if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true)
{
Relay_L_Solar_2=1;
}

} // end if ac_available


if (matched_timer_2_stop==1)
{
Timer_2_isOn=0;        // to continue the timer after breakout the timer when grid is available
EEPROM_write(0x50,0);        //- save it to eeprom if power is cut
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1 && RunWithOutBattery==false )
{
///SolarOnGridOff_2=0; // to enter once again in the interrupt
//for the turn off there is no need for delay
Relay_L_Solar_2=0; // relay off
SecondsRealTimePv_ReConnect_T2=0;
LCD_OUT(1,16," ");
}

if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true )
{
SecondsRealTimePv_ReConnect_T2=0;
Relay_L_Solar_2=0; // relay off
}

} // end match timer stop

//***************************ByPass System**************************************
// if voltage ac is good and voltage protection is enabled
  // do not enter the bypass if the voltage is not good because it will be already switched to solar
if (AC_Available==0 && ByPassState==0 && VoltageProtectorGood==1 )       //bypass enabled
{
////////////////////////////////////////////////////////////////////////////////
Delay_ms(500);       // for error to get one seconds approxmiallty
SecondsRealTime++;
if (SecondsRealTime==60)
{
LCD_Init();
LCD_CMD(_LCD_CLEAR);
LCD_CMD(_LCD_CURSOR_OFF);
}
if (SecondsRealTime==600)
{
LCD_Init();
LCD_CMD(_LCD_CLEAR);
LCD_CMD(_LCD_CURSOR_OFF);
}

if(SecondsRealTime >= startupTIme_1)
{
//LCD_OUT(2,16,"G");
Relay_L_Solar=1;
//ToggleBuzzer();
}
if(SecondsRealTime >= startupTIme_2)
{
Relay_L_Solar_2=1;
}
//LCD_OUT(2,16,"G");
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
//@Note Moved to interrupts vector int1 for fast shutdown
//-> functions for shutting down loads if there is no timers and grid is off
/*if(AC_Available==1 && Timer_isOn!=1  )
{
AcBuzzerActiveTimes=0; // make buzzer va  riable zero to get activated once again
///old_timer_1=ReadMinutes();  // time must be updated after grid is off
SecondsRealTime=0;
Relay_L_Solar=0;
LCD_OUT(2,16," "); // clear lcd
}

if (AC_Available==1 && Timer_2_isOn!=1)  // it must be   Timer_2_isOn==0    but because of error in loading eeprom value
{
///old_timer_2=ReadMinutes();   // time must be updated after grid is off
SecondsRealTime=0;
Relay_L_Solar_2=0;
LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
}*/
// function just for clearing screen  wehen grid goes off and timers are enabled screen must be cleared
if(AC_Available==1 && Timer_2_isOn == 1 && Timer_isOn == 1)
{
 LCD_CLEAR(2,7,16); // to clear lcd when grid is not available
}



//------------------------Functions for reactiving timers------------------------
/*
 these function is used for reactiving timers when grid available in the same timer is on or off
*/
//-> if the  ac is shutdown and timer is steel in the range of being on  so reactive timer 1
if (AC_Available==1 && Timer_isOn==1 && Vin_Battery > StartLoadsVoltage && RunWithOutBattery==false )
{
SecondsRealTimePv_ReConnect_T1++;
Delay_ms(400);
if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;

}
if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true )
{
SecondsRealTimePv_ReConnect_T1++;
Delay_ms(400);
if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;

}
//-> if the  ac is shutdown and timer is steel in the range of being on  so reactive timer 2
if (AC_Available==1 && Timer_2_isOn==1 && Vin_Battery > StartLoadsVoltage_T2 && RunWithOutBattery==false )     //run with battery
{
SecondsRealTimePv_ReConnect_T2++;
Delay_ms(400);
if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
Relay_L_Solar_2=1;
}

if (AC_Available==1 && Timer_2_isOn==1 &&  RunWithOutBattery==true )            //run without battery
{
SecondsRealTimePv_ReConnect_T2++;
Delay_ms(400);
if (  SecondsRealTimePv_ReConnect_T2 > startupTIme_2)
Relay_L_Solar_2=1;
}

//--Turn Load off when battery Voltage  is Low and AC Not available and Bypass is enabled
if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
{
SecondsRealTimePv_ReConnect_T1=0;
Start_Timer_0_A();         // give some time for battery voltage
}

//--Turn Load off when battery Voltage  is Low and AC Not available and Bypass is enabled
if (Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1 &&  Timer_2_isOn==1 && RunWithOutBattery==false)
{
SecondsRealTimePv_ReConnect_T2=0;
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
AcBuzzerActiveTimes =1 ;
Buzzer=1;
Delay_ms(1000);
Buzzer=0;
Delay_ms(5000);
LCD_Init();
LCD_CMD(_LCD_CLEAR);
LCD_CMD(_LCD_CURSOR_OFF);

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
SetLowBatteryVoltage();// program 5 to set low battery voltage
if (Exit==1)   break;     //break out of the while loop
SetStartUpLoadsVoltage(); // program 15 to enable timer or disable
if (Exit==1)   break;     //break out of the while loop
//SetHighVoltage(); // program 16 to set high voltage
if (Exit==1)   break;     //break out of the while loop
//SetLowVoltage();   // program 17 to set low voltage
if (Exit==1)   break;     //break out of the while loop
SetDS1307_Time();    // program 10
//if (Exit==1)   break;     //break out of the while loop
//SetDS1307Minutes_Program(); // program 11
//if (Exit==1)   break;     //break out of the while loop
//SetDS1307Seconds_Program(); // program 12
//if (Exit==1)   break;
Startup_Timers();
if(Exit==1) break;
//RunTimersNow();   // this is in the case of setting the controller for first time it give option to start timer now
//if(Exit==1) break;
//RestoreFactorySettings();
//if (Exit==1)   break;       //break out of the while loop*/
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
/*ByteToStr(hours_lcd_1,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');*/
ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M");
LCD_Out(2,7,txt);
//break out while loop and interupt
if (Exit==1)
{
LCD_Clear(2,1,16);
break;     //break out of the while loop
}

//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1  )
{
delay_ms(ButtonDelay);
minutes_lcd_1++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
/*ByteToStr(minutes_lcd_1,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);*/
if (Exit==1)
{
LCD_Clear(2,1,16);
break;     //break out of the while loop
}
 //-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
hours_lcd_1++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
/*ByteToStr(hours_lcd_2,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');*/
ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)          
{  
LCD_Clear(2,1,16);
break;     //break out of the while loop
}
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{

if (Increment==1)
{
delay_ms(ButtonDelay);
minutes_lcd_2++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
/*ByteToStr(minutes_lcd_2,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);*/
if (Exit==1)
{
LCD_Clear(2,1,16);
break;     //break out of the while loop
}
//-> to make sure that the value will never be changed until the user press increment or decrement
while(Increment== 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
hours_lcd_2++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
LCD_OUT(1,1,"T2 On: [3]");
Delay_ms(100);
LCD_Clear(2,1,16);
while (Set==1)
{
/*ByteToStr(hours_lcd_timer2_start,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');*/
ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M");
LCD_Out(2,7,txt);
//break out while loop and interupt
if (Exit==1)
{
LCD_Clear(2,1,16);
break;     //break out of the while loop
}

//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1  )
{
delay_ms(ButtonDelay);
minutes_lcd_timer2_start++;
}
if (Decrement==1 )
{
delay_ms(ButtonDelay);
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
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');
/*ByteToStr(minutes_lcd_timer2_start,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);*/
if (Exit==1)
{
break;     //break out of the while loop
}
 //-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
hours_lcd_timer2_start++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
LCD_OUT(1,1,"T2 Off: [4]");
LCD_Clear(2,1,16);
Delay_ms(500);
while (Set==1)
{
/*ByteToStr(hours_lcd_timer2_stop,txt);
LCD_OUT(2,1,"H:");
LCD_Out(2,2,txt);
LCD_Chr_Cp('-');*/
ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
if (Exit==1)   break;     //break out of the while loop
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
minutes_lcd_timer2_stop++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
/*ByteToStr(minutes_lcd_timer2_stop,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);*/
if (Exit==1) 
{
LCD_Clear(2,1,16);
break;     //break out of the while loop
}
//-> to make sure that the value will never be changed until the user press increment or decrement
while(Increment== 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
hours_lcd_timer2_stop++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
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
void SetDS1307_Time()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time[H] [9]");
Delay_ms(500);
set_ds1307_minutes=ReadMinutes();      // to read time now
set_ds1307_hours=ReadHours();          // to read time now
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
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours++;

}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours--;
}
if(set_ds1307_hours>23) set_ds1307_hours=0;
if (set_ds1307_hours<0) set_ds1307_hours=0;
} // end while decrement or increment
} // end first while
//******************************’Minutes Program********************************
Delay_ms(500);
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time[M] [10]");
Delay_ms(500);
while (Set==1)
{
ByteToStr(set_ds1307_minutes,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,7,txt);
LCD_Chr_Cp('-');
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes++;
}

if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes--;
}
if(set_ds1307_minutes>59) set_ds1307_minutes=0;
if(set_ds1307_minutes<0) set_ds1307_minutes=0;
} // end while decrement or increment
} // end first while
//*******************************Seconds****************************************
Delay_ms(500);
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time[S] [11]");
Delay_ms(500);
while (Set==1)
{
ByteToStr(set_ds1307_seconds,txt);
LCD_OUT(2,12,"S:");
LCD_Out(2,13,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds--;
}
if (set_ds1307_seconds>59) set_ds1307_seconds=0;
if (set_ds1307_seconds<0) set_ds1307_seconds=0;
//-> Send Now time to ds1307 to be set
//-> to force user to change the time when the last seconds options is changing it must be saved
Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
} // end while decrement or increment
} // end first while
//---------------------------------Set Date-------------------------------------
Delay_ms(1000);
LCD_Clear(1,1,16);  // clear the lcd first row
LCD_CLear(2,1,16); // clear the lcd two row
LCD_OUT(1,1,"Set Date[D] [12]");
//set_ds1307_day=Read_Day();
Delay_ms(500);
while (Set==1)
{
ByteToStr(set_ds1307_day,txt);
LCD_OUT(2,1,"D:");
LCD_Out(2,3,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_day++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_day--;
}
if (set_ds1307_day>31) set_ds1307_day=0;
if (set_ds1307_day<0) set_ds1307_day=0;
}  // end while increment or decrement
} //  end while set
//********************************Months****************************************
Delay_ms(1000);
LCD_Clear(1,1,16);
//LCD_OUT(1,1,"Set Date[M] [13]");
//set_ds1307_month=Read_Month();
Delay_ms(500);
while (Set==1)
{
ByteToStr(set_ds1307_month,txt);
LCD_OUT(2,6,"M:");
LCD_Out(2,8,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_month++;

}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_month--;
}
if (set_ds1307_month>12) set_ds1307_month=0;
if (set_ds1307_month<0) set_ds1307_month=0;
}  // end while increment or decrement
} //  end while set
//*************************************Years************************************
Delay_ms(1000);
LCD_Clear(1,1,16);
//LCD_OUT(1,1,"Set Date[Y] [14]");
//set_ds1307_year=Read_Year();
Delay_ms(500);
while (Set==1)
{
ByteToStr(set_ds1307_year,txt);
LCD_OUT(2,12,"Y:");
LCD_Out(2,14,txt);
if (Exit==1)   break;     //break out of the while loop
while(Increment==1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_year++;

}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_year--;
}
if (set_ds1307_year>99) set_ds1307_year=0;
if (set_ds1307_year<0) set_ds1307_year=0;
Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
}  // end while increment or decrement
} //  end while set
}  // end setTimeAndData
/*//--------------------------------Set Minutes Ds1307----------------------------
void SetDS1307Minutes_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time[M] [10]");
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
}*/
/*//--------------------------------Set DS1307 Seconds----------------------------
void SetDS1307Seconds_Program()
{
LCD_Clear(1,1,16);
LCD_OUT(1,1,"Set Time[S] [11]");
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
}*/

//----------------------SetLowBatteryVoltage------------------------------------
void SetLowBatteryVoltage()
{
LCD_OUT(1,1,"Low Battery  [5]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
LCD_OUT(2,1,"T1");
sprintf(txt,"%4.1fV",Mini_Battery_Voltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,4,txt);
//LCD_OUT(2,9,"V");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
if (Increment==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage+=0.1;

}
if (Decrement==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage-=0.1;
}
if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
} //end wile increment and decrement
}// end first while set
//------------------------------------------------------------------------------
Delay_ms(1000);
while(Set==1)
{
LCD_OUT(2,1,"T2");
sprintf(txt,"%4.1fV",Mini_Battery_Voltage_T2);     // re format vin_battery to have 2 decimals
LCD_OUT(2,4,txt);
//LCD_OUT(2,9,"V");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
if (Increment==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage_T2+=0.1;

}
if (Decrement==1)
{
Delay_ms(ButtonDelay);
Mini_Battery_Voltage_T2-=0.1;
}
if (Mini_Battery_Voltage_T2>65) Mini_Battery_Voltage_T2=0;
if (Mini_Battery_Voltage_T2<0) Mini_Battery_Voltage_T2=0;
} //end wile increment and decrement
}// end while set
StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);   // save float number to eeprom
LCD_CMD(_LCD_CLEAR);
}
//---------------------StatrtUp Battery Voltage for Loads-----------------------
void SetStartUpLoadsVoltage()
{
LCD_OUT(1,1,"Start Loads V[6]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
LCD_OUT(2,1,"T1");
sprintf(txt,"%4.1fV",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
LCD_OUT(2,4,txt);
//LCD_OUT(2,9,"V");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
if (Increment==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage+=0.1;

}
if (Decrement==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage-=0.1;
}
if (StartLoadsVoltage>65) StartLoadsVoltage=0;
if (StartLoadsVoltage<0) StartLoadsVoltage=0;
} //end wile increment and decrement
}// end first while
//------------------------------------------------------------------------------
Delay_ms(1000);
while(Set==1)
{
LCD_OUT(2,1,"T2");
sprintf(txt,"%4.1fV",StartLoadsVoltage_T2);     // re format vin_battery to have 2 decimals
LCD_OUT(2,4,txt);
//LCD_OUT(2,9,"V");
if (Exit==1)   break;     //break out of the while loop
while (Increment==1 || Decrement==1)
{
//sprintf(txt,"%4.1f",StartLoadsVoltage);     // re format vin_battery to have 2 decimals
//LCD_OUT(2,1,txt);
//LCD_OUT(2,5,"V");
if (Increment==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage_T2+=0.1;

}
if (Decrement==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage_T2-=0.1;
}
if (StartLoadsVoltage_T2>65) StartLoadsVoltage_T2=0;
if (StartLoadsVoltage_T2<0) StartLoadsVoltage_T2=0;
} //end wile increment and decrement
}// end first while
StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);   // save float number to

LCD_CMD(_LCD_CLEAR);
}
//----------------------------Program 11 Set High Voltage-----------------------
void SetHighVoltage()
{
LCD_OUT(1,1,"High AC Volt [7]");
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
Delay_ms(ButtonDelay);
High_Voltage++;
}
if(Decrement==1)
{
Delay_ms(ButtonDelay);
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
LCD_OUT(1,1,"Low AC Volt [8]");
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
Delay_ms(ButtonDelay);
Low_Voltage++;
}
if(Decrement==1)
{
Delay_ms(ButtonDelay);
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
//------------------------------ StartUp Timer----------------------------------
//- > when grid is available and load must turn on they must have time between each
//-> other so solar inverter don't switch off
void Startup_Timers()
{
LCD_OUT(1,1,"Start Loads [15]");
Delay_ms(500);
LCD_Clear(2,1,16);
while(Set==1)
{
IntToStr(startupTIme_1,txt);
LCD_OUT(2,1,"T1");
//LCD_OUT(2,16,"S");
LCD_OUT(2,5,txt);
if(Exit==1) break ; // break while loop
while(Increment==1 || Decrement==1)
{
if(Increment==1)
{
Delay_ms(ButtonDelay);
startupTIme_1++;
}
if(Decrement==1)
{
Delay_ms(ButtonDelay);
startupTIme_1--;
}
if(startupTIme_1 > 600  ) startupTIme_1=0;
if (startupTIme_1<0) startupTIme_1=0;
} // end  while increment decrement
} // end while main while set
//**********************************End First While-----------------------------
Delay_ms(1000);
while (Set==1)
{
IntToStr(startupTIme_2,txt);
LCD_OUT(2,1,"T2");
//LCD_OUT(2,16,"S");
LCD_OUT(2,5,txt);
if(Exit==1) break ; // break while loop
while(Increment==1 || Decrement==1)
{
if(Increment==1)
{
Delay_ms(ButtonDelay);
startupTIme_2++;
}
if(Decrement==1)
{
Delay_ms(ButtonDelay);
startupTIme_2--;
}
if(startupTIme_2 > 600 ) startupTIme_2=0;
if (startupTIme_2<0) startupTIme_2=0;
} // end while increment and decrement
} // end while set
//EEPROM_Write(0x40,startupTIme_1);
StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);   // save float number to eeprom
LCD_CMD(_LCD_CLEAR);
//EEPROM_Write(0x41,startupTIme_2);

} // end  function
//------------------------------Reset factory Settings--------------------------
/*void RestoreFactorySettings()
{
LCD_OUT(1,1,"Restore Factory [14]");
Delay_ms(500);
LCD_Clear(2,1,16);
 //-> entering first lock loop
while(Set==1)
{
if (Exit==1) break;
Delay_ms(1000);
if (Increment==1 && Decrement==1)
{
delay_ms(10000);     // if user pressed for 6 seconds then reset factory settings
if (Increment==1 && Decrement==1)
{
LCD_OUT(2,1,"Resetting");

EEPROM_FactorySettings();
break; // break while loop
delay_ms(2000);
}
}
} // end first while
LCD_Clear(2,1,16);
}*/
//----------------------------Screen 1------------------------------------------
void Screen_1()
{
//LCD_Clear(2,1,13);
//Read_Date();
Read_Time();
Read_Battery();
CalculateAC();
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
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value *5.0)/1024.0;
/*Vadc=Vin* (4.7K /100K) => Vin=(104.7/4.7k) * VADC*/
//100k*1.01=99K , 4.7K *1.01=4.653
Vin_Battery=((10.5/0.5)*Battery_Voltage); // 0.3 volt error from reading
LCD_OUT(2,1,"V=");
sprintf(txt,"%4.1f",Vin_Battery);     // re format vin_battery to have 2 decimals
LCD_OUT(2,3,txt);

}

//---------------------------------LOW battery Voltage--------------------------
void LowBatteryVoltageAlarm()
{
if (Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false) // to give some time to the handle the situation
{
Buzzer=1;
Delay_ms(500);
Buzzer=0;
Delay_ms(500);
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
 //--------------------Error List-----------------------------------------------
void ErrorList()
 {
if(Vin_Battery<Mini_Battery_Voltage && RunWithOutBattery==false)  
{
LCD_OUT(1,16,"1");
} 
else
{
LCD_OUT(1,16," ");
}

if(VoltageProtectorGood==0 && AC_Available==0)  {LCD_OUT(1,16,"2");}  else {LCD_OUT(2,16," ");}

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
void Interupt_Timer_0_A_OFFTime() iv IVT_ADDR_TIMER0_COMPA
{
SREG_I_Bit=0; // disable interrupts
Timer_Counter_3++;                // timer for battery voltage
Timer_Counter_4++;
Timer_Counter_For_Grid_Turn_Off++;

//- give some time to battery to turn off loads
if (Timer_Counter_3==500)              // more than 10 seconds
{

if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
{
SecondsRealTime=0;
Delay_ms(500);
Relay_L_Solar=0;
LCD_CLEAR(2,7,16);
}
Timer_Counter_3=0;
Stop_Timer_0();
}

//- give some time to battery to turn off loads
if (Timer_Counter_4==500)              // more than 10 seconds
{

if(Vin_Battery<Mini_Battery_Voltage_T2 && AC_Available==1)
{
SecondsRealTime=0;
Delay_ms(500);
Relay_L_Solar_2=0;
LCD_CLEAR(2,7,16);
}
Timer_Counter_4=0;
Stop_Timer_0();
}
 // give some time to ac loads when grid is available and grid is low or high to switch off/
//if (Timer_Counter_3==1000)              // more than 10 seconds
//{
if (Timer_Counter_For_Grid_Turn_Off==1000)
{
if(VoltageProtectorGood==0 && AC_Available==0)
{
SecondsRealTime=0;
Relay_L_Solar=0;
Relay_L_Solar_2=0;
LCD_CLEAR(2,7,16);
}
Timer_Counter_For_Grid_Turn_Off=0;
Stop_Timer_0();
}
///SREG=Old_Reg; // return the state
SREG_I_Bit=1;
OCF0A_Bit=1; // clear
}
//------------------------------------------------------------------------------
void Stop_Timer_0()
{
CS00_bit=0;
CS01_bit=0;
CS02_bit=0;
}

//---------------------------Load EEPROM Factory Settings-----------------------
void EEPROM_FactorySettings(char period)
{
if(period==1) // summer  timer
{
Mini_Battery_Voltage=23.0,
StartLoadsVoltage=25.0,
startupTIme_1 =180,
startupTIme_2=240,
Mini_Battery_Voltage_T2=24.0,
StartLoadsVoltage_T2=26.0;
//*****************timer 1****************
EEPROM_Write(0x00,8);  // writing start hours
EEPROM_Write(0x01,0);    // writing  start minutes
EEPROM_Write(0x03,17);    // writing off hours
EEPROM_Write(0x04,0);    // writing off minutes
//****************timer 2********************
EEPROM_Write(0x18,9);  // writing start hours
EEPROM_Write(0x19,0);    // writing  start minutes
EEPROM_Write(0x20,17);    // writing off hours
EEPROM_Write(0x21,0);    // writing off minutes
//**********************************************
StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
}
if (period==0) // winter timer
{
Mini_Battery_Voltage=23.0,
StartLoadsVoltage=25.0,
startupTIme_1 =180,
startupTIme_2=240,
Mini_Battery_Voltage_T2=24.0,
StartLoadsVoltage_T2=26.0;
//*****************timer 1****************
EEPROM_Write(0x00,8);  // writing start hours
EEPROM_Write(0x01,0);    // writing  start minutes
EEPROM_Write(0x03,12);    // writing off hours
EEPROM_Write(0x04,0);    // writing off minutes
//****************timer 2********************
EEPROM_Write(0x18,9);  // writing start hours
EEPROM_Write(0x19,0);    // writing  start minutes
EEPROM_Write(0x20,12);    // writing off hours
EEPROM_Write(0x21,0);    // writing off minutes
//**********************************************
StoreBytesIntoEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
StoreBytesIntoEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);
StoreBytesIntoEEprom(0x45,(unsigned short *)&startupTIme_1,2);
StoreBytesIntoEEprom(0x47,(unsigned short *)&startupTIme_2,2);
StoreBytesIntoEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
StoreBytesIntoEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
}
//global variables
EEPROM_Write(0x12,255); //  high voltage Grid
EEPROM_Write(0x13,170); // load low voltage
EEPROM_Write(0x49,0); //  timer1_ison
EEPROM_Write(0x50,0); // timer2_is on
}
//---------------This function is for making timers run now---------------------
RunTimersNowCheck()
{
if (Increment==1 && Exit==0 )      // first
{
Delay_ms(2000);
if ( Increment==1 && Exit==0 )
{
Delay_ms(2000);
if( Increment==1 && Exit==0 )
{
Timer_isOn=1;
Timer_2_isOn=1;
LCD_OUT(2,1,"L1 L2 Running");
Delay_ms(1000);
LCD_CLEAR(2,1,16);
EEPROM_Write(0x49,1);
EEPROM_Write(0x50,1);
} //
}
}
//---------------------------------Reset to Summer time-------------------------
if (Increment==1 && Exit==1 && Decrement==0)      // first
{
Delay_ms(2000);
if ( Increment==1 && Exit==1 && Decrement==0)
{
Delay_ms(5000);
EEPROM_FactorySettings(1);        // summer time
Delay_ms(100);
EEPROM_Load();    // read the new values from epprom
LCD_OUT(2,1,"Reset Summer    ");
Delay_ms(1000);
LCD_CLEAR(2,1,16);
}
}
if (Increment==0 && Exit==1 && Decrement==1)      // first
{
Delay_ms(2000);
if ( Increment==0 && Exit==1 && Decrement==1)
{
Delay_ms(5000);
EEPROM_FactorySettings(0);        // winter time
Delay_ms(100);
EEPROM_Load();    // read the new values from epprom
LCD_OUT(2,1,"Reset Winter    ");
Delay_ms(1000);
LCD_CLEAR(2,1,16);
}
}///-----------------------------ShutDown Loads-----------------------------------
if (Decrement==1 )      // first
{
Delay_ms(1000);
if ( Decrement==1 )
{
Delay_ms(2000);
if (Decrement==1  )
{
Timer_isOn=0;
Timer_2_isOn=0;
Relay_L_Solar=0;
Relay_L_Solar_2=0;
SecondsRealTimePv_ReConnect_T1=0;  // to make count starts again
SecondsRealTimePv_ReConnect_T2=0; // to make count starts aain
EEPROM_Write(0x49,0);  // save to epprom to shutdown
EEPROM_Write(0x50,0);  // save to epprom to shutdown
}
}
}
}
//-----------------------------------Watch Dog timer----------------------------
void WDT_Enable()
{
//asm cli;
//asm wdr;
SREG_I_bit=0;
MCUSR &= ~(1<<WDRF);
WDTCSR |= (1<<WDCE) | (1<<WDE);     //write a logic one to the Watchdog change enable bit (WDCE) and WDE
WDTCSR |=  (1<<WDE);               //logic one must be written to WDE regardless of the previous value of the WDE bit.
//WDTCSR =  (1 <<WDP0) | (1<<WDE)  ;
SREG_I_bit=1;
}

void WDT_Prescaler_Change()
{
//asm cli;
//asm wdr;
SREG_I_bit=0;
WDTCSR |= (1<<WDCE) | (1<<WDE);
// Set new prescaler(time-out) value = 64K cycles (~0.5 s)
WDTCSR  = (1<<WDE) | (1<<WDP3) | (1<<WDP0);     // very important the equal as in datasheet examples code
//asm sei;
SREG_I_bit=1;
}

void WDT_Disable()
{
//asm cli;
//asm wdr;
SREG_I_bit=0;
MCUSR &= ~(1<<WDRF);
WDTCSR |= (1<<WDCE) | (1<<WDE);
//Turn off WDT
WDTCSR = 0x00;
//asm sei;
SREG_I_bit=1;
}
//------------------------------------------------------------------------------

void CheckForSet()
{

if (Set==0) SetUpProgram();

}
//------------------------Auto program For battery------------------------------
//@this program used for running timers without battery and to be set auto
void AutoRunWithOutBatteryProtection()
{
if (Vin_Battery==0)
{
RunWithOutBattery=true;
}
else
{
RunWithOutBattery=false;
}
}
//-------------------Check for timer activation inside range--------------------
void CheckForTimerActivationInRange()
{

//-a
if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 )
{
Timer_isOn=1;
EEPROM_Write(0x49,1);
}
//-b
if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
{
// study the state
if(ReadMinutes() < minutes_lcd_2)        // starts the load
{
Timer_isOn=1;
EEPROM_Write(0x49,1);
}
}
//******************************************************************************
if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() < hours_lcd_timer2_stop )
{
Timer_2_isOn=1;
EEPROM_Write(0x50,1);
}

if (ReadHours() >= hours_lcd_timer2_start && ReadMinutes() >= minutes_lcd_timer2_start && ReadHours() == hours_lcd_timer2_stop )
{
if(ReadMinutes()<minutes_lcd_timer2_stop)
{
Timer_2_isOn=1;
EEPROM_Write(0x50,1);
}
}
}  // end function
//------------------------------------------------------------------------------
void main() {
//WDT_Disable();  // very important or the mcu will stuck at start
Config();
ADCBattery(); // adc configuartion for adc
EEPROM_Load(); // load params programs
TWI_Config();
Config_Interrupts();
ReadBytesFromEEprom(0x30,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
ReadBytesFromEEprom(0x40,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
ReadBytesFromEEprom(0x45,(unsigned short *)&startupTIme_1,2);
ReadBytesFromEEprom(0x47,(unsigned short *)&startupTIme_2,2);
ReadBytesFromEEprom(0x51,(unsigned short *)&Mini_Battery_Voltage_T2,4);
ReadBytesFromEEprom(0x55,(unsigned short *)&StartLoadsVoltage_T2,4);
//Start_Timer_2_B();      //for updating screen
while(1)
{
CheckForTimerActivationInRange();
AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
CheckForSet();
RunTimersNowCheck();
//WDT_Enable();
//WDT_Prescaler_Change();
Screen_1();
Check_Timers();
//LowBatteryVoltageAlarm();
ErrorList();
Delay_ms(200);
//while(1);   // to make cpu stucks
//WDT_Disable();
} // end while
}   // end main
//-> Eng. Riyad Al-Ali 24-8-2022 V1.0