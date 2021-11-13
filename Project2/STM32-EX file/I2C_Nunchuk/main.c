#include <stdio.h>
#include "stm32f05xxx.h"
#include "stm32f05xxx_i2c.h"

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

void delayms(int len)
{
	while(len--) wait_1ms();
}

int I2C_byte_write(unsigned char saddr, unsigned char maddr, unsigned char data)
{
	I2C1_CR1 = I2C_CR1_PE;
	I2C1_CR2 = I2C_CR2_AUTOEND | (2 << 16) | (saddr << 1);
	I2C1_CR2 |= I2C_CR2_START;
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Wait for address to go

	I2C1_TXDR = maddr; // send data
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Check Tx empty
	
	I2C1_TXDR = data; // send data
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Check Tx empty

	return 0;
}

int I2C_burst_write(unsigned char saddr, unsigned char maddr, int byteCount, unsigned char* data)
{
	I2C1_CR1 = I2C_CR1_PE;
	I2C1_CR2 = I2C_CR2_AUTOEND | ((byteCount+1) << 16) | (saddr << 1);
	I2C1_CR2 |= I2C_CR2_START;
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Wait for address to go

	I2C1_TXDR = maddr; // send data
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Check Tx empty

    for (; byteCount > 0; byteCount--)
    {
		I2C1_TXDR = *data++; // send data
		while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Check Tx empty
	}

	return 0;
}

int I2C_burstRead(unsigned char saddr, char maddr, int byteCount, unsigned char* data)
{
	// First we send the address we want to read from:
	I2C1_CR1 = I2C_CR1_PE;
	I2C1_CR2 = I2C_CR2_AUTOEND | (1 << 16) | (saddr << 1);
	I2C1_CR2 |= I2C_CR2_START; // Go
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Wait for address to go

	I2C1_TXDR = maddr; // send data
	while ((I2C1_ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {} // Check Tx empty
	
	// Second: we gatter the data sent by the slave device
	I2C1_CR1 = I2C_CR1_PE | I2C_CR1_RXIE;
	I2C1_CR2 = I2C_CR2_AUTOEND | (byteCount<<16) | I2C_CR2_RD_WRN | (NUNCHUK_ADDRESS << 1);
	I2C1_CR2 |= I2C_CR2_START; // Go
    
    for (; byteCount > 0; byteCount--)
    {
		while ((I2C1_ISR & I2C_ISR_RXNE) != I2C_ISR_RXNE) {} // Wait for data to arrive
		*data++=I2C1_RXDR; // Reading 'receive' register clears RXNE flag
	}

	return 0;
}

void nunchuck_init(int print_extension_type)
{
	unsigned char buf[6];
	
	I2C_byte_write(0x52, 0xF0, 0x55);
	I2C_byte_write(0x52, 0xFB, 0x00);
		 
	// Read the extension type from the register block.
	// For the original Nunchuk it should be: 00 00 a4 20 00 00.
	I2C_burstRead(0x52, 0xFA, 6, buf);
	if(print_extension_type)
	{
		printf("Extension type: %02x  %02x  %02x  %02x  %02x  %02x\r\n", 
			buf[0],  buf[1], buf[2], buf[3], buf[4], buf[5]);
	}

	// Send the crypto key (zeros), in 3 blocks of 6, 6 & 4.
	buf[0]=0; buf[1]=0; buf[2]=0; buf[3]=0; buf[4]=0; buf[5]=0;
	
	I2C_byte_write(0x52, 0xF0, 0xAA);
	I2C_burst_write(0x52, 0x40, 6, buf);
	I2C_burst_write(0x52, 0x40, 6, buf);
	I2C_burst_write(0x52, 0x40, 4, buf);
}

void nunchuck_getdata(unsigned char * s)
{
	unsigned char i;

	// Start measurement
	I2C_burstRead(0x52, 0x00, 6, s);

	// Decrypt received data
	for(i=0; i<6; i++)
	{
		s[i]=(s[i]^0x17)+0x17;
	}
}

void I2C_init (void)
{
	RCC_AHBENR |= BIT18; // peripheral clock enable for port B (I2C pins are in port B)
	RCC_APB1ENR  |= BIT21; // peripheral clock enable for I2C1 (page 123 of RM0091 Reference manual)
	
	//Configure PB6 for I2C1_SCL, pin 29 in LQFP32 package (page 36 of Datasheet)
	GPIOB_MODER    |= BIT13; // AF-Mode (page 157 of RM0091 Reference manual)
	GPIOB_AFRL     |= BIT24; // AF1 selected (page 161 of RM0091 Reference manual)
	
	//Configure PB7 for I2C1_SDA, pin 30 in LQFP32 package
	GPIOB_MODER    |= BIT15; // AF-Mode (page 157 of RM0091 Reference manual)
	GPIOB_AFRL     |= BIT28; // AF1 selected (page 161 of RM0091 Reference manual)
	
	// This, somehow configures the I2C clock
	I2C1_TIMINGR = (uint32_t)0x00B01A4B;
}

void main(void)
{
	unsigned char rbuf[6];
 	int joy_x, joy_y, off_x, off_y, acc_x, acc_y, acc_z;
 	char but1, but2;

	printf("\x1b[2J\x1b[1;1H"); // Clear screen using ANSI escape sequence.
	printf ("STM32F051 I2C WII Nunchuck test program\r\n"
	        "File: %s\r\n"
	        "Compiled: %s, %s\r\n\r\n",
	        __FILE__, __DATE__, __TIME__);
	
	I2C_init();

	nunchuck_init(1);
	delayms(100);

	nunchuck_getdata(rbuf);

	off_x=(int)rbuf[0]-128;
	off_y=(int)rbuf[1]-128;
	printf("Offset_X:%4d Offset_Y:%4d\r\n", off_x, off_y);

	while(1)
	{
		nunchuck_getdata(rbuf);

		joy_x=(int)rbuf[0]-128-off_x;
		joy_y=(int)rbuf[1]-128-off_y;
		acc_x=rbuf[2]*4; 
		acc_y=rbuf[3]*4;
		acc_z=rbuf[4]*4;

		but1=(rbuf[5] & 0x01)?1:0;
		but2=(rbuf[5] & 0x02)?1:0;
		if (rbuf[5] & 0x04) acc_x+=2;
		if (rbuf[5] & 0x08) acc_x+=1;
		if (rbuf[5] & 0x10) acc_y+=2;
		if (rbuf[5] & 0x20) acc_y+=1;
		if (rbuf[5] & 0x40) acc_z+=2;
		if (rbuf[5] & 0x80) acc_z+=1;
		
		printf("Buttons(Z:%c, C:%c) Joystick(%4d, %4d) Accelerometer(%3d, %3d, %3d)\x1b[0J\r",
			   but1?'1':'0', but2?'1':'0', joy_x, joy_y, acc_x, acc_y, acc_z);
		fflush(stdout);
		delayms(100);
	}
	
}
