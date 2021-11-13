#include <stdio.h>
#include "stm32f05xxx.h"

#define F_CPU 48000000L
#define NUNCHUK_ADDRESS 0x52

void wait_1ms(void)
{
	// For SysTick info check the STM32F0xxx Cortex-M0 programming manual page 85.
	STK_RVR = (F_CPU/1000L) - 1;  // set reload register, counter rolls over from zero, hence -1
	STK_CVR = 0; // load the SysTick counter
	STK_CSR = 0x05; // Bit 0: ENABLE, BIT 1: TICKINT, BIT 2:CLKSOURCE
	while((STK_CSR & BIT16)==0); // Bit 16 is the COUNTFLAG.  True when counter rolls over from zero.
	STK_CSR = 0x00; // Disable Systick counter
}

void delayMs(int len)
{
	while(len--) wait_1ms();
}

// https://community.st.com/s/question/0D50X00009XkXwy/stm32f0-spi-read-and-write
static void config_SPI(void)
{
	RCC_AHBENR |= BIT17;  // Enable GPIOA clock
	RCC_APB2ENR |= BIT12; // peripheral clock enable for SPI1 (page 122 of RM0091 Reference manual)
	
	// Configure PA4 for CSn, pin 10 in LQFP32 package
	GPIOA_MODER |= BIT8; // Make pin PA4 output
	GPIOA_ODR |= BIT4; // CSn=1
	
	//Configure PA5 for SPI1_SCK, pin 11 in LQFP32 package
	GPIOA_MODER |= BIT11; // AF-Mode (page 157 of RM0091 Reference manual)
	GPIOA_AFRL  |= 0; // AF0 selected (page 161 of RM0091 Reference manual)
	
	//Configure PA6 for SPI1_MISO, pin 12 in LQFP32 package
	GPIOA_MODER |= BIT13; // AF-Mode (page 157 of RM0091 Reference manual)
	GPIOA_AFRL  |= 0; // AF0 selected (page 161 of RM0091 Reference manual)
	
	//Configure PA7 for SPI1_MOSI, pin 13 in LQFP32 package
	GPIOA_MODER |= BIT15; // AF-Mode (page 157 of RM0091 Reference manual)
	GPIOA_AFRL  |= 0; // AF0 selected (page 161 of RM0091 Reference manual)
	
	SPI1_CR1 = 0x00000000; // Reset SPI1 CR1 Registry.  Page 801 of RM0091 Reference manual
	SPI1_CR1 = (( 0ul << 0) | // CPHA=0
				( 0ul << 1) | // CPOL=0
				( 1ul << 2) | // MSTR=1
				( 7ul << 3) | // BR (fPCLK/256) ~= 187 kbit/sec ]
				( 0ul << 7) | // MSBFIRST
				( 1ul << 8) | // SSI must be 1 when SSM=1 or a frame error occurs
				( 1ul << 9)); // SSM
	SPI1_CR2 = ( BIT10 | BIT9 | BIT8 ); // page 803 of RM0091 Reference manual
	SPI1_CR1 |= BIT6; // Enable SPI1
}

uint8_t SPI_Write (uint8_t wr)
{
	uint8_t data=0;
	
	while ((SPI1_SR & BIT1) == 0); // SPI status register (SPIx_SR) is in page 806
	*((uint8_t *)&SPI1_DR) = wr; // "SPI1_DR = wr;" send 16 bits instead of 8!
	while (SPI1_SR & BIT7); // Check Busy flag (Page 806)
	//while ((SPI1_SR & BIT0) == 0); // 0: Rx buffer empty (hangs here)
	data = *((uint8_t *)&SPI1_DR); // "data = SPI1_DR;" waits for 16-bits
	
	return data;
}

// Read 10 bits from the MCP3008 ADC converter using the recommended
// format in the datasheet.
unsigned int volatile GetADC(char channel)
{
	unsigned char val;
	unsigned int adc;
	int j;
	
	GPIOA_ODR &= ~BIT4; // CSn=0 Select/enable ADC.
	for(j=0; j<20; j++); // A bit of delay...
	
	val=SPI_Write(0x01);

	val=SPI_Write((channel*0x10)|0x80); // Send single/diff* bit, D2, D1, and D0 bits.
	adc=((val & 0x03)*0x100); // val contains the high part of the result.
	
	val=SPI_Write(0x55); // Dummy transmission to get low part of result.
	adc+=val; // val contains the low part of the result.

	for(j=0; j<30; j++); // A bit of delay...
	GPIOA_ODR |= BIT4; // CSn=1 Deselect ADC.
	
	return adc;
}

// The Voltage reference input to the MCP3008.  For best results, measure it and put here.
#define VREF 3.3

void main(void)
{
	delayMs(500); // Give PuTTY a chance to start before sending text
	
	printf("\x1b[2J\x1b[1;1H"); // Clear screen using ANSI escape sequence.
	printf ("MCP3008 SPI test program\r\n"
	        "File: %s\r\n"
	        "Compiled: %s, %s\r\n\r\n",
	        __FILE__, __DATE__, __TIME__);
    
	config_SPI();
    
    while(1)
	{
		printf("V0=%5.3f, V1=%5.3f\r", (GetADC(0)*VREF)/1023.0, (GetADC(1)*VREF)/1023.0);
		fflush(stdout);
		delayMs(500);
	}
}
