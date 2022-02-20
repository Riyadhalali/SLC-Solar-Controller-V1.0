/***********************************************************
Mills Libary based on Timer 2 for ATmega8
Prescalr : 64 
CPU Frequency : 8 MHZ
Created by: Eng. Riyad Al-Ali 
Date : 16/4/2020
************************************************************/

#include "millis.h"



 
unsigned long g_Millis=0;                //Global var. for counting milliseconds.

/*
I Used timer 2 instead of timer 0 because there  is no compare match in timer 0
*/

void initMillis() {
WGM20_bit=0;
WGM21_bit=1;                             //Clear TImer on Compar Match Mode (2), no pin output
CS20_bit=0;
CS21_bit=0;
CS22_bit=1;
OCR2= TIMER_RESOLUTION;
SREG_I_Bit=1 ; // enable interrupts                               //256: Overflow every 15.68 ms
OCIE2_Bit=1;  // Compare Match interrupts enable
}
//------------------------------------------------------------------------------

unsigned long millis(){
unsigned long m;
char oldSREG = SREG;
SREG_I_Bit=0;   //disable interrupts hile we read timer0_millis or we might get an
m = g_Millis;
m=m/100;   //first it was every 100 000 is 1 second, or 1000 microsecond so i divided it 100 to have milly second
SREG = oldSREG;  //restoring old state so the interrupts will be enabled once again
return m;
}
//------------------------------------------------------------------------------
void interrupt_ISR() iv IVT_ADDR_TIMER2_COMP
{
unsigned char usFract=0;
g_Millis += MILLIS_INC;
usFract  += MILLIS_INC_FRACT>>3;
if( usFract >= 2000>>3 ){                //2000 / 8 = 250
usFract -= 2000>>3;   // because the error occurs every 2ms and the resoultion of counting in timers is 2ms
g_Millis++;
}
OCF2_bit=1;    // Clearing Interrupt flag register
}