#include "stm32f05xxx.h"
#include <stdio.h>
#include <stdlib.h>

#define SYSCLK 48000000L
#define DEF_F 15000L

int egets(char *s, int Max);

void TogglePin(void) 
{    
	GPIOA_ODR ^= BIT0; // Toggle PA0
}


// Interrupt service routines are the same as normal
// subroutines (or C funtions) in Cortex-M microcontrollers.
// The following should happen at a rate of 1kHz.
// The following function is associated with the TIM1 interrupt 
// via the interrupt vector table defined in startup.s
void Timer1ISR(void) 
{
	TIM1_SR &= ~BIT0; // clear update interrupt flag
	TogglePin(); // toggle the state of the LED every second
}

void SysInit(void)
{
	// Set up output port bit for blinking LED
	RCC_AHBENR |= 0x00020000;  // peripheral clock enable for port A
	GPIOA_MODER |= 0x00000001; // Make pin PA0 output
	
	// Set up timer
	RCC_APB2ENR |= BIT11; // turn on clock for timer1
	TIM1_ARR = SYSCLK/(DEF_F*2L);
	ISER |= BIT13;        // enable timer interrupts in the NVIC
	TIM1_CR1 |= BIT4;     // Downcounting    
	TIM1_CR1 |= BIT0;     // enable counting    
	TIM1_DIER |= BIT0;    // enable update event (reload event) interrupt  
	enable_interrupts();
}

int main(void)
{
    char buf[32];
    int newF, reload;

	SysInit();
	
    printf("Frequency generator for the STM32F051.\r\n");
    printf("By Jesus Calvino-Fraga (c) 2018.\r\n\r\n");
	
	while (1)
	{
    	printf("Frequency: ");
    	fflush(stdout);
    	egets(buf, 31); // wait here until data is received
 
	    newF=atoi(buf);
	    if(newF>200000L)
	    {
	       printf("\r\nWarning: High frequencies will cause the interrupt service routine for\r\n"
	             "the timer to take all available processor time.  Capping to 200000Hz.\r\n");
	       newF=200000L;
	    }
	    if(newF>0)
	    {
		    reload=(SYSCLK/(newF*2L));
		    printf("\r\nFrequency set to: %d\r\n", SYSCLK/(reload*2L));
			TIM1_CR1 &= ~BIT0;     // disable counting    
			TIM1_ARR = reload;	        
			TIM1_CR1 |= BIT0;     // enable counting    
        }
	}
}
