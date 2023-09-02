#include "ds1307.h"
#include <stdint.h>
/*
Notes: bcd_values is the time entered by user from lcd

*/

unsigned short Data;
unsigned short reg_1,reg_3,reg_4,reg_5,reg_6;
unsigned short reg_2;
unsigned short Full_Minutes,Full_Hours,Full_Seconds;
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

//------------------------------Write DS1307------------------------------------
void write_Ds1307(unsigned short Address, unsigned short w_data)
{

TWI_Start();
TWI_Write(0xD0);
TWI_Write(Address);
TWI_Write(W_data);
TWI_Stop();
}
//------------------------------Read DS1307-------------------------------------
unsigned short Read_DS1307(unsigned short Address)
{
TWI_Start();   //as mentioned in the datasheet we must deal with is as a reciever mode
TWI_Write(0xD0);   //the DS1307 Address
TWI_Write(address);
TWI_Start();
TWI_Write(0xD1);   ///then we send this address for tuning to Read Mode
Data=TWI_Read(0);   // read Data and send not acknownlegment byte for ending the Data   reading
TWI_Stop();      //stop and close connection
return Data;
}
//-------------------------------Read Seconds-----------------------------------
unsigned short ReadSeconds()
{
//-> read seconds as complete variable
Read_DS1307(0x00);
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
Full_Seconds=(reg_2<<4)+reg_1;
Full_Seconds=Bcd2Dec(Full_Seconds);
return Full_Seconds;
}

//-------------------------------Read Minutes-----------------------------------
unsigned short ReadMinutes()
{
//-> read minutes as complete variable
Read_DS1307(0x01);
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
Full_Minutes=(reg_2<<4)+reg_1;
Full_Minutes=Bcd2Dec(Full_Minutes);
return Full_Minutes;
}
//----------------------------Read hours----------------------------------------
unsigned short ReadHours()
{
//-> read hours as complete variable
Read_DS1307(0x02);    //read seconds "0x00" or read minutes "0x01"
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
Full_Hours=(reg_2<<4)+reg_1;
Full_Hours=Bcd2Dec(Full_Hours);
return Full_Hours;
}
//----------------------------Read Date-----------------------------------------
unsigned short ReadDate (unsigned short date_address)
{
Read_DS1307(date_address);    //read seconds "0x00" or read minutes "0x01"
reg_1 = Data & 0x0F;
reg_2 = Data & 0xF0;
reg_2 = reg_2 >> 4;
date=(reg_2<<4)+reg_1;
date=Bcd2Dec(date);
return date;
}


void Read_time()
{
  //LCD_CMD(_LCD_CLEAR);
  
  Read_DS1307(0x02);
  reg_1 = Data & 0x0F;
  reg_2 = Data & 0xF0;
  reg_2 = reg_2 >> 4;
  LCD_OUT(1,1,"Time:");
  Lcd_Chr(1 , 6, reg_2+0x30);
  Lcd_Chr_Cp(reg_1 + 0x30);
  Lcd_Chr_Cp('-');
  delay_ms(10);
  Read_DS1307(0x01);
  reg_1 = Data & 0x0F;
  reg_2 = Data & 0xF0;
  reg_2 = reg_2 >> 4;
  Lcd_Chr_Cp(reg_2 + 0x30);
  Lcd_Chr_Cp(reg_1 + 0x30);
  Lcd_Chr_Cp('-');
  delay_ms(10);
  Read_DS1307(0x00);
  reg_1 = Data&0x0F;
  reg_2 = Data&0xF0;
  reg_2 = reg_2 >> 4;
  Lcd_Chr_cp(reg_2 + 0x30);
  Lcd_Chr_cp(reg_1 + 0x30);
  delay_ms(100);

  }
  //------------------------------TWI Call Back---------------------------------
  // define callback function
void TWI_TimeoutCallback(char errorCode) {

   if (errorCode == _TWI_TIMEOUT_RD ) {
     // do something if timeout is caused during read
     TWI_Close();

   }

   if (errorCode == _TWI_TIMEOUT_WR) {
     // do something if timeout is caused during write
     TWI_Close();

   }

   if (errorCode == _TWI_TIMEOUT_START) {
     // do something if timeout is caused during start
     TWI_Close();

   }
}
  
  //----------------------------------------TWI Config--------------------------
  void TWI_Config()
  {
   TWI_Init(100000);
   TWI_SetTimeoutCallback(1000, TWI_TimeoutCallback);
  }
  //-----------------------------------Check Time-------------------------------
  char CheckTimeOccuredOn(char seconds_required, char minutes_required,char hours_required)
  {

  //------------------------------Seconds---------------------------------------
  Read_DS1307(0x00);         //Read seconds
  seconds_reg_1_On = Data & 0x0F;
  seconds_reg_2_On = Data & 0xF0;
  seconds_reg_2_On = seconds_reg_2_On >> 4;

  //-----------------------------Minutes----------------------------------------
  Read_DS1307(0x01);
  minutes_reg_1_On = Data & 0x0F;
  minutes_reg_2_On = Data & 0xF0;
  minutes_reg_2_On = minutes_reg_2_On >> 4;
  //------------------------------Hours-----------------------------------------
  Read_Ds1307(0x02);
  hours_reg_1_On = Data & 0x0F;     // least important
  hours_reg_2_On = Data & 0xF0;     //most importanat
  hours_reg_2_On = hours_reg_2_On >> 4;
  //----------------------------------------------------------------------------
  //-converting time required to match to bcd bcd format
  //bcd_value_seconds_L=Dec2Bcd(seconds_required)& 0x0F;       //least important
  //bcd_value_seconds_H=(Dec2Bcd(seconds_required)&0xF0)>> 4; // getting most important
  bcd_value_minutes_L_On=Dec2Bcd(minutes_required)& 0x0F;       //least important
  bcd_value_minutes_H_On=(Dec2Bcd(minutes_required)&0xF0)>> 4; // getting most important
  bcd_value_hours_L_On=Dec2Bcd(hours_required)& 0x0F;       //least important
  bcd_value_hours_H_On=(Dec2Bcd(hours_required)&0xF0)>> 4; // getting most important

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
  //----------------------------------------------------------------------------
   char CheckTimeOccuredOff(char seconds_required, char minutes_required,char hours_required)
  {

  //char txt[10];
  //------------------------------Seconds---------------------------------------
  Read_DS1307(0x00);         //Read seconds
  seconds_reg_1_Off = Data & 0x0F;
  seconds_reg_2_Off = Data & 0xF0;
  seconds_reg_2_Off = seconds_reg_2_Off >> 4;

  //-----------------------------Minutes----------------------------------------
  Read_DS1307(0x01);
  minutes_reg_1_Off = Data & 0x0F;
  minutes_reg_2_Off = Data & 0xF0;
  minutes_reg_2_Off = minutes_reg_2_Off >> 4;
  //------------------------------Hours-----------------------------------------
  Read_Ds1307(0x02);
  hours_reg_1_Off = Data & 0x0F;     // least important
  hours_reg_2_Off = Data & 0xF0;     //most importanat
  hours_reg_2_Off = hours_reg_2_Off >> 4;
  //----------------------------------------------------------------------------
  //-converting time required to match to bcd bcd format
  //bcd_value_seconds_L=Dec2Bcd(seconds_required)& 0x0F;       //least important
  //bcd_value_seconds_H=(Dec2Bcd(seconds_required)&0xF0)>> 4; // getting most important
  bcd_value_minutes_L_Off=Dec2Bcd(minutes_required)& 0x0F;       //least important
  bcd_value_minutes_H_Off=(Dec2Bcd(minutes_required)&0xF0)>> 4; // getting most important
  bcd_value_hours_L_Off=Dec2Bcd(hours_required)& 0x0F;       //least important
  bcd_value_hours_H_Off=(Dec2Bcd(hours_required)&0xF0)>> 4; // getting most important

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
/*//-----------------------------------Correction Time--------------------------
  //-> this function is to correct the switching time of the load if battery was low
  char CorrectionLoad()
  {

//-> if battery was not in good state then the timer start will pass and load at the specific time will not start
//-> so i made a correction load time to select the timer range to be on
  if (bcd_value_hours_L_On<=hours_reg_1_On && bcd_value_hours_H_On <= hours_reg_2_On
  && bcd_value_hours_L_Off>=hours_reg_1_Off && bcd_value_hours_H_Off >= hours_reg_2_Off)
  {
   return 1;
  }
  else
  {
  return 0;
  }


  }*/