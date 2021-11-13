#include <stdio.h>
#include "stm32f05xxx.h"

void main(void)
{
	int current, previous;
	RCC_AHBENR |= 0x00020000; // peripheral clock enable for port A
	
	// Information here: http://hertaville.com/stm32f0-gpio-tutorial-part-1.html
	GPIOA_MODER &= ~(BIT16 | BIT17); // Make pin PA8 input
	// Activate pull up for pin PA8:
	GPIOA_PUPDR |= BIT16; 
	GPIOA_PUPDR &= ~(BIT17); 
	
	printf("Push button test for STM32F051.  Connect pushbutton between PA8 (pin 18) and ground.\r\n");
	previous=(GPIOA_IDR&BIT8)?0:1;
	while (1)
	{
		current=(GPIOA_IDR&BIT8)?1:0;
		if(current!=previous)
		{
			previous=current;
			printf("PA8=%d\r", current);
			fflush(stdout);
		}
	}
}
