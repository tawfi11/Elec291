#include "stm32f05xxx.h"

#define F_CPU 48000000L

void wait_1ms(void)
{
	// For SysTick info check the STM32F0xxx Cortex-M0 programming manual page 85.
	STK_RVR = (F_CPU/1000L) - 1;  // set reload register, counter rolls over from zero, hence -1
	STK_CVR = 0; // load the SysTick counter
	STK_CSR = 0x05; // Bit 0: ENABLE, BIT 1: TICKINT, BIT 2:CLKSOURCE
	while((STK_CSR & BIT16)==0); // Bit 16 is the COUNTFLAG.  True when counter rolls over from zero.
	STK_CSR = 0x00; // Disable Systick counter
}

void delayms(int len)
{
	while(len--) wait_1ms();
}

void main(void)
{
	RCC_AHBENR |= 0x00020000; // peripheral clock enable for port A
	GPIOA_MODER |= 0x00000001; // Make pin PA0 output
	while(1)
	{
		GPIOA_ODR |= 0x00000001; // PA0=1
		delayms(500);
		GPIOA_ODR &= ~(0x00000001); // PA0=0
		delayms(500);
	}
}
