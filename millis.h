#ifndef millis_h
#define millis_h
//---------------------------------------------------------------------------------------------------------------------------------------
#define F_CPU 8000000
#define clockCyclesPerMicrosecond ( F_CPU / 1000000 )
#define T0_PRESCALE 64
#define TIMER_RESOLUTION    256
#define clockCyclesToMicroseconds  ( (T0_PRESCALE * TIMER_RESOLUTION)/ clockCyclesPerMicrosecond )
#define MICROSECONDS_PER_TIMER0_OVERFLOW ( clockCyclesToMicroseconds )
#define MILLIS_INC       (MICROSECONDS_PER_TIMER0_OVERFLOW / 1000)
#define MILLIS_INC_FRACT (MICROSECONDS_PER_TIMER0_OVERFLOW % 1000)
#include "millis.c"
//---------------------------------------------------------------------------------------------------------------------------------------
void InitMillis();
unsigned long millis();
#endif