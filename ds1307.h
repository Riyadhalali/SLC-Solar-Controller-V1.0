#ifndef DS1307_h
#define DS1307_h
//------------------------------------Variables---------------------------------

#include "ds1307.h"
//-----------------------------Functions----------------------------------------
void write_Ds1307(unsigned short Address, unsigned short w_data);
unsigned short Read_DS1307(unsigned short Address);
void Read_time();
void TWI_Config();
char CheckTimeOccuredOn(char seconds_required, char minutes_required, char hours_required);
char CheckTimeOccuredOff(char seconds_required, char minutes_required, char hours_required);
char CorrectionLoad();
unsigned short ReadMinutes();
unsigned short ReadHours();
unsigned short ReadSeconds();
//void Read_Date();
//unsigned short Read_Day();
//unsigned short Read_Month();
//unsigned short Read_Year();
unsigned short ReadDate(unsigned short date_address);

#endif