#include "stm32f05xxx.h"
#include <stdio.h>
#include <stdlib.h>

#define SYSCLK 48000000L
#define DEF_F 100000L // To achieve a tick of 10 us

volatile int ISR_pw=100, ISR_cnt=0, ISR_frc;

int egets(char *s, int Max);

// The following ISR happens at a rate of 100kHz.  It is used
// to generate the standard hobby servo 50Hz signal with a pulse
// width of 0.6ms to 2.4ms.
void Timer1ISR(void) 
{
	TIM1_SR &= ~BIT0; // clear update interrupt flag
	ISR_cnt++;
	if(ISR_cnt<ISR_pw)
	{
		GPIOA_ODR |= BIT0; // PA0=1
	}
	else
	{
		GPIOA_ODR &= ~BIT0; // PA0=0
	}
	if(ISR_cnt>=2000)
	{
		ISR_cnt=0; // 2000 * 10us=20ms
		ISR_frc++;
	}
}

void SysInit(void)
{
	// Set up output port bit for blinking LED
	RCC_AHBENR |= 0x00020000;  // peripheral clock enable for port A
	GPIOA_MODER |= 0x00000001; // Make pin PA0 output
	
	// Set up timer
	RCC_APB2ENR |= BIT11; // turn on clock for timer1
	TIM1_ARR = SYSCLK/DEF_F;
	ISER |= BIT13;        // enable timer interrupts in the NVIC
	TIM1_CR1 |= BIT4;     // Downcounting    
	TIM1_CR1 |= BIT0;     // enable counting    
	TIM1_DIER |= BIT0;    // enable update event (reload event) interrupt  
	enable_interrupts();
}

void delay_ms (int msecs)
{	
	int ticks;
	ISR_frc=0;
	ticks=msecs/20;
	while(ISR_frc<ticks);
}

int main(void)
{
    char buf[32];
    int pw;

	SysInit();
	
	// Give putty a chance to start
	delay_ms(500); // wait 500 ms
	
	printf("\x1b[2J\x1b[1;1H"); // Clear screen using ANSI escape sequence.
    printf("Servo signal generator for the STM32F051.\r\n");
    printf("By Jesus Calvino-Fraga (c) 2018.\r\n");
    printf("Pulse width between 60 (for 0.6ms) and 240 (for 2.4ms)\r\n");
	
	while (1)
	{
    	printf("New pulse width: ");
    	fflush(stdout);
    	egets(buf, sizeof(buf)-1); // wait here until data is received
 
    	printf("\n");
    	fflush(stdout);
	    pw=atoi(buf);
	    if( (pw>=60) && (pw<=240) )
	    {
	    	ISR_pw=pw;
        }
        else
        {
        	printf("%d is out of the valid range\r\n", pw);
        }
	}
}
