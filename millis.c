#include "millis.h"


 
unsigned long g_Millis=0;                //Global var. for counting milliseconds.


void initMillis() {
WGM00_bit=0;
WGM01_bit=1;
WGM02_bit=0;
CS00_bit=0;
CS01_bit=0;
CS02_bit=1;
OCR0A=TIMER_RESOLUTION;
SREG_I_bit=1;
TIMSK0 |= (1<<OCIE0A);
}


unsigned long millis(){
unsigned long m;
char oldSREG = SREG;
SREG_I_Bit=0;   //disable interrupts hile we read timer0_millis or we might get an
m = g_Millis;
m=m/100;   //first it was every 100 000 is 1 second, or 1000 microsecond so i divided it 100 to have milly second
SREG = oldSREG;  //restoring old state so the interrupts will be enabled once again
return m;
}

void interrupt_ISR() iv IVT_ADDR_TIMER0_COMPA
{
unsigned char usFract=0;
g_Millis += MILLIS_INC;
usFract  += MILLIS_INC_FRACT>>3;
if( usFract >= 2000>>3 ){                //2000 / 8 = 250
usFract -= 2000>>3;   // because the error occurs every 2ms and the resoultion of counting in timers is 2ms
g_Millis++;
}
OCF0A_bit=1;    // Clearing Interrupt flag register
}