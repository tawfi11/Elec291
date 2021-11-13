#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "stm32f05xxx.h"
#include "adc.h"

void delay(int dly)
{
	while( dly--);
}

void main(void)
{
	float a[2];
	int j[2];
	
	printf("ADC/SERIAL/CLOCK test.\r\n");
	
	initADC();
	
	RCC_AHBENR |= 0x00020000; // peripheral clock enable for port A
	GPIOA_MODER |= 0x00000001; // Make pin PA0 output
	while(1)
	{
		ADC_CHSELR = BIT8;          // Select Channel 8
		j[0]=readADC();
		a[0]=(j[0]*3.3)/0x1000;
		ADC_CHSELR = BIT9;          // Select Channel 9
		j[1]=readADC();
		a[1]=(j[1]*3.3)/0x1000;
		
		printf("ADC[8]=0x%04x V=%fV, ADC[9]=0x%04x V=%fV,\r", j[0], a[0], j[1], a[1]);
		fflush(stdout);
		GPIOA_ODR |= BIT0; // PA0=1
		delay(500000);
		GPIOA_ODR &= ~(BIT0); // PA0=0
		delay(500000);
	}
}
